-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 4/11).
-- 작품 10개(새 10개), seed 186개 중 잇기 185·숨김 1·그대로 0.
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

-- ===== Terry Plumeri (composer_id 419) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 10개 중 음반 묶음 10개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 0개,
-- 새 작품 10개, part 208개, 그 아래 0개.
-- seed 186개 중 185개를 음반 묶음 안 곡으로 잇고, 0개는 낱개 작품으로 두고, 1개를 숨긴다.

-- None Black Sea Raid

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Black Sea Raid', 'Black Sea Raid', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Black Sea Raid'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24962 AND linked.composer_id = 419), 'musicbrainz:a0678246-478e-4a34-a3b8-017c34a098ee', 1, NULL, 'Burial at Sea', 'Burial at Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0678246-478e-4a34-a3b8-017c34a098ee'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Burial at Sea"', piece.title_en = 'Black Sea Raid: Burial at Sea', piece.editor_locked = 1
WHERE piece.id = 24962 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23309 AND linked.composer_id = 419), 'musicbrainz:0b97909d-cb07-4fc3-91b7-7e0e65ef65a7', 2, NULL, 'We’re Getting Out of Here', 'We’re Getting Out of Here', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b97909d-cb07-4fc3-91b7-7e0e65ef65a7'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "We’re Getting Out of Here"', piece.title_en = 'Black Sea Raid: We’re Getting Out of Here', piece.editor_locked = 1
WHERE piece.id = 23309 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23215 AND linked.composer_id = 419), 'musicbrainz:01a9f036-eea0-4cff-bb1a-8176c6704ae6', 3, NULL, 'The General’s Orders', 'The General’s Orders', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01a9f036-eea0-4cff-bb1a-8176c6704ae6'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "The General’s Orders"', piece.title_en = 'Black Sea Raid: The General’s Orders', piece.editor_locked = 1
WHERE piece.id = 23215 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24217 AND linked.composer_id = 419), 'musicbrainz:5f991b68-49af-4a72-b698-ab49158836f8', 4, NULL, 'The Rescue of Natalia Porofsky', 'The Rescue of Natalia Porofsky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f991b68-49af-4a72-b698-ab49158836f8'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "The Rescue of Natalia Porofsky"', piece.title_en = 'Black Sea Raid: The Rescue of Natalia Porofsky', piece.editor_locked = 1
WHERE piece.id = 24217 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25249 AND linked.composer_id = 419), 'musicbrainz:bb95da21-8ad5-4ddf-b5dc-0c041093a94b', 5, NULL, 'The Crimean Coast', 'The Crimean Coast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb95da21-8ad5-4ddf-b5dc-0c041093a94b'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "The Crimean Coast"', piece.title_en = 'Black Sea Raid: The Crimean Coast', piece.editor_locked = 1
WHERE piece.id = 25249 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24604 AND linked.composer_id = 419), 'musicbrainz:817cd2ec-656d-4cc8-a2cc-dd33ea44d76a', 6, NULL, 'Escape From the Mental Institution', 'Escape From the Mental Institution', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:817cd2ec-656d-4cc8-a2cc-dd33ea44d76a'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Escape From the Mental Institution"', piece.title_en = 'Black Sea Raid: Escape From the Mental Institution', piece.editor_locked = 1
WHERE piece.id = 24604 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25662 AND linked.composer_id = 419), 'musicbrainz:e21c58c5-dcdb-4bdc-a289-420afe8bde03', 7, NULL, 'A Soldier’s Suspicion', 'A Soldier’s Suspicion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e21c58c5-dcdb-4bdc-a289-420afe8bde03'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "A Soldier’s Suspicion"', piece.title_en = 'Black Sea Raid: A Soldier’s Suspicion', piece.editor_locked = 1
WHERE piece.id = 25662 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23481 AND linked.composer_id = 419), 'musicbrainz:18961d6f-0621-4bd8-b5ec-e830f3f94657', 8, NULL, 'The Hidden Missile', 'The Hidden Missile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18961d6f-0621-4bd8-b5ec-e830f3f94657'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "The Hidden Missile"', piece.title_en = 'Black Sea Raid: The Hidden Missile', piece.editor_locked = 1
WHERE piece.id = 23481 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24106 AND linked.composer_id = 419), 'musicbrainz:5580ece5-3a1e-4fd5-b779-8712186792e0', 9, NULL, 'Theft of a Nuclear Warhead', 'Theft of a Nuclear Warhead', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5580ece5-3a1e-4fd5-b779-8712186792e0'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Theft of a Nuclear Warhead"', piece.title_en = 'Black Sea Raid: Theft of a Nuclear Warhead', piece.editor_locked = 1
WHERE piece.id = 24106 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23282 AND linked.composer_id = 419), 'musicbrainz:095142fa-f78d-4c97-9eed-608d4a02774f', 10, NULL, 'Ten Million or Death', 'Ten Million or Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:095142fa-f78d-4c97-9eed-608d4a02774f'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Ten Million or Death"', piece.title_en = 'Black Sea Raid: Ten Million or Death', piece.editor_locked = 1
WHERE piece.id = 23282 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23894 AND linked.composer_id = 419), 'musicbrainz:415ffb96-f411-457e-852d-05fb116871d3', 11, NULL, 'Spy Talk', 'Spy Talk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:415ffb96-f411-457e-852d-05fb116871d3'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Spy Talk"', piece.title_en = 'Black Sea Raid: Spy Talk', piece.editor_locked = 1
WHERE piece.id = 23894 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23570 AND linked.composer_id = 419), 'musicbrainz:212ebcab-105e-452f-8ad7-cc668a09ab5b', 12, NULL, 'Rick’s Greeting', 'Rick’s Greeting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:212ebcab-105e-452f-8ad7-cc668a09ab5b'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Rick’s Greeting"', piece.title_en = 'Black Sea Raid: Rick’s Greeting', piece.editor_locked = 1
WHERE piece.id = 23570 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25560 AND linked.composer_id = 419), 'musicbrainz:d866f455-7332-4a84-b437-1680faed7050', 13, NULL, 'Death in the Afternoon', 'Death in the Afternoon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d866f455-7332-4a84-b437-1680faed7050'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Death in the Afternoon"', piece.title_en = 'Black Sea Raid: Death in the Afternoon', piece.editor_locked = 1
WHERE piece.id = 25560 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25198 AND linked.composer_id = 419), 'musicbrainz:b64c6852-24a0-49e6-a178-0c4e11b9f8a3', 14, NULL, 'Falling Tires, Blazing Bullets', 'Falling Tires, Blazing Bullets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b64c6852-24a0-49e6-a178-0c4e11b9f8a3'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Falling Tires, Blazing Bullets"', piece.title_en = 'Black Sea Raid: Falling Tires, Blazing Bullets', piece.editor_locked = 1
WHERE piece.id = 25198 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25040 AND linked.composer_id = 419), 'musicbrainz:a68f3dee-0b89-494f-9b1f-41100cca0c2f', 15, NULL, 'The Man Who Could Drive Anything', 'The Man Who Could Drive Anything', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a68f3dee-0b89-494f-9b1f-41100cca0c2f'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "The Man Who Could Drive Anything"', piece.title_en = 'Black Sea Raid: The Man Who Could Drive Anything', piece.editor_locked = 1
WHERE piece.id = 25040 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24422 AND linked.composer_id = 419), 'musicbrainz:727d817b-a7c0-451f-95b7-c9748e0368f5', 16, NULL, 'Entrance to the Institution', 'Entrance to the Institution', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:727d817b-a7c0-451f-95b7-c9748e0368f5'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Entrance to the Institution"', piece.title_en = 'Black Sea Raid: Entrance to the Institution', piece.editor_locked = 1
WHERE piece.id = 24422 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23415 AND linked.composer_id = 419), 'musicbrainz:139e58cc-d701-4dcb-85ed-022b62e9f7de', 17, NULL, 'The Abduction', 'The Abduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139e58cc-d701-4dcb-85ed-022b62e9f7de'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "The Abduction"', piece.title_en = 'Black Sea Raid: The Abduction', piece.editor_locked = 1
WHERE piece.id = 23415 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23859 AND linked.composer_id = 419), 'musicbrainz:3d0f3e02-abb6-4e15-847f-42aaf1cfb254', 18, NULL, 'At the Gate', 'At the Gate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d0f3e02-abb6-4e15-847f-42aaf1cfb254'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "At the Gate"', piece.title_en = 'Black Sea Raid: At the Gate', piece.editor_locked = 1
WHERE piece.id = 23859 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23560 AND linked.composer_id = 419), 'musicbrainz:2008c1ad-0b2f-4513-9208-ec3e1f9aa53a', 19, NULL, 'Russian Tanks in Pursuit', 'Russian Tanks in Pursuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2008c1ad-0b2f-4513-9208-ec3e1f9aa53a'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Russian Tanks in Pursuit"', piece.title_en = 'Black Sea Raid: Russian Tanks in Pursuit', piece.editor_locked = 1
WHERE piece.id = 23560 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24224 AND linked.composer_id = 419), 'musicbrainz:60068aec-e692-4012-92aa-106c9dd6c68a', 20, NULL, 'Natalia’s Love', 'Natalia’s Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60068aec-e692-4012-92aa-106c9dd6c68a'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Natalia’s Love"', piece.title_en = 'Black Sea Raid: Natalia’s Love', piece.editor_locked = 1
WHERE piece.id = 24224 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25059 AND linked.composer_id = 419), 'musicbrainz:a8cf7cd1-cbf9-4442-b462-f6faddf279fa', 21, NULL, 'Kiss Your Ass Goodbye', 'Kiss Your Ass Goodbye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8cf7cd1-cbf9-4442-b462-f6faddf279fa'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Kiss Your Ass Goodbye"', piece.title_en = 'Black Sea Raid: Kiss Your Ass Goodbye', piece.editor_locked = 1
WHERE piece.id = 25059 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfac2c3d-576a-4792-a560-73d5ede0e7f5', 22, NULL, 'End Credits', 'End Credits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfac2c3d-576a-4792-a560-73d5ede0e7f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23957 AND linked.composer_id = 419), 'musicbrainz:4605f41b-34d9-4134-9a7c-e90afdbb4368', 23, NULL, 'Dusk', 'Dusk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Black Sea Raid' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4605f41b-34d9-4134-9a7c-e90afdbb4368'
);

UPDATE pieces piece
SET piece.title = 'Black Sea Raid 중 "Dusk"', piece.title_en = 'Black Sea Raid: Dusk', piece.editor_locked = 1
WHERE piece.id = 23957 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mr. Atlas

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mr. Atlas', 'Mr. Atlas', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mr. Atlas'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24358 AND linked.composer_id = 419), 'musicbrainz:6ced3895-652c-4871-ab58-aac31b05c114', 1, NULL, 'Fanfare And Opening', 'Fanfare And Opening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ced3895-652c-4871-ab58-aac31b05c114'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Fanfare And Opening"', piece.title_en = 'Mr. Atlas: Fanfare And Opening', piece.editor_locked = 1
WHERE piece.id = 24358 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24963 AND linked.composer_id = 419), 'musicbrainz:a0ce419f-5e1e-49c6-bb54-e2b18b1719df', 2, NULL, 'Mr. Atlas Main Title Theme', 'Mr. Atlas Main Title Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0ce419f-5e1e-49c6-bb54-e2b18b1719df'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Mr. Atlas Main Title Theme"', piece.title_en = 'Mr. Atlas: Mr. Atlas Main Title Theme', piece.editor_locked = 1
WHERE piece.id = 24963 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23543 AND linked.composer_id = 419), 'musicbrainz:1e1754b6-0ec1-4f9e-86b6-248e62f682bd', 3, NULL, 'The Ride Home', 'The Ride Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e1754b6-0ec1-4f9e-86b6-248e62f682bd'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "The Ride Home"', piece.title_en = 'Mr. Atlas: The Ride Home', piece.editor_locked = 1
WHERE piece.id = 23543 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23583 AND linked.composer_id = 419), 'musicbrainz:225f04a5-947b-4905-9d07-e59d57c826b0', 4, NULL, 'I''ll Bet It''s The Way He Smells', 'I''ll Bet It''s The Way He Smells', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:225f04a5-947b-4905-9d07-e59d57c826b0'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "I''ll Bet It''s The Way He Smells"', piece.title_en = 'Mr. Atlas: I''ll Bet It''s The Way He Smells', piece.editor_locked = 1
WHERE piece.id = 23583 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24700 AND linked.composer_id = 419), 'musicbrainz:8a82c0e1-8dd5-41b4-91bc-015a16dc6256', 5, NULL, 'Legend Has It A Giant Sleeps There', 'Legend Has It A Giant Sleeps There', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a82c0e1-8dd5-41b4-91bc-015a16dc6256'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Legend Has It A Giant Sleeps There"', piece.title_en = 'Mr. Atlas: Legend Has It A Giant Sleeps There', piece.editor_locked = 1
WHERE piece.id = 24700 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25491 AND linked.composer_id = 419), 'musicbrainz:d3765470-063a-4093-9b34-5130afc3be4f', 6, NULL, 'Danny''s Discovery In The Cave', 'Danny''s Discovery In The Cave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3765470-063a-4093-9b34-5130afc3be4f'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Danny''s Discovery In The Cave"', piece.title_en = 'Mr. Atlas: Danny''s Discovery In The Cave', piece.editor_locked = 1
WHERE piece.id = 25491 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f1d7e59-99a3-4c2f-aceb-bdb6ed84e343', 7, NULL, 'The Invitation', 'The Invitation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f1d7e59-99a3-4c2f-aceb-bdb6ed84e343'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25522 AND linked.composer_id = 419), 'musicbrainz:d6076a65-ce18-4d33-a3e8-58b9235baeb4', 8, NULL, 'A Day In Town', 'A Day In Town', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6076a65-ce18-4d33-a3e8-58b9235baeb4'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "A Day In Town"', piece.title_en = 'Mr. Atlas: A Day In Town', piece.editor_locked = 1
WHERE piece.id = 25522 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24719 AND linked.composer_id = 419), 'musicbrainz:8c42e05f-1802-41fb-85ab-764051d4d7b0', 9, NULL, 'A Clouded Mind Only Shadows The Heart', 'A Clouded Mind Only Shadows The Heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c42e05f-1802-41fb-85ab-764051d4d7b0'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "A Clouded Mind Only Shadows The Heart"', piece.title_en = 'Mr. Atlas: A Clouded Mind Only Shadows The Heart', piece.editor_locked = 1
WHERE piece.id = 24719 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25120 AND linked.composer_id = 419), 'musicbrainz:aea9205d-0c7f-440b-912e-7592fbaf57b4', 10, NULL, 'Your Chariot Moves Without Horses', 'Your Chariot Moves Without Horses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea9205d-0c7f-440b-912e-7592fbaf57b4'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Your Chariot Moves Without Horses"', piece.title_en = 'Mr. Atlas: Your Chariot Moves Without Horses', piece.editor_locked = 1
WHERE piece.id = 25120 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25537 AND linked.composer_id = 419), 'musicbrainz:d720c4ea-3153-4c53-ab47-6da423c3bd8e', 11, NULL, 'Danny And Gus In The Barn', 'Danny And Gus In The Barn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d720c4ea-3153-4c53-ab47-6da423c3bd8e'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Danny And Gus In The Barn"', piece.title_en = 'Mr. Atlas: Danny And Gus In The Barn', piece.editor_locked = 1
WHERE piece.id = 25537 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23811 AND linked.composer_id = 419), 'musicbrainz:38a32a45-d337-40ed-8ec1-928013b0317f', 12, NULL, 'Looking For Horses', 'Looking For Horses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38a32a45-d337-40ed-8ec1-928013b0317f'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Looking For Horses"', piece.title_en = 'Mr. Atlas: Looking For Horses', piece.editor_locked = 1
WHERE piece.id = 23811 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25772 AND linked.composer_id = 419), 'musicbrainz:eb60efde-200c-47d6-ae4e-cec0837ec470', 13, NULL, 'The Joy Of Being Followed', 'The Joy Of Being Followed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb60efde-200c-47d6-ae4e-cec0837ec470'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "The Joy Of Being Followed"', piece.title_en = 'Mr. Atlas: The Joy Of Being Followed', piece.editor_locked = 1
WHERE piece.id = 25772 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23931 AND linked.composer_id = 419), 'musicbrainz:43f9f376-91e6-4d00-8579-2090a9df181e', 14, NULL, 'Mr. Atlas To The Rescue', 'Mr. Atlas To The Rescue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43f9f376-91e6-4d00-8579-2090a9df181e'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Mr. Atlas To The Rescue"', piece.title_en = 'Mr. Atlas: Mr. Atlas To The Rescue', piece.editor_locked = 1
WHERE piece.id = 23931 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25564 AND linked.composer_id = 419), 'musicbrainz:d989a874-a9a2-404c-b290-0b0bd0f8af82', 15, NULL, 'A Season For Everything', 'A Season For Everything', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d989a874-a9a2-404c-b290-0b0bd0f8af82'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "A Season For Everything"', piece.title_en = 'Mr. Atlas: A Season For Everything', piece.editor_locked = 1
WHERE piece.id = 25564 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23264 AND linked.composer_id = 419), 'musicbrainz:079ec059-5d86-4fd5-83a9-93ff01d6e7ac', 16, NULL, 'Fun In The Park', 'Fun In The Park', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:079ec059-5d86-4fd5-83a9-93ff01d6e7ac'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Fun In The Park"', piece.title_en = 'Mr. Atlas: Fun In The Park', piece.editor_locked = 1
WHERE piece.id = 23264 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24781 AND linked.composer_id = 419), 'musicbrainz:92300e73-590a-49af-84d4-6622052de44d', 17, NULL, 'Wilshire And Phil Discover The Gold', 'Wilshire And Phil Discover The Gold', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92300e73-590a-49af-84d4-6622052de44d'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Wilshire And Phil Discover The Gold"', piece.title_en = 'Mr. Atlas: Wilshire And Phil Discover The Gold', piece.editor_locked = 1
WHERE piece.id = 24781 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24365 AND linked.composer_id = 419), 'musicbrainz:6d7ac749-f91c-4853-8a4a-4b8c367c91a4', 18, NULL, 'Love In The Afternoon', 'Love In The Afternoon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7ac749-f91c-4853-8a4a-4b8c367c91a4'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Love In The Afternoon"', piece.title_en = 'Mr. Atlas: Love In The Afternoon', piece.editor_locked = 1
WHERE piece.id = 24365 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25428 AND linked.composer_id = 419), 'musicbrainz:cd115c3d-e7b9-4ab1-b56c-57dfa91192ed', 19, NULL, 'A Fast Jeep And A Rough Road', 'A Fast Jeep And A Rough Road', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd115c3d-e7b9-4ab1-b56c-57dfa91192ed'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "A Fast Jeep And A Rough Road"', piece.title_en = 'Mr. Atlas: A Fast Jeep And A Rough Road', piece.editor_locked = 1
WHERE piece.id = 25428 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25245 AND linked.composer_id = 419), 'musicbrainz:bb14f5b0-388e-4893-a08d-a78a45086681', 20, NULL, 'I Am Atlas, Son Of Iapetus', 'I Am Atlas, Son Of Iapetus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb14f5b0-388e-4893-a08d-a78a45086681'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "I Am Atlas, Son Of Iapetus"', piece.title_en = 'Mr. Atlas: I Am Atlas, Son Of Iapetus', piece.editor_locked = 1
WHERE piece.id = 25245 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23474 AND linked.composer_id = 419), 'musicbrainz:180d4ff3-09f2-4b0a-8077-5639e50d9411', 21, NULL, 'The Tear That Gives Life', 'The Tear That Gives Life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180d4ff3-09f2-4b0a-8077-5639e50d9411'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "The Tear That Gives Life"', piece.title_en = 'Mr. Atlas: The Tear That Gives Life', piece.editor_locked = 1
WHERE piece.id = 23474 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24650 AND linked.composer_id = 419), 'musicbrainz:8579b4e0-97bb-4269-bf6d-95e5cedd2fa4', 22, NULL, 'Just Say, "Hey Dude, And I''ll Be Back"', 'Just Say, "Hey Dude, And I''ll Be Back"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Mr. Atlas' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8579b4e0-97bb-4269-bf6d-95e5cedd2fa4'
);

UPDATE pieces piece
SET piece.title = 'Mr. Atlas 중 "Just Say, "Hey Dude, And I''ll Be Back""', piece.title_en = 'Mr. Atlas: Just Say, "Hey Dude, And I''ll Be Back"', piece.editor_locked = 1
WHERE piece.id = 24650 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <Night Eyes 3> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <Night Eyes 3> 사운드트랙', 'Night Eyes 3', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <Night Eyes 3> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25388 AND linked.composer_id = 419), 'musicbrainz:c9404814-5325-473d-b632-b132d3fb9e72', 1, NULL, 'Love in the Night', 'Love in the Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9404814-5325-473d-b632-b132d3fb9e72'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Love in the Night"', piece.title_en = 'Night Eyes 3: Love in the Night', piece.editor_locked = 1
WHERE piece.id = 25388 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23959 AND linked.composer_id = 419), 'musicbrainz:465f0e2a-3822-4a1d-bd70-7849479aeb9e', 2, NULL, 'Betrayed', 'Betrayed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:465f0e2a-3822-4a1d-bd70-7849479aeb9e'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Betrayed"', piece.title_en = 'Night Eyes 3: Betrayed', piece.editor_locked = 1
WHERE piece.id = 23959 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25474 AND linked.composer_id = 419), 'musicbrainz:d1ab9da4-eb0f-43f3-8e0d-02a87240d576', 3, NULL, 'Running Scared Before Sunrise', 'Running Scared Before Sunrise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1ab9da4-eb0f-43f3-8e0d-02a87240d576'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Running Scared Before Sunrise"', piece.title_en = 'Night Eyes 3: Running Scared Before Sunrise', piece.editor_locked = 1
WHERE piece.id = 25474 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25313 AND linked.composer_id = 419), 'musicbrainz:c1bb60e3-b000-461e-8a96-14f370cdba00', 4, NULL, 'The Bath of Another Angle', 'The Bath of Another Angle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1bb60e3-b000-461e-8a96-14f370cdba00'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "The Bath of Another Angle"', piece.title_en = 'Night Eyes 3: The Bath of Another Angle', piece.editor_locked = 1
WHERE piece.id = 25313 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24416 AND linked.composer_id = 419), 'musicbrainz:71d07a08-1715-4ce5-91dd-0b0f784ec206', 5, NULL, 'Early Morning Intruder / Shattered Glass at Midnight', 'Early Morning Intruder / Shattered Glass at Midnight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71d07a08-1715-4ce5-91dd-0b0f784ec206'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Early Morning Intruder / Shattered Glass at Midnight"', piece.title_en = 'Night Eyes 3: Early Morning Intruder / Shattered Glass at Midnight', piece.editor_locked = 1
WHERE piece.id = 24416 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24163 AND linked.composer_id = 419), 'musicbrainz:5aa87f35-d836-41e7-85a3-6a23e65ce67e', 6, NULL, 'The Installation', 'The Installation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aa87f35-d836-41e7-85a3-6a23e65ce67e'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "The Installation"', piece.title_en = 'Night Eyes 3: The Installation', piece.editor_locked = 1
WHERE piece.id = 24163 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23202 AND linked.composer_id = 419), 'musicbrainz:007a2a20-badf-40eb-bd28-16a630f39f3b', 7, NULL, 'Beyond Thoughts of Darkness', 'Beyond Thoughts of Darkness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:007a2a20-badf-40eb-bd28-16a630f39f3b'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Beyond Thoughts of Darkness"', piece.title_en = 'Night Eyes 3: Beyond Thoughts of Darkness', piece.editor_locked = 1
WHERE piece.id = 23202 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24799 AND linked.composer_id = 419), 'musicbrainz:930c1292-9f92-43a5-9332-a7e49ccb6282', 8, NULL, 'The Flame of Love’s Betrayal', 'The Flame of Love’s Betrayal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:930c1292-9f92-43a5-9332-a7e49ccb6282'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "The Flame of Love’s Betrayal"', piece.title_en = 'Night Eyes 3: The Flame of Love’s Betrayal', piece.editor_locked = 1
WHERE piece.id = 24799 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25294 AND linked.composer_id = 419), 'musicbrainz:bfb10fa1-167f-4152-a78c-229cbb44a296', 9, NULL, 'Venomous Strike of the Intruder', 'Venomous Strike of the Intruder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb10fa1-167f-4152-a78c-229cbb44a296'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Venomous Strike of the Intruder"', piece.title_en = 'Night Eyes 3: Venomous Strike of the Intruder', piece.editor_locked = 1
WHERE piece.id = 25294 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23515 AND linked.composer_id = 419), 'musicbrainz:1bd10035-2373-4b77-96ff-bb6d7b6d7e27', 10, NULL, 'The Innocence of a Child’s Smile', 'The Innocence of a Child’s Smile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd10035-2373-4b77-96ff-bb6d7b6d7e27'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "The Innocence of a Child’s Smile"', piece.title_en = 'Night Eyes 3: The Innocence of a Child’s Smile', piece.editor_locked = 1
WHERE piece.id = 23515 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23316 AND linked.composer_id = 419), 'musicbrainz:0c06df87-cbb4-492e-9a82-3d5fd8ebdbd3', 11, NULL, 'Evil Watches Through a Glass', 'Evil Watches Through a Glass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c06df87-cbb4-492e-9a82-3d5fd8ebdbd3'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Evil Watches Through a Glass"', piece.title_en = 'Night Eyes 3: Evil Watches Through a Glass', piece.editor_locked = 1
WHERE piece.id = 23316 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23615 AND linked.composer_id = 419), 'musicbrainz:25c523c6-a52a-468c-b11c-d687bce8a3b5', 12, NULL, 'Search for a Past', 'Search for a Past', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c523c6-a52a-468c-b11c-d687bce8a3b5'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Search for a Past"', piece.title_en = 'Night Eyes 3: Search for a Past', piece.editor_locked = 1
WHERE piece.id = 23615 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24065 AND linked.composer_id = 419), 'musicbrainz:51be693a-de6c-4f6e-8155-6dd0713069ae', 13, NULL, 'Dinner for Another Reason', 'Dinner for Another Reason', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51be693a-de6c-4f6e-8155-6dd0713069ae'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Dinner for Another Reason"', piece.title_en = 'Night Eyes 3: Dinner for Another Reason', piece.editor_locked = 1
WHERE piece.id = 24065 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24410 AND linked.composer_id = 419), 'musicbrainz:71269be5-56b8-464b-8730-51b400954883', 14, NULL, 'A Daughter’s Wish', 'A Daughter’s Wish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71269be5-56b8-464b-8730-51b400954883'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "A Daughter’s Wish"', piece.title_en = 'Night Eyes 3: A Daughter’s Wish', piece.editor_locked = 1
WHERE piece.id = 24410 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25475 AND linked.composer_id = 419), 'musicbrainz:d1abe190-9c97-4b9b-a5d2-568cf1893ed3', 15, NULL, 'Stalking the Elusive Shadow', 'Stalking the Elusive Shadow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1abe190-9c97-4b9b-a5d2-568cf1893ed3'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Stalking the Elusive Shadow"', piece.title_en = 'Night Eyes 3: Stalking the Elusive Shadow', piece.editor_locked = 1
WHERE piece.id = 25475 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24149 AND linked.composer_id = 419), 'musicbrainz:594fd4b6-cdf3-4d47-9b2d-557da32e0a97', 16, NULL, 'The Reflection of a Misty Image', 'The Reflection of a Misty Image', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:594fd4b6-cdf3-4d47-9b2d-557da32e0a97'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "The Reflection of a Misty Image"', piece.title_en = 'Night Eyes 3: The Reflection of a Misty Image', piece.editor_locked = 1
WHERE piece.id = 24149 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25839 AND linked.composer_id = 419), 'musicbrainz:f1a6b7cb-3434-4e80-bd69-c873ee238001', 17, NULL, 'Search for a Past Beyond Tomorrow', 'Search for a Past Beyond Tomorrow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1a6b7cb-3434-4e80-bd69-c873ee238001'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Search for a Past Beyond Tomorrow"', piece.title_en = 'Night Eyes 3: Search for a Past Beyond Tomorrow', piece.editor_locked = 1
WHERE piece.id = 25839 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25675 AND linked.composer_id = 419), 'musicbrainz:e34a691f-3999-47f2-9ed7-395f9b169413', 18, NULL, 'Death Enters Without Knocking', 'Death Enters Without Knocking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e34a691f-3999-47f2-9ed7-395f9b169413'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Death Enters Without Knocking"', piece.title_en = 'Night Eyes 3: Death Enters Without Knocking', piece.editor_locked = 1
WHERE piece.id = 25675 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23388 AND linked.composer_id = 419), 'musicbrainz:112d7d5d-d12f-416b-8345-59baa08ab125', 19, NULL, 'Love in the Night Drifts Softly', 'Love in the Night Drifts Softly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Night Eyes 3> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:112d7d5d-d12f-416b-8345-59baa08ab125'
);

UPDATE pieces piece
SET piece.title = '영화 <Night Eyes 3> 사운드트랙 중 "Love in the Night Drifts Softly"', piece.title_en = 'Night Eyes 3: Love in the Night Drifts Softly', piece.editor_locked = 1
WHERE piece.id = 23388 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <데스 위시 5> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <데스 위시 5> 사운드트랙', 'Death Wish V: The Face of Death', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <데스 위시 5> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52a5828d-8bb0-47f0-9014-71d32da30e58', 1, NULL, 'Main Titles', 'Main Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52a5828d-8bb0-47f0-9014-71d32da30e58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25023 AND linked.composer_id = 419), 'musicbrainz:a52d7d52-a2a8-4c17-9e67-6db45a10a539', 2, NULL, 'Reggie''s Pressing', 'Reggie''s Pressing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a52d7d52-a2a8-4c17-9e67-6db45a10a539'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Reggie''s Pressing"', piece.title_en = 'Death Wish V: The Face of Death: Reggie''s Pressing', piece.editor_locked = 1
WHERE piece.id = 25023 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25974 AND linked.composer_id = 419), 'musicbrainz:fd65c179-f25c-4722-9d42-5a691c283487', 3, NULL, 'Freddie Catches the Ball', 'Freddie Catches the Ball', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd65c179-f25c-4722-9d42-5a691c283487'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Freddie Catches the Ball"', piece.title_en = 'Death Wish V: The Face of Death: Freddie Catches the Ball', piece.editor_locked = 1
WHERE piece.id = 25974 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25122 AND linked.composer_id = 419), 'musicbrainz:aeafbb00-4b8f-4a48-a4a6-bd748e5a5138', 4, NULL, 'The Wounded Bear Goes Down', 'The Wounded Bear Goes Down', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeafbb00-4b8f-4a48-a4a6-bd748e5a5138'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "The Wounded Bear Goes Down"', piece.title_en = 'Death Wish V: The Face of Death: The Wounded Bear Goes Down', piece.editor_locked = 1
WHERE piece.id = 25122 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25099 AND linked.composer_id = 419), 'musicbrainz:ac26f730-45f0-4dc3-97a6-c0bc4efa1fe6', 5, NULL, 'Chikie''s Last Canoli', 'Chikie''s Last Canoli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac26f730-45f0-4dc3-97a6-c0bc4efa1fe6'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Chikie''s Last Canoli"', piece.title_en = 'Death Wish V: The Face of Death: Chikie''s Last Canoli', piece.editor_locked = 1
WHERE piece.id = 25099 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24982 AND linked.composer_id = 419), 'musicbrainz:a1ba8b0b-6499-467d-adcb-9a518914373c', 6, NULL, 'Freddie Meets Olivia', 'Freddie Meets Olivia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1ba8b0b-6499-467d-adcb-9a518914373c'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Freddie Meets Olivia"', piece.title_en = 'Death Wish V: The Face of Death: Freddie Meets Olivia', piece.editor_locked = 1
WHERE piece.id = 24982 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25619 AND linked.composer_id = 419), 'musicbrainz:de3cdcdf-dc66-4b8b-8d2e-5bff1a98c12e', 7, NULL, 'Olivia''s Death', 'Olivia''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3cdcdf-dc66-4b8b-8d2e-5bff1a98c12e'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Olivia''s Death"', piece.title_en = 'Death Wish V: The Face of Death: Olivia''s Death', piece.editor_locked = 1
WHERE piece.id = 25619 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d4e206b-1d28-4ead-83bd-ce8279cdac5e', 8, NULL, 'Olivia''s Theme', 'Olivia''s Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d4e206b-1d28-4ead-83bd-ce8279cdac5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24481 AND linked.composer_id = 419), 'musicbrainz:774652e4-df2e-4692-b911-83fd00b221a9', 9, NULL, 'Tommy''s Place', 'Tommy''s Place', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:774652e4-df2e-4692-b911-83fd00b221a9'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Tommy''s Place"', piece.title_en = 'Death Wish V: The Face of Death: Tommy''s Place', piece.editor_locked = 1
WHERE piece.id = 24481 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25073 AND linked.composer_id = 419), 'musicbrainz:aa163301-e67a-46bf-bae2-2bbf491b9d8e', 10, NULL, 'Paul''s Decision', 'Paul''s Decision', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa163301-e67a-46bf-bae2-2bbf491b9d8e'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Paul''s Decision"', piece.title_en = 'Death Wish V: The Face of Death: Paul''s Decision', piece.editor_locked = 1
WHERE piece.id = 25073 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25146 AND linked.composer_id = 419), 'musicbrainz:b07bb1be-ee03-4594-9c00-66e9d6030c84', 11, NULL, 'Ship Him to Jersey', 'Ship Him to Jersey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b07bb1be-ee03-4594-9c00-66e9d6030c84'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Ship Him to Jersey"', piece.title_en = 'Death Wish V: The Face of Death: Ship Him to Jersey', piece.editor_locked = 1
WHERE piece.id = 25146 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af1f2018-c45e-416e-8a31-5f808f94a01c', 12, NULL, 'Stalking The Enemy', 'Stalking The Enemy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af1f2018-c45e-416e-8a31-5f808f94a01c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24827 AND linked.composer_id = 419), 'musicbrainz:95dd508d-3f66-4edd-9d62-e9b42c5749b3', 13, NULL, 'We''re Here', 'We''re Here', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95dd508d-3f66-4edd-9d62-e9b42c5749b3'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "We''re Here"', piece.title_en = 'Death Wish V: The Face of Death: We''re Here', piece.editor_locked = 1
WHERE piece.id = 24827 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33474424-5f2c-4381-9be4-5b3ee7d1ee20', 14, NULL, 'Olivia''s Theme', 'Olivia''s Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33474424-5f2c-4381-9be4-5b3ee7d1ee20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23338 AND linked.composer_id = 419), 'musicbrainz:0d4383fc-6d77-4724-ab71-06483b4b1da2', 15, NULL, 'Paul''s Package', 'Paul''s Package', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d4383fc-6d77-4724-ab71-06483b4b1da2'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Paul''s Package"', piece.title_en = 'Death Wish V: The Face of Death: Paul''s Package', piece.editor_locked = 1
WHERE piece.id = 23338 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23671 AND linked.composer_id = 419), 'musicbrainz:2a06d3fe-a3d1-4900-9682-0381ca333df5', 16, NULL, 'Tommy''s Bath', 'Tommy''s Bath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a06d3fe-a3d1-4900-9682-0381ca333df5'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Tommy''s Bath"', piece.title_en = 'Death Wish V: The Face of Death: Tommy''s Bath', piece.editor_locked = 1
WHERE piece.id = 23671 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5953eaa4-269f-49ae-ae27-2a171dcf7cef', 17, NULL, 'Stalking the Enemy', 'Stalking the Enemy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5953eaa4-269f-49ae-ae27-2a171dcf7cef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25159 AND linked.composer_id = 419), 'musicbrainz:b24acb32-a63b-4de3-9409-4897ab8653f6', 18, NULL, 'The Forklift', 'The Forklift', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b24acb32-a63b-4de3-9409-4897ab8653f6'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "The Forklift"', piece.title_en = 'Death Wish V: The Face of Death: The Forklift', piece.editor_locked = 1
WHERE piece.id = 25159 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23929 AND linked.composer_id = 419), 'musicbrainz:43e1371b-6124-4a64-bb7b-17486207b9a7', 19, NULL, 'Sal Searches', 'Sal Searches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43e1371b-6124-4a64-bb7b-17486207b9a7'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Sal Searches"', piece.title_en = 'Death Wish V: The Face of Death: Sal Searches', piece.editor_locked = 1
WHERE piece.id = 23929 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25244 AND linked.composer_id = 419), 'musicbrainz:baf14ce7-5ffc-4563-91b6-94d3fffe05ab', 20, NULL, 'Stalking Sal', 'Stalking Sal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baf14ce7-5ffc-4563-91b6-94d3fffe05ab'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Stalking Sal"', piece.title_en = 'Death Wish V: The Face of Death: Stalking Sal', piece.editor_locked = 1
WHERE piece.id = 25244 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24005 AND linked.composer_id = 419), 'musicbrainz:4bbf27ef-9d4d-4ae0-b95c-688b3b6d9cc8', 21, NULL, 'Sal''s Death', 'Sal''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bbf27ef-9d4d-4ae0-b95c-688b3b6d9cc8'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Sal''s Death"', piece.title_en = 'Death Wish V: The Face of Death: Sal''s Death', piece.editor_locked = 1
WHERE piece.id = 24005 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23242 AND linked.composer_id = 419), 'musicbrainz:057d5e15-f64a-409c-8bc5-894aac356f6a', 22, NULL, 'Tommy in Pursuit', 'Tommy in Pursuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:057d5e15-f64a-409c-8bc5-894aac356f6a'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Tommy in Pursuit"', piece.title_en = 'Death Wish V: The Face of Death: Tommy in Pursuit', piece.editor_locked = 1
WHERE piece.id = 23242 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:248731a2-71eb-4925-9e6b-9cc883560236', 23, NULL, 'End Credits', 'End Credits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:248731a2-71eb-4925-9e6b-9cc883560236'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24348 AND linked.composer_id = 419), 'musicbrainz:6c73d617-461c-40f7-b7d2-395fde64c140', 24, NULL, 'Looking for Mister Right', 'Looking for Mister Right', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <데스 위시 5> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c73d617-461c-40f7-b7d2-395fde64c140'
);

UPDATE pieces piece
SET piece.title = '영화 <데스 위시 5> 사운드트랙 중 "Looking for Mister Right"', piece.title_en = 'Death Wish V: The Face of Death: Looking for Mister Right', piece.editor_locked = 1
WHERE piece.id = 24348 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <Scarecrows> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <Scarecrows> 사운드트랙', 'Scarecrows', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <Scarecrows> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c8b5f92-3fb8-4c39-a137-0f9fefeb8469', 1, NULL, 'Main Titles', 'Main Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c8b5f92-3fb8-4c39-a137-0f9fefeb8469'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23901 AND linked.composer_id = 419), 'musicbrainz:4234c6a6-c900-4dc9-a9aa-a68020d9e22c', 2, NULL, 'The Road to the Farm', 'The Road to the Farm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4234c6a6-c900-4dc9-a9aa-a68020d9e22c'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "The Road to the Farm"', piece.title_en = 'Scarecrows: The Road to the Farm', piece.editor_locked = 1
WHERE piece.id = 23901 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25262 AND linked.composer_id = 419), 'musicbrainz:bd4a91e8-48e3-43ac-94d6-422fe3fc7d8f', 3, NULL, 'Running for the Plane', 'Running for the Plane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd4a91e8-48e3-43ac-94d6-422fe3fc7d8f'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "Running for the Plane"', piece.title_en = 'Scarecrows: Running for the Plane', piece.editor_locked = 1
WHERE piece.id = 25262 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23982 AND linked.composer_id = 419), 'musicbrainz:494037b8-0197-4cd1-98f2-ae05052ce7b9', 4, NULL, 'The Cleaning of Bert''s Head', 'The Cleaning of Bert''s Head', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:494037b8-0197-4cd1-98f2-ae05052ce7b9'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "The Cleaning of Bert''s Head"', piece.title_en = 'Scarecrows: The Cleaning of Bert''s Head', piece.editor_locked = 1
WHERE piece.id = 23982 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25114 AND linked.composer_id = 419), 'musicbrainz:ae23c34d-6e2b-48fa-951c-84e390294b11', 5, NULL, 'Waking Up', 'Waking Up', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae23c34d-6e2b-48fa-951c-84e390294b11'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "Waking Up"', piece.title_en = 'Scarecrows: Waking Up', piece.editor_locked = 1
WHERE piece.id = 25114 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25478 AND linked.composer_id = 419), 'musicbrainz:d2082b43-39c1-4274-b804-4d945ac96492', 6, NULL, 'You Want the Money?', 'You Want the Money?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2082b43-39c1-4274-b804-4d945ac96492'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "You Want the Money?"', piece.title_en = 'Scarecrows: You Want the Money?', piece.editor_locked = 1
WHERE piece.id = 25478 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23838 AND linked.composer_id = 419), 'musicbrainz:3b5fcf2f-9266-42d0-8a70-3e83609af835', 7, NULL, 'The Man Stuffed with Money', 'The Man Stuffed with Money', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b5fcf2f-9266-42d0-8a70-3e83609af835'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "The Man Stuffed with Money"', piece.title_en = 'Scarecrows: The Man Stuffed with Money', piece.editor_locked = 1
WHERE piece.id = 23838 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23799 AND linked.composer_id = 419), 'musicbrainz:37b55512-d09e-49d4-8778-487f223980bb', 8, NULL, 'Entrance to the Old Farm House', 'Entrance to the Old Farm House', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37b55512-d09e-49d4-8778-487f223980bb'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "Entrance to the Old Farm House"', piece.title_en = 'Scarecrows: Entrance to the Old Farm House', piece.editor_locked = 1
WHERE piece.id = 23799 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24909 AND linked.composer_id = 419), 'musicbrainz:9caadac9-b0b0-41ee-9fd5-5f97d18722a3', 9, NULL, 'Three Crosses', 'Three Crosses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9caadac9-b0b0-41ee-9fd5-5f97d18722a3'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "Three Crosses"', piece.title_en = 'Scarecrows: Three Crosses', piece.editor_locked = 1
WHERE piece.id = 24909 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24241 AND linked.composer_id = 419), 'musicbrainz:61b51c48-c8b4-4768-a9a2-e2c6e842c20d', 10, NULL, 'Barbed Wire Daddy', 'Barbed Wire Daddy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61b51c48-c8b4-4768-a9a2-e2c6e842c20d'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "Barbed Wire Daddy"', piece.title_en = 'Scarecrows: Barbed Wire Daddy', piece.editor_locked = 1
WHERE piece.id = 24241 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24173 AND linked.composer_id = 419), 'musicbrainz:5bacb62a-2bea-4049-a4f2-720d890e343e', 11, NULL, 'The Conference', 'The Conference', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bacb62a-2bea-4049-a4f2-720d890e343e'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "The Conference"', piece.title_en = 'Scarecrows: The Conference', piece.editor_locked = 1
WHERE piece.id = 24173 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23504 AND linked.composer_id = 419), 'musicbrainz:1b2529db-eaf6-48b7-98f9-86eb39fa17cb', 12, NULL, 'The Return', 'The Return', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b2529db-eaf6-48b7-98f9-86eb39fa17cb'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "The Return"', piece.title_en = 'Scarecrows: The Return', piece.editor_locked = 1
WHERE piece.id = 23504 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24940 AND linked.composer_id = 419), 'musicbrainz:9ed93ff6-801a-49df-a86a-e7b02d9ebfab', 13, NULL, 'Through the Woods', 'Through the Woods', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed93ff6-801a-49df-a86a-e7b02d9ebfab'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "Through the Woods"', piece.title_en = 'Scarecrows: Through the Woods', piece.editor_locked = 1
WHERE piece.id = 24940 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24858 AND linked.composer_id = 419), 'musicbrainz:98037d2a-b237-40fb-bb8e-13fa95600eb8', 14, NULL, 'The Truck with No Engine', 'The Truck with No Engine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98037d2a-b237-40fb-bb8e-13fa95600eb8'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "The Truck with No Engine"', piece.title_en = 'Scarecrows: The Truck with No Engine', piece.editor_locked = 1
WHERE piece.id = 24858 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25844 AND linked.composer_id = 419), 'musicbrainz:f21ef844-6686-4b53-8699-bb46e198039f', 15, NULL, 'Roxanne''s Dilemma', 'Roxanne''s Dilemma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21ef844-6686-4b53-8699-bb46e198039f'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "Roxanne''s Dilemma"', piece.title_en = 'Scarecrows: Roxanne''s Dilemma', piece.editor_locked = 1
WHERE piece.id = 25844 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24871 AND linked.composer_id = 419), 'musicbrainz:9936a94d-38c4-4d5d-bf99-6ac87ca80ccb', 16, NULL, 'How Are We Gonna Live in Mexico… If We’re Dead?', 'How Are We Gonna Live in Mexico… If We’re Dead?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9936a94d-38c4-4d5d-bf99-6ac87ca80ccb'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "How Are We Gonna Live in Mexico… If We’re Dead?"', piece.title_en = 'Scarecrows: How Are We Gonna Live in Mexico… If We’re Dead?', piece.editor_locked = 1
WHERE piece.id = 24871 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25570 AND linked.composer_id = 419), 'musicbrainz:d9d546e9-0905-4649-88cb-3ee048785ee9', 17, NULL, 'The Last Phone Call', 'The Last Phone Call', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9d546e9-0905-4649-88cb-3ee048785ee9'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "The Last Phone Call"', piece.title_en = 'Scarecrows: The Last Phone Call', piece.editor_locked = 1
WHERE piece.id = 25570 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25482 AND linked.composer_id = 419), 'musicbrainz:d23c2c9f-2f90-40ba-8d35-7f1d5c4fb544', 18, NULL, 'The Getaway', 'The Getaway', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d23c2c9f-2f90-40ba-8d35-7f1d5c4fb544'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "The Getaway"', piece.title_en = 'Scarecrows: The Getaway', piece.editor_locked = 1
WHERE piece.id = 25482 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23829 AND linked.composer_id = 419), 'musicbrainz:3a484ef9-a1ef-4dae-b4a7-3c48bddeb05c', 19, NULL, 'Death on a Plane', 'Death on a Plane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Scarecrows> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a484ef9-a1ef-4dae-b4a7-3c48bddeb05c'
);

UPDATE pieces piece
SET piece.title = '영화 <Scarecrows> 사운드트랙 중 "Death on a Plane"', piece.title_en = 'Scarecrows: Death on a Plane', piece.editor_locked = 1
WHERE piece.id = 23829 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <Nate and the Colonel> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <Nate and the Colonel> 사운드트랙', 'Nate and the Colonel', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <Nate and the Colonel> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2380b29-8891-4d7a-adf3-463f7cba4e9c', 1, NULL, 'This Wounded Land (instrumental)', 'This Wounded Land (instrumental)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2380b29-8891-4d7a-adf3-463f7cba4e9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24215 AND linked.composer_id = 419), 'musicbrainz:5f9019c4-8b35-4a1a-a88d-5982dee5ceba', 2, NULL, 'A Prayer for My People', 'A Prayer for My People', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f9019c4-8b35-4a1a-a88d-5982dee5ceba'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "A Prayer for My People"', piece.title_en = 'Nate and the Colonel: A Prayer for My People', piece.editor_locked = 1
WHERE piece.id = 24215 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24762 AND linked.composer_id = 419), 'musicbrainz:8fd9f3f3-7b91-41ba-b333-37ee828d8a4f', 3, NULL, 'The Trip to the Village', 'The Trip to the Village', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fd9f3f3-7b91-41ba-b333-37ee828d8a4f'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Trip to the Village"', piece.title_en = 'Nate and the Colonel: The Trip to the Village', piece.editor_locked = 1
WHERE piece.id = 24762 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25402 AND linked.composer_id = 419), 'musicbrainz:cac40e68-39e3-4685-a4fb-a1deb0940640', 4, NULL, 'Rebel Attack and Goodbye to War', 'Rebel Attack and Goodbye to War', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cac40e68-39e3-4685-a4fb-a1deb0940640'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "Rebel Attack and Goodbye to War"', piece.title_en = 'Nate and the Colonel: Rebel Attack and Goodbye to War', piece.editor_locked = 1
WHERE piece.id = 25402 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23806 AND linked.composer_id = 419), 'musicbrainz:384e72d6-0ff8-456e-93a1-7dcbd0d60684', 5, NULL, 'Death of the Colonel''s Wife and Moving West', 'Death of the Colonel''s Wife and Moving West', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:384e72d6-0ff8-456e-93a1-7dcbd0d60684'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "Death of the Colonel''s Wife and Moving West"', piece.title_en = 'Nate and the Colonel: Death of the Colonel''s Wife and Moving West', piece.editor_locked = 1
WHERE piece.id = 23806 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11117c37-1992-4f27-a7c5-c45c1fb1bac0', 6, NULL, 'A New Friend', 'A New Friend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11117c37-1992-4f27-a7c5-c45c1fb1bac0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25117 AND linked.composer_id = 419), 'musicbrainz:ae6c9b05-b096-452e-8054-170a442cd7c7', 7, NULL, 'The New Neighbors', 'The New Neighbors', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae6c9b05-b096-452e-8054-170a442cd7c7'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "The New Neighbors"', piece.title_en = 'Nate and the Colonel: The New Neighbors', piece.editor_locked = 1
WHERE piece.id = 25117 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23294 AND linked.composer_id = 419), 'musicbrainz:0aaecd69-b5f3-41d6-8c2a-e23b38922715', 8, NULL, 'A New Land... An Old Friendship', 'A New Land... An Old Friendship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aaecd69-b5f3-41d6-8c2a-e23b38922715'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "A New Land... An Old Friendship"', piece.title_en = 'Nate and the Colonel: A New Land... An Old Friendship', piece.editor_locked = 1
WHERE piece.id = 23294 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23203 AND linked.composer_id = 419), 'musicbrainz:00d2c38a-71de-48a5-8f48-95b856c6456d', 9, NULL, 'Bird Feather and the Colonel', 'Bird Feather and the Colonel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00d2c38a-71de-48a5-8f48-95b856c6456d'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "Bird Feather and the Colonel"', piece.title_en = 'Nate and the Colonel: Bird Feather and the Colonel', piece.editor_locked = 1
WHERE piece.id = 23203 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25518 AND linked.composer_id = 419), 'musicbrainz:d5dd47de-e3f3-415c-ac08-3e9ad5ffefab', 10, NULL, 'Union Trash', 'Union Trash', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5dd47de-e3f3-415c-ac08-3e9ad5ffefab'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "Union Trash"', piece.title_en = 'Nate and the Colonel: Union Trash', piece.editor_locked = 1
WHERE piece.id = 25518 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25080 AND linked.composer_id = 419), 'musicbrainz:aa77518c-b32d-4168-8ecf-11c643e05afd', 11, NULL, 'I Will Make The Blue Coats My Enemy', 'I Will Make The Blue Coats My Enemy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa77518c-b32d-4168-8ecf-11c643e05afd'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "I Will Make The Blue Coats My Enemy"', piece.title_en = 'Nate and the Colonel: I Will Make The Blue Coats My Enemy', piece.editor_locked = 1
WHERE piece.id = 25080 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24096 AND linked.composer_id = 419), 'musicbrainz:54bdc76f-d1f7-4668-a476-d29c37cd05c2', 12, NULL, 'Rescue Bird Feather', 'Rescue Bird Feather', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54bdc76f-d1f7-4668-a476-d29c37cd05c2'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "Rescue Bird Feather"', piece.title_en = 'Nate and the Colonel: Rescue Bird Feather', piece.editor_locked = 1
WHERE piece.id = 24096 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24517 AND linked.composer_id = 419), 'musicbrainz:79cf88b6-1c14-4679-8af3-f10c7bdb2521', 13, NULL, 'The Trip Home', 'The Trip Home', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79cf88b6-1c14-4679-8af3-f10c7bdb2521'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Trip Home"', piece.title_en = 'Nate and the Colonel: The Trip Home', piece.editor_locked = 1
WHERE piece.id = 24517 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23365 AND linked.composer_id = 419), 'musicbrainz:0f790b91-5eb3-4909-b788-a2ff08641e0c', 14, NULL, 'Blackfoot Attack', 'Blackfoot Attack', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f790b91-5eb3-4909-b788-a2ff08641e0c'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "Blackfoot Attack"', piece.title_en = 'Nate and the Colonel: Blackfoot Attack', piece.editor_locked = 1
WHERE piece.id = 23365 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24737 AND linked.composer_id = 419), 'musicbrainz:8da736f8-7407-4d96-af5b-d4c1c0c4f745', 15, NULL, 'The Wedding and Skinner''s Death', 'The Wedding and Skinner''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8da736f8-7407-4d96-af5b-d4c1c0c4f745'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Wedding and Skinner''s Death"', piece.title_en = 'Nate and the Colonel: The Wedding and Skinner''s Death', piece.editor_locked = 1
WHERE piece.id = 24737 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25149 AND linked.composer_id = 419), 'musicbrainz:b109f2f7-9f4d-43fc-935b-3d13765d0221', 16, NULL, 'Home Life', 'Home Life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b109f2f7-9f4d-43fc-935b-3d13765d0221'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "Home Life"', piece.title_en = 'Nate and the Colonel: Home Life', piece.editor_locked = 1
WHERE piece.id = 25149 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25782 AND linked.composer_id = 419), 'musicbrainz:ec90c473-c5a2-48e6-a581-a2ff864ff67a', 17, NULL, 'The Captain Fires Once', 'The Captain Fires Once', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec90c473-c5a2-48e6-a581-a2ff864ff67a'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Captain Fires Once"', piece.title_en = 'Nate and the Colonel: The Captain Fires Once', piece.editor_locked = 1
WHERE piece.id = 25782 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b2c1773-235b-44d4-9a8f-cbe78e902588', 18, NULL, 'The Invitation', 'The Invitation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b2c1773-235b-44d4-9a8f-cbe78e902588'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25128 AND linked.composer_id = 419), 'musicbrainz:aef60ca0-11fb-4b17-8d11-2003a6ee76b3', 19, NULL, 'The Final Battle and Massacre', 'The Final Battle and Massacre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aef60ca0-11fb-4b17-8d11-2003a6ee76b3'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "The Final Battle and Massacre"', piece.title_en = 'Nate and the Colonel: The Final Battle and Massacre', piece.editor_locked = 1
WHERE piece.id = 25128 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24398 AND linked.composer_id = 419), 'musicbrainz:70487328-9390-406d-aa4c-c2916a0ccf37', 20, NULL, 'This Wounded Land (vocal)', 'This Wounded Land (vocal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <Nate and the Colonel> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70487328-9390-406d-aa4c-c2916a0ccf37'
);

UPDATE pieces piece
SET piece.title = '영화 <Nate and the Colonel> 사운드트랙 중 "This Wounded Land (vocal)"', piece.title_en = 'Nate and the Colonel: This Wounded Land (vocal)', piece.editor_locked = 1
WHERE piece.id = 24398 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Raging Angels

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Raging Angels', 'Raging Angels', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Raging Angels'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e682b5b6-c743-405a-ac0f-e7f5a61a3772', 1, NULL, 'Main Titles', 'Main Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e682b5b6-c743-405a-ac0f-e7f5a61a3772'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7c596e2-b91e-44d6-a96f-a9f00b157d32', 2, NULL, 'The Intruder', 'The Intruder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7c596e2-b91e-44d6-a96f-a9f00b157d32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24330 AND linked.composer_id = 419), 'musicbrainz:6a893982-a2d5-4a1a-bd5a-65836acdce4e', 3, NULL, 'Chris''s Meeting', 'Chris''s Meeting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a893982-a2d5-4a1a-bd5a-65836acdce4e'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Chris''s Meeting"', piece.title_en = 'Raging Angels: Chris''s Meeting', piece.editor_locked = 1
WHERE piece.id = 24330 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25087 AND linked.composer_id = 419), 'musicbrainz:ab345077-2bb5-4c1a-897b-0e0b47e8aaf9', 4, NULL, 'Sister Kate Asks for Help', 'Sister Kate Asks for Help', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab345077-2bb5-4c1a-897b-0e0b47e8aaf9'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Sister Kate Asks for Help"', piece.title_en = 'Raging Angels: Sister Kate Asks for Help', piece.editor_locked = 1
WHERE piece.id = 25087 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25580 AND linked.composer_id = 419), 'musicbrainz:dac85505-5cfc-473b-afae-7c915449e806', 5, NULL, 'Chris''s Question', 'Chris''s Question', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dac85505-5cfc-473b-afae-7c915449e806'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Chris''s Question"', piece.title_en = 'Raging Angels: Chris''s Question', piece.editor_locked = 1
WHERE piece.id = 25580 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24150 AND linked.composer_id = 419), 'musicbrainz:595fa586-be93-4ff7-b535-c1cb78dfe60a', 6, NULL, 'Molech Greets Sister Kate', 'Molech Greets Sister Kate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:595fa586-be93-4ff7-b535-c1cb78dfe60a'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Molech Greets Sister Kate"', piece.title_en = 'Raging Angels: Molech Greets Sister Kate', piece.editor_locked = 1
WHERE piece.id = 24150 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25355 AND linked.composer_id = 419), 'musicbrainz:c5918277-d41d-4537-841a-07162a39a060', 7, NULL, 'The Dance of Darkness', 'The Dance of Darkness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5918277-d41d-4537-841a-07162a39a060'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "The Dance of Darkness"', piece.title_en = 'Raging Angels: The Dance of Darkness', piece.editor_locked = 1
WHERE piece.id = 25355 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23686 AND linked.composer_id = 419), 'musicbrainz:2c67ff4f-fe13-4740-bc9c-0e31f25dd298', 8, NULL, 'Colin Reveals the Way to Lila', 'Colin Reveals the Way to Lila', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c67ff4f-fe13-4740-bc9c-0e31f25dd298'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Colin Reveals the Way to Lila"', piece.title_en = 'Raging Angels: Colin Reveals the Way to Lila', piece.editor_locked = 1
WHERE piece.id = 23686 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23549 AND linked.composer_id = 419), 'musicbrainz:1e98b6dc-9368-4733-8faa-96454ca19fa3', 9, NULL, 'Chris and Lila', 'Chris and Lila', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e98b6dc-9368-4733-8faa-96454ca19fa3'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Chris and Lila"', piece.title_en = 'Raging Angels: Chris and Lila', piece.editor_locked = 1
WHERE piece.id = 23549 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24397 AND linked.composer_id = 419), 'musicbrainz:70486f71-1d29-4b58-8315-9f92aa8b3a4a', 10, NULL, 'An Inner Tornado Brings Voices', 'An Inner Tornado Brings Voices', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70486f71-1d29-4b58-8315-9f92aa8b3a4a'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "An Inner Tornado Brings Voices"', piece.title_en = 'Raging Angels: An Inner Tornado Brings Voices', piece.editor_locked = 1
WHERE piece.id = 24397 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24810 AND linked.composer_id = 419), 'musicbrainz:947da513-eac9-4e2d-94fc-b26f47ff3f1e', 11, NULL, 'A View From Above', 'A View From Above', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:947da513-eac9-4e2d-94fc-b26f47ff3f1e'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "A View From Above"', piece.title_en = 'Raging Angels: A View From Above', piece.editor_locked = 1
WHERE piece.id = 24810 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24369 AND linked.composer_id = 419), 'musicbrainz:6dbadd91-7e4c-476c-991e-758b055b9fbe', 12, NULL, 'To Exorcise the Demonic Need', 'To Exorcise the Demonic Need', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dbadd91-7e4c-476c-991e-758b055b9fbe'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "To Exorcise the Demonic Need"', piece.title_en = 'Raging Angels: To Exorcise the Demonic Need', piece.editor_locked = 1
WHERE piece.id = 24369 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23477 AND linked.composer_id = 419), 'musicbrainz:185dc2fa-d071-4c08-ae95-7e1aa61f5893', 13, NULL, 'When Darkness Enters the Room', 'When Darkness Enters the Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:185dc2fa-d071-4c08-ae95-7e1aa61f5893'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "When Darkness Enters the Room"', piece.title_en = 'Raging Angels: When Darkness Enters the Room', piece.editor_locked = 1
WHERE piece.id = 23477 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25361 AND linked.composer_id = 419), 'musicbrainz:c67c1636-6983-45c9-9409-da8f7c078505', 14, NULL, 'A Distant Reach for a Lost Touch', 'A Distant Reach for a Lost Touch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c67c1636-6983-45c9-9409-da8f7c078505'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "A Distant Reach for a Lost Touch"', piece.title_en = 'Raging Angels: A Distant Reach for a Lost Touch', piece.editor_locked = 1
WHERE piece.id = 25361 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25267 AND linked.composer_id = 419), 'musicbrainz:bd91f745-1149-429b-b6a1-3101ef9dfa54', 15, NULL, 'Molech''s Revenge', 'Molech''s Revenge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd91f745-1149-429b-b6a1-3101ef9dfa54'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Molech''s Revenge"', piece.title_en = 'Raging Angels: Molech''s Revenge', piece.editor_locked = 1
WHERE piece.id = 25267 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25349 AND linked.composer_id = 419), 'musicbrainz:c544117f-5303-4d4e-8995-97994ceb41a8', 16, NULL, 'Sister Kate Reaches for Chris', 'Sister Kate Reaches for Chris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c544117f-5303-4d4e-8995-97994ceb41a8'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Sister Kate Reaches for Chris"', piece.title_en = 'Raging Angels: Sister Kate Reaches for Chris', piece.editor_locked = 1
WHERE piece.id = 25349 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23222 AND linked.composer_id = 419), 'musicbrainz:02b8e058-042b-4b56-9969-3e8f5c6961ca', 17, NULL, 'The Death of Grandma Ruth', 'The Death of Grandma Ruth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02b8e058-042b-4b56-9969-3e8f5c6961ca'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "The Death of Grandma Ruth"', piece.title_en = 'Raging Angels: The Death of Grandma Ruth', piece.editor_locked = 1
WHERE piece.id = 23222 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23808 AND linked.composer_id = 419), 'musicbrainz:388b4649-1e23-4e35-ae73-ffd17b156274', 18, NULL, 'Retribution and the Final Battle', 'Retribution and the Final Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Raging Angels' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:388b4649-1e23-4e35-ae73-ffd17b156274'
);

UPDATE pieces piece
SET piece.title = 'Raging Angels 중 "Retribution and the Final Battle"', piece.title_en = 'Raging Angels: Retribution and the Final Battle', piece.editor_locked = 1
WHERE piece.id = 23808 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화 <블랙 이글> 사운드트랙

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 <블랙 이글> 사운드트랙', 'Black Eagle', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 <블랙 이글> 사운드트랙'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24208 AND linked.composer_id = 419), 'musicbrainz:5f398002-e046-41e0-912b-99fda6329777', 1, NULL, 'Arrival in Malta / Rooftop Chase', 'Arrival in Malta / Rooftop Chase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f398002-e046-41e0-912b-99fda6329777'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Arrival in Malta / Rooftop Chase"', piece.title_en = 'Black Eagle: Arrival in Malta / Rooftop Chase', piece.editor_locked = 1
WHERE piece.id = 24208 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddff096d-0eee-4b04-82c4-9797e6922dfa', 2, NULL, 'The Intruder', 'The Intruder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddff096d-0eee-4b04-82c4-9797e6922dfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23425 AND linked.composer_id = 419), 'musicbrainz:14ae2412-fc8b-414a-aaf9-f296dd2ed872', 3, NULL, 'Flight and Escape', 'Flight and Escape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14ae2412-fc8b-414a-aaf9-f296dd2ed872'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Flight and Escape"', piece.title_en = 'Black Eagle: Flight and Escape', piece.editor_locked = 1
WHERE piece.id = 23425 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23394 AND linked.composer_id = 419), 'musicbrainz:11d2f3a8-9bc6-4c93-9438-633c16042d5d', 4, NULL, 'The Old Fort', 'The Old Fort', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11d2f3a8-9bc6-4c93-9438-633c16042d5d'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "The Old Fort"', piece.title_en = 'Black Eagle: The Old Fort', piece.editor_locked = 1
WHERE piece.id = 23394 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24661 AND linked.composer_id = 419), 'musicbrainz:865f1ffd-c43b-4a98-855a-270b0dfc7e29', 5, NULL, 'Father and Son / Andre''s Death', 'Father and Son / Andre''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:865f1ffd-c43b-4a98-855a-270b0dfc7e29'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Father and Son / Andre''s Death"', piece.title_en = 'Black Eagle: Father and Son / Andre''s Death', piece.editor_locked = 1
WHERE piece.id = 24661 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24946 AND linked.composer_id = 419), 'musicbrainz:9f2eb73e-0421-44c6-a507-402e15816200', 6, NULL, 'Ken Parachutes / Overlooking Malta', 'Ken Parachutes / Overlooking Malta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f2eb73e-0421-44c6-a507-402e15816200'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Ken Parachutes / Overlooking Malta"', piece.title_en = 'Black Eagle: Ken Parachutes / Overlooking Malta', piece.editor_locked = 1
WHERE piece.id = 24946 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23889 AND linked.composer_id = 419), 'musicbrainz:40c82e2f-f3a1-46ca-8227-28e7e0d3b29a', 7, NULL, 'Ken and Andre in Battle', 'Ken and Andre in Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40c82e2f-f3a1-46ca-8227-28e7e0d3b29a'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Ken and Andre in Battle"', piece.title_en = 'Black Eagle: Ken and Andre in Battle', piece.editor_locked = 1
WHERE piece.id = 23889 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23854 AND linked.composer_id = 419), 'musicbrainz:3cbc6770-1b6c-48b2-8220-c1cf4951d3ae', 8, NULL, 'Underwater', 'Underwater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cbc6770-1b6c-48b2-8220-c1cf4951d3ae'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Underwater"', piece.title_en = 'Black Eagle: Underwater', piece.editor_locked = 1
WHERE piece.id = 23854 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25340 AND linked.composer_id = 419), 'musicbrainz:c46bee94-42b1-4ef1-b050-b76c0fc5ec56', 9, NULL, 'Ken''s Ritual', 'Ken''s Ritual', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c46bee94-42b1-4ef1-b050-b76c0fc5ec56'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Ken''s Ritual"', piece.title_en = 'Black Eagle: Ken''s Ritual', piece.editor_locked = 1
WHERE piece.id = 25340 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24178 AND linked.composer_id = 419), 'musicbrainz:5bf5a0f8-0e0a-4350-a682-cec96901584d', 10, NULL, 'Ken Boards Ship', 'Ken Boards Ship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bf5a0f8-0e0a-4350-a682-cec96901584d'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Ken Boards Ship"', piece.title_en = 'Black Eagle: Ken Boards Ship', piece.editor_locked = 1
WHERE piece.id = 24178 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25406 AND linked.composer_id = 419), 'musicbrainz:cb2b6df6-4545-4cc9-b622-3bee74c5c478', 11, NULL, 'The Russian Trawler / Brian''s Disappointment', 'The Russian Trawler / Brian''s Disappointment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb2b6df6-4545-4cc9-b622-3bee74c5c478'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "The Russian Trawler / Brian''s Disappointment"', piece.title_en = 'Black Eagle: The Russian Trawler / Brian''s Disappointment', piece.editor_locked = 1
WHERE piece.id = 25406 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25011 AND linked.composer_id = 419), 'musicbrainz:a442862d-4543-4930-992c-f3025d7cec7d', 12, NULL, 'Patricia''s Capture / On a Cliff', 'Patricia''s Capture / On a Cliff', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a442862d-4543-4930-992c-f3025d7cec7d'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Patricia''s Capture / On a Cliff"', piece.title_en = 'Black Eagle: Patricia''s Capture / On a Cliff', piece.editor_locked = 1
WHERE piece.id = 25011 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23783 AND linked.composer_id = 419), 'musicbrainz:36acf705-ee39-4437-96bf-bce0b96041c3', 13, NULL, 'Final Resolution / End Titles', 'Final Resolution / End Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36acf705-ee39-4437-96bf-bce0b96041c3'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Final Resolution / End Titles"', piece.title_en = 'Black Eagle: Final Resolution / End Titles', piece.editor_locked = 1
WHERE piece.id = 23783 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24699 AND linked.composer_id = 419), 'musicbrainz:8a6352ae-47b8-416a-a6da-5a752089c428', 14, NULL, 'Cara''s Death', 'Cara''s Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a6352ae-47b8-416a-a6da-5a752089c428'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Cara''s Death"', piece.title_en = 'Black Eagle: Cara''s Death', piece.editor_locked = 1
WHERE piece.id = 24699 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25030 AND linked.composer_id = 419), 'musicbrainz:a5b98e00-4a21-40b1-906b-d5ee7317561a', 15, NULL, 'The Clan', 'The Clan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5b98e00-4a21-40b1-906b-d5ee7317561a'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "The Clan"', piece.title_en = 'Black Eagle: The Clan', piece.editor_locked = 1
WHERE piece.id = 25030 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24219 AND linked.composer_id = 419), 'musicbrainz:5fb27b92-beee-47e9-ad7b-c2c4cf029838', 16, NULL, 'Lucius in Pursuit', 'Lucius in Pursuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fb27b92-beee-47e9-ad7b-c2c4cf029838'
);

UPDATE pieces piece
SET piece.title = '영화 <블랙 이글> 사운드트랙 중 "Lucius in Pursuit"', piece.title_en = 'Black Eagle: Lucius in Pursuit', piece.editor_locked = 1
WHERE piece.id = 24219 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1349ab72-a3d3-4bc8-94f5-8b930e639197', 17, NULL, 'End Titles', 'End Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = '영화 <블랙 이글> 사운드트랙' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1349ab72-a3d3-4bc8-94f5-8b930e639197'
);


-- None Final Judgement

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Final Judgement', 'Final Judgement', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Final Judgement'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ee1194c-675e-45fd-937c-ff6cfc67ac4e', 1, NULL, 'Main Title', 'Main Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ee1194c-675e-45fd-937c-ff6cfc67ac4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23903 AND linked.composer_id = 419), 'musicbrainz:424dfe12-d83b-4631-bfb2-f861451b211e', 2, NULL, 'Suspect', 'Suspect', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:424dfe12-d83b-4631-bfb2-f861451b211e'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Suspect"', piece.title_en = 'Final Judgement: Suspect', piece.editor_locked = 1
WHERE piece.id = 23903 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23381 AND linked.composer_id = 419), 'musicbrainz:10cbb788-c002-4c9e-a19f-6472d366c803', 3, NULL, 'Following Rob', 'Following Rob', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10cbb788-c002-4c9e-a19f-6472d366c803'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Following Rob"', piece.title_en = 'Final Judgement: Following Rob', piece.editor_locked = 1
WHERE piece.id = 23381 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23234 AND linked.composer_id = 419), 'musicbrainz:047dfb0e-e4d2-4e1c-9c83-16f69ce033af', 4, NULL, 'Daydream', 'Daydream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:047dfb0e-e4d2-4e1c-9c83-16f69ce033af'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Daydream"', piece.title_en = 'Final Judgement: Daydream', piece.editor_locked = 1
WHERE piece.id = 23234 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25312 AND linked.composer_id = 419), 'musicbrainz:c1b552b4-0d5d-4c85-a08e-5fa8436101b0', 5, NULL, 'The Chase', 'The Chase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1b552b4-0d5d-4c85-a08e-5fa8436101b0'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "The Chase"', piece.title_en = 'Final Judgement: The Chase', piece.editor_locked = 1
WHERE piece.id = 25312 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23937 AND linked.composer_id = 419), 'musicbrainz:44a79800-55c6-45f0-9c59-8f7b17139642', 6, NULL, 'The Fight / End Titles', 'The Fight / End Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44a79800-55c6-45f0-9c59-8f7b17139642'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "The Fight / End Titles"', piece.title_en = 'Final Judgement: The Fight / End Titles', piece.editor_locked = 1
WHERE piece.id = 23937 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:799fe404-8187-4e9d-8bde-c22ca525b9ab', 7, NULL, 'Main Titles', 'Main Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:799fe404-8187-4e9d-8bde-c22ca525b9ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24769 AND linked.composer_id = 419), 'musicbrainz:90de5b33-1387-4bda-b715-45595e05cef1', 8, NULL, 'Goodnight Mom', 'Goodnight Mom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90de5b33-1387-4bda-b715-45595e05cef1'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Goodnight Mom"', piece.title_en = 'Final Judgement: Goodnight Mom', piece.editor_locked = 1
WHERE piece.id = 24769 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25043 AND linked.composer_id = 419), 'musicbrainz:a751b680-822b-4b50-baa5-0faa10ab8e3d', 9, NULL, 'Reinforcements', 'Reinforcements', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a751b680-822b-4b50-baa5-0faa10ab8e3d'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Reinforcements"', piece.title_en = 'Final Judgement: Reinforcements', piece.editor_locked = 1
WHERE piece.id = 25043 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23678 AND linked.composer_id = 419), 'musicbrainz:2b1ac40d-e6d1-4775-b180-15ee27f9dd67', 10, NULL, 'Narrow Escape', 'Narrow Escape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b1ac40d-e6d1-4775-b180-15ee27f9dd67'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Narrow Escape"', piece.title_en = 'Final Judgement: Narrow Escape', piece.editor_locked = 1
WHERE piece.id = 23678 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23262 AND linked.composer_id = 419), 'musicbrainz:074a53c6-1b53-430c-aed4-98b5f8d13742', 11, NULL, 'Getting Ready', 'Getting Ready', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074a53c6-1b53-430c-aed4-98b5f8d13742'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Getting Ready"', piece.title_en = 'Final Judgement: Getting Ready', piece.editor_locked = 1
WHERE piece.id = 23262 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14612623-ba75-4493-8c09-279a4efdca53', 12, NULL, 'End Titles', 'End Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14612623-ba75-4493-8c09-279a4efdca53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4cce284-58da-47a7-b7d8-691093f07e4d', 13, NULL, 'Main Title', 'Main Title', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4cce284-58da-47a7-b7d8-691093f07e4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23274 AND linked.composer_id = 419), 'musicbrainz:0896207a-8470-4e05-94ab-b061509d365a', 14, NULL, 'Ariel and David / The Burial', 'Ariel and David / The Burial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0896207a-8470-4e05-94ab-b061509d365a'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Ariel and David / The Burial"', piece.title_en = 'Final Judgement: Ariel and David / The Burial', piece.editor_locked = 1
WHERE piece.id = 23274 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25303 AND linked.composer_id = 419), 'musicbrainz:c0c2811e-dce6-463c-8736-1f4a4a872965', 15, NULL, 'Lusus Attacks / Ariel''s Rape', 'Lusus Attacks / Ariel''s Rape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0c2811e-dce6-463c-8736-1f4a4a872965'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Lusus Attacks / Ariel''s Rape"', piece.title_en = 'Final Judgement: Lusus Attacks / Ariel''s Rape', piece.editor_locked = 1
WHERE piece.id = 25303 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23985 AND linked.composer_id = 419), 'musicbrainz:4996122e-d0b5-4e89-ac05-e32881335a87', 16, NULL, 'Sharons Discovery / Lusus in Persuit', 'Sharons Discovery / Lusus in Persuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4996122e-d0b5-4e89-ac05-e32881335a87'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "Sharons Discovery / Lusus in Persuit"', piece.title_en = 'Final Judgement: Sharons Discovery / Lusus in Persuit', piece.editor_locked = 1
WHERE piece.id = 23985 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25005 AND linked.composer_id = 419), 'musicbrainz:a3932eac-2d14-426e-bc23-73b1b63e2e69', 17, NULL, 'David and Ariel / David''s Fight', 'David and Ariel / David''s Fight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3932eac-2d14-426e-bc23-73b1b63e2e69'
);

UPDATE pieces piece
SET piece.title = 'Final Judgement 중 "David and Ariel / David''s Fight"', piece.title_en = 'Final Judgement: David and Ariel / David''s Fight', piece.editor_locked = 1
WHERE piece.id = 25005 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b29af74a-205c-4b49-8508-362750db8fe2', 18, NULL, 'End Credits', 'End Credits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Final Judgement' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b29af74a-205c-4b49-8508-362750db8fe2'
);


-- None Zero Option

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Zero Option', 'Zero Option', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 419
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Zero Option'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41cd09d4-5116-4de6-bbf5-ffe13c167eed', 1, NULL, 'Main Titles', 'Main Titles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41cd09d4-5116-4de6-bbf5-ffe13c167eed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24768 AND linked.composer_id = 419), 'musicbrainz:90b4641e-1149-4f2e-a58e-32be39115b36', 2, NULL, 'Love in the Evening', 'Love in the Evening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90b4641e-1149-4f2e-a58e-32be39115b36'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Love in the Evening"', piece.title_en = 'Zero Option: Love in the Evening', piece.editor_locked = 1
WHERE piece.id = 24768 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25824 AND linked.composer_id = 419), 'musicbrainz:f0d5adfe-7938-4ffa-916e-bb7c63d8c882', 3, NULL, 'The First Day Out of Prison', 'The First Day Out of Prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0d5adfe-7938-4ffa-916e-bb7c63d8c882'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The First Day Out of Prison"', piece.title_en = 'Zero Option: The First Day Out of Prison', piece.editor_locked = 1
WHERE piece.id = 25824 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23766 AND linked.composer_id = 419), 'musicbrainz:34f74dbc-eb4d-4799-8e79-d660dfbdbf03', 4, NULL, 'The Rescue', 'The Rescue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34f74dbc-eb4d-4799-8e79-d660dfbdbf03'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Rescue"', piece.title_en = 'Zero Option: The Rescue', piece.editor_locked = 1
WHERE piece.id = 23766 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05bbe6a2-594f-4771-a782-4425ef4f89bf', 5, NULL, 'The Messenger', 'The Messenger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05bbe6a2-594f-4771-a782-4425ef4f89bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25512 AND linked.composer_id = 419), 'musicbrainz:d585b7f5-ef7f-4775-8f94-f38f15e32c50', 6, NULL, 'Lee''s Deadline', 'Lee''s Deadline', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d585b7f5-ef7f-4775-8f94-f38f15e32c50'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Lee''s Deadline"', piece.title_en = 'Zero Option: Lee''s Deadline', piece.editor_locked = 1
WHERE piece.id = 25512 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23496 AND linked.composer_id = 419), 'musicbrainz:1a189db3-ae81-4a36-be82-3c69f6e54c1f', 7, NULL, 'A Tale of Another Time', 'A Tale of Another Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a189db3-ae81-4a36-be82-3c69f6e54c1f'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "A Tale of Another Time"', piece.title_en = 'Zero Option: A Tale of Another Time', piece.editor_locked = 1
WHERE piece.id = 23496 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23866 AND linked.composer_id = 419), 'musicbrainz:3dc6fcf0-133b-4c78-9a14-c446d07342f9', 8, NULL, 'A Child''s Interest', 'A Child''s Interest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc6fcf0-133b-4c78-9a14-c446d07342f9'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "A Child''s Interest"', piece.title_en = 'Zero Option: A Child''s Interest', piece.editor_locked = 1
WHERE piece.id = 23866 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23399 AND linked.composer_id = 419), 'musicbrainz:126c606d-8ffa-448c-896a-4a67584643dd', 9, NULL, 'The Lesson of Another Era', 'The Lesson of Another Era', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:126c606d-8ffa-448c-896a-4a67584643dd'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Lesson of Another Era"', piece.title_en = 'Zero Option: The Lesson of Another Era', piece.editor_locked = 1
WHERE piece.id = 23399 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25548 AND linked.composer_id = 419), 'musicbrainz:d7c5b216-15d7-4ce3-8de6-4f65181fb5e9', 10, NULL, 'Running Out of Time', 'Running Out of Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7c5b216-15d7-4ce3-8de6-4f65181fb5e9'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Running Out of Time"', piece.title_en = 'Zero Option: Running Out of Time', piece.editor_locked = 1
WHERE piece.id = 25548 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24882 AND linked.composer_id = 419), 'musicbrainz:9a91f9ee-04d8-4b92-ae38-b7b2cc6fafd5', 11, NULL, 'Wicked''s Hood', 'Wicked''s Hood', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a91f9ee-04d8-4b92-ae38-b7b2cc6fafd5'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Wicked''s Hood"', piece.title_en = 'Zero Option: Wicked''s Hood', piece.editor_locked = 1
WHERE piece.id = 24882 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25041 AND linked.composer_id = 419), 'musicbrainz:a713d993-465e-4b66-a29f-511ec5ddf7cb', 12, NULL, 'The Dripping of Time', 'The Dripping of Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a713d993-465e-4b66-a29f-511ec5ddf7cb'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Dripping of Time"', piece.title_en = 'Zero Option: The Dripping of Time', piece.editor_locked = 1
WHERE piece.id = 25041 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25978 AND linked.composer_id = 419), 'musicbrainz:fd8cd38c-43c0-425e-b8fe-fc6aa9c3d0ac', 13, NULL, 'Love for a Grandson', 'Love for a Grandson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd8cd38c-43c0-425e-b8fe-fc6aa9c3d0ac'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Love for a Grandson"', piece.title_en = 'Zero Option: Love for a Grandson', piece.editor_locked = 1
WHERE piece.id = 25978 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25036 AND linked.composer_id = 419), 'musicbrainz:a633a496-3bc5-49a8-9555-78b26f81488c', 14, NULL, 'The Inevitable Fall', 'The Inevitable Fall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a633a496-3bc5-49a8-9555-78b26f81488c'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Inevitable Fall"', piece.title_en = 'Zero Option: The Inevitable Fall', piece.editor_locked = 1
WHERE piece.id = 25036 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24144 AND linked.composer_id = 419), 'musicbrainz:59165285-d8fb-41e1-8bea-bbcccaad86ee', 15, NULL, 'Death of the Evil One', 'Death of the Evil One', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59165285-d8fb-41e1-8bea-bbcccaad86ee'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Death of the Evil One"', piece.title_en = 'Zero Option: Death of the Evil One', piece.editor_locked = 1
WHERE piece.id = 24144 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23368 AND linked.composer_id = 419), 'musicbrainz:0fac4e26-bbac-41bc-be51-37541a8707d2', 16, NULL, 'Running for Your Life', 'Running for Your Life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fac4e26-bbac-41bc-be51-37541a8707d2'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Running for Your Life"', piece.title_en = 'Zero Option: Running for Your Life', piece.editor_locked = 1
WHERE piece.id = 23368 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 26011 AND linked.composer_id = 419), 'musicbrainz:ffb1da4d-a6f3-42c7-a6a7-906126bd8432', 17, NULL, 'Love Waits', 'Love Waits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffb1da4d-a6f3-42c7-a6a7-906126bd8432'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Love Waits"', piece.title_en = 'Zero Option: Love Waits', piece.editor_locked = 1
WHERE piece.id = 26011 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25445 AND linked.composer_id = 419), 'musicbrainz:cf04654c-2092-4639-a04f-fdc26940d938', 18, NULL, 'The Vision of Death', 'The Vision of Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf04654c-2092-4639-a04f-fdc26940d938'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Vision of Death"', piece.title_en = 'Zero Option: The Vision of Death', piece.editor_locked = 1
WHERE piece.id = 25445 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25399 AND linked.composer_id = 419), 'musicbrainz:ca7dd987-09af-4811-9f99-3abdf15ba47e', 19, NULL, 'The Drift of a Late Night Dream', 'The Drift of a Late Night Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca7dd987-09af-4811-9f99-3abdf15ba47e'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Drift of a Late Night Dream"', piece.title_en = 'Zero Option: The Drift of a Late Night Dream', piece.editor_locked = 1
WHERE piece.id = 25399 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24901 AND linked.composer_id = 419), 'musicbrainz:9c336ffc-f2c5-445d-b51d-eb7811b9101b', 20, NULL, 'The Sleepless', 'The Sleepless', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c336ffc-f2c5-445d-b51d-eb7811b9101b'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Sleepless"', piece.title_en = 'Zero Option: The Sleepless', piece.editor_locked = 1
WHERE piece.id = 24901 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25883 AND linked.composer_id = 419), 'musicbrainz:f54aea7d-b3e8-4726-a912-b3686a5080c6', 21, NULL, 'A Thought for Tomorrow', 'A Thought for Tomorrow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f54aea7d-b3e8-4726-a912-b3686a5080c6'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "A Thought for Tomorrow"', piece.title_en = 'Zero Option: A Thought for Tomorrow', piece.editor_locked = 1
WHERE piece.id = 25883 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24492 AND linked.composer_id = 419), 'musicbrainz:7814c8c9-a104-4a2b-aee1-1a5966caffe2', 22, NULL, 'Reaching Into the Darkness', 'Reaching Into the Darkness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7814c8c9-a104-4a2b-aee1-1a5966caffe2'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Reaching Into the Darkness"', piece.title_en = 'Zero Option: Reaching Into the Darkness', piece.editor_locked = 1
WHERE piece.id = 24492 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25350 AND linked.composer_id = 419), 'musicbrainz:c546880e-2bf1-481e-8d1e-2f6deb169368', 23, NULL, 'Sweet Memories', 'Sweet Memories', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c546880e-2bf1-481e-8d1e-2f6deb169368'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Sweet Memories"', piece.title_en = 'Zero Option: Sweet Memories', piece.editor_locked = 1
WHERE piece.id = 25350 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25943 AND linked.composer_id = 419), 'musicbrainz:fadc40d1-5912-42d5-a03e-329ba8232fd0', 24, NULL, 'The Drift of an Afternoon Dream', 'The Drift of an Afternoon Dream', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fadc40d1-5912-42d5-a03e-329ba8232fd0'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Drift of an Afternoon Dream"', piece.title_en = 'Zero Option: The Drift of an Afternoon Dream', piece.editor_locked = 1
WHERE piece.id = 25943 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25810 AND linked.composer_id = 419), 'musicbrainz:ef5c9ec5-0a75-49b9-9e67-5d5be6378429', 25, NULL, 'The Desire of a Woman Gone Mad', 'The Desire of a Woman Gone Mad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef5c9ec5-0a75-49b9-9e67-5d5be6378429'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Desire of a Woman Gone Mad"', piece.title_en = 'Zero Option: The Desire of a Woman Gone Mad', piece.editor_locked = 1
WHERE piece.id = 25810 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24892 AND linked.composer_id = 419), 'musicbrainz:9b8fbf98-47b9-4efb-90e1-1d155ae339eb', 26, NULL, 'Molecules', 'Molecules', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b8fbf98-47b9-4efb-90e1-1d155ae339eb'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Molecules"', piece.title_en = 'Zero Option: Molecules', piece.editor_locked = 1
WHERE piece.id = 24892 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23227 AND linked.composer_id = 419), 'musicbrainz:0368bed3-f1cd-4bf5-a1ff-a06894a1c081', 27, NULL, 'The Meeting Without One Then Another', 'The Meeting Without One Then Another', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0368bed3-f1cd-4bf5-a1ff-a06894a1c081'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "The Meeting Without One Then Another"', piece.title_en = 'Zero Option: The Meeting Without One Then Another', piece.editor_locked = 1
WHERE piece.id = 23227 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24113 AND linked.composer_id = 419), 'musicbrainz:5611fcac-5aae-4c65-bb80-0c0f6dedbb69', 28, NULL, 'Reaching for Tomorrow''s Love', 'Reaching for Tomorrow''s Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 419 AND p.title = 'Zero Option' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5611fcac-5aae-4c65-bb80-0c0f6dedbb69'
);

UPDATE pieces piece
SET piece.title = 'Zero Option 중 "Reaching for Tomorrow''s Love"', piece.title_en = 'Zero Option: Reaching for Tomorrow''s Love', piece.editor_locked = 1
WHERE piece.id = 24113 AND piece.composer_id = 419
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 419 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    25156
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
