-- 필립 글래스 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 359개(묶음 50, 다악장 30, 낱곡 279),
-- 새 작품 36개, part 583개, 그 아래 57개.
-- seed 386개 중 322개를 작품·part 에 잇고, 39개를 숨기고, 25개는 그대로 둔다.
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

-- None "Trilogy" Sonata

UPDATE pieces piece
SET piece.title = '"Trilogy" Sonata', piece.title_en = '"Trilogy" Sonata',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7974 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Act III (from Satyagraha)', part.name_en = '"Trilogy" Sonata: II. Act III (from Satyagraha)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7974 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5e322a17-b567-49bf-bc24-bcab99f28093' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e322a17-b567-49bf-bc24-bcab99f28093', 1, 'II', 'Act III (from Satyagraha)', '"Trilogy" Sonata: II. Act III (from Satyagraha)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7974 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e322a17-b567-49bf-bc24-bcab99f28093'
);


-- None 1+1

UPDATE pieces piece
SET piece.title = '1+1', piece.title_en = '1+1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7840 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 1000 Airplanes on the Roof

UPDATE pieces piece
SET piece.title = '1000 Airplanes on the Roof', piece.title_en = '1000 Airplanes on the Roof',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9185 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1000 Airplanes on the Roof', part.name_en = '1000 Airplanes on the Roof: 1000 Airplanes on the Roof',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:463797ab-5fc5-4292-8ab7-6395c904c8ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:463797ab-5fc5-4292-8ab7-6395c904c8ff', 1, NULL, '1000 Airplanes on the Roof', '1000 Airplanes on the Roof: 1000 Airplanes on the Roof', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:463797ab-5fc5-4292-8ab7-6395c904c8ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'City Walk', part.name_en = '1000 Airplanes on the Roof: City Walk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9553c1e7-bfe6-47e4-bd5f-094158504326' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9553c1e7-bfe6-47e4-bd5f-094158504326', 2, NULL, 'City Walk', '1000 Airplanes on the Roof: City Walk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9553c1e7-bfe6-47e4-bd5f-094158504326'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Girlfriend', part.name_en = '1000 Airplanes on the Roof: Girlfriend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9a98c2eb-2d46-4e90-9a1b-bab4fde62035' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a98c2eb-2d46-4e90-9a1b-bab4fde62035', 3, NULL, 'Girlfriend', '1000 Airplanes on the Roof: Girlfriend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a98c2eb-2d46-4e90-9a1b-bab4fde62035'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'My Building Disappeared', part.name_en = '1000 Airplanes on the Roof: My Building Disappeared',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c17817cd-c4cc-4216-9ef4-d6502ba91290' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c17817cd-c4cc-4216-9ef4-d6502ba91290', 4, NULL, 'My Building Disappeared', '1000 Airplanes on the Roof: My Building Disappeared', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c17817cd-c4cc-4216-9ef4-d6502ba91290'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Screens of Memory', part.name_en = '1000 Airplanes on the Roof: Screens of Memory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6ad393f0-467d-4a94-ba8d-f8acba95e06a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ad393f0-467d-4a94-ba8d-f8acba95e06a', 5, NULL, 'Screens of Memory', '1000 Airplanes on the Roof: Screens of Memory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ad393f0-467d-4a94-ba8d-f8acba95e06a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'What Time is Grey', part.name_en = '1000 Airplanes on the Roof: What Time is Grey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:43f4cce6-a746-4b93-88ab-ab3427dadb8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43f4cce6-a746-4b93-88ab-ab3427dadb8b', 6, NULL, 'What Time is Grey', '1000 Airplanes on the Roof: What Time is Grey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43f4cce6-a746-4b93-88ab-ab3427dadb8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Labyrinth', part.name_en = '1000 Airplanes on the Roof: Labyrinth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:14e3122c-bbc8-4616-afdf-5255de754d6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14e3122c-bbc8-4616-afdf-5255de754d6e', 7, NULL, 'Labyrinth', '1000 Airplanes on the Roof: Labyrinth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14e3122c-bbc8-4616-afdf-5255de754d6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Return to the Hive', part.name_en = '1000 Airplanes on the Roof: Return to the Hive',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:03d790b2-ed6a-4de0-b87e-ed2c7b2167d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03d790b2-ed6a-4de0-b87e-ed2c7b2167d5', 8, NULL, 'Return to the Hive', '1000 Airplanes on the Roof: Return to the Hive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d790b2-ed6a-4de0-b87e-ed2c7b2167d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Three Truths', part.name_en = '1000 Airplanes on the Roof: Three Truths',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:094dcbb3-f297-464e-a6d8-e38e14f266ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:094dcbb3-f297-464e-a6d8-e38e14f266ea', 9, NULL, 'Three Truths', '1000 Airplanes on the Roof: Three Truths', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:094dcbb3-f297-464e-a6d8-e38e14f266ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'The Encounter', part.name_en = '1000 Airplanes on the Roof: The Encounter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9114f24c-aa8a-466d-9fb2-1c7fa64c87c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9114f24c-aa8a-466d-9fb2-1c7fa64c87c4', 10, NULL, 'The Encounter', '1000 Airplanes on the Roof: The Encounter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9114f24c-aa8a-466d-9fb2-1c7fa64c87c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Grey Cloud Over New York', part.name_en = '1000 Airplanes on the Roof: Grey Cloud Over New York',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ca00375c-5d52-46f5-b9f2-f8583d5bd030' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca00375c-5d52-46f5-b9f2-f8583d5bd030', 11, NULL, 'Grey Cloud Over New York', '1000 Airplanes on the Roof: Grey Cloud Over New York', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca00375c-5d52-46f5-b9f2-f8583d5bd030'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Where Have You Been asked the Doctor', part.name_en = '1000 Airplanes on the Roof: Where Have You Been asked the Doctor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5961e20b-8ca4-4789-9ff0-cbbb4895768c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5961e20b-8ca4-4789-9ff0-cbbb4895768c', 12, NULL, 'Where Have You Been asked the Doctor', '1000 Airplanes on the Roof: Where Have You Been asked the Doctor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5961e20b-8ca4-4789-9ff0-cbbb4895768c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'A Normal Man Running', part.name_en = '1000 Airplanes on the Roof: A Normal Man Running',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:dfea27a1-4fb8-4c6e-b50f-7cc3432b99ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfea27a1-4fb8-4c6e-b50f-7cc3432b99ed', 13, NULL, 'A Normal Man Running', '1000 Airplanes on the Roof: A Normal Man Running', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfea27a1-4fb8-4c6e-b50f-7cc3432b99ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Pebbles Dropped Into the Lake', part.name_en = 'Pebbles Dropped Into the Lake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9185 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6d870273-b6f0-460f-a94a-7828e432184b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d870273-b6f0-460f-a94a-7828e432184b', 14, NULL, 'Pebbles Dropped Into the Lake', 'Pebbles Dropped Into the Lake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9185 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d870273-b6f0-460f-a94a-7828e432184b'
);


-- None 5 Weeks

UPDATE pieces piece
SET piece.title = '5 Weeks', piece.title_en = '5 Weeks',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10140 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 600 Lines

UPDATE pieces piece
SET piece.title = '600 Lines', piece.title_en = '600 Lines',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9487 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 67 Cities

UPDATE pieces piece
SET piece.title = '67 Cities', piece.title_en = '67 Cities',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7970 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 7 Months After Launch

UPDATE pieces piece
SET piece.title = '7 Months After Launch', piece.title_en = '7 Months After Launch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7837 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Choice

UPDATE pieces piece
SET piece.title = 'A Choice', piece.title_en = 'A Choice',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9446 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Life Lived Together

UPDATE pieces piece
SET piece.title = 'A Life Lived Together', piece.title_en = 'A Life Lived Together',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7744 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Madrigal Opera

UPDATE pieces piece
SET piece.title = 'A Madrigal Opera', piece.title_en = 'A Madrigal Opera',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8069 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part III', part.name_en = 'A Madrigal Opera: Part III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8069 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f8291275-ba9c-4d86-8332-33d53d1a3f58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8291275-ba9c-4d86-8332-33d53d1a3f58', 1, NULL, 'Part III', 'A Madrigal Opera: Part III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8069 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8291275-ba9c-4d86-8332-33d53d1a3f58'
);


-- None A Musical Portrait of Chuck Close

UPDATE pieces piece
SET piece.title = 'A Musical Portrait of Chuck Close', piece.title_en = 'A Musical Portrait of Chuck Close',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7781 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'A Musical Portrait of Chuck Close: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1c8d3e96-753d-43e7-8b51-3e8fb61a20e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c8d3e96-753d-43e7-8b51-3e8fb61a20e8', 1, NULL, 'I', 'A Musical Portrait of Chuck Close: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c8d3e96-753d-43e7-8b51-3e8fb61a20e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'A Musical Portrait of Chuck Close: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fe7d8ef1-3bd7-4a4f-bc07-44422ced8367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe7d8ef1-3bd7-4a4f-bc07-44422ced8367', 2, NULL, 'II', 'A Musical Portrait of Chuck Close: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe7d8ef1-3bd7-4a4f-bc07-44422ced8367'
);


-- None A New Weapon

UPDATE pieces piece
SET piece.title = 'A New Weapon', piece.title_en = 'A New Weapon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9237 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Secret Solo 2

UPDATE pieces piece
SET piece.title = 'A Secret Solo 2', piece.title_en = 'A Secret Solo 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8438 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Abandoned Factory

UPDATE pieces piece
SET piece.title = 'Abandoned Factory', piece.title_en = 'Abandoned Factory',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11058 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Abandonment

UPDATE pieces piece
SET piece.title = 'Abandonment', piece.title_en = 'Abandonment',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8703 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Across the World

UPDATE pieces piece
SET piece.title = 'Across the World', piece.title_en = 'Across the World',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7897 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Akhnaten>

UPDATE pieces piece
SET piece.title = '오페라 <Akhnaten>', piece.title_en = 'Akhnaten',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8916 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I: Year 1 of Akhnaten’s Reign · Thebes', part.name_en = 'Akhnaten: Act I: Year 1 of Akhnaten’s Reign · Thebes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9', 1, NULL, 'Act I: Year 1 of Akhnaten’s Reign · Thebes', 'Akhnaten: Act I: Year 1 of Akhnaten’s Reign · Thebes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. Prelude', part.name_en = 'Akhnaten: Act I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e46cfdc7-52a3-445e-a134-d3acc8e3bc0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e46cfdc7-52a3-445e-a134-d3acc8e3bc0f', 1, NULL, 'Act I. Prelude', 'Akhnaten: Act I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e46cfdc7-52a3-445e-a134-d3acc8e3bc0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I, Scene I. Funeral of Amenhotep III', part.name_en = 'Akhnaten: Act I, Scene I. Funeral of Amenhotep III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1b55f3bb-9b90-4049-8335-15a040be6c8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1b55f3bb-9b90-4049-8335-15a040be6c8a', 2, NULL, 'Act I, Scene I. Funeral of Amenhotep III', 'Akhnaten: Act I, Scene I. Funeral of Amenhotep III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b55f3bb-9b90-4049-8335-15a040be6c8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I, Scene II. The Coronation of Akhnaten', part.name_en = 'Akhnaten: Act I, Scene II. The Coronation of Akhnaten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:04fc9e5d-126d-4ca8-a72b-78c27dac05db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04fc9e5d-126d-4ca8-a72b-78c27dac05db', 3, NULL, 'Act I, Scene II. The Coronation of Akhnaten', 'Akhnaten: Act I, Scene II. The Coronation of Akhnaten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04fc9e5d-126d-4ca8-a72b-78c27dac05db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I, Scene III. The Window of Appearances', part.name_en = 'Akhnaten: Act I, Scene III. The Window of Appearances',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ca226839-d232-473f-81e8-cfab1109db7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca226839-d232-473f-81e8-cfab1109db7b', 4, NULL, 'Act I, Scene III. The Window of Appearances', 'Akhnaten: Act I, Scene III. The Window of Appearances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fde6ed42-73e0-47cf-8974-9cc7f08c8bd9'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca226839-d232-473f-81e8-cfab1109db7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II: Years 5 to 15 · Thebes and Akhetaten', part.name_en = 'Akhnaten: Act II: Years 5 to 15 · Thebes and Akhetaten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c', 2, NULL, 'Act II: Years 5 to 15 · Thebes and Akhetaten', 'Akhnaten: Act II: Years 5 to 15 · Thebes and Akhetaten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II, Scene I. The Temple', part.name_en = 'Akhnaten: Act II, Scene I. The Temple',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:320bdab5-029e-47f2-88de-969edb70fb21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:320bdab5-029e-47f2-88de-969edb70fb21', 1, NULL, 'Act II, Scene I. The Temple', 'Akhnaten: Act II, Scene I. The Temple', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:320bdab5-029e-47f2-88de-969edb70fb21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II, Scene II. Akhnaten and Nefertiti', part.name_en = 'Akhnaten: Act II, Scene II. Akhnaten and Nefertiti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6287970b-12bc-4483-8935-b309627ed87c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6287970b-12bc-4483-8935-b309627ed87c', 2, NULL, 'Act II, Scene II. Akhnaten and Nefertiti', 'Akhnaten: Act II, Scene II. Akhnaten and Nefertiti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6287970b-12bc-4483-8935-b309627ed87c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II, Scene III. The City', part.name_en = 'Akhnaten: Act II, Scene III. The City',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9cefdf56-dcf5-48b4-bd06-24c692f904cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9cefdf56-dcf5-48b4-bd06-24c692f904cc', 3, NULL, 'Act II, Scene III. The City', 'Akhnaten: Act II, Scene III. The City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cefdf56-dcf5-48b4-bd06-24c692f904cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II, Scene III. Dance', part.name_en = 'Akhnaten: Act II, Scene III. Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:02baee65-7c9e-4561-95ae-3a12ca1b0f9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02baee65-7c9e-4561-95ae-3a12ca1b0f9e', 4, NULL, 'Act II, Scene III. Dance', 'Akhnaten: Act II, Scene III. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02baee65-7c9e-4561-95ae-3a12ca1b0f9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II, Scene IV. Hymn', part.name_en = 'Akhnaten: Act II, Scene IV. Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5ec87633-5705-4bb0-8e6b-b5bf0f582427' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ec87633-5705-4bb0-8e6b-b5bf0f582427', 5, NULL, 'Act II, Scene IV. Hymn', 'Akhnaten: Act II, Scene IV. Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e43d8e3f-74d6-4435-b6a4-cf7e4c87745c'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ec87633-5705-4bb0-8e6b-b5bf0f582427'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III: Year 17 and the Present · Akhetaten', part.name_en = 'Akhnaten: Act III: Year 17 and the Present · Akhetaten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503', 3, NULL, 'Act III: Year 17 and the Present · Akhetaten', 'Akhnaten: Act III: Year 17 and the Present · Akhetaten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III, Scene I. The Family', part.name_en = 'Akhnaten: Act III, Scene I. The Family',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:94892095-60c6-4dff-b3de-ee6bd4b73809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94892095-60c6-4dff-b3de-ee6bd4b73809', 1, NULL, 'Act III, Scene I. The Family', 'Akhnaten: Act III, Scene I. The Family', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94892095-60c6-4dff-b3de-ee6bd4b73809'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III, Scene II. Attack and Fall', part.name_en = 'Akhnaten: Act III, Scene II. Attack and Fall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:44134e4b-01c7-48e1-8d9e-7265b5037b9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:44134e4b-01c7-48e1-8d9e-7265b5037b9a', 2, NULL, 'Act III, Scene II. Attack and Fall', 'Akhnaten: Act III, Scene II. Attack and Fall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44134e4b-01c7-48e1-8d9e-7265b5037b9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III, Scene III. The Ruins', part.name_en = 'Akhnaten: Act III, Scene III. The Ruins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c8d4e835-0c35-4db0-9574-6cd43504e135' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c8d4e835-0c35-4db0-9574-6cd43504e135', 3, NULL, 'Act III, Scene III. The Ruins', 'Akhnaten: Act III, Scene III. The Ruins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8d4e835-0c35-4db0-9574-6cd43504e135'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III, Scene IV. Epilogue', part.name_en = 'Akhnaten: Act III, Scene IV. Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8916 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e26ee5d0-8283-4d74-b87b-4d76e4c0714c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e26ee5d0-8283-4d74-b87b-4d76e4c0714c', 4, NULL, 'Act III, Scene IV. Epilogue', 'Akhnaten: Act III, Scene IV. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12453cb-8cca-4b98-a473-ab5c1173f503'
WHERE p.id = 8916 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e26ee5d0-8283-4d74-b87b-4d76e4c0714c'
);


-- None All Falls Apart

UPDATE pieces piece
SET piece.title = 'All Falls Apart', piece.title_en = 'All Falls Apart',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8995 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None All the Money

UPDATE pieces piece
SET piece.title = 'All the Money', piece.title_en = 'All the Money',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10656 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ange des Orages

UPDATE pieces piece
SET piece.title = 'Ange des Orages', piece.title_en = 'Ange des Orages',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7793 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Angela

UPDATE pieces piece
SET piece.title = 'Angela', piece.title_en = 'Angela',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10429 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Anima Mundi

UPDATE pieces piece
SET piece.title = 'Anima Mundi', piece.title_en = 'Anima Mundi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8645 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Journey', part.name_en = 'Anima Mundi: The Journey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8645 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:2d647a53-87a1-4fc2-9ec5-e21d97e8540e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d647a53-87a1-4fc2-9ec5-e21d97e8540e', 1, NULL, 'The Journey', 'Anima Mundi: The Journey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8645 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d647a53-87a1-4fc2-9ec5-e21d97e8540e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Garden', part.name_en = 'Anima Mundi: The Garden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8645 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:455f461f-8b3d-4267-a41f-183389a1e3c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:455f461f-8b3d-4267-a41f-183389a1e3c8', 2, NULL, 'The Garden', 'Anima Mundi: The Garden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8645 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:455f461f-8b3d-4267-a41f-183389a1e3c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Beginning', part.name_en = 'Anima Mundi: The Beginning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8645 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:55de674f-cbcf-44eb-b52c-ca0394733cbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55de674f-cbcf-44eb-b52c-ca0394733cbc', 3, NULL, 'The Beginning', 'Anima Mundi: The Beginning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8645 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55de674f-cbcf-44eb-b52c-ca0394733cbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Living Waters', part.name_en = 'Anima Mundi: Living Waters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8645 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8573c7aa-5bc3-4abd-a163-343a3368bbab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8573c7aa-5bc3-4abd-a163-343a3368bbab', 4, NULL, 'Living Waters', 'Anima Mundi: Living Waters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8645 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8573c7aa-5bc3-4abd-a163-343a3368bbab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Witness', part.name_en = 'Anima Mundi: The Witness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8645 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8702d9f9-ece2-4b30-a29f-3b8f01aa3810' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8702d9f9-ece2-4b30-a29f-3b8f01aa3810', 5, NULL, 'The Witness', 'Anima Mundi: The Witness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8645 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8702d9f9-ece2-4b30-a29f-3b8f01aa3810'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Perpetual Motion', part.name_en = 'Anima Mundi: Perpetual Motion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8645 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a33c667e-3c31-486b-914a-9603e481aebd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a33c667e-3c31-486b-914a-9603e481aebd', 6, NULL, 'Perpetual Motion', 'Anima Mundi: Perpetual Motion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8645 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a33c667e-3c31-486b-914a-9603e481aebd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Ark', part.name_en = 'Anima Mundi: The Ark',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8645 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c166536a-0a44-4093-9b9a-eeaa281fbd66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c166536a-0a44-4093-9b9a-eeaa281fbd66', 7, NULL, 'The Ark', 'Anima Mundi: The Ark', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8645 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c166536a-0a44-4093-9b9a-eeaa281fbd66'
);


-- None Annie's Theme

UPDATE pieces piece
SET piece.title = 'Annie''s Theme', piece.title_en = 'Annie''s Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9158 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Arabesque in Memoriam

UPDATE pieces piece
SET piece.title = 'Arabesque in Memoriam', piece.title_en = 'Arabesque in Memoriam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8639 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Are Years What? (For Marianne Moore)

UPDATE pieces piece
SET piece.title = 'Are Years What? (For Marianne Moore)', piece.title_en = 'Are Years What? (For Marianne Moore)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10763 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aria From Act III of Satyagraha

UPDATE pieces piece
SET piece.title = 'Aria From Act III of Satyagraha', piece.title_en = 'Aria From Act III of Satyagraha',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10703 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ave

UPDATE pieces piece
SET piece.title = 'Ave', piece.title_en = 'Ave',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8606 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Back to Sad Things

UPDATE pieces piece
SET piece.title = 'Back to Sad Things', piece.title_en = 'Back to Sad Things',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10214 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Backwoods Couple

UPDATE pieces piece
SET piece.title = 'Backwoods Couple', piece.title_en = 'Backwoods Couple',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9379 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bahia

UPDATE pieces piece
SET piece.title = 'Bahia', piece.title_en = 'Bahia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10253 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Barbara’s House

UPDATE pieces piece
SET piece.title = 'Barbara’s House', piece.title_en = 'Barbara’s House',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10632 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Behind the Moon

UPDATE pieces piece
SET piece.title = 'Behind the Moon', piece.title_en = 'Behind the Moon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11024 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Bent>

UPDATE pieces piece
SET piece.title = '영화음악 <Bent>', piece.title_en = 'Bent',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8940 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Epilogue for Solo Violin (From Bent)', part.name_en = 'Epilogue for Solo Violin (From Bent)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8940 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a133829f-7001-4223-9b21-fded25ce5ec3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a133829f-7001-4223-9b21-fded25ce5ec3', 1, NULL, 'Epilogue for Solo Violin (From Bent)', 'Epilogue for Solo Violin (From Bent)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8940 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a133829f-7001-4223-9b21-fded25ce5ec3'
);


-- None Blind Moles

UPDATE pieces piece
SET piece.title = 'Blind Moles', piece.title_en = 'Blind Moles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10224 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Blood on the Stairs

UPDATE pieces piece
SET piece.title = 'Blood on the Stairs', piece.title_en = 'Blood on the Stairs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8427 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Body Count

UPDATE pieces piece
SET piece.title = 'Body Count', piece.title_en = 'Body Count',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10345 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Book of Longing>

UPDATE pieces piece
SET piece.title = '연가곡집 <Book of Longing>', piece.title_en = 'Book of Longing',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7798 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'This Morning I Woke Up Again', part.name_en = 'Book of Longing: This Morning I Woke Up Again',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:02bc09e8-75b6-474b-bebf-7a4bf5d9247e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02bc09e8-75b6-474b-bebf-7a4bf5d9247e', 1, NULL, 'This Morning I Woke Up Again', 'Book of Longing: This Morning I Woke Up Again', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02bc09e8-75b6-474b-bebf-7a4bf5d9247e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Babylon', part.name_en = 'Book of Longing: Babylon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1578828d-76b7-4bd1-a86c-ca4aa6d9d336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1578828d-76b7-4bd1-a86c-ca4aa6d9d336', 2, NULL, 'Babylon', 'Book of Longing: Babylon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1578828d-76b7-4bd1-a86c-ca4aa6d9d336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Not a Jew', part.name_en = 'Book of Longing: Not a Jew',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1e0c4a1d-9987-4f9c-b1a0-d2005b8cc174' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e0c4a1d-9987-4f9c-b1a0-d2005b8cc174', 3, NULL, 'Not a Jew', 'Book of Longing: Not a Jew', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e0c4a1d-9987-4f9c-b1a0-d2005b8cc174'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'You Came to Me This Morning', part.name_en = 'Book of Longing: You Came to Me This Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:22e130e6-8e72-43a4-b0d5-8f67d3186ed9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e130e6-8e72-43a4-b0d5-8f67d3186ed9', 4, NULL, 'You Came to Me This Morning', 'Book of Longing: You Came to Me This Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e130e6-8e72-43a4-b0d5-8f67d3186ed9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Prologue - I Can''t Make the Hills', part.name_en = 'Book of Longing: Prologue - I Can''t Make the Hills',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:26889c52-1135-47a6-a3b6-855d71db8912' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26889c52-1135-47a6-a3b6-855d71db8912', 5, NULL, 'Prologue - I Can''t Make the Hills', 'Book of Longing: Prologue - I Can''t Make the Hills', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26889c52-1135-47a6-a3b6-855d71db8912'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'G-d Opened My Eyes', part.name_en = 'Book of Longing: G-d Opened My Eyes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3cde005d-ba89-4ca0-a901-414409f2af08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cde005d-ba89-4ca0-a901-414409f2af08', 6, NULL, 'G-d Opened My Eyes', 'Book of Longing: G-d Opened My Eyes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cde005d-ba89-4ca0-a901-414409f2af08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'I Was Doing Something', part.name_en = 'Book of Longing: I Was Doing Something',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:49a43ed7-9eb7-4642-9b21-114911bbecda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a43ed7-9eb7-4642-9b21-114911bbecda', 7, NULL, 'I Was Doing Something', 'Book of Longing: I Was Doing Something', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a43ed7-9eb7-4642-9b21-114911bbecda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'How Much I Love You', part.name_en = 'Book of Longing: How Much I Love You',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:79a953aa-9624-47b5-9e5e-82b14bcaee4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79a953aa-9624-47b5-9e5e-82b14bcaee4a', 8, NULL, 'How Much I Love You', 'Book of Longing: How Much I Love You', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79a953aa-9624-47b5-9e5e-82b14bcaee4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Epilogue - Merely a Prayer', part.name_en = 'Book of Longing: Epilogue - Merely a Prayer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7c890d65-726c-40ba-b95f-a483b0c2ec1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c890d65-726c-40ba-b95f-a483b0c2ec1a', 9, NULL, 'Epilogue - Merely a Prayer', 'Book of Longing: Epilogue - Merely a Prayer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c890d65-726c-40ba-b95f-a483b0c2ec1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'I Am Now Able', part.name_en = 'Book of Longing: I Am Now Able',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7e840cae-478b-4e9d-bb00-58b131c88a77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e840cae-478b-4e9d-bb00-58b131c88a77', 10, NULL, 'I Am Now Able', 'Book of Longing: I Am Now Able', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e840cae-478b-4e9d-bb00-58b131c88a77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'I Want to Love You Now', part.name_en = 'Book of Longing: I Want to Love You Now',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7eed5498-3294-4a28-a9aa-c784055d790d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7eed5498-3294-4a28-a9aa-c784055d790d', 11, NULL, 'I Want to Love You Now', 'Book of Longing: I Want to Love You Now', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eed5498-3294-4a28-a9aa-c784055d790d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Want to Fly', part.name_en = 'Book of Longing: Want to Fly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8104eeb9-d37f-4e7d-8951-5147da126179' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8104eeb9-d37f-4e7d-8951-5147da126179', 12, NULL, 'Want to Fly', 'Book of Longing: Want to Fly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8104eeb9-d37f-4e7d-8951-5147da126179'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Don''t Have the Proof', part.name_en = 'Book of Longing: Don''t Have the Proof',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:818ef2af-d03a-4ed6-b274-6e32ff1a24c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:818ef2af-d03a-4ed6-b274-6e32ff1a24c3', 13, NULL, 'Don''t Have the Proof', 'Book of Longing: Don''t Have the Proof', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:818ef2af-d03a-4ed6-b274-6e32ff1a24c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Puppet Time', part.name_en = 'Book of Longing: Puppet Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8d998b42-b9ab-4ed8-be0b-33e653b1468f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d998b42-b9ab-4ed8-be0b-33e653b1468f', 14, NULL, 'Puppet Time', 'Book of Longing: Puppet Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d998b42-b9ab-4ed8-be0b-33e653b1468f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Mother Mother', part.name_en = 'Book of Longing: Mother Mother',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9ef98593-ae45-448e-b44a-797952072fb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ef98593-ae45-448e-b44a-797952072fb4', 15, NULL, 'Mother Mother', 'Book of Longing: Mother Mother', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ef98593-ae45-448e-b44a-797952072fb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'You Go Your Way', part.name_en = 'Book of Longing: You Go Your Way',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b5a6ae71-1031-4fa5-9f6e-313a7f4bf4c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5a6ae71-1031-4fa5-9f6e-313a7f4bf4c6', 16, NULL, 'You Go Your Way', 'Book of Longing: You Go Your Way', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5a6ae71-1031-4fa5-9f6e-313a7f4bf4c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'A Sip of Wine', part.name_en = 'Book of Longing: A Sip of Wine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:cf9044e3-2a36-4f35-8728-b78e566d6030' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf9044e3-2a36-4f35-8728-b78e566d6030', 17, NULL, 'A Sip of Wine', 'Book of Longing: A Sip of Wine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf9044e3-2a36-4f35-8728-b78e566d6030'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'The Light Came Through the Window', part.name_en = 'Book of Longing: The Light Came Through the Window',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:db49ebf9-86d1-4749-b0da-52ffd811a59f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db49ebf9-86d1-4749-b0da-52ffd811a59f', 18, NULL, 'The Light Came Through the Window', 'Book of Longing: The Light Came Through the Window', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db49ebf9-86d1-4749-b0da-52ffd811a59f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'I Came Down From the Mountains', part.name_en = 'Book of Longing: I Came Down From the Mountains',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e6bb5b80-256a-4df9-8513-f9bf84039ec8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6bb5b80-256a-4df9-8513-f9bf84039ec8', 19, NULL, 'I Came Down From the Mountains', 'Book of Longing: I Came Down From the Mountains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6bb5b80-256a-4df9-8513-f9bf84039ec8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'I Enjoyed the Laughter', part.name_en = 'Book of Longing: I Enjoyed the Laughter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e8241100-a083-48a7-9915-5f229f706ef0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8241100-a083-48a7-9915-5f229f706ef0', 20, NULL, 'I Enjoyed the Laughter', 'Book of Longing: I Enjoyed the Laughter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8241100-a083-48a7-9915-5f229f706ef0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Roshi''s Very Tired', part.name_en = 'Book of Longing: Roshi''s Very Tired',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f8c0195a-a73a-4afb-8666-c61cc19fbfc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8c0195a-a73a-4afb-8666-c61cc19fbfc9', 21, NULL, 'Roshi''s Very Tired', 'Book of Longing: Roshi''s Very Tired', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8c0195a-a73a-4afb-8666-c61cc19fbfc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'The Night of Santiago', part.name_en = 'Book of Longing: The Night of Santiago',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7798 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ff032a44-eaae-4bc2-9953-7416cd7b2b78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff032a44-eaae-4bc2-9953-7416cd7b2b78', 22, NULL, 'The Night of Santiago', 'Book of Longing: The Night of Santiago', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7798 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff032a44-eaae-4bc2-9953-7416cd7b2b78'
);


-- None Brass Sextet

UPDATE pieces piece
SET piece.title = 'Brass Sextet', piece.title_en = 'Brass Sextet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10424 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Hymn', part.name_en = 'Brass Sextet: I. Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10424 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:25756ce2-edb0-4f1f-a1d1-6fce8990690c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25756ce2-edb0-4f1f-a1d1-6fce8990690c', 1, 'I', 'Hymn', 'Brass Sextet: I. Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10424 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25756ce2-edb0-4f1f-a1d1-6fce8990690c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ballad', part.name_en = 'Brass Sextet: II. Ballad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10424 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:497f4395-119f-41bf-b575-865f8ab10787' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:497f4395-119f-41bf-b575-865f8ab10787', 2, 'II', 'Ballad', 'Brass Sextet: II. Ballad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10424 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:497f4395-119f-41bf-b575-865f8ab10787'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Finale', part.name_en = 'Brass Sextet: III. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10424 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3af73500-200c-4265-899a-241f0ccacc03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3af73500-200c-4265-899a-241f0ccacc03', 3, 'III', 'Finale', 'Brass Sextet: III. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10424 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af73500-200c-4265-899a-241f0ccacc03'
);


-- None Buying the Boat

UPDATE pieces piece
SET piece.title = 'Buying the Boat', piece.title_en = 'Buying the Boat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10133 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cabrini Green

UPDATE pieces piece
SET piece.title = 'Cabrini Green', piece.title_en = 'Cabrini Green',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8907 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Candyman: It Was Always You, Helen

UPDATE pieces piece
SET piece.title = 'Candyman: It Was Always You, Helen', piece.title_en = 'Candyman: It Was Always You, Helen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10279 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Car Ride

UPDATE pieces piece
SET piece.title = 'Car Ride', piece.title_en = 'Car Ride',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11284 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cassandra’s Dream

UPDATE pieces piece
SET piece.title = 'Cassandra’s Dream', piece.title_en = 'Cassandra’s Dream',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9087 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cassandra’s Dream Finale

UPDATE pieces piece
SET piece.title = 'Cassandra’s Dream Finale', piece.title_en = 'Cassandra’s Dream Finale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9938 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chris and the Model Airplane

UPDATE pieces piece
SET piece.title = 'Chris and the Model Airplane', piece.title_en = 'Chris and the Model Airplane',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9424 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Closing

UPDATE pieces piece
SET piece.title = 'Closing', piece.title_en = 'Closing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10257 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Coleman’s Consequences

UPDATE pieces piece
SET piece.title = 'Coleman’s Consequences', piece.title_en = 'Coleman’s Consequences',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8690 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Coleman’s Dilemma

UPDATE pieces piece
SET piece.title = 'Coleman’s Dilemma', piece.title_en = 'Coleman’s Dilemma',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10423 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Coleman’s Theme

UPDATE pieces piece
SET piece.title = 'Coleman’s Theme', piece.title_en = 'Coleman’s Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7804 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Company

UPDATE pieces piece
SET piece.title = 'Company', piece.title_en = 'Company',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8064 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Company: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8064 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:755d4e71-9a53-434c-be1e-1e4d3cdfc9fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:755d4e71-9a53-434c-be1e-1e4d3cdfc9fa', 1, NULL, 'I', 'Company: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8064 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:755d4e71-9a53-434c-be1e-1e4d3cdfc9fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Company: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8064 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e38202d2-d126-4687-9062-ec95de8829a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e38202d2-d126-4687-9062-ec95de8829a0', 2, NULL, 'II', 'Company: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8064 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e38202d2-d126-4687-9062-ec95de8829a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Company: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8064 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:78081c0e-cdf6-48be-abcb-fbd3bccc07b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78081c0e-cdf6-48be-abcb-fbd3bccc07b6', 3, NULL, 'III', 'Company: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8064 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78081c0e-cdf6-48be-abcb-fbd3bccc07b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Company: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8064 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0497e2eb-7ae3-440e-a1a0-42c74fbd081c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0497e2eb-7ae3-440e-a1a0-42c74fbd081c', 4, NULL, 'IV', 'Company: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8064 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0497e2eb-7ae3-440e-a1a0-42c74fbd081c'
);


-- None 가곡 <Compassion in Exile>

UPDATE pieces piece
SET piece.title = '가곡 <Compassion in Exile>', piece.title_en = 'Compassion in Exile',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9490 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concert Overture (Overture for 2012)

UPDATE pieces piece
SET piece.title = 'Concert Overture (Overture for 2012)', piece.title_en = 'Concert Overture (Overture for 2012)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8812 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 첼로 협주곡 1번

UPDATE pieces piece
SET piece.title = '첼로 협주곡 1번', piece.title_en = 'Concerto for Cello and Orchestra no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7815 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Concerto for Cello and Orchestra no. 1: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7815 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bb6a0cd8-3c4c-4b35-afe4-2fb05a52fd90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb6a0cd8-3c4c-4b35-afe4-2fb05a52fd90', 1, NULL, 'I', 'Concerto for Cello and Orchestra no. 1: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7815 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb6a0cd8-3c4c-4b35-afe4-2fb05a52fd90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Concerto for Cello and Orchestra no. 1: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7815 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f5a13518-1db5-4620-941f-7faed080bc12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5a13518-1db5-4620-941f-7faed080bc12', 2, NULL, 'II', 'Concerto for Cello and Orchestra no. 1: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7815 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5a13518-1db5-4620-941f-7faed080bc12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Concerto for Cello and Orchestra no. 1: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7815 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:448a7944-9ba8-45db-bc47-81177ef16fde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:448a7944-9ba8-45db-bc47-81177ef16fde', 3, NULL, 'III', 'Concerto for Cello and Orchestra no. 1: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7815 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:448a7944-9ba8-45db-bc47-81177ef16fde'
);


-- None Concerto for Harpsichord and Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Harpsichord and Chamber Orchestra', piece.title_en = 'Concerto for Harpsichord and Chamber Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10323 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Concerto for Harpsichord and Chamber Orchestra: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10323 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1454a3f1-fb56-4f0d-99ee-2308b2f14588' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1454a3f1-fb56-4f0d-99ee-2308b2f14588', 1, NULL, 'I', 'Concerto for Harpsichord and Chamber Orchestra: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10323 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1454a3f1-fb56-4f0d-99ee-2308b2f14588'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Concerto for Harpsichord and Chamber Orchestra: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10323 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3e89d4ba-eb04-4e01-bbee-0bece9b31ba6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e89d4ba-eb04-4e01-bbee-0bece9b31ba6', 2, NULL, 'II', 'Concerto for Harpsichord and Chamber Orchestra: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10323 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e89d4ba-eb04-4e01-bbee-0bece9b31ba6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Concerto for Harpsichord and Chamber Orchestra: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10323 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:08dfba67-bdab-46c8-94b8-d7d4c6c19da1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08dfba67-bdab-46c8-94b8-d7d4c6c19da1', 3, NULL, 'III', 'Concerto for Harpsichord and Chamber Orchestra: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10323 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08dfba67-bdab-46c8-94b8-d7d4c6c19da1'
);


-- None Concerto for Two Pianos

UPDATE pieces piece
SET piece.title = 'Concerto for Two Pianos', piece.title_en = 'Concerto for Two Pianos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9131 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Connected Politically

UPDATE pieces piece
SET piece.title = 'Connected Politically', piece.title_en = 'Connected Politically',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10457 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Courage

UPDATE pieces piece
SET piece.title = 'Courage', piece.title_en = 'Courage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10670 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Damned If I Don’t

UPDATE pieces piece
SET piece.title = 'Damned If I Don’t', piece.title_en = 'Damned If I Don’t',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10844 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dance Nos. 1-5

UPDATE pieces piece
SET piece.title = 'Dance Nos. 1-5', piece.title_en = 'Dance Nos. 1-5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9667 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dance No. 1', part.name_en = 'Dance No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9667 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:52641649-fcdb-4c56-ba88-9d3092b0f84f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52641649-fcdb-4c56-ba88-9d3092b0f84f', 1, NULL, 'Dance No. 1', 'Dance No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9667 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52641649-fcdb-4c56-ba88-9d3092b0f84f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dance No. 2', part.name_en = 'Dance No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9667 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6f95e106-9d96-4332-9628-46aae5d83da1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f95e106-9d96-4332-9628-46aae5d83da1', 2, NULL, 'Dance No. 2', 'Dance No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9667 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f95e106-9d96-4332-9628-46aae5d83da1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dance No. 3', part.name_en = 'Dance No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9667 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3b97b072-fac1-457a-9290-2273e6bd4dc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b97b072-fac1-457a-9290-2273e6bd4dc4', 3, NULL, 'Dance No. 3', 'Dance No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9667 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b97b072-fac1-457a-9290-2273e6bd4dc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dance No. 4', part.name_en = 'Dance No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9667 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:103132c0-add5-44ed-bb22-4278c059f74d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:103132c0-add5-44ed-bb22-4278c059f74d', 4, NULL, 'Dance No. 4', 'Dance No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9667 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:103132c0-add5-44ed-bb22-4278c059f74d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dance No. 5', part.name_en = 'Dance No. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9667 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:47927afb-3a8e-4199-9c5e-d7ded591f171' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47927afb-3a8e-4199-9c5e-d7ded591f171', 5, NULL, 'Dance No. 5', 'Dance No. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9667 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47927afb-3a8e-4199-9c5e-d7ded591f171'
);


-- None Daniel's Flashback

UPDATE pieces piece
SET piece.title = 'Daniel''s Flashback', piece.title_en = 'Daniel''s Flashback',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10877 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Data

UPDATE pieces piece
SET piece.title = 'Data', piece.title_en = 'Data',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9675 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Days and Nights in Rocinha

UPDATE pieces piece
SET piece.title = 'Days and Nights in Rocinha', piece.title_en = 'Days and Nights in Rocinha',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7680 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Death of the Twins / Finale

UPDATE pieces piece
SET piece.title = 'Death of the Twins / Finale', piece.title_en = 'Death of the Twins / Finale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10199 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Death on the Boat

UPDATE pieces piece
SET piece.title = 'Death on the Boat', piece.title_en = 'Death on the Boat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7975 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deel’s Song

UPDATE pieces piece
SET piece.title = 'Deel’s Song', piece.title_en = 'Deel’s Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8124 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Des gazelles aux kangourous

UPDATE pieces piece
SET piece.title = 'Des gazelles aux kangourous', piece.title_en = 'Des gazelles aux kangourous',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11167 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Des insectes aux baleines

UPDATE pieces piece
SET piece.title = 'Des insectes aux baleines', piece.title_en = 'Des insectes aux baleines',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9684 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Disappearance

UPDATE pieces piece
SET piece.title = 'Disappearance', piece.title_en = 'Disappearance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11170 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Distant Figure (Passacaglia for Solo Piano)

UPDATE pieces piece
SET piece.title = 'Distant Figure (Passacaglia for Solo Piano)', piece.title_en = 'Distant Figure (Passacaglia for Solo Piano)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8035 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dominoes

UPDATE pieces piece
SET piece.title = 'Dominoes', piece.title_en = 'Dominoes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9623 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Double Concerto for Violin, Cello & Orchestra

UPDATE pieces piece
SET piece.title = 'Double Concerto for Violin, Cello & Orchestra', piece.title_en = 'Double Concerto for Violin, Cello & Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8261 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Duet no. 1', part.name_en = 'Double Concerto for Violin, Cello & Orchestra: Duet no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8261 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a361e45c-c4d6-44c5-a7ef-73e379dcb92e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a361e45c-c4d6-44c5-a7ef-73e379dcb92e', 1, NULL, 'Duet no. 1', 'Double Concerto for Violin, Cello & Orchestra: Duet no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8261 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a361e45c-c4d6-44c5-a7ef-73e379dcb92e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part 1', part.name_en = 'Double Concerto for Violin, Cello & Orchestra: Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8261 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c748c295-18f4-42a1-a0e5-6841cec1ac97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c748c295-18f4-42a1-a0e5-6841cec1ac97', 2, NULL, 'Part 1', 'Double Concerto for Violin, Cello & Orchestra: Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8261 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c748c295-18f4-42a1-a0e5-6841cec1ac97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Duet no. 2', part.name_en = 'Double Concerto for Violin, Cello & Orchestra: Duet no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8261 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4264fd41-99f3-49d9-97ee-163c1f6b088f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4264fd41-99f3-49d9-97ee-163c1f6b088f', 3, NULL, 'Duet no. 2', 'Double Concerto for Violin, Cello & Orchestra: Duet no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8261 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4264fd41-99f3-49d9-97ee-163c1f6b088f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part 2', part.name_en = 'Double Concerto for Violin, Cello & Orchestra: Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8261 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a9af13fa-b8d6-49a4-b839-dcffe2add6e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9af13fa-b8d6-49a4-b839-dcffe2add6e6', 4, NULL, 'Part 2', 'Double Concerto for Violin, Cello & Orchestra: Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8261 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9af13fa-b8d6-49a4-b839-dcffe2add6e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Duet no. 3', part.name_en = 'Double Concerto for Violin, Cello & Orchestra: Duet no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8261 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ca975423-7197-4e00-88a9-34ea3709188c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca975423-7197-4e00-88a9-34ea3709188c', 5, NULL, 'Duet no. 3', 'Double Concerto for Violin, Cello & Orchestra: Duet no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8261 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca975423-7197-4e00-88a9-34ea3709188c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Part 3', part.name_en = 'Double Concerto for Violin, Cello & Orchestra: Part 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8261 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:565c0b2b-f201-48ac-98f9-98e00a12a7cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:565c0b2b-f201-48ac-98f9-98e00a12a7cc', 6, NULL, 'Part 3', 'Double Concerto for Violin, Cello & Orchestra: Part 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8261 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:565c0b2b-f201-48ac-98f9-98e00a12a7cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Duet no. 4', part.name_en = 'Double Concerto for Violin, Cello & Orchestra: Duet no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8261 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:548acbff-db4a-4e55-845d-7434870971e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:548acbff-db4a-4e55-845d-7434870971e1', 7, NULL, 'Duet no. 4', 'Double Concerto for Violin, Cello & Orchestra: Duet no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8261 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:548acbff-db4a-4e55-845d-7434870971e1'
);


-- None 영화음악 <Dracula>

UPDATE pieces piece
SET piece.title = '영화음악 <Dracula>', piece.title_en = 'Dracula',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8152 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Seward Sanatorium', part.name_en = 'Seward Sanatorium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:058e362b-4f3e-48f4-b27b-8a3e44aa9d70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:058e362b-4f3e-48f4-b27b-8a3e44aa9d70', 1, NULL, 'Seward Sanatorium', 'Seward Sanatorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:058e362b-4f3e-48f4-b27b-8a3e44aa9d70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mina''s Bedroom / The Abbey', part.name_en = 'Mina''s Bedroom / The Abbey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:096affe9-598d-440f-9d8e-300df634d41e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:096affe9-598d-440f-9d8e-300df634d41e', 2, NULL, 'Mina''s Bedroom / The Abbey', 'Mina''s Bedroom / The Abbey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:096affe9-598d-440f-9d8e-300df634d41e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Castle', part.name_en = 'The Castle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:09ed5bd1-9744-4be4-8003-1dbc0b4cd553' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09ed5bd1-9744-4be4-8003-1dbc0b4cd553', 3, NULL, 'The Castle', 'The Castle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09ed5bd1-9744-4be4-8003-1dbc0b4cd553'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Renfield', part.name_en = 'Renfield',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0e29810b-7218-4d45-8cf0-82dfb95d58dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e29810b-7218-4d45-8cf0-82dfb95d58dd', 4, NULL, 'Renfield', 'Renfield', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e29810b-7218-4d45-8cf0-82dfb95d58dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dracula', part.name_en = 'Dracula: Dracula',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:184a2892-c2a0-4738-8cdd-88b32388c7f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:184a2892-c2a0-4738-8cdd-88b32388c7f3', 5, NULL, 'Dracula', 'Dracula: Dracula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:184a2892-c2a0-4738-8cdd-88b32388c7f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'London Fog', part.name_en = 'London Fog',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1cba74e6-76f4-47c5-8c08-d194f4956503' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cba74e6-76f4-47c5-8c08-d194f4956503', 6, NULL, 'London Fog', 'London Fog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cba74e6-76f4-47c5-8c08-d194f4956503'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Dracula Enters', part.name_en = 'Dracula Enters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:22b4d3e3-f7d3-41ec-88b1-9181c86b9a7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22b4d3e3-f7d3-41ec-88b1-9181c86b9a7f', 7, NULL, 'Dracula Enters', 'Dracula Enters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22b4d3e3-f7d3-41ec-88b1-9181c86b9a7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Three Consorts of Dracula', part.name_en = 'The Three Consorts of Dracula',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:29e4ffeb-9148-4dcf-ad2c-5b63dad92c3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29e4ffeb-9148-4dcf-ad2c-5b63dad92c3e', 8, NULL, 'The Three Consorts of Dracula', 'The Three Consorts of Dracula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29e4ffeb-9148-4dcf-ad2c-5b63dad92c3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Horrible Tragedy', part.name_en = 'Horrible Tragedy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3887d993-ebb2-465b-91d6-11c03c0b43f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3887d993-ebb2-465b-91d6-11c03c0b43f8', 9, NULL, 'Horrible Tragedy', 'Horrible Tragedy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3887d993-ebb2-465b-91d6-11c03c0b43f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'When the Dream Comes', part.name_en = 'When the Dream Comes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:445239ff-106d-4881-af9a-f955730bf147' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:445239ff-106d-4881-af9a-f955730bf147', 10, NULL, 'When the Dream Comes', 'When the Dream Comes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:445239ff-106d-4881-af9a-f955730bf147'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Inn', part.name_en = 'The Inn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:473cf10e-e3ac-417b-8d83-554e0a4cd7d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:473cf10e-e3ac-417b-8d83-554e0a4cd7d7', 11, NULL, 'The Inn', 'The Inn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:473cf10e-e3ac-417b-8d83-554e0a4cd7d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Renfield in the Drawing Room', part.name_en = 'Renfield in the Drawing Room',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5144e6b6-ffa4-4ef5-91d5-3a02581ef41e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5144e6b6-ffa4-4ef5-91d5-3a02581ef41e', 12, NULL, 'Renfield in the Drawing Room', 'Renfield in the Drawing Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5144e6b6-ffa4-4ef5-91d5-3a02581ef41e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The Crypt', part.name_en = 'The Crypt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:550b17da-f5af-44a2-beb5-9f96e382cb21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:550b17da-f5af-44a2-beb5-9f96e382cb21', 13, NULL, 'The Crypt', 'The Crypt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:550b17da-f5af-44a2-beb5-9f96e382cb21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Storm', part.name_en = 'The Storm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:766ccf81-4237-4f8b-90fa-4e405094838d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:766ccf81-4237-4f8b-90fa-4e405094838d', 14, NULL, 'The Storm', 'The Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:766ccf81-4237-4f8b-90fa-4e405094838d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'The End of Dracula', part.name_en = 'The End of Dracula',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:775ce417-be99-4e9c-891b-ddfc2ca3f9f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:775ce417-be99-4e9c-891b-ddfc2ca3f9f8', 15, NULL, 'The End of Dracula', 'The End of Dracula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:775ce417-be99-4e9c-891b-ddfc2ca3f9f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Excellent, Mr. Renfield', part.name_en = 'Excellent, Mr. Renfield',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:78e89dcb-8663-49ee-9431-88575dc1e708' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e89dcb-8663-49ee-9431-88575dc1e708', 16, NULL, 'Excellent, Mr. Renfield', 'Excellent, Mr. Renfield', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e89dcb-8663-49ee-9431-88575dc1e708'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Women in White', part.name_en = 'Women in White',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7ded0830-fe28-4264-a8dc-405fc15266a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ded0830-fe28-4264-a8dc-405fc15266a5', 17, NULL, 'Women in White', 'Women in White', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ded0830-fe28-4264-a8dc-405fc15266a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Dr. Van Helsing and Dracula', part.name_en = 'Dr. Van Helsing and Dracula',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:83e1d316-4e0e-4665-98b4-447e139d55c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83e1d316-4e0e-4665-98b4-447e139d55c3', 18, NULL, 'Dr. Van Helsing and Dracula', 'Dr. Van Helsing and Dracula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e1d316-4e0e-4665-98b4-447e139d55c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'The Drawing Room', part.name_en = 'The Drawing Room',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8cd172ad-f2a1-4eba-a2d1-0b730ee0c622' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cd172ad-f2a1-4eba-a2d1-0b730ee0c622', 19, NULL, 'The Drawing Room', 'The Drawing Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cd172ad-f2a1-4eba-a2d1-0b730ee0c622'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Lucy''s Bitten', part.name_en = 'Lucy''s Bitten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a688f3ea-cb27-4ce9-a94f-1296ef283119' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a688f3ea-cb27-4ce9-a94f-1296ef283119', 20, NULL, 'Lucy''s Bitten', 'Lucy''s Bitten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a688f3ea-cb27-4ce9-a94f-1296ef283119'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Carriage Without a Driver', part.name_en = 'Carriage Without a Driver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c3a39c7d-0d7c-4545-ab15-edcda00ccb34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3a39c7d-0d7c-4545-ab15-edcda00ccb34', 21, NULL, 'Carriage Without a Driver', 'Carriage Without a Driver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3a39c7d-0d7c-4545-ab15-edcda00ccb34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Journey to the Inn', part.name_en = 'Journey to the Inn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:eac37dbe-6bc7-467f-8db2-aaa6d8a4a908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eac37dbe-6bc7-467f-8db2-aaa6d8a4a908', 22, NULL, 'Journey to the Inn', 'Journey to the Inn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac37dbe-6bc7-467f-8db2-aaa6d8a4a908'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Or a Wolf', part.name_en = 'Or a Wolf',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ef03c50f-fe7b-4e97-a5aa-216ab982ef76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef03c50f-fe7b-4e97-a5aa-216ab982ef76', 23, NULL, 'Or a Wolf', 'Or a Wolf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef03c50f-fe7b-4e97-a5aa-216ab982ef76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'In the Theatre', part.name_en = 'In the Theatre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f1787a7e-7432-4217-a37b-116c8aec74b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1787a7e-7432-4217-a37b-116c8aec74b1', 24, NULL, 'In the Theatre', 'In the Theatre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1787a7e-7432-4217-a37b-116c8aec74b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'In His Cell', part.name_en = 'In His Cell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f289ccab-1bd4-46d4-a6ff-ffef2d85ba7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f289ccab-1bd4-46d4-a6ff-ffef2d85ba7b', 25, NULL, 'In His Cell', 'In His Cell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f289ccab-1bd4-46d4-a6ff-ffef2d85ba7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Mina on the Terrace', part.name_en = 'Mina on the Terrace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8152 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fc76d4d2-2b05-475e-a43a-75f807c0dd4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc76d4d2-2b05-475e-a43a-75f807c0dd4d', 26, NULL, 'Mina on the Terrace', 'Mina on the Terrace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8152 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc76d4d2-2b05-475e-a43a-75f807c0dd4d'
);


-- None Dreaming Awake

UPDATE pieces piece
SET piece.title = 'Dreaming Awake', piece.title_en = 'Dreaming Awake',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10053 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Echorus

UPDATE pieces piece
SET piece.title = 'Echorus', piece.title_en = 'Echorus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10079 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Einstein on the Beach>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Knee Play 1', part.name_en = 'Einstein on the Beach: Knee Play 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:17e9a0e6-3ab6-4110-8933-b7f0061b35f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17e9a0e6-3ab6-4110-8933-b7f0061b35f8', 1, NULL, 'Knee Play 1', 'Einstein on the Beach: Knee Play 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17e9a0e6-3ab6-4110-8933-b7f0061b35f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act Two', part.name_en = 'Einstein on the Beach: Act Two',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:429f5022-af03-4ad9-8cf5-b1ffe0b95e41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:429f5022-af03-4ad9-8cf5-b1ffe0b95e41', 2, NULL, 'Act Two', 'Einstein on the Beach: Act Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:429f5022-af03-4ad9-8cf5-b1ffe0b95e41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:429f5022-af03-4ad9-8cf5-b1ffe0b95e41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1: Dance 1 (Field With Spaceship)', part.name_en = 'Einstein on the Beach: Act Two: Scene 1: Dance 1 (Field With Spaceship)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8ec8cdce-0749-472e-be31-a67ee09c2a5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ec8cdce-0749-472e-be31-a67ee09c2a5c', 1, NULL, 'Scene 1: Dance 1 (Field With Spaceship)', 'Einstein on the Beach: Act Two: Scene 1: Dance 1 (Field With Spaceship)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:429f5022-af03-4ad9-8cf5-b1ffe0b95e41'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ec8cdce-0749-472e-be31-a67ee09c2a5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:429f5022-af03-4ad9-8cf5-b1ffe0b95e41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 2: Night Train', part.name_en = 'Einstein on the Beach: Act Two: Scene 2: Night Train',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1a68b362-f56f-43fd-a85d-1b13836c00fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a68b362-f56f-43fd-a85d-1b13836c00fb', 2, NULL, 'Scene 2: Night Train', 'Einstein on the Beach: Act Two: Scene 2: Night Train', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:429f5022-af03-4ad9-8cf5-b1ffe0b95e41'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a68b362-f56f-43fd-a85d-1b13836c00fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Knee Play 3', part.name_en = 'Einstein on the Beach: Knee Play 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8b22d4fe-2ab0-43c3-9ea0-d8f0e0e5e6a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b22d4fe-2ab0-43c3-9ea0-d8f0e0e5e6a1', 3, NULL, 'Knee Play 3', 'Einstein on the Beach: Knee Play 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b22d4fe-2ab0-43c3-9ea0-d8f0e0e5e6a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Knee Play 5', part.name_en = 'Einstein on the Beach: Knee Play 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:93bbcb18-7554-4e4c-af60-631fd35d2870' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93bbcb18-7554-4e4c-af60-631fd35d2870', 4, NULL, 'Knee Play 5', 'Einstein on the Beach: Knee Play 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93bbcb18-7554-4e4c-af60-631fd35d2870'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Knee Play 4', part.name_en = 'Einstein on the Beach: Knee Play 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:941c63af-34e9-40e3-b62c-d12570baceee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:941c63af-34e9-40e3-b62c-d12570baceee', 5, NULL, 'Knee Play 4', 'Einstein on the Beach: Knee Play 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:941c63af-34e9-40e3-b62c-d12570baceee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act Three', part.name_en = 'Einstein on the Beach: Act Three',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ad2f48dc-68ad-440e-a2f0-b1e2359d16ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad2f48dc-68ad-440e-a2f0-b1e2359d16ab', 6, NULL, 'Act Three', 'Einstein on the Beach: Act Three', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad2f48dc-68ad-440e-a2f0-b1e2359d16ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad2f48dc-68ad-440e-a2f0-b1e2359d16ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1: Trial/Prison', part.name_en = 'Einstein on the Beach: Act Three: Scene 1: Trial/Prison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e527fd04-916f-4cd3-975b-39d250cd22f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e527fd04-916f-4cd3-975b-39d250cd22f3', 1, NULL, 'Scene 1: Trial/Prison', 'Einstein on the Beach: Act Three: Scene 1: Trial/Prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad2f48dc-68ad-440e-a2f0-b1e2359d16ab'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e527fd04-916f-4cd3-975b-39d250cd22f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad2f48dc-68ad-440e-a2f0-b1e2359d16ab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 2: Dance 2: (Field With Spaceship)', part.name_en = 'Einstein on the Beach: Act Three: Scene 2: Dance 2: (Field With Spaceship)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:75a61e41-1253-4c3b-a302-967ded99e339' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75a61e41-1253-4c3b-a302-967ded99e339', 2, NULL, 'Scene 2: Dance 2: (Field With Spaceship)', 'Einstein on the Beach: Act Three: Scene 2: Dance 2: (Field With Spaceship)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad2f48dc-68ad-440e-a2f0-b1e2359d16ab'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75a61e41-1253-4c3b-a302-967ded99e339'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act Four', part.name_en = 'Einstein on the Beach: Act Four',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e', 7, NULL, 'Act Four', 'Einstein on the Beach: Act Four', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1: Building', part.name_en = 'Einstein on the Beach: Act Four: Scene 1: Building',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:42bd6169-75fc-4725-9fd0-daaab419e7e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42bd6169-75fc-4725-9fd0-daaab419e7e7', 1, NULL, 'Scene 1: Building', 'Einstein on the Beach: Act Four: Scene 1: Building', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42bd6169-75fc-4725-9fd0-daaab419e7e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 2: Bed', part.name_en = 'Einstein on the Beach: Act Four: Scene 2: Bed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6307cb4f-b375-4c9d-a66d-34573071faa4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6307cb4f-b375-4c9d-a66d-34573071faa4', 2, NULL, 'Scene 2: Bed', 'Einstein on the Beach: Act Four: Scene 2: Bed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6307cb4f-b375-4c9d-a66d-34573071faa4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 3: Spaceship', part.name_en = 'Einstein on the Beach: Act Four: Scene 3: Spaceship',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:80ef6c75-9699-4e85-a4c7-11b015b3cc81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80ef6c75-9699-4e85-a4c7-11b015b3cc81', 3, NULL, 'Scene 3: Spaceship', 'Einstein on the Beach: Act Four: Scene 3: Spaceship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6706f35-bc07-4267-b7de-da239532595e'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80ef6c75-9699-4e85-a4c7-11b015b3cc81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act One', part.name_en = 'Einstein on the Beach: Act One',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:db42a71c-233f-4a3e-916d-93a63302f1d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db42a71c-233f-4a3e-916d-93a63302f1d6', 8, NULL, 'Act One', 'Einstein on the Beach: Act One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db42a71c-233f-4a3e-916d-93a63302f1d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db42a71c-233f-4a3e-916d-93a63302f1d6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 1: Train', part.name_en = 'Einstein on the Beach: Act One: Scene 1: Train',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:45e660fb-1ffe-4038-8bd4-84efcb908581' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45e660fb-1ffe-4038-8bd4-84efcb908581', 1, NULL, 'Scene 1: Train', 'Einstein on the Beach: Act One: Scene 1: Train', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db42a71c-233f-4a3e-916d-93a63302f1d6'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45e660fb-1ffe-4038-8bd4-84efcb908581'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db42a71c-233f-4a3e-916d-93a63302f1d6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 2: Trial', part.name_en = 'Einstein on the Beach: Act One: Scene 2: Trial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:36f282fe-6b13-4dde-a050-2e69270d38fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36f282fe-6b13-4dde-a050-2e69270d38fe', 2, NULL, 'Scene 2: Trial', 'Einstein on the Beach: Act One: Scene 2: Trial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db42a71c-233f-4a3e-916d-93a63302f1d6'
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36f282fe-6b13-4dde-a050-2e69270d38fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Knee Play 2', part.name_en = 'Einstein on the Beach: Knee Play 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 353 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:dba66054-5878-4473-b04a-8b98a5adbf1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dba66054-5878-4473-b04a-8b98a5adbf1b', 9, NULL, 'Knee Play 2', 'Einstein on the Beach: Knee Play 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 353 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dba66054-5878-4473-b04a-8b98a5adbf1b'
);


-- None Elizabeth Chooses a Career

UPDATE pieces piece
SET piece.title = 'Elizabeth Chooses a Career', piece.title_en = 'Elizabeth Chooses a Career',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8423 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Emigration

UPDATE pieces piece
SET piece.title = 'Emigration', piece.title_en = 'Emigration',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10339 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Engagement

UPDATE pieces piece
SET piece.title = 'Engagement', piece.title_en = 'Engagement',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8137 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Enter Vivian

UPDATE pieces piece
SET piece.title = 'Enter Vivian', piece.title_en = 'Enter Vivian',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9710 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Evening Song>

UPDATE pieces piece
SET piece.title = '가곡 <Evening Song>', piece.title_en = 'Evening Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9736 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Evening Song No. 3

UPDATE pieces piece
SET piece.title = 'Evening Song No. 3', piece.title_en = 'Evening Song No. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9288 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Evening Song no. 2

UPDATE pieces piece
SET piece.title = 'Evening Song no. 2', piece.title_en = 'Evening Song no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8051 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Explosives

UPDATE pieces piece
SET piece.title = 'Explosives', piece.title_en = 'Explosives',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9779 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eyes, Hands, Wheels

UPDATE pieces piece
SET piece.title = 'Eyes, Hands, Wheels', piece.title_en = 'Eyes, Hands, Wheels',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9588 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Facades

UPDATE pieces piece
SET piece.title = 'Facades', piece.title_en = 'Facades',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9056 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Face to Razor

UPDATE pieces piece
SET piece.title = 'Face to Razor', piece.title_en = 'Face to Razor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9895 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Father Stephen Lewis

UPDATE pieces piece
SET piece.title = 'Father Stephen Lewis', piece.title_en = 'Father Stephen Lewis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11042 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None First Day of School

UPDATE pieces piece
SET piece.title = 'First Day of School', piece.title_en = 'First Day of School',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10496 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Floating Candyman

UPDATE pieces piece
SET piece.title = 'Floating Candyman', piece.title_en = 'Floating Candyman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8772 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Floating in Space

UPDATE pieces piece
SET piece.title = 'Floating in Space', piece.title_en = 'Floating in Space',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10762 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Floe 87

UPDATE pieces piece
SET piece.title = 'Floe 87', piece.title_en = 'Floe 87',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9433 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four Movements for Two Pianos

UPDATE pieces piece
SET piece.title = 'Four Movements for Two Pianos', piece.title_en = 'Four Movements for Two Pianos',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10923 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Four Movements for Two Pianos: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10923 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:36072ec6-1307-4282-aa22-cefe72e2af3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36072ec6-1307-4282-aa22-cefe72e2af3d', 1, NULL, 'I', 'Four Movements for Two Pianos: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10923 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36072ec6-1307-4282-aa22-cefe72e2af3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Four Movements for Two Pianos: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10923 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ae28db0f-d16e-4a13-89a2-742b9370c2ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae28db0f-d16e-4a13-89a2-742b9370c2ef', 2, NULL, 'II', 'Four Movements for Two Pianos: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10923 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae28db0f-d16e-4a13-89a2-742b9370c2ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Four Movements for Two Pianos: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10923 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e993cd2c-0afe-4bed-8086-7449dbf5f648' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e993cd2c-0afe-4bed-8086-7449dbf5f648', 3, NULL, 'III', 'Four Movements for Two Pianos: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10923 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e993cd2c-0afe-4bed-8086-7449dbf5f648'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Four Movements for Two Pianos: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10923 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4bbdf887-0577-408a-bebc-32b4d8836dec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bbdf887-0577-408a-bebc-32b4d8836dec', 4, NULL, 'IV', 'Four Movements for Two Pianos: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10923 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bbdf887-0577-408a-bebc-32b4d8836dec'
);


-- None Gertrude Leaves the Summer House

UPDATE pieces piece
SET piece.title = 'Gertrude Leaves the Summer House', piece.title_en = 'Gertrude Leaves the Summer House',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8506 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gertrude Returns

UPDATE pieces piece
SET piece.title = 'Gertrude Returns', piece.title_en = 'Gertrude Returns',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9659 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gertrude’s Paradise

UPDATE pieces piece
SET piece.title = 'Gertrude’s Paradise', piece.title_en = 'Gertrude’s Paradise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9264 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Glasspieces>

UPDATE pieces piece
SET piece.title = '발레 <Glasspieces>', piece.title_en = 'Glasspieces',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7517 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Glasspiece #3 ("Funeral" from Akhnaten)', part.name_en = 'Glasspieces: Glasspiece #3 ("Funeral" from Akhnaten)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7517 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:afff7265-cfa9-3f51-9e67-86c49983d85a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afff7265-cfa9-3f51-9e67-86c49983d85a', 1, NULL, 'Glasspiece #3 ("Funeral" from Akhnaten)', 'Glasspieces: Glasspiece #3 ("Funeral" from Akhnaten)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7517 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afff7265-cfa9-3f51-9e67-86c49983d85a'
);


-- None Glassworks

UPDATE pieces piece
SET piece.title = 'Glassworks', piece.title_en = 'Glassworks',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7678 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Opening', part.name_en = 'Glassworks: I. Opening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7678 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e638dfc4-50c3-4f8c-b817-6d463a834d8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e638dfc4-50c3-4f8c-b817-6d463a834d8a', 1, 'I', 'Opening', 'Glassworks: I. Opening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7678 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e638dfc4-50c3-4f8c-b817-6d463a834d8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Floe', part.name_en = 'Glassworks: II. Floe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7678 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:75243c4c-588e-4633-bcde-9f8c99201169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75243c4c-588e-4633-bcde-9f8c99201169', 2, 'II', 'Floe', 'Glassworks: II. Floe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7678 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75243c4c-588e-4633-bcde-9f8c99201169'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Islands', part.name_en = 'Glassworks: III. Islands',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7678 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d76d0d13-db38-4554-8d05-684a184b6402' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d76d0d13-db38-4554-8d05-684a184b6402', 3, 'III', 'Islands', 'Glassworks: III. Islands', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7678 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d76d0d13-db38-4554-8d05-684a184b6402'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'VI',
    part.name_ko = 'Closing', part.name_en = 'Glassworks: VI. Closing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7678 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9755faa7-4322-4f30-b461-b0c37929c8e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9755faa7-4322-4f30-b461-b0c37929c8e6', 4, 'VI', 'Closing', 'Glassworks: VI. Closing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7678 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9755faa7-4322-4f30-b461-b0c37929c8e6'
);


-- None Going Home

UPDATE pieces piece
SET piece.title = 'Going Home', piece.title_en = 'Going Home',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10348 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Golden Coins

UPDATE pieces piece
SET piece.title = 'Golden Coins', piece.title_en = 'Golden Coins',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10037 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Good Girl

UPDATE pieces piece
SET piece.title = 'Good Girl', piece.title_en = 'Good Girl',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8575 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gradus

UPDATE pieces piece
SET piece.title = 'Gradus', piece.title_en = 'Gradus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9874 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gulf of Tonkin

UPDATE pieces piece
SET piece.title = 'Gulf of Tonkin', piece.title_en = 'Gulf of Tonkin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10935 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None He Is Coerced to Look

UPDATE pieces piece
SET piece.title = 'He Is Coerced to Look', piece.title_en = 'He Is Coerced to Look',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9045 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hour of the Slack and Escape

UPDATE pieces piece
SET piece.title = 'Hour of the Slack and Escape', piece.title_en = 'Hour of the Slack and Escape',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9253 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None How Now

UPDATE pieces piece
SET piece.title = 'How Now', piece.title_en = 'How Now',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9577 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Howard’s Request / In the Apt.

UPDATE pieces piece
SET piece.title = 'Howard’s Request / In the Apt.', piece.title_en = 'Howard’s Request / In the Apt.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8941 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Hydrogen Jukebox>

UPDATE pieces piece
SET piece.title = '오페라 <Hydrogen Jukebox>', piece.title_en = 'Hydrogen Jukebox',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11227 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Song #1 from Iron Horse', part.name_en = 'Hydrogen Jukebox: Song #1 from Iron Horse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ee305f98-51b9-4a87-9d75-91495a7dc907' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee305f98-51b9-4a87-9d75-91495a7dc907', 1, NULL, 'Song #1 from Iron Horse', 'Hydrogen Jukebox: Song #1 from Iron Horse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee305f98-51b9-4a87-9d75-91495a7dc907'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Song #2 Jahweh and Allah Battle', part.name_en = 'Hydrogen Jukebox: Song #2 Jahweh and Allah Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1656b26d-f249-4dba-9609-d80fbcc98049' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1656b26d-f249-4dba-9609-d80fbcc98049', 2, NULL, 'Song #2 Jahweh and Allah Battle', 'Hydrogen Jukebox: Song #2 Jahweh and Allah Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1656b26d-f249-4dba-9609-d80fbcc98049'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Song #3 from Iron Horse', part.name_en = 'Hydrogen Jukebox: Song #3 from Iron Horse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:41c49161-1b9b-40a8-9b83-7e8e605bb1f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c49161-1b9b-40a8-9b83-7e8e605bb1f2', 3, NULL, 'Song #3 from Iron Horse', 'Hydrogen Jukebox: Song #3 from Iron Horse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c49161-1b9b-40a8-9b83-7e8e605bb1f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Song #4 To P.O', part.name_en = 'Hydrogen Jukebox: Song #4 To P.O.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e9f29d36-9890-413e-91bc-8e99f5cc6cd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9f29d36-9890-413e-91bc-8e99f5cc6cd6', 4, NULL, 'Song #4 To P.O', 'Hydrogen Jukebox: Song #4 To P.O.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9f29d36-9890-413e-91bc-8e99f5cc6cd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Song #5 from Crossing Nation; Over Denver Again; Going to Chicago and To Poe: Over the Planet, Air Albany-Baltimore', part.name_en = 'Hydrogen Jukebox: Song #5 from Crossing Nation; Over Denver Again; Going to Chicago and To Poe: Over the Planet, Air Albany-Baltimore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:af45e97c-dda7-44d3-8387-33d6eac79659' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af45e97c-dda7-44d3-8387-33d6eac79659', 5, NULL, 'Song #5 from Crossing Nation; Over Denver Again; Going to Chicago and To Poe: Over the Planet, Air Albany-Baltimore', 'Hydrogen Jukebox: Song #5 from Crossing Nation; Over Denver Again; Going to Chicago and To Poe: Over the Planet, Air Albany-Baltimore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af45e97c-dda7-44d3-8387-33d6eac79659'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Song #6 from Wichita Vortex Sutra', part.name_en = 'Hydrogen Jukebox: Song #6 from Wichita Vortex Sutra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:12269f9a-84d1-4f17-bddd-7c78209caead' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12269f9a-84d1-4f17-bddd-7c78209caead', 6, NULL, 'Song #6 from Wichita Vortex Sutra', 'Hydrogen Jukebox: Song #6 from Wichita Vortex Sutra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12269f9a-84d1-4f17-bddd-7c78209caead'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Song #7 from Howl, Part II', part.name_en = 'Hydrogen Jukebox: Song #7 from Howl, Part II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:12e33917-2d9f-439b-9884-fb115337960a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12e33917-2d9f-439b-9884-fb115337960a', 7, NULL, 'Song #7 from Howl, Part II', 'Hydrogen Jukebox: Song #7 from Howl, Part II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12e33917-2d9f-439b-9884-fb115337960a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Song #8 from Cabin in the Rockies', part.name_en = 'Hydrogen Jukebox: Song #8 from Cabin in the Rockies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0b619712-171d-4a6d-813b-dd091adde1bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b619712-171d-4a6d-813b-dd091adde1bb', 8, NULL, 'Song #8 from Cabin in the Rockies', 'Hydrogen Jukebox: Song #8 from Cabin in the Rockies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b619712-171d-4a6d-813b-dd091adde1bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Song #9 from Nagasaki Days (Numbers in Red Notebook)', part.name_en = 'Hydrogen Jukebox: Song #9 from Nagasaki Days (Numbers in Red Notebook)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5884033e-1f3f-4738-a7d2-ad2463ea3d32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5884033e-1f3f-4738-a7d2-ad2463ea3d32', 9, NULL, 'Song #9 from Nagasaki Days (Numbers in Red Notebook)', 'Hydrogen Jukebox: Song #9 from Nagasaki Days (Numbers in Red Notebook)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5884033e-1f3f-4738-a7d2-ad2463ea3d32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Song #10 Aunt Rose', part.name_en = 'Hydrogen Jukebox: Song #10 Aunt Rose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ad5df102-9f50-46fc-aa38-8aba08bd190f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad5df102-9f50-46fc-aa38-8aba08bd190f', 10, NULL, 'Song #10 Aunt Rose', 'Hydrogen Jukebox: Song #10 Aunt Rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad5df102-9f50-46fc-aa38-8aba08bd190f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Song #11 from The Green Automobile', part.name_en = 'Hydrogen Jukebox: Song #11 from The Green Automobile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:14c46929-c821-49cb-8991-147a75a67539' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14c46929-c821-49cb-8991-147a75a67539', 11, NULL, 'Song #11 from The Green Automobile', 'Hydrogen Jukebox: Song #11 from The Green Automobile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14c46929-c821-49cb-8991-147a75a67539'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Song #12 from N.S.A. Dope Calypso', part.name_en = 'Hydrogen Jukebox: Song #12 from N.S.A. Dope Calypso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c91ab635-26ef-450c-b46b-55e541642f8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c91ab635-26ef-450c-b46b-55e541642f8b', 12, NULL, 'Song #12 from N.S.A. Dope Calypso', 'Hydrogen Jukebox: Song #12 from N.S.A. Dope Calypso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c91ab635-26ef-450c-b46b-55e541642f8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Song #13 from Nagasaki Days (Everybody’s Fantasy)', part.name_en = 'Hydrogen Jukebox: Song #13 from Nagasaki Days (Everybody’s Fantasy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:131c7b8a-9503-4891-9310-26460e9917a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:131c7b8a-9503-4891-9310-26460e9917a9', 13, NULL, 'Song #13 from Nagasaki Days (Everybody’s Fantasy)', 'Hydrogen Jukebox: Song #13 from Nagasaki Days (Everybody’s Fantasy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:131c7b8a-9503-4891-9310-26460e9917a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Song #14 Ayers Rock/Uluru Song and “Throw Out the Yellow Journalists…”', part.name_en = 'Hydrogen Jukebox: Song #14 Ayers Rock/Uluru Song and “Throw Out the Yellow Journalists…”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:85619544-33c5-41ad-bcee-8d3f0935f0e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85619544-33c5-41ad-bcee-8d3f0935f0e9', 14, NULL, 'Song #14 Ayers Rock/Uluru Song and “Throw Out the Yellow Journalists…”', 'Hydrogen Jukebox: Song #14 Ayers Rock/Uluru Song and “Throw Out the Yellow Journalists…”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85619544-33c5-41ad-bcee-8d3f0935f0e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Song #15 Father Death Blues (from Don’t Grow Old)', part.name_en = 'Hydrogen Jukebox: Song #15 Father Death Blues (from Don’t Grow Old)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11227 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e119bb02-3b34-4dfb-9d18-313616af4fbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e119bb02-3b34-4dfb-9d18-313616af4fbc', 15, NULL, 'Song #15 Father Death Blues (from Don’t Grow Old)', 'Hydrogen Jukebox: Song #15 Father Death Blues (from Don’t Grow Old)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11227 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e119bb02-3b34-4dfb-9d18-313616af4fbc'
);


-- None I Knew Her

UPDATE pieces piece
SET piece.title = 'I Knew Her', piece.title_en = 'I Knew Her',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10057 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None IBM Punch Cards

UPDATE pieces piece
SET piece.title = 'IBM Punch Cards', piece.title_en = 'IBM Punch Cards',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8663 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ignorant Sky

UPDATE pieces piece
SET piece.title = 'Ignorant Sky', piece.title_en = 'Ignorant Sky',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9257 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ik-Ook

UPDATE pieces piece
SET piece.title = 'Ik-Ook', piece.title_en = 'Ik-Ook',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10411 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In Again Out Again

UPDATE pieces piece
SET piece.title = 'In Again Out Again', piece.title_en = 'In Again Out Again',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8500 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In the Summer House

UPDATE pieces piece
SET piece.title = 'In the Summer House', piece.title_en = 'In the Summer House',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10336 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <In the Upper Room>

UPDATE pieces piece
SET piece.title = '발레 <In the Upper Room>', piece.title_en = 'In the Upper Room',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9331 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dance I', part.name_en = 'In the Upper Room: Dance I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:64712db2-cd7a-35e5-83f5-790867f5fc1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64712db2-cd7a-35e5-83f5-790867f5fc1f', 1, NULL, 'Dance I', 'In the Upper Room: Dance I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64712db2-cd7a-35e5-83f5-790867f5fc1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dance II', part.name_en = 'In the Upper Room: Dance II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4dbbe3b3-26e7-3653-9314-a14ae4c5eb6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbbe3b3-26e7-3653-9314-a14ae4c5eb6e', 2, NULL, 'Dance II', 'In the Upper Room: Dance II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbbe3b3-26e7-3653-9314-a14ae4c5eb6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dance III', part.name_en = 'In the Upper Room: Dance III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:cf6679f5-1fe1-3365-8569-64268bdb152a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf6679f5-1fe1-3365-8569-64268bdb152a', 3, NULL, 'Dance III', 'In the Upper Room: Dance III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf6679f5-1fe1-3365-8569-64268bdb152a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dance IV', part.name_en = 'In the Upper Room: Dance IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5f244592-cf62-3cbe-be15-13323834fdb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f244592-cf62-3cbe-be15-13323834fdb2', 4, NULL, 'Dance IV', 'In the Upper Room: Dance IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f244592-cf62-3cbe-be15-13323834fdb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dance V', part.name_en = 'In the Upper Room: Dance V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bfbe2bf2-e60c-349e-b6aa-8079937d3e0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfbe2bf2-e60c-349e-b6aa-8079937d3e0b', 5, NULL, 'Dance V', 'In the Upper Room: Dance V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfbe2bf2-e60c-349e-b6aa-8079937d3e0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dance VI', part.name_en = 'In the Upper Room: Dance VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:cb921e37-f1dc-3065-8ddc-a6dee8e2cceb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb921e37-f1dc-3065-8ddc-a6dee8e2cceb', 6, NULL, 'Dance VI', 'In the Upper Room: Dance VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb921e37-f1dc-3065-8ddc-a6dee8e2cceb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Dance VII', part.name_en = 'In the Upper Room: Dance VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9d1d9959-7e91-3fdc-b946-87c184ec68e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d1d9959-7e91-3fdc-b946-87c184ec68e9', 7, NULL, 'Dance VII', 'In the Upper Room: Dance VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d1d9959-7e91-3fdc-b946-87c184ec68e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Dance VIII', part.name_en = 'In the Upper Room: Dance VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:65f7aa61-e1e8-3e21-8231-ad74678fc8c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65f7aa61-e1e8-3e21-8231-ad74678fc8c0', 8, NULL, 'Dance VIII', 'In the Upper Room: Dance VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f7aa61-e1e8-3e21-8231-ad74678fc8c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Dance IX', part.name_en = 'In the Upper Room: Dance IX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9331 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1318c2a1-1607-3c45-a118-bd3667321d4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1318c2a1-1607-3c45-a118-bd3667321d4b', 9, NULL, 'Dance IX', 'In the Upper Room: Dance IX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9331 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1318c2a1-1607-3c45-a118-bd3667321d4b'
);


-- None In the Upper Room, Pt. 1

UPDATE pieces piece
SET piece.title = 'In the Upper Room, Pt. 1', piece.title_en = 'In the Upper Room, Pt. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9785 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In the Upper Room, Pt. 2

UPDATE pieces piece
SET piece.title = 'In the Upper Room, Pt. 2', piece.title_en = 'In the Upper Room, Pt. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9092 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In the Upper Room, Pt. 3

UPDATE pieces piece
SET piece.title = 'In the Upper Room, Pt. 3', piece.title_en = 'In the Upper Room, Pt. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10091 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None It Was Always You, Helen

UPDATE pieces piece
SET piece.title = 'It Was Always You, Helen', piece.title_en = 'It Was Always You, Helen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8718 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Itaipu>

UPDATE pieces piece
SET piece.title = '칸타타 <Itaipu>', piece.title_en = 'Itaipu',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7732 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mato Grosso', part.name_en = 'Itaipu: I. Mato Grosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7732 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4638900d-0989-4d49-8472-1b1f88bafb6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4638900d-0989-4d49-8472-1b1f88bafb6c', 1, 'I', 'Mato Grosso', 'Itaipu: I. Mato Grosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7732 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4638900d-0989-4d49-8472-1b1f88bafb6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Lake', part.name_en = 'Itaipu: II. The Lake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7732 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:dea29ff4-a96b-40f4-a39e-ad8df6d81cd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea29ff4-a96b-40f4-a39e-ad8df6d81cd0', 2, 'II', 'The Lake', 'Itaipu: II. The Lake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7732 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea29ff4-a96b-40f4-a39e-ad8df6d81cd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Dam', part.name_en = 'Itaipu: III. The Dam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7732 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:73580433-657b-4dbb-b8c7-57f6c5265687' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73580433-657b-4dbb-b8c7-57f6c5265687', 3, 'III', 'The Dam', 'Itaipu: III. The Dam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7732 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73580433-657b-4dbb-b8c7-57f6c5265687'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'To the Sea', part.name_en = 'Itaipu: IV. To the Sea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7732 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8e195ddd-53dd-4dde-924c-250b41997205' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e195ddd-53dd-4dde-924c-250b41997205', 4, 'IV', 'To the Sea', 'Itaipu: IV. To the Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7732 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e195ddd-53dd-4dde-924c-250b41997205'
);


-- None It’s Your Choice

UPDATE pieces piece
SET piece.title = 'It’s Your Choice', piece.title_en = 'It’s Your Choice',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11274 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jenipapo

UPDATE pieces piece
SET piece.title = 'Jenipapo', piece.title_en = 'Jenipapo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8604 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jenipapo Finale

UPDATE pieces piece
SET piece.title = 'Jenipapo Finale', piece.title_en = 'Jenipapo Finale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8029 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Journalism 101

UPDATE pieces piece
SET piece.title = 'Journalism 101', piece.title_en = 'Journalism 101',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11125 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Junkyard

UPDATE pieces piece
SET piece.title = 'Junkyard', piece.title_en = 'Junkyard',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8449 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None King Lear

UPDATE pieces piece
SET piece.title = 'King Lear', piece.title_en = 'King Lear',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10789 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Yet Better Thus', part.name_en = 'King Lear: Yet Better Thus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:009691b0-5728-4a79-8084-c79778a6959e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:009691b0-5728-4a79-8084-c79778a6959e', 1, NULL, 'Yet Better Thus', 'King Lear: Yet Better Thus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:009691b0-5728-4a79-8084-c79778a6959e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I Heard Myself Proclaimed', part.name_en = 'King Lear: I Heard Myself Proclaimed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:035a28a7-6ddb-4e0b-b3a8-5ae330bf0519' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:035a28a7-6ddb-4e0b-b3a8-5ae330bf0519', 2, NULL, 'I Heard Myself Proclaimed', 'King Lear: I Heard Myself Proclaimed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:035a28a7-6ddb-4e0b-b3a8-5ae330bf0519'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'So Be My Lord', part.name_en = 'King Lear: So Be My Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0988122a-5637-456c-b706-8ba495fbf76f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0988122a-5637-456c-b706-8ba495fbf76f', 3, NULL, 'So Be My Lord', 'King Lear: So Be My Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0988122a-5637-456c-b706-8ba495fbf76f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lear and the Storm', part.name_en = 'King Lear: Lear and the Storm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0b29e004-de5b-4ffb-be7f-19fd9f28d55e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b29e004-de5b-4ffb-be7f-19fd9f28d55e', 4, NULL, 'Lear and the Storm', 'King Lear: Lear and the Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b29e004-de5b-4ffb-be7f-19fd9f28d55e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Storm Unleashes', part.name_en = 'King Lear: Storm Unleashes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0c091473-0bba-4841-b3d4-7cc165f8d517' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c091473-0bba-4841-b3d4-7cc165f8d517', 5, NULL, 'Storm Unleashes', 'King Lear: Storm Unleashes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c091473-0bba-4841-b3d4-7cc165f8d517'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Edgar''s Mention of the Gods', part.name_en = 'King Lear: Edgar''s Mention of the Gods',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:172a914b-3da6-4085-aadf-27e753f1ea16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:172a914b-3da6-4085-aadf-27e753f1ea16', 6, NULL, 'Edgar''s Mention of the Gods', 'King Lear: Edgar''s Mention of the Gods', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:172a914b-3da6-4085-aadf-27e753f1ea16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Winter''s Not Gone Yet', part.name_en = 'King Lear: Winter''s Not Gone Yet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:26a74a9a-6a47-4a0f-a122-e0d697d96fb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26a74a9a-6a47-4a0f-a122-e0d697d96fb6', 7, NULL, 'Winter''s Not Gone Yet', 'King Lear: Winter''s Not Gone Yet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26a74a9a-6a47-4a0f-a122-e0d697d96fb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'These Late Eclipses', part.name_en = 'King Lear: These Late Eclipses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:37c77cbc-d7a3-42c1-a94f-e96207e6a703' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37c77cbc-d7a3-42c1-a94f-e96207e6a703', 8, NULL, 'These Late Eclipses', 'King Lear: These Late Eclipses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37c77cbc-d7a3-42c1-a94f-e96207e6a703'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Approach Thou Beacon', part.name_en = 'King Lear: Approach Thou Beacon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3da45ff0-9699-4e66-8eac-195b838c2673' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3da45ff0-9699-4e66-8eac-195b838c2673', 9, NULL, 'Approach Thou Beacon', 'King Lear: Approach Thou Beacon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3da45ff0-9699-4e66-8eac-195b838c2673'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Rumbling Storm Reprise', part.name_en = 'King Lear: Rumbling Storm Reprise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:551a6c6e-2bd8-4b03-905a-5b66949158a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:551a6c6e-2bd8-4b03-905a-5b66949158a7', 10, NULL, 'Rumbling Storm Reprise', 'King Lear: Rumbling Storm Reprise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:551a6c6e-2bd8-4b03-905a-5b66949158a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Military Music Part 2', part.name_en = 'King Lear: Military Music Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5e8a824d-a560-4070-be08-d30277061247' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e8a824d-a560-4070-be08-d30277061247', 11, NULL, 'Military Music Part 2', 'King Lear: Military Music Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e8a824d-a560-4070-be08-d30277061247'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'King Lear: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:67f6eaec-ac1a-4f63-96c1-86af7444b0ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f6eaec-ac1a-4f63-96c1-86af7444b0ad', 12, NULL, 'Overture', 'King Lear: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f6eaec-ac1a-4f63-96c1-86af7444b0ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Here is My Pledge', part.name_en = 'King Lear: Here is My Pledge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:67fb1e01-7d31-4056-9592-296db1411950' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67fb1e01-7d31-4056-9592-296db1411950', 13, NULL, 'Here is My Pledge', 'King Lear: Here is My Pledge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67fb1e01-7d31-4056-9592-296db1411950'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Remnants of the Storm', part.name_en = 'King Lear: Remnants of the Storm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7712ae42-91e4-4baf-a1db-7ebf85fb31f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7712ae42-91e4-4baf-a1db-7ebf85fb31f2', 14, NULL, 'Remnants of the Storm', 'King Lear: Remnants of the Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7712ae42-91e4-4baf-a1db-7ebf85fb31f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Omen of the Storm', part.name_en = 'King Lear: Omen of the Storm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:786ea530-526a-410d-ac6c-71b5e576c682' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:786ea530-526a-410d-ac6c-71b5e576c682', 15, NULL, 'Omen of the Storm', 'King Lear: Omen of the Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:786ea530-526a-410d-ac6c-71b5e576c682'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Let Me Not Be Mad', part.name_en = 'King Lear: Let Me Not Be Mad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7a110cb0-894d-4120-a78c-bd469423595c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a110cb0-894d-4120-a78c-bd469423595c', 16, NULL, 'Let Me Not Be Mad', 'King Lear: Let Me Not Be Mad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a110cb0-894d-4120-a78c-bd469423595c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Drinking Song', part.name_en = 'King Lear: Drinking Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:862bda8a-c590-4046-a41f-5909a2eac8c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:862bda8a-c590-4046-a41f-5909a2eac8c9', 17, NULL, 'Drinking Song', 'King Lear: Drinking Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:862bda8a-c590-4046-a41f-5909a2eac8c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Gloucester & Edmund', part.name_en = 'King Lear: Gloucester & Edmund',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:87120f9e-5214-4794-9ec5-346857a91060' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87120f9e-5214-4794-9ec5-346857a91060', 18, NULL, 'Gloucester & Edmund', 'King Lear: Gloucester & Edmund', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87120f9e-5214-4794-9ec5-346857a91060'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Military Music Part 1', part.name_en = 'King Lear: Military Music Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9164a2dc-39bd-4064-a3f9-fa31d2dd1e40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9164a2dc-39bd-4064-a3f9-fa31d2dd1e40', 19, NULL, 'Military Music Part 1', 'King Lear: Military Music Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9164a2dc-39bd-4064-a3f9-fa31d2dd1e40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Rumbling Storm Part 2', part.name_en = 'King Lear: Rumbling Storm Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9d7ae695-b956-4b68-b241-11b4bd8bd1ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d7ae695-b956-4b68-b241-11b4bd8bd1ac', 20, NULL, 'Rumbling Storm Part 2', 'King Lear: Rumbling Storm Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d7ae695-b956-4b68-b241-11b4bd8bd1ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'It Raineth Every Day', part.name_en = 'King Lear: It Raineth Every Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a112dba2-b2a1-4ac5-8a8d-ca8991f262ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a112dba2-b2a1-4ac5-8a8d-ca8991f262ad', 21, NULL, 'It Raineth Every Day', 'King Lear: It Raineth Every Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a112dba2-b2a1-4ac5-8a8d-ca8991f262ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Entr''acte', part.name_en = 'King Lear: Entr''acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a2a1ecb0-69e6-4509-879a-d0b24dc65eac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a1ecb0-69e6-4509-879a-d0b24dc65eac', 22, NULL, 'Entr''acte', 'King Lear: Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a1ecb0-69e6-4509-879a-d0b24dc65eac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Goneril''s House', part.name_en = 'King Lear: Goneril''s House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:aadc9c7f-4dc7-42c4-8730-f2dbf10a5730' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aadc9c7f-4dc7-42c4-8730-f2dbf10a5730', 23, NULL, 'Goneril''s House', 'King Lear: Goneril''s House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aadc9c7f-4dc7-42c4-8730-f2dbf10a5730'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Prayer in Storm', part.name_en = 'King Lear: Prayer in Storm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ae26695d-cc83-4ae8-8ecb-5e29061dc99d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae26695d-cc83-4ae8-8ecb-5e29061dc99d', 24, NULL, 'Prayer in Storm', 'King Lear: Prayer in Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae26695d-cc83-4ae8-8ecb-5e29061dc99d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Rumbling Storm Part 1', part.name_en = 'King Lear: Rumbling Storm Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b68b8554-aff6-48d8-9c54-2a4352310bd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b68b8554-aff6-48d8-9c54-2a4352310bd3', 25, NULL, 'Rumbling Storm Part 1', 'King Lear: Rumbling Storm Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b68b8554-aff6-48d8-9c54-2a4352310bd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Fools Had Ne''er Less Grace in a Year', part.name_en = 'King Lear: Fools Had Ne''er Less Grace in a Year',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bcfdc4c9-1400-44b2-bf6a-1f294efbf338' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcfdc4c9-1400-44b2-bf6a-1f294efbf338', 26, NULL, 'Fools Had Ne''er Less Grace in a Year', 'King Lear: Fools Had Ne''er Less Grace in a Year', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcfdc4c9-1400-44b2-bf6a-1f294efbf338'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'How Does My Royal Lord', part.name_en = 'King Lear: How Does My Royal Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c25d0e0d-7f49-46e4-a53c-cd2d73660de4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c25d0e0d-7f49-46e4-a53c-cd2d73660de4', 27, NULL, 'How Does My Royal Lord', 'King Lear: How Does My Royal Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c25d0e0d-7f49-46e4-a53c-cd2d73660de4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Cordelia''s Prayer', part.name_en = 'King Lear: Cordelia''s Prayer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:cb8164ec-06ce-4d21-b45b-f0d2804d21ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb8164ec-06ce-4d21-b45b-f0d2804d21ff', 28, NULL, 'Cordelia''s Prayer', 'King Lear: Cordelia''s Prayer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb8164ec-06ce-4d21-b45b-f0d2804d21ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Epilogue', part.name_en = 'King Lear: Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f2e16294-c6d7-4075-8d1a-702f64e8cbcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2e16294-c6d7-4075-8d1a-702f64e8cbcc', 29, NULL, 'Epilogue', 'King Lear: Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2e16294-c6d7-4075-8d1a-702f64e8cbcc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Avenge Gloucester''s Eyes', part.name_en = 'King Lear: Avenge Gloucester''s Eyes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10789 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f4018018-8c8a-4bb1-9d04-9e2f9e20c997' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4018018-8c8a-4bb1-9d04-9e2f9e20c997', 30, NULL, 'Avenge Gloucester''s Eyes', 'King Lear: Avenge Gloucester''s Eyes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10789 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4018018-8c8a-4bb1-9d04-9e2f9e20c997'
);


-- None 영화음악 <Kundun>

UPDATE pieces piece
SET piece.title = '영화음악 <Kundun>', piece.title_en = 'Kundun',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8019 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Thirteenth Dalai Lama', part.name_en = 'Thirteenth Dalai Lama',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:026f7826-0bc5-4981-99df-cfe516d279eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:026f7826-0bc5-4981-99df-cfe516d279eb', 1, NULL, 'Thirteenth Dalai Lama', 'Thirteenth Dalai Lama', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:026f7826-0bc5-4981-99df-cfe516d279eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Distraught', part.name_en = 'Distraught',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:085cf644-e508-490e-8ff0-da8c505ed6d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:085cf644-e508-490e-8ff0-da8c505ed6d9', 2, NULL, 'Distraught', 'Distraught', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:085cf644-e508-490e-8ff0-da8c505ed6d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chinese Invade', part.name_en = 'Chinese Invade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3b86a724-6215-4c61-9e22-145af6dc9dd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b86a724-6215-4c61-9e22-145af6dc9dd6', 3, NULL, 'Chinese Invade', 'Chinese Invade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b86a724-6215-4c61-9e22-145af6dc9dd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lord Chamberlain', part.name_en = 'Lord Chamberlain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4d62fe22-f7e3-4495-be06-f1209dd5ad01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d62fe22-f7e3-4495-be06-f1209dd5ad01', 4, NULL, 'Lord Chamberlain', 'Lord Chamberlain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d62fe22-f7e3-4495-be06-f1209dd5ad01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Fish', part.name_en = 'Fish',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4dcf3fb0-6f15-43df-8d58-0a26671824d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dcf3fb0-6f15-43df-8d58-0a26671824d1', 5, NULL, 'Fish', 'Fish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dcf3fb0-6f15-43df-8d58-0a26671824d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Norbu Plays', part.name_en = 'Norbu Plays',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:58b367c6-21fc-4ecf-9624-bfcb3bd62fd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58b367c6-21fc-4ecf-9624-bfcb3bd62fd9', 6, NULL, 'Norbu Plays', 'Norbu Plays', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58b367c6-21fc-4ecf-9624-bfcb3bd62fd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Sand Mandala', part.name_en = 'Sand Mandala',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5f22a7dc-90aa-4db7-80ed-d697ce5fe474' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f22a7dc-90aa-4db7-80ed-d697ce5fe474', 7, NULL, 'Sand Mandala', 'Sand Mandala', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f22a7dc-90aa-4db7-80ed-d697ce5fe474'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Reting''s Eyes', part.name_en = 'Reting''s Eyes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6eb88f13-7d24-4969-8ac5-f3466d98ad07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6eb88f13-7d24-4969-8ac5-f3466d98ad07', 8, NULL, 'Reting''s Eyes', 'Reting''s Eyes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eb88f13-7d24-4969-8ac5-f3466d98ad07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Choosing', part.name_en = 'Choosing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8163f5b8-8950-44ca-b872-0bcc4fcc7720' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8163f5b8-8950-44ca-b872-0bcc4fcc7720', 9, NULL, 'Choosing', 'Choosing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8163f5b8-8950-44ca-b872-0bcc4fcc7720'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Move to Dungkar', part.name_en = 'Move to Dungkar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9910338e-8588-43b4-97d8-0031cabd09b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9910338e-8588-43b4-97d8-0031cabd09b5', 10, NULL, 'Move to Dungkar', 'Move to Dungkar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9910338e-8588-43b4-97d8-0031cabd09b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Escape to India', part.name_en = 'Escape to India',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c31f5a5e-a19c-4250-b8bc-ca23390832d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c31f5a5e-a19c-4250-b8bc-ca23390832d5', 11, NULL, 'Escape to India', 'Escape to India', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c31f5a5e-a19c-4250-b8bc-ca23390832d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Projector', part.name_en = 'Projector',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c9b13fd0-e45e-43c3-8158-17130e5040a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9b13fd0-e45e-43c3-8158-17130e5040a3', 12, NULL, 'Projector', 'Projector', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9b13fd0-e45e-43c3-8158-17130e5040a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Lhasa at Night', part.name_en = 'Lhasa at Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:cd0761e0-8312-4126-98dd-aa18a5451748' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd0761e0-8312-4126-98dd-aa18a5451748', 13, NULL, 'Lhasa at Night', 'Lhasa at Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd0761e0-8312-4126-98dd-aa18a5451748'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Dark Kitchen', part.name_en = 'Dark Kitchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ce7e6b1d-0118-42dd-ba0d-eba87696d6fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce7e6b1d-0118-42dd-ba0d-eba87696d6fc', 14, NULL, 'Dark Kitchen', 'Dark Kitchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce7e6b1d-0118-42dd-ba0d-eba87696d6fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Caravan Moves Out', part.name_en = 'Caravan Moves Out',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:dc9ac917-9223-4048-b48c-2b7d77828fed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc9ac917-9223-4048-b48c-2b7d77828fed', 15, NULL, 'Caravan Moves Out', 'Caravan Moves Out', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc9ac917-9223-4048-b48c-2b7d77828fed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Northern Tibet', part.name_en = 'Northern Tibet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ee95ee1d-9f3f-4c1b-980f-7967acc26954' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee95ee1d-9f3f-4c1b-980f-7967acc26954', 16, NULL, 'Northern Tibet', 'Northern Tibet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee95ee1d-9f3f-4c1b-980f-7967acc26954'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Norbulingka', part.name_en = 'Norbulingka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f7aa2ad4-1da8-45cf-9bf0-eb7b4581f180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7aa2ad4-1da8-45cf-9bf0-eb7b4581f180', 17, NULL, 'Norbulingka', 'Norbulingka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7aa2ad4-1da8-45cf-9bf0-eb7b4581f180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Potala', part.name_en = 'Potala',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8019 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fd281874-4284-4942-9c92-de667c31f8a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd281874-4284-4942-9c92-de667c31f8a5', 18, NULL, 'Potala', 'Potala', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8019 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd281874-4284-4942-9c92-de667c31f8a5'
);


-- None L'Envol des cygnes

UPDATE pieces piece
SET piece.title = 'L''Envol des cygnes', piece.title_en = 'L''Envol des cygnes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9637 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <La Belle et la Bête>

UPDATE pieces piece
SET piece.title = '오페라 <La Belle et la Bête>', piece.title_en = 'La Belle et la Bête',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9348 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scène 1: Ouverture', part.name_en = 'La Belle et la Bête: Scène 1: Ouverture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:cee40ec2-daa7-429d-82a9-86576bc1823b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cee40ec2-daa7-429d-82a9-86576bc1823b', 1, NULL, 'Scène 1: Ouverture', 'La Belle et la Bête: Scène 1: Ouverture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cee40ec2-daa7-429d-82a9-86576bc1823b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scène 2: Les Sœurs', part.name_en = 'La Belle et la Bête: Scène 2: Les Sœurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5d9ac3c3-f99c-4d8f-b8e6-2f5bdf66f96f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d9ac3c3-f99c-4d8f-b8e6-2f5bdf66f96f', 2, NULL, 'Scène 2: Les Sœurs', 'La Belle et la Bête: Scène 2: Les Sœurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d9ac3c3-f99c-4d8f-b8e6-2f5bdf66f96f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scène 3: La Demande en mariage d’avenant', part.name_en = 'La Belle et la Bête: Scène 3: La Demande en mariage d’avenant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:306df7a3-c49d-452f-ab0a-518e687adf71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:306df7a3-c49d-452f-ab0a-518e687adf71', 3, NULL, 'Scène 3: La Demande en mariage d’avenant', 'La Belle et la Bête: Scène 3: La Demande en mariage d’avenant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:306df7a3-c49d-452f-ab0a-518e687adf71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scène 4: Le Voyage du père', part.name_en = 'La Belle et la Bête: Scène 4: Le Voyage du père',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3e2c3f5a-adc8-4e66-93fe-e1a39585e970' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e2c3f5a-adc8-4e66-93fe-e1a39585e970', 4, NULL, 'Scène 4: Le Voyage du père', 'La Belle et la Bête: Scène 4: Le Voyage du père', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e2c3f5a-adc8-4e66-93fe-e1a39585e970'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scène 5: Le Domaine de la Bête', part.name_en = 'La Belle et la Bête: Scène 5: Le Domaine de la Bête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9cff9810-9a20-435a-80de-a66b9e207df3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cff9810-9a20-435a-80de-a66b9e207df3', 5, NULL, 'Scène 5: Le Domaine de la Bête', 'La Belle et la Bête: Scène 5: Le Domaine de la Bête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cff9810-9a20-435a-80de-a66b9e207df3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scène 6: Le Retour du père', part.name_en = 'La Belle et la Bête: Scène 6: Le Retour du père',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6883f775-e294-44c2-89a3-ca10639583f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6883f775-e294-44c2-89a3-ca10639583f8', 6, NULL, 'Scène 6: Le Retour du père', 'La Belle et la Bête: Scène 6: Le Retour du père', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6883f775-e294-44c2-89a3-ca10639583f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scène 7: La Belle va au château', part.name_en = 'La Belle et la Bête: Scène 7: La Belle va au château',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8fb58116-823e-4725-b75e-988e64f8fb61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fb58116-823e-4725-b75e-988e64f8fb61', 7, NULL, 'Scène 7: La Belle va au château', 'La Belle et la Bête: Scène 7: La Belle va au château', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fb58116-823e-4725-b75e-988e64f8fb61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scène 8: Le Dîner', part.name_en = 'La Belle et la Bête: Scène 8: Le Dîner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e1a16d3c-1550-41b7-97e1-17d6ab17a592' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1a16d3c-1550-41b7-97e1-17d6ab17a592', 8, NULL, 'Scène 8: Le Dîner', 'La Belle et la Bête: Scène 8: Le Dîner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1a16d3c-1550-41b7-97e1-17d6ab17a592'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scène 9: Les Tourments de la Bête', part.name_en = 'La Belle et la Bête: Scène 9: Les Tourments de la Bête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:16ae5824-5632-44a6-ba63-c43ba8c077d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16ae5824-5632-44a6-ba63-c43ba8c077d4', 9, NULL, 'Scène 9: Les Tourments de la Bête', 'La Belle et la Bête: Scène 9: Les Tourments de la Bête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16ae5824-5632-44a6-ba63-c43ba8c077d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scène 10: Promenade dans le jardin', part.name_en = 'La Belle et la Bête: Scène 10: Promenade dans le jardin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3c526545-62c9-4432-acdc-edc7061ce523' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c526545-62c9-4432-acdc-edc7061ce523', 10, NULL, 'Scène 10: Promenade dans le jardin', 'La Belle et la Bête: Scène 10: Promenade dans le jardin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c526545-62c9-4432-acdc-edc7061ce523'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scène 11: La Saisie des meubles', part.name_en = 'La Belle et la Bête: Scène 11: La Saisie des meubles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:30323721-e048-40c8-9a16-117a77f10319' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30323721-e048-40c8-9a16-117a77f10319', 11, NULL, 'Scène 11: La Saisie des meubles', 'La Belle et la Bête: Scène 11: La Saisie des meubles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30323721-e048-40c8-9a16-117a77f10319'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scène 12: La Confiance de la Bête en la Belle', part.name_en = 'La Belle et la Bête: Scène 12: La Confiance de la Bête en la Belle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fe4ed584-1c07-434b-be9b-e379b397ff18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe4ed584-1c07-434b-be9b-e379b397ff18', 12, NULL, 'Scène 12: La Confiance de la Bête en la Belle', 'La Belle et la Bête: Scène 12: La Confiance de la Bête en la Belle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe4ed584-1c07-434b-be9b-e379b397ff18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scène 13: Belle retourne chez son père', part.name_en = 'La Belle et la Bête: Scène 13: Belle retourne chez son père',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:afa14cb1-f843-4a03-ba4a-3be21c2aaaac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afa14cb1-f843-4a03-ba4a-3be21c2aaaac', 13, NULL, 'Scène 13: Belle retourne chez son père', 'La Belle et la Bête: Scène 13: Belle retourne chez son père', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afa14cb1-f843-4a03-ba4a-3be21c2aaaac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Scène 14: Belle raconte son histoire', part.name_en = 'La Belle et la Bête: Scène 14: Belle raconte son histoire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0af9cd79-4bfb-46fd-a928-6b821b06c620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0af9cd79-4bfb-46fd-a928-6b821b06c620', 14, NULL, 'Scène 14: Belle raconte son histoire', 'La Belle et la Bête: Scène 14: Belle raconte son histoire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0af9cd79-4bfb-46fd-a928-6b821b06c620'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Scène 15: Le Plan', part.name_en = 'La Belle et la Bête: Scène 15: Le Plan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:979de88d-667a-4c39-8e9a-7358b3cefea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:979de88d-667a-4c39-8e9a-7358b3cefea8', 15, NULL, 'Scène 15: Le Plan', 'La Belle et la Bête: Scène 15: Le Plan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:979de88d-667a-4c39-8e9a-7358b3cefea8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Scène 16: Le Passion d’avenant', part.name_en = 'La Belle et la Bête: Scène 16: Le Passion d’avenant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:974d7a4b-012d-4216-8a6b-da2073a20dd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:974d7a4b-012d-4216-8a6b-da2073a20dd6', 16, NULL, 'Scène 16: Le Passion d’avenant', 'La Belle et la Bête: Scène 16: Le Passion d’avenant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:974d7a4b-012d-4216-8a6b-da2073a20dd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Scène 17: Le Magnifique apparaît', part.name_en = 'La Belle et la Bête: Scène 17: Le Magnifique apparaît',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d18a4258-7009-4223-852d-337955831dde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d18a4258-7009-4223-852d-337955831dde', 17, NULL, 'Scène 17: Le Magnifique apparaît', 'La Belle et la Bête: Scène 17: Le Magnifique apparaît', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d18a4258-7009-4223-852d-337955831dde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Scène 18: Le Miroir', part.name_en = 'La Belle et la Bête: Scène 18: Le Miroir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3f0dd5c0-72ee-4db7-8079-7f8ef2f22983' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f0dd5c0-72ee-4db7-8079-7f8ef2f22983', 18, NULL, 'Scène 18: Le Miroir', 'La Belle et la Bête: Scène 18: Le Miroir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f0dd5c0-72ee-4db7-8079-7f8ef2f22983'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Scène 19: Le Pavillon', part.name_en = 'La Belle et la Bête: Scène 19: Le Pavillon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d2bdeaeb-39bd-4398-8231-bcfe88b9e071' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2bdeaeb-39bd-4398-8231-bcfe88b9e071', 19, NULL, 'Scène 19: Le Pavillon', 'La Belle et la Bête: Scène 19: Le Pavillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2bdeaeb-39bd-4398-8231-bcfe88b9e071'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Scène 20: La Métamorphose', part.name_en = 'La Belle et la Bête: Scène 20: La Métamorphose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9348 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1db956f0-74b6-4523-8dbd-0b0c1ab63177' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1db956f0-74b6-4523-8dbd-0b0c1ab63177', 20, NULL, 'Scène 20: La Métamorphose', 'La Belle et la Bête: Scène 20: La Métamorphose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9348 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1db956f0-74b6-4523-8dbd-0b0c1ab63177'
);


-- None La Course sur l'eau des grèbes

UPDATE pieces piece
SET piece.title = 'La Course sur l''eau des grèbes', piece.title_en = 'La Course sur l''eau des grèbes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10902 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Naissance du faon

UPDATE pieces piece
SET piece.title = 'La Naissance du faon', piece.title_en = 'La Naissance du faon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9103 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Toilette

UPDATE pieces piece
SET piece.title = 'La Toilette', piece.title_en = 'La Toilette',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8932 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lady Day

UPDATE pieces piece
SET piece.title = 'Lady Day', piece.title_en = 'Lady Day',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8867 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Landing

UPDATE pieces piece
SET piece.title = 'Landing', piece.title_en = 'Landing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9933 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Land‐Grab

UPDATE pieces piece
SET piece.title = 'Land‐Grab', piece.title_en = 'Land‐Grab',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8235 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Ballet des oiseaux

UPDATE pieces piece
SET piece.title = 'Le Ballet des oiseaux', piece.title_en = 'Le Ballet des oiseaux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9941 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Paon et les Grues japonaises

UPDATE pieces piece
SET piece.title = 'Le Paon et les Grues japonaises', piece.title_en = 'Le Paon et les Grues japonaises',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10033 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Retour des animaux

UPDATE pieces piece
SET piece.title = 'Le Retour des animaux', piece.title_en = 'Le Retour des animaux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8524 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Left Alone…

UPDATE pieces piece
SET piece.title = 'Left Alone…', piece.title_en = 'Left Alone…',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10075 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Combats

UPDATE pieces piece
SET piece.title = 'Les Combats', piece.title_en = 'Les Combats',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9632 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Couples heureux

UPDATE pieces piece
SET piece.title = 'Les Couples heureux', piece.title_en = 'Les Couples heureux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10340 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Kangourous

UPDATE pieces piece
SET piece.title = 'Les Kangourous', piece.title_en = 'Les Kangourous',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9671 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Orangs outans et les Petits Canards

UPDATE pieces piece
SET piece.title = 'Les Orangs outans et les Petits Canards', piece.title_en = 'Les Orangs outans et les Petits Canards',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8666 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Regards des flairs

UPDATE pieces piece
SET piece.title = 'Les Regards des flairs', piece.title_en = 'Les Regards des flairs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8365 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les cygnes reviennent

UPDATE pieces piece
SET piece.title = 'Les cygnes reviennent', piece.title_en = 'Les cygnes reviennent',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8754 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Life Itself

UPDATE pieces piece
SET piece.title = 'Life Itself', piece.title_en = 'Life Itself',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8727 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lionel Departs

UPDATE pieces piece
SET piece.title = 'Lionel Departs', piece.title_en = 'Lionel Departs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10513 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Love Divided By

UPDATE pieces piece
SET piece.title = 'Love Divided By', piece.title_en = 'Love Divided By',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10885 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Low Evil

UPDATE pieces piece
SET piece.title = 'Low Evil', piece.title_en = 'Low Evil',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9303 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mad Rush

UPDATE pieces piece
SET piece.title = 'Mad Rush', piece.title_en = 'Mad Rush',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10779 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melody for Saxophone No. 10

UPDATE pieces piece
SET piece.title = 'Melody for Saxophone No. 10', piece.title_en = 'Melody for Saxophone No. 10',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8408 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melody for Saxophone No. 12

UPDATE pieces piece
SET piece.title = 'Melody for Saxophone No. 12', piece.title_en = 'Melody for Saxophone No. 12',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9377 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melody for Saxophone No. 5

UPDATE pieces piece
SET piece.title = 'Melody for Saxophone No. 5', piece.title_en = 'Melody for Saxophone No. 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9385 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Metamorphosis

UPDATE pieces piece
SET piece.title = 'Metamorphosis', piece.title_en = 'Metamorphosis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7883 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Metamorphosis V', part.name_en = 'Metamorphosis V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7883 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:250991f2-c014-362e-b5d1-2c598ee40dd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:250991f2-c014-362e-b5d1-2c598ee40dd0', 1, NULL, 'Metamorphosis V', 'Metamorphosis V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7883 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:250991f2-c014-362e-b5d1-2c598ee40dd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Metamorphosis II', part.name_en = 'Metamorphosis II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7883 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4ee9929e-356b-3529-a420-8d0b48a955d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee9929e-356b-3529-a420-8d0b48a955d6', 2, NULL, 'Metamorphosis II', 'Metamorphosis II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7883 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee9929e-356b-3529-a420-8d0b48a955d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Metamorphosis III', part.name_en = 'Metamorphosis III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7883 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:72ca9371-fb4b-371b-9005-3f850ad5b210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72ca9371-fb4b-371b-9005-3f850ad5b210', 3, NULL, 'Metamorphosis III', 'Metamorphosis III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7883 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72ca9371-fb4b-371b-9005-3f850ad5b210'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Metamorphosis I', part.name_en = 'Metamorphosis I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7883 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a5926abc-ac2d-3035-9a4f-d995b6812981' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5926abc-ac2d-3035-9a4f-d995b6812981', 4, NULL, 'Metamorphosis I', 'Metamorphosis I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7883 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5926abc-ac2d-3035-9a4f-d995b6812981'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Metamorphosis IV', part.name_en = 'Metamorphosis IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7883 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b1f5c98d-1f30-3122-abbb-a8f315b56f0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f5c98d-1f30-3122-abbb-a8f315b56f0d', 5, NULL, 'Metamorphosis IV', 'Metamorphosis IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7883 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f5c98d-1f30-3122-abbb-a8f315b56f0d'
);


-- None 영화음악 <Mishima>

UPDATE pieces piece
SET piece.title = '영화음악 <Mishima>', piece.title_en = 'Mishima',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10733 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mishima / Opening', part.name_en = 'Mishima / Opening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0126e087-a07b-43aa-a8ac-281259bf772c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0126e087-a07b-43aa-a8ac-281259bf772c', 1, NULL, 'Mishima / Opening', 'Mishima / Opening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0126e087-a07b-43aa-a8ac-281259bf772c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Morning', part.name_en = 'November 25: Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:85f23cec-9a91-47fb-936b-e00c0425673b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85f23cec-9a91-47fb-936b-e00c0425673b', 2, NULL, 'Morning', 'November 25: Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85f23cec-9a91-47fb-936b-e00c0425673b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Grandmother & Kimitake', part.name_en = '1934: Grandmother & Kimitake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a36c92bd-800d-4f74-9a55-a4f67c5a6e90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a36c92bd-800d-4f74-9a55-a4f67c5a6e90', 3, NULL, 'Grandmother & Kimitake', '1934: Grandmother & Kimitake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a36c92bd-800d-4f74-9a55-a4f67c5a6e90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Temple of the Golden Pavilion (“Like Some Enormous Music”)', part.name_en = 'Temple of the Golden Pavilion (“Like Some Enormous Music”)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:741b3c6a-374f-4e98-8580-8b13c4ee71a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:741b3c6a-374f-4e98-8580-8b13c4ee71a0', 4, NULL, 'Temple of the Golden Pavilion (“Like Some Enormous Music”)', 'Temple of the Golden Pavilion (“Like Some Enormous Music”)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:741b3c6a-374f-4e98-8580-8b13c4ee71a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Kyoko’s House', part.name_en = 'Osamu’s Theme: Kyoko’s House',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:491afb4f-5cce-4414-af39-ba196da60dfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:491afb4f-5cce-4414-af39-ba196da60dfa', 5, NULL, 'Kyoko’s House', 'Osamu’s Theme: Kyoko’s House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:491afb4f-5cce-4414-af39-ba196da60dfa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Saint Sebastian', part.name_en = '1937: Saint Sebastian',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f8db8a5c-d56f-4487-aec9-f6cd1bfe3d90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8db8a5c-d56f-4487-aec9-f6cd1bfe3d90', 6, NULL, 'Saint Sebastian', '1937: Saint Sebastian', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8db8a5c-d56f-4487-aec9-f6cd1bfe3d90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Kyoko’s House (“Stage Blood Is Not Enough”)', part.name_en = 'Kyoko’s House (“Stage Blood Is Not Enough”)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bcc3c3be-8f22-4169-a54a-3c1f4cf549da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcc3c3be-8f22-4169-a54a-3c1f4cf549da', 7, NULL, 'Kyoko’s House (“Stage Blood Is Not Enough”)', 'Kyoko’s House (“Stage Blood Is Not Enough”)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcc3c3be-8f22-4169-a54a-3c1f4cf549da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Ichigaya', part.name_en = 'November 25: Ichigaya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:57fdf78b-60a1-4b46-94ab-fbd3e80fd60e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57fdf78b-60a1-4b46-94ab-fbd3e80fd60e', 8, NULL, 'Ichigaya', 'November 25: Ichigaya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57fdf78b-60a1-4b46-94ab-fbd3e80fd60e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Award Montage', part.name_en = '1957: Award Montage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b8a8517c-4d9b-4531-a4a0-6e25ee148252' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8a8517c-4d9b-4531-a4a0-6e25ee148252', 9, NULL, 'Award Montage', '1957: Award Montage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8a8517c-4d9b-4531-a4a0-6e25ee148252'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Runaway Horses (“Poetry Written with a Splash of Blood”)', part.name_en = 'Runaway Horses (“Poetry Written with a Splash of Blood”)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:04846752-6f92-49e7-beeb-500c47e20da1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04846752-6f92-49e7-beeb-500c47e20da1', 10, NULL, 'Runaway Horses (“Poetry Written with a Splash of Blood”)', 'Runaway Horses (“Poetry Written with a Splash of Blood”)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04846752-6f92-49e7-beeb-500c47e20da1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Body Building', part.name_en = '1962: Body Building',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a55786e1-7dc8-4e42-8753-8ffdc9698e1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a55786e1-7dc8-4e42-8753-8ffdc9698e1d', 11, NULL, 'Body Building', '1962: Body Building', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a55786e1-7dc8-4e42-8753-8ffdc9698e1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'The Last Day', part.name_en = 'November 25: The Last Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f009d2b5-5449-4ca9-99f9-9e0423268709' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f009d2b5-5449-4ca9-99f9-9e0423268709', 12, NULL, 'The Last Day', 'November 25: The Last Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f009d2b5-5449-4ca9-99f9-9e0423268709'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Epilogue From Sun and Steel', part.name_en = 'F‐104: Epilogue From Sun and Steel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b52c02ca-c059-4fcb-8191-e92e3b5e8419' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b52c02ca-c059-4fcb-8191-e92e3b5e8419', 13, NULL, 'Epilogue From Sun and Steel', 'F‐104: Epilogue From Sun and Steel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b52c02ca-c059-4fcb-8191-e92e3b5e8419'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Mishima / Closing', part.name_en = 'Mishima / Closing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4b24b456-1b28-4f15-897c-38c743a891a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b24b456-1b28-4f15-897c-38c743a891a2', 14, NULL, 'Mishima / Closing', 'Mishima / Closing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b24b456-1b28-4f15-897c-38c743a891a2'
);


-- None Modern Love Waltz

UPDATE pieces piece
SET piece.title = 'Modern Love Waltz', piece.title_en = 'Modern Love Waltz',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10740 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Molly Is a Dreamer

UPDATE pieces piece
SET piece.title = 'Molly Is a Dreamer', piece.title_en = 'Molly Is a Dreamer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9852 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mon Père, Mon Père

UPDATE pieces piece
SET piece.title = 'Mon Père, Mon Père', piece.title_en = 'Mon Père, Mon Père',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9971 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Monsters of Grace>

UPDATE pieces piece
SET piece.title = '오페라 <Monsters of Grace>', piece.title_en = 'Monsters of Grace',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10286 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '"Where Everything is Music" from Monsters of Grace', part.name_en = 'Three Songs for Baritone & Piano: No. 3, "Where Everything is Music" from Monsters of Grace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10286 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0b509e36-53c9-41d9-8fdf-6c34f98b0f07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b509e36-53c9-41d9-8fdf-6c34f98b0f07', 1, NULL, '"Where Everything is Music" from Monsters of Grace', 'Three Songs for Baritone & Piano: No. 3, "Where Everything is Music" from Monsters of Grace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10286 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b509e36-53c9-41d9-8fdf-6c34f98b0f07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '"Let the Letter Read You" from Monsters of Grace', part.name_en = 'Three Songs for Baritone & Piano: No. 2, "Let the Letter Read You" from Monsters of Grace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10286 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:28a266e8-7830-4310-ad07-f25941ac4295' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28a266e8-7830-4310-ad07-f25941ac4295', 2, NULL, '"Let the Letter Read You" from Monsters of Grace', 'Three Songs for Baritone & Piano: No. 2, "Let the Letter Read You" from Monsters of Grace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10286 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28a266e8-7830-4310-ad07-f25941ac4295'
);


-- None Mr. Solares’ Picnic Lunch

UPDATE pieces piece
SET piece.title = 'Mr. Solares’ Picnic Lunch', piece.title_en = 'Mr. Solares’ Picnic Lunch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8739 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Music Box>

UPDATE pieces piece
SET piece.title = '가곡 <Music Box>', piece.title_en = 'Music Box',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8302 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music in Contrary Motion

UPDATE pieces piece
SET piece.title = 'Music in Contrary Motion', piece.title_en = 'Music in Contrary Motion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10268 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music in Fifths

UPDATE pieces piece
SET piece.title = 'Music in Fifths', piece.title_en = 'Music in Fifths',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10767 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music in Similar Motion

UPDATE pieces piece
SET piece.title = 'Music in Similar Motion', piece.title_en = 'Music in Similar Motion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10344 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music in Twelve Parts

UPDATE pieces piece
SET piece.title = 'Music in Twelve Parts', piece.title_en = 'Music in Twelve Parts',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10562 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Music in Twelve Parts: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:582cc423-67cd-4e6c-9931-6f80aa073b68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:582cc423-67cd-4e6c-9931-6f80aa073b68', 1, NULL, 'I', 'Music in Twelve Parts: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:582cc423-67cd-4e6c-9931-6f80aa073b68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Music in Twelve Parts: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:468bb1a7-6041-4e0a-910c-f9d7979fb6e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:468bb1a7-6041-4e0a-910c-f9d7979fb6e8', 2, NULL, 'II', 'Music in Twelve Parts: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:468bb1a7-6041-4e0a-910c-f9d7979fb6e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Music in Twelve Parts: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:be2688d0-5950-4be7-94f7-094bb69fee90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be2688d0-5950-4be7-94f7-094bb69fee90', 3, NULL, 'III', 'Music in Twelve Parts: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be2688d0-5950-4be7-94f7-094bb69fee90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Music in Twelve Parts: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6e4d0154-192d-4253-abe6-e340417889a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e4d0154-192d-4253-abe6-e340417889a6', 4, NULL, 'IV', 'Music in Twelve Parts: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e4d0154-192d-4253-abe6-e340417889a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Music in Twelve Parts: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c03f4e84-4c09-4ad9-9952-c2270e58ca4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c03f4e84-4c09-4ad9-9952-c2270e58ca4b', 5, NULL, 'V', 'Music in Twelve Parts: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c03f4e84-4c09-4ad9-9952-c2270e58ca4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Music in Twelve Parts: VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f32b169b-aa8d-4aac-b57c-a1cd22cfe8f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f32b169b-aa8d-4aac-b57c-a1cd22cfe8f3', 6, NULL, 'VI', 'Music in Twelve Parts: VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f32b169b-aa8d-4aac-b57c-a1cd22cfe8f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'VII', part.name_en = 'Music in Twelve Parts: VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f1df513e-7e79-48c9-af65-fa8db0e92f29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1df513e-7e79-48c9-af65-fa8db0e92f29', 7, NULL, 'VII', 'Music in Twelve Parts: VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1df513e-7e79-48c9-af65-fa8db0e92f29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'VIII', part.name_en = 'Music in Twelve Parts: VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9ddbab9c-383f-46de-88d2-85c2eb5715b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ddbab9c-383f-46de-88d2-85c2eb5715b5', 8, NULL, 'VIII', 'Music in Twelve Parts: VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ddbab9c-383f-46de-88d2-85c2eb5715b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'IX', part.name_en = 'Music in Twelve Parts: IX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5c3a8bb9-35e6-4410-8112-1eb57bf0bf2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c3a8bb9-35e6-4410-8112-1eb57bf0bf2a', 9, NULL, 'IX', 'Music in Twelve Parts: IX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c3a8bb9-35e6-4410-8112-1eb57bf0bf2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'X', part.name_en = 'Music in Twelve Parts: X',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:70b44209-bd68-4612-b52c-5e4892e76099' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70b44209-bd68-4612-b52c-5e4892e76099', 10, NULL, 'X', 'Music in Twelve Parts: X', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70b44209-bd68-4612-b52c-5e4892e76099'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'XI', part.name_en = 'Music in Twelve Parts: XI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:2d36be41-5833-4813-b92e-2e0732e2a0b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d36be41-5833-4813-b92e-2e0732e2a0b4', 11, NULL, 'XI', 'Music in Twelve Parts: XI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d36be41-5833-4813-b92e-2e0732e2a0b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'XII', part.name_en = 'Music in Twelve Parts: XII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10562 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:984fe61b-89ab-4dce-ac06-5c4926ae3379' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:984fe61b-89ab-4dce-ac06-5c4926ae3379', 12, NULL, 'XII', 'Music in Twelve Parts: XII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10562 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:984fe61b-89ab-4dce-ac06-5c4926ae3379'
);


-- None Music with Changing Parts

UPDATE pieces piece
SET piece.title = 'Music with Changing Parts', piece.title_en = 'Music with Changing Parts',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10666 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Neverwas Restored

UPDATE pieces piece
SET piece.title = 'Neverwas Restored', piece.title_en = 'Neverwas Restored',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8761 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None No More, You Petty Spirits

UPDATE pieces piece
SET piece.title = 'No More, You Petty Spirits', piece.title_en = 'No More, You Petty Spirits',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8810 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None No Second Chance

UPDATE pieces piece
SET piece.title = 'No Second Chance', piece.title_en = 'No Second Chance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10141 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Norman Morrison

UPDATE pieces piece
SET piece.title = 'Norman Morrison', piece.title_en = 'Norman Morrison',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8293 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None November 1, 1967

UPDATE pieces piece
SET piece.title = 'November 1, 1967', piece.title_en = 'November 1, 1967',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8289 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Novus Ordo Seclorum

UPDATE pieces piece
SET piece.title = 'Novus Ordo Seclorum', piece.title_en = 'Novus Ordo Seclorum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8414 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Off Planet, Part 1

UPDATE pieces piece
SET piece.title = 'Off Planet, Part 1', piece.title_en = 'Off Planet, Part 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11022 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Off Planet, Part 2

UPDATE pieces piece
SET piece.title = 'Off Planet, Part 2', piece.title_en = 'Off Planet, Part 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9616 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None On My Watch and Caught

UPDATE pieces piece
SET piece.title = 'On My Watch and Caught', piece.title_en = 'On My Watch and Caught',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9692 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One Plus One

UPDATE pieces piece
SET piece.title = 'One Plus One', piece.title_en = 'One Plus One',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9179 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opening Titles

UPDATE pieces piece
SET piece.title = 'Opening Titles', piece.title_en = 'Opening Titles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8928 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opportunity vs. Spirit

UPDATE pieces piece
SET piece.title = 'Opportunity vs. Spirit', piece.title_en = 'Opportunity vs. Spirit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7870 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Orbit

UPDATE pieces piece
SET piece.title = 'Orbit', piece.title_en = 'Orbit',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11003 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Origami Spacekraft

UPDATE pieces piece
SET piece.title = 'Origami Spacekraft', piece.title_en = 'Origami Spacekraft',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9231 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Orphée>

UPDATE pieces piece
SET piece.title = '오페라 <Orphée>', piece.title_en = 'Orphée',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8965 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Orphée: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30', 1, NULL, 'Act I', 'Orphée: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I. "le Café" (The Café)', part.name_en = 'Orphée: Act I, Scene I. "le Café" (The Café)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:68bac199-62c7-4c60-8ce8-ebd9a0b21924' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68bac199-62c7-4c60-8ce8-ebd9a0b21924', 1, NULL, 'Scene I. "le Café" (The Café)', 'Orphée: Act I, Scene I. "le Café" (The Café)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68bac199-62c7-4c60-8ce8-ebd9a0b21924'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II. "la Route" (The Road)', part.name_en = 'Orphée: Act I, Scene II. "la Route" (The Road)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b6772d8a-d1f1-4c62-aed2-54edb3eeb989' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6772d8a-d1f1-4c62-aed2-54edb3eeb989', 2, NULL, 'Scene II. "la Route" (The Road)', 'Orphée: Act I, Scene II. "la Route" (The Road)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6772d8a-d1f1-4c62-aed2-54edb3eeb989'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene III. "le Chalet" (The Chalet)', part.name_en = 'Orphée: Act I, Scene III. "le Chalet" (The Chalet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0d3086cc-0ff6-4595-b624-7589f12d877e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d3086cc-0ff6-4595-b624-7589f12d877e', 3, NULL, 'Scene III. "le Chalet" (The Chalet)', 'Orphée: Act I, Scene III. "le Chalet" (The Chalet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d3086cc-0ff6-4595-b624-7589f12d877e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene IV. "Chez Orphée" (Orphée''s House)', part.name_en = 'Orphée: Act I, Scene IV. "Chez Orphée" (Orphée''s House)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3bc8fee3-42e1-404a-9149-4b828324b39b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bc8fee3-42e1-404a-9149-4b828324b39b', 4, NULL, 'Scene IV. "Chez Orphée" (Orphée''s House)', 'Orphée: Act I, Scene IV. "Chez Orphée" (Orphée''s House)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bc8fee3-42e1-404a-9149-4b828324b39b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene V. "la Chambre d''Orphée" (Orphée''s Bedroom)', part.name_en = 'Orphée: Act I, Scene V. "la Chambre d''Orphée" (Orphée''s Bedroom)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b2a248ff-4a91-4903-b2a2-e057087287ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2a248ff-4a91-4903-b2a2-e057087287ff', 5, NULL, 'Scene V. "la Chambre d''Orphée" (Orphée''s Bedroom)', 'Orphée: Act I, Scene V. "la Chambre d''Orphée" (Orphée''s Bedroom)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a248ff-4a91-4903-b2a2-e057087287ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene VI. "le Studio d''Orphée" (Orphée''s Studio)', part.name_en = 'Orphée: Act I, Scene VI. "le Studio d''Orphée" (Orphée''s Studio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6c8a7c8f-1465-4553-845a-de6a1c5c335d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c8a7c8f-1465-4553-845a-de6a1c5c335d', 6, NULL, 'Scene VI. "le Studio d''Orphée" (Orphée''s Studio)', 'Orphée: Act I, Scene VI. "le Studio d''Orphée" (Orphée''s Studio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c8a7c8f-1465-4553-845a-de6a1c5c335d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene VII. "le Bureau du Commissaire" (Commissioner''s Office)', part.name_en = 'Orphée: Act I, Scene VII. "le Bureau du Commissaire" (Commissioner''s Office)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e2f4a5a0-2061-4695-95f2-4f198090a3d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e2f4a5a0-2061-4695-95f2-4f198090a3d9', 7, NULL, 'Scene VII. "le Bureau du Commissaire" (Commissioner''s Office)', 'Orphée: Act I, Scene VII. "le Bureau du Commissaire" (Commissioner''s Office)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2f4a5a0-2061-4695-95f2-4f198090a3d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene VIII. "la Poursuite" (The Chase)', part.name_en = 'Orphée: Act I, Scene VIII. "la Poursuite" (The Chase)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:78db362f-92ba-4914-a97b-a55da6ef9715' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78db362f-92ba-4914-a97b-a55da6ef9715', 8, NULL, 'Scene VIII. "la Poursuite" (The Chase)', 'Orphée: Act I, Scene VIII. "la Poursuite" (The Chase)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78db362f-92ba-4914-a97b-a55da6ef9715'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene IX. "Chez Orphée" (Orphée''s House)', part.name_en = 'Orphée: Act I, Scene IX. "Chez Orphée" (Orphée''s House)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8f674f16-4b47-4466-8cf8-477c061b02fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f674f16-4b47-4466-8cf8-477c061b02fe', 9, NULL, 'Scene IX. "Chez Orphée" (Orphée''s House)', 'Orphée: Act I, Scene IX. "Chez Orphée" (Orphée''s House)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81d3e6aa-0302-4582-8533-75dfd5b87d30'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f674f16-4b47-4466-8cf8-477c061b02fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Orphée: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7', 2, NULL, 'Act II', 'Orphée: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I. le Voyage aux Enfers (Journey to the Underworld)', part.name_en = 'Orphée: Act II, Scene I. le Voyage aux Enfers (Journey to the Underworld)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b23a0c3c-2fee-4c97-b6b9-54292214d816' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b23a0c3c-2fee-4c97-b6b9-54292214d816', 1, NULL, 'Scene I. le Voyage aux Enfers (Journey to the Underworld)', 'Orphée: Act II, Scene I. le Voyage aux Enfers (Journey to the Underworld)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b23a0c3c-2fee-4c97-b6b9-54292214d816'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II. le Procès (The Trial)', part.name_en = 'Orphée: Act II, Scene II. le Procès (The Trial)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:086fbe42-ab51-4498-803f-f98b336ee2e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:086fbe42-ab51-4498-803f-f98b336ee2e4', 2, NULL, 'Scene II. le Procès (The Trial)', 'Orphée: Act II, Scene II. le Procès (The Trial)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:086fbe42-ab51-4498-803f-f98b336ee2e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene III. Orphée et la Princesse (Orphée and the Princess)', part.name_en = 'Orphée: Act II, Scene III. Orphée et la Princesse (Orphée and the Princess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:22a564f2-7523-487d-a0a5-9db0d8c6d5c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22a564f2-7523-487d-a0a5-9db0d8c6d5c9', 3, NULL, 'Scene III. Orphée et la Princesse (Orphée and the Princess)', 'Orphée: Act II, Scene III. Orphée et la Princesse (Orphée and the Princess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22a564f2-7523-487d-a0a5-9db0d8c6d5c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene IV. le Verdict (The Verdict)', part.name_en = 'Orphée: Act II, Scene IV. le Verdict (The Verdict)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fde1bbf9-82c2-41ac-ba3d-b5ce44e71968' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fde1bbf9-82c2-41ac-ba3d-b5ce44e71968', 4, NULL, 'Scene IV. le Verdict (The Verdict)', 'Orphée: Act II, Scene IV. le Verdict (The Verdict)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fde1bbf9-82c2-41ac-ba3d-b5ce44e71968'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene V. Interlude Musicale - le Retour chez Orphée (Musical Interlude - Return to Orphée''s House)', part.name_en = 'Orphée: Act II, Scene V. Interlude Musicale - le Retour chez Orphée (Musical Interlude - Return to Orphée''s House)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d9c4b6f9-7909-4d11-b522-19683935a0b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9c4b6f9-7909-4d11-b522-19683935a0b7', 5, NULL, 'Scene V. Interlude Musicale - le Retour chez Orphée (Musical Interlude - Return to Orphée''s House)', 'Orphée: Act II, Scene V. Interlude Musicale - le Retour chez Orphée (Musical Interlude - Return to Orphée''s House)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9c4b6f9-7909-4d11-b522-19683935a0b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene VI. Chez Orphée (Orphée''s House)', part.name_en = 'Orphée: Act II, Scene VI. Chez Orphée (Orphée''s House)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a017a1fa-0f3a-4374-80df-f6b747e6f43b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a017a1fa-0f3a-4374-80df-f6b747e6f43b', 6, NULL, 'Scene VI. Chez Orphée (Orphée''s House)', 'Orphée: Act II, Scene VI. Chez Orphée (Orphée''s House)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a017a1fa-0f3a-4374-80df-f6b747e6f43b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene VII. le Studio d''Orphée (Orphée''s Studio)', part.name_en = 'Orphée: Act II, Scene VII. le Studio d''Orphée (Orphée''s Studio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f891d281-27d1-4b21-ae11-ee5e1a416650' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f891d281-27d1-4b21-ae11-ee5e1a416650', 7, NULL, 'Scene VII. le Studio d''Orphée (Orphée''s Studio)', 'Orphée: Act II, Scene VII. le Studio d''Orphée (Orphée''s Studio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f891d281-27d1-4b21-ae11-ee5e1a416650'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene VIII. le Retour d''Orphée (Orphée''s Return)', part.name_en = 'Orphée: Act II, Scene VIII. le Retour d''Orphée (Orphée''s Return)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:88cc20bb-0e2b-4193-a3a0-3355d5561438' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88cc20bb-0e2b-4193-a3a0-3355d5561438', 8, NULL, 'Scene VIII. le Retour d''Orphée (Orphée''s Return)', 'Orphée: Act II, Scene VIII. le Retour d''Orphée (Orphée''s Return)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88cc20bb-0e2b-4193-a3a0-3355d5561438'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene IX. la Chambre d''Orphée (Orphée''s Bedroom)', part.name_en = 'Orphée: Act II, Scene IX. la Chambre d''Orphée (Orphée''s Bedroom)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8965 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:370c2687-6055-4331-a5d4-9bc28d779804' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:370c2687-6055-4331-a5d4-9bc28d779804', 9, NULL, 'Scene IX. la Chambre d''Orphée (Orphée''s Bedroom)', 'Orphée: Act II, Scene IX. la Chambre d''Orphée (Orphée''s Bedroom)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6a3c4060-dc2b-4c9a-a2c9-f9cc12a3b6d7'
WHERE p.id = 8965 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:370c2687-6055-4331-a5d4-9bc28d779804'
);


-- None Ossipon is Tempted

UPDATE pieces piece
SET piece.title = 'Ossipon is Tempted', piece.title_en = 'Ossipon is Tempted',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9016 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Part IV (From Dressed Like an Egg)

UPDATE pieces piece
SET piece.title = 'Part IV (From Dressed Like an Egg)', piece.title_en = 'Part IV (From Dressed Like an Egg)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9259 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Part V (From Dressed Like an Egg)

UPDATE pieces piece
SET piece.title = 'Part V (From Dressed Like an Egg)', piece.title_en = 'Part V (From Dressed Like an Egg)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7938 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Partita for Solo Violin

UPDATE pieces piece
SET piece.title = 'Partita for Solo Violin', piece.title_en = 'Partita for Solo Violin',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9050 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Opening', part.name_en = 'Partita for Solo Violin: I. Opening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9050 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:77c907f3-058e-4ee1-a63c-0dcacc0435fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77c907f3-058e-4ee1-a63c-0dcacc0435fe', 1, 'I', 'Opening', 'Partita for Solo Violin: I. Opening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9050 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77c907f3-058e-4ee1-a63c-0dcacc0435fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dance 1', part.name_en = 'Partita for Solo Violin: II. Dance 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9050 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:df1f5a72-e467-4ffa-9f27-f950dc70e2c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df1f5a72-e467-4ffa-9f27-f950dc70e2c4', 2, 'II', 'Dance 1', 'Partita for Solo Violin: II. Dance 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9050 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df1f5a72-e467-4ffa-9f27-f950dc70e2c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chaconne, Part 1', part.name_en = 'Partita for Solo Violin: III. Chaconne, Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9050 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:26a693db-01e4-4e23-98b2-5a3e64c072c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26a693db-01e4-4e23-98b2-5a3e64c072c7', 3, 'III', 'Chaconne, Part 1', 'Partita for Solo Violin: III. Chaconne, Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9050 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26a693db-01e4-4e23-98b2-5a3e64c072c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Morning Song', part.name_en = 'Partita for Solo Violin: IV. Morning Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9050 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:99691cd7-6a79-40ef-ba85-74045e7d2dc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99691cd7-6a79-40ef-ba85-74045e7d2dc5', 4, 'IV', 'Morning Song', 'Partita for Solo Violin: IV. Morning Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9050 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99691cd7-6a79-40ef-ba85-74045e7d2dc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Chaconne, Part 2', part.name_en = 'Partita for Solo Violin: V. Chaconne, Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9050 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e7244c2e-090e-4e93-b5a8-36d4f887a2c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7244c2e-090e-4e93-b5a8-36d4f887a2c6', 5, 'V', 'Chaconne, Part 2', 'Partita for Solo Violin: V. Chaconne, Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9050 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7244c2e-090e-4e93-b5a8-36d4f887a2c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Dance 2', part.name_en = 'Partita for Solo Violin: VI. Dance 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9050 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a6b58887-4e8f-4f5d-88db-7342e46e2c17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6b58887-4e8f-4f5d-88db-7342e46e2c17', 6, 'VI', 'Dance 2', 'Partita for Solo Violin: VI. Dance 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9050 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6b58887-4e8f-4f5d-88db-7342e46e2c17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Evening Song', part.name_en = 'Partita for Solo Violin: VII. Evening Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9050 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9c28da3f-1055-45e6-b425-41ced0ca52ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c28da3f-1055-45e6-b425-41ced0ca52ec', 7, 'VII', 'Evening Song', 'Partita for Solo Violin: VII. Evening Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9050 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c28da3f-1055-45e6-b425-41ced0ca52ec'
);


-- None 파르티타 2번

UPDATE pieces piece
SET piece.title = '파르티타 2번', piece.title_en = 'Partita no. 2 for Solo Cello',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10850 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Partita no. 2 for Solo Cello: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10850 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ea93cc32-df0d-4899-8c35-fc3d39200840' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea93cc32-df0d-4899-8c35-fc3d39200840', 1, NULL, 'I', 'Partita no. 2 for Solo Cello: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10850 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea93cc32-df0d-4899-8c35-fc3d39200840'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Partita no. 2 for Solo Cello: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10850 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a616f719-e568-4690-9ddd-03dbc8619acf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a616f719-e568-4690-9ddd-03dbc8619acf', 2, NULL, 'II', 'Partita no. 2 for Solo Cello: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10850 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a616f719-e568-4690-9ddd-03dbc8619acf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Partita no. 2 for Solo Cello: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10850 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9e5181b8-ecf2-4e42-b6ad-b5d7fca7decb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e5181b8-ecf2-4e42-b6ad-b5d7fca7decb', 3, NULL, 'III', 'Partita no. 2 for Solo Cello: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10850 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e5181b8-ecf2-4e42-b6ad-b5d7fca7decb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Partita no. 2 for Solo Cello: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10850 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:04e149e9-0da3-4cda-a2ad-94eb71aa0de0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04e149e9-0da3-4cda-a2ad-94eb71aa0de0', 4, NULL, 'IV', 'Partita no. 2 for Solo Cello: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10850 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04e149e9-0da3-4cda-a2ad-94eb71aa0de0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Partita no. 2 for Solo Cello: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10850 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7d8fd079-458a-4ecb-a0d3-ab4e127ff101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d8fd079-458a-4ecb-a0d3-ab4e127ff101', 5, NULL, 'V', 'Partita no. 2 for Solo Cello: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10850 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d8fd079-458a-4ecb-a0d3-ab4e127ff101'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Partita no. 2 for Solo Cello: VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10850 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:96e0faa9-e010-4b6c-9fe1-d421ef4ae84c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96e0faa9-e010-4b6c-9fe1-d421ef4ae84c', 6, NULL, 'VI', 'Partita no. 2 for Solo Cello: VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10850 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96e0faa9-e010-4b6c-9fe1-d421ef4ae84c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'VII', part.name_en = 'Partita no. 2 for Solo Cello: VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10850 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6e76d39b-c013-4b5a-98d1-ee14d939cf2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e76d39b-c013-4b5a-98d1-ee14d939cf2c', 7, NULL, 'VII', 'Partita no. 2 for Solo Cello: VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10850 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e76d39b-c013-4b5a-98d1-ee14d939cf2c'
);


-- None Paul Sleepwalking

UPDATE pieces piece
SET piece.title = 'Paul Sleepwalking', piece.title_en = 'Paul Sleepwalking',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10460 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Perpetulum

UPDATE pieces piece
SET piece.title = 'Perpetulum', piece.title_en = 'Perpetulum',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8622 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part 1', part.name_en = 'Perpetulum: Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8622 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:07729fdf-df98-4fa9-aaf9-ac2de99e6f09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07729fdf-df98-4fa9-aaf9-ac2de99e6f09', 1, NULL, 'Part 1', 'Perpetulum: Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8622 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07729fdf-df98-4fa9-aaf9-ac2de99e6f09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part 2', part.name_en = 'Perpetulum: Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8622 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:723c94c2-a36f-41c4-a754-7e0ecce658e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:723c94c2-a36f-41c4-a754-7e0ecce658e0', 2, NULL, 'Part 2', 'Perpetulum: Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8622 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:723c94c2-a36f-41c4-a754-7e0ecce658e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Cadenza', part.name_en = 'Perpetulum: Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8622 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4db1fe86-4640-4ee4-80ba-94720b8e2332' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4db1fe86-4640-4ee4-80ba-94720b8e2332', 3, NULL, 'Cadenza', 'Perpetulum: Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8622 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4db1fe86-4640-4ee4-80ba-94720b8e2332'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part 3', part.name_en = 'Perpetulum: Part 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8622 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:405f877b-8b22-41da-8cc5-3a9a53db6fe7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:405f877b-8b22-41da-8cc5-3a9a53db6fe7', 4, NULL, 'Part 3', 'Perpetulum: Part 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8622 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:405f877b-8b22-41da-8cc5-3a9a53db6fe7'
);


-- None Persephone

UPDATE pieces piece
SET piece.title = 'Persephone', piece.title_en = 'Persephone',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7721 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Family', part.name_en = 'Persephone: I. Family',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7721 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a6e9d59d-4e08-41ed-8673-e11702d889b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6e9d59d-4e08-41ed-8673-e11702d889b9', 1, 'I', 'Family', 'Persephone: I. Family', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7721 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6e9d59d-4e08-41ed-8673-e11702d889b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Galatea', part.name_en = 'Persephone: II. Galatea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7721 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:166db2d0-2fbb-49c4-b7de-be11fc1cb098' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:166db2d0-2fbb-49c4-b7de-be11fc1cb098', 2, 'II', 'Galatea', 'Persephone: II. Galatea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7721 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:166db2d0-2fbb-49c4-b7de-be11fc1cb098'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Beds', part.name_en = 'Persephone: III. Beds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7721 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4f2e69fa-7b1d-4246-96d9-1a287186c9c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f2e69fa-7b1d-4246-96d9-1a287186c9c2', 3, 'III', 'Beds', 'Persephone: III. Beds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7721 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f2e69fa-7b1d-4246-96d9-1a287186c9c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Cocktail Party', part.name_en = 'Persephone: IV. Cocktail Party',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7721 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f7b130f3-627c-471b-8577-d46ae7d3e12c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7b130f3-627c-471b-8577-d46ae7d3e12c', 4, 'IV', 'Cocktail Party', 'Persephone: IV. Cocktail Party', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7721 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7b130f3-627c-471b-8577-d46ae7d3e12c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Perceval', part.name_en = 'Persephone: V. Perceval',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7721 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bc4125bd-7a9d-4268-9dbe-604375888c9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc4125bd-7a9d-4268-9dbe-604375888c9f', 5, 'V', 'Perceval', 'Persephone: V. Perceval', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7721 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc4125bd-7a9d-4268-9dbe-604375888c9f'
);


-- None 피아노 협주곡 3번

UPDATE pieces piece
SET piece.title = '피아노 협주곡 3번', piece.title_en = 'Piano Concerto no. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10321 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Movement I', part.name_en = 'Piano Concerto no. 3: Movement I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10321 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:322bc1a6-f2d3-4eda-9c61-4ecc5b13193c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:322bc1a6-f2d3-4eda-9c61-4ecc5b13193c', 1, NULL, 'Movement I', 'Piano Concerto no. 3: Movement I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10321 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:322bc1a6-f2d3-4eda-9c61-4ecc5b13193c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Movement II', part.name_en = 'Piano Concerto no. 3: Movement II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10321 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6f57613e-a1de-4090-bc13-f284b74802a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f57613e-a1de-4090-bc13-f284b74802a8', 2, NULL, 'Movement II', 'Piano Concerto no. 3: Movement II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10321 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f57613e-a1de-4090-bc13-f284b74802a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Movement III (for Arvo Pärt)', part.name_en = 'Piano Concerto no. 3: Movement III (for Arvo Pärt)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10321 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8dd1ed06-3ac1-4aff-915b-740a136dec15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dd1ed06-3ac1-4aff-915b-740a136dec15', 3, NULL, 'Movement III (for Arvo Pärt)', 'Piano Concerto no. 3: Movement III (for Arvo Pärt)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10321 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dd1ed06-3ac1-4aff-915b-740a136dec15'
);


-- None Piece in the Shape of a Square

UPDATE pieces piece
SET piece.title = 'Piece in the Shape of a Square', piece.title_en = 'Piece in the Shape of a Square',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8764 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Political Connections

UPDATE pieces piece
SET piece.title = 'Political Connections', piece.title_en = 'Political Connections',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11270 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude to Endgame

UPDATE pieces piece
SET piece.title = 'Prelude to Endgame', piece.title_en = 'Prelude to Endgame',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8292 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Private and Public

UPDATE pieces piece
SET piece.title = 'Private and Public', piece.title_en = 'Private and Public',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8160 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Remaining Silent Now

UPDATE pieces piece
SET piece.title = 'Remaining Silent Now', piece.title_en = 'Remaining Silent Now',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9010 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Return From Vietnam

UPDATE pieces piece
SET piece.title = 'Return From Vietnam', piece.title_en = 'Return From Vietnam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8808 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Return to Cabrini

UPDATE pieces piece
SET piece.title = 'Return to Cabrini', piece.title_en = 'Return to Cabrini',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7853 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Reverend's Walk

UPDATE pieces piece
SET piece.title = 'Reverend''s Walk', piece.title_en = 'Reverend''s Walk',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7874 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None River Run

UPDATE pieces piece
SET piece.title = 'River Run', piece.title_en = 'River Run',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10389 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Roast Beef

UPDATE pieces piece
SET piece.title = 'Roast Beef', piece.title_en = 'Roast Beef',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8288 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Robot Geologist

UPDATE pieces piece
SET piece.title = 'Robot Geologist', piece.title_en = 'Robot Geologist',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8068 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rolling Thunder

UPDATE pieces piece
SET piece.title = 'Rolling Thunder', piece.title_en = 'Rolling Thunder',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9115 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Running Away

UPDATE pieces piece
SET piece.title = 'Running Away', piece.title_en = 'Running Away',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8873 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Safe Journey

UPDATE pieces piece
SET piece.title = 'Safe Journey', piece.title_en = 'Safe Journey',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8499 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sailing

UPDATE pieces piece
SET piece.title = 'Sailing', piece.title_en = 'Sailing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10774 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sarabande in Common Time for Solo Violin

UPDATE pieces piece
SET piece.title = 'Sarabande in Common Time for Solo Violin', piece.title_en = 'Sarabande in Common Time for Solo Violin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8742 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Satyagraha>

UPDATE pieces piece
SET piece.title = '오페라 <Satyagraha>', piece.title_en = 'Satyagraha',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7821 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I, Scene I. On the Kuru Field of Justice', part.name_en = 'Satyagraha: Act I, Scene I. On the Kuru Field of Justice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7821 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:21a95b26-7855-4a3d-ac6b-5e1b1db3b048' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21a95b26-7855-4a3d-ac6b-5e1b1db3b048', 1, NULL, 'Act I, Scene I. On the Kuru Field of Justice', 'Satyagraha: Act I, Scene I. On the Kuru Field of Justice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7821 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21a95b26-7855-4a3d-ac6b-5e1b1db3b048'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II, Scene III. Protest (1908)', part.name_en = 'Satyagraha: Act II, Scene III. Protest (1908)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7821 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:27a75fee-f346-4adf-985a-207c17bc6618' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27a75fee-f346-4adf-985a-207c17bc6618', 2, NULL, 'Act II, Scene III. Protest (1908)', 'Satyagraha: Act II, Scene III. Protest (1908)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7821 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27a75fee-f346-4adf-985a-207c17bc6618'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I, Scene II. Tolstoy Farm (1910)', part.name_en = 'Satyagraha: Act I, Scene II. Tolstoy Farm (1910)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7821 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6949a84a-33bf-49c1-a8d1-cd75c7322154' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6949a84a-33bf-49c1-a8d1-cd75c7322154', 3, NULL, 'Act I, Scene II. Tolstoy Farm (1910)', 'Satyagraha: Act I, Scene II. Tolstoy Farm (1910)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7821 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6949a84a-33bf-49c1-a8d1-cd75c7322154'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II, Scene II. Indian Opinion (1906)', part.name_en = 'Satyagraha: Act II, Scene II. Indian Opinion (1906)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7821 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:72d4c0e1-d89d-44d2-90d4-a365f85054cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72d4c0e1-d89d-44d2-90d4-a365f85054cc', 4, NULL, 'Act II, Scene II. Indian Opinion (1906)', 'Satyagraha: Act II, Scene II. Indian Opinion (1906)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7821 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d4c0e1-d89d-44d2-90d4-a365f85054cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II, Scene I. Confrontation and Rescue (1896)', part.name_en = 'Satyagraha: Act II, Scene I. Confrontation and Rescue (1896)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7821 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7c8eb893-81a0-41ea-a5c4-e9f24b1ae53c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c8eb893-81a0-41ea-a5c4-e9f24b1ae53c', 5, NULL, 'Act II, Scene I. Confrontation and Rescue (1896)', 'Satyagraha: Act II, Scene I. Confrontation and Rescue (1896)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7821 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c8eb893-81a0-41ea-a5c4-e9f24b1ae53c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act III. New Castle March (1913)', part.name_en = 'Satyagraha: Act III. New Castle March (1913)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7821 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9b4d0a60-4d42-4757-a5e6-57cac6eacf1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b4d0a60-4d42-4757-a5e6-57cac6eacf1b', 6, NULL, 'Act III. New Castle March (1913)', 'Satyagraha: Act III. New Castle March (1913)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7821 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b4d0a60-4d42-4757-a5e6-57cac6eacf1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I, Scene III. The Vow (1906)', part.name_en = 'Satyagraha: Act I, Scene III. The Vow (1906)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7821 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b6cde4a6-8271-4a23-a901-71c972e2b242' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6cde4a6-8271-4a23-a901-71c972e2b242', 7, NULL, 'Act I, Scene III. The Vow (1906)', 'Satyagraha: Act I, Scene III. The Vow (1906)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7821 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6cde4a6-8271-4a23-a901-71c972e2b242'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act III. Conclusion', part.name_en = 'Satyagraha: Act III. Conclusion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7821 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f45083d5-9476-4cd2-b9fe-841d4892c2f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f45083d5-9476-4cd2-b9fe-841d4892c2f1', 8, NULL, 'Act III. Conclusion', 'Satyagraha: Act III. Conclusion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7821 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f45083d5-9476-4cd2-b9fe-841d4892c2f1'
);


-- None Saxophone Quartet

UPDATE pieces piece
SET piece.title = 'Saxophone Quartet', piece.title_en = 'Saxophone Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8905 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'IV',
    part.name_ko = '-', part.name_en = 'Saxophone Quartet: IV. -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8905 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:57ef32cb-3024-4213-9703-8a9da78ebec1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57ef32cb-3024-4213-9703-8a9da78ebec1', 1, 'IV', '-', 'Saxophone Quartet: IV. -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8905 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57ef32cb-3024-4213-9703-8a9da78ebec1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '-', part.name_en = 'Saxophone Quartet: II. -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8905 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7e936b37-75c8-4749-8fc0-0c38b6f89425' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e936b37-75c8-4749-8fc0-0c38b6f89425', 2, 'II', '-', 'Saxophone Quartet: II. -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8905 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e936b37-75c8-4749-8fc0-0c38b6f89425'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = '-', part.name_en = 'Saxophone Quartet: I. -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8905 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7f55ebd1-2897-48ff-8a15-7b0029cf1aa0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f55ebd1-2897-48ff-8a15-7b0029cf1aa0', 3, 'I', '-', 'Saxophone Quartet: I. -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8905 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f55ebd1-2897-48ff-8a15-7b0029cf1aa0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'III',
    part.name_ko = '-', part.name_en = 'Saxophone Quartet: III. -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8905 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c0929aea-e16e-4d82-9c31-e7ef66dce904' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0929aea-e16e-4d82-9c31-e7ef66dce904', 4, 'III', '-', 'Saxophone Quartet: III. -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8905 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0929aea-e16e-4d82-9c31-e7ef66dce904'
);


-- None Second Perception of Light, Moon, Mist, and Rainbow

UPDATE pieces piece
SET piece.title = 'Second Perception of Light, Moon, Mist, and Rainbow', piece.title_en = 'Second Perception of Light, Moon, Mist, and Rainbow',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10007 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Secret Agent

UPDATE pieces piece
SET piece.title = 'Secret Agent', piece.title_en = 'Secret Agent',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9581 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Secret Agent Ending

UPDATE pieces piece
SET piece.title = 'Secret Agent Ending', piece.title_en = 'Secret Agent Ending',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8208 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sediments

UPDATE pieces piece
SET piece.title = 'Sediments', piece.title_en = 'Sediments',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8794 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sheba & Steven

UPDATE pieces piece
SET piece.title = 'Sheba & Steven', piece.title_en = 'Sheba & Steven',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10176 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sheba’s Longing

UPDATE pieces piece
SET piece.title = 'Sheba’s Longing', piece.title_en = 'Sheba’s Longing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8969 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Shipyard

UPDATE pieces piece
SET piece.title = 'Shipyard', piece.title_en = 'Shipyard',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10587 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Simple

UPDATE pieces piece
SET piece.title = 'Simple', piece.title_en = 'Simple',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11079 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Snow Falling in the Playground

UPDATE pieces piece
SET piece.title = 'Snow Falling in the Playground', piece.title_en = 'Snow Falling in the Playground',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9802 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Snowing

UPDATE pieces piece
SET piece.title = 'Snowing', piece.title_en = 'Snowing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11239 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None So Much of Our Hopes

UPDATE pieces piece
SET piece.title = 'So Much of Our Hopes', piece.title_en = 'So Much of Our Hopes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9261 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Someone Has Died

UPDATE pieces piece
SET piece.title = 'Someone Has Died', piece.title_en = 'Someone Has Died',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10186 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Someone in Your Garden

UPDATE pieces piece
SET piece.title = 'Someone in Your Garden', piece.title_en = 'Someone in Your Garden',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8972 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Songs and Poems for Solo Cello

UPDATE pieces piece
SET piece.title = 'Songs and Poems for Solo Cello', piece.title_en = 'Songs and Poems for Solo Cello',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9355 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Song I', part.name_en = 'Songs and Poems for Solo Cello: Song I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9355 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:24fb394f-97f1-3658-9ef4-bd583d61380c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24fb394f-97f1-3658-9ef4-bd583d61380c', 1, NULL, 'Song I', 'Songs and Poems for Solo Cello: Song I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9355 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24fb394f-97f1-3658-9ef4-bd583d61380c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Song II', part.name_en = 'Songs and Poems for Solo Cello: Song II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9355 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c6b0904f-490d-36d2-9793-4bb0aad37660' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6b0904f-490d-36d2-9793-4bb0aad37660', 2, NULL, 'Song II', 'Songs and Poems for Solo Cello: Song II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9355 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6b0904f-490d-36d2-9793-4bb0aad37660'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Song III', part.name_en = 'Songs and Poems for Solo Cello: Song III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9355 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8bca7aba-1dc0-3521-aa4d-1d15b894e738' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bca7aba-1dc0-3521-aa4d-1d15b894e738', 3, NULL, 'Song III', 'Songs and Poems for Solo Cello: Song III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9355 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bca7aba-1dc0-3521-aa4d-1d15b894e738'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Song IV', part.name_en = 'Songs and Poems for Solo Cello: Song IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9355 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bddc52da-1cec-386c-bd2c-4a6c0e2b03d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bddc52da-1cec-386c-bd2c-4a6c0e2b03d3', 4, NULL, 'Song IV', 'Songs and Poems for Solo Cello: Song IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9355 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bddc52da-1cec-386c-bd2c-4a6c0e2b03d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Song V', part.name_en = 'Songs and Poems for Solo Cello: Song V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9355 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:46651345-dee0-364a-aa63-7f61e81a156a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46651345-dee0-364a-aa63-7f61e81a156a', 5, NULL, 'Song V', 'Songs and Poems for Solo Cello: Song V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9355 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46651345-dee0-364a-aa63-7f61e81a156a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Song VI', part.name_en = 'Songs and Poems for Solo Cello: Song VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9355 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:42cb7ead-2bb0-3ee0-8944-5d23841c3221' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42cb7ead-2bb0-3ee0-8944-5d23841c3221', 6, NULL, 'Song VI', 'Songs and Poems for Solo Cello: Song VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9355 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42cb7ead-2bb0-3ee0-8944-5d23841c3221'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Song VII', part.name_en = 'Songs and Poems for Solo Cello: Song VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9355 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:92e389ee-f3c0-3f68-bea9-e4890b50e3d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92e389ee-f3c0-3f68-bea9-e4890b50e3d0', 7, NULL, 'Song VII', 'Songs and Poems for Solo Cello: Song VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9355 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92e389ee-f3c0-3f68-bea9-e4890b50e3d0'
);


-- None Songs of Milarepa

UPDATE pieces piece
SET piece.title = 'Songs of Milarepa', piece.title_en = 'Songs of Milarepa',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10427 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I Am the Man Called Milarepa', part.name_en = 'Songs of Milarepa: No. 1, I Am the Man Called Milarepa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10427 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:11ab8501-392a-4dad-bfb1-4ddf971219d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11ab8501-392a-4dad-bfb1-4ddf971219d2', 1, NULL, 'I Am the Man Called Milarepa', 'Songs of Milarepa: No. 1, I Am the Man Called Milarepa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10427 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ab8501-392a-4dad-bfb1-4ddf971219d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Song of the Five Sisters', part.name_en = 'Songs of Milarepa: No. 3, Song of the Five Sisters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10427 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:56174e1b-43dd-42e5-9f13-183f566ca6d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56174e1b-43dd-42e5-9f13-183f566ca6d9', 2, NULL, 'Song of the Five Sisters', 'Songs of Milarepa: No. 3, Song of the Five Sisters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10427 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56174e1b-43dd-42e5-9f13-183f566ca6d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Song of the White Staff', part.name_en = 'Songs of Milarepa: No. 2, Song of the White Staff',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10427 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:dc9df535-688a-47bc-9ced-77c5614abf1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc9df535-688a-47bc-9ced-77c5614abf1c', 3, NULL, 'Song of the White Staff', 'Songs of Milarepa: No. 2, Song of the White Staff', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10427 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc9df535-688a-47bc-9ced-77c5614abf1c'
);


-- None Spirit and Opportunity

UPDATE pieces piece
SET piece.title = 'Spirit and Opportunity', piece.title_en = 'Spirit and Opportunity',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9929 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stalking

UPDATE pieces piece
SET piece.title = 'Stalking', piece.title_en = 'Stalking',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11201 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Statistical Control

UPDATE pieces piece
SET piece.title = 'Statistical Control', piece.title_en = 'Statistical Control',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7816 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 1번

UPDATE pieces piece
SET piece.title = '현악 4중주 1번', piece.title_en = 'String Quartet no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8778 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Part One', part.name_en = 'String Quartet no. 1: I. Part One',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8778 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c0eab37e-b7af-40ed-8773-efcd5af8ffc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0eab37e-b7af-40ed-8773-efcd5af8ffc1', 1, 'I', 'Part One', 'String Quartet no. 1: I. Part One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8778 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0eab37e-b7af-40ed-8773-efcd5af8ffc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ambient Pause', part.name_en = 'String Quartet no. 1: II. Ambient Pause',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8778 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:60827c02-8c63-4a27-9d8c-5e8556842d39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60827c02-8c63-4a27-9d8c-5e8556842d39', 2, 'II', 'Ambient Pause', 'String Quartet no. 1: II. Ambient Pause', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8778 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60827c02-8c63-4a27-9d8c-5e8556842d39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Part Two', part.name_en = 'String Quartet no. 1: III. Part Two',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8778 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fed5a830-81d8-41f4-861e-ec09e2891c8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fed5a830-81d8-41f4-861e-ec09e2891c8f', 3, 'III', 'Part Two', 'String Quartet no. 1: III. Part Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8778 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fed5a830-81d8-41f4-861e-ec09e2891c8f'
);


-- None 현악 4중주 2번 "Company"

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 "Company"', piece.title_en = 'String Quartet no. 2 “Company”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8712 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'String Quartet no. 2 "Company": I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8712 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:29c6daab-2a87-4aec-bb7f-b830e46be84e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29c6daab-2a87-4aec-bb7f-b830e46be84e', 1, NULL, 'I', 'String Quartet no. 2 "Company": I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8712 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29c6daab-2a87-4aec-bb7f-b830e46be84e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'String Quartet no. 2 "Company": II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8712 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:465a979d-842a-40fb-a012-4b0848b1689e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:465a979d-842a-40fb-a012-4b0848b1689e', 2, NULL, 'II', 'String Quartet no. 2 "Company": II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8712 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:465a979d-842a-40fb-a012-4b0848b1689e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'String Quartet no. 2 "Company": III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8712 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a980620e-8c86-41af-a29e-3e2cb19fd731' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a980620e-8c86-41af-a29e-3e2cb19fd731', 3, NULL, 'III', 'String Quartet no. 2 "Company": III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8712 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a980620e-8c86-41af-a29e-3e2cb19fd731'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'String Quartet no. 2 "Company": IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8712 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:28829ca7-b50c-46b5-a84e-95d346d323c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28829ca7-b50c-46b5-a84e-95d346d323c2', 4, NULL, 'IV', 'String Quartet no. 2 "Company": IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8712 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28829ca7-b50c-46b5-a84e-95d346d323c2'
);


-- None 현악 4중주 3번 "Mishima"

UPDATE pieces piece
SET piece.title = '현악 4중주 3번 "Mishima"', piece.title_en = 'String Quartet no. 3 “Mishima”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9384 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Award Montage', part.name_en = 'String Quartet no. 3 "Mishima": I. 1957. Award Montage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9384 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e85a7a9b-e8f0-4545-aaae-eb3cc0b7ced7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e85a7a9b-e8f0-4545-aaae-eb3cc0b7ced7', 1, 'I', 'Award Montage', 'String Quartet no. 3 "Mishima": I. 1957. Award Montage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9384 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e85a7a9b-e8f0-4545-aaae-eb3cc0b7ced7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'November 25. Ichigaya', part.name_en = 'String Quartet no. 3 "Mishima": II. November 25. Ichigaya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9384 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:feb854b2-44f5-47f5-a242-f60f4cd84d22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feb854b2-44f5-47f5-a242-f60f4cd84d22', 2, 'II', 'November 25. Ichigaya', 'String Quartet no. 3 "Mishima": II. November 25. Ichigaya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9384 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feb854b2-44f5-47f5-a242-f60f4cd84d22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Grandmother and Kimitake', part.name_en = 'String Quartet no. 3 "Mishima": III. 1934. Grandmother and Kimitake',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9384 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:73b81c99-ca4c-4c2e-995f-96b099a7c118' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73b81c99-ca4c-4c2e-995f-96b099a7c118', 3, 'III', 'Grandmother and Kimitake', 'String Quartet no. 3 "Mishima": III. 1934. Grandmother and Kimitake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9384 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73b81c99-ca4c-4c2e-995f-96b099a7c118'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Body Building', part.name_en = 'String Quartet no. 3 "Mishima": IV. 1962. Body Building',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9384 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d5bfce3d-0178-4a06-af8b-a570ce39b63e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5bfce3d-0178-4a06-af8b-a570ce39b63e', 4, 'IV', 'Body Building', 'String Quartet no. 3 "Mishima": IV. 1962. Body Building', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9384 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5bfce3d-0178-4a06-af8b-a570ce39b63e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Blood Oath', part.name_en = 'String Quartet no. 3 "Mishima": V. Blood Oath',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9384 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6fad2848-430a-4fd2-8d61-320765179d13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fad2848-430a-4fd2-8d61-320765179d13', 5, 'V', 'Blood Oath', 'String Quartet no. 3 "Mishima": V. Blood Oath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9384 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fad2848-430a-4fd2-8d61-320765179d13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Mishima/Closing', part.name_en = 'String Quartet no. 3 "Mishima": VI. Mishima/Closing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9384 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5d023769-8c70-480b-8059-cf93efd99ab5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d023769-8c70-480b-8059-cf93efd99ab5', 6, 'VI', 'Mishima/Closing', 'String Quartet no. 3 "Mishima": VI. Mishima/Closing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9384 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d023769-8c70-480b-8059-cf93efd99ab5'
);


-- None 현악 4중주 4번 "Buczak"

UPDATE pieces piece
SET piece.title = '현악 4중주 4번 "Buczak"', piece.title_en = 'String Quartet no. 4 “Buczak”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9022 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'String Quartet no. 4 "Buczak": I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9022 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:871fe990-8cd3-4911-b691-8af95fc2fa73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:871fe990-8cd3-4911-b691-8af95fc2fa73', 1, NULL, 'I', 'String Quartet no. 4 "Buczak": I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9022 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:871fe990-8cd3-4911-b691-8af95fc2fa73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'String Quartet no. 4 "Buczak": II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9022 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e76cc71b-178d-4d2b-b05d-96a73e2e316a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e76cc71b-178d-4d2b-b05d-96a73e2e316a', 2, NULL, 'II', 'String Quartet no. 4 "Buczak": II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9022 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e76cc71b-178d-4d2b-b05d-96a73e2e316a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'String Quartet no. 4 "Buczak": III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9022 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:079da588-1541-4741-8c7c-6900f4319eb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:079da588-1541-4741-8c7c-6900f4319eb4', 3, NULL, 'III', 'String Quartet no. 4 "Buczak": III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9022 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:079da588-1541-4741-8c7c-6900f4319eb4'
);


-- None 현악 4중주 6번

UPDATE pieces piece
SET piece.title = '현악 4중주 6번', piece.title_en = 'String Quartet no. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9733 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'String Quartet no. 6: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a577b8ec-deed-4b03-9631-a10309d8adf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a577b8ec-deed-4b03-9631-a10309d8adf8', 1, NULL, 'I', 'String Quartet no. 6: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a577b8ec-deed-4b03-9631-a10309d8adf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'String Quartet no. 6: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:21509dc1-0d28-4b95-89cd-c21a285aaced' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21509dc1-0d28-4b95-89cd-c21a285aaced', 2, NULL, 'II', 'String Quartet no. 6: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21509dc1-0d28-4b95-89cd-c21a285aaced'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'String Quartet no. 6: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9733 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:13466a06-7ab8-4021-9ff6-a526a31a42da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13466a06-7ab8-4021-9ff6-a526a31a42da', 3, NULL, 'III', 'String Quartet no. 6: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9733 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13466a06-7ab8-4021-9ff6-a526a31a42da'
);


-- None 현악 4중주 7번

UPDATE pieces piece
SET piece.title = '현악 4중주 7번', piece.title_en = 'String Quartet no. 7',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8313 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Strung Out

UPDATE pieces piece
SET piece.title = 'Strung Out', piece.title_en = 'Strung Out',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9977 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Success

UPDATE pieces piece
SET piece.title = 'Success', piece.title_en = 'Success',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11021 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 12번 "Lodger"

UPDATE pieces piece
SET piece.title = '교향곡 12번 "Lodger"', piece.title_en = 'Symphony No. 12 "Lodger"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8781 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'African Night Flight', part.name_en = 'Symphony No. 12 "Lodger": III. African Night Flight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:673765a3-b8f2-47c7-b24c-4886358d7ef3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:673765a3-b8f2-47c7-b24c-4886358d7ef3', 1, 'III', 'African Night Flight', 'Symphony No. 12 "Lodger": III. African Night Flight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:673765a3-b8f2-47c7-b24c-4886358d7ef3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'IV',
    part.name_ko = 'Boys Keep Swinging', part.name_en = 'Symphony No. 12 "Lodger": IV. Boys Keep Swinging',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:68ea3d5b-ff53-4079-b522-05ca0a7a35ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68ea3d5b-ff53-4079-b522-05ca0a7a35ca', 2, 'IV', 'Boys Keep Swinging', 'Symphony No. 12 "Lodger": IV. Boys Keep Swinging', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68ea3d5b-ff53-4079-b522-05ca0a7a35ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'VI',
    part.name_ko = 'Repetition', part.name_en = 'Symphony No. 12 "Lodger": VI. Repetition',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b3ec2bf3-5443-4235-bd96-d84ecc61402a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3ec2bf3-5443-4235-bd96-d84ecc61402a', 3, 'VI', 'Repetition', 'Symphony No. 12 "Lodger": VI. Repetition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3ec2bf3-5443-4235-bd96-d84ecc61402a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'V',
    part.name_ko = 'Yassassin', part.name_en = 'Symphony No. 12 "Lodger": V. Yassassin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c4be9473-aecc-4261-b968-74e0707222e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4be9473-aecc-4261-b968-74e0707222e9', 4, 'V', 'Yassassin', 'Symphony No. 12 "Lodger": V. Yassassin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4be9473-aecc-4261-b968-74e0707222e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VII',
    part.name_ko = 'Red Sails', part.name_en = 'Symphony No. 12 "Lodger": VII. Red Sails',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d8b5dd56-73de-40ac-87fa-16c322219851' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8b5dd56-73de-40ac-87fa-16c322219851', 5, 'VII', 'Red Sails', 'Symphony No. 12 "Lodger": VII. Red Sails', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b5dd56-73de-40ac-87fa-16c322219851'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'II',
    part.name_ko = 'Move On', part.name_en = 'Symphony No. 12 "Lodger": II. Move On',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ed953cab-cc78-4ca4-9371-d1c68bc038d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed953cab-cc78-4ca4-9371-d1c68bc038d7', 6, 'II', 'Move On', 'Symphony No. 12 "Lodger": II. Move On', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed953cab-cc78-4ca4-9371-d1c68bc038d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'I',
    part.name_ko = 'Fantastic Voyage', part.name_en = 'Symphony No. 12 "Lodger": I. Fantastic Voyage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8781 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:eed29761-ab9f-42ee-a5eb-de228870e985' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eed29761-ab9f-42ee-a5eb-de228870e985', 7, 'I', 'Fantastic Voyage', 'Symphony No. 12 "Lodger": I. Fantastic Voyage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8781 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eed29761-ab9f-42ee-a5eb-de228870e985'
);


-- None 교향곡 14번 "Liechtenstein"

UPDATE pieces piece
SET piece.title = '교향곡 14번 "Liechtenstein"', piece.title_en = 'Symphony No. 14, "Liechtenstein"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9226 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Movement I', part.name_en = 'Symphony No. 14, "Liechtenstein": Movement I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9226 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:15addad6-1497-442f-a75e-86a57d7515b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15addad6-1497-442f-a75e-86a57d7515b7', 1, NULL, 'Movement I', 'Symphony No. 14, "Liechtenstein": Movement I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9226 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15addad6-1497-442f-a75e-86a57d7515b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Movement III', part.name_en = 'Symphony No. 14, "Liechtenstein": Movement III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9226 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:78b57f57-441e-4a16-a7cf-93b3391a7c72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78b57f57-441e-4a16-a7cf-93b3391a7c72', 2, NULL, 'Movement III', 'Symphony No. 14, "Liechtenstein": Movement III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9226 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78b57f57-441e-4a16-a7cf-93b3391a7c72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Movement II', part.name_en = 'Symphony No. 14, "Liechtenstein": Movement II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9226 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9fb197cb-d358-47bc-909a-11e932ab9518' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fb197cb-d358-47bc-909a-11e932ab9518', 3, NULL, 'Movement II', 'Symphony No. 14, "Liechtenstein": Movement II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9226 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fb197cb-d358-47bc-909a-11e932ab9518'
);


-- None 교향곡 1번 "Low"

UPDATE pieces piece
SET piece.title = '교향곡 1번 "Low"', piece.title_en = 'Symphony no. 1 “Low”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8432 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 10번

UPDATE pieces piece
SET piece.title = '교향곡 10번', piece.title_en = 'Symphony no. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11102 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Symphony no. 10: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11102 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8692c12c-2bb9-4e93-a222-4e93944ce84e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8692c12c-2bb9-4e93-a222-4e93944ce84e', 1, NULL, 'I', 'Symphony no. 10: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11102 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8692c12c-2bb9-4e93-a222-4e93944ce84e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Symphony no. 10: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11102 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:040c9dfa-fc4a-4d10-a57d-8d5bcdd45ff3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:040c9dfa-fc4a-4d10-a57d-8d5bcdd45ff3', 2, NULL, 'II', 'Symphony no. 10: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11102 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:040c9dfa-fc4a-4d10-a57d-8d5bcdd45ff3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Symphony no. 10: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11102 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:eab51e4f-125f-4d60-bf8c-3f3a7805dd08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eab51e4f-125f-4d60-bf8c-3f3a7805dd08', 3, NULL, 'III', 'Symphony no. 10: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11102 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eab51e4f-125f-4d60-bf8c-3f3a7805dd08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Symphony no. 10: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11102 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:327becdd-f0f6-4536-b028-ddc3f1442c65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:327becdd-f0f6-4536-b028-ddc3f1442c65', 4, NULL, 'IV', 'Symphony no. 10: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11102 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:327becdd-f0f6-4536-b028-ddc3f1442c65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Symphony no. 10: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11102 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d1c21745-de23-4152-8f39-306a86e3836c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c21745-de23-4152-8f39-306a86e3836c', 5, NULL, 'V', 'Symphony no. 10: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11102 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c21745-de23-4152-8f39-306a86e3836c'
);


-- None 교향곡 2번

UPDATE pieces piece
SET piece.title = '교향곡 2번', piece.title_en = 'Symphony no. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9561 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Symphony no. 2: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9561 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9ec4230e-a906-488a-ba59-b351455b575b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ec4230e-a906-488a-ba59-b351455b575b', 1, NULL, 'I', 'Symphony no. 2: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9561 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ec4230e-a906-488a-ba59-b351455b575b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Symphony no. 2: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9561 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:671f6621-20fd-4613-af7b-fd78ab3dc489' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:671f6621-20fd-4613-af7b-fd78ab3dc489', 2, NULL, 'II', 'Symphony no. 2: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9561 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:671f6621-20fd-4613-af7b-fd78ab3dc489'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Symphony no. 2: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9561 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7cb9016d-a725-48a1-ab25-f2961d54dc34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cb9016d-a725-48a1-ab25-f2961d54dc34', 3, NULL, 'III', 'Symphony no. 2: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9561 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cb9016d-a725-48a1-ab25-f2961d54dc34'
);


-- None 교향곡 3번

UPDATE pieces piece
SET piece.title = '교향곡 3번', piece.title_en = 'Symphony no. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10629 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Symphony no. 3: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10629 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f21b9fd7-38e2-4790-a50d-4024828f1e70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f21b9fd7-38e2-4790-a50d-4024828f1e70', 1, NULL, 'I', 'Symphony no. 3: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10629 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21b9fd7-38e2-4790-a50d-4024828f1e70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Symphony no. 3: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10629 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0fa56ba0-68e3-4eb7-bedb-e2216fae05ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fa56ba0-68e3-4eb7-bedb-e2216fae05ff', 2, NULL, 'II', 'Symphony no. 3: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10629 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fa56ba0-68e3-4eb7-bedb-e2216fae05ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Symphony no. 3: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10629 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:731e2230-107f-4f3b-847f-2a2c534c2bce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:731e2230-107f-4f3b-847f-2a2c534c2bce', 3, NULL, 'III', 'Symphony no. 3: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10629 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:731e2230-107f-4f3b-847f-2a2c534c2bce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Symphony no. 3: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10629 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:67461669-78e3-408a-8805-9067a2030e31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67461669-78e3-408a-8805-9067a2030e31', 4, NULL, 'IV', 'Symphony no. 3: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10629 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67461669-78e3-408a-8805-9067a2030e31'
);


-- None 교향곡 4번 "Heroes"

UPDATE pieces piece
SET piece.title = '교향곡 4번 "Heroes"', piece.title_en = 'Symphony no. 4 "Heroes"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9539 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 교향곡 5번 "Requiem, Bardo, Nirmanakaya"

UPDATE pieces piece
SET piece.title = '교향곡 5번 "Requiem, Bardo, Nirmanakaya"', piece.title_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10377 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Before the Creation', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: I. Before the Creation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4cec6129-e161-48b1-afef-d4d87afdacee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cec6129-e161-48b1-afef-d4d87afdacee', 1, 'I', 'Before the Creation', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: I. Before the Creation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cec6129-e161-48b1-afef-d4d87afdacee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Creation of the Cosmos', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: II. Creation of the Cosmos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:506002ce-37c2-42f9-9b51-eea9739341db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:506002ce-37c2-42f9-9b51-eea9739341db', 2, 'II', 'Creation of the Cosmos', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: II. Creation of the Cosmos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:506002ce-37c2-42f9-9b51-eea9739341db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Creation of the Sentient Beings', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: III. Creation of the Sentient Beings',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bca758db-09a7-494a-a392-fddde00b4ab7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bca758db-09a7-494a-a392-fddde00b4ab7', 3, 'III', 'Creation of the Sentient Beings', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: III. Creation of the Sentient Beings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bca758db-09a7-494a-a392-fddde00b4ab7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Creation of Human Beings', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: IV. Creation of Human Beings',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b76fc47a-40b7-40a3-b0b8-667e66d17009' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b76fc47a-40b7-40a3-b0b8-667e66d17009', 4, 'IV', 'Creation of Human Beings', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: IV. Creation of Human Beings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b76fc47a-40b7-40a3-b0b8-667e66d17009'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Love and Joy', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: V. Love and Joy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:980b206d-3170-4bdc-ad06-57b8f9cd8f3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:980b206d-3170-4bdc-ad06-57b8f9cd8f3e', 5, 'V', 'Love and Joy', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: V. Love and Joy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:980b206d-3170-4bdc-ad06-57b8f9cd8f3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Evil and Ignorance', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: VI. Evil and Ignorance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:451a12a9-f224-43f5-86f1-084d300c55b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:451a12a9-f224-43f5-86f1-084d300c55b5', 6, 'VI', 'Evil and Ignorance', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: VI. Evil and Ignorance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:451a12a9-f224-43f5-86f1-084d300c55b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Suffering', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: VII. Suffering',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:41ff21ef-5e19-42f3-b3bb-6b544c0b5a45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ff21ef-5e19-42f3-b3bb-6b544c0b5a45', 7, 'VII', 'Suffering', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: VII. Suffering', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ff21ef-5e19-42f3-b3bb-6b544c0b5a45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Compassion', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: VIII. Compassion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:13098d5b-484d-4c37-a8d0-43ca2e08e12f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13098d5b-484d-4c37-a8d0-43ca2e08e12f', 8, 'VIII', 'Compassion', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: VIII. Compassion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13098d5b-484d-4c37-a8d0-43ca2e08e12f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Death', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: IX. Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:af384117-b62d-4b51-829e-3d5f82c260bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af384117-b62d-4b51-829e-3d5f82c260bc', 9, 'IX', 'Death', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: IX. Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af384117-b62d-4b51-829e-3d5f82c260bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Judgment and Apocalypse', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: X. Judgment and Apocalypse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:56fc1165-419f-4aaa-b85f-8cd84f242838' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56fc1165-419f-4aaa-b85f-8cd84f242838', 10, 'X', 'Judgment and Apocalypse', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: X. Judgment and Apocalypse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56fc1165-419f-4aaa-b85f-8cd84f242838'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Paradise', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: XI. Paradise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:dfc4487d-ead2-48a9-8193-6d17530de0e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfc4487d-ead2-48a9-8193-6d17530de0e6', 11, 'XI', 'Paradise', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: XI. Paradise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfc4487d-ead2-48a9-8193-6d17530de0e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Dedication of Merit', part.name_en = 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: XII. Dedication of Merit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10377 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:25f126a7-9e83-4b7f-b0d8-0a48149b578e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25f126a7-9e83-4b7f-b0d8-0a48149b578e', 12, 'XII', 'Dedication of Merit', 'Symphony no. 5 “Requiem, Bardo, Nirmanakaya”: XII. Dedication of Merit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10377 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25f126a7-9e83-4b7f-b0d8-0a48149b578e'
);


-- None 교향곡 6번 "Plutonian Ode"

UPDATE pieces piece
SET piece.title = '교향곡 6번 "Plutonian Ode"', piece.title_en = 'Symphony no. 6 “Plutonian Ode”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9764 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Symphony no. 6 “Plutonian Ode”: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9764 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e26dd6f9-7e4e-4953-beee-05d01b600ceb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e26dd6f9-7e4e-4953-beee-05d01b600ceb', 1, NULL, 'I', 'Symphony no. 6 “Plutonian Ode”: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9764 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e26dd6f9-7e4e-4953-beee-05d01b600ceb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Symphony no. 6 “Plutonian Ode”: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9764 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bf14c46c-b36b-4ecd-aae1-f88ed8c1299c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf14c46c-b36b-4ecd-aae1-f88ed8c1299c', 2, NULL, 'II', 'Symphony no. 6 “Plutonian Ode”: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9764 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf14c46c-b36b-4ecd-aae1-f88ed8c1299c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Symphony no. 6 “Plutonian Ode”: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9764 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:069abbf4-9a8b-4c11-81d2-4244846cb1e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:069abbf4-9a8b-4c11-81d2-4244846cb1e6', 3, NULL, 'III', 'Symphony no. 6 “Plutonian Ode”: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9764 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:069abbf4-9a8b-4c11-81d2-4244846cb1e6'
);


-- None 교향곡 7번 "Toltec"

UPDATE pieces piece
SET piece.title = '교향곡 7번 "Toltec"', piece.title_en = 'Symphony no. 7 “Toltec”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9761 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Corn', part.name_en = 'Symphony no. 7 “Toltec”: I. The Corn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9761 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:b41f259f-ae17-4a96-a680-87123f8ea15c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b41f259f-ae17-4a96-a680-87123f8ea15c', 1, 'I', 'The Corn', 'Symphony no. 7 “Toltec”: I. The Corn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9761 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b41f259f-ae17-4a96-a680-87123f8ea15c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Hikuri (Sacred Root)', part.name_en = 'Symphony no. 7 “Toltec”: II. The Hikuri (Sacred Root)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9761 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:16bdcea8-fce4-4b9b-872a-6394fde9b1ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16bdcea8-fce4-4b9b-872a-6394fde9b1ec', 2, 'II', 'The Hikuri (Sacred Root)', 'Symphony no. 7 “Toltec”: II. The Hikuri (Sacred Root)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9761 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16bdcea8-fce4-4b9b-872a-6394fde9b1ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Blue Deer', part.name_en = 'Symphony no. 7 “Toltec”: III. The Blue Deer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9761 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8fb4c0fd-fd55-4616-8082-9194eb83cf80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fb4c0fd-fd55-4616-8082-9194eb83cf80', 3, 'III', 'The Blue Deer', 'Symphony no. 7 “Toltec”: III. The Blue Deer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9761 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fb4c0fd-fd55-4616-8082-9194eb83cf80'
);


-- None Target Destruction

UPDATE pieces piece
SET piece.title = 'Target Destruction', piece.title_en = 'Target Destruction',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11228 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Beach / Lionel and Molly

UPDATE pieces piece
SET piece.title = 'The Beach / Lionel and Molly', piece.title_en = 'The Beach / Lionel and Molly',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10098 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Beggin

UPDATE pieces piece
SET piece.title = 'The Beggin', piece.title_en = 'The Beggin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9624 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Brother Becomes a Maniac

UPDATE pieces piece
SET piece.title = 'The Brother Becomes a Maniac', piece.title_en = 'The Brother Becomes a Maniac',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10717 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Canyon

UPDATE pieces piece
SET piece.title = 'The Canyon', piece.title_en = 'The Canyon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8890 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Cockney Brothers

UPDATE pieces piece
SET piece.title = 'The Cockney Brothers', piece.title_en = 'The Cockney Brothers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9839 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Complete Piano Etudes

UPDATE pieces piece
SET piece.title = 'The Complete Piano Etudes', piece.title_en = 'The Complete Piano Etudes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10913 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Etudes for Piano, Volume 1', part.name_en = 'Etudes for Piano, Volume 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598', 1, NULL, 'Etudes for Piano, Volume 1', 'Etudes for Piano, Volume 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Etude no. 1', part.name_en = 'Etude no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f2f97e55-8f69-4c44-a72d-c840e4bbaf09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2f97e55-8f69-4c44-a72d-c840e4bbaf09', 1, NULL, 'Etude no. 1', 'Etude no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2f97e55-8f69-4c44-a72d-c840e4bbaf09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Etude no. 3', part.name_en = 'Etude no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f00f56bf-cbc0-4c7c-a7db-88bf1191cd5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f00f56bf-cbc0-4c7c-a7db-88bf1191cd5a', 2, NULL, 'Etude no. 3', 'Etude no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f00f56bf-cbc0-4c7c-a7db-88bf1191cd5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Etude no. 5', part.name_en = 'Etude no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:65fba1d6-9503-4a46-8947-0393af8c1668' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:65fba1d6-9503-4a46-8947-0393af8c1668', 3, NULL, 'Etude no. 5', 'Etude no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65fba1d6-9503-4a46-8947-0393af8c1668'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 354 AND linked.composer_id = 93),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Etude no. 6', part.name_en = 'Etude no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f4e481ae-e994-4ca5-aff0-d2d8c1d06ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 354 AND linked.composer_id = 93), 'musicbrainz:f4e481ae-e994-4ca5-aff0-d2d8c1d06ccf', 4, NULL, 'Etude no. 6', 'Etude no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4e481ae-e994-4ca5-aff0-d2d8c1d06ccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Etude no. 7', part.name_en = 'Etude no. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7923b3e5-ce45-47e4-89b9-deb7c938213b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7923b3e5-ce45-47e4-89b9-deb7c938213b', 5, NULL, 'Etude no. 7', 'Etude no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7923b3e5-ce45-47e4-89b9-deb7c938213b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Etude no. 8', part.name_en = 'Etude no. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c78b31bc-4a05-486d-9604-3d867817eb00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c78b31bc-4a05-486d-9604-3d867817eb00', 6, NULL, 'Etude no. 8', 'Etude no. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c78b31bc-4a05-486d-9604-3d867817eb00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Etude no. 10', part.name_en = 'Etude no. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:630ec6c9-c219-4097-9640-f8aec313a0f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:630ec6c9-c219-4097-9640-f8aec313a0f7', 7, NULL, 'Etude no. 10', 'Etude no. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:66ed32d5-fbea-4e86-a842-087e183f0598'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:630ec6c9-c219-4097-9640-f8aec313a0f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Etudes for Piano, Volume 2', part.name_en = 'Etudes for Piano, Volume 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a', 2, NULL, 'Etudes for Piano, Volume 2', 'Etudes for Piano, Volume 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Etude no. 11', part.name_en = 'Etude no. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7b23bac4-1d8c-4dca-a4af-e2c051fe6250' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b23bac4-1d8c-4dca-a4af-e2c051fe6250', 1, NULL, 'Etude no. 11', 'Etude no. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b23bac4-1d8c-4dca-a4af-e2c051fe6250'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Etude no. 12', part.name_en = 'Etude no. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:808615c8-92e5-4a47-a735-979d1ca52aa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:808615c8-92e5-4a47-a735-979d1ca52aa1', 2, NULL, 'Etude no. 12', 'Etude no. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:808615c8-92e5-4a47-a735-979d1ca52aa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Étude no. 13', part.name_en = 'Étude no. 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:59197a3b-885f-4044-b175-330d05fc5d4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59197a3b-885f-4044-b175-330d05fc5d4f', 3, NULL, 'Étude no. 13', 'Étude no. 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59197a3b-885f-4044-b175-330d05fc5d4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Étude no. 14', part.name_en = 'Étude no. 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:37b32acc-d275-4f71-b3f9-bad4b466d173' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37b32acc-d275-4f71-b3f9-bad4b466d173', 4, NULL, 'Étude no. 14', 'Étude no. 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37b32acc-d275-4f71-b3f9-bad4b466d173'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Étude no. 15', part.name_en = 'Étude no. 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7a58fd03-e543-4ca0-98b9-f0de2eb32bd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a58fd03-e543-4ca0-98b9-f0de2eb32bd2', 5, NULL, 'Étude no. 15', 'Étude no. 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a58fd03-e543-4ca0-98b9-f0de2eb32bd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Etude no. 16', part.name_en = 'Etude no. 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:aab58de9-36e6-4781-85d3-1bce477cdbc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aab58de9-36e6-4781-85d3-1bce477cdbc5', 6, NULL, 'Etude no. 16', 'Etude no. 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aab58de9-36e6-4781-85d3-1bce477cdbc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Etude no. 17', part.name_en = 'Etude no. 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:84aa8ae0-5b74-40b9-a3c9-30e28fca45e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84aa8ae0-5b74-40b9-a3c9-30e28fca45e4', 7, NULL, 'Etude no. 17', 'Etude no. 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84aa8ae0-5b74-40b9-a3c9-30e28fca45e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Étude no. 18', part.name_en = 'Étude no. 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:003d2be5-5371-41a4-9edf-2d5be9e7e4d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:003d2be5-5371-41a4-9edf-2d5be9e7e4d7', 8, NULL, 'Étude no. 18', 'Étude no. 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:003d2be5-5371-41a4-9edf-2d5be9e7e4d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Etude no. 19', part.name_en = 'Etude no. 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:15203edd-ea8e-4614-a768-bdb9d7befc16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15203edd-ea8e-4614-a768-bdb9d7befc16', 9, NULL, 'Etude no. 19', 'Etude no. 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15203edd-ea8e-4614-a768-bdb9d7befc16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Étude no. 20', part.name_en = 'Étude no. 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10913 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:850e9cea-a061-46bf-8ce9-fbf26cc0317e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:850e9cea-a061-46bf-8ce9-fbf26cc0317e', 10, NULL, 'Étude no. 20', 'Étude no. 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:99ec78d5-4400-4c45-91c2-9c3464cabe8a'
WHERE p.id = 10913 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:850e9cea-a061-46bf-8ce9-fbf26cc0317e'
);


-- None The Day Room

UPDATE pieces piece
SET piece.title = 'The Day Room', piece.title_en = 'The Day Room',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9754 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Demise of Candyman

UPDATE pieces piece
SET piece.title = 'The Demise of Candyman', piece.title_en = 'The Demise of Candyman',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8173 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Ending

UPDATE pieces piece
SET piece.title = 'The Ending', piece.title_en = 'The Ending',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10328 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Entrance of the Moon

UPDATE pieces piece
SET piece.title = 'The Entrance of the Moon', piece.title_en = 'The Entrance of the Moon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9448 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <The Fall of the House of Usher>

UPDATE pieces piece
SET piece.title = '오페라 <The Fall of the House of Usher>', piece.title_en = 'The Fall of the House of Usher',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9104 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I: Scene 5', part.name_en = 'The Fall of the House of Usher, Act I: Scene 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:08592a90-a89f-46c4-9c4b-8f615d446a9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08592a90-a89f-46c4-9c4b-8f615d446a9c', 1, NULL, 'Act I: Scene 5', 'The Fall of the House of Usher, Act I: Scene 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08592a90-a89f-46c4-9c4b-8f615d446a9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I: Scene 2', part.name_en = 'The Fall of the House of Usher, Act I: Scene 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1bc3e6a9-9dcb-428c-98b6-605cad88ee6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bc3e6a9-9dcb-428c-98b6-605cad88ee6d', 2, NULL, 'Act I: Scene 2', 'The Fall of the House of Usher, Act I: Scene 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bc3e6a9-9dcb-428c-98b6-605cad88ee6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I: Scene 4', part.name_en = 'The Fall of the House of Usher, Act I: Scene 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4f62f63e-ba66-4c2b-b427-cf220b009bbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f62f63e-ba66-4c2b-b427-cf220b009bbe', 3, NULL, 'Act I: Scene 4', 'The Fall of the House of Usher, Act I: Scene 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f62f63e-ba66-4c2b-b427-cf220b009bbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I: Scene 6', part.name_en = 'The Fall of the House of Usher, Act I: Scene 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:56ed07e3-fa23-44e2-9d3d-abf2f2543625' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56ed07e3-fa23-44e2-9d3d-abf2f2543625', 4, NULL, 'Act I: Scene 6', 'The Fall of the House of Usher, Act I: Scene 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56ed07e3-fa23-44e2-9d3d-abf2f2543625'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I: Scene 3', part.name_en = 'The Fall of the House of Usher, Act I: Scene 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:578020d8-f9c4-43da-b817-f2fa675f26a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:578020d8-f9c4-43da-b817-f2fa675f26a0', 5, NULL, 'Act I: Scene 3', 'The Fall of the House of Usher, Act I: Scene 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:578020d8-f9c4-43da-b817-f2fa675f26a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I: Scene 1', part.name_en = 'The Fall of the House of Usher, Act I: Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6208bdb0-8475-4a9f-be69-b2badd6d92da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6208bdb0-8475-4a9f-be69-b2badd6d92da', 6, NULL, 'Act I: Scene 1', 'The Fall of the House of Usher, Act I: Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6208bdb0-8475-4a9f-be69-b2badd6d92da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II: Scene 4', part.name_en = 'The Fall of the House of Usher, Act II: Scene 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:688be5d0-2150-47e2-8ec8-5a3d7aacf684' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:688be5d0-2150-47e2-8ec8-5a3d7aacf684', 7, NULL, 'Act II: Scene 4', 'The Fall of the House of Usher, Act II: Scene 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:688be5d0-2150-47e2-8ec8-5a3d7aacf684'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I: Interlude', part.name_en = 'The Fall of the House of Usher, Act I: Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6eff6f6e-360c-4134-bc55-df744db662dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6eff6f6e-360c-4134-bc55-df744db662dd', 8, NULL, 'Act I: Interlude', 'The Fall of the House of Usher, Act I: Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eff6f6e-360c-4134-bc55-df744db662dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I: Prologue', part.name_en = 'The Fall of the House of Usher, Act I: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:87f4b63a-aa53-4822-9a62-a5984d83ba1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87f4b63a-aa53-4822-9a62-a5984d83ba1e', 9, NULL, 'Act I: Prologue', 'The Fall of the House of Usher, Act I: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87f4b63a-aa53-4822-9a62-a5984d83ba1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II: Scene 3', part.name_en = 'The Fall of the House of Usher, Act II: Scene 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a0d7da81-f10e-4a50-bc98-4423c0d0b918' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0d7da81-f10e-4a50-bc98-4423c0d0b918', 10, NULL, 'Act II: Scene 3', 'The Fall of the House of Usher, Act II: Scene 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d7da81-f10e-4a50-bc98-4423c0d0b918'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act II: Prelude', part.name_en = 'The Fall of the House of Usher, Act II: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a7d90c7c-a00c-4277-929f-890fefbe5247' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7d90c7c-a00c-4277-929f-890fefbe5247', 11, NULL, 'Act II: Prelude', 'The Fall of the House of Usher, Act II: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7d90c7c-a00c-4277-929f-890fefbe5247'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act II: Scene 2', part.name_en = 'The Fall of the House of Usher, Act II: Scene 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:af20d19c-0325-4de2-8110-e8fbc578549f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af20d19c-0325-4de2-8110-e8fbc578549f', 12, NULL, 'Act II: Scene 2', 'The Fall of the House of Usher, Act II: Scene 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af20d19c-0325-4de2-8110-e8fbc578549f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act II: Scene 1', part.name_en = 'The Fall of the House of Usher, Act II: Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9104 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c4acc44c-9b3d-4b89-8832-28b6b57ce498' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4acc44c-9b3d-4b89-8832-28b6b57ce498', 13, NULL, 'Act II: Scene 1', 'The Fall of the House of Usher, Act II: Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9104 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4acc44c-9b3d-4b89-8832-28b6b57ce498'
);


-- None The First Mad Rush

UPDATE pieces piece
SET piece.title = 'The First Mad Rush', piece.title_en = 'The First Mad Rush',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9532 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The First Meridian

UPDATE pieces piece
SET piece.title = 'The First Meridian', piece.title_en = 'The First Meridian',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7862 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Fog of War

UPDATE pieces piece
SET piece.title = 'The Fog of War', piece.title_en = 'The Fog of War',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9569 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Fog of War: The War to End All Wars

UPDATE pieces piece
SET piece.title = 'The Fog of War: The War to End All Wars', piece.title_en = 'The Fog of War: The War to End All Wars',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10052 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Harts

UPDATE pieces piece
SET piece.title = 'The Harts', piece.title_en = 'The Harts',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9216 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The History

UPDATE pieces piece
SET piece.title = 'The History', piece.title_en = 'The History',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10677 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Hurricane and Recognition of Death

UPDATE pieces piece
SET piece.title = 'The Hurricane and Recognition of Death', piece.title_en = 'The Hurricane and Recognition of Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10989 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Interview

UPDATE pieces piece
SET piece.title = 'The Interview', piece.title_en = 'The Interview',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11222 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Light That Failed

UPDATE pieces piece
SET piece.title = 'The Light That Failed', piece.title_en = 'The Light That Failed',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9622 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Lobster Bowl

UPDATE pieces piece
SET piece.title = 'The Lobster Bowl', piece.title_en = 'The Lobster Bowl',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8312 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Maelström

UPDATE pieces piece
SET piece.title = 'The Maelström', piece.title_en = 'The Maelström',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9470 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Man in the Bath

UPDATE pieces piece
SET piece.title = 'The Man in the Bath', piece.title_en = 'The Man in the Bath',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8901 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Naming

UPDATE pieces piece
SET piece.title = 'The Naming', piece.title_en = 'The Naming',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11103 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Not Doings of an Insomniac

UPDATE pieces piece
SET piece.title = 'The Not Doings of an Insomniac', piece.title_en = 'The Not Doings of an Insomniac',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10982 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Small Town', part.name_en = 'The Not Doings of an Insomniac: Small Town',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:47496655-446d-4a39-af7f-52da5c4829ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47496655-446d-4a39-af7f-52da5c4829ec', 1, NULL, 'Small Town', 'The Not Doings of an Insomniac: Small Town', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47496655-446d-4a39-af7f-52da5c4829ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Partita for Solo Double Bass: I. Not Dreaming', part.name_en = 'The Not Doings of an Insomniac: Partita for Solo Double Bass: I. Not Dreaming',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c8ce8d44-0164-4f3d-8dfa-ade45cfa08ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8ce8d44-0164-4f3d-8dfa-ade45cfa08ce', 2, NULL, 'Partita for Solo Double Bass: I. Not Dreaming', 'The Not Doings of an Insomniac: Partita for Solo Double Bass: I. Not Dreaming', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8ce8d44-0164-4f3d-8dfa-ade45cfa08ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Telephone Song', part.name_en = 'The Not Doings of an Insomniac: Telephone Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a8b478cd-c35a-4135-8b0f-45488fe9b649' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8b478cd-c35a-4135-8b0f-45488fe9b649', 3, NULL, 'Telephone Song', 'The Not Doings of an Insomniac: Telephone Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8b478cd-c35a-4135-8b0f-45488fe9b649'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Partita for Solo Double Bass: II. Not Tasting', part.name_en = 'The Not Doings of an Insomniac: Partita for Solo Double Bass: II. Not Tasting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:783202e4-a055-453f-bf55-d2c4736a7c2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:783202e4-a055-453f-bf55-d2c4736a7c2f', 4, NULL, 'Partita for Solo Double Bass: II. Not Tasting', 'The Not Doings of an Insomniac: Partita for Solo Double Bass: II. Not Tasting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:783202e4-a055-453f-bf55-d2c4736a7c2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Shine, Shine', part.name_en = 'The Not Doings of an Insomniac: Shine, Shine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9ee41500-ab17-458b-897f-83bd35fae1f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ee41500-ab17-458b-897f-83bd35fae1f9', 5, NULL, 'Shine, Shine', 'The Not Doings of an Insomniac: Shine, Shine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ee41500-ab17-458b-897f-83bd35fae1f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Partita for Solo Double Bass: III. Not Smelling', part.name_en = 'The Not Doings of an Insomniac: Partita for Solo Double Bass: III. Not Smelling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bc2538c3-7463-4dd2-840a-b6f8764a9f10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc2538c3-7463-4dd2-840a-b6f8764a9f10', 6, NULL, 'Partita for Solo Double Bass: III. Not Smelling', 'The Not Doings of an Insomniac: Partita for Solo Double Bass: III. Not Smelling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc2538c3-7463-4dd2-840a-b6f8764a9f10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Neighborhood', part.name_en = 'The Not Doings of an Insomniac: Neighborhood',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:64ec9832-afda-47f3-9e92-0a0fa363a6df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64ec9832-afda-47f3-9e92-0a0fa363a6df', 7, NULL, 'Neighborhood', 'The Not Doings of an Insomniac: Neighborhood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64ec9832-afda-47f3-9e92-0a0fa363a6df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Partita for Solo Double Bass: IV. Not Hearing', part.name_en = 'The Not Doings of an Insomniac: Partita for Solo Double Bass: IV. Not Hearing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:49857b19-70cc-4b1e-be66-207bd5aec386' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49857b19-70cc-4b1e-be66-207bd5aec386', 8, NULL, 'Partita for Solo Double Bass: IV. Not Hearing', 'The Not Doings of an Insomniac: Partita for Solo Double Bass: IV. Not Hearing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49857b19-70cc-4b1e-be66-207bd5aec386'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'I Wonder How Many People in This City', part.name_en = 'The Not Doings of an Insomniac: I Wonder How Many People in This City',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5043da42-b079-444b-a049-097139723809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5043da42-b079-444b-a049-097139723809', 9, NULL, 'I Wonder How Many People in This City', 'The Not Doings of an Insomniac: I Wonder How Many People in This City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5043da42-b079-444b-a049-097139723809'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Partita for Solo Double Bass: V. Not Seeing', part.name_en = 'The Not Doings of an Insomniac: Partita for Solo Double Bass: V. Not Seeing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:42b7c1d2-20fd-4066-8f8d-ab8f7e7f45aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b7c1d2-20fd-4066-8f8d-ab8f7e7f45aa', 10, NULL, 'Partita for Solo Double Bass: V. Not Seeing', 'The Not Doings of an Insomniac: Partita for Solo Double Bass: V. Not Seeing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b7c1d2-20fd-4066-8f8d-ab8f7e7f45aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Babel', part.name_en = 'The Not Doings of an Insomniac: Babel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:98c8b6ef-4078-4acf-adac-a29dfd7c48bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98c8b6ef-4078-4acf-adac-a29dfd7c48bd', 11, NULL, 'Babel', 'The Not Doings of an Insomniac: Babel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98c8b6ef-4078-4acf-adac-a29dfd7c48bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Partita for Solo Double Bass: VI. Not Touching', part.name_en = 'The Not Doings of an Insomniac: Partita for Solo Double Bass: VI. Not Touching',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:363ab0c5-87a5-4bc3-adef-617b5b579da9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:363ab0c5-87a5-4bc3-adef-617b5b579da9', 12, NULL, 'Partita for Solo Double Bass: VI. Not Touching', 'The Not Doings of an Insomniac: Partita for Solo Double Bass: VI. Not Touching', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:363ab0c5-87a5-4bc3-adef-617b5b579da9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Nobody Wants A Lonely Heart', part.name_en = 'The Not Doings of an Insomniac: Nobody Wants A Lonely Heart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0e4ff54b-53df-448a-bca2-06f5f2140ed3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e4ff54b-53df-448a-bca2-06f5f2140ed3', 13, NULL, 'Nobody Wants A Lonely Heart', 'The Not Doings of an Insomniac: Nobody Wants A Lonely Heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e4ff54b-53df-448a-bca2-06f5f2140ed3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Partita for Solo Double Bass: VII. Not Beginning, Not Ending', part.name_en = 'The Not Doings of an Insomniac: Partita for Solo Double Bass: VII. Not Beginning, Not Ending',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10982 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5d228473-1316-44a2-8843-2a588c8fa626' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d228473-1316-44a2-8843-2a588c8fa626', 14, NULL, 'Partita for Solo Double Bass: VII. Not Beginning, Not Ending', 'The Not Doings of an Insomniac: Partita for Solo Double Bass: VII. Not Beginning, Not Ending', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10982 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d228473-1316-44a2-8843-2a588c8fa626'
);


-- None The Olympian - Lighting of the Torch

UPDATE pieces piece
SET piece.title = 'The Olympian - Lighting of the Torch', piece.title_en = 'The Olympian - Lighting of the Torch',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11259 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Paris Sky

UPDATE pieces piece
SET piece.title = 'The Paris Sky', piece.title_en = 'The Paris Sky',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9542 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Passion of Ramakrishna

UPDATE pieces piece
SET piece.title = 'The Passion of Ramakrishna', piece.title_en = 'The Passion of Ramakrishna',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9485 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part 3', part.name_en = 'Part 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9485 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0bd34a2b-504d-4ba3-9b25-fd2880b92efa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bd34a2b-504d-4ba3-9b25-fd2880b92efa', 1, NULL, 'Part 3', 'Part 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9485 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bd34a2b-504d-4ba3-9b25-fd2880b92efa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part 1', part.name_en = 'Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9485 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1f6302e8-7ff4-43f9-997a-4c2d1de509cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f6302e8-7ff4-43f9-997a-4c2d1de509cc', 2, NULL, 'Part 1', 'Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9485 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f6302e8-7ff4-43f9-997a-4c2d1de509cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9485 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:745f41e5-55d7-4fda-9e52-d411e54480d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:745f41e5-55d7-4fda-9e52-d411e54480d6', 3, NULL, 'Prologue', 'Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9485 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:745f41e5-55d7-4fda-9e52-d411e54480d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part 4', part.name_en = 'Part 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9485 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:7516d3db-cd29-464a-b3da-1fc38f84a6cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7516d3db-cd29-464a-b3da-1fc38f84a6cf', 4, NULL, 'Part 4', 'Part 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9485 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7516d3db-cd29-464a-b3da-1fc38f84a6cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Epilogue', part.name_en = 'Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9485 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ab45ec07-4754-4736-abda-75b8497b007f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab45ec07-4754-4736-abda-75b8497b007f', 5, NULL, 'Epilogue', 'Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9485 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab45ec07-4754-4736-abda-75b8497b007f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Part 2', part.name_en = 'Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9485 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f2389887-71cc-4d8d-9154-5990d1cecfda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2389887-71cc-4d8d-9154-5990d1cecfda', 6, NULL, 'Part 2', 'Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9485 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2389887-71cc-4d8d-9154-5990d1cecfda'
);


-- None 오페라 <The Perfect American>

UPDATE pieces piece
SET piece.title = '오페라 <The Perfect American>', piece.title_en = 'The Perfect American',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8038 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene 5', part.name_en = 'The Perfect American - Act I: Scene 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:23aa1270-1c52-48eb-b75d-d803bfeedeb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23aa1270-1c52-48eb-b75d-d803bfeedeb7', 1, NULL, 'Scene 5', 'The Perfect American - Act I: Scene 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23aa1270-1c52-48eb-b75d-d803bfeedeb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 1', part.name_en = 'The Perfect American - Act II: Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:26ab6940-8c1d-4fc7-a387-74fc78abdf7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26ab6940-8c1d-4fc7-a387-74fc78abdf7c', 2, NULL, 'Scene 1', 'The Perfect American - Act II: Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26ab6940-8c1d-4fc7-a387-74fc78abdf7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene 3', part.name_en = 'The Perfect American - Act I: Scene 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:384e00e2-f812-4945-93fc-9d65532e7c71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:384e00e2-f812-4945-93fc-9d65532e7c71', 3, NULL, 'Scene 3', 'The Perfect American - Act I: Scene 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:384e00e2-f812-4945-93fc-9d65532e7c71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Epilogue', part.name_en = 'The Perfect American - Act II: Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3dc1e735-5cf1-4107-8d72-4f74a5fc3426' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dc1e735-5cf1-4107-8d72-4f74a5fc3426', 4, NULL, 'Epilogue', 'The Perfect American - Act II: Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc1e735-5cf1-4107-8d72-4f74a5fc3426'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene 2', part.name_en = 'The Perfect American - Act II: Scene 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:73813520-e8ff-465b-8e6c-034dd74c2be4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73813520-e8ff-465b-8e6c-034dd74c2be4', 5, NULL, 'Scene 2', 'The Perfect American - Act II: Scene 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73813520-e8ff-465b-8e6c-034dd74c2be4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene 6', part.name_en = 'The Perfect American - Act II: Scene 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:816e757f-d968-4854-b02c-6c32443f6d8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:816e757f-d968-4854-b02c-6c32443f6d8a', 6, NULL, 'Scene 6', 'The Perfect American - Act II: Scene 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:816e757f-d968-4854-b02c-6c32443f6d8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene 3', part.name_en = 'The Perfect American - Act II: Scene 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:97f68e4d-9c3f-4b80-8db6-0751be0598b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97f68e4d-9c3f-4b80-8db6-0751be0598b9', 7, NULL, 'Scene 3', 'The Perfect American - Act II: Scene 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97f68e4d-9c3f-4b80-8db6-0751be0598b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene 1', part.name_en = 'The Perfect American - Act I: Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a269518b-50a1-474c-bfba-a59f453bd1a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a269518b-50a1-474c-bfba-a59f453bd1a3', 8, NULL, 'Scene 1', 'The Perfect American - Act I: Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a269518b-50a1-474c-bfba-a59f453bd1a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene 2', part.name_en = 'The Perfect American - Act I: Scene 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c63c7b24-daef-4c64-9b8c-7722a7ddcaee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c63c7b24-daef-4c64-9b8c-7722a7ddcaee', 9, NULL, 'Scene 2', 'The Perfect American - Act I: Scene 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c63c7b24-daef-4c64-9b8c-7722a7ddcaee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene 5', part.name_en = 'The Perfect American - Act II: Scene 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d74c5de8-e2f3-4d43-aaee-71104e0b4a15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d74c5de8-e2f3-4d43-aaee-71104e0b4a15', 10, NULL, 'Scene 5', 'The Perfect American - Act II: Scene 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d74c5de8-e2f3-4d43-aaee-71104e0b4a15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'The Perfect American - Act I: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e38b7d2a-588a-4868-85d1-a1fec191ac01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e38b7d2a-588a-4868-85d1-a1fec191ac01', 11, NULL, 'Prologue', 'The Perfect American - Act I: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e38b7d2a-588a-4868-85d1-a1fec191ac01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene 4', part.name_en = 'The Perfect American - Act I: Scene 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f21eb5f8-4953-4130-b91a-f8d77e54a0d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f21eb5f8-4953-4130-b91a-f8d77e54a0d8', 12, NULL, 'Scene 4', 'The Perfect American - Act I: Scene 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21eb5f8-4953-4130-b91a-f8d77e54a0d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scene 4', part.name_en = 'The Perfect American - Act II: Scene 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8038 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fdb2d18c-e640-4fcd-b1d6-daf10c43d28d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdb2d18c-e640-4fcd-b1d6-daf10c43d28d', 13, NULL, 'Scene 4', 'The Perfect American - Act II: Scene 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8038 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdb2d18c-e640-4fcd-b1d6-daf10c43d28d'
);


-- None The Photographer

UPDATE pieces piece
SET piece.title = 'The Photographer', piece.title_en = 'The Photographer',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9621 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'The Photographer: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9621 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:398e3b2e-8427-491f-b498-23c1415334b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:398e3b2e-8427-491f-b498-23c1415334b1', 1, NULL, 'Act II', 'The Photographer: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9621 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398e3b2e-8427-491f-b498-23c1415334b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'The Photographer: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9621 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:af5ed6cb-9e61-44ce-be11-b5cab0c21388' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af5ed6cb-9e61-44ce-be11-b5cab0c21388', 2, NULL, 'Act III', 'The Photographer: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9621 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af5ed6cb-9e61-44ce-be11-b5cab0c21388'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A Gentleman''s Honor (instrumental)', part.name_en = 'The Photographer: A Gentleman''s Honor (instrumental)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9621 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:d375d6f7-c0f7-4290-86ad-c14628c9d898' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d375d6f7-c0f7-4290-86ad-c14628c9d898', 3, NULL, 'A Gentleman''s Honor (instrumental)', 'The Photographer: A Gentleman''s Honor (instrumental)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9621 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d375d6f7-c0f7-4290-86ad-c14628c9d898'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '"A Gentleman''s Honor"', part.name_en = 'The Photographer: "A Gentleman''s Honor"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9621 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:fc325765-adf8-441c-9718-277d135a6246' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc325765-adf8-441c-9718-277d135a6246', 4, NULL, '"A Gentleman''s Honor"', 'The Photographer: "A Gentleman''s Honor"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9621 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc325765-adf8-441c-9718-277d135a6246'
);


-- None 가곡 <The Plant-Boy's Song>

UPDATE pieces piece
SET piece.title = '가곡 <The Plant-Boy''s Song>', piece.title_en = 'The Plant-Boy''s Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8658 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Plot Unravels

UPDATE pieces piece
SET piece.title = 'The Plot Unravels', piece.title_en = 'The Plot Unravels',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11202 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Promise

UPDATE pieces piece
SET piece.title = 'The Promise', piece.title_en = 'The Promise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9509 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Pursuit & Murder in the Park

UPDATE pieces piece
SET piece.title = 'The Pursuit & Murder in the Park', piece.title_en = 'The Pursuit & Murder in the Park',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11017 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Reciprocal Gaze

UPDATE pieces piece
SET piece.title = 'The Reciprocal Gaze', piece.title_en = 'The Reciprocal Gaze',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9856 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Reclamation Bill

UPDATE pieces piece
SET piece.title = 'The Reclamation Bill', piece.title_en = 'The Reclamation Bill',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9967 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Secret Agent

UPDATE pieces piece
SET piece.title = 'The Secret Agent', piece.title_en = 'The Secret Agent',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9502 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Sighting

UPDATE pieces piece
SET piece.title = 'The Sighting', piece.title_en = 'The Sighting',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10335 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Slave Quarters

UPDATE pieces piece
SET piece.title = 'The Slave Quarters', piece.title_en = 'The Slave Quarters',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10535 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Strategem

UPDATE pieces piece
SET piece.title = 'The Strategem', piece.title_en = 'The Strategem',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10422 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <The Trial>

UPDATE pieces piece
SET piece.title = '오페라 <The Trial>', piece.title_en = 'The Trial',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8400 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act Two: Scene 5: Journey to a Quarry', part.name_en = 'The Trial: Act Two: Scene 5: Journey to a Quarry',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:05e33920-7b04-488a-9484-12d441da4868' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05e33920-7b04-488a-9484-12d441da4868', 1, NULL, 'Act Two: Scene 5: Journey to a Quarry', 'The Trial: Act Two: Scene 5: Journey to a Quarry', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05e33920-7b04-488a-9484-12d441da4868'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act One: Scene 5B: The Flogger', part.name_en = 'The Trial: Act One: Scene 5B: The Flogger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:14c986bb-276e-4998-916b-a911a7ef28df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14c986bb-276e-4998-916b-a911a7ef28df', 2, NULL, 'Act One: Scene 5B: The Flogger', 'The Trial: Act One: Scene 5B: The Flogger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14c986bb-276e-4998-916b-a911a7ef28df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act One: Scene 2B: The Tenant Next Door, Fräulein Bürstner', part.name_en = 'The Trial: Act One: Scene 2B: The Tenant Next Door, Fräulein Bürstner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:176f9ba1-c77f-485a-a470-c552de673680' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:176f9ba1-c77f-485a-a470-c552de673680', 3, NULL, 'Act One: Scene 2B: The Tenant Next Door, Fräulein Bürstner', 'The Trial: Act One: Scene 2B: The Tenant Next Door, Fräulein Bürstner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:176f9ba1-c77f-485a-a470-c552de673680'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act Two: Scene 4: The Priest', part.name_en = 'The Trial: Act Two: Scene 4: The Priest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:192b1b8f-2307-4dfd-9f53-20dcf8953c06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:192b1b8f-2307-4dfd-9f53-20dcf8953c06', 4, NULL, 'Act Two: Scene 4: The Priest', 'The Trial: Act Two: Scene 4: The Priest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:192b1b8f-2307-4dfd-9f53-20dcf8953c06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act One: Scene 4: Washerwoman, The Student, The Court Usher (Washerwoman''s husband)', part.name_en = 'The Trial: Act One: Scene 4: Washerwoman, The Student, The Court Usher (Washerwoman''s husband)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:265a88ae-4470-4d42-88ff-57eb673fa8bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:265a88ae-4470-4d42-88ff-57eb673fa8bd', 5, NULL, 'Act One: Scene 4: Washerwoman, The Student, The Court Usher (Washerwoman''s husband)', 'The Trial: Act One: Scene 4: Washerwoman, The Student, The Court Usher (Washerwoman''s husband)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:265a88ae-4470-4d42-88ff-57eb673fa8bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act Two: Prelude', part.name_en = 'The Trial: Act Two: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:316c4878-7724-4d99-9460-43ea206979da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:316c4878-7724-4d99-9460-43ea206979da', 6, NULL, 'Act Two: Prelude', 'The Trial: Act Two: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:316c4878-7724-4d99-9460-43ea206979da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act Two: Scene 2: Titorelli the painter', part.name_en = 'The Trial: Act Two: Scene 2: Titorelli the painter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5f713b93-5078-4006-8b94-398e2d09a64e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f713b93-5078-4006-8b94-398e2d09a64e', 7, NULL, 'Act Two: Scene 2: Titorelli the painter', 'The Trial: Act Two: Scene 2: Titorelli the painter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f713b93-5078-4006-8b94-398e2d09a64e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act One: Scene 3: The Court', part.name_en = 'The Trial: Act One: Scene 3: The Court',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:6ba68dcd-776e-4d6d-ab0a-0dcb1c91cf29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ba68dcd-776e-4d6d-ab0a-0dcb1c91cf29', 8, NULL, 'Act One: Scene 3: The Court', 'The Trial: Act One: Scene 3: The Court', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ba68dcd-776e-4d6d-ab0a-0dcb1c91cf29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act One: Scene 1: The Arrest: Franz, Willem, The Inspector', part.name_en = 'The Trial: Act One: Scene 1: The Arrest: Franz, Willem, The Inspector',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:97372d21-d8e5-4f3b-99e8-7fa6be5d5dcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97372d21-d8e5-4f3b-99e8-7fa6be5d5dcd', 9, NULL, 'Act One: Scene 1: The Arrest: Franz, Willem, The Inspector', 'The Trial: Act One: Scene 1: The Arrest: Franz, Willem, The Inspector', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97372d21-d8e5-4f3b-99e8-7fa6be5d5dcd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act One: Scene 2A: The Landlady, Frau Grubach', part.name_en = 'The Trial: Act One: Scene 2A: The Landlady, Frau Grubach',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:bcb686b7-0cf2-405d-847c-096087655799' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcb686b7-0cf2-405d-847c-096087655799', 10, NULL, 'Act One: Scene 2A: The Landlady, Frau Grubach', 'The Trial: Act One: Scene 2A: The Landlady, Frau Grubach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcb686b7-0cf2-405d-847c-096087655799'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act Two: Scene 1: Uncle Albert takes K. to visit Lawyer Huld and Leni (Huld''s maid-cum-nurse)', part.name_en = 'The Trial: Act Two: Scene 1: Uncle Albert takes K. to visit Lawyer Huld and Leni (Huld''s maid-cum-nurse)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e48c952f-ea73-4314-bb0e-5041285274cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e48c952f-ea73-4314-bb0e-5041285274cc', 11, NULL, 'Act Two: Scene 1: Uncle Albert takes K. to visit Lawyer Huld and Leni (Huld''s maid-cum-nurse)', 'The Trial: Act Two: Scene 1: Uncle Albert takes K. to visit Lawyer Huld and Leni (Huld''s maid-cum-nurse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48c952f-ea73-4314-bb0e-5041285274cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act One: Scene 5A: At the Bank: Uncle Albert', part.name_en = 'The Trial: Act One: Scene 5A: At the Bank: Uncle Albert',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e7bf4d26-9918-44bd-a514-9cef6382f641' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7bf4d26-9918-44bd-a514-9cef6382f641', 12, NULL, 'Act One: Scene 5A: At the Bank: Uncle Albert', 'The Trial: Act One: Scene 5A: At the Bank: Uncle Albert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7bf4d26-9918-44bd-a514-9cef6382f641'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act Two: Scene 3: Lawyer Huld''s House: Block (another client), Leni', part.name_en = 'The Trial: Act Two: Scene 3: Lawyer Huld''s House: Block (another client), Leni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8400 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:f015d88a-2f98-40d4-97cc-e89b305653ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f015d88a-2f98-40d4-97cc-e89b305653ab', 13, NULL, 'Act Two: Scene 3: Lawyer Huld''s House: Block (another client), Leni', 'The Trial: Act Two: Scene 3: Lawyer Huld''s House: Block (another client), Leni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8400 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f015d88a-2f98-40d4-97cc-e89b305653ab'
);


-- None 오페라 <The Voyage>

UPDATE pieces piece
SET piece.title = '오페라 <The Voyage>', piece.title_en = 'The Voyage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10488 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The War to End All Wars

UPDATE pieces piece
SET piece.title = 'The War to End All Wars', piece.title_en = 'The War to End All Wars',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10808 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Windcatcher

UPDATE pieces piece
SET piece.title = 'The Windcatcher', piece.title_en = 'The Windcatcher',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8167 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part III', part.name_en = 'The Windcatcher, Part III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8167 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:0d3aac27-4a19-495c-ba3f-1b27124e9c5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d3aac27-4a19-495c-ba3f-1b27124e9c5e', 1, NULL, 'Part III', 'The Windcatcher, Part III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8167 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d3aac27-4a19-495c-ba3f-1b27124e9c5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part I', part.name_en = 'The Windcatcher, Part I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8167 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8c4c4479-4702-4abe-8f28-32a0432268aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c4c4479-4702-4abe-8f28-32a0432268aa', 2, NULL, 'Part I', 'The Windcatcher, Part I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8167 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c4c4479-4702-4abe-8f28-32a0432268aa'
);


-- None They Enter the Stream

UPDATE pieces piece
SET piece.title = 'They Enter the Stream', piece.title_en = 'They Enter the Stream',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8839 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 3개의 가곡

UPDATE pieces piece
SET piece.title = '3개의 가곡', piece.title_en = 'Three Songs for Chorus a Cappella',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8947 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'There Are Some Men', part.name_en = 'Three Songs for Chorus a Cappella: I. There Are Some Men',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8947 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:3d899708-03cc-43f6-bab7-a3b1ef8dbdc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d899708-03cc-43f6-bab7-a3b1ef8dbdc5', 1, 'I', 'There Are Some Men', 'Three Songs for Chorus a Cappella: I. There Are Some Men', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8947 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d899708-03cc-43f6-bab7-a3b1ef8dbdc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quand les hommes vivront d''amour', part.name_en = 'Three Songs for Chorus a Cappella: II. Quand les hommes vivront d''amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8947 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:dc0dd1db-e754-4edf-8dad-e1fa3c59e215' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc0dd1db-e754-4edf-8dad-e1fa3c59e215', 2, 'II', 'Quand les hommes vivront d''amour', 'Three Songs for Chorus a Cappella: II. Quand les hommes vivront d''amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8947 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc0dd1db-e754-4edf-8dad-e1fa3c59e215'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Pierre de Soleil', part.name_en = 'Three Songs for Chorus a Cappella: III. Pierre de Soleil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8947 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:5a75bcdb-c33f-4c2f-b96d-3162cf7e632f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a75bcdb-c33f-4c2f-b96d-3162cf7e632f', 3, 'III', 'Pierre de Soleil', 'Three Songs for Chorus a Cappella: III. Pierre de Soleil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8947 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a75bcdb-c33f-4c2f-b96d-3162cf7e632f'
);


-- None Through the Woods

UPDATE pieces piece
SET piece.title = 'Through the Woods', piece.title_en = 'Through the Woods',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9456 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tirol Concerto for Piano & Orchestra

UPDATE pieces piece
SET piece.title = 'Tirol Concerto for Piano & Orchestra', piece.title_en = 'Tirol Concerto for Piano & Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9863 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Tirol Concerto for Piano & Orchestra: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9863 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:4ea3507b-4495-486b-a695-80ed69e62bf7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ea3507b-4495-486b-a695-80ed69e62bf7', 1, NULL, 'I', 'Tirol Concerto for Piano & Orchestra: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9863 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ea3507b-4495-486b-a695-80ed69e62bf7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Tirol Concerto for Piano & Orchestra: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9863 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:41cfafe1-de5d-45f4-a98d-ff49161b44bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41cfafe1-de5d-45f4-a98d-ff49161b44bb', 2, NULL, 'II', 'Tirol Concerto for Piano & Orchestra: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9863 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41cfafe1-de5d-45f4-a98d-ff49161b44bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Tirol Concerto for Piano & Orchestra: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9863 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:ee6f6c7f-3972-45b3-8388-46f3d0ea7102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee6f6c7f-3972-45b3-8388-46f3d0ea7102', 3, NULL, 'III', 'Tirol Concerto for Piano & Orchestra: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9863 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee6f6c7f-3972-45b3-8388-46f3d0ea7102'
);


-- None Tissue No. 1

UPDATE pieces piece
SET piece.title = 'Tissue No. 1', piece.title_en = 'Tissue No. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9786 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tissue No. 2

UPDATE pieces piece
SET piece.title = 'Tissue No. 2', piece.title_en = 'Tissue No. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9019 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tissue No. 7

UPDATE pieces piece
SET piece.title = 'Tissue No. 7', piece.title_en = 'Tissue No. 7',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8903 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tissue no. 6

UPDATE pieces piece
SET piece.title = 'Tissue no. 6', piece.title_en = 'Tissue no. 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10751 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tranquility

UPDATE pieces piece
SET piece.title = 'Tranquility', piece.title_en = 'Tranquility',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10246 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trust

UPDATE pieces piece
SET piece.title = 'Trust', piece.title_en = 'Trust',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9061 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Pages

UPDATE pieces piece
SET piece.title = 'Two Pages', piece.title_en = 'Two Pages',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8420 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Unfolding

UPDATE pieces piece
SET piece.title = 'Unfolding', piece.title_en = 'Unfolding',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10360 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Unilateralism

UPDATE pieces piece
SET piece.title = 'Unilateralism', piece.title_en = 'Unilateralism',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8566 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vanessa and the Changelings

UPDATE pieces piece
SET piece.title = 'Vanessa and the Changelings', piece.title_en = 'Vanessa and the Changelings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10977 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Verloc and the Russian Embassy

UPDATE pieces piece
SET piece.title = 'Verloc and the Russian Embassy', piece.title_en = 'Verloc and the Russian Embassy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9250 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Victor's Lament

UPDATE pieces piece
SET piece.title = 'Victor''s Lament', piece.title_en = 'Victor''s Lament',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10936 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린 협주곡 1번

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 1번', piece.title_en = 'Violin Concerto no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8381 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '♩ = 104 — ♩ = 120', part.name_en = 'Violin Concerto no. 1: I. ♩ = 104 — ♩ = 120',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8381 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8938810b-5436-4f22-8a73-a968ab55747d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8938810b-5436-4f22-8a73-a968ab55747d', 1, 'I', '♩ = 104 — ♩ = 120', 'Violin Concerto no. 1: I. ♩ = 104 — ♩ = 120', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8381 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8938810b-5436-4f22-8a73-a968ab55747d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '♩ = ca. 108', part.name_en = 'Violin Concerto no. 1: II. ♩ = ca. 108',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8381 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:37db430a-bbbe-4bc1-af07-b70004e647b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37db430a-bbbe-4bc1-af07-b70004e647b5', 2, 'II', '♩ = ca. 108', 'Violin Concerto no. 1: II. ♩ = ca. 108', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8381 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37db430a-bbbe-4bc1-af07-b70004e647b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '♩ = ca. 150 — Coda. Poco meno, ♩ = 104', part.name_en = 'Violin Concerto no. 1: III. ♩ = ca. 150 — Coda. Poco meno, ♩ = 104',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8381 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c51df766-b859-44e3-9a83-56196da67dee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c51df766-b859-44e3-9a83-56196da67dee', 3, 'III', '♩ = ca. 150 — Coda. Poco meno, ♩ = 104', 'Violin Concerto no. 1: III. ♩ = ca. 150 — Coda. Poco meno, ♩ = 104', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8381 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c51df766-b859-44e3-9a83-56196da67dee'
);


-- None 바이올린 협주곡 2번 "The American Four Seasons"

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 2번 "The American Four Seasons"', piece.title_en = 'Violin Concerto no. 2 “The American Four Seasons”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8303 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Violin Concerto no. 2 “The American Four Seasons”: 1. Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8303 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8528d691-3b94-40bc-81e6-0ed2a924a849' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8528d691-3b94-40bc-81e6-0ed2a924a849', 1, NULL, 'Prologue', 'Violin Concerto no. 2 “The American Four Seasons”: 1. Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8303 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8528d691-3b94-40bc-81e6-0ed2a924a849'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Movement I', part.name_en = 'Violin Concerto no. 2 “The American Four Seasons”: 2. Movement I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8303 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:269c40df-fcc4-40c5-b8af-9736e0f5afa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:269c40df-fcc4-40c5-b8af-9736e0f5afa6', 2, NULL, 'Movement I', 'Violin Concerto no. 2 “The American Four Seasons”: 2. Movement I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8303 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:269c40df-fcc4-40c5-b8af-9736e0f5afa6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Song no. 1', part.name_en = 'Violin Concerto no. 2 “The American Four Seasons”: 3. Song no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8303 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:1e43c873-bfac-4c12-b419-d03c3b06fb0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e43c873-bfac-4c12-b419-d03c3b06fb0c', 3, NULL, 'Song no. 1', 'Violin Concerto no. 2 “The American Four Seasons”: 3. Song no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8303 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e43c873-bfac-4c12-b419-d03c3b06fb0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Movement II', part.name_en = 'Violin Concerto no. 2 “The American Four Seasons”: 4. Movement II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8303 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:9457a13d-995a-40f7-86ba-6f83370c24bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9457a13d-995a-40f7-86ba-6f83370c24bc', 4, NULL, 'Movement II', 'Violin Concerto no. 2 “The American Four Seasons”: 4. Movement II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8303 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9457a13d-995a-40f7-86ba-6f83370c24bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Song no. 2', part.name_en = 'Violin Concerto no. 2 “The American Four Seasons”: 5. Song no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8303 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:e8384c1e-5fb5-4663-8be2-11860c16fb5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8384c1e-5fb5-4663-8be2-11860c16fb5f', 5, NULL, 'Song no. 2', 'Violin Concerto no. 2 “The American Four Seasons”: 5. Song no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8303 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8384c1e-5fb5-4663-8be2-11860c16fb5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Movement III', part.name_en = 'Violin Concerto no. 2 “The American Four Seasons”: 6. Movement III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8303 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:18e73d16-675e-4f66-b728-d438a938d608' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18e73d16-675e-4f66-b728-d438a938d608', 6, NULL, 'Movement III', 'Violin Concerto no. 2 “The American Four Seasons”: 6. Movement III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8303 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18e73d16-675e-4f66-b728-d438a938d608'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Song no. 3', part.name_en = 'Violin Concerto no. 2 “The American Four Seasons”: 7. Song no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8303 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:babcaa61-6e1d-4706-852e-fe2230f69eaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:babcaa61-6e1d-4706-852e-fe2230f69eaa', 7, NULL, 'Song no. 3', 'Violin Concerto no. 2 “The American Four Seasons”: 7. Song no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8303 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:babcaa61-6e1d-4706-852e-fe2230f69eaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '8 Movement IV', part.name_en = 'Violin Concerto no. 2 “The American Four Seasons”: 8 Movement IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8303 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c241320e-0321-4395-b2e6-7a889b316a62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c241320e-0321-4395-b2e6-7a889b316a62', 8, NULL, '8 Movement IV', 'Violin Concerto no. 2 “The American Four Seasons”: 8 Movement IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8303 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c241320e-0321-4395-b2e6-7a889b316a62'
);


-- None 영화음악 <Visitors>

UPDATE pieces piece
SET piece.title = '영화음악 <Visitors>', piece.title_en = 'Visitors',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9443 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vivian’s Death / Two Marriages

UPDATE pieces piece
SET piece.title = 'Vivian’s Death / Two Marriages', piece.title_en = 'Vivian’s Death / Two Marriages',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9220 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Voices for Didgeridoo and Organ

UPDATE pieces piece
SET piece.title = 'Voices for Didgeridoo and Organ', piece.title_en = 'Voices for Didgeridoo and Organ',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8731 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Song 1', part.name_en = 'Voices for Didgeridoo and Organ: Song 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8731 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:c53b2557-452c-47c5-9d74-544e880fe904' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c53b2557-452c-47c5-9d74-544e880fe904', 1, NULL, 'Song 1', 'Voices for Didgeridoo and Organ: Song 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8731 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c53b2557-452c-47c5-9d74-544e880fe904'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Song 2', part.name_en = 'Voices for Didgeridoo and Organ: Song 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8731 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:62195aca-8894-433b-a54e-7ee91d3de959' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62195aca-8894-433b-a54e-7ee91d3de959', 2, NULL, 'Song 2', 'Voices for Didgeridoo and Organ: Song 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8731 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62195aca-8894-433b-a54e-7ee91d3de959'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Song 3', part.name_en = 'Voices for Didgeridoo and Organ: Song 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8731 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:8cb94b36-69a8-4e2b-af29-5085143710a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cb94b36-69a8-4e2b-af29-5085143710a7', 3, NULL, 'Song 3', 'Voices for Didgeridoo and Organ: Song 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8731 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cb94b36-69a8-4e2b-af29-5085143710a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Song 4', part.name_en = 'Voices for Didgeridoo and Organ: Song 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8731 AND p.composer_id = 93 AND part.part_key = 'musicbrainz:a87dec1a-f9ce-4756-988f-af85c4dc4f71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a87dec1a-f9ce-4756-988f-af85c4dc4f71', 4, NULL, 'Song 4', 'Voices for Didgeridoo and Organ: Song 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8731 AND p.composer_id = 93
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a87dec1a-f9ce-4756-988f-af85c4dc4f71'
);


-- None Where We Go

UPDATE pieces piece
SET piece.title = 'Where We Go', piece.title_en = 'Where We Go',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8149 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Why Are We Here?

UPDATE pieces piece
SET piece.title = 'Why Are We Here?', piece.title_en = 'Why Are We Here?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10650 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Wichita Vortex Sutra

UPDATE pieces piece
SET piece.title = 'Wichita Vortex Sutra', piece.title_en = 'Wichita Vortex Sutra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7502 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Winnie Goes to Sea

UPDATE pieces piece
SET piece.title = 'Winnie Goes to Sea', piece.title_en = 'Winnie Goes to Sea',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8374 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Winnie Remembers

UPDATE pieces piece
SET piece.title = 'Winnie Remembers', piece.title_en = 'Winnie Remembers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9390 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Winnie?

UPDATE pieces piece
SET piece.title = 'Winnie?', piece.title_en = 'Winnie?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8234 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Zoe & Kate Watch Video>

UPDATE pieces piece
SET piece.title = '가곡 <Zoe & Kate Watch Video>', piece.title_en = 'Zoe & Kate Watch Video',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8253 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Zoe Goes to the Restaurant>

UPDATE pieces piece
SET piece.title = '가곡 <Zoe Goes to the Restaurant>', piece.title_en = 'Zoe Goes to the Restaurant',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8722 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Étoile Polaire

UPDATE pieces piece
SET piece.title = 'Étoile Polaire', piece.title_en = 'Étoile Polaire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10271 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None “For Your Own Benefit”

UPDATE pieces piece
SET piece.title = '“For Your Own Benefit”', piece.title_en = '“For Your Own Benefit”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9493 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None “I Knew You’d Come Back.”

UPDATE pieces piece
SET piece.title = '“I Knew You’d Come Back.”', piece.title_en = '“I Knew You’d Come Back.”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8632 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None “Life Is Tragic, Mrs. Constable.”

UPDATE pieces piece
SET piece.title = '“Life Is Tragic, Mrs. Constable.”', piece.title_en = '“Life Is Tragic, Mrs. Constable.”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10396 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None “My One and Only Hope…”

UPDATE pieces piece
SET piece.title = '“My One and Only Hope…”', piece.title_en = '“My One and Only Hope…”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9599 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None “When I Was a Little Girl…”

UPDATE pieces piece
SET piece.title = '“When I Was a Little Girl…”', piece.title_en = '“When I Was a Little Girl…”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7915 AND piece.composer_id = 93
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 100,000 People

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '100,000 People', '100,000 People', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '100,000 People'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89aef528-9932-4de8-932b-cb63dd741247'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '89aef528-9932-4de8-932b-cb63dd741247'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '100,000 People' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89aef528-9932-4de8-932b-cb63dd741247'
);


-- None A Drive in the Country

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'A Drive in the Country', 'A Drive in the Country', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'A Drive in the Country'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4729642b-b067-4d29-bd36-919add51aadf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4729642b-b067-4d29-bd36-919add51aadf'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'A Drive in the Country' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4729642b-b067-4d29-bd36-919add51aadf'
);


-- None 오페라 <Appomattox>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Appomattox>', 'Appomattox', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Appomattox>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31f645df-7224-415a-be49-90fada4d1ba2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31f645df-7224-415a-be49-90fada4d1ba2'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '오페라 <Appomattox>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31f645df-7224-415a-be49-90fada4d1ba2'
);


-- None Betrayal

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Betrayal', 'Betrayal', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Betrayal'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd217905-36b4-466e-b92f-66f86edd8d77'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd217905-36b4-466e-b92f-66f86edd8d77'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Betrayal' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd217905-36b4-466e-b92f-66f86edd8d77'
);


-- None 영화음악 <Candyman>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <Candyman>', 'Candyman', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <Candyman>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78f18add-6f7e-4771-a9ff-22968d49f0b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78f18add-6f7e-4771-a9ff-22968d49f0b3'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Candyman>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78f18add-6f7e-4771-a9ff-22968d49f0b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30c3ff90-4427-49c3-a27b-7b2a64c93e9b', 1, NULL, 'Helen''s Theme', 'Helen''s Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Candyman>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30c3ff90-4427-49c3-a27b-7b2a64c93e9b'
);


-- None Concerto Fantasy for Two Timpanists and Orchestra

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Concerto Fantasy for Two Timpanists and Orchestra', 'Concerto Fantasy for Two Timpanists and Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Concerto Fantasy for Two Timpanists and Orchestra'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a615f22-745f-4f4e-8eda-5a51db8db91a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a615f22-745f-4f4e-8eda-5a51db8db91a'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Concerto Fantasy for Two Timpanists and Orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a615f22-745f-4f4e-8eda-5a51db8db91a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0e8d8bd-b159-4201-9822-93db6c5aed02', 1, NULL, 'I', 'Concerto Fantasy for Two Timpanists and Orchestra: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Concerto Fantasy for Two Timpanists and Orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0e8d8bd-b159-4201-9822-93db6c5aed02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:315bf6b6-8782-4caf-88c1-eff6f621ead8', 2, NULL, 'II', 'Concerto Fantasy for Two Timpanists and Orchestra: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Concerto Fantasy for Two Timpanists and Orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:315bf6b6-8782-4caf-88c1-eff6f621ead8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4562bd35-aea2-4d51-9dda-15893bd915c2', 3, NULL, 'Cadenza', 'Concerto Fantasy for Two Timpanists and Orchestra: Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Concerto Fantasy for Two Timpanists and Orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4562bd35-aea2-4d51-9dda-15893bd915c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e10dcfbd-3d8b-4b3d-9c0e-47ded6cbcd0c', 4, NULL, 'III', 'Concerto Fantasy for Two Timpanists and Orchestra: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Concerto Fantasy for Two Timpanists and Orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e10dcfbd-3d8b-4b3d-9c0e-47ded6cbcd0c'
);


-- None Confession

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Confession', 'Confession', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Confession'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '969e30b0-957a-4b9e-b29b-cb46755bd4b3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '969e30b0-957a-4b9e-b29b-cb46755bd4b3'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Confession' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '969e30b0-957a-4b9e-b29b-cb46755bd4b3'
);


-- None Discovery

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Discovery', 'Discovery', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Discovery'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '765f69c1-f732-4a3b-8b5d-9f695b57b9cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '765f69c1-f732-4a3b-8b5d-9f695b57b9cb'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Discovery' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '765f69c1-f732-4a3b-8b5d-9f695b57b9cb'
);


-- None Gone

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Gone', 'Gone', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Gone'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc11bec5-d155-40d1-8111-2a2c51a083a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc11bec5-d155-40d1-8111-2a2c51a083a8'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Gone' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc11bec5-d155-40d1-8111-2a2c51a083a8'
);


-- None Helen's Theme

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Helen''s Theme', 'Helen''s Theme', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Helen''s Theme'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed54afac-f22c-4f59-8548-ce4ce494196e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed54afac-f22c-4f59-8548-ce4ce494196e'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Helen''s Theme' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed54afac-f22c-4f59-8548-ce4ce494196e'
);


-- None 가곡 <Help Me>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Help Me>', 'Help Me', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Help Me>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00b36d8f-77ea-44b2-9931-f9e21d6c9d05'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00b36d8f-77ea-44b2-9931-f9e21d6c9d05'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '가곡 <Help Me>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00b36d8f-77ea-44b2-9931-f9e21d6c9d05'
);


-- None Invitation

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Invitation', 'Invitation', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Invitation'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fb5b08b-5c68-4209-9447-9e2245b5530c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2fb5b08b-5c68-4209-9447-9e2245b5530c'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Invitation' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fb5b08b-5c68-4209-9447-9e2245b5530c'
);


-- None 영화음악 <Koyaanisqatsi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <Koyaanisqatsi>', 'Koyaanisqatsi', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <Koyaanisqatsi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4a6780c-6c0c-450f-b398-24bab7e2e09c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c4a6780c-6c0c-450f-b398-24bab7e2e09c'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4a6780c-6c0c-450f-b398-24bab7e2e09c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2134d98-556e-44b2-9225-14afd7b1fc9f', 1, NULL, 'Koyaanisqatsi', 'Koyaanisqatsi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2134d98-556e-44b2-9225-14afd7b1fc9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9df5577-29f5-4238-839e-0e75ad2af53f', 2, NULL, 'Organic', 'Organic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9df5577-29f5-4238-839e-0e75ad2af53f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c542eeea-3245-45d9-996b-dba7df2fb651', 3, NULL, 'Cloudscape', 'Cloudscape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c542eeea-3245-45d9-996b-dba7df2fb651'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b448e81f-4219-408a-badd-eb7b48cddda4', 4, NULL, 'Resource', 'Resource', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b448e81f-4219-408a-badd-eb7b48cddda4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c9745bf-c63d-4112-b244-f52cd9755012', 5, NULL, 'Vessels', 'Vessels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c9745bf-c63d-4112-b244-f52cd9755012'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f803ae7f-a0fd-4381-85d3-8319da254030', 6, NULL, 'Pruit Igoe', 'Pruit Igoe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f803ae7f-a0fd-4381-85d3-8319da254030'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1b4f27e-9bdc-46c5-937a-594379cc9ff9', 7, NULL, 'Pruitt Igoe Coda', 'Pruitt Igoe Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b4f27e-9bdc-46c5-937a-594379cc9ff9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31f39502-6c15-4e7c-8782-536e579f9afd', 8, NULL, 'SloMo People', 'SloMo People', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31f39502-6c15-4e7c-8782-536e579f9afd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8111b62c-aa37-4703-ac08-6f621652ee4e', 9, NULL, 'The Grid Introduction', 'The Grid Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8111b62c-aa37-4703-ac08-6f621652ee4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c5366eb-718c-4f9f-a403-c4c4aeac319f', 10, NULL, 'The Grid', 'The Grid', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c5366eb-718c-4f9f-a403-c4c4aeac319f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ee0791e-cf33-406e-9108-1fb6d9f8ab49', 11, NULL, 'Microchip', 'Microchip', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ee0791e-cf33-406e-9108-1fb6d9f8ab49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41b85ad1-e3e4-4489-8469-0e26cd77bea7', 12, NULL, 'Prophecies', 'Prophecies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41b85ad1-e3e4-4489-8469-0e26cd77bea7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62e152d4-bd22-495c-aa2a-5698f7175bec', 13, NULL, 'Translations and Credits', 'Translations and Credits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Koyaanisqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e152d4-bd22-495c-aa2a-5698f7175bec'
);


-- None 영화음악 <Naqoyqatsi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <Naqoyqatsi>', 'Naqoyqatsi', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <Naqoyqatsi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4ce50a1-e219-4b2b-b7d6-266a101265d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4ce50a1-e219-4b2b-b7d6-266a101265d4'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4ce50a1-e219-4b2b-b7d6-266a101265d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c8a94a7-d401-4a16-bbaa-e177dffad3cd', 1, NULL, 'Massman', 'Massman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c8a94a7-d401-4a16-bbaa-e177dffad3cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2347c896-487f-4c15-86b8-7578205a8576', 2, NULL, 'New World', 'New World', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2347c896-487f-4c15-86b8-7578205a8576'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26519b45-fc6f-4a53-b671-c0bc3f5f631c', 3, NULL, 'The Vivid Unknown', 'The Vivid Unknown', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26519b45-fc6f-4a53-b671-c0bc3f5f631c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4202bcfa-603b-4727-8766-a7677657ac63', 4, NULL, 'Intensive Time', 'Intensive Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4202bcfa-603b-4727-8766-a7677657ac63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f29f312-ff04-45e5-b012-8c6dc946cfed', 5, NULL, 'Religion', 'Religion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f29f312-ff04-45e5-b012-8c6dc946cfed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8245f22c-2f2f-4cfb-9cc6-534166257f4d', 6, NULL, 'Media Weather', 'Media Weather', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8245f22c-2f2f-4cfb-9cc6-534166257f4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acb84208-62f4-461d-b5a2-3ea100ed428b', 7, NULL, 'Old World', 'Old World', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acb84208-62f4-461d-b5a2-3ea100ed428b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c68595e7-23f9-49e8-924e-ac957011efba', 8, NULL, 'Primacy of Number', 'Primacy of Number', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c68595e7-23f9-49e8-924e-ac957011efba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de45e9fd-3989-4a8d-b4d1-ce46072b49cc', 9, NULL, 'Point Blank', 'Point Blank', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de45e9fd-3989-4a8d-b4d1-ce46072b49cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df5eb308-a654-4fce-9691-7cfe954bbeca', 10, NULL, 'Naqoyqatsi', 'Naqoyqatsi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df5eb308-a654-4fce-9691-7cfe954bbeca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eacf01e1-3f03-4664-9a63-447914f7cfa9', 11, NULL, 'Definition', 'Definition', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Naqoyqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eacf01e1-3f03-4664-9a63-447914f7cfa9'
);


-- None Opening

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Opening', 'Opening', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Opening'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07693745-47e6-3356-ae3f-7ef79ce891ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07693745-47e6-3356-ae3f-7ef79ce891ee'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Opening' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07693745-47e6-3356-ae3f-7ef79ce891ee'
);


-- None 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡', 'Overture', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '96b18c5e-4795-366a-b968-32c7dceff922'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '96b18c5e-4795-366a-b968-32c7dceff922'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '서곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '96b18c5e-4795-366a-b968-32c7dceff922'
);


-- None 피아노 협주곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번', 'Piano Concerto no. 2', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31c18546-cb5c-424b-af28-4f4d78a8912c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31c18546-cb5c-424b-af28-4f4d78a8912c'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '피아노 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31c18546-cb5c-424b-af28-4f4d78a8912c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e07d782-0418-41bf-ae1b-568863db6426', 1, 'I', 'The Vision', 'Piano Concerto no. 2: I. The Vision', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '피아노 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e07d782-0418-41bf-ae1b-568863db6426'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a557489-46e7-44d9-a35c-fadad60fde70', 2, 'II', 'Sacagawea', 'Piano Concerto no. 2: II. Sacagawea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '피아노 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a557489-46e7-44d9-a35c-fadad60fde70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1ba2044-0e81-4379-92c2-b92acb28d6d5', 3, 'III', 'The Land', 'Piano Concerto no. 2: III. The Land', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '피아노 협주곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1ba2044-0e81-4379-92c2-b92acb28d6d5'
);


-- None 영화음악 <Powaqqatsi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <Powaqqatsi>', 'Powaqqatsi', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <Powaqqatsi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '897d626e-b351-4e6b-a903-4fa4fe066ad8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '897d626e-b351-4e6b-a903-4fa4fe066ad8'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '897d626e-b351-4e6b-a903-4fa4fe066ad8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad8e414-823a-4b37-8c39-08c9e3db56da', 1, NULL, 'Anthem of the New World Part 1', 'Anthem of the New World Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad8e414-823a-4b37-8c39-08c9e3db56da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12ac1018-cb89-4262-afa8-49453ea8e57c', 2, NULL, 'That Place', 'That Place', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12ac1018-cb89-4262-afa8-49453ea8e57c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28a26f5d-cd0c-448d-9097-b8220b7ae293', 3, NULL, 'Serra Pellada', 'Serra Pellada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28a26f5d-cd0c-448d-9097-b8220b7ae293'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31811514-88ad-40bb-a727-baba41bc6197', 4, NULL, 'New Cities in Ancient Lands, Africa', 'New Cities in Ancient Lands, Africa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31811514-88ad-40bb-a727-baba41bc6197'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42fe4c30-2918-49f3-a935-80b53d9b9e82', 5, NULL, 'Train to São Paulo', 'Train to São Paulo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42fe4c30-2918-49f3-a935-80b53d9b9e82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:593c2d8b-e0ec-463b-9fd0-502ae0a7e29b', 6, NULL, 'Mr. Suso #2 With Reflection', 'Mr. Suso #2 With Reflection', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:593c2d8b-e0ec-463b-9fd0-502ae0a7e29b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d5a427e-a6ae-4133-978e-e0a5d7260086', 7, NULL, 'The Unutterable', 'The Unutterable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d5a427e-a6ae-4133-978e-e0a5d7260086'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63cafaeb-d632-4fdb-885f-2a9961d7f88a', 8, NULL, 'Video Dream', 'Video Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63cafaeb-d632-4fdb-885f-2a9961d7f88a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d066915-0af3-410d-8a4a-fa029a96115b', 9, NULL, 'Anthem of the New World Part 3', 'Anthem of the New World Part 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d066915-0af3-410d-8a4a-fa029a96115b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fe5ae99-5e8d-4514-8d3c-af9d3519306f', 10, NULL, 'From Egypt', 'From Egypt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fe5ae99-5e8d-4514-8d3c-af9d3519306f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:857e2c47-cbf8-443e-b55a-9e986d15bed0', 11, NULL, 'New Cities in Ancient Lands, China', 'New Cities in Ancient Lands, China', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:857e2c47-cbf8-443e-b55a-9e986d15bed0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bdfeb8a-baa5-4cbf-ad04-badab8d51e9b', 12, NULL, 'Caught', 'Caught', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bdfeb8a-baa5-4cbf-ad04-badab8d51e9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:919918ba-7688-441d-8943-203a4ee08b8b', 13, NULL, 'Mr. Suso #1', 'Mr. Suso #1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:919918ba-7688-441d-8943-203a4ee08b8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bc0faca-af5a-479b-bb51-2d0753e059c7', 14, NULL, 'Mosque and Temple', 'Mosque and Temple', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bc0faca-af5a-479b-bb51-2d0753e059c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b53c7741-3df7-49ba-982f-73219c8f35df', 15, NULL, 'New Cities in Ancient Lands, India', 'New Cities in Ancient Lands, India', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b53c7741-3df7-49ba-982f-73219c8f35df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd6b3d52-542a-4e69-ac1e-85e3ed86224b', 16, NULL, 'The Title', 'The Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd6b3d52-542a-4e69-ac1e-85e3ed86224b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c430d39d-7644-47bf-a95c-022f49756cea', 17, NULL, 'Anthem of the New World Part 2', 'Anthem of the New World Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c430d39d-7644-47bf-a95c-022f49756cea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcdf92e9-b7d7-4c16-a45d-22a944df9b4f', 18, NULL, 'Powaqqatsi', 'Powaqqatsi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <Powaqqatsi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcdf92e9-b7d7-4c16-a45d-22a944df9b4f'
);


-- None Renfield

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Renfield', 'Renfield', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Renfield'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5153eba-00b0-4066-a80e-8b120cb88616'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5153eba-00b0-4066-a80e-8b120cb88616'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Renfield' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5153eba-00b0-4066-a80e-8b120cb88616'
);


-- None 바이올린과 피아노를 위한 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 소나타', 'Sonata for Violin and Piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be303f26-8712-41ab-8292-dac1c9e66d70'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be303f26-8712-41ab-8292-dac1c9e66d70'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '바이올린과 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be303f26-8712-41ab-8292-dac1c9e66d70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bedd4ce9-2055-4ad2-87ec-7c5de3dae779', 1, 'I', 'Movement I', 'Sonata for Violin and Piano: I. Movement I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '바이올린과 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bedd4ce9-2055-4ad2-87ec-7c5de3dae779'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:796522ed-e304-457d-9a3b-f9a2c0895e6b', 2, 'II', 'Movement II', 'Sonata for Violin and Piano: II. Movement II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '바이올린과 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:796522ed-e304-457d-9a3b-f9a2c0895e6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef511d92-9ef5-4464-b231-d895749babc6', 3, 'III', 'Movement III', 'Sonata for Violin and Piano: III. Movement III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '바이올린과 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef511d92-9ef5-4464-b231-d895749babc6'
);


-- None 연가곡집 <Songs from Liquid Days>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <Songs from Liquid Days>', 'Songs from Liquid Days', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <Songs from Liquid Days>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f84a8f8b-9f0c-46fb-892a-319b6eaeaed5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f84a8f8b-9f0c-46fb-892a-319b6eaeaed5'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '연가곡집 <Songs from Liquid Days>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f84a8f8b-9f0c-46fb-892a-319b6eaeaed5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b38d9f42-b858-3825-b1ab-3d11906debe2', 1, 'I', 'Changing Opinion', 'Songs from Liquid Days: I. Changing Opinion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '연가곡집 <Songs from Liquid Days>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b38d9f42-b858-3825-b1ab-3d11906debe2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f659724-246a-34eb-8714-185dd6b4cfac', 2, 'II', 'Lightning', 'Songs from Liquid Days: II. Lightning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '연가곡집 <Songs from Liquid Days>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f659724-246a-34eb-8714-185dd6b4cfac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdb34338-9bbc-33ad-8c16-09039777e79e', 3, 'III', 'Freezing', 'Songs from Liquid Days: III. Freezing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '연가곡집 <Songs from Liquid Days>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdb34338-9bbc-33ad-8c16-09039777e79e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a98f43b-34f8-3ca2-8c10-bedf2e3ee7d9', 4, 'IV', 'Liquid Days', 'Songs from Liquid Days: IV. Liquid Days', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '연가곡집 <Songs from Liquid Days>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a98f43b-34f8-3ca2-8c10-bedf2e3ee7d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f9afca0-cede-3281-8ddc-bfe7392976e6', 5, 'V', 'Open the Kingdom', 'Songs from Liquid Days: V. Open the Kingdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '연가곡집 <Songs from Liquid Days>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f9afca0-cede-3281-8ddc-bfe7392976e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01e8464e-809c-396d-97a8-748ba809d686', 6, 'VI', 'Forgetting', 'Songs from Liquid Days: VI. Forgetting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '연가곡집 <Songs from Liquid Days>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01e8464e-809c-396d-97a8-748ba809d686'
);


-- None 현악 4중주 5번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 5번', 'String Quartet no. 5', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 5번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54860ac7-42ee-4c3a-9639-9227effb8af6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54860ac7-42ee-4c3a-9639-9227effb8af6'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54860ac7-42ee-4c3a-9639-9227effb8af6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:922eae8e-da35-4dfe-bcfa-892e73dcf173', 1, NULL, 'I', 'String Quartet no. 5: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:922eae8e-da35-4dfe-bcfa-892e73dcf173'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68962f45-590e-4e05-9b63-be8226fc5010', 2, NULL, 'II', 'String Quartet no. 5: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68962f45-590e-4e05-9b63-be8226fc5010'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbb7f883-3b98-4edd-896e-efdb82cd67c1', 3, NULL, 'III', 'String Quartet no. 5: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb7f883-3b98-4edd-896e-efdb82cd67c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a643570e-9aca-4621-a659-bc7111ac839a', 4, NULL, 'IV', 'String Quartet no. 5: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a643570e-9aca-4621-a659-bc7111ac839a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d85a8146-6619-4a87-85f5-95b564006d08', 5, NULL, 'V', 'String Quartet no. 5: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d85a8146-6619-4a87-85f5-95b564006d08'
);


-- None Suspicion

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Suspicion', 'Suspicion', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Suspicion'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30bfdc95-59f4-4e73-a7e9-c093050c7687'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30bfdc95-59f4-4e73-a7e9-c093050c7687'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Suspicion' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30bfdc95-59f4-4e73-a7e9-c093050c7687'
);


-- None 교향곡 11번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 11번', 'Symphony no. 11', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 11번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5192d563-d99f-481b-97a5-94adf72f0c9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5192d563-d99f-481b-97a5-94adf72f0c9e'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5192d563-d99f-481b-97a5-94adf72f0c9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fdc9795-b33c-468a-9c38-7612a25c6188', 1, NULL, 'I', 'Symphony no. 11: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fdc9795-b33c-468a-9c38-7612a25c6188'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:884a6d68-cdc1-46c8-ac54-1c3bea3496f4', 2, NULL, 'II', 'Symphony no. 11: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:884a6d68-cdc1-46c8-ac54-1c3bea3496f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:731305c7-802b-4c29-b986-cbd06df698aa', 3, NULL, 'III', 'Symphony no. 11: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 11번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:731305c7-802b-4c29-b986-cbd06df698aa'
);


-- None 교향곡 8번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 8번', 'Symphony no. 8', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 8번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35f705b6-c39a-47e1-8915-03d10ffa5011'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35f705b6-c39a-47e1-8915-03d10ffa5011'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35f705b6-c39a-47e1-8915-03d10ffa5011'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f396def3-be6d-44fc-89c4-2224366426cc', 1, NULL, 'I', 'Symphony no. 8: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f396def3-be6d-44fc-89c4-2224366426cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c247213-ec30-4244-b16e-236e46bad3aa', 2, NULL, 'II', 'Symphony no. 8: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c247213-ec30-4244-b16e-236e46bad3aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5961648c-6488-4a54-bf19-89619c7e5521', 3, NULL, 'III', 'Symphony no. 8: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 8번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5961648c-6488-4a54-bf19-89619c7e5521'
);


-- None 교향곡 9번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 9번', 'Symphony no. 9', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 9번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf7e2c14-6ca0-4241-9a3e-b0727d6a67a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf7e2c14-6ca0-4241-9a3e-b0727d6a67a3'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf7e2c14-6ca0-4241-9a3e-b0727d6a67a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6661be3-4aad-42a1-af3f-dbd3f5f47858', 1, NULL, 'I', 'Symphony no. 9: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6661be3-4aad-42a1-af3f-dbd3f5f47858'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e30cc4a3-18fa-4ded-876c-113a005614bc', 2, NULL, 'II', 'Symphony no. 9: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e30cc4a3-18fa-4ded-876c-113a005614bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38275e2e-a7c0-475d-9e01-2fea2f5526c3', 3, NULL, 'III', 'Symphony no. 9: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '교향곡 9번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38275e2e-a7c0-475d-9e01-2fea2f5526c3'
);


-- None The Argument

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Argument', 'The Argument', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Argument'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b86420fc-e449-4f0e-a6ca-eadfa31cf3a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b86420fc-e449-4f0e-a6ca-eadfa31cf3a3'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'The Argument' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b86420fc-e449-4f0e-a6ca-eadfa31cf3a3'
);


-- None The Bedroom

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Bedroom', 'The Bedroom', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Bedroom'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04d28ecd-8734-3ffc-8439-2583f4eb39c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '04d28ecd-8734-3ffc-8439-2583f4eb39c9'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'The Bedroom' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '04d28ecd-8734-3ffc-8439-2583f4eb39c9'
);


-- None The Chase

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Chase', 'The Chase', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Chase'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61727825-2a5c-4c5b-8bcd-2ff473ff4dd1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61727825-2a5c-4c5b-8bcd-2ff473ff4dd1'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'The Chase' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61727825-2a5c-4c5b-8bcd-2ff473ff4dd1'
);


-- None 영화음악 <The Family>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <The Family>', 'The Family', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <The Family>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ff6c7de-913b-4b21-97b1-eaed5b677dcb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ff6c7de-913b-4b21-97b1-eaed5b677dcb'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Family>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ff6c7de-913b-4b21-97b1-eaed5b677dcb'
);


-- None 영화음악 <The Hours>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <The Hours>', 'The Hours', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <The Hours>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc66b6d4-ff32-4d24-b370-6a1974b8d16d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc66b6d4-ff32-4d24-b370-6a1974b8d16d'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc66b6d4-ff32-4d24-b370-6a1974b8d16d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02f4500a-880c-4bf0-97a7-0706ef713a1b', 1, NULL, 'The Kiss', 'The Kiss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02f4500a-880c-4bf0-97a7-0706ef713a1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4142904c-6eca-38c4-9f40-1e7a802fd86d', 2, NULL, 'An Unwelcome Friend', 'An Unwelcome Friend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4142904c-6eca-38c4-9f40-1e7a802fd86d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7aa18b60-0201-3c55-ab46-04a5694a307c', 3, NULL, 'Dead Things', 'Dead Things', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aa18b60-0201-3c55-ab46-04a5694a307c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ca17eef-b47b-34b7-a9d0-42861b9a8eec', 4, NULL, 'I’m Going to Make a Cake', 'I’m Going to Make a Cake', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ca17eef-b47b-34b7-a9d0-42861b9a8eec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8db51614-8de9-3bb7-8624-2922ebea16db', 5, NULL, 'The Poet Acts', 'The Poet Acts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8db51614-8de9-3bb7-8624-2922ebea16db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd524aff-c6f4-38ca-93fa-11f8406e67b8', 6, NULL, 'The Hours', 'The Hours', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd524aff-c6f4-38ca-93fa-11f8406e67b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c431bd46-83e0-3d80-b1e0-1c0112bc2352', 7, NULL, 'Tearing Herself Away', 'Tearing Herself Away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c431bd46-83e0-3d80-b1e0-1c0112bc2352'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c913188c-5077-3bb3-b421-4c085a09d66c', 8, NULL, 'Choosing Life', 'Choosing Life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c913188c-5077-3bb3-b421-4c085a09d66c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd734099-6426-3ae8-859b-8bf07db7e6ea', 9, NULL, 'Why Does Someone Have to Die?', 'Why Does Someone Have to Die?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd734099-6426-3ae8-859b-8bf07db7e6ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d11bbebe-8a74-34fc-9b4d-b51106776152', 10, NULL, 'Something She Has to Do', 'Something She Has to Do', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d11bbebe-8a74-34fc-9b4d-b51106776152'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0f641a5-e7d0-3763-9586-930f69e3655b', 11, NULL, 'Escape!', 'Escape!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0f641a5-e7d0-3763-9586-930f69e3655b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f193f24f-224d-3882-aab8-03908960f699', 12, NULL, 'Morning Passages', 'Morning Passages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Hours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f193f24f-224d-3882-aab8-03908960f699'
);


-- None 영화음악 <The Illusionist>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <The Illusionist>', 'The Illusionist', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <The Illusionist>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14938ce5-6061-4c2e-a45c-a3e9a36c7f8f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14938ce5-6061-4c2e-a45c-a3e9a36c7f8f'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14938ce5-6061-4c2e-a45c-a3e9a36c7f8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05ebe0f7-b176-3652-ba45-a925657f47c9', 1, NULL, 'The Missing Gem', 'The Missing Gem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05ebe0f7-b176-3652-ba45-a925657f47c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ae779b9-63d8-32e6-867c-4a395fe42154', 2, NULL, 'Chance Encounter', 'Chance Encounter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ae779b9-63d8-32e6-867c-4a395fe42154'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bd49222-a53c-3cbd-93f1-c41de17e1b03', 3, NULL, 'Do You Know Me?', 'Do You Know Me?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd49222-a53c-3cbd-93f1-c41de17e1b03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26378fb2-93ad-32a0-89bb-1edb227a996e', 4, NULL, 'Life in the Mountains', 'Life in the Mountains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26378fb2-93ad-32a0-89bb-1edb227a996e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27be4fab-609f-3252-9295-3a1609dcbaed', 5, NULL, 'The New Theater', 'The New Theater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27be4fab-609f-3252-9295-3a1609dcbaed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bc7466d-a55b-3050-9793-daf593ce6435', 6, NULL, 'Frankel Appears', 'Frankel Appears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bc7466d-a55b-3050-9793-daf593ce6435'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36da17fb-59a7-3612-a30c-593a6f6006b8', 7, NULL, 'Eisenheim Disappears', 'Eisenheim Disappears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36da17fb-59a7-3612-a30c-593a6f6006b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d4cf848-0a3f-3f54-b0b7-66b74b7ee22a', 8, NULL, 'The Chase', 'The Chase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d4cf848-0a3f-3f54-b0b7-66b74b7ee22a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f59496f-ceda-395b-8231-eb035630b0a6', 9, NULL, 'The Accident', 'The Accident', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f59496f-ceda-395b-8231-eb035630b0a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:663a7ea5-c9ff-30dc-9bd9-a3cb2d7d02a6', 10, NULL, 'The Locket', 'The Locket', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:663a7ea5-c9ff-30dc-9bd9-a3cb2d7d02a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dab8213-635f-3a26-a83c-c422b7510a54', 11, NULL, 'The Illusionist', 'The Illusionist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dab8213-635f-3a26-a83c-c422b7510a54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:896c8178-49e2-3a5c-8cbc-edf0a130dea1', 12, NULL, 'Meeting in the Carriage', 'Meeting in the Carriage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:896c8178-49e2-3a5c-8cbc-edf0a130dea1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d7293b8-626c-340b-99c5-8d3a250f445d', 13, NULL, 'Wish I Would See You Again', 'Wish I Would See You Again', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d7293b8-626c-340b-99c5-8d3a250f445d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fab9b03-e6bf-34c7-9dea-641592d7e15f', 14, NULL, 'The Orange Tree', 'The Orange Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fab9b03-e6bf-34c7-9dea-641592d7e15f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b219a73d-d2e6-3d61-b7be-bac865385035', 15, NULL, 'The Secret Plot', 'The Secret Plot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b219a73d-d2e6-3d61-b7be-bac865385035'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba330549-16b6-3cd8-871d-6ee18369c64f', 16, NULL, 'Sophie''s Ride to the Castle', 'Sophie''s Ride to the Castle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba330549-16b6-3cd8-871d-6ee18369c64f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beb40cda-a682-3500-a12e-414b731cce86', 17, NULL, 'A Shout From the Crowd', 'A Shout From the Crowd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beb40cda-a682-3500-a12e-414b731cce86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee69677b-18c8-3425-895e-293b02f0112f', 18, NULL, 'Sophie', 'Sophie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee69677b-18c8-3425-895e-293b02f0112f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f28af93f-1d06-3d69-b05e-7c4f60ece512', 19, NULL, 'The Search', 'The Search', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f28af93f-1d06-3d69-b05e-7c4f60ece512'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5395525-e6f8-3265-9f9a-7586a37bc4f1', 20, NULL, 'The Mirror', 'The Mirror', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5395525-e6f8-3265-9f9a-7586a37bc4f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa25e86c-3739-3ca1-bcbf-23df5dcf1692', 21, NULL, 'The Sword', 'The Sword', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Illusionist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa25e86c-3739-3ca1-bcbf-23df5dcf1692'
);


-- None The Kiss

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Kiss', 'The Kiss', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Kiss'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2aa9f0e9-c38e-480d-bf9f-049b6970f1d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2aa9f0e9-c38e-480d-bf9f-049b6970f1d1'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'The Kiss' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2aa9f0e9-c38e-480d-bf9f-049b6970f1d1'
);


-- None The Light

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Light', 'The Light', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Light'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46aac998-494e-484d-ad1a-82a33916a180'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46aac998-494e-484d-ad1a-82a33916a180'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'The Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46aac998-494e-484d-ad1a-82a33916a180'
);


-- None 영화음악 <The Thin Blue Line>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <The Thin Blue Line>', 'The Thin Blue Line', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <The Thin Blue Line>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89383861-70bd-4ad8-9d70-b1441ad7747f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '89383861-70bd-4ad8-9d70-b1441ad7747f'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89383861-70bd-4ad8-9d70-b1441ad7747f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b8aa7d3-ed91-46cb-b00f-81e8ea41f586', 1, NULL, 'The Trial, Part One', 'The Trial, Part One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b8aa7d3-ed91-46cb-b00f-81e8ea41f586'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ea29be9-27ef-4ea8-9c38-8df1d3b72db3', 2, NULL, 'Comets & Vegas', 'Comets & Vegas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ea29be9-27ef-4ea8-9c38-8df1d3b72db3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16c9b9ae-1773-49fa-895c-38c7b12a2dfb', 3, NULL, 'The Defense Attorneys, Part Two', 'The Defense Attorneys, Part Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16c9b9ae-1773-49fa-895c-38c7b12a2dfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20ea1ed4-bbd1-4b9b-b9dd-a368456e3efe', 4, NULL, 'Turko, Part One', 'Turko, Part One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20ea1ed4-bbd1-4b9b-b9dd-a368456e3efe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37811d7d-f1c7-4728-996f-b834dafef6f5', 5, NULL, 'The Mystery Eyewitness, Part Three', 'The Mystery Eyewitness, Part Three', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37811d7d-f1c7-4728-996f-b834dafef6f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3baa85d3-4197-4c82-8355-475378991095', 6, NULL, 'The Mystery Eyewitness, Part Four', 'The Mystery Eyewitness, Part Four', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3baa85d3-4197-4c82-8355-475378991095'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d649ace-2d5c-4ff5-8e2f-6123eda472fd', 7, NULL, 'The Trial, Part Two', 'The Trial, Part Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d649ace-2d5c-4ff5-8e2f-6123eda472fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40530ca9-3051-4338-908c-a447437825d8', 8, NULL, 'Dr. Death', 'Dr. Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40530ca9-3051-4338-908c-a447437825d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:478cbeef-a3f6-4591-ae38-93066ed90f97', 9, NULL, 'Vidor', 'Vidor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:478cbeef-a3f6-4591-ae38-93066ed90f97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4aaf47bc-18d4-41af-a162-188b748710dd', 10, NULL, 'The Mystery Eyewitness, Part Five', 'The Mystery Eyewitness, Part Five', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aaf47bc-18d4-41af-a162-188b748710dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d575467-3ada-47fb-bd21-8a4aa8e8613e', 11, NULL, 'Opening Credits', 'Opening Credits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d575467-3ada-47fb-bd21-8a4aa8e8613e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e4009ca-c016-4ed8-85c4-e8b4a5a762f1', 12, NULL, 'The Mystery Eyewitness, Part One', 'The Mystery Eyewitness, Part One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e4009ca-c016-4ed8-85c4-e8b4a5a762f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5152c8f2-62f3-4b52-958f-e7211f94a0fe', 13, NULL, 'Interrogation, Part One', 'Interrogation, Part One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5152c8f2-62f3-4b52-958f-e7211f94a0fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:546476d5-d5a0-4779-8bb5-0e8bb493a704', 14, NULL, 'The Electric Chair', 'The Electric Chair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:546476d5-d5a0-4779-8bb5-0e8bb493a704'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:674f5b30-402b-476c-9baf-128b91aa6ed1', 15, NULL, 'End Credits', 'End Credits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:674f5b30-402b-476c-9baf-128b91aa6ed1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:842a6dfd-2cdf-44bd-addf-b192fbbbc873', 16, NULL, 'The Mystery Eyewitness, Part Two', 'The Mystery Eyewitness, Part Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:842a6dfd-2cdf-44bd-addf-b192fbbbc873'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:880705d1-379d-47cd-b9f3-d40fbcdaabcd', 17, NULL, 'Harris'' Story', 'Harris'' Story', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:880705d1-379d-47cd-b9f3-d40fbcdaabcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8be464d8-68d0-4c4e-83c8-3e51e468d204', 18, NULL, 'Elba Carr', 'Elba Carr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8be464d8-68d0-4c4e-83c8-3e51e468d204'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99fbdf0c-eb08-46df-8948-1c3015b3eda9', 19, NULL, 'Interrogation, Part Two', 'Interrogation, Part Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99fbdf0c-eb08-46df-8948-1c3015b3eda9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bfa918b-bc65-417f-9d3e-19b2dca53cb2', 20, NULL, 'Houston Skyline', 'The Thin Blue Line: Houston Skyline', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bfa918b-bc65-417f-9d3e-19b2dca53cb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a14186fd-fae9-4ab4-8bec-abc40ff90641', 21, NULL, 'The Thin Blue Line', 'The Thin Blue Line', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a14186fd-fae9-4ab4-8bec-abc40ff90641'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8064691-d526-4ffd-9458-25f15a75676e', 22, NULL, 'Hell on Earth', 'Hell on Earth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8064691-d526-4ffd-9458-25f15a75676e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8d77999-eb4a-49de-8191-26cc86141a31', 23, NULL, 'The Judge', 'The Judge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8d77999-eb4a-49de-8191-26cc86141a31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adcdaf27-17fc-43df-91bd-62267dafe053', 24, NULL, 'Turko, Part Two', 'Turko, Part Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adcdaf27-17fc-43df-91bd-62267dafe053'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b64cc6a3-a31f-4f55-aff6-a043ca6300c7', 25, NULL, 'The Confession', 'The Confession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b64cc6a3-a31f-4f55-aff6-a043ca6300c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1f36c94-2a41-4d07-bbbd-2d1b9eb24582', 26, NULL, 'Adams'' Story', 'Adams'' Story', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1f36c94-2a41-4d07-bbbd-2d1b9eb24582'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd58032f-1cfc-4192-bdaf-fcfa6453485c', 27, NULL, 'Harris'' Testimony', 'Harris'' Testimony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd58032f-1cfc-4192-bdaf-fcfa6453485c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2478161-e173-42dc-bac8-90560e818231', 28, NULL, 'Harris'' Crimes, Part Two', 'Harris'' Crimes, Part Two', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2478161-e173-42dc-bac8-90560e818231'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed308790-9112-46ae-93dc-0e0efcb1d484', 29, NULL, 'Harris'' Childhood', 'Harris'' Childhood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed308790-9112-46ae-93dc-0e0efcb1d484'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1881f8c-3718-4ca2-953e-01a8d6896ce1', 30, NULL, 'The Defense Attorneys, Part One', 'The Defense Attorneys, Part One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1881f8c-3718-4ca2-953e-01a8d6896ce1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f38cffb6-ec3f-4356-8ade-a674c6ed8527', 31, NULL, 'Harris'' Crimes, Part One', 'Harris'' Crimes, Part One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 93 AND p.title = '영화음악 <The Thin Blue Line>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f38cffb6-ec3f-4356-8ade-a674c6ed8527'
);


-- None Vertigo

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Vertigo', 'Vertigo', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 93
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Vertigo'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '438cc333-b1ae-44b1-9966-3e959ea60b00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '438cc333-b1ae-44b1-9966-3e959ea60b00'
FROM pieces p
WHERE p.composer_id = 93 AND p.title = 'Vertigo' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '438cc333-b1ae-44b1-9966-3e959ea60b00'
);


-- 카탈로그에 대응이 없는 seed 작품 39개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 93 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7670, 7784, 7805, 7916, 7952, 8075, 8221, 8270, 8443, 8488, 8529, 8588, 8682, 8780, 8837, 8852, 8879, 9159, 9181, 9481,
    9525, 9670, 9686, 9805, 10118, 10285, 10316, 10356, 10536, 10561, 10722, 10859, 10864, 10871, 10890, 11077, 11129, 11175, 11255
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
