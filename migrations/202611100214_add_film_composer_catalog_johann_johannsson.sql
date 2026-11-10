-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 5/9).
-- 작품 17개(새 12개), seed 165개 중 잇기 148·숨김 17·그대로 0.
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

-- ===== 요한 요한손 (composer_id 206) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 17개 중 음반 묶음 12개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 5개,
-- 새 작품 12개, part 223개, 그 아래 0개.
-- seed 165개 중 143개를 음반 묶음 안 곡으로 잇고, 5개는 낱개 작품으로 두고, 17개를 숨긴다.

-- None 12 Conversations with Thilo Heinzmann

UPDATE pieces piece
SET piece.title = '12 Conversations with Thilo Heinzmann', piece.title_en = '12 Conversations with Thilo Heinzmann',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20023 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Arc', part.name_en = '12 Conversations With Thilo Heinzmann: Arc',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:2ec980b3-6151-460e-a42a-a6659913c25e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ec980b3-6151-460e-a42a-a6659913c25e', 1, NULL, 'Arc', '12 Conversations With Thilo Heinzmann: Arc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ec980b3-6151-460e-a42a-a6659913c25e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lacrimosa', part.name_en = '12 Conversations With Thilo Heinzmann: Lacrimosa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:3192ea4b-269b-4463-8d81-cfe3c03be1fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3192ea4b-269b-4463-8d81-cfe3c03be1fe', 2, NULL, 'Lacrimosa', '12 Conversations With Thilo Heinzmann: Lacrimosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3192ea4b-269b-4463-8d81-cfe3c03be1fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Zurich', part.name_en = '12 Conversations With Thilo Heinzmann: Zurich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:5daa3ff7-fdf0-40a3-99fb-03371f9342d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5daa3ff7-fdf0-40a3-99fb-03371f9342d1', 3, NULL, 'Zurich', '12 Conversations With Thilo Heinzmann: Zurich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5daa3ff7-fdf0-40a3-99fb-03371f9342d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Gold', part.name_en = '12 Conversations With Thilo Heinzmann: Gold',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:5fc4f006-7651-4a40-9a0e-74c340fdc14a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fc4f006-7651-4a40-9a0e-74c340fdc14a', 4, NULL, 'Gold', '12 Conversations With Thilo Heinzmann: Gold', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fc4f006-7651-4a40-9a0e-74c340fdc14a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Low', part.name_en = '12 Conversations With Thilo Heinzmann: Low',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:68d63665-0eca-4931-ab67-99c079daddee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68d63665-0eca-4931-ab67-99c079daddee', 5, NULL, 'Low', '12 Conversations With Thilo Heinzmann: Low', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68d63665-0eca-4931-ab67-99c079daddee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Danse', part.name_en = '12 Conversations With Thilo Heinzmann: Danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:a220b394-f27c-40c8-98c3-f50196eea25c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a220b394-f27c-40c8-98c3-f50196eea25c', 6, NULL, 'Danse', '12 Conversations With Thilo Heinzmann: Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a220b394-f27c-40c8-98c3-f50196eea25c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Shell', part.name_en = '12 Conversations With Thilo Heinzmann: Shell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:b99ef3ed-78fc-4387-b156-19a2c4a813c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b99ef3ed-78fc-4387-b156-19a2c4a813c9', 7, NULL, 'Shell', '12 Conversations With Thilo Heinzmann: Shell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b99ef3ed-78fc-4387-b156-19a2c4a813c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Manifest', part.name_en = '12 Conversations With Thilo Heinzmann: Manifest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:d8899b24-0bdc-4bee-a1ed-e9adbcfce92e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8899b24-0bdc-4bee-a1ed-e9adbcfce92e', 8, NULL, 'Manifest', '12 Conversations With Thilo Heinzmann: Manifest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8899b24-0bdc-4bee-a1ed-e9adbcfce92e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Pol', part.name_en = '12 Conversations With Thilo Heinzmann: Pol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:da78906f-3128-4011-9134-460b6d180313' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da78906f-3128-4011-9134-460b6d180313', 9, NULL, 'Pol', '12 Conversations With Thilo Heinzmann: Pol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da78906f-3128-4011-9134-460b6d180313'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Stuk', part.name_en = '12 Conversations With Thilo Heinzmann: Stuk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:e5cd06ef-f625-44be-9e44-3d81d40ad643' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5cd06ef-f625-44be-9e44-3d81d40ad643', 10, NULL, 'Stuk', '12 Conversations With Thilo Heinzmann: Stuk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5cd06ef-f625-44be-9e44-3d81d40ad643'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Harm', part.name_en = '12 Conversations With Thilo Heinzmann: Harm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:eacb3a5f-226f-47c4-96ab-1b2361de7da6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eacb3a5f-226f-47c4-96ab-1b2361de7da6', 11, NULL, 'Harm', '12 Conversations With Thilo Heinzmann: Harm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eacb3a5f-226f-47c4-96ab-1b2361de7da6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Form', part.name_en = '12 Conversations With Thilo Heinzmann: Form',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 20023 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:fe507725-6807-4129-8670-893baa9bbc30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe507725-6807-4129-8670-893baa9bbc30', 12, NULL, 'Form', '12 Conversations With Thilo Heinzmann: Form', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 20023 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe507725-6807-4129-8670-893baa9bbc30'
);


-- None A Prayer to the Dynamo

UPDATE pieces piece
SET piece.title = 'A Prayer to the Dynamo', piece.title_en = 'A Prayer to the Dynamo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19400 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part 2', part.name_en = 'A Prayer to the Dynamo: Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19400 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:23a28945-bed7-4984-8666-3e21c6712e58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23a28945-bed7-4984-8666-3e21c6712e58', 1, NULL, 'Part 2', 'A Prayer to the Dynamo: Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19400 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23a28945-bed7-4984-8666-3e21c6712e58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part 4', part.name_en = 'A Prayer to the Dynamo: Part 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19400 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:5362a907-ac26-46ed-8219-5819c4766e98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5362a907-ac26-46ed-8219-5819c4766e98', 2, NULL, 'Part 4', 'A Prayer to the Dynamo: Part 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19400 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5362a907-ac26-46ed-8219-5819c4766e98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part 3', part.name_en = 'A Prayer to the Dynamo: Part 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19400 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:590358f4-6065-4c4c-9bd7-bb4c04621e74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:590358f4-6065-4c4c-9bd7-bb4c04621e74', 3, NULL, 'Part 3', 'A Prayer to the Dynamo: Part 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19400 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:590358f4-6065-4c4c-9bd7-bb4c04621e74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part 1', part.name_en = 'A Prayer to the Dynamo: Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19400 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:cd469a0f-2106-4ab8-9af7-00eeecf42cc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd469a0f-2106-4ab8-9af7-00eeecf42cc1', 4, NULL, 'Part 1', 'A Prayer to the Dynamo: Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19400 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd469a0f-2106-4ab8-9af7-00eeecf42cc1'
);


-- None 영화음악 <Copenhagen Dreams>

UPDATE pieces piece
SET piece.title = '영화음악 <Copenhagen Dreams>', piece.title_en = 'Copenhagen Dreams',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19212 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A Memorial Garden on Enghavevej', part.name_en = 'A Memorial Garden on Enghavevej',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:1999c187-8c2a-47a3-9804-f0dcc8d5686f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1999c187-8c2a-47a3-9804-f0dcc8d5686f', 1, NULL, 'A Memorial Garden on Enghavevej', 'A Memorial Garden on Enghavevej', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1999c187-8c2a-47a3-9804-f0dcc8d5686f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'They Leave Everything Behind', part.name_en = 'They Leave Everything Behind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:1f7f2a76-93c4-4e39-a947-ed5d4e40a5c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f7f2a76-93c4-4e39-a947-ed5d4e40a5c9', 2, NULL, 'They Leave Everything Behind', 'They Leave Everything Behind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f7f2a76-93c4-4e39-a947-ed5d4e40a5c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A French School on Værnedamsvej', part.name_en = 'A French School on Værnedamsvej',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:2177efda-8ca7-4445-9a45-91b1b6200b70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2177efda-8ca7-4445-9a45-91b1b6200b70', 3, NULL, 'A French School on Værnedamsvej', 'A French School on Værnedamsvej', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2177efda-8ca7-4445-9a45-91b1b6200b70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Eleven Thousand Six Hundred and Sixty‐Nine Died of Natural Causes', part.name_en = 'Eleven Thousand Six Hundred and Sixty‐Nine Died of Natural Causes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:3f8d7f52-88c4-498d-bfe3-efbd58f0a6f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f8d7f52-88c4-498d-bfe3-efbd58f0a6f0', 4, NULL, 'Eleven Thousand Six Hundred and Sixty‐Nine Died of Natural Causes', 'Eleven Thousand Six Hundred and Sixty‐Nine Died of Natural Causes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f8d7f52-88c4-498d-bfe3-efbd58f0a6f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'He Says It’s the Future', part.name_en = 'He Says It’s the Future',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:50836b38-1d51-4807-b25e-cb11ed86a98a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50836b38-1d51-4807-b25e-cb11ed86a98a', 5, NULL, 'He Says It’s the Future', 'He Says It’s the Future', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50836b38-1d51-4807-b25e-cb11ed86a98a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'He Hit Her on the Head With “The Wind in the Willows”', part.name_en = 'He Hit Her on the Head With “The Wind in the Willows”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:697464b3-3b17-4d0f-855e-f47acf246dd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:697464b3-3b17-4d0f-855e-f47acf246dd4', 6, NULL, 'He Hit Her on the Head With “The Wind in the Willows”', 'He Hit Her on the Head With “The Wind in the Willows”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:697464b3-3b17-4d0f-855e-f47acf246dd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Three Thousand Five Hundred and Ninety One Benches', part.name_en = 'Three Thousand Five Hundred and Ninety One Benches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:6fde7a7e-a957-416a-bb76-e4044dadf334' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fde7a7e-a957-416a-bb76-e4044dadf334', 7, NULL, 'Three Thousand Five Hundred and Ninety One Benches', 'Three Thousand Five Hundred and Ninety One Benches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fde7a7e-a957-416a-bb76-e4044dadf334'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'They Dream They’ll Get There', part.name_en = 'They Dream They’ll Get There',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:7d24dd61-e90f-4a1f-87c5-bf1bf942fb1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d24dd61-e90f-4a1f-87c5-bf1bf942fb1b', 8, NULL, 'They Dream They’ll Get There', 'They Dream They’ll Get There', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d24dd61-e90f-4a1f-87c5-bf1bf942fb1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'They Imagine the City Growing Out Into the Ocean', part.name_en = 'They Imagine the City Growing Out Into the Ocean',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:81688c1c-60b1-4c7a-a3a8-d58592d335bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81688c1c-60b1-4c7a-a3a8-d58592d335bf', 9, NULL, 'They Imagine the City Growing Out Into the Ocean', 'They Imagine the City Growing Out Into the Ocean', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81688c1c-60b1-4c7a-a3a8-d58592d335bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Here, They Used to Build Ships', part.name_en = 'Here, They Used to Build Ships',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:81ac949a-1edc-4d51-b992-672ee8080db9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81ac949a-1edc-4d51-b992-672ee8080db9', 10, NULL, 'Here, They Used to Build Ships', 'Here, They Used to Build Ships', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ac949a-1edc-4d51-b992-672ee8080db9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Jewish Cemetery on Møllegade', part.name_en = 'The Jewish Cemetery on Møllegade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:9151fa00-d2d2-4fc5-b19c-60831e9a2933' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9151fa00-d2d2-4fc5-b19c-60831e9a2933', 11, NULL, 'The Jewish Cemetery on Møllegade', 'The Jewish Cemetery on Møllegade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9151fa00-d2d2-4fc5-b19c-60831e9a2933'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'She Loves to Ride the Port Ferry When It Rains', part.name_en = 'She Loves to Ride the Port Ferry When It Rains',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:9c6a3865-ec42-4bae-8c27-db6656551d86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c6a3865-ec42-4bae-8c27-db6656551d86', 12, NULL, 'She Loves to Ride the Port Ferry When It Rains', 'She Loves to Ride the Port Ferry When It Rains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c6a3865-ec42-4bae-8c27-db6656551d86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'An Eiffel Tower by the Lakes', part.name_en = 'An Eiffel Tower by the Lakes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:b3f5336d-42d2-4b0b-8841-ac6a842266bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3f5336d-42d2-4b0b-8841-ac6a842266bb', 13, NULL, 'An Eiffel Tower by the Lakes', 'An Eiffel Tower by the Lakes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3f5336d-42d2-4b0b-8841-ac6a842266bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'A Six‐Lane Highway', part.name_en = 'A Six‐Lane Highway',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:cb651dfe-1a88-4fcd-8a9b-fc4065b8ca96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb651dfe-1a88-4fcd-8a9b-fc4065b8ca96', 14, NULL, 'A Six‐Lane Highway', 'A Six‐Lane Highway', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb651dfe-1a88-4fcd-8a9b-fc4065b8ca96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'It Will Take Some Time', part.name_en = 'It Will Take Some Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:cc13b504-f67d-44a8-912d-ab01ed9d91c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc13b504-f67d-44a8-912d-ab01ed9d91c6', 15, NULL, 'It Will Take Some Time', 'It Will Take Some Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc13b504-f67d-44a8-912d-ab01ed9d91c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Song About the Hyacinths', part.name_en = 'The Song About the Hyacinths',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:cff4a9f8-5df7-4751-b580-07c5d1605848' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cff4a9f8-5df7-4751-b580-07c5d1605848', 16, NULL, 'The Song About the Hyacinths', 'The Song About the Hyacinths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cff4a9f8-5df7-4751-b580-07c5d1605848'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'They Had to Work It Out Between Them', part.name_en = 'They Had to Work It Out Between Them',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:f5475b62-a522-409b-b20a-5844b46c969f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5475b62-a522-409b-b20a-5844b46c969f', 17, NULL, 'They Had to Work It Out Between Them', 'They Had to Work It Out Between Them', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5475b62-a522-409b-b20a-5844b46c969f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'They Fed the Sparrows Leftovers and Offered Grass to Scherfig’s Turtle', part.name_en = 'They Fed the Sparrows Leftovers and Offered Grass to Scherfig’s Turtle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:fcf48235-7bf0-403c-8312-efdf83a0d091' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcf48235-7bf0-403c-8312-efdf83a0d091', 18, NULL, 'They Fed the Sparrows Leftovers and Offered Grass to Scherfig’s Turtle', 'They Fed the Sparrows Leftovers and Offered Grass to Scherfig’s Turtle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf48235-7bf0-403c-8312-efdf83a0d091'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'There’s No Harm Done', part.name_en = 'There’s No Harm Done',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19212 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:ff80ad98-a326-4cb0-af9c-7c62437b8664' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff80ad98-a326-4cb0-af9c-7c62437b8664', 19, NULL, 'There’s No Harm Done', 'There’s No Harm Done', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19212 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff80ad98-a326-4cb0-af9c-7c62437b8664'
);


-- None Drone Mass

UPDATE pieces piece
SET piece.title = 'Drone Mass', piece.title_en = 'Drone Mass',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17731 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'To Fold & Remain Dormant', part.name_en = 'To Fold & Remain Dormant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:12a20a6a-4ab9-4c36-91c0-04a32f9b6f78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12a20a6a-4ab9-4c36-91c0-04a32f9b6f78', 1, NULL, 'To Fold & Remain Dormant', 'To Fold & Remain Dormant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12a20a6a-4ab9-4c36-91c0-04a32f9b6f78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Triptych in Mass', part.name_en = 'Triptych in Mass',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:22b17732-8d9e-4d33-8edb-4f12bbc2d539' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22b17732-8d9e-4d33-8edb-4f12bbc2d539', 2, NULL, 'Triptych in Mass', 'Triptych in Mass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22b17732-8d9e-4d33-8edb-4f12bbc2d539'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Mountain View, the Majesty of the Snow‐Clad Peaks, From a Place of Contemplation and Reflection', part.name_en = 'The Mountain View, the Majesty of the Snow‐Clad Peaks, From a Place of Contemplation and Reflection',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:389dfc38-5f5b-4261-b7d4-e229378ee37d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389dfc38-5f5b-4261-b7d4-e229378ee37d', 3, NULL, 'The Mountain View, the Majesty of the Snow‐Clad Peaks, From a Place of Contemplation and Reflection', 'The Mountain View, the Majesty of the Snow‐Clad Peaks, From a Place of Contemplation and Reflection', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389dfc38-5f5b-4261-b7d4-e229378ee37d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Divine Objects, Pt. 2', part.name_en = 'Divine Objects, Pt. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:49a4754f-bf6c-4b96-b06c-86ac8b263295' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a4754f-bf6c-4b96-b06c-86ac8b263295', 4, NULL, 'Divine Objects, Pt. 2', 'Divine Objects, Pt. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a4754f-bf6c-4b96-b06c-86ac8b263295'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Divine Objects, Pt. 1', part.name_en = 'Divine Objects, Pt. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:8dafc7f0-5fa7-447d-94eb-59e3cf4c2109' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dafc7f0-5fa7-447d-94eb-59e3cf4c2109', 5, NULL, 'Divine Objects, Pt. 1', 'Divine Objects, Pt. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dafc7f0-5fa7-447d-94eb-59e3cf4c2109'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Take the Night Air', part.name_en = 'Take the Night Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:8f43a0d2-ffa3-4c0e-aabe-d181f1219180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f43a0d2-ffa3-4c0e-aabe-d181f1219180', 6, NULL, 'Take the Night Air', 'Take the Night Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f43a0d2-ffa3-4c0e-aabe-d181f1219180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Two Is Apocryphal', part.name_en = 'Two Is Apocryphal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:9c4c0428-67c5-4570-8cd2-e9baba4346cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c4c0428-67c5-4570-8cd2-e9baba4346cc', 7, NULL, 'Two Is Apocryphal', 'Two Is Apocryphal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c4c0428-67c5-4570-8cd2-e9baba4346cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'One Is True', part.name_en = 'One Is True',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:a3978e63-f517-4c7b-8150-5c9293daf0de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3978e63-f517-4c7b-8150-5c9293daf0de', 8, NULL, 'One Is True', 'One Is True', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3978e63-f517-4c7b-8150-5c9293daf0de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Moral Vacuums', part.name_en = 'Moral Vacuums',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:b1e9e71d-f435-49ad-a0f1-3e0150b41eaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1e9e71d-f435-49ad-a0f1-3e0150b41eaa', 9, NULL, 'Moral Vacuums', 'Moral Vacuums', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1e9e71d-f435-49ad-a0f1-3e0150b41eaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Low Drone of Circulating Blood, Diminishes With Time', part.name_en = 'The Low Drone of Circulating Blood, Diminishes With Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:c834c862-6a12-4a2a-ae49-050339ed37bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c834c862-6a12-4a2a-ae49-050339ed37bd', 10, NULL, 'The Low Drone of Circulating Blood, Diminishes With Time', 'The Low Drone of Circulating Blood, Diminishes With Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c834c862-6a12-4a2a-ae49-050339ed37bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Last Foul Wind I Ever Knew', part.name_en = 'The Last Foul Wind I Ever Knew',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17731 AND p.composer_id = 206 AND part.part_key = 'musicbrainz:cd738464-7502-4583-ac7d-1c8fa408aedc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd738464-7502-4583-ac7d-1c8fa408aedc', 11, NULL, 'The Last Foul Wind I Ever Knew', 'The Last Foul Wind I Ever Knew', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17731 AND p.composer_id = 206
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd738464-7502-4583-ac7d-1c8fa408aedc'
);


-- None Tu non mi perderai mai

UPDATE pieces piece
SET piece.title = 'Tu non mi perderai mai', piece.title_en = 'Tu non mi perderai mai',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17816 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <사랑에 대한 모든 것> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <사랑에 대한 모든 것> 사운드트랙', 'The Theory of Everything: Original Motion Picture Soundtrack', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <사랑에 대한 모든 것> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17625 AND linked.composer_id = 206), 'musicbrainz:622cf84c-7f48-4d05-9176-5235dba668bd', 1, NULL, 'Cambridge, 1963', 'Cambridge, 1963', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:622cf84c-7f48-4d05-9176-5235dba668bd'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Cambridge, 1963"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Cambridge, 1963', piece.editor_locked = 1
WHERE piece.id = 17625 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d77568ba-6067-418e-ab6b-b54a725cdf13', 2, NULL, 'Rowing', 'Rowing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d77568ba-6067-418e-ab6b-b54a725cdf13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18255 AND linked.composer_id = 206), 'musicbrainz:8a800673-96ed-4744-b031-31020eb23e1a', 3, NULL, 'Domestic Pressures', 'Domestic Pressures', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a800673-96ed-4744-b031-31020eb23e1a'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Domestic Pressures"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Domestic Pressures', piece.editor_locked = 1
WHERE piece.id = 18255 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17430 AND linked.composer_id = 206), 'musicbrainz:5661d58a-1f97-408f-bbec-953285d33857', 4, NULL, 'Chalkboard', 'Chalkboard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5661d58a-1f97-408f-bbec-953285d33857'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Chalkboard"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Chalkboard', piece.editor_locked = 1
WHERE piece.id = 17430 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18605 AND linked.composer_id = 206), 'musicbrainz:9fc46e05-0e4c-43c6-9b6d-57e1473f1e1c', 5, NULL, 'Cavendish Lab', 'Cavendish Lab', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fc46e05-0e4c-43c6-9b6d-57e1473f1e1c'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Cavendish Lab"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Cavendish Lab', piece.editor_locked = 1
WHERE piece.id = 18605 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18450 AND linked.composer_id = 206), 'musicbrainz:957570f9-5a72-4aac-a461-9dc16a3a1735', 6, NULL, 'Collapsing Inwards', 'Collapsing Inwards', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:957570f9-5a72-4aac-a461-9dc16a3a1735'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Collapsing Inwards"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Collapsing Inwards', piece.editor_locked = 1
WHERE piece.id = 18450 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19208 AND linked.composer_id = 206), 'musicbrainz:c5c483c5-a4a7-4765-8071-4131a233ccdd', 7, NULL, 'A Game of Croquet', 'A Game of Croquet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5c483c5-a4a7-4765-8071-4131a233ccdd'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Game of Croquet"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: A Game of Croquet', piece.editor_locked = 1
WHERE piece.id = 19208 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17442 AND linked.composer_id = 206), 'musicbrainz:5710b2a9-d43f-49f6-8630-85161e3a5b30', 8, NULL, 'The Origins of Time', 'The Origins of Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5710b2a9-d43f-49f6-8630-85161e3a5b30'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Origins of Time"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: The Origins of Time', piece.editor_locked = 1
WHERE piece.id = 17442 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18628 AND linked.composer_id = 206), 'musicbrainz:a10e14d2-185c-4229-8c38-0a6ed7434b4f', 9, NULL, 'Viva Voce', 'Viva Voce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a10e14d2-185c-4229-8c38-0a6ed7434b4f'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Viva Voce"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Viva Voce', piece.editor_locked = 1
WHERE piece.id = 18628 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad11ad7b-343b-4527-aeb0-4cdcabbc649b', 10, NULL, 'The Wedding', 'The Wedding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad11ad7b-343b-4527-aeb0-4cdcabbc649b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16181 AND linked.composer_id = 206), 'musicbrainz:0b594dfa-71c8-4712-955e-fec24bb818cb', 11, NULL, 'The Dreams That Stuff Is Made Of', 'The Dreams That Stuff Is Made Of', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b594dfa-71c8-4712-955e-fec24bb818cb'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Dreams That Stuff Is Made Of"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: The Dreams That Stuff Is Made Of', piece.editor_locked = 1
WHERE piece.id = 16181 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18188 AND linked.composer_id = 206), 'musicbrainz:858397b2-020b-4af0-a7ed-32f5431488c4', 12, NULL, 'A Spacetime Singularity', 'A Spacetime Singularity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:858397b2-020b-4af0-a7ed-32f5431488c4'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Spacetime Singularity"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: A Spacetime Singularity', piece.editor_locked = 1
WHERE piece.id = 18188 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18859 AND linked.composer_id = 206), 'musicbrainz:af73c5b7-64f1-460e-9993-e8b75ad369a8', 13, NULL, 'The Stairs', 'The Stairs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af73c5b7-64f1-460e-9993-e8b75ad369a8'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Stairs"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: The Stairs', piece.editor_locked = 1
WHERE piece.id = 18859 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17539 AND linked.composer_id = 206), 'musicbrainz:5cc18a8a-b9a3-4f64-9b02-0e4092b77877', 14, NULL, 'A Normal Family', 'A Normal Family', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cc18a8a-b9a3-4f64-9b02-0e4092b77877'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Normal Family"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: A Normal Family', piece.editor_locked = 1
WHERE piece.id = 17539 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17041 AND linked.composer_id = 206), 'musicbrainz:3ea18d01-7645-4d99-ae20-02bf43652e3d', 15, NULL, 'Forces of Attraction', 'Forces of Attraction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ea18d01-7645-4d99-ae20-02bf43652e3d'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Forces of Attraction"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Forces of Attraction', piece.editor_locked = 1
WHERE piece.id = 17041 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16215 AND linked.composer_id = 206), 'musicbrainz:0d272385-c294-4b75-8999-ce1c90fd93f2', 16, NULL, 'Rowing (alternative version)', 'Rowing (alternative version)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d272385-c294-4b75-8999-ce1c90fd93f2'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Rowing (alternative version)"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Rowing (alternative version)', piece.editor_locked = 1
WHERE piece.id = 16215 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16451 AND linked.composer_id = 206), 'musicbrainz:1a1a4333-a9bc-4ae2-8274-dfbab213ef46', 17, NULL, 'Camping', 'Camping', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a1a4333-a9bc-4ae2-8274-dfbab213ef46'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Camping"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Camping', piece.editor_locked = 1
WHERE piece.id = 16451 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18971 AND linked.composer_id = 206), 'musicbrainz:b6a6e9c8-04b8-48b9-a6d0-9e793eb1c8d0', 18, NULL, 'Coma', 'Coma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6a6e9c8-04b8-48b9-a6d0-9e793eb1c8d0'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Coma"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Coma', piece.editor_locked = 1
WHERE piece.id = 18971 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18269 AND linked.composer_id = 206), 'musicbrainz:8b3fe345-6340-483e-956b-17cee688c6a5', 19, NULL, 'The Spelling Board', 'The Spelling Board', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b3fe345-6340-483e-956b-17cee688c6a5'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Spelling Board"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: The Spelling Board', piece.editor_locked = 1
WHERE piece.id = 18269 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17767 AND linked.composer_id = 206), 'musicbrainz:6a702208-dca2-4a61-9661-da4f2d3db794', 20, NULL, 'The Voice Box', 'The Voice Box', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a702208-dca2-4a61-9661-da4f2d3db794'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Voice Box"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: The Voice Box', piece.editor_locked = 1
WHERE piece.id = 17767 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19464 AND linked.composer_id = 206), 'musicbrainz:d6c14708-fa39-4f66-bd0d-839fadc292d7', 21, NULL, 'A Brief History of Time', 'A Brief History of Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6c14708-fa39-4f66-bd0d-839fadc292d7'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Brief History of Time"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: A Brief History of Time', piece.editor_locked = 1
WHERE piece.id = 19464 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18163 AND linked.composer_id = 206), 'musicbrainz:840a8cb6-baa4-47c1-ba33-197d1e6a023a', 22, NULL, 'Daisy, Daisy', 'Daisy, Daisy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:840a8cb6-baa4-47c1-ba33-197d1e6a023a'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "Daisy, Daisy"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: Daisy, Daisy', piece.editor_locked = 1
WHERE piece.id = 18163 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18830 AND linked.composer_id = 206), 'musicbrainz:adb2af23-e3e0-4fe4-bf8d-85acd2dfc9f1', 23, NULL, 'A Model of the Universe', 'A Model of the Universe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adb2af23-e3e0-4fe4-bf8d-85acd2dfc9f1'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "A Model of the Universe"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: A Model of the Universe', piece.editor_locked = 1
WHERE piece.id = 18830 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16617 AND linked.composer_id = 206), 'musicbrainz:256e75ca-f643-41cc-8c4f-c0bf3b4f0d7c', 24, NULL, 'The Theory of Everything', 'The Theory of Everything', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:256e75ca-f643-41cc-8c4f-c0bf3b4f0d7c'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Theory of Everything"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: The Theory of Everything', piece.editor_locked = 1
WHERE piece.id = 16617 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16667 AND linked.composer_id = 206), 'musicbrainz:2843b241-2528-409c-9e26-75a7a3f67980', 25, NULL, 'London, 1988', 'London, 1988', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2843b241-2528-409c-9e26-75a7a3f67980'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "London, 1988"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: London, 1988', piece.editor_locked = 1
WHERE piece.id = 16667 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:332fde25-036c-4bd1-a191-2d31b471570d', 26, NULL, 'Epilogue', 'Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:332fde25-036c-4bd1-a191-2d31b471570d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17118 AND linked.composer_id = 206), 'musicbrainz:43becfe6-d634-4383-8bdc-29ecdc7fc4b7', 27, NULL, 'The Whirling Ways of Stars That Pass', 'The Whirling Ways of Stars That Pass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <사랑에 대한 모든 것> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43becfe6-d634-4383-8bdc-29ecdc7fc4b7'
);

UPDATE pieces piece
SET piece.title = '영화 <사랑에 대한 모든 것> 사운드트랙 중 "The Whirling Ways of Stars That Pass"', piece.title_en = 'The Theory of Everything: Original Motion Picture Soundtrack: The Whirling Ways of Stars That Pass', piece.editor_locked = 1
WHERE piece.id = 17118 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <컨택트> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <컨택트> 사운드트랙', 'Arrival: Original Motion Picture Soundtrack', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <컨택트> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17899 AND linked.composer_id = 206), 'musicbrainz:7275eaa1-bb91-47a4-a570-f15e34877219', 1, NULL, 'Arrival', 'Arrival', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7275eaa1-bb91-47a4-a570-f15e34877219'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Arrival"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Arrival', piece.editor_locked = 1
WHERE piece.id = 17899 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66b290ab-e695-4957-8b6a-fd0b2dbf827e', 2, NULL, 'Heptapod B', 'Heptapod B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66b290ab-e695-4957-8b6a-fd0b2dbf827e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18132 AND linked.composer_id = 206), 'musicbrainz:81790154-7f67-44b4-a5c0-19153966c352', 3, NULL, 'Sapir‐Whorf', 'Sapir‐Whorf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81790154-7f67-44b4-a5c0-19153966c352'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Sapir‐Whorf"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Sapir‐Whorf', piece.editor_locked = 1
WHERE piece.id = 18132 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18716 AND linked.composer_id = 206), 'musicbrainz:a639fc98-c0ea-425c-b60e-1de6de609131', 4, NULL, 'Hydraulic Lift', 'Hydraulic Lift', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a639fc98-c0ea-425c-b60e-1de6de609131'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Hydraulic Lift"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Hydraulic Lift', piece.editor_locked = 1
WHERE piece.id = 18716 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17072 AND linked.composer_id = 206), 'musicbrainz:40790b3f-2842-4a5a-aeac-8130a8aa510d', 5, NULL, 'First Encounter', 'First Encounter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40790b3f-2842-4a5a-aeac-8130a8aa510d'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "First Encounter"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: First Encounter', piece.editor_locked = 1
WHERE piece.id = 17072 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17575 AND linked.composer_id = 206), 'musicbrainz:5f761ef6-5ff0-4317-b379-1c2f8c60e305', 6, NULL, 'Transmutation at a Distance', 'Transmutation at a Distance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f761ef6-5ff0-4317-b379-1c2f8c60e305'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Transmutation at a Distance"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Transmutation at a Distance', piece.editor_locked = 1
WHERE piece.id = 17575 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16467 AND linked.composer_id = 206), 'musicbrainz:1aff25a4-900c-4d13-adea-d29f2c863be8', 7, NULL, 'Around the Clock News', 'Around the Clock News', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aff25a4-900c-4d13-adea-d29f2c863be8'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Around the Clock News"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Around the Clock News', piece.editor_locked = 1
WHERE piece.id = 16467 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19935 AND linked.composer_id = 206), 'musicbrainz:f6276eb1-b483-43fb-85e3-bc4270c53c45', 8, NULL, 'Xenolinguistics', 'Xenolinguistics', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6276eb1-b483-43fb-85e3-bc4270c53c45'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Xenolinguistics"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Xenolinguistics', piece.editor_locked = 1
WHERE piece.id = 19935 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18967 AND linked.composer_id = 206), 'musicbrainz:b67c81d1-1a2c-4423-8efd-00198f377b0d', 9, NULL, 'Ultimatum', 'Ultimatum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b67c81d1-1a2c-4423-8efd-00198f377b0d'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Ultimatum"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Ultimatum', piece.editor_locked = 1
WHERE piece.id = 18967 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17288 AND linked.composer_id = 206), 'musicbrainz:4d6262a6-23c6-4f6a-8cda-923f5ad96b0a', 10, NULL, 'Principle of Least Time', 'Principle of Least Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d6262a6-23c6-4f6a-8cda-923f5ad96b0a'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Principle of Least Time"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Principle of Least Time', piece.editor_locked = 1
WHERE piece.id = 17288 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19451 AND linked.composer_id = 206), 'musicbrainz:d5acdd7e-3b9a-4d5a-b05a-de6210341484', 11, NULL, 'Hazmat', 'Hazmat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5acdd7e-3b9a-4d5a-b05a-de6210341484'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Hazmat"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Hazmat', piece.editor_locked = 1
WHERE piece.id = 19451 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16348 AND linked.composer_id = 206), 'musicbrainz:14bd6f29-bcb1-40b5-b2ef-851522f84015', 12, NULL, 'Hammers and Nails', 'Hammers and Nails', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14bd6f29-bcb1-40b5-b2ef-851522f84015'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Hammers and Nails"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Hammers and Nails', piece.editor_locked = 1
WHERE piece.id = 16348 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17163 AND linked.composer_id = 206), 'musicbrainz:45b4a3f4-8704-4638-9df1-48e8c8e715c1', 13, NULL, 'Xenoanthropology', 'Xenoanthropology', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45b4a3f4-8704-4638-9df1-48e8c8e715c1'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Xenoanthropology"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Xenoanthropology', piece.editor_locked = 1
WHERE piece.id = 17163 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19022 AND linked.composer_id = 206), 'musicbrainz:bab6c597-16ae-456f-aa3c-714dcc3e70a5', 14, NULL, 'Non‐Zero‐Sum Game', 'Non‐Zero‐Sum Game', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bab6c597-16ae-456f-aa3c-714dcc3e70a5'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Non‐Zero‐Sum Game"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Non‐Zero‐Sum Game', piece.editor_locked = 1
WHERE piece.id = 19022 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16360 AND linked.composer_id = 206), 'musicbrainz:1556cb2d-6543-4beb-95b3-a47911595b06', 15, NULL, 'Properties of Explosive Materials', 'Properties of Explosive Materials', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1556cb2d-6543-4beb-95b3-a47911595b06'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Properties of Explosive Materials"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Properties of Explosive Materials', piece.editor_locked = 1
WHERE piece.id = 16360 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17526 AND linked.composer_id = 206), 'musicbrainz:5c0c0f58-c4a6-41df-99f5-6c46c6de1848', 16, NULL, 'Escalation', 'Escalation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c0c0f58-c4a6-41df-99f5-6c46c6de1848'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Escalation"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Escalation', piece.editor_locked = 1
WHERE piece.id = 17526 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19968 AND linked.composer_id = 206), 'musicbrainz:f7a37d3a-aa83-4fe4-a1f6-66ef7a70a08e', 17, NULL, 'Decyphering', 'Decyphering', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a37d3a-aa83-4fe4-a1f6-66ef7a70a08e'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Decyphering"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Decyphering', piece.editor_locked = 1
WHERE piece.id = 19968 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19282 AND linked.composer_id = 206), 'musicbrainz:ca86316c-71b4-4dfa-a5bf-bffc105fd30c', 18, NULL, 'One of Twelve', 'One of Twelve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca86316c-71b4-4dfa-a5bf-bffc105fd30c'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "One of Twelve"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: One of Twelve', piece.editor_locked = 1
WHERE piece.id = 19282 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19725 AND linked.composer_id = 206), 'musicbrainz:e9cba0fb-487e-4a40-91d5-3bac1d154797', 19, NULL, 'Rise', 'Rise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9cba0fb-487e-4a40-91d5-3bac1d154797'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Rise"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Rise', piece.editor_locked = 1
WHERE piece.id = 19725 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19109 AND linked.composer_id = 206), 'musicbrainz:bfaeb4ca-4b75-4aef-a24e-a9594f630b10', 20, NULL, 'Kangaru', 'Kangaru', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <컨택트> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfaeb4ca-4b75-4aef-a24e-a9594f630b10'
);

UPDATE pieces piece
SET piece.title = '영화 <컨택트> 사운드트랙 중 "Kangaru"', piece.title_en = 'Arrival: Original Motion Picture Soundtrack: Kangaru', piece.editor_locked = 1
WHERE piece.id = 19109 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <Free the Mind> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <Free the Mind> 사운드트랙', 'Free the Mind: Original Motion Picture Soundtrack', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <Free the Mind> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20007 AND linked.composer_id = 206), 'musicbrainz:fa0282b9-244a-4761-bad1-0437150503e7', 1, NULL, 'Free the Mind', 'Free the Mind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa0282b9-244a-4761-bad1-0437150503e7'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Free the Mind"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Free the Mind', piece.editor_locked = 1
WHERE piece.id = 20007 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20049 AND linked.composer_id = 206), 'musicbrainz:fca5766e-5231-42b2-bb46-d5f65283cfa7', 2, NULL, 'Radio', 'Radio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fca5766e-5231-42b2-bb46-d5f65283cfa7'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Radio"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Radio', piece.editor_locked = 1
WHERE piece.id = 20049 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18461 AND linked.composer_id = 206), 'musicbrainz:965bd08f-d8b6-4387-a118-9867551bc541', 3, NULL, 'Elevator I', 'Elevator I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:965bd08f-d8b6-4387-a118-9867551bc541'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Elevator I"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Elevator I', piece.editor_locked = 1
WHERE piece.id = 18461 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17311 AND linked.composer_id = 206), 'musicbrainz:4f8fe575-b3da-4d2f-8f44-68e1936c8769', 4, NULL, 'Elevator II', 'Elevator II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f8fe575-b3da-4d2f-8f44-68e1936c8769'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Elevator II"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Elevator II', piece.editor_locked = 1
WHERE piece.id = 17311 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17569 AND linked.composer_id = 206), 'musicbrainz:5efd6a2b-a8f0-4ad6-858b-3cec25d74377', 5, NULL, 'Neurons', 'Neurons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5efd6a2b-a8f0-4ad6-858b-3cec25d74377'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Neurons"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Neurons', piece.editor_locked = 1
WHERE piece.id = 17569 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16342 AND linked.composer_id = 206), 'musicbrainz:1459b3b3-9ed0-4583-b650-cf80ea8bc647', 6, NULL, 'Night Montage', 'Night Montage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1459b3b3-9ed0-4583-b650-cf80ea8bc647'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Night Montage"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Night Montage', piece.editor_locked = 1
WHERE piece.id = 16342 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16321 AND linked.composer_id = 206), 'musicbrainz:130ec245-ae1a-4331-8d79-c17dbdd56f27', 7, NULL, 'First Attempts', 'First Attempts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:130ec245-ae1a-4331-8d79-c17dbdd56f27'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "First Attempts"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: First Attempts', piece.editor_locked = 1
WHERE piece.id = 16321 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17532 AND linked.composer_id = 206), 'musicbrainz:5c69643f-589c-476c-bb18-7e50156b8bda', 8, NULL, 'Sparkles', 'Sparkles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c69643f-589c-476c-bb18-7e50156b8bda'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Sparkles"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Sparkles', piece.editor_locked = 1
WHERE piece.id = 17532 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16007 AND linked.composer_id = 206), 'musicbrainz:017327f7-e5c3-4f9f-bc5b-53bb1c1b2686', 9, NULL, 'Breathe', 'Breathe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:017327f7-e5c3-4f9f-bc5b-53bb1c1b2686'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Breathe"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Breathe', piece.editor_locked = 1
WHERE piece.id = 16007 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18225 AND linked.composer_id = 206), 'musicbrainz:888af112-3439-49b1-8794-5670498cdf1a', 10, NULL, 'Will''s Story 1', 'Will''s Story 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:888af112-3439-49b1-8794-5670498cdf1a'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Will''s Story 1"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Will''s Story 1', piece.editor_locked = 1
WHERE piece.id = 18225 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17264 AND linked.composer_id = 206), 'musicbrainz:4bacefc6-84c6-4138-8086-33d1383311a9', 11, NULL, 'Meditation (From „free the Mind” Soundtrack)', 'Meditation (From „free the Mind” Soundtrack)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bacefc6-84c6-4138-8086-33d1383311a9'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Meditation (From „free the Mind” Soundtrack)"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Meditation (From „free the Mind” Soundtrack)', piece.editor_locked = 1
WHERE piece.id = 17264 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17244 AND linked.composer_id = 206), 'musicbrainz:4a384440-420f-497c-9888-ee2c8a2bff17', 12, NULL, 'Lab', 'Lab', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a384440-420f-497c-9888-ee2c8a2bff17'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Lab"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Lab', piece.editor_locked = 1
WHERE piece.id = 17244 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17620 AND linked.composer_id = 206), 'musicbrainz:61d7cb3f-ed9d-47e5-a2dc-9b6ea2430ba0', 13, NULL, 'Emotional Intelligence', 'Emotional Intelligence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61d7cb3f-ed9d-47e5-a2dc-9b6ea2430ba0'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Emotional Intelligence"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Emotional Intelligence', piece.editor_locked = 1
WHERE piece.id = 17620 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18028 AND linked.composer_id = 206), 'musicbrainz:7acbeed1-b989-473a-b1bc-c9be2c2c1c91', 14, NULL, 'Innocence (From „free the Mind” Soundtrack)', 'Innocence (From „free the Mind” Soundtrack)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7acbeed1-b989-473a-b1bc-c9be2c2c1c91'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Innocence (From „free the Mind” Soundtrack)"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Innocence (From „free the Mind” Soundtrack)', piece.editor_locked = 1
WHERE piece.id = 18028 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16353 AND linked.composer_id = 206), 'musicbrainz:14e8d166-d326-412c-b525-eebb258e2920', 15, NULL, 'Separation', 'Separation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14e8d166-d326-412c-b525-eebb258e2920'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Separation"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Separation', piece.editor_locked = 1
WHERE piece.id = 16353 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17559 AND linked.composer_id = 206), 'musicbrainz:5e794f73-35b4-4aad-a218-45bab7e568ef', 16, NULL, 'Love After Love', 'Love After Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e794f73-35b4-4aad-a218-45bab7e568ef'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Love After Love"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Love After Love', piece.editor_locked = 1
WHERE piece.id = 17559 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16075 AND linked.composer_id = 206), 'musicbrainz:0518e5ce-3db6-4cc9-9b4d-fa6ee9196882', 17, NULL, 'Will''s Story 2', 'Will''s Story 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <Free the Mind> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0518e5ce-3db6-4cc9-9b4d-fa6ee9196882'
);

UPDATE pieces piece
SET piece.title = '영화 <Free the Mind> 사운드트랙 중 "Will''s Story 2"', piece.title_en = 'Free the Mind: Original Motion Picture Soundtrack: Will''s Story 2', piece.editor_locked = 1
WHERE piece.id = 16075 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Englabörn & Variations

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Englabörn & Variations', 'Englabörn & Variations', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Englabörn & Variations'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3d64525-e903-4a4a-b15b-9448c15c45ef', 1, NULL, 'Odi et amo', 'Odi et amo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3d64525-e903-4a4a-b15b-9448c15c45ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16584 AND linked.composer_id = 206), 'musicbrainz:2315dd32-0de4-4218-921a-2a4b9de022a7', 2, NULL, 'Englabörn', 'Englabörn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2315dd32-0de4-4218-921a-2a4b9de022a7'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Englabörn"', piece.title_en = 'Englabörn & Variations: Englabörn', piece.editor_locked = 1
WHERE piece.id = 16584 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19062 AND linked.composer_id = 206), 'musicbrainz:bcf996b1-7241-4592-b869-76af6a3754be', 3, NULL, 'Jói & Karen', 'Jói & Karen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcf996b1-7241-4592-b869-76af6a3754be'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Jói & Karen"', piece.title_en = 'Englabörn & Variations: Jói & Karen', piece.editor_locked = 1
WHERE piece.id = 19062 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17195 AND linked.composer_id = 206), 'musicbrainz:4778f1f1-31b3-42d7-9ead-1f9982f64a6c', 4, NULL, 'Þetta gerist á bestu bæjum', 'Þetta gerist á bestu bæjum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4778f1f1-31b3-42d7-9ead-1f9982f64a6c'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Þetta gerist á bestu bæjum"', piece.title_en = 'Englabörn & Variations: Þetta gerist á bestu bæjum', piece.editor_locked = 1
WHERE piece.id = 17195 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16810 AND linked.composer_id = 206), 'musicbrainz:3185eb23-5475-4c31-adb7-3db73f9b6593', 5, NULL, 'Sálfræðingur', 'Sálfræðingur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3185eb23-5475-4c31-adb7-3db73f9b6593'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Sálfræðingur"', piece.title_en = 'Englabörn & Variations: Sálfræðingur', piece.editor_locked = 1
WHERE piece.id = 16810 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16920 AND linked.composer_id = 206), 'musicbrainz:377cdfe9-4341-4ed3-8e5f-28d1e2980b0b', 6, NULL, '“Ég sleppi þér aldrei”', '“Ég sleppi þér aldrei”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:377cdfe9-4341-4ed3-8e5f-28d1e2980b0b'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "“Ég sleppi þér aldrei”"', piece.title_en = 'Englabörn & Variations: “Ég sleppi þér aldrei”', piece.editor_locked = 1
WHERE piece.id = 16920 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19701 AND linked.composer_id = 206), 'musicbrainz:e76a709e-8896-4ce5-a908-bc4d8a047e45', 7, NULL, 'Sálfræðingur deyr', 'Sálfræðingur deyr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e76a709e-8896-4ce5-a908-bc4d8a047e45'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Sálfræðingur deyr"', piece.title_en = 'Englabörn & Variations: Sálfræðingur deyr', piece.editor_locked = 1
WHERE piece.id = 19701 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17247 AND linked.composer_id = 206), 'musicbrainz:4a58cbeb-008b-4c57-ba54-02ab707fd3e5', 8, NULL, 'Bað', 'Bað', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a58cbeb-008b-4c57-ba54-02ab707fd3e5'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Bað"', piece.title_en = 'Englabörn & Variations: Bað', piece.editor_locked = 1
WHERE piece.id = 17247 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18233 AND linked.composer_id = 206), 'musicbrainz:89538f73-d656-4ecc-91d6-7c4a73fdf426', 9, NULL, '“Ég heyrði allt án þess að hlusta”', '“Ég heyrði allt án þess að hlusta”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89538f73-d656-4ecc-91d6-7c4a73fdf426'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "“Ég heyrði allt án þess að hlusta”"', piece.title_en = 'Englabörn & Variations: “Ég heyrði allt án þess að hlusta”', piece.editor_locked = 1
WHERE piece.id = 18233 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19005 AND linked.composer_id = 206), 'musicbrainz:b8e4bfb7-5572-4bc0-afd4-1de3f0d29834', 10, NULL, 'Karen býr til engil', 'Karen býr til engil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8e4bfb7-5572-4bc0-afd4-1de3f0d29834'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Karen býr til engil"', piece.title_en = 'Englabörn & Variations: Karen býr til engil', piece.editor_locked = 1
WHERE piece.id = 19005 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19290 AND linked.composer_id = 206), 'musicbrainz:cb056a90-183e-49f2-b700-1401b478d712', 11, NULL, 'Englabörn – tilbrigði', 'Englabörn – tilbrigði', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb056a90-183e-49f2-b700-1401b478d712'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Englabörn – tilbrigði"', piece.title_en = 'Englabörn & Variations: Englabörn – tilbrigði', piece.editor_locked = 1
WHERE piece.id = 19290 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19009 AND linked.composer_id = 206), 'musicbrainz:b9412194-92fc-4313-92c9-c3ec9006a120', 12, NULL, '“Ég átti gráa æsku”', '“Ég átti gráa æsku”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9412194-92fc-4313-92c9-c3ec9006a120'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "“Ég átti gráa æsku”"', piece.title_en = 'Englabörn & Variations: “Ég átti gráa æsku”', piece.editor_locked = 1
WHERE piece.id = 19009 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17827 AND linked.composer_id = 206), 'musicbrainz:6e77af43-f4fc-49dc-b518-b3713891bb32', 13, NULL, 'Krókódíll', 'Krókódíll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e77af43-f4fc-49dc-b518-b3713891bb32'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Krókódíll"', piece.title_en = 'Englabörn & Variations: Krókódíll', piece.editor_locked = 1
WHERE piece.id = 17827 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17826 AND linked.composer_id = 206), 'musicbrainz:6e64382b-1148-4fb9-8cbf-0e33c03e195d', 14, NULL, '“Ef ég hefði aldrei…”', '“Ef ég hefði aldrei…”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e64382b-1148-4fb9-8cbf-0e33c03e195d'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "“Ef ég hefði aldrei…”"', piece.title_en = 'Englabörn & Variations: “Ef ég hefði aldrei…”', piece.editor_locked = 1
WHERE piece.id = 17826 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16598 AND linked.composer_id = 206), 'musicbrainz:24429771-d4a0-43e2-830f-26e4b290d975', 15, NULL, '…eins og venjulegt fólk', '…eins og venjulegt fólk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24429771-d4a0-43e2-830f-26e4b290d975'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "…eins og venjulegt fólk"', piece.title_en = 'Englabörn & Variations: …eins og venjulegt fólk', piece.editor_locked = 1
WHERE piece.id = 16598 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16193 AND linked.composer_id = 206), 'musicbrainz:0c3e804d-e4e2-495e-9556-1aeecae2f858', 16, NULL, 'Odi et Amo – bis', 'Odi et Amo – bis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c3e804d-e4e2-495e-9556-1aeecae2f858'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Odi et Amo – bis"', piece.title_en = 'Englabörn & Variations: Odi et Amo – bis', piece.editor_locked = 1
WHERE piece.id = 16193 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb181126-b6be-4eb4-8ae6-a23d359efbba', 17, NULL, '“Ég heyrði allt án þess að hlusta” (A Winged Victory for the Sullen rework)', '“Ég heyrði allt án þess að hlusta” (A Winged Victory for the Sullen rework)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb181126-b6be-4eb4-8ae6-a23d359efbba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:209a283e-b4d4-405f-a754-f02b2837ec88', 18, NULL, 'Odi et Amo (Jóhannson/Donadello rework)', 'Odi et Amo (Jóhannson/Donadello rework)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:209a283e-b4d4-405f-a754-f02b2837ec88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e6f56d9-11db-4c87-885f-e508daa04049', 19, NULL, 'Englabörn (Víkingur Ólafsson piano version)', 'Englabörn (Víkingur Ólafsson piano version)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e6f56d9-11db-4c87-885f-e508daa04049'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0996f945-010d-47f2-882e-5e07545829ae', 20, NULL, 'Jói & Karen (Ryuichi Sakamoto rework)', 'Jói & Karen (Ryuichi Sakamoto rework)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0996f945-010d-47f2-882e-5e07545829ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18345 AND linked.composer_id = 206), 'musicbrainz:8f606df3-1e3b-4d7e-a9cc-a181da163596', 21, NULL, 'Holy Thursday (“Ég heyrði allt án þess að hlusta”) (Theatre of Voices version)', 'Holy Thursday (“Ég heyrði allt án þess að hlusta”) (Theatre of Voices version)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f606df3-1e3b-4d7e-a9cc-a181da163596'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Holy Thursday (“Ég heyrði allt án þess að hlusta”) (Theatre of Voices version)"', piece.title_en = 'Englabörn & Variations: Holy Thursday (“Ég heyrði allt án þess að hlusta”) (Theatre of Voices version)', piece.editor_locked = 1
WHERE piece.id = 18345 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8636e994-0205-445c-819d-08ad60188fb5', 22, NULL, 'Englabörn (Viktor Orri Árnason rework)', 'Englabörn (Viktor Orri Árnason rework)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8636e994-0205-445c-819d-08ad60188fb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a22f2a-58ea-4534-bb22-43a4b4391225', 23, NULL, 'Odi et Amo – bis (Alex Somers rework)', 'Odi et Amo – bis (Alex Somers rework)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a22f2a-58ea-4534-bb22-43a4b4391225'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10a35eca-654a-4bfd-b34f-7a952b157347', 24, NULL, 'Sálfræðingur deyr (Hildur Guðnadóttir rework)', 'Sálfræðingur deyr (Hildur Guðnadóttir rework)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10a35eca-654a-4bfd-b34f-7a952b157347'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f523a6a0-9fb1-41a7-afcd-292a32d2ebbb', 25, NULL, 'Odi et Amo – bis (Jóhannson/Donadello rework)', 'Odi et Amo – bis (Jóhannson/Donadello rework)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f523a6a0-9fb1-41a7-afcd-292a32d2ebbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1f90ebb-207a-42d2-94e8-1b4f3ce47f61', 26, NULL, '…eins og venjulegt fólk (Paul Corley rework)', '…eins og venjulegt fólk (Paul Corley rework)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1f90ebb-207a-42d2-94e8-1b4f3ce47f61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16885 AND linked.composer_id = 206), 'musicbrainz:352e79bc-bd59-4e7c-9e99-48d4668d314d', 27, NULL, 'Odi et Amo (Theatre of Voices version)', 'Odi et Amo (Theatre of Voices version)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Englabörn & Variations' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:352e79bc-bd59-4e7c-9e99-48d4668d314d'
);

UPDATE pieces piece
SET piece.title = 'Englabörn & Variations 중 "Odi et Amo (Theatre of Voices version)"', piece.title_en = 'Englabörn & Variations: Odi et Amo (Theatre of Voices version)', piece.editor_locked = 1
WHERE piece.id = 16885 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <시카리오: 암살자의 도시> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <시카리오: 암살자의 도시> 사운드트랙', 'Sicario: Original Motion Picture Soundtrack', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <시카리오: 암살자의 도시> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18397 AND linked.composer_id = 206), 'musicbrainz:923b1d31-15ba-4f21-882a-dc0add3ea102', 1, NULL, 'Armoured Vehicle', 'Armoured Vehicle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:923b1d31-15ba-4f21-882a-dc0add3ea102'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Armoured Vehicle"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Armoured Vehicle', piece.editor_locked = 1
WHERE piece.id = 18397 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19326 AND linked.composer_id = 206), 'musicbrainz:cdbeaf51-c491-4c28-afb1-236071d75ee9', 2, NULL, 'The Beast', 'The Beast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdbeaf51-c491-4c28-afb1-236071d75ee9'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "The Beast"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: The Beast', piece.editor_locked = 1
WHERE piece.id = 19326 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16778 AND linked.composer_id = 206), 'musicbrainz:2fbfb02a-fe5d-453e-8164-9ec81a8c04eb', 3, NULL, 'The Border', 'The Border', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fbfb02a-fe5d-453e-8164-9ec81a8c04eb'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "The Border"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: The Border', piece.editor_locked = 1
WHERE piece.id = 16778 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16826 AND linked.composer_id = 206), 'musicbrainz:3257f126-5eeb-43c8-b2ff-dbb0eb18213a', 4, NULL, 'Drywall', 'Drywall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3257f126-5eeb-43c8-b2ff-dbb0eb18213a'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Drywall"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Drywall', piece.editor_locked = 1
WHERE piece.id = 16826 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19595 AND linked.composer_id = 206), 'musicbrainz:dfef4d42-e8ff-4a08-8b4d-f004bb54aa9c', 5, NULL, 'Explosion', 'Explosion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfef4d42-e8ff-4a08-8b4d-f004bb54aa9c'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Explosion"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Explosion', piece.editor_locked = 1
WHERE piece.id = 19595 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16047 AND linked.composer_id = 206), 'musicbrainz:0386c79b-5d7b-402d-a700-d822e62d8b86', 6, NULL, 'Desert Music', 'Desert Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0386c79b-5d7b-402d-a700-d822e62d8b86'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Desert Music"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Desert Music', piece.editor_locked = 1
WHERE piece.id = 16047 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18370 AND linked.composer_id = 206), 'musicbrainz:90c6061b-6c66-4230-86fd-132b6876db53', 7, NULL, 'Target', 'Target', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90c6061b-6c66-4230-86fd-132b6876db53'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Target"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Target', piece.editor_locked = 1
WHERE piece.id = 18370 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18470 AND linked.composer_id = 206), 'musicbrainz:970557b0-6e20-4b64-ab0e-5196dfbe41d8', 8, NULL, 'Convoy', 'Convoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:970557b0-6e20-4b64-ab0e-5196dfbe41d8'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Convoy"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Convoy', piece.editor_locked = 1
WHERE piece.id = 18470 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18220 AND linked.composer_id = 206), 'musicbrainz:8831065e-8819-41ee-9742-599289a61b64', 9, NULL, 'The Bank', 'The Bank', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8831065e-8819-41ee-9742-599289a61b64'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "The Bank"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: The Bank', piece.editor_locked = 1
WHERE piece.id = 18220 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19339 AND linked.composer_id = 206), 'musicbrainz:ce8e1996-4f21-4982-9f50-135ef7625318', 10, NULL, 'Surveillance', 'Surveillance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce8e1996-4f21-4982-9f50-135ef7625318'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Surveillance"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Surveillance', piece.editor_locked = 1
WHERE piece.id = 19339 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1f462c3-2f2d-4c34-b8fa-3d2bc56e077a', 11, NULL, 'Reflection', 'Reflection', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1f462c3-2f2d-4c34-b8fa-3d2bc56e077a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17150 AND linked.composer_id = 206), 'musicbrainz:453264aa-30b6-4c87-94d8-06b4d33d2574', 12, NULL, 'Melancholia', 'Melancholia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:453264aa-30b6-4c87-94d8-06b4d33d2574'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Melancholia"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Melancholia', piece.editor_locked = 1
WHERE piece.id = 17150 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9d55e71-f448-4deb-880e-4ad7f25345f8', 13, NULL, 'Night Vision', 'Night Vision', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9d55e71-f448-4deb-880e-4ad7f25345f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18745 AND linked.composer_id = 206), 'musicbrainz:a7e01f74-f7f6-4af0-bffe-7d486f336130', 14, NULL, 'Tunnel Music', 'Tunnel Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7e01f74-f7f6-4af0-bffe-7d486f336130'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Tunnel Music"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Tunnel Music', piece.editor_locked = 1
WHERE piece.id = 18745 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:670015e9-f2a6-465e-9fd9-f3454476b99d', 15, NULL, 'Fausto', 'Fausto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:670015e9-f2a6-465e-9fd9-f3454476b99d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17942 AND linked.composer_id = 206), 'musicbrainz:74b473b9-e477-4153-af8f-41a72c4eca45', 16, NULL, 'Balcony', 'Balcony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74b473b9-e477-4153-af8f-41a72c4eca45'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Balcony"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Balcony', piece.editor_locked = 1
WHERE piece.id = 17942 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18733 AND linked.composer_id = 206), 'musicbrainz:a70901b5-7f5d-42e5-87ef-74b1142f1c74', 17, NULL, 'Soccer Game', 'Soccer Game', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a70901b5-7f5d-42e5-87ef-74b1142f1c74'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Soccer Game"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Soccer Game', piece.editor_locked = 1
WHERE piece.id = 18733 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17866 AND linked.composer_id = 206), 'musicbrainz:703d9249-3d07-4dc3-8aa9-f67eb7d2d227', 18, NULL, 'Alejandro’s Song', 'Alejandro’s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '영화 <시카리오: 암살자의 도시> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:703d9249-3d07-4dc3-8aa9-f67eb7d2d227'
);

UPDATE pieces piece
SET piece.title = '영화 <시카리오: 암살자의 도시> 사운드트랙 중 "Alejandro’s Song"', piece.title_en = 'Sicario: Original Motion Picture Soundtrack: Alejandro’s Song', piece.editor_locked = 1
WHERE piece.id = 17866 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Orphée

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Orphée', 'Orphée', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Orphée'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20058 AND linked.composer_id = 206), 'musicbrainz:fd68ed9f-6fbb-4d98-b18a-51f86d8cc528', 1, NULL, 'Flight From the City', 'Flight From the City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd68ed9f-6fbb-4d98-b18a-51f86d8cc528'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "Flight From the City"', piece.title_en = 'Orphée: Flight From the City', piece.editor_locked = 1
WHERE piece.id = 20058 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17385 AND linked.composer_id = 206), 'musicbrainz:53e67255-3719-4fbc-9bde-d6949303c58c', 2, NULL, 'A Song for Europa', 'A Song for Europa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53e67255-3719-4fbc-9bde-d6949303c58c'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "A Song for Europa"', piece.title_en = 'Orphée: A Song for Europa', piece.editor_locked = 1
WHERE piece.id = 17385 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18408 AND linked.composer_id = 206), 'musicbrainz:930bcc59-0773-4170-b238-c31df297073f', 3, NULL, 'The Drowned World', 'The Drowned World', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:930bcc59-0773-4170-b238-c31df297073f'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "The Drowned World"', piece.title_en = 'Orphée: The Drowned World', piece.editor_locked = 1
WHERE piece.id = 18408 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20094 AND linked.composer_id = 206), 'musicbrainz:ffc90f00-1b5c-4545-b459-fcef0c187d94', 4, NULL, 'A Deal With Chaos', 'A Deal With Chaos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffc90f00-1b5c-4545-b459-fcef0c187d94'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "A Deal With Chaos"', piece.title_en = 'Orphée: A Deal With Chaos', piece.editor_locked = 1
WHERE piece.id = 20094 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98166d99-2ecb-4abf-8d08-5b10897d8765', 5, NULL, 'A Pile of Dust', 'A Pile of Dust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98166d99-2ecb-4abf-8d08-5b10897d8765'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16314 AND linked.composer_id = 206), 'musicbrainz:129807c6-3b83-4813-a1db-91abe6d3e06a', 6, NULL, 'A Sparrow Alighted Upon Our Shoulder', 'A Sparrow Alighted Upon Our Shoulder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:129807c6-3b83-4813-a1db-91abe6d3e06a'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "A Sparrow Alighted Upon Our Shoulder"', piece.title_en = 'Orphée: A Sparrow Alighted Upon Our Shoulder', piece.editor_locked = 1
WHERE piece.id = 16314 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18595 AND linked.composer_id = 206), 'musicbrainz:9edc90c3-7ead-4ff6-9ffe-ca8e4ecd69ae', 7, NULL, 'Fragment I', 'Fragment I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9edc90c3-7ead-4ff6-9ffe-ca8e4ecd69ae'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "Fragment I"', piece.title_en = 'Orphée: Fragment I', piece.editor_locked = 1
WHERE piece.id = 18595 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18072 AND linked.composer_id = 206), 'musicbrainz:7cebcab3-60d8-412f-b19c-3cbff473b604', 8, NULL, 'By the Roes, and by the Hinds of the Field', 'By the Roes, and by the Hinds of the Field', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cebcab3-60d8-412f-b19c-3cbff473b604'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "By the Roes, and by the Hinds of the Field"', piece.title_en = 'Orphée: By the Roes, and by the Hinds of the Field', piece.editor_locked = 1
WHERE piece.id = 18072 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18727 AND linked.composer_id = 206), 'musicbrainz:a6be4f99-16ea-44ee-9b69-a0b50ed34a64', 9, NULL, 'The Radiant City', 'The Radiant City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6be4f99-16ea-44ee-9b69-a0b50ed34a64'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "The Radiant City"', piece.title_en = 'Orphée: The Radiant City', piece.editor_locked = 1
WHERE piece.id = 18727 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18346 AND linked.composer_id = 206), 'musicbrainz:8f62ff65-2511-40a2-8b50-ee3da7bac96c', 10, NULL, 'Fragment II', 'Fragment II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f62ff65-2511-40a2-8b50-ee3da7bac96c'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "Fragment II"', piece.title_en = 'Orphée: Fragment II', piece.editor_locked = 1
WHERE piece.id = 18346 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19124 AND linked.composer_id = 206), 'musicbrainz:c09803f1-0a5d-4670-8f9e-7d3c9d6ee828', 11, NULL, 'The Burning Mountain', 'The Burning Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c09803f1-0a5d-4670-8f9e-7d3c9d6ee828'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "The Burning Mountain"', piece.title_en = 'Orphée: The Burning Mountain', piece.editor_locked = 1
WHERE piece.id = 19124 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17043 AND linked.composer_id = 206), 'musicbrainz:3eafc1ba-146d-4545-aa09-3704e81ff294', 12, NULL, 'De Luce et Umbra', 'De Luce et Umbra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eafc1ba-146d-4545-aa09-3704e81ff294'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "De Luce et Umbra"', piece.title_en = 'Orphée: De Luce et Umbra', piece.editor_locked = 1
WHERE piece.id = 17043 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16442 AND linked.composer_id = 206), 'musicbrainz:19c6db39-987f-4dc4-9f65-66178858d1fa', 13, NULL, 'Good Morning, Midnight', 'Good Morning, Midnight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19c6db39-987f-4dc4-9f65-66178858d1fa'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "Good Morning, Midnight"', piece.title_en = 'Orphée: Good Morning, Midnight', piece.editor_locked = 1
WHERE piece.id = 16442 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17914 AND linked.composer_id = 206), 'musicbrainz:7307f005-126a-4f0a-817c-51ba3ca20353', 14, NULL, 'Good Night, Day', 'Good Night, Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7307f005-126a-4f0a-817c-51ba3ca20353'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "Good Night, Day"', piece.title_en = 'Orphée: Good Night, Day', piece.editor_locked = 1
WHERE piece.id = 17914 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19648 AND linked.composer_id = 206), 'musicbrainz:e2b6ce77-632c-454b-85e4-0e808c12710f', 15, NULL, 'Orphic Hymn', 'Orphic Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Orphée' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2b6ce77-632c-454b-85e4-0e808c12710f'
);

UPDATE pieces piece
SET piece.title = 'Orphée 중 "Orphic Hymn"', piece.title_en = 'Orphée: Orphic Hymn', piece.editor_locked = 1
WHERE piece.id = 19648 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None White Black Boy: Original Soundtrack

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'White Black Boy: Original Soundtrack', 'White Black Boy: Original Soundtrack', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'White Black Boy: Original Soundtrack'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:142ab8bc-564b-4c62-b7dc-51cd5295573d', 1, NULL, 'Intro', 'Intro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:142ab8bc-564b-4c62-b7dc-51cd5295573d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17699 AND linked.composer_id = 206), 'musicbrainz:66dc7bda-0ee2-4aa2-8792-6a0f91d64ec7', 2, NULL, 'Playing With Ball', 'Playing With Ball', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66dc7bda-0ee2-4aa2-8792-6a0f91d64ec7'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Playing With Ball"', piece.title_en = 'White Black Boy: Original Soundtrack: Playing With Ball', piece.editor_locked = 1
WHERE piece.id = 17699 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16275 AND linked.composer_id = 206), 'musicbrainz:109a8031-965f-4e5d-a5cd-ece39f5213c7', 3, NULL, 'Dying Bird', 'Dying Bird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:109a8031-965f-4e5d-a5cd-ece39f5213c7'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Dying Bird"', piece.title_en = 'White Black Boy: Original Soundtrack: Dying Bird', piece.editor_locked = 1
WHERE piece.id = 16275 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16730 AND linked.composer_id = 206), 'musicbrainz:2c2b6c99-fe64-476e-bb72-dcca105f8f65', 4, NULL, 'Exam Results', 'Exam Results', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c2b6c99-fe64-476e-bb72-dcca105f8f65'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Exam Results"', piece.title_en = 'White Black Boy: Original Soundtrack: Exam Results', piece.editor_locked = 1
WHERE piece.id = 16730 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17251 AND linked.composer_id = 206), 'musicbrainz:4aaf40cc-5e0b-4222-9052-68e3816d2615', 5, NULL, 'Nightmare II', 'Nightmare II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aaf40cc-5e0b-4222-9052-68e3816d2615'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Nightmare II"', piece.title_en = 'White Black Boy: Original Soundtrack: Nightmare II', piece.editor_locked = 1
WHERE piece.id = 17251 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16599 AND linked.composer_id = 206), 'musicbrainz:245a5800-66bc-4633-a92d-ec5c76b26156', 6, NULL, 'Feather', 'Feather', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:245a5800-66bc-4633-a92d-ec5c76b26156'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Feather"', piece.title_en = 'White Black Boy: Original Soundtrack: Feather', piece.editor_locked = 1
WHERE piece.id = 16599 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40bb6e10-a7f7-452a-b61c-3f25e863206e', 7, NULL, 'Sun', 'Sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40bb6e10-a7f7-452a-b61c-3f25e863206e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17481 AND linked.composer_id = 206), 'musicbrainz:593a9924-5863-4748-9dcc-4de321a2003a', 8, NULL, 'Bad Results', 'Bad Results', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:593a9924-5863-4748-9dcc-4de321a2003a'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Bad Results"', piece.title_en = 'White Black Boy: Original Soundtrack: Bad Results', piece.editor_locked = 1
WHERE piece.id = 17481 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19335 AND linked.composer_id = 206), 'musicbrainz:ce49b9a1-5a97-4308-addb-c0cf745f9c76', 9, NULL, 'Exam', 'Exam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce49b9a1-5a97-4308-addb-c0cf745f9c76'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Exam"', piece.title_en = 'White Black Boy: Original Soundtrack: Exam', piece.editor_locked = 1
WHERE piece.id = 19335 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19739 AND linked.composer_id = 206), 'musicbrainz:ea43f828-9cd2-4bcf-a268-537bc52af8e4', 10, NULL, 'Nightmare', 'Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea43f828-9cd2-4bcf-a268-537bc52af8e4'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Nightmare"', piece.title_en = 'White Black Boy: Original Soundtrack: Nightmare', piece.editor_locked = 1
WHERE piece.id = 19739 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16439 AND linked.composer_id = 206), 'musicbrainz:19a97b39-85cb-4690-af17-06ed4d1084e5', 11, NULL, 'Time To Say Goodbye', 'Time To Say Goodbye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19a97b39-85cb-4690-af17-06ed4d1084e5'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Time To Say Goodbye"', piece.title_en = 'White Black Boy: Original Soundtrack: Time To Say Goodbye', piece.editor_locked = 1
WHERE piece.id = 16439 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8647c523-d484-4af3-9312-a9bdb454a856', 12, NULL, 'End Theme', 'End Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8647c523-d484-4af3-9312-a9bdb454a856'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16741 AND linked.composer_id = 206), 'musicbrainz:2d2ab3cf-c47b-45ff-a11a-dff58ff00964', 13, NULL, 'Automobile', 'Automobile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'White Black Boy: Original Soundtrack' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d2ab3cf-c47b-45ff-a11a-dff58ff00964'
);

UPDATE pieces piece
SET piece.title = 'White Black Boy: Original Soundtrack 중 "Automobile"', piece.title_en = 'White Black Boy: Original Soundtrack: Automobile', piece.editor_locked = 1
WHERE piece.id = 16741 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None And in the Endless Pause There Came the Sound of Bees

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'And in the Endless Pause There Came the Sound of Bees', 'And in the Endless Pause There Came the Sound of Bees', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'And in the Endless Pause There Came the Sound of Bees'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:894655b3-1746-4f71-a814-4635bc42a034', 1, NULL, 'Theme', 'Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:894655b3-1746-4f71-a814-4635bc42a034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17404 AND linked.composer_id = 206), 'musicbrainz:54d06fd5-8ed5-4499-90d3-3c1c192d4943', 2, NULL, 'City Building', 'City Building', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54d06fd5-8ed5-4499-90d3-3c1c192d4943'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "City Building"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: City Building', piece.editor_locked = 1
WHERE piece.id = 17404 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19018 AND linked.composer_id = 206), 'musicbrainz:ba665fb1-5e48-4d61-ad9f-9a3e597b8422', 3, NULL, 'Entering the City', 'Entering the City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba665fb1-5e48-4d61-ad9f-9a3e597b8422'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "Entering the City"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: Entering the City', piece.editor_locked = 1
WHERE piece.id = 19018 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18276 AND linked.composer_id = 206), 'musicbrainz:8bb9735d-1f2e-49a9-9054-f188ba3304df', 4, NULL, 'The Flat', 'The Flat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb9735d-1f2e-49a9-9054-f188ba3304df'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "The Flat"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: The Flat', piece.editor_locked = 1
WHERE piece.id = 18276 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18040 AND linked.composer_id = 206), 'musicbrainz:7b684f13-3640-4c2a-b214-ea4e68bd8886', 5, NULL, 'Rainwater', 'Rainwater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b684f13-3640-4c2a-b214-ea4e68bd8886'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "Rainwater"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: Rainwater', piece.editor_locked = 1
WHERE piece.id = 18040 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18284 AND linked.composer_id = 206), 'musicbrainz:8c3df0fe-596d-4965-af3c-29eabb8c2019', 6, NULL, 'Siren Song', 'Siren Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c3df0fe-596d-4965-af3c-29eabb8c2019'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "Siren Song"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: Siren Song', piece.editor_locked = 1
WHERE piece.id = 18284 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17869 AND linked.composer_id = 206), 'musicbrainz:7062a265-bbf7-499f-8517-0bacca9434c4', 7, NULL, 'Pods', 'Pods', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7062a265-bbf7-499f-8517-0bacca9434c4'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "Pods"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: Pods', piece.editor_locked = 1
WHERE piece.id = 17869 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17344 AND linked.composer_id = 206), 'musicbrainz:517183b0-2b77-4b20-a235-c7b2d764cf6d', 8, NULL, 'The Gift', 'The Gift', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:517183b0-2b77-4b20-a235-c7b2d764cf6d'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "The Gift"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: The Gift', piece.editor_locked = 1
WHERE piece.id = 17344 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18421 AND linked.composer_id = 206), 'musicbrainz:93b8bb44-b1f2-4235-abd2-2b7f49a829ee', 9, NULL, 'Dying City', 'Dying City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93b8bb44-b1f2-4235-abd2-2b7f49a829ee'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "Dying City"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: Dying City', piece.editor_locked = 1
WHERE piece.id = 18421 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db34c109-8e03-47f2-80dd-42e1edbbde31', 10, NULL, 'City Building (alternate version)', 'City Building (alternate version)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db34c109-8e03-47f2-80dd-42e1edbbde31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f0ce53d-90ee-4399-a521-4691aedf4936', 11, NULL, 'Escape', 'Escape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f0ce53d-90ee-4399-a521-4691aedf4936'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20020 AND linked.composer_id = 206), 'musicbrainz:faa87df1-b140-471d-be70-1c95f7cda6a5', 12, NULL, 'Inside the Pods', 'Inside the Pods', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faa87df1-b140-471d-be70-1c95f7cda6a5'
);

UPDATE pieces piece
SET piece.title = 'And in the Endless Pause There Came the Sound of Bees 중 "Inside the Pods"', piece.title_en = 'And in the Endless Pause There Came the Sound of Bees: Inside the Pods', piece.editor_locked = 1
WHERE piece.id = 20020 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ab9e78f-2915-4e64-a0ac-c453b7002179', 13, NULL, 'End Theme', 'End Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'And in the Endless Pause There Came the Sound of Bees' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ab9e78f-2915-4e64-a0ac-c453b7002179'
);


-- None Fordlândia (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Fordlândia (음반)', 'Fordlândia', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Fordlândia (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17549 AND linked.composer_id = 206), 'musicbrainz:5ddf0ee0-1e2a-45ad-9b8f-74b0a9aa6270', 1, NULL, 'Fordlândia', 'Fordlândia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ddf0ee0-1e2a-45ad-9b8f-74b0a9aa6270'
);

UPDATE pieces piece
SET piece.title = 'Fordlândia (음반) 중 "Fordlândia"', piece.title_en = 'Fordlândia: Fordlândia', piece.editor_locked = 1
WHERE piece.id = 17549 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caab94dc-1ce5-4d42-aa9c-6b0c7652417e', 2, NULL, 'Melodia (I)', 'Melodia (I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caab94dc-1ce5-4d42-aa9c-6b0c7652417e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18330 AND linked.composer_id = 206), 'musicbrainz:8e7e68ad-8e9f-4571-998d-e104fd0c8378', 3, NULL, 'The Rocket Builder (Io Pan!)', 'The Rocket Builder (Io Pan!)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e7e68ad-8e9f-4571-998d-e104fd0c8378'
);

UPDATE pieces piece
SET piece.title = 'Fordlândia (음반) 중 "The Rocket Builder (Io Pan!)"', piece.title_en = 'Fordlândia: The Rocket Builder (Io Pan!)', piece.editor_locked = 1
WHERE piece.id = 18330 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b03cb1e-0acd-4add-a551-6b8e2c8d63f3', 4, NULL, 'Melodia (II)', 'Melodia (II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b03cb1e-0acd-4add-a551-6b8e2c8d63f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16686 AND linked.composer_id = 206), 'musicbrainz:29ac562e-9fe2-49cb-baf1-6426da144f8c', 5, NULL, 'Aerial View', 'Fordlândia – Aerial View', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ac562e-9fe2-49cb-baf1-6426da144f8c'
);

UPDATE pieces piece
SET piece.title = 'Fordlândia (음반) 중 "Aerial View"', piece.title_en = 'Fordlândia: Fordlândia – Aerial View', piece.editor_locked = 1
WHERE piece.id = 16686 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16173 AND linked.composer_id = 206), 'musicbrainz:0ad1aced-ead5-4504-a893-ba4888787cf4', 6, NULL, 'Melodia (III)', 'Melodia (III)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad1aced-ead5-4504-a893-ba4888787cf4'
);

UPDATE pieces piece
SET piece.title = 'Fordlândia (음반) 중 "Melodia (III)"', piece.title_en = 'Fordlândia: Melodia (III)', piece.editor_locked = 1
WHERE piece.id = 16173 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19541 AND linked.composer_id = 206), 'musicbrainz:dbed3422-a41c-47c1-a84d-0cf2da187c18', 7, NULL, 'Chimaerica', 'Chimaerica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbed3422-a41c-47c1-a84d-0cf2da187c18'
);

UPDATE pieces piece
SET piece.title = 'Fordlândia (음반) 중 "Chimaerica"', piece.title_en = 'Fordlândia: Chimaerica', piece.editor_locked = 1
WHERE piece.id = 19541 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bf22b32-25ff-4958-b180-2defe3c58c13', 8, NULL, 'Melodia (IV)', 'Melodia (IV)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bf22b32-25ff-4958-b180-2defe3c58c13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19186 AND linked.composer_id = 206), 'musicbrainz:c4a7df08-83f0-44d9-8b6c-3ff7a9463385', 9, NULL, 'The Great God Pan Is Dead', 'The Great God Pan Is Dead', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4a7df08-83f0-44d9-8b6c-3ff7a9463385'
);

UPDATE pieces piece
SET piece.title = 'Fordlândia (음반) 중 "The Great God Pan Is Dead"', piece.title_en = 'Fordlândia: The Great God Pan Is Dead', piece.editor_locked = 1
WHERE piece.id = 19186 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffc1199e-dd90-43df-b664-539a680920a1', 10, NULL, 'Melodia (Guidelines for a Space Propulsion Device Based on Heim’s Quantum Theory)', 'Melodia (Guidelines for a Space Propulsion Device Based on Heim’s Quantum Theory)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffc1199e-dd90-43df-b664-539a680920a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18962 AND linked.composer_id = 206), 'musicbrainz:b62bb221-7115-412a-87e4-62a1de7c8231', 11, NULL, 'How We Left Fordlândia', 'How We Left Fordlândia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Fordlândia (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b62bb221-7115-412a-87e4-62a1de7c8231'
);

UPDATE pieces piece
SET piece.title = 'Fordlândia (음반) 중 "How We Left Fordlândia"', piece.title_en = 'Fordlândia: How We Left Fordlândia', piece.editor_locked = 1
WHERE piece.id = 18962 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None IBM 1401, A User’s Manual

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'IBM 1401, A User’s Manual', 'IBM 1401, A User’s Manual', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'IBM 1401, A User’s Manual'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18848 AND linked.composer_id = 206), 'musicbrainz:aea9def6-f27d-3d63-b2a0-941867c9b5d8', 1, NULL, 'Part 1: IBM 1401 Processing Unit', 'Part 1: IBM 1401 Processing Unit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'IBM 1401, A User’s Manual' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea9def6-f27d-3d63-b2a0-941867c9b5d8'
);

UPDATE pieces piece
SET piece.title = 'IBM 1401, A User’s Manual 중 "Part 1: IBM 1401 Processing Unit"', piece.title_en = 'IBM 1401, A User’s Manual: Part 1: IBM 1401 Processing Unit', piece.editor_locked = 1
WHERE piece.id = 18848 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16127 AND linked.composer_id = 206), 'musicbrainz:07f86561-2b17-3998-a63b-738ef0d1b8a0', 2, NULL, 'Part 2: IBM 1403 Printer', 'Part 2: IBM 1403 Printer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'IBM 1401, A User’s Manual' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07f86561-2b17-3998-a63b-738ef0d1b8a0'
);

UPDATE pieces piece
SET piece.title = 'IBM 1401, A User’s Manual 중 "Part 2: IBM 1403 Printer"', piece.title_en = 'IBM 1401, A User’s Manual: Part 2: IBM 1403 Printer', piece.editor_locked = 1
WHERE piece.id = 16127 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17214 AND linked.composer_id = 206), 'musicbrainz:48a67c13-1df9-3f15-b07a-e11e2237bc91', 3, NULL, 'Part 3: IBM 1402 Card Read-Punch', 'Part 3: IBM 1402 Card Read-Punch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'IBM 1401, A User’s Manual' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48a67c13-1df9-3f15-b07a-e11e2237bc91'
);

UPDATE pieces piece
SET piece.title = 'IBM 1401, A User’s Manual 중 "Part 3: IBM 1402 Card Read-Punch"', piece.title_en = 'IBM 1401, A User’s Manual: Part 3: IBM 1402 Card Read-Punch', piece.editor_locked = 1
WHERE piece.id = 17214 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16425 AND linked.composer_id = 206), 'musicbrainz:18cbc99c-3899-3c93-9b3d-0407e8155f02', 4, NULL, 'Part 4: IBM 729 II Magnetic Tape Unit', 'Part 4: IBM 729 II Magnetic Tape Unit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'IBM 1401, A User’s Manual' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18cbc99c-3899-3c93-9b3d-0407e8155f02'
);

UPDATE pieces piece
SET piece.title = 'IBM 1401, A User’s Manual 중 "Part 4: IBM 729 II Magnetic Tape Unit"', piece.title_en = 'IBM 1401, A User’s Manual: Part 4: IBM 729 II Magnetic Tape Unit', piece.editor_locked = 1
WHERE piece.id = 16425 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19810 AND linked.composer_id = 206), 'musicbrainz:ef5176e6-3ec5-3685-81ac-e4b7de286d38', 5, NULL, 'Part 5: The Sun''s Gone Dim and the Sky''s Turned Black', 'Part 5: The Sun''s Gone Dim and the Sky''s Turned Black', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'IBM 1401, A User’s Manual' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef5176e6-3ec5-3685-81ac-e4b7de286d38'
);

UPDATE pieces piece
SET piece.title = 'IBM 1401, A User’s Manual 중 "Part 5: The Sun''s Gone Dim and the Sky''s Turned Black"', piece.title_en = 'IBM 1401, A User’s Manual: Part 5: The Sun''s Gone Dim and the Sky''s Turned Black', piece.editor_locked = 1
WHERE piece.id = 19810 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Virðulegu Forsetar

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Virðulegu Forsetar', 'Virðulegu Forsetar', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Virðulegu Forsetar'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18910 AND linked.composer_id = 206), 'musicbrainz:b2a7baad-5510-46ce-91a7-d024477a038d', 1, NULL, 'Part 1', 'Virðulegu Forsetar: Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Virðulegu Forsetar' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a7baad-5510-46ce-91a7-d024477a038d'
);

UPDATE pieces piece
SET piece.title = 'Virðulegu Forsetar 중 "Part 1"', piece.title_en = 'Virðulegu Forsetar: Virðulegu Forsetar: Part 1', piece.editor_locked = 1
WHERE piece.id = 18910 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17095 AND linked.composer_id = 206), 'musicbrainz:422800c1-d34d-48bc-82db-faaae87b338b', 2, NULL, 'Part 2', 'Virðulegu Forsetar: Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Virðulegu Forsetar' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:422800c1-d34d-48bc-82db-faaae87b338b'
);

UPDATE pieces piece
SET piece.title = 'Virðulegu Forsetar 중 "Part 2"', piece.title_en = 'Virðulegu Forsetar: Virðulegu Forsetar: Part 2', piece.editor_locked = 1
WHERE piece.id = 17095 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17718 AND linked.composer_id = 206), 'musicbrainz:680670a3-6977-4545-a8fb-a06e6ed15fd8', 3, NULL, 'Part 3', 'Virðulegu Forsetar: Part 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Virðulegu Forsetar' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:680670a3-6977-4545-a8fb-a06e6ed15fd8'
);

UPDATE pieces piece
SET piece.title = 'Virðulegu Forsetar 중 "Part 3"', piece.title_en = 'Virðulegu Forsetar: Virðulegu Forsetar: Part 3', piece.editor_locked = 1
WHERE piece.id = 17718 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17248 AND linked.composer_id = 206), 'musicbrainz:4a5b1d26-d0f9-4a8d-a54e-413ef7718434', 4, NULL, 'Part 4', 'Virðulegu Forsetar: Part 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = 'Virðulegu Forsetar' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a5b1d26-d0f9-4a8d-a54e-413ef7718434'
);

UPDATE pieces piece
SET piece.title = 'Virðulegu Forsetar 중 "Part 4"', piece.title_en = 'Virðulegu Forsetar: Virðulegu Forsetar: Part 4', piece.editor_locked = 1
WHERE piece.id = 17248 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 2012-05-15: De Duif, Amsterdam, Netherlands

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2012-05-15: De Duif, Amsterdam, Netherlands', '2012-05-15: De Duif, Amsterdam, Netherlands', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 206
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2012-05-15: De Duif, Amsterdam, Netherlands'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15727 AND linked.composer_id = 206), 'musicbrainz:0ec7e18c-b79a-4121-ade6-b9f348f4429a', 1, NULL, 'They Being Dead Yet Speaketh', 'They Being Dead Yet Speaketh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '2012-05-15: De Duif, Amsterdam, Netherlands' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ec7e18c-b79a-4121-ade6-b9f348f4429a'
);

UPDATE pieces piece
SET piece.title = '2012-05-15: De Duif, Amsterdam, Netherlands 중 "They Being Dead Yet Speaketh"', piece.title_en = '2012-05-15: De Duif, Amsterdam, Netherlands: They Being Dead Yet Speaketh', piece.editor_locked = 1
WHERE piece.id = 15727 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd68ed9f-6fbb-4d98-b18a-51f86d8cc528', 2, NULL, 'Flight From the City', 'Flight From the City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '2012-05-15: De Duif, Amsterdam, Netherlands' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd68ed9f-6fbb-4d98-b18a-51f86d8cc528'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aea9def6-f27d-3d63-b2a0-941867c9b5d8', 3, NULL, 'Part 1: IBM 1401 Processing Unit', 'Part 1: IBM 1401 Processing Unit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '2012-05-15: De Duif, Amsterdam, Netherlands' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea9def6-f27d-3d63-b2a0-941867c9b5d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81ac949a-1edc-4d51-b992-672ee8080db9', 4, NULL, 'Here, They Used to Build Ships', 'Here, They Used to Build Ships', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '2012-05-15: De Duif, Amsterdam, Netherlands' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ac949a-1edc-4d51-b992-672ee8080db9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81688c1c-60b1-4c7a-a3a8-d58592d335bf', 5, NULL, 'They Imagine the City Growing Out Into the Ocean', 'They Imagine the City Growing Out Into the Ocean', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '2012-05-15: De Duif, Amsterdam, Netherlands' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81688c1c-60b1-4c7a-a3a8-d58592d335bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19820 AND linked.composer_id = 206), 'musicbrainz:effa922f-dc55-4686-9c65-dc5dede4fbaf', 6, NULL, 'The Cause of Labour Is the Hope of the World', 'The Cause of Labour Is the Hope of the World', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '2012-05-15: De Duif, Amsterdam, Netherlands' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:effa922f-dc55-4686-9c65-dc5dede4fbaf'
);

UPDATE pieces piece
SET piece.title = '2012-05-15: De Duif, Amsterdam, Netherlands 중 "The Cause of Labour Is the Hope of the World"', piece.title_en = '2012-05-15: De Duif, Amsterdam, Netherlands: The Cause of Labour Is the Hope of the World', piece.editor_locked = 1
WHERE piece.id = 19820 AND piece.composer_id = 206
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3d64525-e903-4a4a-b15b-9448c15c45ef', 7, NULL, 'Odi et amo', 'Odi et amo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 206 AND p.title = '2012-05-15: De Duif, Amsterdam, Netherlands' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3d64525-e903-4a4a-b15b-9448c15c45ef'
);

-- 카탈로그에 대응이 없는 seed 작품 17개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 206 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16153, 16177, 16234, 16277, 16548, 16988, 17755, 18195, 18517, 19143, 19286, 19472, 19528, 19660, 19749, 19911, 20092
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
