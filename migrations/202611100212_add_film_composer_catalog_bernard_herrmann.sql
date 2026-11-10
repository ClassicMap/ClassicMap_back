-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 3/9).
-- 작품 44개(새 21개), seed 315개 중 잇기 265·숨김 50·그대로 0.
--
-- 영화·TV·게임·애니 작곡가는 4차 규칙 위에 음반 묶음을 얹었다(사람·에이전트 판단 없음).
-- 규칙은 seed_pipeline/curation/catalog-wave6-2026-11-10/tools/film_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave6-2026-11-10/<작곡가>/(catalog.json·seed_map.json·groups.json).
--   연주회용 작품(MB 갈래 교향곡·협주곡·오페라·칸타타 등, 우리말로 옮길 수 있는 갈래 제목,
--     갈래 없는 다악장·묶음)과 영화 단위 MB 작품(갈래 Soundtrack 이면서 part 가 있는 seed)은
--     4차 규칙 그대로 둔다.
--   큐·노래 seed 는 녹음이 실린 MusicBrainz 음반(release group) 하나에 묶는다. 음반이
--     한 줄 묶음 작품(type album, manual)이 되고 seed 는 그 안 곡(piece_parts.linked_piece_id)이
--     되며 제목은 「<묶음> 중 "<곡>"」으로 바뀐다. 곡 순서는 대표 판의 트랙 순서이고,
--     seed 가 없는 곡은 이름만 넣는다. seed 가 하나만 이어지는 음반은 묶지 않고 낱곡으로 둔다.
--   묶음 제목: 위키데이터에서 이 작곡가가 음악을 맡은 영화이면 「영화 <원제> 사운드트랙」,
--     그 영화의 한국어 위키백과 문서가 있으면 문서 제목을 한국 개봉 제목으로 쓴다.
--     모음집·TV·게임·애니·일반 음반은 음반 원제 그대로. 운영 작품 제목과 겹치면 「(음반)」.
--   어느 음반에도 없는 큐는 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     노래는 음반에 없어도 보이게 둔다. 비교 구간이 있거나 part 가 가리키는 작품은
--     숨기지 않는다. 두 번 돌려도 같다.

-- ===== 버나드 허먼 (composer_id 112) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 44개 중 음반 묶음 16개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 28개,
-- 새 작품 21개, part 725개, 그 아래 0개.
-- seed 315개 중 243개를 음반 묶음 안 곡으로 잇고, 22개는 낱개 작품으로 두고, 50개를 숨긴다.

-- 숨길 seed 가 쥔 카탈로그 제목을 비운다
UPDATE pieces piece
SET piece.title = 'On a Note of Triumph (Part 2) (중복 7941)'
WHERE piece.id = 7941 AND piece.composer_id = 112 AND piece.title = 'On a Note of Triumph (Part 2)'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 5 Fingers

UPDATE pieces piece
SET piece.title = '5 Fingers', piece.title_en = '5 Fingers',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9410 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Old Street', part.name_en = 'The Old Street',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:13aa9a83-02a9-4151-8940-b60210ed13f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13aa9a83-02a9-4151-8940-b60210ed13f7', 1, NULL, 'The Old Street', 'The Old Street', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13aa9a83-02a9-4151-8940-b60210ed13f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Alone', part.name_en = 'Alone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3603ece7-200b-4d78-8e8a-25d4c529b7b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3603ece7-200b-4d78-8e8a-25d4c529b7b3', 2, NULL, 'Alone', 'Alone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3603ece7-200b-4d78-8e8a-25d4c529b7b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Escape', part.name_en = 'Escape',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3c9b446a-0826-455f-bc08-9b1f94bd37a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c9b446a-0826-455f-bc08-9b1f94bd37a8', 3, NULL, 'Escape', 'Escape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c9b446a-0826-455f-bc08-9b1f94bd37a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4d84354f-5696-490a-abe7-3544ba12b76d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d84354f-5696-490a-abe7-3544ba12b76d', 4, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d84354f-5696-490a-abe7-3544ba12b76d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dreams', part.name_en = 'Dreams',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:75bee383-0aba-4e5f-8ad8-8beca91a66fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75bee383-0aba-4e5f-8ad8-8beca91a66fd', 5, NULL, 'Dreams', 'Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75bee383-0aba-4e5f-8ad8-8beca91a66fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Embassy', part.name_en = 'The Embassy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:87e42302-870a-4449-9671-f477d8b0d9ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87e42302-870a-4449-9671-f477d8b0d9ed', 6, NULL, 'The Embassy', 'The Embassy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87e42302-870a-4449-9671-f477d8b0d9ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Charwoman', part.name_en = 'The Charwoman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:94ec99d9-7bad-49ba-821b-e503c0dc21ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94ec99d9-7bad-49ba-821b-e503c0dc21ce', 7, NULL, 'The Charwoman', 'The Charwoman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94ec99d9-7bad-49ba-821b-e503c0dc21ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Romance', part.name_en = 'Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:953a860e-c2c3-454f-85ea-90632652f5f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:953a860e-c2c3-454f-85ea-90632652f5f8', 8, NULL, 'Romance', 'Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:953a860e-c2c3-454f-85ea-90632652f5f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Boat', part.name_en = 'The Boat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:960c584d-2d2f-40b5-9dd6-12bfbbe3c480' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:960c584d-2d2f-40b5-9dd6-12bfbbe3c480', 9, NULL, 'The Boat', 'The Boat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:960c584d-2d2f-40b5-9dd6-12bfbbe3c480'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Rio', part.name_en = 'Rio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a5486850-0b11-47bb-a0e4-a97e20020fd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5486850-0b11-47bb-a0e4-a97e20020fd6', 10, NULL, 'Rio', 'Rio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5486850-0b11-47bb-a0e4-a97e20020fd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Pursuit', part.name_en = 'The Pursuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c0cfd7ef-ac15-4798-8e5e-a8888d8f54b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0cfd7ef-ac15-4798-8e5e-a8888d8f54b4', 11, NULL, 'The Pursuit', 'The Pursuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0cfd7ef-ac15-4798-8e5e-a8888d8f54b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c6fa5f67-b5de-4987-9956-82a1aba010f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6fa5f67-b5de-4987-9956-82a1aba010f3', 12, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6fa5f67-b5de-4987-9956-82a1aba010f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Departure', part.name_en = 'Departure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:cb503ada-7d77-470d-a48f-e9974e7461a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb503ada-7d77-470d-a48f-e9974e7461a2', 13, NULL, 'Departure', 'Departure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb503ada-7d77-470d-a48f-e9974e7461a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Cicero', part.name_en = 'Cicero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e576b953-1f2d-4d60-b75d-e3cd06b7be20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e576b953-1f2d-4d60-b75d-e3cd06b7be20', 14, NULL, 'Cicero', 'Cicero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e576b953-1f2d-4d60-b75d-e3cd06b7be20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The Safe', part.name_en = 'The Safe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e8ed3b0b-4fd8-429c-8693-897f3f82fd78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8ed3b0b-4fd8-429c-8693-897f3f82fd78', 15, NULL, 'The Safe', 'The Safe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8ed3b0b-4fd8-429c-8693-897f3f82fd78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Film', part.name_en = 'The Film',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f2fe1156-2a9e-4d6d-9d4f-db39500d472d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2fe1156-2a9e-4d6d-9d4f-db39500d472d', 16, NULL, 'The Film', 'The Film', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2fe1156-2a9e-4d6d-9d4f-db39500d472d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Five Weeks', part.name_en = 'Five Weeks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9410 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f5b7f423-ba6a-465d-beca-8132f12bafba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5b7f423-ba6a-465d-beca-8132f12bafba', 17, NULL, 'Five Weeks', 'Five Weeks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9410 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5b7f423-ba6a-465d-beca-8132f12bafba'
);


-- None 칸타타 <A Child Is Born>

UPDATE pieces piece
SET piece.title = '칸타타 <A Child Is Born>', piece.title_en = 'A Child Is Born',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11114 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Cape Fear>

UPDATE pieces piece
SET piece.title = '영화음악 <Cape Fear>', piece.title_en = 'Cape Fear',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10314 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Dog Is Poisoned', part.name_en = 'The Dog Is Poisoned',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:07c05ab5-43cd-461e-b795-5bd6989137fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07c05ab5-43cd-461e-b795-5bd6989137fb', 1, NULL, 'The Dog Is Poisoned', 'The Dog Is Poisoned', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07c05ab5-43cd-461e-b795-5bd6989137fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Girl Is Found', part.name_en = 'The Girl Is Found',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:0c03a7f3-b5fc-413a-9785-1ceaa1a72afb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c03a7f3-b5fc-413a-9785-1ceaa1a72afb', 2, NULL, 'The Girl Is Found', 'The Girl Is Found', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c03a7f3-b5fc-413a-9785-1ceaa1a72afb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sam Talks to the Police', part.name_en = 'Sam Talks to the Police',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:143a614c-409c-4ba5-a39b-db258a60bf2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:143a614c-409c-4ba5-a39b-db258a60bf2f', 3, NULL, 'Sam Talks to the Police', 'Sam Talks to the Police', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:143a614c-409c-4ba5-a39b-db258a60bf2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Cape Fear!!!', part.name_en = 'Cape Fear!!!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1a009b90-372c-45f2-9cff-505e4295ed04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a009b90-372c-45f2-9cff-505e4295ed04', 4, NULL, 'Cape Fear!!!', 'Cape Fear!!!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a009b90-372c-45f2-9cff-505e4295ed04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'At the School', part.name_en = 'At the School',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:22507362-73c3-4bc2-8a18-121b5b324a6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22507362-73c3-4bc2-8a18-121b5b324a6a', 5, NULL, 'At the School', 'At the School', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22507362-73c3-4bc2-8a18-121b5b324a6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'An Evening With Max Cady', part.name_en = 'An Evening With Max Cady',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:27a9d32e-552f-4fb2-b0e1-ab9a3f9b31bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27a9d32e-552f-4fb2-b0e1-ab9a3f9b31bb', 6, NULL, 'An Evening With Max Cady', 'An Evening With Max Cady', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27a9d32e-552f-4fb2-b0e1-ab9a3f9b31bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Courtroom', part.name_en = 'The Courtroom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:304fe43b-24b3-48d4-b574-232aa3295a18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:304fe43b-24b3-48d4-b574-232aa3295a18', 7, NULL, 'The Courtroom', 'The Courtroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304fe43b-24b3-48d4-b574-232aa3295a18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Main Title', part.name_en = 'Main Title',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3bd24ea7-7cb0-4456-a992-77e8832ad3f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bd24ea7-7cb0-4456-a992-77e8832ad3f6', 8, NULL, 'Main Title', 'Main Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bd24ea7-7cb0-4456-a992-77e8832ad3f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Farewell Sounds of a Boat at Night', part.name_en = 'Farewell Sounds of a Boat at Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3e19fc56-4746-4dea-b002-60ee2bc343fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e19fc56-4746-4dea-b002-60ee2bc343fb', 9, NULL, 'Farewell Sounds of a Boat at Night', 'Farewell Sounds of a Boat at Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e19fc56-4746-4dea-b002-60ee2bc343fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Dream', part.name_en = 'The Dream',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:41a2887a-e1a3-4cf1-bc41-39dd904f6b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41a2887a-e1a3-4cf1-bc41-39dd904f6b21', 10, NULL, 'The Dream', 'The Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41a2887a-e1a3-4cf1-bc41-39dd904f6b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4a459680-fca8-4963-985e-c9e13af6c1ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a459680-fca8-4963-985e-c9e13af6c1ef', 11, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a459680-fca8-4963-985e-c9e13af6c1ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Cady Is Attacked', part.name_en = 'Cady Is Attacked',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:56c68565-dc97-41b8-ac35-664c396b91f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56c68565-dc97-41b8-ac35-664c396b91f3', 12, NULL, 'Cady Is Attacked', 'Cady Is Attacked', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56c68565-dc97-41b8-ac35-664c396b91f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Sam Gets a Gun', part.name_en = 'Sam Gets a Gun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:65e0f662-899d-41c8-8f3e-1c6779cf69ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e0f662-899d-41c8-8f3e-1c6779cf69ea', 13, NULL, 'Sam Gets a Gun', 'Sam Gets a Gun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e0f662-899d-41c8-8f3e-1c6779cf69ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Cady at the Boat Dock', part.name_en = 'Cady at the Boat Dock',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:6dd7e13b-f37c-44e4-ae9d-7a6889530822' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dd7e13b-f37c-44e4-ae9d-7a6889530822', 14, NULL, 'Cady at the Boat Dock', 'Cady at the Boat Dock', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dd7e13b-f37c-44e4-ae9d-7a6889530822'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Sam Leaves the Case to the Judge', part.name_en = 'Sam Leaves the Case to the Judge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:7c1fb702-a936-46c7-86e5-846215fc936f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c1fb702-a936-46c7-86e5-846215fc936f', 15, NULL, 'Sam Leaves the Case to the Judge', 'Sam Leaves the Case to the Judge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c1fb702-a936-46c7-86e5-846215fc936f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Final Confrontation', part.name_en = 'Final Confrontation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:becd43a2-042d-492c-bd6b-836b56f9016e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:becd43a2-042d-492c-bd6b-836b56f9016e', 16, NULL, 'Final Confrontation', 'Final Confrontation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:becd43a2-042d-492c-bd6b-836b56f9016e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Sam Arrives', part.name_en = 'Sam Arrives',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c3e0a3f2-ed0f-4b5e-a7bf-1af29e35799f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3e0a3f2-ed0f-4b5e-a7bf-1af29e35799f', 17, NULL, 'Sam Arrives', 'Sam Arrives', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3e0a3f2-ed0f-4b5e-a7bf-1af29e35799f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'The House Bowling Alley', part.name_en = 'The House Bowling Alley',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ca794856-a044-40e3-aad2-5c8745adb311' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca794856-a044-40e3-aad2-5c8745adb311', 18, NULL, 'The House Bowling Alley', 'The House Bowling Alley', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca794856-a044-40e3-aad2-5c8745adb311'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Cady Stalks the Daughter', part.name_en = 'Cady Stalks the Daughter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:cebd1f14-051a-4e44-83da-644db502418f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cebd1f14-051a-4e44-83da-644db502418f', 19, NULL, 'Cady Stalks the Daughter', 'Cady Stalks the Daughter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cebd1f14-051a-4e44-83da-644db502418f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Pick-Up', part.name_en = 'The Pick-Up',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d6131abd-3483-40b7-8afb-d6d2481e446e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6131abd-3483-40b7-8afb-d6d2481e446e', 20, NULL, 'The Pick-Up', 'The Pick-Up', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6131abd-3483-40b7-8afb-d6d2481e446e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'The Barking Dog', part.name_en = 'The Barking Dog',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d9207f33-2d8e-4ae4-9a43-144b3bf7c66d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9207f33-2d8e-4ae4-9a43-144b3bf7c66d', 21, NULL, 'The Barking Dog', 'The Barking Dog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9207f33-2d8e-4ae4-9a43-144b3bf7c66d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'The Car Keys', part.name_en = 'The Car Keys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:dae3ee11-c6cd-4611-be21-d582b41ac75c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dae3ee11-c6cd-4611-be21-d582b41ac75c', 22, NULL, 'The Car Keys', 'The Car Keys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dae3ee11-c6cd-4611-be21-d582b41ac75c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Cady Calls Sam', part.name_en = 'Cady Calls Sam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ebfbf11c-6485-46da-b0da-03b7825e09d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebfbf11c-6485-46da-b0da-03b7825e09d5', 23, NULL, 'Cady Calls Sam', 'Cady Calls Sam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebfbf11c-6485-46da-b0da-03b7825e09d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Sam Returns Home', part.name_en = 'Sam Returns Home',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ec112e86-5f2a-4c3e-acc9-61c9281b1b42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec112e86-5f2a-4c3e-acc9-61c9281b1b42', 24, NULL, 'Sam Returns Home', 'Sam Returns Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec112e86-5f2a-4c3e-acc9-61c9281b1b42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'After the Dream', part.name_en = 'After the Dream',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10314 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f599cf43-e093-4233-9607-1483fa98f05e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f599cf43-e093-4233-9607-1483fa98f05e', 25, NULL, 'After the Dream', 'After the Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10314 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f599cf43-e093-4233-9607-1483fa98f05e'
);


-- None 영화음악 <Citizen Kane>

UPDATE pieces piece
SET piece.title = '영화음악 <Citizen Kane>', piece.title_en = 'Citizen Kane',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7910 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hornpipe Polka', part.name_en = 'Hornpipe Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:02a19974-1c87-3d95-a10c-04f0408ee6ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02a19974-1c87-3d95-a10c-04f0408ee6ab', 1, NULL, 'Hornpipe Polka', 'Hornpipe Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02a19974-1c87-3d95-a10c-04f0408ee6ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Second Xanadu', part.name_en = 'Second Xanadu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:036bd6b9-5172-3517-b791-88855652e815' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:036bd6b9-5172-3517-b791-88855652e815', 2, NULL, 'Second Xanadu', 'Second Xanadu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:036bd6b9-5172-3517-b791-88855652e815'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Litany', part.name_en = 'Litany',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:0ad3dbbf-3ad3-3ef1-bcda-e8bbbcc9a805' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad3dbbf-3ad3-3ef1-bcda-e8bbbcc9a805', 3, NULL, 'Litany', 'Litany', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad3dbbf-3ad3-3ef1-bcda-e8bbbcc9a805'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Leland''s Dismissal', part.name_en = 'Leland''s Dismissal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1055147d-064e-363f-a1a9-0e88cd7ca2cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1055147d-064e-363f-a1a9-0e88cd7ca2cf', 4, NULL, 'Leland''s Dismissal', 'Leland''s Dismissal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1055147d-064e-363f-a1a9-0e88cd7ca2cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dissolve', part.name_en = 'Dissolve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:152bee34-4a49-3217-b5e9-fa913c4036d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:152bee34-4a49-3217-b5e9-fa913c4036d0', 5, NULL, 'Dissolve', 'Dissolve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:152bee34-4a49-3217-b5e9-fa913c4036d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Valse Presentation', part.name_en = 'Valse Presentation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:18fc3790-74c8-3abf-bea7-5e1e02173303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18fc3790-74c8-3abf-bea7-5e1e02173303', 6, NULL, 'Valse Presentation', 'Valse Presentation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18fc3790-74c8-3abf-bea7-5e1e02173303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Sunset Narration', part.name_en = 'Sunset Narration',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1cfa060f-bff4-3a46-8433-f83ec53c1bae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cfa060f-bff4-3a46-8433-f83ec53c1bae', 7, NULL, 'Sunset Narration', 'Sunset Narration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cfa060f-bff4-3a46-8433-f83ec53c1bae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Second Manuscript', part.name_en = 'Second Manuscript',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:20365930-aee6-34f5-b388-82240cc995f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20365930-aee6-34f5-b388-82240cc995f2', 8, NULL, 'Second Manuscript', 'Second Manuscript', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20365930-aee6-34f5-b388-82240cc995f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Bernstein''s Presto', part.name_en = 'Bernstein''s Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2280c85f-c068-3f2b-8d8d-0c87f5568f33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2280c85f-c068-3f2b-8d8d-0c87f5568f33', 9, NULL, 'Bernstein''s Presto', 'Bernstein''s Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2280c85f-c068-3f2b-8d8d-0c87f5568f33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Xanadu Music', part.name_en = 'Xanadu Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:35fdb453-6f65-390c-86f7-7b892188d8c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35fdb453-6f65-390c-86f7-7b892188d8c6', 10, NULL, 'Xanadu Music', 'Xanadu Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35fdb453-6f65-390c-86f7-7b892188d8c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Mother Memory', part.name_en = 'Mother Memory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:412f0ac7-4a2e-3d1a-8f9a-596334c8b461' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:412f0ac7-4a2e-3d1a-8f9a-596334c8b461', 11, NULL, 'Mother Memory', 'Mother Memory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:412f0ac7-4a2e-3d1a-8f9a-596334c8b461'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4376832b-0d65-387e-9190-d5edf5419aed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4376832b-0d65-387e-9190-d5edf5419aed', 12, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4376832b-0d65-387e-9190-d5edf5419aed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41', 13, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Dawn', part.name_en = 'Dawn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:58033690-5061-31df-8f40-f150130db2fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58033690-5061-31df-8f40-f150130db2fe', 14, NULL, 'Dawn', 'Dawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58033690-5061-31df-8f40-f150130db2fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Bernstein''s Narration', part.name_en = 'Bernstein''s Narration',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:5bc7a988-d296-3e96-bafe-7836742e411d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bc7a988-d296-3e96-bafe-7836742e411d', 15, NULL, 'Bernstein''s Narration', 'Bernstein''s Narration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bc7a988-d296-3e96-bafe-7836742e411d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Kane and Susan', part.name_en = 'Kane and Susan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:6cf3b624-28a7-3e07-aa8c-246e717b128a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cf3b624-28a7-3e07-aa8c-246e717b128a', 16, NULL, 'Kane and Susan', 'Kane and Susan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cf3b624-28a7-3e07-aa8c-246e717b128a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:6f6d9351-921a-402a-8513-cabca17f8f6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f6d9351-921a-402a-8513-cabca17f8f6a', 17, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f6d9351-921a-402a-8513-cabca17f8f6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Susan Leaves', part.name_en = 'Susan Leaves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:704014ad-01c2-32e4-9920-80c6a07edbb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:704014ad-01c2-32e4-9920-80c6a07edbb1', 18, NULL, 'Susan Leaves', 'Susan Leaves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:704014ad-01c2-32e4-9920-80c6a07edbb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Kane Marries', part.name_en = 'Kane Marries',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:73ad505a-7522-3be9-be6d-153dcd216dce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73ad505a-7522-3be9-be6d-153dcd216dce', 19, NULL, 'Kane Marries', 'Kane Marries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73ad505a-7522-3be9-be6d-153dcd216dce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Carter''s Exit', part.name_en = 'Carter''s Exit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:78695660-cd79-396e-9a83-f4ed6aaffe79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78695660-cd79-396e-9a83-f4ed6aaffe79', 20, NULL, 'Carter''s Exit', 'Carter''s Exit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78695660-cd79-396e-9a83-f4ed6aaffe79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Charles Meets Thatcher', part.name_en = 'Charles Meets Thatcher',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8266af90-445e-39b9-9d50-615e1d0c3074' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8266af90-445e-39b9-9d50-615e1d0c3074', 21, NULL, 'Charles Meets Thatcher', 'Charles Meets Thatcher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8266af90-445e-39b9-9d50-615e1d0c3074'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'The Night', part.name_en = 'The Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:82f40cb1-1ad1-3e2b-90b7-d0273e363862' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82f40cb1-1ad1-3e2b-90b7-d0273e363862', 22, NULL, 'The Night', 'The Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82f40cb1-1ad1-3e2b-90b7-d0273e363862'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Chronicle Scherzo', part.name_en = 'Chronicle Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:879446cb-fb03-32f4-9952-143fdaa920ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:879446cb-fb03-32f4-9952-143fdaa920ed', 23, NULL, 'Chronicle Scherzo', 'Chronicle Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:879446cb-fb03-32f4-9952-143fdaa920ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Kane''s New Office', part.name_en = 'Kane''s New Office',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:9ae9e375-d849-3173-a613-980b823fbdc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ae9e375-d849-3173-a613-980b823fbdc2', 24, NULL, 'Kane''s New Office', 'Kane''s New Office', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ae9e375-d849-3173-a613-980b823fbdc2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Getty''s Departure', part.name_en = 'Getty''s Departure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a49e1880-a0c2-398e-bbed-e9704b60d3d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a49e1880-a0c2-398e-bbed-e9704b60d3d9', 25, NULL, 'Getty''s Departure', 'Getty''s Departure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a49e1880-a0c2-398e-bbed-e9704b60d3d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Jigsaws', part.name_en = 'Jigsaws',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b51532c9-a417-393c-bdf7-e4afd7a0693a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b51532c9-a417-393c-bdf7-e4afd7a0693a', 26, NULL, 'Jigsaws', 'Jigsaws', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b51532c9-a417-393c-bdf7-e4afd7a0693a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Manuscript Reading and Snow Picture', part.name_en = 'Manuscript Reading and Snow Picture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c0540fbc-372b-3d45-b331-b8f48a245402' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0540fbc-372b-3d45-b331-b8f48a245402', 27, NULL, 'Manuscript Reading and Snow Picture', 'Manuscript Reading and Snow Picture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0540fbc-372b-3d45-b331-b8f48a245402'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Mother''s Sacrifice', part.name_en = 'Mother''s Sacrifice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c5e92f04-f1a1-3b3f-b115-74f92b398325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5e92f04-f1a1-3b3f-b115-74f92b398325', 28, NULL, 'Mother''s Sacrifice', 'Mother''s Sacrifice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e92f04-f1a1-3b3f-b115-74f92b398325'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'The Glass Ball', part.name_en = 'The Glass Ball',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c6aa0eeb-e1ee-34fa-b6a7-8e583519c45d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6aa0eeb-e1ee-34fa-b6a7-8e583519c45d', 29, NULL, 'The Glass Ball', 'The Glass Ball', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6aa0eeb-e1ee-34fa-b6a7-8e583519c45d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'New Dawn Music', part.name_en = 'New Dawn Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ca1f85e9-8e97-381d-a9ba-937aa8aedf8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca1f85e9-8e97-381d-a9ba-937aa8aedf8b', 30, NULL, 'New Dawn Music', 'New Dawn Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca1f85e9-8e97-381d-a9ba-937aa8aedf8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Kane''s Return', part.name_en = 'Kane''s Return',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:cb2e67b6-9e9e-3d20-a3ad-bdb30632bf92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb2e67b6-9e9e-3d20-a3ad-bdb30632bf92', 31, NULL, 'Kane''s Return', 'Kane''s Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb2e67b6-9e9e-3d20-a3ad-bdb30632bf92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Xanadu', part.name_en = 'Xanadu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d6384693-a829-3e8d-a5ec-de96ba5ea90e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6384693-a829-3e8d-a5ec-de96ba5ea90e', 32, NULL, 'Xanadu', 'Xanadu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6384693-a829-3e8d-a5ec-de96ba5ea90e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Thanks', part.name_en = 'Thanks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:deb803f8-ec5c-3c1d-b07d-963145f9c111' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deb803f8-ec5c-3c1d-b07d-963145f9c111', 33, NULL, 'Thanks', 'Thanks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deb803f8-ec5c-3c1d-b07d-963145f9c111'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Theme and Variations', part.name_en = 'Theme and Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:df11dc02-d7a0-3bf8-bd4e-523cb8a16309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df11dc02-d7a0-3bf8-bd4e-523cb8a16309', 34, NULL, 'Theme and Variations', 'Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df11dc02-d7a0-3bf8-bd4e-523cb8a16309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Susan''s Room', part.name_en = 'Susan''s Room',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e28876ae-feac-321c-93c5-a86692fcef0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e28876ae-feac-321c-93c5-a86692fcef0d', 35, NULL, 'Susan''s Room', 'Susan''s Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e28876ae-feac-321c-93c5-a86692fcef0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Salaambo''s Aria', part.name_en = 'Salaambo''s Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e2f80f82-71a1-369c-8b0a-e67c983c4bf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2f80f82-71a1-369c-8b0a-e67c983c4bf2', 36, NULL, 'Salaambo''s Aria', 'Salaambo''s Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2f80f82-71a1-369c-8b0a-e67c983c4bf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Rain', part.name_en = 'Rain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e336b06f-9b6a-3f3e-977a-d575853b5fb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e336b06f-9b6a-3f3e-977a-d575853b5fb9', 37, NULL, 'Rain', 'Rain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e336b06f-9b6a-3f3e-977a-d575853b5fb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'The Trip', part.name_en = 'The Trip',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e77b0b00-b24b-379b-abd8-0831271e7560' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e77b0b00-b24b-379b-abd8-0831271e7560', 38, NULL, 'The Trip', 'The Trip', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e77b0b00-b24b-379b-abd8-0831271e7560'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Kane''s Picnic', part.name_en = 'Kane''s Picnic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:edf98acb-1054-36c1-9a1d-0afd9081d9bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edf98acb-1054-36c1-9a1d-0afd9081d9bb', 39, NULL, 'Kane''s Picnic', 'Kane''s Picnic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf98acb-1054-36c1-9a1d-0afd9081d9bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Galop', part.name_en = 'Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f3af0a80-d213-39cc-b4d7-87769ea22fb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3af0a80-d213-39cc-b4d7-87769ea22fb6', 40, NULL, 'Galop', 'Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3af0a80-d213-39cc-b4d7-87769ea22fb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'El Rancho', part.name_en = 'El Rancho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7910 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fdf4c92f-d592-3421-80ff-894b7edcf082' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdf4c92f-d592-3421-80ff-894b7edcf082', 41, NULL, 'El Rancho', 'El Rancho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7910 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdf4c92f-d592-3421-80ff-894b7edcf082'
);


-- None For the Fallen

UPDATE pieces piece
SET piece.title = 'For the Fallen', piece.title_en = 'For the Fallen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8358 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Get Outta My Heart>

UPDATE pieces piece
SET piece.title = '가곡 <Get Outta My Heart>', piece.title_en = 'Get Outta My Heart',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9449 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Hangover Square>

UPDATE pieces piece
SET piece.title = '영화음악 <Hangover Square>', piece.title_en = 'Hangover Square',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8647 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Concerto Macabre', part.name_en = 'Concerto Macabre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8647 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:db02b85a-e948-4c02-b030-4a2f36a3be25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db02b85a-e948-4c02-b030-4a2f36a3be25', 1, NULL, 'Concerto Macabre', 'Concerto Macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8647 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db02b85a-e948-4c02-b030-4a2f36a3be25'
);


-- None 영화음악 <Jason and the Argonauts>

UPDATE pieces piece
SET piece.title = '영화음악 <Jason and the Argonauts>', piece.title_en = 'Jason and the Argonauts',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8008 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Jason and the Argonauts: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d02df9de-5577-4367-874b-024e9ec07cdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d02df9de-5577-4367-874b-024e9ec07cdd', 1, NULL, 'Prelude', 'Jason and the Argonauts: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d02df9de-5577-4367-874b-024e9ec07cdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Prophesy', part.name_en = 'Jason and the Argonauts: The Prophesy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:6552eafa-2c18-492a-8f2c-1e10de5e7e41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6552eafa-2c18-492a-8f2c-1e10de5e7e41', 2, NULL, 'The Prophesy', 'Jason and the Argonauts: The Prophesy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6552eafa-2c18-492a-8f2c-1e10de5e7e41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Battle', part.name_en = 'Jason and the Argonauts: The Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e8699b6c-2352-4941-a814-08a9ea5591c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8699b6c-2352-4941-a814-08a9ea5591c9', 3, NULL, 'The Battle', 'Jason and the Argonauts: The Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8699b6c-2352-4941-a814-08a9ea5591c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'River Bank', part.name_en = 'Jason and the Argonauts: River Bank',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:525baa24-ee70-4a16-8fed-59aadb9e44b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:525baa24-ee70-4a16-8fed-59aadb9e44b0', 4, NULL, 'River Bank', 'Jason and the Argonauts: River Bank', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:525baa24-ee70-4a16-8fed-59aadb9e44b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Feast', part.name_en = 'Jason and the Argonauts: The Feast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:93c10c75-978a-4583-ba24-58b1ee4337a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93c10c75-978a-4583-ba24-58b1ee4337a7', 5, NULL, 'The Feast', 'Jason and the Argonauts: The Feast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93c10c75-978a-4583-ba24-58b1ee4337a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Oak Grove', part.name_en = 'Jason and the Argonauts: The Oak Grove',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:9417c357-4f08-442e-8e4d-50da79b5f994' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9417c357-4f08-442e-8e4d-50da79b5f994', 6, NULL, 'The Oak Grove', 'Jason and the Argonauts: The Oak Grove', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9417c357-4f08-442e-8e4d-50da79b5f994'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Ascension', part.name_en = 'Jason and the Argonauts: The Ascension',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2e8020ac-e4f1-4b3b-93eb-394c98aa947c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e8020ac-e4f1-4b3b-93eb-394c98aa947c', 7, NULL, 'The Ascension', 'Jason and the Argonauts: The Ascension', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e8020ac-e4f1-4b3b-93eb-394c98aa947c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Mount Olympus', part.name_en = 'Jason and the Argonauts: Mount Olympus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:81ff4d84-0ce4-4229-a507-b78b0284c77f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81ff4d84-0ce4-4229-a507-b78b0284c77f', 8, NULL, 'Mount Olympus', 'Jason and the Argonauts: Mount Olympus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ff4d84-0ce4-4229-a507-b78b0284c77f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Olympic Games', part.name_en = 'Jason and the Argonauts: The Olympic Games',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e4772b6b-7f18-4952-938a-6a1f66262c95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4772b6b-7f18-4952-938a-6a1f66262c95', 9, NULL, 'The Olympic Games', 'Jason and the Argonauts: The Olympic Games', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4772b6b-7f18-4952-938a-6a1f66262c95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Departure', part.name_en = 'Jason and the Argonauts: Departure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d25793f5-c052-46c9-aea1-c95cc75c1f90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d25793f5-c052-46c9-aea1-c95cc75c1f90', 10, NULL, 'Departure', 'Jason and the Argonauts: Departure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d25793f5-c052-46c9-aea1-c95cc75c1f90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Hera''s Effigy', part.name_en = 'Jason and the Argonauts: Hera''s Effigy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:55f2a7ac-7bdb-4fb0-8391-6c3887a809dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55f2a7ac-7bdb-4fb0-8391-6c3887a809dc', 11, NULL, 'Hera''s Effigy', 'Jason and the Argonauts: Hera''s Effigy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55f2a7ac-7bdb-4fb0-8391-6c3887a809dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Argo', part.name_en = 'Jason and the Argonauts: Argo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:95b25e50-76f1-4df0-a6e9-262e48722385' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95b25e50-76f1-4df0-a6e9-262e48722385', 12, NULL, 'Argo', 'Jason and the Argonauts: Argo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95b25e50-76f1-4df0-a6e9-262e48722385'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The Titans', part.name_en = 'Jason and the Argonauts: The Titans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4d150dcd-ee20-47bd-a862-f45c801b9cfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d150dcd-ee20-47bd-a862-f45c801b9cfb', 13, NULL, 'The Titans', 'Jason and the Argonauts: The Titans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d150dcd-ee20-47bd-a862-f45c801b9cfb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Chamber', part.name_en = 'Jason and the Argonauts: The Chamber',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e19e0233-adff-45c9-87cc-606eddbbcbd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e19e0233-adff-45c9-87cc-606eddbbcbd4', 14, NULL, 'The Chamber', 'Jason and the Argonauts: The Chamber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e19e0233-adff-45c9-87cc-606eddbbcbd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The Door', part.name_en = 'Jason and the Argonauts: The Door',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8e729e81-74a3-4b3f-83dc-f03c3414f383' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e729e81-74a3-4b3f-83dc-f03c3414f383', 15, NULL, 'The Door', 'Jason and the Argonauts: The Door', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e729e81-74a3-4b3f-83dc-f03c3414f383'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Talos', part.name_en = 'Jason and the Argonauts: Talos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8df818d0-8b90-4412-bc6d-0e8586c81d2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8df818d0-8b90-4412-bc6d-0e8586c81d2d', 16, NULL, 'Talos', 'Jason and the Argonauts: Talos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8df818d0-8b90-4412-bc6d-0e8586c81d2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'The Boat', part.name_en = 'Jason and the Argonauts: The Boat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b88d3b95-4778-4918-b757-2be6dd9f5c47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b88d3b95-4778-4918-b757-2be6dd9f5c47', 17, NULL, 'The Boat', 'Jason and the Argonauts: The Boat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b88d3b95-4778-4918-b757-2be6dd9f5c47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'The Wreck', part.name_en = 'Jason and the Argonauts: The Wreck',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:7e8552e9-5cd0-4676-b066-9853887bb77e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e8552e9-5cd0-4676-b066-9853887bb77e', 18, NULL, 'The Wreck', 'Jason and the Argonauts: The Wreck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e8552e9-5cd0-4676-b066-9853887bb77e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Hera Speaks', part.name_en = 'Jason and the Argonauts: Hera Speaks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f09cbd18-7fbe-4fb7-9045-743e80aa00c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f09cbd18-7fbe-4fb7-9045-743e80aa00c5', 19, NULL, 'Hera Speaks', 'Jason and the Argonauts: Hera Speaks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f09cbd18-7fbe-4fb7-9045-743e80aa00c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Attack', part.name_en = 'Jason and the Argonauts: The Attack',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a8ebd729-04a7-419e-a997-beea73f0cf29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8ebd729-04a7-419e-a997-beea73f0cf29', 20, NULL, 'The Attack', 'Jason and the Argonauts: The Attack', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8ebd729-04a7-419e-a997-beea73f0cf29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Talos''s Heel', part.name_en = 'Jason and the Argonauts: Talos''s Heel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:54ab84f6-f577-430b-ab80-fbeea0b270d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54ab84f6-f577-430b-ab80-fbeea0b270d1', 21, NULL, 'Talos''s Heel', 'Jason and the Argonauts: Talos''s Heel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54ab84f6-f577-430b-ab80-fbeea0b270d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Talos''s Death', part.name_en = 'Jason and the Argonauts: Talos''s Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2b4428e9-30f4-45f2-a28d-f8f14fdb6b04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b4428e9-30f4-45f2-a28d-f8f14fdb6b04', 22, NULL, 'Talos''s Death', 'Jason and the Argonauts: Talos''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b4428e9-30f4-45f2-a28d-f8f14fdb6b04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Sorrow', part.name_en = 'Jason and the Argonauts: Sorrow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f0ea57a2-be14-434e-b036-42368907af88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0ea57a2-be14-434e-b036-42368907af88', 23, NULL, 'Sorrow', 'Jason and the Argonauts: Sorrow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0ea57a2-be14-434e-b036-42368907af88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Hera''s Warning', part.name_en = 'Jason and the Argonauts: Hera''s Warning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8d2422f6-979e-4d63-b306-19195ef5bbfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d2422f6-979e-4d63-b306-19195ef5bbfe', 24, NULL, 'Hera''s Warning', 'Jason and the Argonauts: Hera''s Warning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d2422f6-979e-4d63-b306-19195ef5bbfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'The Harpies', part.name_en = 'Jason and the Argonauts: The Harpies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c14077f4-48d3-4989-aad4-e491056d8c80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c14077f4-48d3-4989-aad4-e491056d8c80', 25, NULL, 'The Harpies', 'Jason and the Argonauts: The Harpies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c14077f4-48d3-4989-aad4-e491056d8c80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'The Nets', part.name_en = 'Jason and the Argonauts: The Nets',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e81fe9ce-3e3f-496b-beaa-c5489945be8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e81fe9ce-3e3f-496b-beaa-c5489945be8d', 26, NULL, 'The Nets', 'Jason and the Argonauts: The Nets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e81fe9ce-3e3f-496b-beaa-c5489945be8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'The Rope', part.name_en = 'Jason and the Argonauts: The Rope',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:54617e8b-c6e1-4b11-838b-a489987d4bdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54617e8b-c6e1-4b11-838b-a489987d4bdc', 27, NULL, 'The Rope', 'Jason and the Argonauts: The Rope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54617e8b-c6e1-4b11-838b-a489987d4bdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'The Cage', part.name_en = 'Jason and the Argonauts: The Cage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:bbc1716e-e721-43a0-95d9-72665ced659f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbc1716e-e721-43a0-95d9-72665ced659f', 28, NULL, 'The Cage', 'Jason and the Argonauts: The Cage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbc1716e-e721-43a0-95d9-72665ced659f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Medea''s Ship', part.name_en = 'Jason and the Argonauts: Medea''s Ship',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c429bc7b-c97e-4ccd-8b28-5cab293e3b80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c429bc7b-c97e-4ccd-8b28-5cab293e3b80', 29, NULL, 'Medea''s Ship', 'Jason and the Argonauts: Medea''s Ship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c429bc7b-c97e-4ccd-8b28-5cab293e3b80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Triton', part.name_en = 'Jason and the Argonauts: Triton',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:0d4785d7-0164-4b7c-8035-0dea105cb14a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d4785d7-0164-4b7c-8035-0dea105cb14a', 30, NULL, 'Triton', 'Jason and the Argonauts: Triton', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d4785d7-0164-4b7c-8035-0dea105cb14a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Medea', part.name_en = 'Jason and the Argonauts: Medea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4c7ea51e-472a-4672-887e-f3f1cf1ca7ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c7ea51e-472a-4672-887e-f3f1cf1ca7ee', 31, NULL, 'Medea', 'Jason and the Argonauts: Medea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c7ea51e-472a-4672-887e-f3f1cf1ca7ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Acastus and Jason Fight', part.name_en = 'Jason and the Argonauts: Acastus and Jason Fight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c099fb47-c3c4-49c4-a018-2bbae7161eba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c099fb47-c3c4-49c4-a018-2bbae7161eba', 32, NULL, 'Acastus and Jason Fight', 'Jason and the Argonauts: Acastus and Jason Fight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c099fb47-c3c4-49c4-a018-2bbae7161eba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Temple Dance', part.name_en = 'Jason and the Argonauts: Temple Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a0481825-e3e9-477f-b524-90c1e99afccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0481825-e3e9-477f-b524-90c1e99afccf', 33, NULL, 'Temple Dance', 'Jason and the Argonauts: Temple Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0481825-e3e9-477f-b524-90c1e99afccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'The Glade', part.name_en = 'Jason and the Argonauts: The Glade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:44bd5111-f29f-46fd-952b-e4ce470b3975' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44bd5111-f29f-46fd-952b-e4ce470b3975', 34, NULL, 'The Glade', 'Jason and the Argonauts: The Glade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44bd5111-f29f-46fd-952b-e4ce470b3975'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'The Golden Fleece', part.name_en = 'Jason and the Argonauts: The Golden Fleece',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c1c1762d-e043-44f3-93d4-cc60f52e0f98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1c1762d-e043-44f3-93d4-cc60f52e0f98', 35, NULL, 'The Golden Fleece', 'Jason and the Argonauts: The Golden Fleece', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1c1762d-e043-44f3-93d4-cc60f52e0f98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'The Hydra', part.name_en = 'Jason and the Argonauts: The Hydra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1ccf0417-34f4-452a-b289-3580d3216203' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ccf0417-34f4-452a-b289-3580d3216203', 36, NULL, 'The Hydra', 'Jason and the Argonauts: The Hydra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ccf0417-34f4-452a-b289-3580d3216203'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'The Hydra Fight', part.name_en = 'Jason and the Argonauts: The Hydra Fight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:624bf4b7-6c9e-41c0-9bba-b948190b527c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:624bf4b7-6c9e-41c0-9bba-b948190b527c', 37, NULL, 'The Hydra Fight', 'Jason and the Argonauts: The Hydra Fight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:624bf4b7-6c9e-41c0-9bba-b948190b527c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'The Stolen Fleece', part.name_en = 'Jason and the Argonauts: The Stolen Fleece',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f21ee433-6827-4af1-9549-9158154f2464' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f21ee433-6827-4af1-9549-9158154f2464', 38, NULL, 'The Stolen Fleece', 'Jason and the Argonauts: The Stolen Fleece', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21ee433-6827-4af1-9549-9158154f2464'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'The Hydra''s Teeth', part.name_en = 'Jason and the Argonauts: The Hydra''s Teeth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b992301f-1d75-4f3c-b562-344f0b26eb26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b992301f-1d75-4f3c-b562-344f0b26eb26', 39, NULL, 'The Hydra''s Teeth', 'Jason and the Argonauts: The Hydra''s Teeth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b992301f-1d75-4f3c-b562-344f0b26eb26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'The Path', part.name_en = 'Jason and the Argonauts: The Path',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:80132071-5327-41a6-94cb-ac811f4f7303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80132071-5327-41a6-94cb-ac811f4f7303', 40, NULL, 'The Path', 'Jason and the Argonauts: The Path', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80132071-5327-41a6-94cb-ac811f4f7303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'The Cure', part.name_en = 'Jason and the Argonauts: The Cure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1bed76c2-d5a0-433d-b7c7-b74bffa5828d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bed76c2-d5a0-433d-b7c7-b74bffa5828d', 41, NULL, 'The Cure', 'Jason and the Argonauts: The Cure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bed76c2-d5a0-433d-b7c7-b74bffa5828d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'The Teeth', part.name_en = 'Jason and the Argonauts: The Teeth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c21d1e4c-1f14-4747-85b1-161524757be3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c21d1e4c-1f14-4747-85b1-161524757be3', 42, NULL, 'The Teeth', 'Jason and the Argonauts: The Teeth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c21d1e4c-1f14-4747-85b1-161524757be3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'The Skeletons', part.name_en = 'Jason and the Argonauts: The Skeletons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:6517e2b5-531e-4215-a7a4-3cc7c62adf56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6517e2b5-531e-4215-a7a4-3cc7c62adf56', 43, NULL, 'The Skeletons', 'Jason and the Argonauts: The Skeletons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6517e2b5-531e-4215-a7a4-3cc7c62adf56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'The Skeletons Attack', part.name_en = 'Jason and the Argonauts: The Skeletons Attack',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c7bf2c28-067d-464f-a980-a5840cf3610b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7bf2c28-067d-464f-a980-a5840cf3610b', 44, NULL, 'The Skeletons Attack', 'Jason and the Argonauts: The Skeletons Attack', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7bf2c28-067d-464f-a980-a5840cf3610b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Scherzo Macabre', part.name_en = 'Jason and the Argonauts: Scherzo Macabre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3fdb3e97-0ae3-48cb-b730-bc5d7715e509' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fdb3e97-0ae3-48cb-b730-bc5d7715e509', 45, NULL, 'Scherzo Macabre', 'Jason and the Argonauts: Scherzo Macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fdb3e97-0ae3-48cb-b730-bc5d7715e509'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Jason and the Argonauts: Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8008 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c2e549e1-397b-4e71-89ca-43022771f305' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2e549e1-397b-4e71-89ca-43022771f305', 46, NULL, 'Finale', 'Jason and the Argonauts: Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8008 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2e549e1-397b-4e71-89ca-43022771f305'
);


-- None 영화음악 <North by Northwest>

UPDATE pieces piece
SET piece.title = '영화음악 <North by Northwest>', piece.title_en = 'North by Northwest',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10873 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Wild Ride', part.name_en = 'The Wild Ride',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:0cdf189d-2de3-3fbe-b7c4-ffaa38b295ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cdf189d-2de3-3fbe-b7c4-ffaa38b295ad', 1, NULL, 'The Wild Ride', 'The Wild Ride', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cdf189d-2de3-3fbe-b7c4-ffaa38b295ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Message', part.name_en = 'The Message',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1f9aad66-a85f-332c-9608-5ee3801b2304' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f9aad66-a85f-332c-9608-5ee3801b2304', 2, NULL, 'The Message', 'The Message', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f9aad66-a85f-332c-9608-5ee3801b2304'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Ridge', part.name_en = 'The Ridge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:224b2cc2-e149-3064-9fdf-26542f6679d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:224b2cc2-e149-3064-9fdf-26542f6679d0', 3, NULL, 'The Ridge', 'The Ridge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:224b2cc2-e149-3064-9fdf-26542f6679d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e', 4, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Return', part.name_en = 'The Return',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:27b88537-624c-3abb-99c5-ac5c0f1c3fd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27b88537-624c-3abb-99c5-ac5c0f1c3fd1', 5, NULL, 'The Return', 'The Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27b88537-624c-3abb-99c5-ac5c0f1c3fd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Cheers', part.name_en = 'Cheers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:28fb2df5-04eb-3d8a-877b-fc47378768c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28fb2df5-04eb-3d8a-877b-fc47378768c3', 6, NULL, 'Cheers', 'Cheers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28fb2df5-04eb-3d8a-877b-fc47378768c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Gates', part.name_en = 'The Gates',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2c3bd6c4-363d-33c0-b933-31d13d2c9972' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c3bd6c4-363d-33c0-b933-31d13d2c9972', 7, NULL, 'The Gates', 'The Gates', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c3bd6c4-363d-33c0-b933-31d13d2c9972'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Door', part.name_en = 'The Door',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2da76289-fd8c-3803-95d3-9bd1e38839be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2da76289-fd8c-3803-95d3-9bd1e38839be', 8, NULL, 'The Door', 'The Door', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2da76289-fd8c-3803-95d3-9bd1e38839be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Information Desk', part.name_en = 'Information Desk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3122d139-88e2-3233-a8c0-ed9befe41de3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3122d139-88e2-3233-a8c0-ed9befe41de3', 9, NULL, 'Information Desk', 'Information Desk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3122d139-88e2-3233-a8c0-ed9befe41de3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Station', part.name_en = 'The Station',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:43618ccf-bffc-36db-9570-89637b391166' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43618ccf-bffc-36db-9570-89637b391166', 10, NULL, 'The Station', 'The Station', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43618ccf-bffc-36db-9570-89637b391166'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Question', part.name_en = 'The Question',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:45ca4605-1aa5-39c7-a702-a31e2d8d1392' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45ca4605-1aa5-39c7-a702-a31e2d8d1392', 11, NULL, 'The Question', 'The Question', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45ca4605-1aa5-39c7-a702-a31e2d8d1392'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'The U.N', part.name_en = 'The U.N.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:481c9d84-8b1c-37f8-b9a9-dce060045998' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:481c9d84-8b1c-37f8-b9a9-dce060045998', 12, NULL, 'The U.N', 'The U.N.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:481c9d84-8b1c-37f8-b9a9-dce060045998'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Conversation Piece', part.name_en = 'Conversation Piece',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4d6fba74-ca08-344f-90f8-1b7a3ec24488' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d6fba74-ca08-344f-90f8-1b7a3ec24488', 13, NULL, 'Conversation Piece', 'Conversation Piece', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d6fba74-ca08-344f-90f8-1b7a3ec24488'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Crash', part.name_en = 'The Crash',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4fe6fe9a-85b7-3775-8ff5-b520983dfa2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fe6fe9a-85b7-3775-8ff5-b520983dfa2f', 14, NULL, 'The Crash', 'The Crash', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fe6fe9a-85b7-3775-8ff5-b520983dfa2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The Knife', part.name_en = 'The Knife',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:53c8ad76-dd9b-37f5-af94-7623eca7049b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53c8ad76-dd9b-37f5-af94-7623eca7049b', 15, NULL, 'The Knife', 'The Knife', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53c8ad76-dd9b-37f5-af94-7623eca7049b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Police', part.name_en = 'The Police',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:5d752c3d-d447-3c9f-aeed-8c8c22b31142' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d752c3d-d447-3c9f-aeed-8c8c22b31142', 16, NULL, 'The Police', 'The Police', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d752c3d-d447-3c9f-aeed-8c8c22b31142'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Duo', part.name_en = 'Duo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:650eef66-f103-38e9-829c-5823bf39d1f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:650eef66-f103-38e9-829c-5823bf39d1f8', 17, NULL, 'Duo', 'Duo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:650eef66-f103-38e9-829c-5823bf39d1f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'The Match Box', part.name_en = 'The Match Box',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:66be834b-c554-3d97-a661-778e4840ca58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66be834b-c554-3d97-a661-778e4840ca58', 18, NULL, 'The Match Box', 'The Match Box', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66be834b-c554-3d97-a661-778e4840ca58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Two Dollars', part.name_en = 'Two Dollars',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:67687837-8a30-304b-a5f7-6b7a054b4a88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67687837-8a30-304b-a5f7-6b7a054b4a88', 19, NULL, 'Two Dollars', 'Two Dollars', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67687837-8a30-304b-a5f7-6b7a054b4a88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Streets (outtake)', part.name_en = 'The Streets (outtake)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:67d59469-d8df-39f6-a33f-48b85bf97c41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67d59469-d8df-39f6-a33f-48b85bf97c41', 20, NULL, 'The Streets (outtake)', 'The Streets (outtake)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67d59469-d8df-39f6-a33f-48b85bf97c41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'The Forest', part.name_en = 'The Forest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:72dfdd53-e312-3c27-b8de-50719b3e298d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72dfdd53-e312-3c27-b8de-50719b3e298d', 21, NULL, 'The Forest', 'The Forest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72dfdd53-e312-3c27-b8de-50719b3e298d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Hotel Lobby (outtake)', part.name_en = 'Hotel Lobby (outtake)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:7bc45246-578a-343e-83de-08989d8ff3dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bc45246-578a-343e-83de-08989d8ff3dd', 22, NULL, 'Hotel Lobby (outtake)', 'Hotel Lobby (outtake)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bc45246-578a-343e-83de-08989d8ff3dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:7c688697-b789-3bc5-8877-4891a3c4fd4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c688697-b789-3bc5-8877-4891a3c4fd4f', 23, NULL, 'Interlude', 'Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c688697-b789-3bc5-8877-4891a3c4fd4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Car Crash', part.name_en = 'Car Crash',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8b45ea3c-a3eb-3f4a-b74f-c9392cdf66f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b45ea3c-a3eb-3f4a-b74f-c9392cdf66f5', 24, NULL, 'Car Crash', 'Car Crash', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b45ea3c-a3eb-3f4a-b74f-c9392cdf66f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Farewell', part.name_en = 'Farewell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8dba318b-e0aa-3af4-bce3-88e58f6c1154' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dba318b-e0aa-3af4-bce3-88e58f6c1154', 25, NULL, 'Farewell', 'Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dba318b-e0aa-3af4-bce3-88e58f6c1154'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'The Airplane', part.name_en = 'The Airplane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:953d0e3a-84e9-375b-af03-ae31528b289b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:953d0e3a-84e9-375b-af03-ae31528b289b', 26, NULL, 'The Airplane', 'The Airplane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:953d0e3a-84e9-375b-af03-ae31528b289b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Goodbye', part.name_en = 'Goodbye',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a0aa1cc4-2538-3177-9cec-feead880a81f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0aa1cc4-2538-3177-9cec-feead880a81f', 27, NULL, 'Goodbye', 'Goodbye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0aa1cc4-2538-3177-9cec-feead880a81f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Detectives', part.name_en = 'Detectives',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ab266688-be42-3c97-b1a0-0b97b97221c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab266688-be42-3c97-b1a0-0b97b97221c4', 28, NULL, 'Detectives', 'Detectives', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab266688-be42-3c97-b1a0-0b97b97221c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'The Ledge', part.name_en = 'The Ledge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b13caacc-67f8-38a3-8bca-4c430f4e7347' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b13caacc-67f8-38a3-8bca-4c430f4e7347', 29, NULL, 'The Ledge', 'The Ledge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b13caacc-67f8-38a3-8bca-4c430f4e7347'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'The House', part.name_en = 'The House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b8ef674e-fe52-3f47-b89d-283c6e01ea3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8ef674e-fe52-3f47-b89d-283c6e01ea3b', 30, NULL, 'The House', 'The House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8ef674e-fe52-3f47-b89d-283c6e01ea3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b9657e7b-1efc-3e73-bada-ebceed9979bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9657e7b-1efc-3e73-bada-ebceed9979bd', 31, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9657e7b-1efc-3e73-bada-ebceed9979bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'The Cliff', part.name_en = 'The Cliff',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c3de9a83-d64a-34a6-a3f7-7ef8edc5c720' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3de9a83-d64a-34a6-a3f7-7ef8edc5c720', 32, NULL, 'The Cliff', 'The Cliff', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3de9a83-d64a-34a6-a3f7-7ef8edc5c720'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'The Elevator', part.name_en = 'The Elevator',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ca565936-afcd-3931-8932-914477333c9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca565936-afcd-3931-8932-914477333c9a', 33, NULL, 'The Elevator', 'The Elevator', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca565936-afcd-3931-8932-914477333c9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'The Balcony', part.name_en = 'The Balcony',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d2fcb9ab-38a4-3454-9eb0-fe31f49e203b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2fcb9ab-38a4-3454-9eb0-fe31f49e203b', 34, NULL, 'The Balcony', 'The Balcony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2fcb9ab-38a4-3454-9eb0-fe31f49e203b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Flight', part.name_en = 'Flight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d7f213c9-b14f-3c6e-af1e-58bfe44059a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7f213c9-b14f-3c6e-af1e-58bfe44059a6', 35, NULL, 'Flight', 'Flight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7f213c9-b14f-3c6e-af1e-58bfe44059a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'On the Rocks', part.name_en = 'On the Rocks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:dc36b7a9-1561-31e7-84df-9591d613c460' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc36b7a9-1561-31e7-84df-9591d613c460', 36, NULL, 'On the Rocks', 'On the Rocks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc36b7a9-1561-31e7-84df-9591d613c460'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'The T.V', part.name_en = 'The T.V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e3c5cc7c-0ac9-3c97-aa4a-32652589450e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3c5cc7c-0ac9-3c97-aa4a-32652589450e', 37, NULL, 'The T.V', 'The T.V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3c5cc7c-0ac9-3c97-aa4a-32652589450e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'The Reunion', part.name_en = 'The Reunion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e72b7385-934d-3ead-9b31-f08a9d820d19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e72b7385-934d-3ead-9b31-f08a9d820d19', 38, NULL, 'The Reunion', 'The Reunion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e72b7385-934d-3ead-9b31-f08a9d820d19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'The Shooting', part.name_en = 'The Shooting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ea826654-9a13-3dd5-b555-5a4c6c6a0bb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea826654-9a13-3dd5-b555-5a4c6c6a0bb5', 39, NULL, 'The Shooting', 'The Shooting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea826654-9a13-3dd5-b555-5a4c6c6a0bb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'The Stone Faces', part.name_en = 'The Stone Faces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:eafdd7da-490c-3c98-8ec0-c5bb3a557995' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eafdd7da-490c-3c98-8ec0-c5bb3a557995', 40, NULL, 'The Stone Faces', 'The Stone Faces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eafdd7da-490c-3c98-8ec0-c5bb3a557995'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'The Pad & Pencil', part.name_en = 'The Pad & Pencil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f268fddd-8257-3845-9d10-32467caab72b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f268fddd-8257-3845-9d10-32467caab72b', 41, NULL, 'The Pad & Pencil', 'The Pad & Pencil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f268fddd-8257-3845-9d10-32467caab72b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'The Phone Booth', part.name_en = 'The Phone Booth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f698cd27-3314-381c-87ee-7fb0e4ba001e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f698cd27-3314-381c-87ee-7fb0e4ba001e', 42, NULL, 'The Phone Booth', 'The Phone Booth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f698cd27-3314-381c-87ee-7fb0e4ba001e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'The Cafeteria', part.name_en = 'The Cafeteria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fa4bc353-0ace-3c35-a2a9-23fad99c74ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa4bc353-0ace-3c35-a2a9-23fad99c74ee', 43, NULL, 'The Cafeteria', 'The Cafeteria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa4bc353-0ace-3c35-a2a9-23fad99c74ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'The Auction', part.name_en = 'The Auction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fb06ae02-b0e2-3fe4-b6ac-1bb8a0e45065' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb06ae02-b0e2-3fe4-b6ac-1bb8a0e45065', 44, NULL, 'The Auction', 'The Auction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb06ae02-b0e2-3fe4-b6ac-1bb8a0e45065'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Kidnapped', part.name_en = 'Kidnapped',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fba5de1f-1ddc-3b22-aed9-aacb82d72dd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fba5de1f-1ddc-3b22-aed9-aacb82d72dd6', 45, NULL, 'Kidnapped', 'Kidnapped', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba5de1f-1ddc-3b22-aed9-aacb82d72dd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'The Airport', part.name_en = 'The Airport',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10873 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fc6c46b9-1a6b-3e27-a4c3-ab0d2acad5fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc6c46b9-1a6b-3e27-a4c3-ab0d2acad5fd', 46, NULL, 'The Airport', 'The Airport', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10873 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc6c46b9-1a6b-3e27-a4c3-ab0d2acad5fd'
);


-- None On a Note of Triumph (Part 2)

UPDATE pieces piece
SET piece.title = 'On a Note of Triumph (Part 2)', piece.title_en = 'On a Note of Triumph (Part 2)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7796 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Psycho>

UPDATE pieces piece
SET piece.title = '영화음악 <Psycho>', piece.title_en = 'Psycho',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8164 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Search (A)', part.name_en = 'The Search (A)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:047b8232-9967-45a6-8129-2f05f9bfcea3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:047b8232-9967-45a6-8129-2f05f9bfcea3', 1, NULL, 'The Search (A)', 'The Search (A)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:047b8232-9967-45a6-8129-2f05f9bfcea3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Shadow', part.name_en = 'The Shadow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:0a089f56-7053-40e3-ab4a-16d7283ff97c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a089f56-7053-40e3-ab4a-16d7283ff97c', 2, NULL, 'The Shadow', 'The Shadow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a089f56-7053-40e3-ab4a-16d7283ff97c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Cabin 1', part.name_en = 'Cabin 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:0a7c212e-e1f6-4ed7-b1ec-153d163bd271' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a7c212e-e1f6-4ed7-b1ec-153d163bd271', 3, NULL, 'Cabin 1', 'Cabin 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a7c212e-e1f6-4ed7-b1ec-153d163bd271'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Cleanup', part.name_en = 'Cleanup',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:0b1823bf-98f0-4e51-8356-096d8faf716d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b1823bf-98f0-4e51-8356-096d8faf716d', 4, NULL, 'Cleanup', 'Cleanup', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b1823bf-98f0-4e51-8356-096d8faf716d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Peephole', part.name_en = 'The Peephole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:16831f98-e079-4fe0-b053-e4de99dd313a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16831f98-e079-4fe0-b053-e4de99dd313a', 5, NULL, 'The Peephole', 'The Peephole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16831f98-e079-4fe0-b053-e4de99dd313a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Car', part.name_en = 'The Car',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:22abd330-6bae-4e45-9b28-11d659202ea2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22abd330-6bae-4e45-9b28-11d659202ea2', 6, NULL, 'The Car', 'The Car', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22abd330-6bae-4e45-9b28-11d659202ea2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Package', part.name_en = 'The Package',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2808c8f7-4aeb-4bb3-bc84-6f882f8a6383' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2808c8f7-4aeb-4bb3-bc84-6f882f8a6383', 7, NULL, 'The Package', 'The Package', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2808c8f7-4aeb-4bb3-bc84-6f882f8a6383'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Rainstorm', part.name_en = 'The Rainstorm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2878fafe-7c81-403f-a640-b1b4a1104889' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2878fafe-7c81-403f-a640-b1b4a1104889', 8, NULL, 'The Rainstorm', 'The Rainstorm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2878fafe-7c81-403f-a640-b1b4a1104889'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Cabin 10', part.name_en = 'Cabin 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2a25df02-3732-4948-b7c3-38d6fd6c3222' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a25df02-3732-4948-b7c3-38d6fd6c3222', 9, NULL, 'Cabin 10', 'Cabin 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a25df02-3732-4948-b7c3-38d6fd6c3222'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Parlour', part.name_en = 'The Parlour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3c39418c-e822-4fbd-b789-bc293547ebb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c39418c-e822-4fbd-b789-bc293547ebb9', 10, NULL, 'The Parlour', 'The Parlour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c39418c-e822-4fbd-b789-bc293547ebb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Curtain', part.name_en = 'The Curtain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4696893e-ba24-40a7-87e0-8fde51fa81da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4696893e-ba24-40a7-87e0-8fde51fa81da', 11, NULL, 'The Curtain', 'The Curtain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4696893e-ba24-40a7-87e0-8fde51fa81da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'The Window', part.name_en = 'The Window',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4a22919e-4748-4498-b166-ff002bd590eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a22919e-4748-4498-b166-ff002bd590eb', 12, NULL, 'The Window', 'The Window', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a22919e-4748-4498-b166-ff002bd590eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The Bathroom', part.name_en = 'The Bathroom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4be2d617-55cb-4568-bb8a-ad1d415a015a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4be2d617-55cb-4568-bb8a-ad1d415a015a', 13, NULL, 'The Bathroom', 'The Bathroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4be2d617-55cb-4568-bb8a-ad1d415a015a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Water', part.name_en = 'The Water',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:5f41ce77-5e41-4b94-a782-a134f19718a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f41ce77-5e41-4b94-a782-a134f19718a6', 14, NULL, 'The Water', 'The Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f41ce77-5e41-4b94-a782-a134f19718a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The First Floor', part.name_en = 'The First Floor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:629d10d6-84d5-4b4c-ae10-f3a804c8a62a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:629d10d6-84d5-4b4c-ae10-f3a804c8a62a', 15, NULL, 'The First Floor', 'The First Floor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:629d10d6-84d5-4b4c-ae10-f3a804c8a62a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Body', part.name_en = 'The Body',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:6ef3d6dd-660d-4618-8115-aeb1ac465b1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ef3d6dd-660d-4618-8115-aeb1ac465b1c', 16, NULL, 'The Body', 'The Body', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ef3d6dd-660d-4618-8115-aeb1ac465b1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'The Cellar', part.name_en = 'The Cellar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:843fb907-b2d8-4bcb-819b-6ddc6b9613bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:843fb907-b2d8-4bcb-819b-6ddc6b9613bf', 17, NULL, 'The Cellar', 'The Cellar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:843fb907-b2d8-4bcb-819b-6ddc6b9613bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Temptation', part.name_en = 'Temptation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:9615db3a-bf06-4350-b7ab-583baf93c638' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9615db3a-bf06-4350-b7ab-583baf93c638', 18, NULL, 'Temptation', 'Temptation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9615db3a-bf06-4350-b7ab-583baf93c638'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'The Toys', part.name_en = 'The Toys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:96171800-2faf-4ea9-9f5e-ce78b504e9c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96171800-2faf-4ea9-9f5e-ce78b504e9c2', 19, NULL, 'The Toys', 'The Toys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96171800-2faf-4ea9-9f5e-ce78b504e9c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Hill', part.name_en = 'The Hill',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:9b56a223-58ac-47c6-bba0-c73e41bc7824' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b56a223-58ac-47c6-bba0-c73e41bc7824', 20, NULL, 'The Hill', 'The Hill', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b56a223-58ac-47c6-bba0-c73e41bc7824'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'The Porch', part.name_en = 'The Porch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:9de00b39-776f-4322-94ea-c2624401c829' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9de00b39-776f-4322-94ea-c2624401c829', 21, NULL, 'The Porch', 'The Porch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9de00b39-776f-4322-94ea-c2624401c829'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'The Patrol Car', part.name_en = 'The Patrol Car',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a32f2a9c-115b-42f1-b0ac-9d1df42c0669' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a32f2a9c-115b-42f1-b0ac-9d1df42c0669', 22, NULL, 'The Patrol Car', 'The Patrol Car', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a32f2a9c-115b-42f1-b0ac-9d1df42c0669'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a48fbf7a-c641-4c6f-bffa-6ecf6c793940' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a48fbf7a-c641-4c6f-bffa-6ecf6c793940', 23, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a48fbf7a-c641-4c6f-bffa-6ecf6c793940'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Discovery', part.name_en = 'Discovery',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a5787532-b97e-45ae-9647-9257fd65503c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5787532-b97e-45ae-9647-9257fd65503c', 24, NULL, 'Discovery', 'Discovery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5787532-b97e-45ae-9647-9257fd65503c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'The City', part.name_en = 'The City',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a9cc1a62-1460-4080-8980-cd4af10af32c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9cc1a62-1460-4080-8980-cd4af10af32c', 25, NULL, 'The City', 'The City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9cc1a62-1460-4080-8980-cd4af10af32c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:afb59aaf-d6a7-4d95-9fea-0c56461a19be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb59aaf-d6a7-4d95-9fea-0c56461a19be', 26, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb59aaf-d6a7-4d95-9fea-0c56461a19be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'The Stairs', part.name_en = 'The Stairs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b7bffd08-1814-4596-99f9-928a9381a252' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7bffd08-1814-4596-99f9-928a9381a252', 27, NULL, 'The Stairs', 'The Stairs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7bffd08-1814-4596-99f9-928a9381a252'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'The Bedroom', part.name_en = 'The Bedroom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b9cc35a3-8936-4e8b-a94e-43c74ebfe40d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9cc35a3-8936-4e8b-a94e-43c74ebfe40d', 28, NULL, 'The Bedroom', 'The Bedroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9cc35a3-8936-4e8b-a94e-43c74ebfe40d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'The Office', part.name_en = 'The Office',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ba4ac44b-9fe7-4958-a9cd-da21aa420309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba4ac44b-9fe7-4958-a9cd-da21aa420309', 29, NULL, 'The Office', 'The Office', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba4ac44b-9fe7-4958-a9cd-da21aa420309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Phone Booth', part.name_en = 'Phone Booth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:be3d2d41-885d-4c4b-aeed-ffb6cc5fcd33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be3d2d41-885d-4c4b-aeed-ffb6cc5fcd33', 30, NULL, 'Phone Booth', 'Phone Booth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be3d2d41-885d-4c4b-aeed-ffb6cc5fcd33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'The Search (B)', part.name_en = 'The Search (B)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c0671bf0-7bec-4aef-857a-24217897f4d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0671bf0-7bec-4aef-857a-24217897f4d9', 31, NULL, 'The Search (B)', 'The Search (B)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0671bf0-7bec-4aef-857a-24217897f4d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'The Madhouse', part.name_en = 'The Madhouse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ceb5968e-9c9e-4a9f-b6ac-042b61cffefa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceb5968e-9c9e-4a9f-b6ac-042b61cffefa', 32, NULL, 'The Madhouse', 'The Madhouse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceb5968e-9c9e-4a9f-b6ac-042b61cffefa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'The Car Lot', part.name_en = 'The Car Lot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d6de8b28-ee91-49c7-a78c-6369107bbf0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6de8b28-ee91-49c7-a78c-6369107bbf0c', 33, NULL, 'The Car Lot', 'The Car Lot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6de8b28-ee91-49c7-a78c-6369107bbf0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'The Knife', part.name_en = 'The Knife',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e3925196-6b9b-484a-8079-4df19a16ef0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3925196-6b9b-484a-8079-4df19a16ef0e', 34, NULL, 'The Knife', 'The Knife', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3925196-6b9b-484a-8079-4df19a16ef0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Marion', part.name_en = 'Marion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ebf3ba74-5ea6-4ffe-bb63-ee6b24e79c26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebf3ba74-5ea6-4ffe-bb63-ee6b24e79c26', 35, NULL, 'Marion', 'Marion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebf3ba74-5ea6-4ffe-bb63-ee6b24e79c26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Hotel Room', part.name_en = 'Hotel Room',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ec932b65-f967-45f9-a4c0-3998a98e440f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec932b65-f967-45f9-a4c0-3998a98e440f', 36, NULL, 'Hotel Room', 'Hotel Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec932b65-f967-45f9-a4c0-3998a98e440f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Flight', part.name_en = 'Flight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f14b2552-6d5f-4661-92ba-5aeba7fee7bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f14b2552-6d5f-4661-92ba-5aeba7fee7bd', 37, NULL, 'Flight', 'Flight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f14b2552-6d5f-4661-92ba-5aeba7fee7bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'The Swamp', part.name_en = 'The Swamp',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f1b6566d-472c-45a2-a784-36cf6fcdea2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1b6566d-472c-45a2-a784-36cf6fcdea2d', 38, NULL, 'The Swamp', 'The Swamp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1b6566d-472c-45a2-a784-36cf6fcdea2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'The Murder', part.name_en = 'The Murder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8164 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fd03b83b-3cf7-48b3-8040-b574c05c23b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd03b83b-3cf7-48b3-8040-b574c05c23b0', 39, NULL, 'The Murder', 'The Murder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8164 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd03b83b-3cf7-48b3-8040-b574c05c23b0'
);


-- None Radar

UPDATE pieces piece
SET piece.title = 'Radar', piece.title_en = 'Radar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9760 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Souvenirs de voyage

UPDATE pieces piece
SET piece.title = 'Souvenirs de voyage', piece.title_en = 'Souvenirs de voyage',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8434 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento (Molto tranquilo)', part.name_en = 'Souvenirs de voyage: I. Lento (Molto tranquilo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8434 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:955682fd-a239-424b-93d7-9f3b6079beab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:955682fd-a239-424b-93d7-9f3b6079beab', 1, 'I', 'Lento (Molto tranquilo)', 'Souvenirs de voyage: I. Lento (Molto tranquilo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8434 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:955682fd-a239-424b-93d7-9f3b6079beab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante (Berceuse)', part.name_en = 'Souvenirs de voyage: II. Andante (Berceuse)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8434 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3c4b9f89-7015-493f-b72b-e5995ba34965' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c4b9f89-7015-493f-b72b-e5995ba34965', 2, 'II', 'Andante (Berceuse)', 'Souvenirs de voyage: II. Andante (Berceuse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8434 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c4b9f89-7015-493f-b72b-e5995ba34965'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino (Canto amoroso)', part.name_en = 'Souvenirs de voyage: III. Andantino (Canto amoroso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8434 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:9d895de2-dfd0-4c20-a2c5-55f3479bd178' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d895de2-dfd0-4c20-a2c5-55f3479bd178', 3, 'III', 'Andantino (Canto amoroso)', 'Souvenirs de voyage: III. Andantino (Canto amoroso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8434 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d895de2-dfd0-4c20-a2c5-55f3479bd178'
);


-- None 교향곡 1번

UPDATE pieces piece
SET piece.title = '교향곡 1번', piece.title_en = 'Symphony no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8324 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Maestoso: Allegro pesante', part.name_en = 'Symphony no. 1: I. Maestoso: Allegro pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8324 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b3bd10ae-4d6d-419d-b89e-82959527f2b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3bd10ae-4d6d-419d-b89e-82959527f2b1', 1, 'I', 'Maestoso: Allegro pesante', 'Symphony no. 1: I. Maestoso: Allegro pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8324 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3bd10ae-4d6d-419d-b89e-82959527f2b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo', part.name_en = 'Symphony no. 1: II. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8324 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e007e985-6ed4-4e4d-a132-e4e909715c31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e007e985-6ed4-4e4d-a132-e4e909715c31', 2, 'II', 'Scherzo', 'Symphony no. 1: II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8324 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e007e985-6ed4-4e4d-a132-e4e909715c31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Symphony no. 1: III. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8324 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b70b78e6-d68c-46e4-ae71-060356ef81fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b70b78e6-d68c-46e4-ae71-060356ef81fd', 3, 'III', 'Andante sostenuto', 'Symphony no. 1: III. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8324 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b70b78e6-d68c-46e4-ae71-060356ef81fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Rondo: Epilogue a la processional', part.name_en = 'Symphony no. 1: IV. Rondo: Epilogue a la processional',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8324 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f00ff09a-f487-480b-9666-26c25c507d7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f00ff09a-f487-480b-9666-26c25c507d7e', 4, 'IV', 'Rondo: Epilogue a la processional', 'Symphony no. 1: IV. Rondo: Epilogue a la processional', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8324 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f00ff09a-f487-480b-9666-26c25c507d7e'
);


-- None 영화음악 <Taxi Driver>

UPDATE pieces piece
SET piece.title = '영화음악 <Taxi Driver>', piece.title_en = 'Taxi Driver',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8300 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The .44 Magnum Is a Monster', part.name_en = 'The .44 Magnum Is a Monster',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8300 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:030e45dc-3b9b-4c40-aa6d-9dbb7ccc1d4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:030e45dc-3b9b-4c40-aa6d-9dbb7ccc1d4c', 1, NULL, 'The .44 Magnum Is a Monster', 'The .44 Magnum Is a Monster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8300 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:030e45dc-3b9b-4c40-aa6d-9dbb7ccc1d4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'God''s Lonely Man', part.name_en = 'God''s Lonely Man',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8300 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2ad20ded-63bd-4345-a321-2d48225305f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ad20ded-63bd-4345-a321-2d48225305f3', 2, NULL, 'God''s Lonely Man', 'God''s Lonely Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8300 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ad20ded-63bd-4345-a321-2d48225305f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Diary of a Taxi Driver', part.name_en = 'Diary of a Taxi Driver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8300 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3f573e21-bc28-4f49-8786-fe93b6eabce7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f573e21-bc28-4f49-8786-fe93b6eabce7', 3, NULL, 'Diary of a Taxi Driver', 'Diary of a Taxi Driver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8300 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f573e21-bc28-4f49-8786-fe93b6eabce7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Betsy in a White Dress', part.name_en = 'Betsy in a White Dress',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8300 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4024bd18-1e43-424e-84c4-d9c6ed881513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4024bd18-1e43-424e-84c4-d9c6ed881513', 4, NULL, 'Betsy in a White Dress', 'Betsy in a White Dress', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8300 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4024bd18-1e43-424e-84c4-d9c6ed881513'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'I Work the Whole City', part.name_en = 'I Work the Whole City',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8300 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:574ccfdf-4f12-4787-9c42-8add43f779e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:574ccfdf-4f12-4787-9c42-8add43f779e6', 5, NULL, 'I Work the Whole City', 'I Work the Whole City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8300 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:574ccfdf-4f12-4787-9c42-8add43f779e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Days Do Not End', part.name_en = 'The Days Do Not End',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8300 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:62efd655-4203-4b0f-9d71-9f06a5bbce51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62efd655-4203-4b0f-9d71-9f06a5bbce51', 6, NULL, 'The Days Do Not End', 'The Days Do Not End', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8300 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62efd655-4203-4b0f-9d71-9f06a5bbce51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Theme From Taxi Driver', part.name_en = 'Theme From Taxi Driver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8300 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d25b996c-4af4-4e79-80ff-836ae0f59206' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d25b996c-4af4-4e79-80ff-836ae0f59206', 7, NULL, 'Theme From Taxi Driver', 'Theme From Taxi Driver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8300 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d25b996c-4af4-4e79-80ff-836ae0f59206'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Sport and Iris', part.name_en = 'Sport and Iris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8300 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:dab4d815-4b1e-41d2-8729-4ec9d8e91d1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dab4d815-4b1e-41d2-8729-4ec9d8e91d1f', 8, NULL, 'Sport and Iris', 'Sport and Iris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8300 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dab4d815-4b1e-41d2-8729-4ec9d8e91d1f'
);


-- None 영화음악 <The Day the Earth Stood Still>

UPDATE pieces piece
SET piece.title = '영화음악 <The Day the Earth Stood Still>', piece.title_en = 'The Day the Earth Stood Still',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7803 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Arlington', part.name_en = 'Arlington',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:15a43f3f-833f-4b0c-afbc-a85da0f89a38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15a43f3f-833f-4b0c-afbc-a85da0f89a38', 1, NULL, 'Arlington', 'Arlington', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15a43f3f-833f-4b0c-afbc-a85da0f89a38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rebirth', part.name_en = 'Rebirth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:23cb1fce-a44e-45d0-a40a-8c8c72416325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23cb1fce-a44e-45d0-a40a-8c8c72416325', 2, NULL, 'Rebirth', 'Rebirth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23cb1fce-a44e-45d0-a40a-8c8c72416325'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Departure', part.name_en = 'Departure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:31dd9864-51b8-4cf9-8d0c-cdd2edc8e8d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31dd9864-51b8-4cf9-8d0c-cdd2edc8e8d6', 3, NULL, 'Departure', 'Departure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31dd9864-51b8-4cf9-8d0c-cdd2edc8e8d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Escape', part.name_en = 'Escape',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:361312c1-7ee3-4aa2-9c36-d41a22f01162' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:361312c1-7ee3-4aa2-9c36-d41a22f01162', 4, NULL, 'Escape', 'Escape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:361312c1-7ee3-4aa2-9c36-d41a22f01162'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Panic', part.name_en = 'Panic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:5469ec77-c16d-44b2-a940-3fc02722f6cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5469ec77-c16d-44b2-a940-3fc02722f6cc', 5, NULL, 'Panic', 'Panic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5469ec77-c16d-44b2-a940-3fc02722f6cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Klaatu', part.name_en = 'Klaatu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:5e4270d9-eb5f-4376-b4d0-05dc3bafaa23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e4270d9-eb5f-4376-b4d0-05dc3bafaa23', 6, NULL, 'Klaatu', 'Klaatu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e4270d9-eb5f-4376-b4d0-05dc3bafaa23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:78209b69-dd9b-4da5-aa94-f65ce7ffd5e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78209b69-dd9b-4da5-aa94-f65ce7ffd5e4', 7, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78209b69-dd9b-4da5-aa94-f65ce7ffd5e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Glowing / Alone / Gort''s Rage / Nikto / The Captive / Terror', part.name_en = 'The Glowing / Alone / Gort''s Rage / Nikto / The Captive / Terror',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:7ef75aeb-bf15-425d-8ae0-4763decfd92f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ef75aeb-bf15-425d-8ae0-4763decfd92f', 8, NULL, 'The Glowing / Alone / Gort''s Rage / Nikto / The Captive / Terror', 'The Glowing / Alone / Gort''s Rage / Nikto / The Captive / Terror', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ef75aeb-bf15-425d-8ae0-4763decfd92f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Solar Diamonds', part.name_en = 'Solar Diamonds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:92b2e1b7-770b-410d-bfb6-134d0e328577' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92b2e1b7-770b-410d-bfb6-134d0e328577', 9, NULL, 'Solar Diamonds', 'Solar Diamonds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92b2e1b7-770b-410d-bfb6-134d0e328577'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Nocturne / Flashlight / The Robot / Space Control', part.name_en = 'Nocturne / Flashlight / The Robot / Space Control',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a3e252a8-cf46-4540-bfee-6666037f0aec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3e252a8-cf46-4540-bfee-6666037f0aec', 10, NULL, 'Nocturne / Flashlight / The Robot / Space Control', 'Nocturne / Flashlight / The Robot / Space Control', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3e252a8-cf46-4540-bfee-6666037f0aec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Danger', part.name_en = 'Danger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b878d6c5-72da-4ea2-88f2-b7fe0ae5cef0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b878d6c5-72da-4ea2-88f2-b7fe0ae5cef0', 11, NULL, 'Danger', 'Danger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b878d6c5-72da-4ea2-88f2-b7fe0ae5cef0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Prelude / Outer Space / Radar', part.name_en = 'Prelude / Outer Space / Radar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:bb681582-54ac-417b-9cbf-6562a31b1433' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb681582-54ac-417b-9cbf-6562a31b1433', 12, NULL, 'Prelude / Outer Space / Radar', 'Prelude / Outer Space / Radar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb681582-54ac-417b-9cbf-6562a31b1433'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Lincoln Memorial', part.name_en = 'Lincoln Memorial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c1405fd5-ea01-4e77-a0f3-117082cde43d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1405fd5-ea01-4e77-a0f3-117082cde43d', 13, NULL, 'Lincoln Memorial', 'Lincoln Memorial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1405fd5-ea01-4e77-a0f3-117082cde43d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Prison', part.name_en = 'The Prison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d9b34485-7248-4a21-a811-f7b53634985d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9b34485-7248-4a21-a811-f7b53634985d', 14, NULL, 'The Prison', 'The Prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9b34485-7248-4a21-a811-f7b53634985d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Gort / Visor / Telescope', part.name_en = 'Gort / Visor / Telescope',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e33ecc78-41ff-478e-9322-334b3a7b519e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e33ecc78-41ff-478e-9322-334b3a7b519e', 15, NULL, 'Gort / Visor / Telescope', 'Gort / Visor / Telescope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e33ecc78-41ff-478e-9322-334b3a7b519e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Farewell', part.name_en = 'Farewell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fa0f64fc-a193-4da6-8bf2-aa24021722c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa0f64fc-a193-4da6-8bf2-aa24021722c4', 16, NULL, 'Farewell', 'Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa0f64fc-a193-4da6-8bf2-aa24021722c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Elevator / Magnetic Pull / Study / Conference / Jewelry Store', part.name_en = 'Elevator / Magnetic Pull / Study / Conference / Jewelry Store',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7803 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fa2c67c2-8566-49fa-b43f-08aba28899d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa2c67c2-8566-49fa-b43f-08aba28899d8', 17, NULL, 'Elevator / Magnetic Pull / Study / Conference / Jewelry Store', 'Elevator / Magnetic Pull / Study / Conference / Jewelry Store', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7803 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa2c67c2-8566-49fa-b43f-08aba28899d8'
);


-- None 연가곡집 <The Fantasticks>

UPDATE pieces piece
SET piece.title = '연가곡집 <The Fantasticks>', piece.title_en = 'The Fantasticks',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9025 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'January', part.name_en = 'The Fantasticks: January',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9025 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d79a6b14-d6d5-4275-bab4-e25529159cfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d79a6b14-d6d5-4275-bab4-e25529159cfe', 1, NULL, 'January', 'The Fantasticks: January', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9025 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d79a6b14-d6d5-4275-bab4-e25529159cfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'February', part.name_en = 'The Fantasticks: February',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9025 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b8804b15-452b-4185-bbcd-abd392b254e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8804b15-452b-4185-bbcd-abd392b254e4', 2, NULL, 'February', 'The Fantasticks: February', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9025 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8804b15-452b-4185-bbcd-abd392b254e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'March', part.name_en = 'The Fantasticks: March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9025 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:af4c7c64-6e7b-4d6b-b9f1-9818a279bc71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af4c7c64-6e7b-4d6b-b9f1-9818a279bc71', 3, NULL, 'March', 'The Fantasticks: March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9025 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af4c7c64-6e7b-4d6b-b9f1-9818a279bc71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'April', part.name_en = 'The Fantasticks: April',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9025 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e527248a-6d8c-451a-adae-496c23ef1d56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e527248a-6d8c-451a-adae-496c23ef1d56', 4, NULL, 'April', 'The Fantasticks: April', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9025 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e527248a-6d8c-451a-adae-496c23ef1d56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'May', part.name_en = 'The Fantasticks: May',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9025 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:62889799-8b83-475d-931b-9b829044d1d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62889799-8b83-475d-931b-9b829044d1d5', 5, NULL, 'May', 'The Fantasticks: May', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9025 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62889799-8b83-475d-931b-9b829044d1d5'
);


-- None 영화음악 <The Snows of Kilimanjaro>

UPDATE pieces piece
SET piece.title = '영화음악 <The Snows of Kilimanjaro>', piece.title_en = 'The Snows of Kilimanjaro',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10711 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Helen', part.name_en = 'Helen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1d5edbeb-d049-4b85-a74f-caeb310807ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d5edbeb-d049-4b85-a74f-caeb310807ea', 1, NULL, 'Helen', 'Helen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d5edbeb-d049-4b85-a74f-caeb310807ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Silence', part.name_en = 'The Silence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1e9f725d-89d4-4cf2-bfd9-ff13c4065215' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e9f725d-89d4-4cf2-bfd9-ff13c4065215', 2, NULL, 'The Silence', 'The Silence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e9f725d-89d4-4cf2-bfd9-ff13c4065215'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Barcarolle', part.name_en = 'Barcarolle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:28c98b91-82bf-42dc-b042-f9e6a43422dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28c98b91-82bf-42dc-b042-f9e6a43422dc', 3, NULL, 'Barcarolle', 'Barcarolle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28c98b91-82bf-42dc-b042-f9e6a43422dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Death-watch', part.name_en = 'The Death-watch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:40bea1b5-8241-4315-b2d9-e8dd6eb93657' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40bea1b5-8241-4315-b2d9-e8dd6eb93657', 4, NULL, 'The Death-watch', 'The Death-watch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40bea1b5-8241-4315-b2d9-e8dd6eb93657'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Letter', part.name_en = 'The Letter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:42b25bc4-98bb-4a97-8723-a43a0ddd3fe3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b25bc4-98bb-4a97-8723-a43a0ddd3fe3', 5, NULL, 'The Letter', 'The Letter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b25bc4-98bb-4a97-8723-a43a0ddd3fe3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:69bbdf1e-ce0d-42fd-beaa-abb982788106' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69bbdf1e-ce0d-42fd-beaa-abb982788106', 6, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69bbdf1e-ce0d-42fd-beaa-abb982788106'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = 'Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:6ead648a-f460-4bff-843b-f4eae6be5d6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ead648a-f460-4bff-843b-f4eae6be5d6d', 7, NULL, 'Nocturne', 'Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ead648a-f460-4bff-843b-f4eae6be5d6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Farewell', part.name_en = 'The Farewell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:81e70a60-6979-46c3-abf6-d63c5a2c4088' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81e70a60-6979-46c3-abf6-d63c5a2c4088', 8, NULL, 'The Farewell', 'The Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81e70a60-6979-46c3-abf6-d63c5a2c4088'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Fall', part.name_en = 'The Fall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:899037dd-32ec-4291-89e8-58c861cc5bbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:899037dd-32ec-4291-89e8-58c861cc5bbb', 9, NULL, 'The Fall', 'The Fall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:899037dd-32ec-4291-89e8-58c861cc5bbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Sorrow', part.name_en = 'Sorrow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:906f4bac-b8ac-4932-9e59-3a77d9cf11cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:906f4bac-b8ac-4932-9e59-3a77d9cf11cd', 10, NULL, 'Sorrow', 'Sorrow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:906f4bac-b8ac-4932-9e59-3a77d9cf11cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Adagietto', part.name_en = 'Adagietto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:aaa91d5e-a51b-4246-a823-94c6295de0c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaa91d5e-a51b-4246-a823-94c6295de0c8', 11, NULL, 'Adagietto', 'Adagietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa91d5e-a51b-4246-a823-94c6295de0c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Interlude I', part.name_en = 'Interlude I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b81f410e-9af5-432c-bf50-0d5915a37d65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b81f410e-9af5-432c-bf50-0d5915a37d65', 12, NULL, 'Interlude I', 'Interlude I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b81f410e-9af5-432c-bf50-0d5915a37d65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The Hyena', part.name_en = 'The Hyena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c78a9df6-b4ff-4179-ba47-877e7ebaef41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c78a9df6-b4ff-4179-ba47-877e7ebaef41', 13, NULL, 'The Hyena', 'The Hyena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c78a9df6-b4ff-4179-ba47-877e7ebaef41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Interlude II', part.name_en = 'Interlude II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e4e4d285-c067-4d58-9482-51c2c9c8cfc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4e4d285-c067-4d58-9482-51c2c9c8cfc5', 14, NULL, 'Interlude II', 'Interlude II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e4d285-c067-4d58-9482-51c2c9c8cfc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ea2e76c1-fc3f-4fed-b2b4-31ff18f99fb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea2e76c1-fc3f-4fed-b2b4-31ff18f99fb6', 15, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea2e76c1-fc3f-4fed-b2b4-31ff18f99fb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Awakening', part.name_en = 'The Awakening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:eedade03-427c-4df4-89b7-5d097f0f279e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eedade03-427c-4df4-89b7-5d097f0f279e', 16, NULL, 'The Awakening', 'The Awakening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eedade03-427c-4df4-89b7-5d097f0f279e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Witch Doctor', part.name_en = 'Witch Doctor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f4a04334-2a1e-4926-95a5-70e80c7d5a45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4a04334-2a1e-4926-95a5-70e80c7d5a45', 17, NULL, 'Witch Doctor', 'Witch Doctor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4a04334-2a1e-4926-95a5-70e80c7d5a45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Memory Waltz', part.name_en = 'Memory Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f8c89063-20c7-4d8b-8598-42f31e8fcd93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8c89063-20c7-4d8b-8598-42f31e8fcd93', 18, NULL, 'Memory Waltz', 'Memory Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8c89063-20c7-4d8b-8598-42f31e8fcd93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Panic', part.name_en = 'Panic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fb9eb835-d6a4-460d-b786-3855ea275481' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb9eb835-d6a4-460d-b786-3855ea275481', 19, NULL, 'Panic', 'Panic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb9eb835-d6a4-460d-b786-3855ea275481'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The River', part.name_en = 'The River',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10711 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fc312ab8-478e-44cf-bff2-d52f0cb7fb69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc312ab8-478e-44cf-bff2-d52f0cb7fb69', 20, NULL, 'The River', 'The River', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10711 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc312ab8-478e-44cf-bff2-d52f0cb7fb69'
);


-- None 영화음악 <The Trouble With Harry>

UPDATE pieces piece
SET piece.title = '영화음악 <The Trouble With Harry>', piece.title_en = 'The Trouble With Harry',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8797 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Phantom Coach', part.name_en = 'The Phantom Coach',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:03dfa624-d03f-472c-b21b-cbcd3208c3b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03dfa624-d03f-472c-b21b-cbcd3208c3b9', 1, NULL, 'The Phantom Coach', 'The Phantom Coach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03dfa624-d03f-472c-b21b-cbcd3208c3b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Waltz Macabre', part.name_en = 'Waltz Macabre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:12b4c9bf-9f85-4424-bff8-5d3c38dddb36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12b4c9bf-9f85-4424-bff8-5d3c38dddb36', 2, NULL, 'Waltz Macabre', 'Waltz Macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12b4c9bf-9f85-4424-bff8-5d3c38dddb36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Country Road', part.name_en = 'The Country Road',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:13bb7851-b11d-4a75-ac59-579793708aa3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13bb7851-b11d-4a75-ac59-579793708aa3', 3, NULL, 'The Country Road', 'The Country Road', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13bb7851-b11d-4a75-ac59-579793708aa3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Cortege', part.name_en = 'Cortege',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1aa48b7f-df11-45b0-bbfb-8b817e32238f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aa48b7f-df11-45b0-bbfb-8b817e32238f', 4, NULL, 'Cortege', 'Cortege', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aa48b7f-df11-45b0-bbfb-8b817e32238f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Autumn Afternoon', part.name_en = 'Autumn Afternoon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1b75baa8-2ab9-4dcc-b93d-cb11631d5723' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b75baa8-2ab9-4dcc-b93d-cb11631d5723', 5, NULL, 'Autumn Afternoon', 'Autumn Afternoon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b75baa8-2ab9-4dcc-b93d-cb11631d5723'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Waltz Reprise', part.name_en = 'Waltz Reprise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2c82fcb2-0bde-4ad4-8320-b5bcd0689110' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c82fcb2-0bde-4ad4-8320-b5bcd0689110', 6, NULL, 'Waltz Reprise', 'Waltz Reprise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c82fcb2-0bde-4ad4-8320-b5bcd0689110'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Valse Lent', part.name_en = 'Valse Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3e9eff20-13fb-483e-992b-dd2685bb5d4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e9eff20-13fb-483e-992b-dd2685bb5d4d', 7, NULL, 'Valse Lent', 'Valse Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e9eff20-13fb-483e-992b-dd2685bb5d4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Closet', part.name_en = 'The Closet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:43f8c89a-ab6a-4847-93e0-52546b4b9c6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43f8c89a-ab6a-4847-93e0-52546b4b9c6b', 8, NULL, 'The Closet', 'The Closet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43f8c89a-ab6a-4847-93e0-52546b4b9c6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Miss Gravely Digs', part.name_en = 'Miss Gravely Digs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4b630dd3-1571-4109-a1a4-d8c681fa9ece' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b630dd3-1571-4109-a1a4-d8c681fa9ece', 9, NULL, 'Miss Gravely Digs', 'Miss Gravely Digs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b630dd3-1571-4109-a1a4-d8c681fa9ece'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Tea Time', part.name_en = 'Tea Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:51b1e559-9a99-438f-9af8-de22030deac7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51b1e559-9a99-438f-9af8-de22030deac7', 10, NULL, 'Tea Time', 'Tea Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51b1e559-9a99-438f-9af8-de22030deac7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Proposal', part.name_en = 'Proposal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:55980ea9-253b-4a19-8bbc-e5e8aee02cee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55980ea9-253b-4a19-8bbc-e5e8aee02cee', 11, NULL, 'Proposal', 'Proposal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55980ea9-253b-4a19-8bbc-e5e8aee02cee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Harvest Eve', part.name_en = 'Harvest Eve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:64e7c18f-ed06-4f46-8d4e-32b6aeb8356f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64e7c18f-ed06-4f46-8d4e-32b6aeb8356f', 12, NULL, 'Harvest Eve', 'Harvest Eve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64e7c18f-ed06-4f46-8d4e-32b6aeb8356f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Porch Talk', part.name_en = 'Porch Talk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:6e9f9d92-7dc9-4656-be90-6dbba27f53e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9f9d92-7dc9-4656-be90-6dbba27f53e9', 13, NULL, 'Porch Talk', 'Porch Talk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9f9d92-7dc9-4656-be90-6dbba27f53e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Walk', part.name_en = 'The Walk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:72b7b151-7fca-49b4-a684-83437e23ff71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72b7b151-7fca-49b4-a684-83437e23ff71', 14, NULL, 'The Walk', 'The Walk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b7b151-7fca-49b4-a684-83437e23ff71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The Sketch', part.name_en = 'The Sketch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:72ed6bde-70ec-4518-ab2b-1f99369abcb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72ed6bde-70ec-4518-ab2b-1f99369abcb8', 15, NULL, 'The Sketch', 'The Sketch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72ed6bde-70ec-4518-ab2b-1f99369abcb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Jennifer', part.name_en = 'Jennifer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8275a5cc-23a2-4e5f-8e5a-5df16f1254ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8275a5cc-23a2-4e5f-8e5a-5df16f1254ed', 16, NULL, 'Jennifer', 'Jennifer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8275a5cc-23a2-4e5f-8e5a-5df16f1254ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Suspicion', part.name_en = 'Suspicion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:84283759-216c-49e8-b584-07eef1b0d7ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84283759-216c-49e8-b584-07eef1b0d7ca', 17, NULL, 'Suspicion', 'Suspicion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84283759-216c-49e8-b584-07eef1b0d7ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Miss Gravely''s Test', part.name_en = 'Miss Gravely''s Test',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8532dddf-9987-44f4-9408-37b7b36f963f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8532dddf-9987-44f4-9408-37b7b36f963f', 18, NULL, 'Miss Gravely''s Test', 'Miss Gravely''s Test', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8532dddf-9987-44f4-9408-37b7b36f963f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'The Body', part.name_en = 'The Body',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:86d96ea9-8ecd-4b7a-9748-a687bc2d3648' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86d96ea9-8ecd-4b7a-9748-a687bc2d3648', 19, NULL, 'The Body', 'The Body', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86d96ea9-8ecd-4b7a-9748-a687bc2d3648'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Doctor''s Return', part.name_en = 'The Doctor''s Return',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:91098be0-fcfd-4c4c-915c-2fa6d742a798' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91098be0-fcfd-4c4c-915c-2fa6d742a798', 20, NULL, 'The Doctor''s Return', 'The Doctor''s Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91098be0-fcfd-4c4c-915c-2fa6d742a798'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'The Murder', part.name_en = 'The Murder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:990cedb5-071a-45ea-86b5-128728652bcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:990cedb5-071a-45ea-86b5-128728652bcd', 21, NULL, 'The Murder', 'The Murder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:990cedb5-071a-45ea-86b5-128728652bcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Autumn', part.name_en = 'Autumn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a216fccb-f25f-406b-856a-2776f729ecbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a216fccb-f25f-406b-856a-2776f729ecbe', 22, NULL, 'Autumn', 'Autumn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a216fccb-f25f-406b-856a-2776f729ecbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'The Wish', part.name_en = 'The Wish',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a8338881-ef20-4789-ad7d-4202ad70a0a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8338881-ef20-4789-ad7d-4202ad70a0a3', 23, NULL, 'The Wish', 'The Wish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8338881-ef20-4789-ad7d-4202ad70a0a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Ostinato', part.name_en = 'Ostinato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:a98f9d08-f65e-4722-9278-96d3493e38ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a98f9d08-f65e-4722-9278-96d3493e38ce', 24, NULL, 'Ostinato', 'Ostinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a98f9d08-f65e-4722-9278-96d3493e38ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Homebodies', part.name_en = 'Homebodies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:aaab5225-5f7a-4e5c-857b-d065a4ae5cf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaab5225-5f7a-4e5c-857b-d065a4ae5cf9', 25, NULL, 'Homebodies', 'Homebodies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaab5225-5f7a-4e5c-857b-d065a4ae5cf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Confession', part.name_en = 'Confession',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:acb5bf98-5f1c-4e71-aab8-04d2a4e44127' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acb5bf98-5f1c-4e71-aab8-04d2a4e44127', 26, NULL, 'Confession', 'Confession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acb5bf98-5f1c-4e71-aab8-04d2a4e44127'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'The Police', part.name_en = 'The Police',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ad8cf946-0bd0-4ac0-8679-9980646d6cc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad8cf946-0bd0-4ac0-8679-9980646d6cc0', 27, NULL, 'The Police', 'The Police', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad8cf946-0bd0-4ac0-8679-9980646d6cc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Duo', part.name_en = 'Duo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b96bac97-7987-4411-add5-d0682363629a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b96bac97-7987-4411-add5-d0682363629a', 28, NULL, 'Duo', 'Duo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b96bac97-7987-4411-add5-d0682363629a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'The Tramp', part.name_en = 'The Tramp',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c2914dd8-2d61-405e-ba3d-9dc79b670890' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2914dd8-2d61-405e-ba3d-9dc79b670890', 29, NULL, 'The Tramp', 'The Tramp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2914dd8-2d61-405e-ba3d-9dc79b670890'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'The Solution', part.name_en = 'The Solution',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c64467ed-8239-4e91-b9a9-8b991a58c409' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c64467ed-8239-4e91-b9a9-8b991a58c409', 30, NULL, 'The Solution', 'The Solution', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c64467ed-8239-4e91-b9a9-8b991a58c409'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'The Bathtub', part.name_en = 'The Bathtub',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:cf7a9a64-1677-47fe-ab77-a72d765bd916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf7a9a64-1677-47fe-ab77-a72d765bd916', 31, NULL, 'The Bathtub', 'The Bathtub', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf7a9a64-1677-47fe-ab77-a72d765bd916'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d279bfbf-57fa-4190-995a-12c4bc1f16a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d279bfbf-57fa-4190-995a-12c4bc1f16a4', 32, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d279bfbf-57fa-4190-995a-12c4bc1f16a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Slumber', part.name_en = 'Slumber',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:dba415a9-bc5b-48a3-bf0b-32ec0ebdd92e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dba415a9-bc5b-48a3-bf0b-32ec0ebdd92e', 33, NULL, 'Slumber', 'Slumber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dba415a9-bc5b-48a3-bf0b-32ec0ebdd92e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'The Burial', part.name_en = 'The Burial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e08812fb-ce40-4df0-ac8d-b3bb3355b504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e08812fb-ce40-4df0-ac8d-b3bb3355b504', 34, NULL, 'The Burial', 'The Burial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e08812fb-ce40-4df0-ac8d-b3bb3355b504'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Afterbeats', part.name_en = 'Afterbeats',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e6252310-ce7c-4d3d-a3c4-8a8e4eae3eaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6252310-ce7c-4d3d-a3c4-8a8e4eae3eaa', 35, NULL, 'Afterbeats', 'Afterbeats', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6252310-ce7c-4d3d-a3c4-8a8e4eae3eaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Encore', part.name_en = 'Encore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e88f0ca5-d950-4658-839b-2ea56a5ab24e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e88f0ca5-d950-4658-839b-2ea56a5ab24e', 36, NULL, 'Encore', 'Encore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e88f0ca5-d950-4658-839b-2ea56a5ab24e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'The Captain', part.name_en = 'The Captain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:eea83d8a-c8a0-4df5-b948-bba8ec06532f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eea83d8a-c8a0-4df5-b948-bba8ec06532f', 37, NULL, 'The Captain', 'The Captain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eea83d8a-c8a0-4df5-b948-bba8ec06532f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'The Doctor', part.name_en = 'The Doctor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f2d0001c-ac20-4128-b118-9151e4b596cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2d0001c-ac20-4128-b118-9151e4b596cd', 38, NULL, 'The Doctor', 'The Doctor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d0001c-ac20-4128-b118-9151e4b596cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Finale', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f9f16cef-dedf-42f8-9334-01df22392665' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9f16cef-dedf-42f8-9334-01df22392665', 39, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f16cef-dedf-42f8-9334-01df22392665'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'The Cup', part.name_en = 'The Cup',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8797 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fe1adb00-e157-44fb-a90d-61728d9752ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe1adb00-e157-44fb-a90d-61728d9752ae', 40, NULL, 'The Cup', 'The Cup', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8797 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe1adb00-e157-44fb-a90d-61728d9752ae'
);


-- None Whitman

UPDATE pieces piece
SET piece.title = 'Whitman', piece.title_en = 'Whitman',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9899 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = 'Listen, Listen', part.name_en = 'Whitman: IV. Listen, Listen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:14fc9a0c-d20f-46cf-8c96-4650c0088b48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14fc9a0c-d20f-46cf-8c96-4650c0088b48', 1, 'IV', 'Listen, Listen', 'Whitman: IV. Listen, Listen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14fc9a0c-d20f-46cf-8c96-4650c0088b48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'X',
    part.name_ko = 'War', part.name_en = 'Whitman: X. War',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2f2b9831-7572-4d92-8a24-d8d9f7d17cea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f2b9831-7572-4d92-8a24-d8d9f7d17cea', 2, 'X', 'War', 'Whitman: X. War', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f2b9831-7572-4d92-8a24-d8d9f7d17cea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Perpetual Journey', part.name_en = 'Whitman: III. Perpetual Journey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:37d7a708-0db6-4c6b-9915-cc6512792134' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37d7a708-0db6-4c6b-9915-cc6512792134', 3, 'III', 'Perpetual Journey', 'Whitman: III. Perpetual Journey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37d7a708-0db6-4c6b-9915-cc6512792134'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'XI',
    part.name_ko = 'Ships', part.name_en = 'Whitman: XI. Ships',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:54df037d-27b3-4aff-8e3f-bf6bbb8582c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54df037d-27b3-4aff-8e3f-bf6bbb8582c5', 4, 'XI', 'Ships', 'Whitman: XI. Ships', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54df037d-27b3-4aff-8e3f-bf6bbb8582c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'XIII',
    part.name_ko = 'Finale', part.name_en = 'Whitman: XIII. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:97ada8d9-36df-4e61-91fb-0ff3f7f34a6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97ada8d9-36df-4e61-91fb-0ff3f7f34a6d', 5, 'XIII', 'Finale', 'Whitman: XIII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97ada8d9-36df-4e61-91fb-0ff3f7f34a6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'IX',
    part.name_ko = 'Battle', part.name_en = 'Whitman: IX. Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:99c9d8e0-2e82-4d75-8f64-b05b9e198e21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99c9d8e0-2e82-4d75-8f64-b05b9e198e21', 6, 'IX', 'Battle', 'Whitman: IX. Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99c9d8e0-2e82-4d75-8f64-b05b9e198e21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'XII',
    part.name_ko = 'Divinity', part.name_en = 'Whitman: XII. Divinity',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:aded5b2a-8c05-4fc3-9953-0dcd8c2f6d68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aded5b2a-8c05-4fc3-9953-0dcd8c2f6d68', 7, 'XII', 'Divinity', 'Whitman: XII. Divinity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aded5b2a-8c05-4fc3-9953-0dcd8c2f6d68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'Whitman: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b2235ec6-b03b-47d2-b4d0-24973eb75409' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2235ec6-b03b-47d2-b4d0-24973eb75409', 8, 'I', 'Introduction', 'Whitman: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2235ec6-b03b-47d2-b4d0-24973eb75409'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'V',
    part.name_ko = 'Cosmos', part.name_en = 'Whitman: V. Cosmos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c5724b1d-bcb9-4700-96f8-04cc77c1cd2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5724b1d-bcb9-4700-96f8-04cc77c1cd2c', 9, 'V', 'Cosmos', 'Whitman: V. Cosmos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5724b1d-bcb9-4700-96f8-04cc77c1cd2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'VIII',
    part.name_ko = 'Miracles', part.name_en = 'Whitman: VIII. Miracles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d3c1f018-7d71-4c29-9370-b89cac1f12c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3c1f018-7d71-4c29-9370-b89cac1f12c3', 10, 'VIII', 'Miracles', 'Whitman: VIII. Miracles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3c1f018-7d71-4c29-9370-b89cac1f12c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'VI',
    part.name_ko = 'Song', part.name_en = 'Whitman: VI. Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e1a28e2e-bff2-41ed-bd68-bc9827dea325' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1a28e2e-bff2-41ed-bd68-bc9827dea325', 11, 'VI', 'Song', 'Whitman: VI. Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1a28e2e-bff2-41ed-bd68-bc9827dea325'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'VII',
    part.name_ko = 'Oath', part.name_en = 'Whitman: VII. Oath',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f2430025-e94d-484d-a93f-4a50f2abbefc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2430025-e94d-484d-a93f-4a50f2abbefc', 12, 'VII', 'Oath', 'Whitman: VII. Oath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2430025-e94d-484d-a93f-4a50f2abbefc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'II',
    part.name_ko = 'Welcome', part.name_en = 'Whitman: II. Welcome',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9899 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:fe6cf823-775b-40d9-8dd4-e3fa320df001' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe6cf823-775b-40d9-8dd4-e3fa320df001', 13, 'II', 'Welcome', 'Whitman: II. Welcome', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9899 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe6cf823-775b-40d9-8dd4-e3fa320df001'
);


-- None 오페라 <Wuthering Heights>

UPDATE pieces piece
SET piece.title = '오페라 <Wuthering Heights>', piece.title_en = 'Wuthering Heights',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9879 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Wuthering Heights: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9879 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1fe4bd3e-3377-41ef-a76e-89d1df8e0863' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fe4bd3e-3377-41ef-a76e-89d1df8e0863', 1, NULL, 'Prologue', 'Wuthering Heights: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9879 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fe4bd3e-3377-41ef-a76e-89d1df8e0863'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Wuthering Heights: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9879 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4e1c9ed8-bb2b-48a7-83c2-8609b0758cc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e1c9ed8-bb2b-48a7-83c2-8609b0758cc8', 2, NULL, 'Act I', 'Wuthering Heights: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9879 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e1c9ed8-bb2b-48a7-83c2-8609b0758cc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Wuthering Heights: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9879 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:cd2d2f60-ac44-497b-ac2f-8958b48cf9ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd2d2f60-ac44-497b-ac2f-8958b48cf9ce', 3, NULL, 'Act II', 'Wuthering Heights: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9879 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd2d2f60-ac44-497b-ac2f-8958b48cf9ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Wuthering Heights: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9879 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:c6e2b702-67f9-445d-8058-fa93c4c1bf62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6e2b702-67f9-445d-8058-fa93c4c1bf62', 4, NULL, 'Act III', 'Wuthering Heights: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9879 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6e2b702-67f9-445d-8058-fa93c4c1bf62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act IV', part.name_en = 'Wuthering Heights: Act IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9879 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:683a9952-0d5d-4388-9d79-12431adf657f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:683a9952-0d5d-4388-9d79-12431adf657f', 5, NULL, 'Act IV', 'Wuthering Heights: Act IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9879 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:683a9952-0d5d-4388-9d79-12431adf657f'
);


-- None 엘레지

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘레지', 'Elegy', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘레지'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73a094ac-9ce6-3f91-81cc-d5cbad053373'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '73a094ac-9ce6-3f91-81cc-d5cbad053373'
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73a094ac-9ce6-3f91-81cc-d5cbad053373'
);


-- None 녹턴

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴', 'Nocturne', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '964f331b-8bc9-4119-b50c-98d3dd4511dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '964f331b-8bc9-4119-b50c-98d3dd4511dd'
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '녹턴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '964f331b-8bc9-4119-b50c-98d3dd4511dd'
);


-- None 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡', 'Overture', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f98c496-6fc5-4c35-9d39-bdacdb6731b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f98c496-6fc5-4c35-9d39-bdacdb6731b8'
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '서곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f98c496-6fc5-4c35-9d39-bdacdb6731b8'
);


-- None 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡', 'Prelude', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75a013af-eb2e-4227-adcf-4c9c4884c0c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75a013af-eb2e-4227-adcf-4c9c4884c0c0'
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75a013af-eb2e-4227-adcf-4c9c4884c0c0'
);


-- None 신포니에타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니에타', 'Sinfonietta', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니에타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08aad746-4137-4e07-a1be-79ad3fd5ae5c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08aad746-4137-4e07-a1be-79ad3fd5ae5c'
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '신포니에타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08aad746-4137-4e07-a1be-79ad3fd5ae5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4aa332c4-8035-4e36-b27e-bde00ed9cacc', 1, 'I', 'Prelude: Slowly', 'Sinfonietta: I. Prelude: Slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '신포니에타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aa332c4-8035-4e36-b27e-bde00ed9cacc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06d6a77c-08cf-41ca-a2c4-901e84181427', 2, 'II', 'Scherzo: Presto', 'Sinfonietta: II. Scherzo: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '신포니에타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06d6a77c-08cf-41ca-a2c4-901e84181427'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f30ff19-2f25-4398-986c-521786d041a2', 3, 'III', 'Adagio', 'Sinfonietta: III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '신포니에타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f30ff19-2f25-4398-986c-521786d041a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76e7a7c6-93ce-479c-8c06-3d72f8f2e031', 4, 'IV', 'Interlude: Largo', 'Sinfonietta: IV. Interlude: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '신포니에타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76e7a7c6-93ce-479c-8c06-3d72f8f2e031'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea9b6193-ac1c-4b8e-995a-1d8826e47481', 5, 'V', 'Variations', 'Sinfonietta: V. Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '신포니에타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea9b6193-ac1c-4b8e-995a-1d8826e47481'
);


-- None Vertigo Suite

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Vertigo Suite', 'Vertigo Suite', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Vertigo Suite'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13fa8d3e-5608-457c-b610-d60a222d3075'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13fa8d3e-5608-457c-b610-d60a222d3075'
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Vertigo Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13fa8d3e-5608-457c-b610-d60a222d3075'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b3fcd59-eeca-4c2f-84b5-7e040b8148c8', 1, 'V', 'Scene d’Amour', 'Vertigo Suite: V. Scene d’Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Vertigo Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b3fcd59-eeca-4c2f-84b5-7e040b8148c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f444bfe-ef47-4877-8099-94c1310e2180', 2, 'III', 'Carlotta''s Portrait', 'Vertigo Suite: III. Carlotta''s Portrait', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Vertigo Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f444bfe-ef47-4877-8099-94c1310e2180'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b10411a-49f5-4393-84aa-d8507f4f8436', 3, 'II', 'The Nightmare', 'Vertigo Suite: II. The Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Vertigo Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b10411a-49f5-4393-84aa-d8507f4f8436'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:692c5ff5-7756-4c22-8493-864fe57771f2', 4, 'I', 'Prelude', 'Vertigo Suite: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Vertigo Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:692c5ff5-7756-4c22-8493-864fe57771f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afc45eab-c92d-40af-8b3c-3e3b69d08fc3', 5, 'IV', 'Scotty Trails Madeline', 'Vertigo Suite: IV. Scotty Trails Madeline', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Vertigo Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afc45eab-c92d-40af-8b3c-3e3b69d08fc3'
);


-- None The Twilight Zone

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Twilight Zone', 'The Twilight Zone', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Twilight Zone'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f635a83b-f61a-3af6-8106-ca02e88d738f', 1, NULL, 'Main Title', 'Main Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f635a83b-f61a-3af6-8106-ca02e88d738f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8258 AND linked.composer_id = 112), 'musicbrainz:26972924-6dd3-3758-baad-6cf0858f8f91', 2, NULL, 'Where Is Everybody? / The Man', 'Where Is Everybody? / The Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26972924-6dd3-3758-baad-6cf0858f8f91'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Where Is Everybody? / The Man"', piece.title_en = 'The Twilight Zone: Where Is Everybody? / The Man', piece.editor_locked = 1
WHERE piece.id = 8258 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd5b11da-c4b8-3375-8cf5-709cda483c14', 3, NULL, 'The Door', 'The Door', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd5b11da-c4b8-3375-8cf5-709cda483c14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8975 AND linked.composer_id = 112), 'musicbrainz:587ae8c1-b44e-368e-958d-becdfd30b38e', 4, NULL, 'The Truck', 'The Truck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:587ae8c1-b44e-368e-958d-becdfd30b38e'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Truck"', piece.title_en = 'The Twilight Zone: The Truck', piece.editor_locked = 1
WHERE piece.id = 8975 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9726 AND linked.composer_id = 112), 'musicbrainz:8dbc84b8-c199-3ddc-91a0-9cd1e771f41c', 5, NULL, 'The Telephone', 'The Telephone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dbc84b8-c199-3ddc-91a0-9cd1e771f41c'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Telephone"', piece.title_en = 'The Twilight Zone: The Telephone', piece.editor_locked = 1
WHERE piece.id = 9726 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eba3eb7b-b28e-3da8-ad14-c2ec1412b39b', 6, NULL, 'The Phone Booth', 'The Phone Booth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eba3eb7b-b28e-3da8-ad14-c2ec1412b39b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9476 AND linked.composer_id = 112), 'musicbrainz:7b57c829-db4d-3155-9e95-08e169b19df1', 7, NULL, 'The Stationhouse', 'The Stationhouse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b57c829-db4d-3155-9e95-08e169b19df1'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Stationhouse"', piece.title_en = 'The Twilight Zone: The Stationhouse', piece.editor_locked = 1
WHERE piece.id = 9476 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9040 AND linked.composer_id = 112), 'musicbrainz:5c903cb3-9632-3983-b013-e9f20b1336b7', 8, NULL, 'The Cell', 'The Cell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c903cb3-9632-3983-b013-e9f20b1336b7'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Cell"', piece.title_en = 'The Twilight Zone: The Cell', piece.editor_locked = 1
WHERE piece.id = 9040 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7967 AND linked.composer_id = 112), 'musicbrainz:0ffc7a1c-5f90-3c7c-8279-ac8aa49434a1', 9, NULL, 'The Sun', 'The Sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ffc7a1c-5f90-3c7c-8279-ac8aa49434a1'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Sun"', piece.title_en = 'The Twilight Zone: The Sun', piece.editor_locked = 1
WHERE piece.id = 7967 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22584a35-25dc-35cd-ba8a-a0e51afbe3cf', 10, NULL, 'The Mirror', 'The Mirror', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22584a35-25dc-35cd-ba8a-a0e51afbe3cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8244 AND linked.composer_id = 112), 'musicbrainz:253446a6-dcd9-3b55-ad65-38eeb2052cb7', 11, NULL, 'The Bookrack', 'The Bookrack', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:253446a6-dcd9-3b55-ad65-38eeb2052cb7'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Bookrack"', piece.title_en = 'The Twilight Zone: The Bookrack', piece.editor_locked = 1
WHERE piece.id = 8244 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10171 AND linked.composer_id = 112), 'musicbrainz:ad8912a7-48df-3d1b-b006-fb4dbde0787d', 12, NULL, 'The Lights', 'The Lights', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad8912a7-48df-3d1b-b006-fb4dbde0787d'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Lights"', piece.title_en = 'The Twilight Zone: The Lights', piece.editor_locked = 1
WHERE piece.id = 10171 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f93d3669-6a55-3165-9634-f6a1a278611a', 13, NULL, 'The Film', 'The Film', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f93d3669-6a55-3165-9634-f6a1a278611a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9129 AND linked.composer_id = 112), 'musicbrainz:63149079-a397-3f42-adf7-47e2215482a3', 14, NULL, 'The Bicycle', 'The Bicycle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63149079-a397-3f42-adf7-47e2215482a3'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Bicycle"', piece.title_en = 'The Twilight Zone: The Bicycle', piece.editor_locked = 1
WHERE piece.id = 9129 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8001 AND linked.composer_id = 112), 'musicbrainz:11e04184-62fd-36f7-af62-33023771788a', 15, NULL, 'The Breakdown', 'The Breakdown', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11e04184-62fd-36f7-af62-33023771788a'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Breakdown"', piece.title_en = 'The Twilight Zone: The Breakdown', piece.editor_locked = 1
WHERE piece.id = 8001 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10895 AND linked.composer_id = 112), 'musicbrainz:e485af44-260b-39d6-9eb0-efb9ed778c56', 16, NULL, 'The Button', 'The Button', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e485af44-260b-39d6-9eb0-efb9ed778c56'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Button"', piece.title_en = 'The Twilight Zone: The Button', piece.editor_locked = 1
WHERE piece.id = 10895 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8803 AND linked.composer_id = 112), 'musicbrainz:4d2ae2be-f6ae-3145-96e6-2a6aac02752e', 17, NULL, 'Finale and Credits', 'Finale and Credits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d2ae2be-f6ae-3145-96e6-2a6aac02752e'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Finale and Credits"', piece.title_en = 'The Twilight Zone: Finale and Credits', piece.editor_locked = 1
WHERE piece.id = 8803 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11019 AND linked.composer_id = 112), 'musicbrainz:ecb3dc52-6089-3a4e-b4d5-1a588b1f95e9', 18, NULL, 'Walking Distance / Intro', 'Walking Distance / Intro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecb3dc52-6089-3a4e-b4d5-1a588b1f95e9'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Walking Distance / Intro"', piece.title_en = 'The Twilight Zone: Walking Distance / Intro', piece.editor_locked = 1
WHERE piece.id = 11019 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9547 AND linked.composer_id = 112), 'musicbrainz:8073d4b7-7804-3022-baa6-1a08b61345ba', 19, NULL, 'The Drugstore', 'The Drugstore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8073d4b7-7804-3022-baa6-1a08b61345ba'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Drugstore"', piece.title_en = 'The Twilight Zone: The Drugstore', piece.editor_locked = 1
WHERE piece.id = 9547 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9031 AND linked.composer_id = 112), 'musicbrainz:5bcf65e1-b594-3df7-9e59-beba5cfb1fb9', 20, NULL, 'Memories', 'Memories', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bcf65e1-b594-3df7-9e59-beba5cfb1fb9'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Memories"', piece.title_en = 'The Twilight Zone: Memories', piece.editor_locked = 1
WHERE piece.id = 9031 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae1515f8-33c5-3ddb-927b-c50aadf32f0a', 21, NULL, 'The Park', 'The Park', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae1515f8-33c5-3ddb-927b-c50aadf32f0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4ab636f-b433-3c4b-8200-f174561562ea', 22, NULL, 'The House', 'The House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4ab636f-b433-3c4b-8200-f174561562ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72dde9a1-31fe-3cbd-8b90-93618b704fb6', 23, NULL, 'The Curtain', 'The Curtain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72dde9a1-31fe-3cbd-8b90-93618b704fb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9858 AND linked.composer_id = 112), 'musicbrainz:97b727be-d192-3479-871f-5fb547b5acff', 24, NULL, 'The Parents', 'The Parents', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97b727be-d192-3479-871f-5fb547b5acff'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Parents"', piece.title_en = 'The Twilight Zone: The Parents', piece.editor_locked = 1
WHERE piece.id = 9858 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10622 AND linked.composer_id = 112), 'musicbrainz:cf531f59-0e58-34ea-b7cd-58f328dce115', 25, NULL, 'The Merry-go-round', 'The Merry-go-round', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf531f59-0e58-34ea-b7cd-58f328dce115'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Merry-go-round"', piece.title_en = 'The Twilight Zone: The Merry-go-round', piece.editor_locked = 1
WHERE piece.id = 10622 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8037 AND linked.composer_id = 112), 'musicbrainz:1420f392-7077-3a5b-9034-45b53e2d872a', 26, NULL, 'Martin''s Summer', 'Martin''s Summer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1420f392-7077-3a5b-9034-45b53e2d872a'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Martin''s Summer"', piece.title_en = 'The Twilight Zone: Martin''s Summer', piece.editor_locked = 1
WHERE piece.id = 8037 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73a094ac-9ce6-3f91-81cc-d5cbad053373', 27, NULL, 'Elegy', 'Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73a094ac-9ce6-3f91-81cc-d5cbad053373'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:887301bb-cc1a-3961-adae-14afe5a0b499', 28, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:887301bb-cc1a-3961-adae-14afe5a0b499'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9062 AND linked.composer_id = 112), 'musicbrainz:5e06ca1e-115a-356a-9ab5-e07877a14114', 29, NULL, 'The Lonely / Twilight Zone Theme', 'The Lonely / Twilight Zone Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e06ca1e-115a-356a-9ab5-e07877a14114'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Lonely / Twilight Zone Theme"', piece.title_en = 'The Twilight Zone: The Lonely / Twilight Zone Theme', piece.editor_locked = 1
WHERE piece.id = 9062 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9950 AND linked.composer_id = 112), 'musicbrainz:9d9fb354-73db-3501-970e-5e168acf2a43', 30, NULL, 'Intro', 'Intro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d9fb354-73db-3501-970e-5e168acf2a43'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Intro"', piece.title_en = 'The Twilight Zone: Intro', piece.editor_locked = 1
WHERE piece.id = 9950 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10550 AND linked.composer_id = 112), 'musicbrainz:ca1ce7f3-e684-323f-87a6-adc75d6461b9', 31, NULL, 'The Waiting', 'The Waiting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca1ce7f3-e684-323f-87a6-adc75d6461b9'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Waiting"', piece.title_en = 'The Twilight Zone: The Waiting', piece.editor_locked = 1
WHERE piece.id = 10550 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10943 AND linked.composer_id = 112), 'musicbrainz:e7c38538-4a1d-336e-a46a-dd4ad9dff162', 32, NULL, 'The Box', 'The Box', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7c38538-4a1d-336e-a46a-dd4ad9dff162'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Box"', piece.title_en = 'The Twilight Zone: The Box', piece.editor_locked = 1
WHERE piece.id = 10943 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10554 AND linked.composer_id = 112), 'musicbrainz:ca5739f3-8bd8-33c8-a584-db09eeedc507', 33, NULL, 'Alicia', 'Alicia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca5739f3-8bd8-33c8-a584-db09eeedc507'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Alicia"', piece.title_en = 'The Twilight Zone: Alicia', piece.editor_locked = 1
WHERE piece.id = 10554 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9819 AND linked.composer_id = 112), 'musicbrainz:9435eb1c-6f4d-3a10-b266-e524d2f8d2f4', 34, NULL, 'Mockery', 'Mockery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9435eb1c-6f4d-3a10-b266-e524d2f8d2f4'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Mockery"', piece.title_en = 'The Twilight Zone: Mockery', piece.editor_locked = 1
WHERE piece.id = 9819 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9358 AND linked.composer_id = 112), 'musicbrainz:7378dceb-bb23-39a9-a1f7-6d0aeee45c1c', 35, NULL, 'Eleven Months', 'Eleven Months', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7378dceb-bb23-39a9-a1f7-6d0aeee45c1c'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Eleven Months"', piece.title_en = 'The Twilight Zone: Eleven Months', piece.editor_locked = 1
WHERE piece.id = 9358 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9246 AND linked.composer_id = 112), 'musicbrainz:6bebc15c-a648-384c-839c-42b3d634dfb2', 36, NULL, 'The Stars', 'The Stars', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bebc15c-a648-384c-839c-42b3d634dfb2'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Stars"', piece.title_en = 'The Twilight Zone: The Stars', piece.editor_locked = 1
WHERE piece.id = 9246 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9208 AND linked.composer_id = 112), 'musicbrainz:69a39f1c-e94a-32a0-9b9c-fb2c20a85b0e', 37, NULL, 'Fear', 'Fear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69a39f1c-e94a-32a0-9b9c-fb2c20a85b0e'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Fear"', piece.title_en = 'The Twilight Zone: Fear', piece.editor_locked = 1
WHERE piece.id = 9208 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f07eac64-f4e5-39d8-85c6-d2c0869ce693', 38, NULL, 'Farewell', 'Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f07eac64-f4e5-39d8-85c6-d2c0869ce693'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17b6c856-3138-31e6-b21d-9d42117cd120', 39, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17b6c856-3138-31e6-b21d-9d42117cd120'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9774 AND linked.composer_id = 112), 'musicbrainz:91129d66-5c37-3a6e-936e-666a4abd818b', 40, NULL, 'Eye of the Beholders / Twilight Zone Theme (2nd Revision)', 'Eye of the Beholders / Twilight Zone Theme (2nd Revision)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91129d66-5c37-3a6e-936e-666a4abd818b'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Eye of the Beholders / Twilight Zone Theme (2nd Revision)"', piece.title_en = 'The Twilight Zone: Eye of the Beholders / Twilight Zone Theme (2nd Revision)', piece.editor_locked = 1
WHERE piece.id = 9774 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8819 AND linked.composer_id = 112), 'musicbrainz:4e6625ad-2083-3cfc-8242-c852e533e8d4', 41, NULL, 'Patience', 'Patience', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e6625ad-2083-3cfc-8242-c852e533e8d4'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Patience"', piece.title_en = 'The Twilight Zone: Patience', piece.editor_locked = 1
WHERE piece.id = 8819 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9148 AND linked.composer_id = 112), 'musicbrainz:643052a7-0265-3205-ac27-7690310d11d2', 42, NULL, 'The Nurse', 'The Nurse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:643052a7-0265-3205-ac27-7690310d11d2'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Nurse"', piece.title_en = 'The Twilight Zone: The Nurse', piece.editor_locked = 1
WHERE piece.id = 9148 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9773 AND linked.composer_id = 112), 'musicbrainz:9109e33a-6e8f-3bfb-b12d-21fddd6ec5cb', 43, NULL, 'The Hospital', 'The Hospital', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9109e33a-6e8f-3bfb-b12d-21fddd6ec5cb'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Hospital"', piece.title_en = 'The Twilight Zone: The Hospital', piece.editor_locked = 1
WHERE piece.id = 9773 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1b9ca51-f2ee-3976-b930-9cdb9a77446a', 44, NULL, 'The Doctor', 'The Doctor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1b9ca51-f2ee-3976-b930-9cdb9a77446a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8237 AND linked.composer_id = 112), 'musicbrainz:24a4b7c4-a99c-3762-bccf-7220469b3c55', 45, NULL, 'The Plea', 'The Plea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24a4b7c4-a99c-3762-bccf-7220469b3c55'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Plea"', piece.title_en = 'The Twilight Zone: The Plea', piece.editor_locked = 1
WHERE piece.id = 8237 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9864 AND linked.composer_id = 112), 'musicbrainz:98885248-3830-33ed-8d33-748c37821723', 46, NULL, 'Lead In', 'Lead In', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98885248-3830-33ed-8d33-748c37821723'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Lead In"', piece.title_en = 'The Twilight Zone: Lead In', piece.editor_locked = 1
WHERE piece.id = 9864 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8681 AND linked.composer_id = 112), 'musicbrainz:443dee12-a7a2-3ac5-97f8-d97d55e8e062', 47, NULL, 'Declaration', 'Declaration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:443dee12-a7a2-3ac5-97f8-d97d55e8e062'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Declaration"', piece.title_en = 'The Twilight Zone: Declaration', piece.editor_locked = 1
WHERE piece.id = 8681 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8342 AND linked.composer_id = 112), 'musicbrainz:2c867bb6-08bf-3257-a534-f8f104c04a23', 48, NULL, 'The Bandage', 'The Bandage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c867bb6-08bf-3257-a534-f8f104c04a23'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Bandage"', piece.title_en = 'The Twilight Zone: The Bandage', piece.editor_locked = 1
WHERE piece.id = 8342 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10122 AND linked.composer_id = 112), 'musicbrainz:a9e7ec94-14cc-3600-ad53-cd38f986d305', 49, NULL, 'The Last Bandage', 'The Last Bandage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9e7ec94-14cc-3600-ad53-cd38f986d305'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Last Bandage"', piece.title_en = 'The Twilight Zone: The Last Bandage', piece.editor_locked = 1
WHERE piece.id = 10122 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10626 AND linked.composer_id = 112), 'musicbrainz:cff1c129-5407-3e41-8613-35e198c1e76a', 50, NULL, 'Hysteria', 'Hysteria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cff1c129-5407-3e41-8613-35e198c1e76a'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Hysteria"', piece.title_en = 'The Twilight Zone: Hysteria', piece.editor_locked = 1
WHERE piece.id = 10626 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7988 AND linked.composer_id = 112), 'musicbrainz:1141418d-bcc3-3499-b607-1e7949bc3fd8', 51, NULL, 'The Revelation', 'The Revelation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1141418d-bcc3-3499-b607-1e7949bc3fd8'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "The Revelation"', piece.title_en = 'The Twilight Zone: The Revelation', piece.editor_locked = 1
WHERE piece.id = 7988 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7b034e8-be22-380e-a30c-05edda72b1d0', 52, NULL, 'End Title', 'End Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7b034e8-be22-380e-a30c-05edda72b1d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9417 AND linked.composer_id = 112), 'musicbrainz:778f08cf-5c47-4fe9-b990-08fb8461a559', 53, NULL, 'New Twilight Zone Theme Opening', 'New Twilight Zone Theme Opening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:778f08cf-5c47-4fe9-b990-08fb8461a559'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "New Twilight Zone Theme Opening"', piece.title_en = 'The Twilight Zone: New Twilight Zone Theme Opening', piece.editor_locked = 1
WHERE piece.id = 9417 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8550 AND linked.composer_id = 112), 'musicbrainz:3a3dfc8b-97f9-429e-a5f9-f9056887b821', 54, NULL, 'Little Girl Lost / Where Are You?', 'Little Girl Lost / Where Are You?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a3dfc8b-97f9-429e-a5f9-f9056887b821'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Little Girl Lost / Where Are You?"', piece.title_en = 'The Twilight Zone: Little Girl Lost / Where Are You?', piece.editor_locked = 1
WHERE piece.id = 8550 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d392657b-a1f8-424d-a6c1-dada1bcee69d', 55, NULL, 'Gone', 'Gone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d392657b-a1f8-424d-a6c1-dada1bcee69d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7943 AND linked.composer_id = 112), 'musicbrainz:0e5b9007-9b78-45ef-8979-acf60e8d7cdd', 56, NULL, 'Emptiness', 'Emptiness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e5b9007-9b78-45ef-8979-acf60e8d7cdd'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Emptiness"', piece.title_en = 'The Twilight Zone: Emptiness', piece.editor_locked = 1
WHERE piece.id = 7943 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8096 AND linked.composer_id = 112), 'musicbrainz:18a6b0c6-12a2-4a27-9753-fc1910d02d68', 57, NULL, 'Dog Gone', 'Dog Gone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18a6b0c6-12a2-4a27-9753-fc1910d02d68'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Dog Gone"', piece.title_en = 'The Twilight Zone: Dog Gone', piece.editor_locked = 1
WHERE piece.id = 8096 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8391 AND linked.composer_id = 112), 'musicbrainz:2fdc9442-8591-4737-8295-f6c1fe82a0ac', 58, NULL, 'Hole in Wall', 'Hole in Wall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fdc9442-8591-4737-8295-f6c1fe82a0ac'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Hole in Wall"', piece.title_en = 'The Twilight Zone: Hole in Wall', piece.editor_locked = 1
WHERE piece.id = 8391 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8073 AND linked.composer_id = 112), 'musicbrainz:16df322a-4c79-422c-9498-0c06862fea5a', 59, NULL, 'Third Dimension', 'Third Dimension', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16df322a-4c79-422c-9498-0c06862fea5a'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Third Dimension"', piece.title_en = 'The Twilight Zone: Third Dimension', piece.editor_locked = 1
WHERE piece.id = 8073 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10020 AND linked.composer_id = 112), 'musicbrainz:a2b83ab2-61d0-4b74-9d3a-61a6a9cdf06e', 60, NULL, 'Coin Disappears', 'Coin Disappears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2b83ab2-61d0-4b74-9d3a-61a6a9cdf06e'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Coin Disappears"', piece.title_en = 'The Twilight Zone: Coin Disappears', piece.editor_locked = 1
WHERE piece.id = 10020 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8799 AND linked.composer_id = 112), 'musicbrainz:4d086496-7766-4bfb-81c4-7df1f669703a', 61, NULL, 'Move Around', 'Move Around', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d086496-7766-4bfb-81c4-7df1f669703a'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Move Around"', piece.title_en = 'The Twilight Zone: Move Around', piece.editor_locked = 1
WHERE piece.id = 8799 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10046 AND linked.composer_id = 112), 'musicbrainz:a44ef38d-dc7a-4161-aa6b-75e6b39213cd', 62, NULL, 'Look for Her', 'Look for Her', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a44ef38d-dc7a-4161-aa6b-75e6b39213cd'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Look for Her"', piece.title_en = 'The Twilight Zone: Look for Her', piece.editor_locked = 1
WHERE piece.id = 10046 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8807 AND linked.composer_id = 112), 'musicbrainz:4d604059-f073-4e47-8e3e-08d7a6acf518', 63, NULL, 'Fourth Dimension', 'Fourth Dimension', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d604059-f073-4e47-8e3e-08d7a6acf518'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Fourth Dimension"', piece.title_en = 'The Twilight Zone: Fourth Dimension', piece.editor_locked = 1
WHERE piece.id = 8807 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9680 AND linked.composer_id = 112), 'musicbrainz:8a35b613-a0bb-4374-a1a3-12e78e61f36e', 64, NULL, 'Half in Zone', 'Half in Zone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a35b613-a0bb-4374-a1a3-12e78e61f36e'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Half in Zone"', piece.title_en = 'The Twilight Zone: Half in Zone', piece.editor_locked = 1
WHERE piece.id = 9680 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8648 AND linked.composer_id = 112), 'musicbrainz:424deb6c-5a77-4f9f-b7c0-df0e2bbd3b30', 65, NULL, 'Living Doll / Tina Arrives', 'Living Doll / Tina Arrives', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:424deb6c-5a77-4f9f-b7c0-df0e2bbd3b30'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Living Doll / Tina Arrives"', piece.title_en = 'The Twilight Zone: Living Doll / Tina Arrives', piece.editor_locked = 1
WHERE piece.id = 8648 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10147 AND linked.composer_id = 112), 'musicbrainz:ac0422cc-cc16-4125-9438-3881c5242805', 66, NULL, 'Tina Talks', 'Tina Talks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac0422cc-cc16-4125-9438-3881c5242805'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Tina Talks"', piece.title_en = 'The Twilight Zone: Tina Talks', piece.editor_locked = 1
WHERE piece.id = 10147 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10044 AND linked.composer_id = 112), 'musicbrainz:a42c1960-a835-41f9-bfb5-cedc1b4057b4', 67, NULL, 'Eric Throws the Doll', 'Eric Throws the Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a42c1960-a835-41f9-bfb5-cedc1b4057b4'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Eric Throws the Doll"', piece.title_en = 'The Twilight Zone: Eric Throws the Doll', piece.editor_locked = 1
WHERE piece.id = 10044 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9403 AND linked.composer_id = 112), 'musicbrainz:76a46266-10d8-4a4f-923d-841ee0d0470b', 68, NULL, 'Supper', 'Supper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76a46266-10d8-4a4f-923d-841ee0d0470b'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Supper"', piece.title_en = 'The Twilight Zone: Supper', piece.editor_locked = 1
WHERE piece.id = 9403 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9982 AND linked.composer_id = 112), 'musicbrainz:a04dd2c7-3725-42ff-8729-6b7a90ea1031', 69, NULL, 'Tina Talks Again', 'Tina Talks Again', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a04dd2c7-3725-42ff-8729-6b7a90ea1031'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Tina Talks Again"', piece.title_en = 'The Twilight Zone: Tina Talks Again', piece.editor_locked = 1
WHERE piece.id = 9982 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10379 AND linked.composer_id = 112), 'musicbrainz:bd24a695-a187-4e5d-a80f-e823c3df0366', 70, NULL, 'Tina Threatens', 'Tina Threatens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd24a695-a187-4e5d-a80f-e823c3df0366'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Tina Threatens"', piece.title_en = 'The Twilight Zone: Tina Threatens', piece.editor_locked = 1
WHERE piece.id = 10379 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11143 AND linked.composer_id = 112), 'musicbrainz:f635e30c-0040-4932-bd8b-70dfc5425a72', 71, NULL, 'In the Cellar', 'In the Cellar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f635e30c-0040-4932-bd8b-70dfc5425a72'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "In the Cellar"', piece.title_en = 'The Twilight Zone: In the Cellar', piece.editor_locked = 1
WHERE piece.id = 11143 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8062 AND linked.composer_id = 112), 'musicbrainz:15ffdc3c-50e3-4ab1-b9c7-720604178123', 72, NULL, 'I''m Going to Kill You', 'I''m Going to Kill You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15ffdc3c-50e3-4ab1-b9c7-720604178123'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "I''m Going to Kill You"', piece.title_en = 'The Twilight Zone: I''m Going to Kill You', piece.editor_locked = 1
WHERE piece.id = 8062 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8005 AND linked.composer_id = 112), 'musicbrainz:12365130-56be-486b-96cd-5737c963471f', 73, NULL, 'Talking Doll', 'Talking Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12365130-56be-486b-96cd-5737c963471f'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Talking Doll"', piece.title_en = 'The Twilight Zone: Talking Doll', piece.editor_locked = 1
WHERE piece.id = 8005 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10035 AND linked.composer_id = 112), 'musicbrainz:a3b09ad8-d7f1-4382-9efd-40e9871a4fba', 74, NULL, 'Tina Disappears', 'Tina Disappears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3b09ad8-d7f1-4382-9efd-40e9871a4fba'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Tina Disappears"', piece.title_en = 'The Twilight Zone: Tina Disappears', piece.editor_locked = 1
WHERE piece.id = 10035 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11187 AND linked.composer_id = 112), 'musicbrainz:f936cce8-5c0c-46fd-932a-2aedbb079f89', 75, NULL, 'Eric Finds Tina', 'Eric Finds Tina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f936cce8-5c0c-46fd-932a-2aedbb079f89'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Eric Finds Tina"', piece.title_en = 'The Twilight Zone: Eric Finds Tina', piece.editor_locked = 1
WHERE piece.id = 11187 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8150 AND linked.composer_id = 112), 'musicbrainz:1c8b4855-969c-42ed-bc21-a3a2abaf8b88', 76, NULL, 'Destroy Tina', 'Destroy Tina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c8b4855-969c-42ed-bc21-a3a2abaf8b88'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Destroy Tina"', piece.title_en = 'The Twilight Zone: Destroy Tina', piece.editor_locked = 1
WHERE piece.id = 8150 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8319 AND linked.composer_id = 112), 'musicbrainz:2ac5aa1b-6419-4672-88e6-c52f9424e0c3', 77, NULL, 'Indestructible Tina', 'Indestructible Tina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac5aa1b-6419-4672-88e6-c52f9424e0c3'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Indestructible Tina"', piece.title_en = 'The Twilight Zone: Indestructible Tina', piece.editor_locked = 1
WHERE piece.id = 8319 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9028 AND linked.composer_id = 112), 'musicbrainz:5bb03943-2f82-4d8b-875f-5328514140fe', 78, NULL, 'Eric Returns Tina', 'Eric Returns Tina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bb03943-2f82-4d8b-875f-5328514140fe'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Eric Returns Tina"', piece.title_en = 'The Twilight Zone: Eric Returns Tina', piece.editor_locked = 1
WHERE piece.id = 9028 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b203c28-3a78-4cad-99d6-00e3221ff1dc', 79, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b203c28-3a78-4cad-99d6-00e3221ff1dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7761 AND linked.composer_id = 112), 'musicbrainz:0258b5f4-67f8-4de4-a875-1a26f743a954', 80, NULL, 'Ninety Years Without Slumbering, Part 1', 'Ninety Years Without Slumbering, Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0258b5f4-67f8-4de4-a875-1a26f743a954'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 1"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 1', piece.editor_locked = 1
WHERE piece.id = 7761 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10699 AND linked.composer_id = 112), 'musicbrainz:d51e5f3d-f747-479d-ae1e-c1f52b5cad3e', 81, NULL, 'Ninety Years Without Slumbering, Part 2', 'Ninety Years Without Slumbering, Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d51e5f3d-f747-479d-ae1e-c1f52b5cad3e'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 2"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 2', piece.editor_locked = 1
WHERE piece.id = 10699 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8175 AND linked.composer_id = 112), 'musicbrainz:1ea14894-0ead-4f5c-85d1-cd340897d381', 82, NULL, 'Ninety Years Without Slumbering, Part 3', 'Ninety Years Without Slumbering, Part 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea14894-0ead-4f5c-85d1-cd340897d381'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 3"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 3', piece.editor_locked = 1
WHERE piece.id = 8175 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10144 AND linked.composer_id = 112), 'musicbrainz:abdb86c4-7a96-474e-a429-28e6dc7f3209', 83, NULL, 'Ninety Years Without Slumbering, Part 4', 'Ninety Years Without Slumbering, Part 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abdb86c4-7a96-474e-a429-28e6dc7f3209'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 4"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 4', piece.editor_locked = 1
WHERE piece.id = 10144 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8363 AND linked.composer_id = 112), 'musicbrainz:2dffe6d3-8a1d-4c29-8151-c1e1b4989bb0', 84, NULL, 'Ninety Years Without Slumbering, Part 5', 'Ninety Years Without Slumbering, Part 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dffe6d3-8a1d-4c29-8151-c1e1b4989bb0'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 5"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 5', piece.editor_locked = 1
WHERE piece.id = 8363 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10329 AND linked.composer_id = 112), 'musicbrainz:b951b935-329f-41ee-ad31-2504d41a3704', 85, NULL, 'Ninety Years Without Slumbering, Part 6', 'Ninety Years Without Slumbering, Part 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b951b935-329f-41ee-ad31-2504d41a3704'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 6"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 6', piece.editor_locked = 1
WHERE piece.id = 10329 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10078 AND linked.composer_id = 112), 'musicbrainz:a68ed96c-b711-4326-b72c-b71c098b1abb', 86, NULL, 'Ninety Years Without Slumbering, Part 7', 'Ninety Years Without Slumbering, Part 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a68ed96c-b711-4326-b72c-b71c098b1abb'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 7"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 7', piece.editor_locked = 1
WHERE piece.id = 10078 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8636 AND linked.composer_id = 112), 'musicbrainz:4198c452-25c2-49b9-bc45-89bbf10a0a7d', 87, NULL, 'Ninety Years Without Slumbering, Part 8', 'Ninety Years Without Slumbering, Part 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4198c452-25c2-49b9-bc45-89bbf10a0a7d'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 8"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 8', piece.editor_locked = 1
WHERE piece.id = 8636 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9356 AND linked.composer_id = 112), 'musicbrainz:734f6bfa-8180-4830-b934-f893aebb9bca', 88, NULL, 'Ninety Years Without Slumbering, Part 9', 'Ninety Years Without Slumbering, Part 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:734f6bfa-8180-4830-b934-f893aebb9bca'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 9"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 9', piece.editor_locked = 1
WHERE piece.id = 9356 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11062 AND linked.composer_id = 112), 'musicbrainz:efebcf56-eb8b-45bc-898d-7cba5b0c5da0', 89, NULL, 'Ninety Years Without Slumbering, Part 10', 'Ninety Years Without Slumbering, Part 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efebcf56-eb8b-45bc-898d-7cba5b0c5da0'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 10"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 10', piece.editor_locked = 1
WHERE piece.id = 11062 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9438 AND linked.composer_id = 112), 'musicbrainz:793e98b7-5fa4-4866-af64-d8890172174d', 90, NULL, 'Ninety Years Without Slumbering, Part 11', 'Ninety Years Without Slumbering, Part 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:793e98b7-5fa4-4866-af64-d8890172174d'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 11"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 11', piece.editor_locked = 1
WHERE piece.id = 9438 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9227 AND linked.composer_id = 112), 'musicbrainz:6b0f839f-0200-444e-b886-5c2e71b53f24', 91, NULL, 'Ninety Years Without Slumbering, Part 12', 'Ninety Years Without Slumbering, Part 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b0f839f-0200-444e-b886-5c2e71b53f24'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "Ninety Years Without Slumbering, Part 12"', piece.title_en = 'The Twilight Zone: Ninety Years Without Slumbering, Part 12', piece.editor_locked = 1
WHERE piece.id = 9227 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:148fd74f-91c7-4dc7-99a6-cd2a7bc77eff', 92, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:148fd74f-91c7-4dc7-99a6-cd2a7bc77eff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8887 AND linked.composer_id = 112), 'musicbrainz:527d7bf6-81db-4f71-ac26-e7ddb972e5c6', 93, NULL, 'New Twilight Zone Theme Closing', 'New Twilight Zone Theme Closing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Twilight Zone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:527d7bf6-81db-4f71-ac26-e7ddb972e5c6'
);

UPDATE pieces piece
SET piece.title = 'The Twilight Zone 중 "New Twilight Zone Theme Closing"', piece.title_en = 'The Twilight Zone: New Twilight Zone Theme Closing', piece.editor_locked = 1
WHERE piece.id = 8887 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <신밧드의 7번째 모험> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <신밧드의 7번째 모험> 사운드트랙', 'The 7th Voyage of Sinbad', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <신밧드의 7번째 모험> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e39cae8b-f761-402e-8d7d-4f1abe473bdf', 1, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e39cae8b-f761-402e-8d7d-4f1abe473bdf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10451 AND linked.composer_id = 112), 'musicbrainz:c30f5568-f006-48c0-885e-7f13f036d7ae', 2, NULL, 'The Fog', 'The Fog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c30f5568-f006-48c0-885e-7f13f036d7ae'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Fog"', piece.title_en = 'The 7th Voyage of Sinbad: The Fog', piece.editor_locked = 1
WHERE piece.id = 10451 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9213 AND linked.composer_id = 112), 'musicbrainz:69d03c98-6724-432d-91b7-7a3dadec7f2a', 3, NULL, 'The Princess', 'The Princess', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69d03c98-6724-432d-91b7-7a3dadec7f2a'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Princess"', piece.title_en = 'The 7th Voyage of Sinbad: The Princess', piece.editor_locked = 1
WHERE piece.id = 9213 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10149 AND linked.composer_id = 112), 'musicbrainz:ac1279b5-eebd-45e1-9da6-ef8dd98d0b86', 4, NULL, 'The Stone Gate', 'The Stone Gate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac1279b5-eebd-45e1-9da6-ef8dd98d0b86'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Stone Gate"', piece.title_en = 'The 7th Voyage of Sinbad: The Stone Gate', piece.editor_locked = 1
WHERE piece.id = 10149 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8052 AND linked.composer_id = 112), 'musicbrainz:1534693f-3ca8-4de3-a971-e9631559e676', 5, NULL, 'The Cyclops', 'The Cyclops', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1534693f-3ca8-4de3-a971-e9631559e676'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Cyclops"', piece.title_en = 'The 7th Voyage of Sinbad: The Cyclops', piece.editor_locked = 1
WHERE piece.id = 8052 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10202 AND linked.composer_id = 112), 'musicbrainz:af83c47b-3b41-440e-81fe-5ce49c700e31', 6, NULL, 'The Trumpets', 'The Trumpets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af83c47b-3b41-440e-81fe-5ce49c700e31'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Trumpets"', piece.title_en = 'The 7th Voyage of Sinbad: The Trumpets', piece.editor_locked = 1
WHERE piece.id = 10202 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11252 AND linked.composer_id = 112), 'musicbrainz:fd870acf-cc0d-41d4-a513-f59812f3763c', 7, NULL, 'Bagdad', 'Bagdad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd870acf-cc0d-41d4-a513-f59812f3763c'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Bagdad"', piece.title_en = 'The 7th Voyage of Sinbad: Bagdad', piece.editor_locked = 1
WHERE piece.id = 11252 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7763 AND linked.composer_id = 112), 'musicbrainz:029b0ea5-8c8f-4b7e-be5e-01af09fb6226', 8, NULL, 'Sultan''s Feast', 'Sultan''s Feast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:029b0ea5-8c8f-4b7e-be5e-01af09fb6226'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Sultan''s Feast"', piece.title_en = 'The 7th Voyage of Sinbad: Sultan''s Feast', piece.editor_locked = 1
WHERE piece.id = 7763 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8510 AND linked.composer_id = 112), 'musicbrainz:376a4190-4938-444a-8cf2-3c66ee523bc0', 9, NULL, 'The Vase', 'The Vase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:376a4190-4938-444a-8cf2-3c66ee523bc0'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Vase"', piece.title_en = 'The 7th Voyage of Sinbad: The Vase', piece.editor_locked = 1
WHERE piece.id = 8510 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9983 AND linked.composer_id = 112), 'musicbrainz:a05d889c-afe3-4964-b753-8aca9b806183', 10, NULL, 'Cobra Dance', 'Cobra Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a05d889c-afe3-4964-b753-8aca9b806183'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Cobra Dance"', piece.title_en = 'The 7th Voyage of Sinbad: Cobra Dance', piece.editor_locked = 1
WHERE piece.id = 9983 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9042 AND linked.composer_id = 112), 'musicbrainz:5cc7d9a8-8b7e-4cb7-9ceb-a4ae089723d3', 11, NULL, 'The Prophesy', 'The Prophesy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc7d9a8-8b7e-4cb7-9ceb-a4ae089723d3'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Prophesy"', piece.title_en = 'The 7th Voyage of Sinbad: The Prophesy', piece.editor_locked = 1
WHERE piece.id = 9042 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9612 AND linked.composer_id = 112), 'musicbrainz:8524dd2c-cce7-42b1-83fb-0a1bb21e666b', 12, NULL, 'The Pool', 'The Pool', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8524dd2c-cce7-42b1-83fb-0a1bb21e666b'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Pool"', piece.title_en = 'The 7th Voyage of Sinbad: The Pool', piece.editor_locked = 1
WHERE piece.id = 9612 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11030 AND linked.composer_id = 112), 'musicbrainz:ed907b27-2c5e-4b19-b8e5-f66478f96235', 13, NULL, 'Night Magic', 'Night Magic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed907b27-2c5e-4b19-b8e5-f66478f96235'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Night Magic"', piece.title_en = 'The 7th Voyage of Sinbad: Night Magic', piece.editor_locked = 1
WHERE piece.id = 11030 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11145 AND linked.composer_id = 112), 'musicbrainz:f6d0a764-17ed-4f0a-9a7e-c1ceac5bda0a', 14, NULL, 'Tiny Princess', 'Tiny Princess', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6d0a764-17ed-4f0a-9a7e-c1ceac5bda0a'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Tiny Princess"', piece.title_en = 'The 7th Voyage of Sinbad: Tiny Princess', piece.editor_locked = 1
WHERE piece.id = 11145 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aeafd9d4-5a77-47c1-b09a-2d839b604c71', 15, NULL, 'The Ship', 'The Ship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeafd9d4-5a77-47c1-b09a-2d839b604c71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d74f891-e607-4a96-b453-9fe01abb24ef', 16, NULL, 'The Fight', 'The Fight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d74f891-e607-4a96-b453-9fe01abb24ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fbec64a-0a02-4566-9c1e-7317106a364e', 17, NULL, 'The Return', 'The Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fbec64a-0a02-4566-9c1e-7317106a364e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10683 AND linked.composer_id = 112), 'musicbrainz:d3c0a1cf-cf27-48cc-87b5-bfd4a66adc2a', 18, NULL, 'The Skull', 'The Skull', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3c0a1cf-cf27-48cc-87b5-bfd4a66adc2a'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Skull"', piece.title_en = 'The 7th Voyage of Sinbad: The Skull', piece.editor_locked = 1
WHERE piece.id = 10683 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9636 AND linked.composer_id = 112), 'musicbrainz:86a3735f-c886-49bc-9d02-b5cf835a46ee', 19, NULL, 'The Cave', 'The Cave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86a3735f-c886-49bc-9d02-b5cf835a46ee'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Cave"', piece.title_en = 'The 7th Voyage of Sinbad: The Cave', piece.editor_locked = 1
WHERE piece.id = 9636 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8959 AND linked.composer_id = 112), 'musicbrainz:57364bf6-c3cd-427e-93ca-e3840f0a4553', 20, NULL, 'The Capture', 'The Capture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57364bf6-c3cd-427e-93ca-e3840f0a4553'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Capture"', piece.title_en = 'The 7th Voyage of Sinbad: The Capture', piece.editor_locked = 1
WHERE piece.id = 8959 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10916 AND linked.composer_id = 112), 'musicbrainz:e5bdc0f3-581e-4b6c-b21d-439ea4e81404', 21, NULL, 'The Fight With The Cyclops', 'The Fight With The Cyclops', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5bdc0f3-581e-4b6c-b21d-439ea4e81404'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Fight With The Cyclops"', piece.title_en = 'The 7th Voyage of Sinbad: The Fight With The Cyclops', piece.editor_locked = 1
WHERE piece.id = 10916 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8103 AND linked.composer_id = 112), 'musicbrainz:1951327c-25f7-4ba2-a816-7d5e9d6b354b', 22, NULL, 'Cyclops'' Death', 'Cyclops'' Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1951327c-25f7-4ba2-a816-7d5e9d6b354b'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Cyclops'' Death"', piece.title_en = 'The 7th Voyage of Sinbad: Cyclops'' Death', piece.editor_locked = 1
WHERE piece.id = 8103 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10475 AND linked.composer_id = 112), 'musicbrainz:c487c1ab-2e8e-4076-b055-9b385ac4464f', 23, NULL, 'The Cliffs', 'The Cliffs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c487c1ab-2e8e-4076-b055-9b385ac4464f'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Cliffs"', piece.title_en = 'The 7th Voyage of Sinbad: The Cliffs', piece.editor_locked = 1
WHERE piece.id = 10475 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8360 AND linked.composer_id = 112), 'musicbrainz:2de2a64f-2d3c-4c7d-86a4-dc98d80625ff', 24, NULL, 'The Egg', 'The Egg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2de2a64f-2d3c-4c7d-86a4-dc98d80625ff'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Egg"', piece.title_en = 'The 7th Voyage of Sinbad: The Egg', piece.editor_locked = 1
WHERE piece.id = 8360 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8573 AND linked.composer_id = 112), 'musicbrainz:3c4074a0-fc31-4ba3-ade2-391208a24991', 25, NULL, 'The Request', 'The Request', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c4074a0-fc31-4ba3-ade2-391208a24991'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Request"', piece.title_en = 'The 7th Voyage of Sinbad: The Request', piece.editor_locked = 1
WHERE piece.id = 8573 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10616 AND linked.composer_id = 112), 'musicbrainz:cf0f29f8-abca-45cd-b96f-a325a119fe85', 26, NULL, 'The Genie''s Home', 'The Genie''s Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf0f29f8-abca-45cd-b96f-a325a119fe85'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Genie''s Home"', piece.title_en = 'The 7th Voyage of Sinbad: The Genie''s Home', piece.editor_locked = 1
WHERE piece.id = 10616 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8262 AND linked.composer_id = 112), 'musicbrainz:26c26a15-f6a5-4b89-9e48-06986e154172', 27, NULL, 'The Fight With The Roc', 'The Fight With The Roc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26c26a15-f6a5-4b89-9e48-06986e154172'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Fight With The Roc"', piece.title_en = 'The 7th Voyage of Sinbad: The Fight With The Roc', piece.editor_locked = 1
WHERE piece.id = 8262 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9236 AND linked.composer_id = 112), 'musicbrainz:6b4bdae0-8039-4cf4-98bd-dde58b6b5827', 28, NULL, 'The Nest', 'The Nest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b4bdae0-8039-4cf4-98bd-dde58b6b5827'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Nest"', piece.title_en = 'The 7th Voyage of Sinbad: The Nest', piece.editor_locked = 1
WHERE piece.id = 9236 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10879 AND linked.composer_id = 112), 'musicbrainz:e3064fec-7e17-4460-b43c-b65e913ed33d', 29, NULL, 'The Dragon', 'The Dragon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3064fec-7e17-4460-b43c-b65e913ed33d'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Dragon"', piece.title_en = 'The 7th Voyage of Sinbad: The Dragon', piece.editor_locked = 1
WHERE piece.id = 10879 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7940 AND linked.composer_id = 112), 'musicbrainz:0e2a38dc-c76c-41bd-90e2-2cbf59cfcd07', 30, NULL, 'Transformation', 'Transformation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e2a38dc-c76c-41bd-90e2-2cbf59cfcd07'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Transformation"', piece.title_en = 'The 7th Voyage of Sinbad: Transformation', piece.editor_locked = 1
WHERE piece.id = 7940 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9615 AND linked.composer_id = 112), 'musicbrainz:8538b3e6-4e75-47d0-b7f2-01c6de992ce0', 31, NULL, 'The Skeleton', 'The Skeleton', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8538b3e6-4e75-47d0-b7f2-01c6de992ce0'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Skeleton"', piece.title_en = 'The 7th Voyage of Sinbad: The Skeleton', piece.editor_locked = 1
WHERE piece.id = 9615 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10729 AND linked.composer_id = 112), 'musicbrainz:d7e1bfea-b238-4976-b7bd-bd2612a1a6d0', 32, NULL, 'The Duel With The Skeleton', 'The Duel With The Skeleton', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7e1bfea-b238-4976-b7bd-bd2612a1a6d0'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Duel With The Skeleton"', piece.title_en = 'The 7th Voyage of Sinbad: The Duel With The Skeleton', piece.editor_locked = 1
WHERE piece.id = 10729 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f30428fe-f7f4-4216-bfa4-3bbacc9ecb3b', 33, NULL, 'The Sword', 'The Sword', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f30428fe-f7f4-4216-bfa4-3bbacc9ecb3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10234 AND linked.composer_id = 112), 'musicbrainz:b1e12959-e119-4a02-8e00-e5ef33c775cb', 34, NULL, 'Dragon And Cyclops', 'Dragon And Cyclops', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1e12959-e119-4a02-8e00-e5ef33c775cb'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "Dragon And Cyclops"', piece.title_en = 'The 7th Voyage of Sinbad: Dragon And Cyclops', piece.editor_locked = 1
WHERE piece.id = 10234 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9871 AND linked.composer_id = 112), 'musicbrainz:98cbc4e5-ce11-43dd-972a-a2b520e77b1d', 35, NULL, 'The Crossbow', 'The Crossbow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98cbc4e5-ce11-43dd-972a-a2b520e77b1d'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Crossbow"', piece.title_en = 'The 7th Voyage of Sinbad: The Crossbow', piece.editor_locked = 1
WHERE piece.id = 9871 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9991 AND linked.composer_id = 112), 'musicbrainz:a1162898-680a-4a63-b573-7fe1c2981dda', 36, NULL, 'The Death Of The Dragon', 'The Death Of The Dragon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1162898-680a-4a63-b573-7fe1c2981dda'
);

UPDATE pieces piece
SET piece.title = '영화 <신밧드의 7번째 모험> 사운드트랙 중 "The Death Of The Dragon"', piece.title_en = 'The 7th Voyage of Sinbad: The Death Of The Dragon', piece.editor_locked = 1
WHERE piece.id = 9991 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e16de6d-84f0-4b80-90c7-8af040ab2d83', 37, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <신밧드의 7번째 모험> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e16de6d-84f0-4b80-90c7-8af040ab2d83'
);


-- None 영화 <The 3 Worlds of Gulliver> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <The 3 Worlds of Gulliver> 사운드트랙', 'The 3 Worlds of Gulliver', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7576f3b-f6ba-47ee-a088-4a7f49fb28fb', 1, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7576f3b-f6ba-47ee-a088-4a7f49fb28fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9165 AND linked.composer_id = 112), 'musicbrainz:6575cb9d-938c-49e6-8a7c-8aa8ec65269b', 2, NULL, 'Minuetto', 'Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6575cb9d-938c-49e6-8a7c-8aa8ec65269b'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Minuetto"', piece.title_en = 'The 3 Worlds of Gulliver: Minuetto', piece.editor_locked = 1
WHERE piece.id = 9165 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41d92732-054e-4c95-8f7d-30bf9f468cb2', 3, NULL, 'The Lovers', 'The Lovers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41d92732-054e-4c95-8f7d-30bf9f468cb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8553 AND linked.composer_id = 112), 'musicbrainz:3a7f95f3-3208-4d65-beb0-bbce19e06aed', 4, NULL, 'Trio Refrain', 'Trio Refrain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a7f95f3-3208-4d65-beb0-bbce19e06aed'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Trio Refrain"', piece.title_en = 'The 3 Worlds of Gulliver: Trio Refrain', piece.editor_locked = 1
WHERE piece.id = 8553 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8042 AND linked.composer_id = 112), 'musicbrainz:145c01d8-c3ac-4325-bfda-21eea6acac3a', 5, NULL, 'The Old House', 'The Old House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:145c01d8-c3ac-4325-bfda-21eea6acac3a'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Old House"', piece.title_en = 'The 3 Worlds of Gulliver: The Old House', piece.editor_locked = 1
WHERE piece.id = 8042 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cfa38a1-0b3d-4fe1-8c9f-ece8cad0f002', 6, NULL, 'The Ship', 'The Ship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cfa38a1-0b3d-4fe1-8c9f-ece8cad0f002'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b874cce-ce0d-4e05-9a5b-dbe110ce9942', 7, NULL, 'The Storm', 'The Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b874cce-ce0d-4e05-9a5b-dbe110ce9942'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10551 AND linked.composer_id = 112), 'musicbrainz:ca3c87e3-903d-4193-8777-5a00ea932dd3', 8, NULL, 'The Lilliputians', 'The Lilliputians', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca3c87e3-903d-4193-8777-5a00ea932dd3'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Lilliputians"', piece.title_en = 'The 3 Worlds of Gulliver: The Lilliputians', piece.editor_locked = 1
WHERE piece.id = 10551 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10407 AND linked.composer_id = 112), 'musicbrainz:bf7d9c42-0e53-4a62-b66f-e3ba453747f8', 9, NULL, 'The Duel', 'The Duel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf7d9c42-0e53-4a62-b66f-e3ba453747f8'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Duel"', piece.title_en = 'The 3 Worlds of Gulliver: The Duel', piece.editor_locked = 1
WHERE piece.id = 10407 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7960 AND linked.composer_id = 112), 'musicbrainz:0f835216-3142-4da8-8514-99a12e2d09aa', 10, NULL, 'The King''s March', 'The King''s March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f835216-3142-4da8-8514-99a12e2d09aa'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The King''s March"', piece.title_en = 'The 3 Worlds of Gulliver: The King''s March', piece.editor_locked = 1
WHERE piece.id = 7960 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11236 AND linked.composer_id = 112), 'musicbrainz:fcadf6a5-df23-4dda-8c4c-88283230ef36', 11, NULL, 'The Clouds', 'The Clouds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcadf6a5-df23-4dda-8c4c-88283230ef36'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Clouds"', piece.title_en = 'The 3 Worlds of Gulliver: The Clouds', piece.editor_locked = 1
WHERE piece.id = 11236 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11063 AND linked.composer_id = 112), 'musicbrainz:efed1fff-10c3-4d98-a7f1-73f872650022', 12, NULL, 'The Trees', 'The Trees', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efed1fff-10c3-4d98-a7f1-73f872650022'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Trees"', piece.title_en = 'The 3 Worlds of Gulliver: The Trees', piece.editor_locked = 1
WHERE piece.id = 11063 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8870 AND linked.composer_id = 112), 'musicbrainz:5190a997-fca4-4624-b5f6-0ab1fdb0aa06', 13, NULL, 'A Hatful of Fish', 'A Hatful of Fish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5190a997-fca4-4624-b5f6-0ab1fdb0aa06'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "A Hatful of Fish"', piece.title_en = 'The 3 Worlds of Gulliver: A Hatful of Fish', piece.editor_locked = 1
WHERE piece.id = 8870 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8232 AND linked.composer_id = 112), 'musicbrainz:23b654e2-17f0-42e2-b2e1-d483f5f6edb0', 14, NULL, 'The Oath', 'The Oath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23b654e2-17f0-42e2-b2e1-d483f5f6edb0'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Oath"', piece.title_en = 'The 3 Worlds of Gulliver: The Oath', piece.editor_locked = 1
WHERE piece.id = 8232 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a8330ff-fa19-40e7-8928-acc0ad4a65c9', 15, NULL, 'The Castle', 'The Castle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a8330ff-fa19-40e7-8928-acc0ad4a65c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10855 AND linked.composer_id = 112), 'musicbrainz:e0aafe04-0bf7-4316-9cd0-86ed7eb21fb4', 16, NULL, 'The Tightrope', 'The Tightrope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0aafe04-0bf7-4316-9cd0-86ed7eb21fb4'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Tightrope"', piece.title_en = 'The 3 Worlds of Gulliver: The Tightrope', piece.editor_locked = 1
WHERE piece.id = 10855 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ec84f7c-8801-4444-b869-c5f9d5362bc4', 17, NULL, 'The Prison', 'The Prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ec84f7c-8801-4444-b869-c5f9d5362bc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcaf8088-217e-439c-bd13-b4b13f93114d', 18, NULL, 'The Fight', 'The Fight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcaf8088-217e-439c-bd13-b4b13f93114d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7807 AND linked.composer_id = 112), 'musicbrainz:04fb0cc3-0941-4bd2-9e31-34a651714ede', 19, NULL, 'War March', 'War March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04fb0cc3-0941-4bd2-9e31-34a651714ede'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "War March"', piece.title_en = 'The 3 Worlds of Gulliver: War March', piece.editor_locked = 1
WHERE piece.id = 7807 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9554 AND linked.composer_id = 112), 'musicbrainz:80f7fc3c-7239-4f41-a1b5-e16410be8969', 20, NULL, 'Naval Battle', 'Naval Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f7fc3c-7239-4f41-a1b5-e16410be8969'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Naval Battle"', piece.title_en = 'The 3 Worlds of Gulliver: Naval Battle', piece.editor_locked = 1
WHERE piece.id = 9554 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11272 AND linked.composer_id = 112), 'musicbrainz:fe81481b-9f5f-4b52-ade8-919dc124fd32', 21, NULL, 'The Fire', 'The Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe81481b-9f5f-4b52-ade8-919dc124fd32'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Fire"', piece.title_en = 'The 3 Worlds of Gulliver: The Fire', piece.editor_locked = 1
WHERE piece.id = 11272 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61036a6a-e178-4cc7-b978-45f20603060d', 22, NULL, 'Escape', 'Escape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61036a6a-e178-4cc7-b978-45f20603060d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f513a574-19f8-43e0-918f-b452291dd8fa', 23, NULL, 'The Beach', 'The Beach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f513a574-19f8-43e0-918f-b452291dd8fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff2e3bd5-aa1a-46aa-9f39-2188341e0fd6', 24, NULL, 'The Shadow', 'The Shadow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff2e3bd5-aa1a-46aa-9f39-2188341e0fd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10614 AND linked.composer_id = 112), 'musicbrainz:ceed7b1d-0630-40ba-816b-c2b25b879cfb', 25, NULL, 'Reunion', 'Reunion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceed7b1d-0630-40ba-816b-c2b25b879cfb'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Reunion"', piece.title_en = 'The 3 Worlds of Gulliver: Reunion', piece.editor_locked = 1
WHERE piece.id = 10614 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4e71b4e-cd45-492c-bff1-ad22555274b8', 26, NULL, 'Duo', 'Duo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4e71b4e-cd45-492c-bff1-ad22555274b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae5e1544-4465-45df-8058-7011ed90bf51', 27, NULL, 'The Wedding', 'The Wedding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae5e1544-4465-45df-8058-7011ed90bf51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:964f331b-8bc9-4119-b50c-98d3dd4511dd', 28, NULL, 'Nocturne', 'Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:964f331b-8bc9-4119-b50c-98d3dd4511dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7738 AND linked.composer_id = 112), 'musicbrainz:00d0993c-a94d-4bff-a90d-ed32c7d54081', 29, NULL, 'The Woodland', 'The Woodland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00d0993c-a94d-4bff-a90d-ed32c7d54081'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Woodland"', piece.title_en = 'The 3 Worlds of Gulliver: The Woodland', piece.editor_locked = 1
WHERE piece.id = 7738 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10702 AND linked.composer_id = 112), 'musicbrainz:d57b0603-4e55-4d9e-8d9f-0055b7b10a0c', 30, NULL, 'The Squirrel', 'The Squirrel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d57b0603-4e55-4d9e-8d9f-0055b7b10a0c'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Squirrel"', piece.title_en = 'The 3 Worlds of Gulliver: The Squirrel', piece.editor_locked = 1
WHERE piece.id = 10702 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10688 AND linked.composer_id = 112), 'musicbrainz:d41b5c90-6fab-441c-baae-3d4f759bd4e6', 31, NULL, 'The Chess Game', 'The Chess Game', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d41b5c90-6fab-441c-baae-3d4f759bd4e6'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Chess Game"', piece.title_en = 'The 3 Worlds of Gulliver: The Chess Game', piece.editor_locked = 1
WHERE piece.id = 10688 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8314 AND linked.composer_id = 112), 'musicbrainz:2a44ddce-4901-4517-b1b2-62c0ea20182b', 32, NULL, 'Alchemy', 'Alchemy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a44ddce-4901-4517-b1b2-62c0ea20182b'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Alchemy"', piece.title_en = 'The 3 Worlds of Gulliver: Alchemy', piece.editor_locked = 1
WHERE piece.id = 8314 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10322 AND linked.composer_id = 112), 'musicbrainz:b8d98238-7940-4058-a26f-a7197afcd927', 33, NULL, 'The Girls', 'The Girls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d98238-7940-4058-a26f-a7197afcd927'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Girls"', piece.title_en = 'The 3 Worlds of Gulliver: The Girls', piece.editor_locked = 1
WHERE piece.id = 10322 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9508 AND linked.composer_id = 112), 'musicbrainz:7d97c874-760b-4305-8cb5-18a5685e31f7', 34, NULL, 'The Crocodile', 'The Crocodile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d97c874-760b-4305-8cb5-18a5685e31f7'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "The Crocodile"', piece.title_en = 'The 3 Worlds of Gulliver: The Crocodile', piece.editor_locked = 1
WHERE piece.id = 9508 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06846756-a24b-4335-a1cd-1f4971112b36', 35, NULL, 'Pursuit', 'Pursuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06846756-a24b-4335-a1cd-1f4971112b36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8097 AND linked.composer_id = 112), 'musicbrainz:18d7c9c1-d1c3-4bc9-b9f4-dfc207f589f3', 36, NULL, 'Happiness', 'Happiness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18d7c9c1-d1c3-4bc9-b9f4-dfc207f589f3'
);

UPDATE pieces piece
SET piece.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙 중 "Happiness"', piece.title_en = 'The 3 Worlds of Gulliver: Happiness', piece.editor_locked = 1
WHERE piece.id = 8097 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa63854c-a38c-4f95-b5bc-251d2bdab29b', 37, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <The 3 Worlds of Gulliver> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa63854c-a38c-4f95-b5bc-251d2bdab29b'
);


-- None Torn Curtain (The Unused Score)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Torn Curtain (The Unused Score)', 'Torn Curtain (The Unused Score)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Torn Curtain (The Unused Score)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcf7891d-7b81-45e6-ac01-5c79b5b038ea', 1, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf7891d-7b81-45e6-ac01-5c79b5b038ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53e2996a-6702-4b2a-880b-ba148200227e', 2, NULL, 'The Ship', 'The Ship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53e2996a-6702-4b2a-880b-ba148200227e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6be5d21-dc1c-48f3-9454-8ecce8078eba', 3, NULL, 'The Radiogram', 'The Radiogram', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6be5d21-dc1c-48f3-9454-8ecce8078eba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9c396f8-455b-484c-82e8-ee254960bf4f', 4, NULL, 'The Hotel', 'The Hotel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9c396f8-455b-484c-82e8-ee254960bf4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10908 AND linked.composer_id = 112), 'musicbrainz:e564f00a-dbe1-4fed-89d7-596ca4313887', 5, NULL, 'The Phone', 'The Phone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e564f00a-dbe1-4fed-89d7-596ca4313887'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Phone"', piece.title_en = 'Torn Curtain (The Unused Score): The Phone', piece.editor_locked = 1
WHERE piece.id = 10908 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9362 AND linked.composer_id = 112), 'musicbrainz:73d47890-cb3b-4e38-877d-20bba327350d', 6, NULL, 'The Bookstore', 'The Bookstore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73d47890-cb3b-4e38-877d-20bba327350d'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Bookstore"', piece.title_en = 'Torn Curtain (The Unused Score): The Bookstore', piece.editor_locked = 1
WHERE piece.id = 9362 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10958 AND linked.composer_id = 112), 'musicbrainz:e8994f44-63e3-44ab-bbbf-09b50af77e3e', 7, NULL, 'The Book', 'The Book', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8994f44-63e3-44ab-bbbf-09b50af77e3e'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Book"', piece.title_en = 'Torn Curtain (The Unused Score): The Book', piece.editor_locked = 1
WHERE piece.id = 10958 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14e6591e-7475-4b74-91de-0a46fb62a310', 8, NULL, 'Valse Lente', 'Valse Lente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14e6591e-7475-4b74-91de-0a46fb62a310'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8963 AND linked.composer_id = 112), 'musicbrainz:57c3df3a-9a50-44d1-9d54-cefba2a04015', 9, NULL, 'The Travel Desk', 'The Travel Desk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c3df3a-9a50-44d1-9d54-cefba2a04015'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Travel Desk"', piece.title_en = 'Torn Curtain (The Unused Score): The Travel Desk', piece.editor_locked = 1
WHERE piece.id = 8963 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8301 AND linked.composer_id = 112), 'musicbrainz:292d7380-08ba-430e-96e6-a8c2b593a258', 10, NULL, 'The Blurring', 'The Blurring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:292d7380-08ba-430e-96e6-a8c2b593a258'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Blurring"', piece.title_en = 'Torn Curtain (The Unused Score): The Blurring', piece.editor_locked = 1
WHERE piece.id = 8301 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8272 AND linked.composer_id = 112), 'musicbrainz:273666e2-bee0-4518-93c3-e95a2ce8a20a', 11, NULL, 'Hotel Berlin', 'Hotel Berlin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:273666e2-bee0-4518-93c3-e95a2ce8a20a'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "Hotel Berlin"', piece.title_en = 'Torn Curtain (The Unused Score): Hotel Berlin', piece.editor_locked = 1
WHERE piece.id = 8272 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11172 AND linked.composer_id = 112), 'musicbrainz:f86ebccf-2055-4cc9-b608-52b7360ff89e', 12, NULL, 'Sarah', 'Sarah', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f86ebccf-2055-4cc9-b608-52b7360ff89e'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "Sarah"', piece.title_en = 'Torn Curtain (The Unused Score): Sarah', piece.editor_locked = 1
WHERE piece.id = 11172 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e390cf79-a22d-44f5-9cca-9317f69217ca', 13, NULL, 'Dawn', 'Dawn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e390cf79-a22d-44f5-9cca-9317f69217ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7774 AND linked.composer_id = 112), 'musicbrainz:038b6bf8-dea5-426e-91bc-ebabfb22449f', 14, NULL, 'Gromek', 'Gromek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:038b6bf8-dea5-426e-91bc-ebabfb22449f'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "Gromek"', piece.title_en = 'Torn Curtain (The Unused Score): Gromek', piece.editor_locked = 1
WHERE piece.id = 7774 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10508 AND linked.composer_id = 112), 'musicbrainz:c6b5493f-60ff-461f-bab1-c73ec928f157', 15, NULL, 'The Farmhouse', 'The Farmhouse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6b5493f-60ff-461f-bab1-c73ec928f157'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Farmhouse"', piece.title_en = 'Torn Curtain (The Unused Score): The Farmhouse', piece.editor_locked = 1
WHERE piece.id = 10508 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9647 AND linked.composer_id = 112), 'musicbrainz:87813009-38ee-4351-a5f2-060c99dd033d', 16, NULL, 'The Killing', 'The Killing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87813009-38ee-4351-a5f2-060c99dd033d'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Killing"', piece.title_en = 'Torn Curtain (The Unused Score): The Killing', piece.editor_locked = 1
WHERE piece.id = 9647 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd22ed76-044f-4e90-84f2-3ca4cb6831b1', 17, NULL, 'The Body', 'The Body', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd22ed76-044f-4e90-84f2-3ca4cb6831b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9664 AND linked.composer_id = 112), 'musicbrainz:89116eb1-d142-4b5e-91af-ae5f534a7d33', 18, NULL, 'The Street', 'The Street', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89116eb1-d142-4b5e-91af-ae5f534a7d33'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Street"', piece.title_en = 'Torn Curtain (The Unused Score): The Street', piece.editor_locked = 1
WHERE piece.id = 9664 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10738 AND linked.composer_id = 112), 'musicbrainz:d8276f24-f579-4e2c-bae5-b53e8b58c105', 19, NULL, 'The Toast', 'The Toast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8276f24-f579-4e2c-bae5-b53e8b58c105'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Toast"', piece.title_en = 'Torn Curtain (The Unused Score): The Toast', piece.editor_locked = 1
WHERE piece.id = 10738 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8413 AND linked.composer_id = 112), 'musicbrainz:3161fa60-0569-4384-b29d-623990b9fba6', 20, NULL, 'The Photos', 'The Photos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3161fa60-0569-4384-b29d-623990b9fba6'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Photos"', piece.title_en = 'Torn Curtain (The Unused Score): The Photos', piece.editor_locked = 1
WHERE piece.id = 8413 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11245 AND linked.composer_id = 112), 'musicbrainz:fd41dc26-df08-4510-ac7c-843d0a854664', 21, NULL, 'The Sausage', 'The Sausage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd41dc26-df08-4510-ac7c-843d0a854664'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Sausage"', piece.title_en = 'Torn Curtain (The Unused Score): The Sausage', piece.editor_locked = 1
WHERE piece.id = 11245 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0d161e5-b213-48a7-9c8c-cd62d171c9ba', 22, NULL, 'The Fall', 'The Fall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0d161e5-b213-48a7-9c8c-cd62d171c9ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8386 AND linked.composer_id = 112), 'musicbrainz:2f7d2d7e-e887-43fc-bb77-65cccf6d56f1', 23, NULL, 'The Cab Driver', 'The Cab Driver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f7d2d7e-e887-43fc-bb77-65cccf6d56f1'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Cab Driver"', piece.title_en = 'Torn Curtain (The Unused Score): The Cab Driver', piece.editor_locked = 1
WHERE piece.id = 8386 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8030031d-98b7-4e6b-9d86-52be52884a6c', 24, NULL, 'The Hill', 'The Hill', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8030031d-98b7-4e6b-9d86-52be52884a6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:596933d9-619d-4429-9246-1416f6903118', 25, NULL, 'The Search', 'The Search', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:596933d9-619d-4429-9246-1416f6903118'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:089b3351-e860-4271-a01e-1991ded90165', 26, NULL, 'Discovery', 'Discovery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089b3351-e860-4271-a01e-1991ded90165'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9309 AND linked.composer_id = 112), 'musicbrainz:706c8fc9-f5f5-408a-bfa3-529c3e6f6c25', 27, NULL, 'The Blackboard', 'The Blackboard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:706c8fc9-f5f5-408a-bfa3-529c3e6f6c25'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Blackboard"', piece.title_en = 'Torn Curtain (The Unused Score): The Blackboard', piece.editor_locked = 1
WHERE piece.id = 9309 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10308 AND linked.composer_id = 112), 'musicbrainz:b7c598a7-922c-4096-b160-3d66a96540d9', 28, NULL, 'The Formula', 'The Formula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7c598a7-922c-4096-b160-3d66a96540d9'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Formula"', piece.title_en = 'Torn Curtain (The Unused Score): The Formula', piece.editor_locked = 1
WHERE piece.id = 10308 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9957 AND linked.composer_id = 112), 'musicbrainz:9e3d8377-51ef-4a48-a888-a41bd4ca9cd3', 29, NULL, 'The Corridor', 'The Corridor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e3d8377-51ef-4a48-a888-a41bd4ca9cd3'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Corridor"', piece.title_en = 'Torn Curtain (The Unused Score): The Corridor', piece.editor_locked = 1
WHERE piece.id = 9957 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11157 AND linked.composer_id = 112), 'musicbrainz:f79cff3a-e370-4ed5-aea8-17f0762bd7e1', 30, NULL, 'The Bicycles', 'The Bicycles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f79cff3a-e370-4ed5-aea8-17f0762bd7e1'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Bicycles"', piece.title_en = 'Torn Curtain (The Unused Score): The Bicycles', piece.editor_locked = 1
WHERE piece.id = 11157 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9317 AND linked.composer_id = 112), 'musicbrainz:70c7c996-d5a1-4c8a-ac73-8953fc6586f5', 31, NULL, 'The Bus', 'The Bus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Torn Curtain (The Unused Score)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70c7c996-d5a1-4c8a-ac73-8953fc6586f5'
);

UPDATE pieces piece
SET piece.title = 'Torn Curtain (The Unused Score) 중 "The Bus"', piece.title_en = 'Torn Curtain (The Unused Score): The Bus', piece.editor_locked = 1
WHERE piece.id = 9317 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <화씨 451> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <화씨 451> 사운드트랙', 'Fahrenheit 451', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <화씨 451> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8025 AND linked.composer_id = 112), 'musicbrainz:137b3191-8b7b-4411-b723-e9d32ac99d11', 1, NULL, 'Prelude', 'Fahrenheit 451: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:137b3191-8b7b-4411-b723-e9d32ac99d11'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Prelude"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: Prelude', piece.editor_locked = 1
WHERE piece.id = 8025 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9650 AND linked.composer_id = 112), 'musicbrainz:8792bcd4-b28a-4b23-9145-1a2e5aabbbe4', 2, NULL, 'Fire Engine', 'Fahrenheit 451: Fire Engine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8792bcd4-b28a-4b23-9145-1a2e5aabbbe4'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Fire Engine"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: Fire Engine', piece.editor_locked = 1
WHERE piece.id = 9650 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7863 AND linked.composer_id = 112), 'musicbrainz:08fe3bc7-15b1-435b-8c4f-5a4fc9f7fe9f', 3, NULL, 'The Bedroom', 'Fahrenheit 451: The Bedroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08fe3bc7-15b1-435b-8c4f-5a4fc9f7fe9f'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "The Bedroom"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: The Bedroom', piece.editor_locked = 1
WHERE piece.id = 7863 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9052 AND linked.composer_id = 112), 'musicbrainz:5d5599dc-1592-4853-9fba-7a50aff2a5bc', 4, NULL, 'The Reading', 'Fahrenheit 451: The Reading', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d5599dc-1592-4853-9fba-7a50aff2a5bc'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "The Reading"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: The Reading', piece.editor_locked = 1
WHERE piece.id = 9052 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9987 AND linked.composer_id = 112), 'musicbrainz:a0c4d295-6f44-4146-b962-21203c5c0e5d', 5, NULL, 'The Garden', 'Fahrenheit 451: The Garden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0c4d295-6f44-4146-b962-21203c5c0e5d'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "The Garden"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: The Garden', piece.editor_locked = 1
WHERE piece.id = 9987 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8200 AND linked.composer_id = 112), 'musicbrainz:20135130-deb0-4510-a102-b5702da1606f', 6, NULL, 'The Nightmare', 'Fahrenheit 451: The Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20135130-deb0-4510-a102-b5702da1606f'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "The Nightmare"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: The Nightmare', piece.editor_locked = 1
WHERE piece.id = 8200 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10164 AND linked.composer_id = 112), 'musicbrainz:ad609d70-dd2f-4cbc-8ad4-9a47564ce085', 7, NULL, 'Flowers of Fire', 'Fahrenheit 451: Flowers of Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad609d70-dd2f-4cbc-8ad4-9a47564ce085'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Flowers of Fire"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: Flowers of Fire', piece.editor_locked = 1
WHERE piece.id = 10164 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10093 AND linked.composer_id = 112), 'musicbrainz:a77935ef-e27a-4b90-a5eb-9b74c87181ab', 8, NULL, 'Flamethrower', 'Fahrenheit 451: Flamethrower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a77935ef-e27a-4b90-a5eb-9b74c87181ab'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Flamethrower"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: Flamethrower', piece.editor_locked = 1
WHERE piece.id = 10093 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8584 AND linked.composer_id = 112), 'musicbrainz:3d971038-6068-4e3f-8686-dbf282740949', 9, NULL, 'Captain''s Death', 'Fahrenheit 451: Captain''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d971038-6068-4e3f-8686-dbf282740949'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Captain''s Death"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: Captain''s Death', piece.editor_locked = 1
WHERE piece.id = 8584 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8687 AND linked.composer_id = 112), 'musicbrainz:451c9fb5-b154-48d7-8f11-3850e3fde44c', 10, NULL, 'The Road', 'Fahrenheit 451: The Road', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:451c9fb5-b154-48d7-8f11-3850e3fde44c'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "The Road"', piece.title_en = 'Fahrenheit 451: Fahrenheit 451: The Road', piece.editor_locked = 1
WHERE piece.id = 8687 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9173 AND linked.composer_id = 112), 'musicbrainz:6628992a-50d9-4c22-9171-07649bbe9d59', 11, NULL, 'The Man in the Grey Flannel Suit: Main Title', 'The Man in the Grey Flannel Suit: Main Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6628992a-50d9-4c22-9171-07649bbe9d59'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "The Man in the Grey Flannel Suit: Main Title"', piece.title_en = 'Fahrenheit 451: The Man in the Grey Flannel Suit: Main Title', piece.editor_locked = 1
WHERE piece.id = 9173 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8872 AND linked.composer_id = 112), 'musicbrainz:519b8e40-8e9b-4cbe-84c9-8715c4bb2496', 12, NULL, 'Tender is the Night: The Embrace', 'Tender is the Night: The Embrace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:519b8e40-8e9b-4cbe-84c9-8715c4bb2496'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Tender is the Night: The Embrace"', piece.title_en = 'Fahrenheit 451: Tender is the Night: The Embrace', piece.editor_locked = 1
WHERE piece.id = 8872 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10162 AND linked.composer_id = 112), 'musicbrainz:ad366e07-07f1-4d3b-995b-1dc9d91b5007', 13, NULL, 'The Ghost and Mrs. Muir: Andante Cantabile', 'The Ghost and Mrs. Muir: Andante Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad366e07-07f1-4d3b-995b-1dc9d91b5007'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "The Ghost and Mrs. Muir: Andante Cantabile"', piece.title_en = 'Fahrenheit 451: The Ghost and Mrs. Muir: Andante Cantabile', piece.editor_locked = 1
WHERE piece.id = 10162 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9418 AND linked.composer_id = 112), 'musicbrainz:77b4943e-04a8-47dd-97af-0db739721514', 14, NULL, 'Anna and the King of Slam: Prelude', 'Anna and the King of Slam: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77b4943e-04a8-47dd-97af-0db739721514'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Anna and the King of Slam: Prelude"', piece.title_en = 'Fahrenheit 451: Anna and the King of Slam: Prelude', piece.editor_locked = 1
WHERE piece.id = 9418 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9803 AND linked.composer_id = 112), 'musicbrainz:92ffc185-521f-4550-8b9b-42d5ef561dc7', 15, NULL, 'Anna and the King of Slam: Montage', 'Anna and the King of Slam: Montage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92ffc185-521f-4550-8b9b-42d5ef561dc7'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Anna and the King of Slam: Montage"', piece.title_en = 'Fahrenheit 451: Anna and the King of Slam: Montage', piece.editor_locked = 1
WHERE piece.id = 9803 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10237 AND linked.composer_id = 112), 'musicbrainz:b23680d0-0921-4705-afc4-5600dafbb037', 16, NULL, 'Anna and the King of Slam: Elegy', 'Anna and the King of Slam: Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b23680d0-0921-4705-afc4-5600dafbb037'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Anna and the King of Slam: Elegy"', piece.title_en = 'Fahrenheit 451: Anna and the King of Slam: Elegy', piece.editor_locked = 1
WHERE piece.id = 10237 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10110 AND linked.composer_id = 112), 'musicbrainz:a906b3c0-bb7f-483a-a581-6680e21119ce', 17, NULL, 'Anna and the King of Slam: Coronation', 'Anna and the King of Slam: Coronation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <화씨 451> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a906b3c0-bb7f-483a-a581-6680e21119ce'
);

UPDATE pieces piece
SET piece.title = '영화 <화씨 451> 사운드트랙 중 "Anna and the King of Slam: Coronation"', piece.title_en = 'Fahrenheit 451: Anna and the King of Slam: Coronation', piece.editor_locked = 1
WHERE piece.id = 10110 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Film Scores

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Film Scores', 'The Film Scores', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Film Scores'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11116 AND linked.composer_id = 112), 'musicbrainz:f49f6257-c1b7-4b7d-8886-edaa2e6313e8', 1, NULL, 'The Man Who Knew Too Much: Prelude', 'The Man Who Knew Too Much: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49f6257-c1b7-4b7d-8886-edaa2e6313e8'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "The Man Who Knew Too Much: Prelude"', piece.title_en = 'The Film Scores: The Man Who Knew Too Much: Prelude', piece.editor_locked = 1
WHERE piece.id = 11116 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74e35456-9a67-4ca2-89d3-a93aef4a9af4', 2, NULL, 'Psycho: A Suite for Strings: Prelude', 'Psycho: A Suite for Strings: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74e35456-9a67-4ca2-89d3-a93aef4a9af4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f4f4f6e-be79-47e1-ad3a-f39f40f86e14', 3, NULL, 'Psycho: A Suite for Strings: The City', 'Psycho: A Suite for Strings: The City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f4f4f6e-be79-47e1-ad3a-f39f40f86e14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea7c5ba-a0b8-48fc-bbe8-8c4f3f36ee44', 4, NULL, 'Psycho: A Suite for Strings: The Rainstorm', 'Psycho: A Suite for Strings: The Rainstorm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea7c5ba-a0b8-48fc-bbe8-8c4f3f36ee44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1bfbe33-f585-474f-8af0-10d86770e9b8', 5, NULL, 'Psycho: A Suite for Strings: The Madhouse', 'Psycho: A Suite for Strings: The Madhouse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1bfbe33-f585-474f-8af0-10d86770e9b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c63ce6b5-0e9e-4cd0-af32-7160ce4c9195', 6, NULL, 'Psycho: A Suite for Strings: The Murder', 'Psycho: A Suite for Strings: The Murder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c63ce6b5-0e9e-4cd0-af32-7160ce4c9195'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92b15290-3acc-498b-8714-2bb56a8b439c', 7, NULL, 'Psycho: A Suite for Strings: The Water', 'Psycho: A Suite for Strings: The Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92b15290-3acc-498b-8714-2bb56a8b439c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4fdaa13-f41c-4a85-8ef3-350afe448a8f', 8, NULL, 'Psycho: A Suite for Strings: The Swamp', 'Psycho: A Suite for Strings: The Swamp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4fdaa13-f41c-4a85-8ef3-350afe448a8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74cc5b79-ab45-4597-921b-88d0bfcd5fa4', 9, NULL, 'Psycho: A Suite for Strings: The Stairs', 'Psycho: A Suite for Strings: The Stairs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74cc5b79-ab45-4597-921b-88d0bfcd5fa4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:949ffa96-61e3-4f14-9711-59c6141f8281', 10, NULL, 'Psycho: A Suite for Strings: The Knife', 'Psycho: A Suite for Strings: The Knife', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:949ffa96-61e3-4f14-9711-59c6141f8281'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:780885d7-f82e-4cc0-a1d9-a28332734e0c', 11, NULL, 'Psycho: A Suite for Strings: The Cellar', 'Psycho: A Suite for Strings: The Cellar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:780885d7-f82e-4cc0-a1d9-a28332734e0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19aa4bcd-a22b-494a-99be-94f8a9fd6a2f', 12, NULL, 'Psycho: A Suite for Strings: Finale', 'Psycho: A Suite for Strings: Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19aa4bcd-a22b-494a-99be-94f8a9fd6a2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7714 AND linked.composer_id = 112), 'musicbrainz:c6f6a898-2e14-4005-84fa-160e7f4d1bc3', 13, NULL, 'Marnie: Suite: I. Prelude', 'Marnie: Suite: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6f6a898-2e14-4005-84fa-160e7f4d1bc3'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Marnie: Suite: I. Prelude"', piece.title_en = 'The Film Scores: Marnie: Suite: I. Prelude', piece.editor_locked = 1
WHERE piece.id = 7714 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8538 AND linked.composer_id = 112), 'musicbrainz:396bc7ad-d7bc-4011-8a76-4e2e8e7a4dad', 14, NULL, 'Marnie: Suite: II. The Hunt', 'Marnie: Suite: II. The Hunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:396bc7ad-d7bc-4011-8a76-4e2e8e7a4dad'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Marnie: Suite: II. The Hunt"', piece.title_en = 'The Film Scores: Marnie: Suite: II. The Hunt', piece.editor_locked = 1
WHERE piece.id = 8538 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e', 15, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:313aafa9-5a7c-4e5b-8a16-867961c94dca', 16, NULL, 'Vertigo Suite: I. Prelude', 'Vertigo Suite: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313aafa9-5a7c-4e5b-8a16-867961c94dca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1998b81d-596f-4b10-9dfd-047807890256', 17, NULL, 'Vertigo Suite: II. The Nightmare', 'Vertigo Suite: II. The Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1998b81d-596f-4b10-9dfd-047807890256'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb239e1a-3435-41c2-b32f-1aad4874dc07', 18, NULL, 'Vertigo Suite: III. Scene d’Amour', 'Vertigo Suite: III. Scene d’Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb239e1a-3435-41c2-b32f-1aad4874dc07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7712 AND linked.composer_id = 112), 'musicbrainz:a5aff613-70b9-4aca-aae8-2609f9415076', 19, NULL, 'Torn Curtain: I. Prelude', 'Torn Curtain: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5aff613-70b9-4aca-aae8-2609f9415076'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Torn Curtain: I. Prelude"', piece.title_en = 'The Film Scores: Torn Curtain: I. Prelude', piece.editor_locked = 1
WHERE piece.id = 7712 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8605 AND linked.composer_id = 112), 'musicbrainz:3fbada2f-384b-48f7-b8f4-44eaa0141a68', 20, NULL, 'Torn Curtain: II. Gromek', 'Torn Curtain: II. Gromek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fbada2f-384b-48f7-b8f4-44eaa0141a68'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Torn Curtain: II. Gromek"', piece.title_en = 'The Film Scores: Torn Curtain: II. Gromek', piece.editor_locked = 1
WHERE piece.id = 8605 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11139 AND linked.composer_id = 112), 'musicbrainz:f5f544d0-9d64-4c31-be65-198a6f0b6446', 21, NULL, 'Torn Curtain: III. The Killing', 'Torn Curtain: III. The Killing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5f544d0-9d64-4c31-be65-198a6f0b6446'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Torn Curtain: III. The Killing"', piece.title_en = 'The Film Scores: Torn Curtain: III. The Killing', piece.editor_locked = 1
WHERE piece.id = 11139 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8546 AND linked.composer_id = 112), 'musicbrainz:39e8ce1c-2f78-4502-8766-a5220fca8b46', 22, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Prelude', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39e8ce1c-2f78-4502-8766-a5220fca8b46'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: Prelude"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: Prelude', piece.editor_locked = 1
WHERE piece.id = 8546 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9550 AND linked.composer_id = 112), 'musicbrainz:808b3165-0912-40d4-9df0-8c786d6e7520', 23, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Fire Engine', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Fire Engine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:808b3165-0912-40d4-9df0-8c786d6e7520'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: Fire Engine"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: Fire Engine', piece.editor_locked = 1
WHERE piece.id = 9550 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9793 AND linked.composer_id = 112), 'musicbrainz:927f5721-6f06-493d-b71a-aec1211da79a', 24, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Bedroom', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Bedroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:927f5721-6f06-493d-b71a-aec1211da79a'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: The Bedroom"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: The Bedroom', piece.editor_locked = 1
WHERE piece.id = 9793 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10972 AND linked.composer_id = 112), 'musicbrainz:e9a3a3b5-a228-4ce2-9124-5e65cc5efe7b', 25, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Reading', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Reading', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9a3a3b5-a228-4ce2-9124-5e65cc5efe7b'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: The Reading"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: The Reading', piece.editor_locked = 1
WHERE piece.id = 10972 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7856 AND linked.composer_id = 112), 'musicbrainz:084a1887-3caf-4c1d-a436-e341a16328f7', 26, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Garden', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Garden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:084a1887-3caf-4c1d-a436-e341a16328f7'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: The Garden"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: The Garden', piece.editor_locked = 1
WHERE piece.id = 7856 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9260 AND linked.composer_id = 112), 'musicbrainz:6cb2077c-f964-40f0-868c-1e6779df55b3', 27, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Nightmare', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb2077c-f964-40f0-868c-1e6779df55b3'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: The Nightmare"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: The Nightmare', piece.editor_locked = 1
WHERE piece.id = 9260 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8617 AND linked.composer_id = 112), 'musicbrainz:40966ffe-5497-4c2b-b029-6a21c24c3468', 28, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Flowers of Fire', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Flowers of Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40966ffe-5497-4c2b-b029-6a21c24c3468'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: Flowers of Fire"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: Flowers of Fire', piece.editor_locked = 1
WHERE piece.id = 8617 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11277 AND linked.composer_id = 112), 'musicbrainz:fef2e95b-4f6c-413c-ac5d-8419fcc6f4b7', 29, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Flamethrower', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Flamethrower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fef2e95b-4f6c-413c-ac5d-8419fcc6f4b7'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: Flamethrower"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: Flamethrower', piece.editor_locked = 1
WHERE piece.id = 11277 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7733 AND linked.composer_id = 112), 'musicbrainz:0074ff3c-a697-47dd-84d9-0f6441a26837', 30, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Captain’s Death', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Captain’s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0074ff3c-a697-47dd-84d9-0f6441a26837'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: The Captain’s Death"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: The Captain’s Death', piece.editor_locked = 1
WHERE piece.id = 7733 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8039 AND linked.composer_id = 112), 'musicbrainz:1438bd55-38e5-49b1-b37d-f2e993c1a7dd', 31, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Road', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: The Road', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1438bd55-38e5-49b1-b37d-f2e993c1a7dd'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: The Road"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: The Road', piece.editor_locked = 1
WHERE piece.id = 8039 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10453 AND linked.composer_id = 112), 'musicbrainz:c332b79d-9d73-4f1d-a7a5-b6457525665c', 32, NULL, 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Finale', 'Fahrenheit 451: Suite for Strings, Harp and Percussion: Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c332b79d-9d73-4f1d-a7a5-b6457525665c'
);

UPDATE pieces piece
SET piece.title = 'The Film Scores 중 "Fahrenheit 451: Suite for Strings, Harp and Percussion: Finale"', piece.title_en = 'The Film Scores: Fahrenheit 451: Suite for Strings, Harp and Percussion: Finale', piece.editor_locked = 1
WHERE piece.id = 10453 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23490be3-8164-46de-9495-cc9111b1c7a1', 33, NULL, 'Taxi Driver: A Night-Piece for Orchestra With Obbligato Alto Sax: Prelude', 'Taxi Driver: A Night-Piece for Orchestra With Obbligato Alto Sax: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23490be3-8164-46de-9495-cc9111b1c7a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f9f1801-c564-4dc0-933f-16f146bd4cef', 34, NULL, 'Taxi Driver: A Night-Piece for Orchestra With Obbligato Alto Sax: Blues', 'Taxi Driver: A Night-Piece for Orchestra With Obbligato Alto Sax: Blues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f9f1801-c564-4dc0-933f-16f146bd4cef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75602c79-8219-4cb5-ade1-22584dfffa0d', 35, NULL, 'Taxi Driver: A Night-Piece for Orchestra With Obbligato Alto Sax: Night Prowl', 'Taxi Driver: A Night-Piece for Orchestra With Obbligato Alto Sax: Night Prowl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75602c79-8219-4cb5-ade1-22584dfffa0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3c39384-e516-4bf9-902a-bf4ad0a70cba', 36, NULL, 'Taxi Driver: A Night-Piece for Orchestra With Obbligato Alto Sax: Bloodbath', 'Taxi Driver: A Night-Piece for Orchestra With Obbligato Alto Sax: Bloodbath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3c39384-e516-4bf9-902a-bf4ad0a70cba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:005439e1-1937-45b6-98c1-6fa815db990d', 37, NULL, 'Taxi Driver: A Night‐Piece for Orchestra With Obbligato Alto Sax: Finale', 'Taxi Driver: A Night‐Piece for Orchestra With Obbligato Alto Sax: Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'The Film Scores' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:005439e1-1937-45b6-98c1-6fa815db990d'
);


-- None 영화 <케이프 피어> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <케이프 피어> 사운드트랙', 'Cape Fear', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <케이프 피어> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10398 AND linked.composer_id = 112), 'musicbrainz:bef636cc-fe47-49cb-8562-8da09852919f', 1, NULL, 'Max', 'Max', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bef636cc-fe47-49cb-8562-8da09852919f'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Max"', piece.title_en = 'Cape Fear: Max', piece.editor_locked = 1
WHERE piece.id = 10398 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10598 AND linked.composer_id = 112), 'musicbrainz:cd414598-2062-43fe-8894-15900d923cfd', 2, NULL, 'Sam''s Story', 'Sam''s Story', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd414598-2062-43fe-8894-15900d923cfd'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Sam''s Story"', piece.title_en = 'Cape Fear: Sam''s Story', piece.editor_locked = 1
WHERE piece.id = 10598 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7924 AND linked.composer_id = 112), 'musicbrainz:0cf2053e-3408-4238-9c65-6cbd1a27083b', 3, NULL, 'Love?', 'Love?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cf2053e-3408-4238-9c65-6cbd1a27083b'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Love?"', piece.title_en = 'Cape Fear: Love?', piece.editor_locked = 1
WHERE piece.id = 7924 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9281 AND linked.composer_id = 112), 'musicbrainz:6e610eeb-c3ab-41e4-9a19-a0c5ce3f552a', 4, NULL, 'Strip Search', 'Strip Search', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e610eeb-c3ab-41e4-9a19-a0c5ce3f552a'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Strip Search"', piece.title_en = 'Cape Fear: Strip Search', piece.editor_locked = 1
WHERE piece.id = 9281 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10334 AND linked.composer_id = 112), 'musicbrainz:b9b9e66b-4408-47a0-be9b-b732cb9414b7', 5, NULL, 'Rape and Hospital', 'Rape and Hospital', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9b9e66b-4408-47a0-be9b-b732cb9414b7'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Rape and Hospital"', piece.title_en = 'Cape Fear: Rape and Hospital', piece.editor_locked = 1
WHERE piece.id = 10334 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10265 AND linked.composer_id = 112), 'musicbrainz:b407d557-c6f9-4e11-8619-01812a1488af', 6, NULL, 'Frightened Sam', 'Frightened Sam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b407d557-c6f9-4e11-8619-01812a1488af'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Frightened Sam"', piece.title_en = 'Cape Fear: Frightened Sam', piece.editor_locked = 1
WHERE piece.id = 10265 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8827 AND linked.composer_id = 112), 'musicbrainz:4f210ef1-3eb1-4293-b521-ed281706845e', 7, NULL, 'Cady Meets the Girls', 'Cady Meets the Girls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f210ef1-3eb1-4293-b521-ed281706845e'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Cady Meets the Girls"', piece.title_en = 'Cape Fear: Cady Meets the Girls', piece.editor_locked = 1
WHERE piece.id = 8827 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11211 AND linked.composer_id = 112), 'musicbrainz:fae3459f-1b9c-4a70-8d6b-ae6cad556508', 8, NULL, 'Sam Hides', 'Sam Hides', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fae3459f-1b9c-4a70-8d6b-ae6cad556508'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Sam Hides"', piece.title_en = 'Cape Fear: Sam Hides', piece.editor_locked = 1
WHERE piece.id = 11211 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8951 AND linked.composer_id = 112), 'musicbrainz:56ef14c1-eac1-44ba-8492-8d9c8ca63702', 9, NULL, 'Drive', 'Drive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56ef14c1-eac1-44ba-8492-8d9c8ca63702'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Drive"', piece.title_en = 'Cape Fear: Drive', piece.editor_locked = 1
WHERE piece.id = 8951 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8105 AND linked.composer_id = 112), 'musicbrainz:195a1bf5-da0a-4681-8ca9-54d9aba5b82d', 10, NULL, 'Teddy Bear Wired', 'Teddy Bear Wired', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:195a1bf5-da0a-4681-8ca9-54d9aba5b82d'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Teddy Bear Wired"', piece.title_en = 'Cape Fear: Teddy Bear Wired', piece.editor_locked = 1
WHERE piece.id = 8105 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9171 AND linked.composer_id = 112), 'musicbrainz:65f3df62-388a-4801-9ebf-c830d2201b7a', 11, NULL, 'Kersek Killed', 'Kersek Killed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f3df62-388a-4801-9ebf-c830d2201b7a'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Kersek Killed"', piece.title_en = 'Cape Fear: Kersek Killed', piece.editor_locked = 1
WHERE piece.id = 9171 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10661 AND linked.composer_id = 112), 'musicbrainz:d206cbd9-677c-47bb-a551-aa7a7d5ac0ee', 12, NULL, 'Houseboat', 'Houseboat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d206cbd9-677c-47bb-a551-aa7a7d5ac0ee'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Houseboat"', piece.title_en = 'Cape Fear: Houseboat', piece.editor_locked = 1
WHERE piece.id = 10661 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0005024d-1324-4b1b-b402-849de7ad3c48', 13, NULL, 'The Fight', 'The Fight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0005024d-1324-4b1b-b402-849de7ad3c48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9984 AND linked.composer_id = 112), 'musicbrainz:a0791f3e-ae51-4283-8f87-a9e222da5fdb', 14, NULL, 'Destruction', 'Destruction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0791f3e-ae51-4283-8f87-a9e222da5fdb'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "Destruction"', piece.title_en = 'Cape Fear: Destruction', piece.editor_locked = 1
WHERE piece.id = 9984 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11174 AND linked.composer_id = 112), 'musicbrainz:f88ca7e7-8029-4fe5-b31c-2b9f2751a9ae', 15, NULL, 'The End', 'The End', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <케이프 피어> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f88ca7e7-8029-4fe5-b31c-2b9f2751a9ae'
);

UPDATE pieces piece
SET piece.title = '영화 <케이프 피어> 사운드트랙 중 "The End"', piece.title_en = 'Cape Fear: The End', piece.editor_locked = 1
WHERE piece.id = 11174 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <시민 케인> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <시민 케인> 사운드트랙', 'Citizen Kane: Music From the 1941 Motion Picture Score', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <시민 케인> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f95ac23f-3961-3252-aa65-477f702f3a53', 1, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f95ac23f-3961-3252-aa65-477f702f3a53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9007 AND linked.composer_id = 112), 'musicbrainz:5a4fdadb-3072-30c7-b128-21891b966340', 2, NULL, 'Susan in Night Club (Rain Sequence)', 'Susan in Night Club (Rain Sequence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a4fdadb-3072-30c7-b128-21891b966340'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Susan in Night Club (Rain Sequence)"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Susan in Night Club (Rain Sequence)', piece.editor_locked = 1
WHERE piece.id = 9007 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8585 AND linked.composer_id = 112), 'musicbrainz:3dcc4715-1205-3de8-b4ff-f28846c06ba7', 3, NULL, 'Thatcher Library (Litany) / Ms. Reading & Snow Picture / Mother''s Sacrifice / Charlie Meets Thatcher', 'Thatcher Library (Litany) / Ms. Reading & Snow Picture / Mother''s Sacrifice / Charlie Meets Thatcher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dcc4715-1205-3de8-b4ff-f28846c06ba7'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Thatcher Library (Litany) / Ms. Reading & Snow Picture / Mother''s Sacrifice / Charlie Meets Thatcher"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Thatcher Library (Litany) / Ms. Reading & Snow Picture / Mother''s Sacrifice / Charlie Meets Thatcher', piece.editor_locked = 1
WHERE piece.id = 8585 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3af0a80-d213-39cc-b4d7-87769ea22fb6', 4, NULL, 'Galop', 'Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3af0a80-d213-39cc-b4d7-87769ea22fb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9188 AND linked.composer_id = 112), 'musicbrainz:67cb7bc5-97cd-301e-b2c9-2a32d0e9b457', 5, NULL, 'Dissolve to Thatcher / Second Ms. / Bernstein''s Narration', 'Dissolve to Thatcher / Second Ms. / Bernstein''s Narration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67cb7bc5-97cd-301e-b2c9-2a32d0e9b457'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Dissolve to Thatcher / Second Ms. / Bernstein''s Narration"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Dissolve to Thatcher / Second Ms. / Bernstein''s Narration', piece.editor_locked = 1
WHERE piece.id = 9188 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10771 AND linked.composer_id = 112), 'musicbrainz:da092869-46c7-3cc9-9217-15bd6d58460c', 6, NULL, 'Kane''s News Office / Carter''s Exit / Chronicle Scherzo', 'Kane''s News Office / Carter''s Exit / Chronicle Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da092869-46c7-3cc9-9217-15bd6d58460c'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Kane''s News Office / Carter''s Exit / Chronicle Scherzo"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Kane''s News Office / Carter''s Exit / Chronicle Scherzo', piece.editor_locked = 1
WHERE piece.id = 10771 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2280c85f-c068-3f2b-8d8d-0c87f5568f33', 7, NULL, 'Bernstein''s Presto', 'Bernstein''s Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2280c85f-c068-3f2b-8d8d-0c87f5568f33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10800 AND linked.composer_id = 112), 'musicbrainz:dcdbf5e7-6769-394e-924f-2dad74537ee5', 8, NULL, 'Kane''s Return / Valse Presentation', 'Kane''s Return / Valse Presentation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcdbf5e7-6769-394e-924f-2dad74537ee5'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Kane''s Return / Valse Presentation"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Kane''s Return / Valse Presentation', piece.editor_locked = 1
WHERE piece.id = 10800 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10134 AND linked.composer_id = 112), 'musicbrainz:aac3c941-a63b-3892-9533-3f0223b55ebe', 9, NULL, 'Sunset Narrative', 'Sunset Narrative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aac3c941-a63b-3892-9533-3f0223b55ebe'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Sunset Narrative"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Sunset Narrative', piece.editor_locked = 1
WHERE piece.id = 10134 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10082 AND linked.composer_id = 112), 'musicbrainz:a6ae7109-c26e-327f-8d87-794cb35d4848', 10, NULL, 'Theme and Variations (Breakfast Montage)', 'Theme and Variations (Breakfast Montage)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6ae7109-c26e-327f-8d87-794cb35d4848'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Theme and Variations (Breakfast Montage)"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Theme and Variations (Breakfast Montage)', piece.editor_locked = 1
WHERE piece.id = 10082 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7800 AND linked.composer_id = 112), 'musicbrainz:04a2178b-29c4-330b-86f5-498db975636c', 11, NULL, 'Kane Meets Susan / Susan''s Room / Mother Memory', 'Kane Meets Susan / Susan''s Room / Mother Memory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04a2178b-29c4-330b-86f5-498db975636c'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Kane Meets Susan / Susan''s Room / Mother Memory"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Kane Meets Susan / Susan''s Room / Mother Memory', piece.editor_locked = 1
WHERE piece.id = 7800 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8165 AND linked.composer_id = 112), 'musicbrainz:1de3858a-beff-39c3-a307-7abc66ec516f', 12, NULL, 'The Trip to Susan''s / Getty''s Departure / Kane Marries', 'The Trip to Susan''s / Getty''s Departure / Kane Marries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1de3858a-beff-39c3-a307-7abc66ec516f'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "The Trip to Susan''s / Getty''s Departure / Kane Marries"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: The Trip to Susan''s / Getty''s Departure / Kane Marries', piece.editor_locked = 1
WHERE piece.id = 8165 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2f80f82-71a1-369c-8b0a-e67c983c4bf2', 13, NULL, 'Salaambo''s Aria', 'Salaambo''s Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2f80f82-71a1-369c-8b0a-e67c983c4bf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1055147d-064e-363f-a1a9-0e88cd7ca2cf', 14, NULL, 'Leland''s Dismissal', 'Leland''s Dismissal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1055147d-064e-363f-a1a9-0e88cd7ca2cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebbff3ea-15f6-3a6f-b6ef-afe74f921a69', 15, NULL, 'Susan in Night Club (New Dawn Sequence)', 'Susan in Night Club (New Dawn Sequence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebbff3ea-15f6-3a6f-b6ef-afe74f921a69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9058 AND linked.composer_id = 112), 'musicbrainz:5dd102dd-74d2-3316-bb0e-2f7e6151d4b6', 16, NULL, 'Opera Montage', 'Opera Montage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dd102dd-74d2-3316-bb0e-2f7e6151d4b6'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Opera Montage"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Opera Montage', piece.editor_locked = 1
WHERE piece.id = 9058 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10526 AND linked.composer_id = 112), 'musicbrainz:c85a74de-8910-3c58-bc47-b2d77f9b943b', 17, NULL, 'Xanadu / Jigsaw Puzzles (Perpetual Motion) / Second Xanadu', 'Xanadu / Jigsaw Puzzles (Perpetual Motion) / Second Xanadu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c85a74de-8910-3c58-bc47-b2d77f9b943b'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Xanadu / Jigsaw Puzzles (Perpetual Motion) / Second Xanadu"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Xanadu / Jigsaw Puzzles (Perpetual Motion) / Second Xanadu', piece.editor_locked = 1
WHERE piece.id = 10526 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8581 AND linked.composer_id = 112), 'musicbrainz:3d34d1a4-b195-3596-826d-91d8922955e5', 18, NULL, 'Kane''s Picnic / Susan Leaves', 'Kane''s Picnic / Susan Leaves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d34d1a4-b195-3596-826d-91d8922955e5'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "Kane''s Picnic / Susan Leaves"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: Kane''s Picnic / Susan Leaves', piece.editor_locked = 1
WHERE piece.id = 8581 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9283 AND linked.composer_id = 112), 'musicbrainz:6e7835cb-242d-37c8-9760-18b77173ba43', 19, NULL, 'El Rancho (Second Dawn Sequence)', 'El Rancho (Second Dawn Sequence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e7835cb-242d-37c8-9760-18b77173ba43'
);

UPDATE pieces piece
SET piece.title = '영화 <시민 케인> 사운드트랙 중 "El Rancho (Second Dawn Sequence)"', piece.title_en = 'Citizen Kane: Music From the 1941 Motion Picture Score: El Rancho (Second Dawn Sequence)', piece.editor_locked = 1
WHERE piece.id = 9283 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6aa0eeb-e1ee-34fa-b6a7-8e583519c45d', 20, NULL, 'The Glass Ball', 'The Glass Ball', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6aa0eeb-e1ee-34fa-b6a7-8e583519c45d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41', 21, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <시민 케인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41'
);


-- None 영화 <유령과 뮤어 부인> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <유령과 뮤어 부인> 사운드트랙', 'The Ghost and Mrs. Muir', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <유령과 뮤어 부인> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8027 AND linked.composer_id = 112), 'musicbrainz:1387d22f-cca1-4ef5-8211-f1e9a142d78f', 1, NULL, 'Prelude / Local Train / The Sea', 'Prelude / Local Train / The Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1387d22f-cca1-4ef5-8211-f1e9a142d78f'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Prelude / Local Train / The Sea"', piece.title_en = 'The Ghost and Mrs. Muir: Prelude / Local Train / The Sea', piece.editor_locked = 1
WHERE piece.id = 8027 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10355 AND linked.composer_id = 112), 'musicbrainz:bafe3cae-703c-48a0-bd31-1fdc5b722b5c', 2, NULL, 'The Ghost / The Storm / The Apparition', 'The Ghost / The Storm / The Apparition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bafe3cae-703c-48a0-bd31-1fdc5b722b5c'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Ghost / The Storm / The Apparition"', piece.title_en = 'The Ghost and Mrs. Muir: The Ghost / The Storm / The Apparition', piece.editor_locked = 1
WHERE piece.id = 10355 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8245 AND linked.composer_id = 112), 'musicbrainz:254a4517-e20e-4e9a-939c-db4a931ad3fe', 3, NULL, 'The Lights / Bedtime', 'The Lights / Bedtime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:254a4517-e20e-4e9a-939c-db4a931ad3fe'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Lights / Bedtime"', piece.title_en = 'The Ghost and Mrs. Muir: The Lights / Bedtime', piece.editor_locked = 1
WHERE piece.id = 8245 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9572 AND linked.composer_id = 112), 'musicbrainz:82974a15-d4cd-4bde-8fbd-ff5953cca7a2', 4, NULL, 'Poetry', 'Poetry', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82974a15-d4cd-4bde-8fbd-ff5953cca7a2'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Poetry"', piece.title_en = 'The Ghost and Mrs. Muir: Poetry', piece.editor_locked = 1
WHERE piece.id = 9572 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8922 AND linked.composer_id = 112), 'musicbrainz:5523d3e7-2abd-498e-bc8c-e378c5921d7b', 5, NULL, 'Lucia / Dictation / Boyhood''s End / Pastoral', 'Lucia / Dictation / Boyhood''s End / Pastoral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5523d3e7-2abd-498e-bc8c-e378c5921d7b'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Lucia / Dictation / Boyhood''s End / Pastoral"', piece.title_en = 'The Ghost and Mrs. Muir: Lucia / Dictation / Boyhood''s End / Pastoral', piece.editor_locked = 1
WHERE piece.id = 8922 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7665060-4045-4a01-8d59-9f59c3acd390', 6, NULL, 'Nocturne', 'Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7665060-4045-4a01-8d59-9f59c3acd390'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9598 AND linked.composer_id = 112), 'musicbrainz:845949f6-a2fb-4861-a86f-468af4ba6615', 7, NULL, 'London / The Reading / Local Train', 'London / The Reading / Local Train', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:845949f6-a2fb-4861-a86f-468af4ba6615'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "London / The Reading / Local Train"', piece.title_en = 'The Ghost and Mrs. Muir: London / The Reading / Local Train', piece.editor_locked = 1
WHERE piece.id = 9598 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9771 AND linked.composer_id = 112), 'musicbrainz:90d2101b-185e-4acb-9194-2e1f7a09d771', 8, NULL, 'The Spring Sea', 'The Spring Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90d2101b-185e-4acb-9194-2e1f7a09d771'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Spring Sea"', piece.title_en = 'The Ghost and Mrs. Muir: The Spring Sea', piece.editor_locked = 1
WHERE piece.id = 9771 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10290 AND linked.composer_id = 112), 'musicbrainz:b685f529-e1d1-43ae-ae19-75e2f6c88de9', 9, NULL, 'Romance / Love / Farewell', 'Romance / Love / Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b685f529-e1d1-43ae-ae19-75e2f6c88de9'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Romance / Love / Farewell"', piece.title_en = 'The Ghost and Mrs. Muir: Romance / Love / Farewell', piece.editor_locked = 1
WHERE piece.id = 10290 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7905 AND linked.composer_id = 112), 'musicbrainz:0b5e7e56-fc20-495b-a0d6-7af415bc53d6', 10, NULL, 'The Home / Sorrow', 'The Home / Sorrow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b5e7e56-fc20-495b-a0d6-7af415bc53d6'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Home / Sorrow"', piece.title_en = 'The Ghost and Mrs. Muir: The Home / Sorrow', piece.editor_locked = 1
WHERE piece.id = 7905 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9280 AND linked.composer_id = 112), 'musicbrainz:6e567fdb-2dc8-46af-8945-bf21de4404f9', 11, NULL, 'The Passing Years / The Late Sea', 'The Passing Years / The Late Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e567fdb-2dc8-46af-8945-bf21de4404f9'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "The Passing Years / The Late Sea"', piece.title_en = 'The Ghost and Mrs. Muir: The Passing Years / The Late Sea', piece.editor_locked = 1
WHERE piece.id = 9280 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9299 AND linked.composer_id = 112), 'musicbrainz:6f53cee9-78c4-49b3-8916-660b17b69b20', 12, NULL, 'Forever', 'Forever', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = '영화 <유령과 뮤어 부인> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f53cee9-78c4-49b3-8916-660b17b69b20'
);

UPDATE pieces piece
SET piece.title = '영화 <유령과 뮤어 부인> 사운드트랙 중 "Forever"', piece.title_en = 'The Ghost and Mrs. Muir: Forever', piece.editor_locked = 1
WHERE piece.id = 9299 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <사이코> 사운드트랙

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10569 AND linked.composer_id = 112),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Intro/Logos', part.name_en = 'Intro/Logos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:cb6afe97-acb1-4848-bda1-2ecbe99c2ef4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10569 AND linked.composer_id = 112), 'musicbrainz:cb6afe97-acb1-4848-bda1-2ecbe99c2ef4', 1, NULL, 'Intro/Logos', 'Intro/Logos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb6afe97-acb1-4848-bda1-2ecbe99c2ef4'
);

UPDATE pieces piece
SET piece.title = '영화 <사이코> 사운드트랙 중 "Intro/Logos"', piece.title_en = 'Psycho Soundtrack: Intro/Logos', piece.editor_locked = 1
WHERE piece.id = 10569 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:b8a627a0-8981-42fe-813b-b583a8b861a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8a627a0-8981-42fe-813b-b583a8b861a7', 2, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8a627a0-8981-42fe-813b-b583a8b861a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The City', part.name_en = 'The City',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:33b75800-8236-41a6-9cc3-20ffb5155372' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33b75800-8236-41a6-9cc3-20ffb5155372', 3, NULL, 'The City', 'The City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33b75800-8236-41a6-9cc3-20ffb5155372'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Marion and Sam', part.name_en = 'Marion and Sam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ad784efd-e53f-4f17-b2f7-17713debbcd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad784efd-e53f-4f17-b2f7-17713debbcd2', 4, NULL, 'Marion and Sam', 'Marion and Sam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad784efd-e53f-4f17-b2f7-17713debbcd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Temptation', part.name_en = 'Temptation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:8196fc58-998c-4f93-bf7b-29baa2c69348' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8196fc58-998c-4f93-bf7b-29baa2c69348', 5, NULL, 'Temptation', 'Temptation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8196fc58-998c-4f93-bf7b-29baa2c69348'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The Rainstorm', part.name_en = 'The Rainstorm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:aa644bc6-6a9f-41f8-8442-25af2219660f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa644bc6-6a9f-41f8-8442-25af2219660f', 6, NULL, 'The Rainstorm', 'The Rainstorm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa644bc6-6a9f-41f8-8442-25af2219660f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Peephole', part.name_en = 'The Peephole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:f4dcf2e5-c264-438e-8bb1-5e40f3b44a37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4dcf2e5-c264-438e-8bb1-5e40f3b44a37', 7, NULL, 'The Peephole', 'The Peephole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4dcf2e5-c264-438e-8bb1-5e40f3b44a37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Murder', part.name_en = 'The Murder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:1ebd8b21-c646-407f-939a-b66784ed7ff3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebd8b21-c646-407f-939a-b66784ed7ff3', 8, NULL, 'The Murder', 'The Murder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebd8b21-c646-407f-939a-b66784ed7ff3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9078 AND linked.composer_id = 112),
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Clean Up', part.name_en = 'The Clean Up',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:5f9858fc-8528-4e9b-83fa-61811606f25d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9078 AND linked.composer_id = 112), 'musicbrainz:5f9858fc-8528-4e9b-83fa-61811606f25d', 9, NULL, 'The Clean Up', 'The Clean Up', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f9858fc-8528-4e9b-83fa-61811606f25d'
);

UPDATE pieces piece
SET piece.title = '영화 <사이코> 사운드트랙 중 "The Clean Up"', piece.title_en = 'Psycho Soundtrack: The Clean Up', piece.editor_locked = 1
WHERE piece.id = 9078 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Car', part.name_en = 'The Car',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:14094ba4-0f87-49f0-b517-584fda210353' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14094ba4-0f87-49f0-b517-584fda210353', 10, NULL, 'The Car', 'The Car', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14094ba4-0f87-49f0-b517-584fda210353'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Swamp', part.name_en = 'The Swamp',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:bec90a98-fef7-4e11-af5b-c81679b70cc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bec90a98-fef7-4e11-af5b-c81679b70cc8', 11, NULL, 'The Swamp', 'The Swamp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bec90a98-fef7-4e11-af5b-c81679b70cc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'The Curtain', part.name_en = 'The Curtain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:18a9cab4-d62e-4dfe-98c9-3a8f700349c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18a9cab4-d62e-4dfe-98c9-3a8f700349c8', 12, NULL, 'The Curtain', 'The Curtain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18a9cab4-d62e-4dfe-98c9-3a8f700349c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The Search', part.name_en = 'The Search',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:3d6a1004-79f4-4676-b51e-c29fda991690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d6a1004-79f4-4676-b51e-c29fda991690', 13, NULL, 'The Search', 'The Search', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d6a1004-79f4-4676-b51e-c29fda991690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Stairs', part.name_en = 'The Stairs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d2a5c761-2bde-4077-b0a0-cfa88878d69f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2a5c761-2bde-4077-b0a0-cfa88878d69f', 14, NULL, 'The Stairs', 'The Stairs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2a5c761-2bde-4077-b0a0-cfa88878d69f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The Knife', part.name_en = 'The Knife',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:de18e4f3-769a-4ffe-ab4c-9f33def026f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de18e4f3-769a-4ffe-ab4c-9f33def026f2', 15, NULL, 'The Knife', 'The Knife', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de18e4f3-769a-4ffe-ab4c-9f33def026f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9781 AND linked.composer_id = 112),
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The 1st Floor', part.name_en = 'The 1st Floor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:91cc27d4-9278-4b46-99f2-fb1b604da084' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9781 AND linked.composer_id = 112), 'musicbrainz:91cc27d4-9278-4b46-99f2-fb1b604da084', 16, NULL, 'The 1st Floor', 'The 1st Floor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91cc27d4-9278-4b46-99f2-fb1b604da084'
);

UPDATE pieces piece
SET piece.title = '영화 <사이코> 사운드트랙 중 "The 1st Floor"', piece.title_en = 'Psycho Soundtrack: The 1st Floor', piece.editor_locked = 1
WHERE piece.id = 9781 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10766 AND linked.composer_id = 112),
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'The Search B', part.name_en = 'The Search B',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:d9deab28-5adc-4491-9013-287923701c29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10766 AND linked.composer_id = 112), 'musicbrainz:d9deab28-5adc-4491-9013-287923701c29', 17, NULL, 'The Search B', 'The Search B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9deab28-5adc-4491-9013-287923701c29'
);

UPDATE pieces piece
SET piece.title = '영화 <사이코> 사운드트랙 중 "The Search B"', piece.title_en = 'Psycho Soundtrack: The Search B', piece.editor_locked = 1
WHERE piece.id = 10766 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'The Hill', part.name_en = 'The Hill',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:2b750e7b-7dd2-4cee-aac4-3f68fff02170' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b750e7b-7dd2-4cee-aac4-3f68fff02170', 18, NULL, 'The Hill', 'The Hill', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b750e7b-7dd2-4cee-aac4-3f68fff02170'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'The Bedroom', part.name_en = 'The Bedroom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:e5e8ba69-1917-4fbd-bcf7-b2c43a362335' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5e8ba69-1917-4fbd-bcf7-b2c43a362335', 19, NULL, 'The Bedroom', 'The Bedroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5e8ba69-1917-4fbd-bcf7-b2c43a362335'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 7818 AND linked.composer_id = 112),
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'The Cellar, Part 1', part.name_en = 'The Cellar, Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:05d808e0-f3a2-4b7a-9d3b-b247f4825566' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7818 AND linked.composer_id = 112), 'musicbrainz:05d808e0-f3a2-4b7a-9d3b-b247f4825566', 20, NULL, 'The Cellar, Part 1', 'The Cellar, Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05d808e0-f3a2-4b7a-9d3b-b247f4825566'
);

UPDATE pieces piece
SET piece.title = '영화 <사이코> 사운드트랙 중 "The Cellar, Part 1"', piece.title_en = 'Psycho Soundtrack: The Cellar, Part 1', piece.editor_locked = 1
WHERE piece.id = 7818 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8751 AND linked.composer_id = 112),
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'The Discovery', part.name_en = 'The Discovery',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:4974307a-7e2c-445c-b739-a32a4d528b1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8751 AND linked.composer_id = 112), 'musicbrainz:4974307a-7e2c-445c-b739-a32a4d528b1b', 21, NULL, 'The Discovery', 'The Discovery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4974307a-7e2c-445c-b739-a32a4d528b1b'
);

UPDATE pieces piece
SET piece.title = '영화 <사이코> 사운드트랙 중 "The Discovery"', piece.title_en = 'Psycho Soundtrack: The Discovery', piece.editor_locked = 1
WHERE piece.id = 8751 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10172 AND linked.composer_id = 112),
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'The Finale', part.name_en = 'The Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 419 AND p.composer_id = 112 AND part.part_key = 'musicbrainz:ad99d1dd-084d-4e03-b6f9-7add1658f658' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10172 AND linked.composer_id = 112), 'musicbrainz:ad99d1dd-084d-4e03-b6f9-7add1658f658', 22, NULL, 'The Finale', 'The Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 419 AND p.composer_id = 112
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad99d1dd-084d-4e03-b6f9-7add1658f658'
);

UPDATE pieces piece
SET piece.title = '영화 <사이코> 사운드트랙 중 "The Finale"', piece.title_en = 'Psycho Soundtrack: The Finale', piece.editor_locked = 1
WHERE piece.id = 10172 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Child Is Born (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A Child Is Born (음반)', 'A Child Is Born', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A Child Is Born (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9387 AND linked.composer_id = 112), 'musicbrainz:75300ea3-86a2-415a-9017-855a2700341a', 1, NULL, 'Part 1', 'A Child Is Born - Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'A Child Is Born (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75300ea3-86a2-415a-9017-855a2700341a'
);

UPDATE pieces piece
SET piece.title = 'A Child Is Born (음반) 중 "Part 1"', piece.title_en = 'A Child Is Born: A Child Is Born - Part 1', piece.editor_locked = 1
WHERE piece.id = 9387 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7984 AND linked.composer_id = 112), 'musicbrainz:11208d04-ba4f-4829-a6a0-2f594b86f288', 2, NULL, 'Part 2', 'A Child Is Born - Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'A Child Is Born (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11208d04-ba4f-4829-a6a0-2f594b86f288'
);

UPDATE pieces piece
SET piece.title = 'A Child Is Born (음반) 중 "Part 2"', piece.title_en = 'A Child Is Born: A Child Is Born - Part 2', piece.editor_locked = 1
WHERE piece.id = 7984 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Psycho Suite for String Quartet / Souvenirs de voyage / Echoes

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes', 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8829 AND linked.composer_id = 112), 'musicbrainz:4f497fcb-cb76-4bc8-b6d3-f129d77755b5', 1, NULL, 'Echoes', 'Echoes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f497fcb-cb76-4bc8-b6d3-f129d77755b5'
);

UPDATE pieces piece
SET piece.title = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes 중 "Echoes"', piece.title_en = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes: Echoes', piece.editor_locked = 1
WHERE piece.id = 8829 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:955682fd-a239-424b-93d7-9f3b6079beab', 2, NULL, 'Souvenirs de voyage: I. Lento (Molto tranquilo)', 'Souvenirs de voyage: I. Lento (Molto tranquilo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:955682fd-a239-424b-93d7-9f3b6079beab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c4b9f89-7015-493f-b72b-e5995ba34965', 3, NULL, 'Souvenirs de voyage: II. Andante (Berceuse)', 'Souvenirs de voyage: II. Andante (Berceuse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c4b9f89-7015-493f-b72b-e5995ba34965'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d895de2-dfd0-4c20-a2c5-55f3479bd178', 4, NULL, 'Souvenirs de voyage: III. Andantino (Canto amoroso)', 'Souvenirs de voyage: III. Andantino (Canto amoroso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d895de2-dfd0-4c20-a2c5-55f3479bd178'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8888 AND linked.composer_id = 112), 'musicbrainz:52ce1f3c-449d-485b-9820-6a317f5125cf', 5, NULL, 'Psycho Suite', 'Psycho Suite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52ce1f3c-449d-485b-9820-6a317f5125cf'
);

UPDATE pieces piece
SET piece.title = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes 중 "Psycho Suite"', piece.title_en = 'Psycho Suite for String Quartet / Souvenirs de voyage / Echoes: Psycho Suite', piece.editor_locked = 1
WHERE piece.id = 8888 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Citizen Kane: The Essential Bernard Herrmann Film Music Collection

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection', 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f49f6257-c1b7-4b7d-8886-edaa2e6313e8', 1, NULL, 'The Man Who Knew Too Much: Prelude', 'The Man Who Knew Too Much: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49f6257-c1b7-4b7d-8886-edaa2e6313e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f6d9351-921a-402a-8513-cabca17f8f6a', 2, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f6d9351-921a-402a-8513-cabca17f8f6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e', 3, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d6fba74-ca08-344f-90f8-1b7a3ec24488', 4, NULL, 'Conversation Piece', 'Conversation Piece', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d6fba74-ca08-344f-90f8-1b7a3ec24488'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5aff613-70b9-4aca-aae8-2609f9415076', 5, NULL, 'Torn Curtain: I. Prelude', 'Torn Curtain: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5aff613-70b9-4aca-aae8-2609f9415076'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fbada2f-384b-48f7-b8f4-44eaa0141a68', 6, NULL, 'Torn Curtain: II. Gromek', 'Torn Curtain: II. Gromek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fbada2f-384b-48f7-b8f4-44eaa0141a68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5f544d0-9d64-4c31-be65-198a6f0b6446', 7, NULL, 'Torn Curtain: III. The Killing', 'Torn Curtain: III. The Killing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5f544d0-9d64-4c31-be65-198a6f0b6446'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8970 AND linked.composer_id = 112), 'musicbrainz:5817e145-e557-30c5-89c9-f52923ad0a1e', 8, NULL, 'The Twilight Zone (Theme)', 'The Twilight Zone (Theme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5817e145-e557-30c5-89c9-f52923ad0a1e'
);

UPDATE pieces piece
SET piece.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection 중 "The Twilight Zone (Theme)"', piece.title_en = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection: The Twilight Zone (Theme)', piece.editor_locked = 1
WHERE piece.id = 8970 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6f6a898-2e14-4005-84fa-160e7f4d1bc3', 9, NULL, 'Marnie: Suite: I. Prelude', 'Marnie: Suite: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6f6a898-2e14-4005-84fa-160e7f4d1bc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bd24ea7-7cb0-4456-a992-77e8832ad3f6', 10, NULL, 'Main Title', 'Main Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bd24ea7-7cb0-4456-a992-77e8832ad3f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22507362-73c3-4bc2-8a18-121b5b324a6a', 11, NULL, 'At the School', 'At the School', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22507362-73c3-4bc2-8a18-121b5b324a6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a459680-fca8-4963-985e-c9e13af6c1ef', 12, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a459680-fca8-4963-985e-c9e13af6c1ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d02df9de-5577-4367-874b-024e9ec07cdd', 13, NULL, 'Jason and the Argonauts: Prelude', 'Jason and the Argonauts: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d02df9de-5577-4367-874b-024e9ec07cdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fedeb3d1-f672-470c-80c1-c546f8d10293', 14, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fedeb3d1-f672-470c-80c1-c546f8d10293'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:936912a3-1acb-3e7f-a461-08b1c8e14ea8', 15, NULL, 'Outer Space', 'Outer Space', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:936912a3-1acb-3e7f-a461-08b1c8e14ea8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:686b404a-2675-3455-86d2-abe66c49361e', 16, NULL, 'The Day the Earth Stood Still (Radar)', 'The Day the Earth Stood Still (Radar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:686b404a-2675-3455-86d2-abe66c49361e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04c4b35b-4640-31a1-a684-9e833a208f3d', 17, NULL, 'The Day the Earth Stood Still (Farewell & Finale)', 'The Day the Earth Stood Still (Farewell & Finale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04c4b35b-4640-31a1-a684-9e833a208f3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fb04490-463d-417b-a144-41d8eca54107', 18, NULL, 'Valse Lente', 'Valse Lente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fb04490-463d-417b-a144-41d8eca54107'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb59aaf-d6a7-4d95-9fea-0c56461a19be', 19, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb59aaf-d6a7-4d95-9fea-0c56461a19be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9cc1a62-1460-4080-8980-cd4af10af32c', 20, NULL, 'The City', 'The City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9cc1a62-1460-4080-8980-cd4af10af32c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2878fafe-7c81-403f-a640-b1b4a1104889', 21, NULL, 'The Rainstorm', 'The Rainstorm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2878fafe-7c81-403f-a640-b1b4a1104889'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd03b83b-3cf7-48b3-8040-b574c05c23b0', 22, NULL, 'The Murder', 'The Murder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd03b83b-3cf7-48b3-8040-b574c05c23b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a48fbf7a-c641-4c6f-bffa-6ecf6c793940', 23, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a48fbf7a-c641-4c6f-bffa-6ecf6c793940'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7672 AND linked.composer_id = 112), 'musicbrainz:579a3017-04d1-3fc6-8e70-df3b618436ce', 24, NULL, 'A Portrait of “Hitch”', 'A Portrait of “Hitch”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:579a3017-04d1-3fc6-8e70-df3b618436ce'
);

UPDATE pieces piece
SET piece.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection 중 "A Portrait of “Hitch”"', piece.title_en = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection: A Portrait of “Hitch”', piece.editor_locked = 1
WHERE piece.id = 7672 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80e8e815-cd04-415b-9514-749541c30350', 25, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80e8e815-cd04-415b-9514-749541c30350'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c69d44a0-c192-4d60-8f4f-5fa9605395b7', 26, NULL, 'The Nightmare', 'The Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c69d44a0-c192-4d60-8f4f-5fa9605395b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0508898-0582-4d5e-9efd-ffd545ddfe81', 27, NULL, 'Scène d’amour', 'Scène d’amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0508898-0582-4d5e-9efd-ffd545ddfe81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83105744-14b9-4104-ae55-f2da53ecfb88', 28, NULL, 'Main Theme', 'Main Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane: The Essential Bernard Herrmann Film Music Collection' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83105744-14b9-4104-ae55-f2da53ecfb88'
);


-- None Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver', 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41', 1, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4376832b-0d65-387e-9190-d5edf5419aed', 2, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4376832b-0d65-387e-9190-d5edf5419aed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8974 AND linked.composer_id = 112), 'musicbrainz:5879369c-43ec-47c6-acb0-7d3e3f692176', 3, NULL, 'The Devil and Daniel Webster', 'The Devil and Daniel Webster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5879369c-43ec-47c6-acb0-7d3e3f692176'
);

UPDATE pieces piece
SET piece.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver 중 "The Devil and Daniel Webster"', piece.title_en = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver: The Devil and Daniel Webster', piece.editor_locked = 1
WHERE piece.id = 8974 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a48fbf7a-c641-4c6f-bffa-6ecf6c793940', 4, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a48fbf7a-c641-4c6f-bffa-6ecf6c793940'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb59aaf-d6a7-4d95-9fea-0c56461a19be', 5, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb59aaf-d6a7-4d95-9fea-0c56461a19be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd03b83b-3cf7-48b3-8040-b574c05c23b0', 6, NULL, 'The Murder', 'The Murder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd03b83b-3cf7-48b3-8040-b574c05c23b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75a013af-eb2e-4227-adcf-4c9c4884c0c0', 7, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75a013af-eb2e-4227-adcf-4c9c4884c0c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0508898-0582-4d5e-9efd-ffd545ddfe81', 8, NULL, 'Scène d’amour', 'Scène d’amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0508898-0582-4d5e-9efd-ffd545ddfe81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e', 9, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10251 AND linked.composer_id = 112), 'musicbrainz:b364ad34-bd61-4403-8ba1-c0db19f11a17', 10, NULL, 'The Bride Wore Black – A Musical Scenario: Prelude / Femme Fatale / The Accident / Love and Death / Funeral / Finale', 'The Bride Wore Black – A Musical Scenario: Prelude / Femme Fatale / The Accident / Love and Death / Funeral / Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b364ad34-bd61-4403-8ba1-c0db19f11a17'
);

UPDATE pieces piece
SET piece.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver 중 "The Bride Wore Black – A Musical Scenario: Prelude / Femme Fatale / The Accident / Love and Death / Funeral / Finale"', piece.title_en = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver: The Bride Wore Black – A Musical Scenario: Prelude / Femme Fatale / The Accident / Love and Death / Funeral / Finale', piece.editor_locked = 1
WHERE piece.id = 10251 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9820 AND linked.composer_id = 112), 'musicbrainz:9441dfd5-95a3-45e4-82eb-0a7e5679eaab', 11, NULL, 'Fahrenheit 451: Finale (The Book People)', 'Fahrenheit 451: Finale (The Book People)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9441dfd5-95a3-45e4-82eb-0a7e5679eaab'
);

UPDATE pieces piece
SET piece.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver 중 "Fahrenheit 451: Finale (The Book People)"', piece.title_en = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver: Fahrenheit 451: Finale (The Book People)', piece.editor_locked = 1
WHERE piece.id = 9820 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9102 AND linked.composer_id = 112), 'musicbrainz:610671f0-7aaf-3512-be87-3b2e5bd209b4', 12, NULL, 'Taxi Driver: Night Piece for Saxophone & Orchestra', 'Taxi Driver: Night Piece for Saxophone & Orchestra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:610671f0-7aaf-3512-be87-3b2e5bd209b4'
);

UPDATE pieces piece
SET piece.title = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver 중 "Taxi Driver: Night Piece for Saxophone & Orchestra"', piece.title_en = 'Bernard Herrmann Film Scores: From Citizen Kane to Taxi Driver: Taxi Driver: Night Piece for Saxophone & Orchestra', piece.editor_locked = 1
WHERE piece.id = 9102 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music From Hitchcock Films

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Music From Hitchcock Films', 'Music From Hitchcock Films', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Music From Hitchcock Films'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7463 AND linked.composer_id = 112), 'musicbrainz:1e55f2e1-4bc9-3182-9671-3866ddd39112', 1, NULL, 'Psycho (A Narrative for Orchestra)', 'Psycho (A Narrative for Orchestra)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Music From Hitchcock Films' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e55f2e1-4bc9-3182-9671-3866ddd39112'
);

UPDATE pieces piece
SET piece.title = 'Music From Hitchcock Films 중 "Psycho (A Narrative for Orchestra)"', piece.title_en = 'Music From Hitchcock Films: Psycho (A Narrative for Orchestra)', piece.editor_locked = 1
WHERE piece.id = 7463 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7713 AND linked.composer_id = 112), 'musicbrainz:e018fefe-498d-3ac4-8bce-6bcb256758ba', 2, NULL, 'Marnie', 'Marnie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Music From Hitchcock Films' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e018fefe-498d-3ac4-8bce-6bcb256758ba'
);

UPDATE pieces piece
SET piece.title = 'Music From Hitchcock Films 중 "Marnie"', piece.title_en = 'Music From Hitchcock Films: Marnie', piece.editor_locked = 1
WHERE piece.id = 7713 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e', 3, NULL, 'Overture', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Music From Hitchcock Films' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27707d75-be69-3573-9465-2e1db479683e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:313aafa9-5a7c-4e5b-8a16-867961c94dca', 4, NULL, 'Vertigo Suite: I. Prelude', 'Vertigo Suite: I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Music From Hitchcock Films' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313aafa9-5a7c-4e5b-8a16-867961c94dca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1998b81d-596f-4b10-9dfd-047807890256', 5, NULL, 'Vertigo Suite: II. The Nightmare', 'Vertigo Suite: II. The Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Music From Hitchcock Films' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1998b81d-596f-4b10-9dfd-047807890256'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb239e1a-3435-41c2-b32f-1aad4874dc07', 6, NULL, 'Vertigo Suite: III. Scene d’Amour', 'Vertigo Suite: III. Scene d’Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Music From Hitchcock Films' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb239e1a-3435-41c2-b32f-1aad4874dc07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:579a3017-04d1-3fc6-8e70-df3b618436ce', 7, NULL, 'A Portrait of “Hitch”', 'A Portrait of “Hitch”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Music From Hitchcock Films' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:579a3017-04d1-3fc6-8e70-df3b618436ce'
);


-- None Citizen Kane (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Citizen Kane (음반)', 'Citizen Kane', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 112
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Citizen Kane (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11109 AND linked.composer_id = 112), 'musicbrainz:f4129a23-3dc4-4ab2-acdb-0175d3cc8f2e', 1, NULL, 'On Dangerous Ground', 'On Dangerous Ground', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4129a23-3dc4-4ab2-acdb-0175d3cc8f2e'
);

UPDATE pieces piece
SET piece.title = 'Citizen Kane (음반) 중 "On Dangerous Ground"', piece.title_en = 'Citizen Kane: On Dangerous Ground', piece.editor_locked = 1
WHERE piece.id = 11109 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0540fbc-372b-3d45-b331-b8f48a245402', 2, NULL, 'Manuscript Reading and Snow Picture', 'Manuscript Reading and Snow Picture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0540fbc-372b-3d45-b331-b8f48a245402'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4376832b-0d65-387e-9190-d5edf5419aed', 3, NULL, 'Prelude', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4376832b-0d65-387e-9190-d5edf5419aed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df11dc02-d7a0-3bf8-bd4e-523cb8a16309', 4, NULL, 'Theme and Variations', 'Theme and Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df11dc02-d7a0-3bf8-bd4e-523cb8a16309'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2f80f82-71a1-369c-8b0a-e67c983c4bf2', 5, NULL, 'Salaambo''s Aria', 'Salaambo''s Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2f80f82-71a1-369c-8b0a-e67c983c4bf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41', 6, NULL, 'Finale', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:452e2018-cb26-3d55-b5fb-a72b406feb41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8287 AND linked.composer_id = 112), 'musicbrainz:284aeca8-2269-44ee-93ea-14408bda5be0', 7, NULL, 'Beneath the 12-Mile Reef', 'Beneath the 12-Mile Reef', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:284aeca8-2269-44ee-93ea-14408bda5be0'
);

UPDATE pieces piece
SET piece.title = 'Citizen Kane (음반) 중 "Beneath the 12-Mile Reef"', piece.title_en = 'Citizen Kane: Beneath the 12-Mile Reef', piece.editor_locked = 1
WHERE piece.id = 8287 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db02b85a-e948-4c02-b030-4a2f36a3be25', 8, NULL, 'Concerto Macabre', 'Concerto Macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db02b85a-e948-4c02-b030-4a2f36a3be25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8787 AND linked.composer_id = 112), 'musicbrainz:4c05e70c-9b71-4da7-834b-928b9b3021c6', 9, NULL, 'White Witch Doctor', 'White Witch Doctor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 112 AND p.title = 'Citizen Kane (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c05e70c-9b71-4da7-834b-928b9b3021c6'
);

UPDATE pieces piece
SET piece.title = 'Citizen Kane (음반) 중 "White Witch Doctor"', piece.title_en = 'Citizen Kane: White Witch Doctor', piece.editor_locked = 1
WHERE piece.id = 8787 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <모비 딕>

UPDATE pieces piece
SET piece.title = '칸타타 <모비 딕>', piece.title_en = 'Moby Dick',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8568 AND piece.composer_id = 112
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 50개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 112 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7767, 7847, 7908, 7941, 7956, 7999, 8049, 8120, 8252, 8311, 8380, 8410, 8430, 8729, 8792, 8820, 8868, 8929, 9086, 9141,
    9166, 9195, 9258, 9399, 9444, 9522, 9718, 9808, 9850, 10000, 10018, 10096, 10154, 10161, 10275, 10350, 10394, 10473, 10600, 10695,
    10817, 10993, 11001, 11005, 11136, 11152, 11154, 11171, 11193, 11200
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
