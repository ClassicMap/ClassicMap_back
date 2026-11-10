-- 작곡가 1명의 큐를 MusicBrainz 음반 단위로 묶는다(6차 자동, 7/9).
-- 작품 10개(새 8개), seed 77개 중 잇기 77·숨김 0·그대로 0.
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

-- ===== 해럴드 버드 (composer_id 399) =====
-- 큐를 음반 단위로 묶는다(6차). 작품 10개 중 음반 묶음 8개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡) 2개,
-- 새 작품 8개, part 86개, 그 아래 0개.
-- seed 77개 중 75개를 음반 묶음 안 곡으로 잇고, 2개는 낱개 작품으로 두고, 0개를 숨긴다.

-- None 가곡 <Flowered Knife Shadows>

UPDATE pieces piece
SET piece.title = '가곡 <Flowered Knife Shadows>', piece.title_en = 'Flowered Knife Shadows',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23122 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Sun at Six Windows>

UPDATE pieces piece
SET piece.title = '가곡 <Sun at Six Windows>', piece.title_en = 'Sun at Six Windows',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23176 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Luxa

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Luxa', 'Luxa', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 399
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Luxa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24589 AND linked.composer_id = 399), 'musicbrainz:7fd69d0f-85e6-4618-a372-74a56e80113b', 1, NULL, 'Niki D.', 'Niki D.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd69d0f-85e6-4618-a372-74a56e80113b'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Niki D."', piece.title_en = 'Luxa: Niki D.', piece.editor_locked = 1
WHERE piece.id = 24589 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25959 AND linked.composer_id = 399), 'musicbrainz:fc2bf0fd-b8d2-4f11-9c68-edc340d1fce6', 2, NULL, 'A Sidelong Glance From My Round Nefertiti', 'A Sidelong Glance From My Round Nefertiti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc2bf0fd-b8d2-4f11-9c68-edc340d1fce6'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "A Sidelong Glance From My Round Nefertiti"', piece.title_en = 'Luxa: A Sidelong Glance From My Round Nefertiti', piece.editor_locked = 1
WHERE piece.id = 25959 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24725 AND linked.composer_id = 399), 'musicbrainz:8d20ba5e-80c0-4b66-a08f-9d61b669be44', 3, NULL, 'Agnes Martin', 'Agnes Martin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d20ba5e-80c0-4b66-a08f-9d61b669be44'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Agnes Martin"', piece.title_en = 'Luxa: Agnes Martin', piece.editor_locked = 1
WHERE piece.id = 24725 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25318 AND linked.composer_id = 399), 'musicbrainz:c2964402-135a-49cc-b593-34136b45df55', 4, NULL, 'Anish Kapoor', 'Anish Kapoor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2964402-135a-49cc-b593-34136b45df55'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Anish Kapoor"', piece.title_en = 'Luxa: Anish Kapoor', piece.editor_locked = 1
WHERE piece.id = 25318 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23708 AND linked.composer_id = 399), 'musicbrainz:2f7d8f9f-fd92-443f-b69f-cf839ca8a41f', 5, NULL, 'Paul McCarthy', 'Paul McCarthy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f7d8f9f-fd92-443f-b69f-cf839ca8a41f'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Paul McCarthy"', piece.title_en = 'Luxa: Paul McCarthy', piece.editor_locked = 1
WHERE piece.id = 23708 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24943 AND linked.composer_id = 399), 'musicbrainz:9ef0890d-6bd0-41a9-97f9-8a4ff74bbdba', 6, NULL, 'Serge Poliakoff', 'Serge Poliakoff', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ef0890d-6bd0-41a9-97f9-8a4ff74bbdba'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Serge Poliakoff"', piece.title_en = 'Luxa: Serge Poliakoff', piece.editor_locked = 1
WHERE piece.id = 24943 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24252 AND linked.composer_id = 399), 'musicbrainz:62a15e57-4da2-4d5e-9a38-413ad114c400', 7, NULL, 'Djinn', 'Djinn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62a15e57-4da2-4d5e-9a38-413ad114c400'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Djinn"', piece.title_en = 'Luxa: Djinn', piece.editor_locked = 1
WHERE piece.id = 24252 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23241 AND linked.composer_id = 399), 'musicbrainz:0563c848-098b-4ca9-a7eb-27fd49394800', 8, NULL, 'Porphyry', 'Porphyry', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0563c848-098b-4ca9-a7eb-27fd49394800'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Porphyry"', piece.title_en = 'Luxa: Porphyry', piece.editor_locked = 1
WHERE piece.id = 23241 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25640 AND linked.composer_id = 399), 'musicbrainz:e052347e-9aa3-42ed-9297-69e22af8ebcb', 9, NULL, 'How Dark the Response to Our Slipping Away', 'How Dark the Response to Our Slipping Away', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e052347e-9aa3-42ed-9297-69e22af8ebcb'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "How Dark the Response to Our Slipping Away"', piece.title_en = 'Luxa: How Dark the Response to Our Slipping Away', piece.editor_locked = 1
WHERE piece.id = 25640 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25962 AND linked.composer_id = 399), 'musicbrainz:fc7c3314-d70e-42a5-be77-c6f5611094c5', 10, NULL, 'Nove Alberi', 'Nove Alberi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc7c3314-d70e-42a5-be77-c6f5611094c5'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Nove Alberi"', piece.title_en = 'Luxa: Nove Alberi', piece.editor_locked = 1
WHERE piece.id = 25962 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25102 AND linked.composer_id = 399), 'musicbrainz:ac68f4d4-89c8-40a6-9510-b965d6a9c4ce', 11, NULL, 'Chet', 'Chet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac68f4d4-89c8-40a6-9510-b965d6a9c4ce'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Chet"', piece.title_en = 'Luxa: Chet', piece.editor_locked = 1
WHERE piece.id = 25102 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24669 AND linked.composer_id = 399), 'musicbrainz:8739954e-952a-4be4-948b-889f14bc56c3', 12, NULL, 'Mandan', 'Mandan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8739954e-952a-4be4-948b-889f14bc56c3'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Mandan"', piece.title_en = 'Luxa: Mandan', piece.editor_locked = 1
WHERE piece.id = 24669 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25290 AND linked.composer_id = 399), 'musicbrainz:bf86a954-e7c6-4ab1-b0e6-4ebaa550be0d', 13, NULL, 'Feral', 'Feral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf86a954-e7c6-4ab1-b0e6-4ebaa550be0d'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Feral"', piece.title_en = 'Luxa: Feral', piece.editor_locked = 1
WHERE piece.id = 25290 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23961 AND linked.composer_id = 399), 'musicbrainz:46cfc756-2521-4bcc-ae35-f23132d0ce7b', 14, NULL, 'Grace', 'Grace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Luxa' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46cfc756-2521-4bcc-ae35-f23132d0ce7b'
);

UPDATE pieces piece
SET piece.title = 'Luxa 중 "Grace"', piece.title_en = 'Luxa: Grace', piece.editor_locked = 1
WHERE piece.id = 23961 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None By the Dawn’s Early Light

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'By the Dawn’s Early Light', 'By the Dawn’s Early Light', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 399
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'By the Dawn’s Early Light'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25463 AND linked.composer_id = 399), 'musicbrainz:d1238601-e933-4eae-a3f9-4683acc3e72d', 1, NULL, 'Poem: Aztec Hotel', 'Poem: Aztec Hotel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1238601-e933-4eae-a3f9-4683acc3e72d'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Poem: Aztec Hotel"', piece.title_en = 'By the Dawn’s Early Light: Poem: Aztec Hotel', piece.editor_locked = 1
WHERE piece.id = 25463 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24548 AND linked.composer_id = 399), 'musicbrainz:7cc2e2e7-1e0f-49d6-b1e7-325621aaa4d0', 2, NULL, 'Boy About 10', 'Boy About 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cc2e2e7-1e0f-49d6-b1e7-325621aaa4d0'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Boy About 10"', piece.title_en = 'By the Dawn’s Early Light: Boy About 10', piece.editor_locked = 1
WHERE piece.id = 24548 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23304 AND linked.composer_id = 399), 'musicbrainz:0b5ea95c-7f56-4bf7-97b8-bb622474a8f9', 3, NULL, 'Arcadia', 'Arcadia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b5ea95c-7f56-4bf7-97b8-bb622474a8f9'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Arcadia"', piece.title_en = 'By the Dawn’s Early Light: Arcadia', piece.editor_locked = 1
WHERE piece.id = 23304 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24394 AND linked.composer_id = 399), 'musicbrainz:7009ea42-9e4c-4ab6-a904-c1daf96c925f', 4, NULL, 'Dead Horse Alive With Flies', 'Dead Horse Alive With Flies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7009ea42-9e4c-4ab6-a904-c1daf96c925f'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Dead Horse Alive With Flies"', piece.title_en = 'By the Dawn’s Early Light: Dead Horse Alive With Flies', piece.editor_locked = 1
WHERE piece.id = 24394 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24225 AND linked.composer_id = 399), 'musicbrainz:600ad299-fc0c-4bf6-a1e6-a8cfdf97a5f2', 5, NULL, 'The Photo of Santiago McKinn', 'The Photo of Santiago McKinn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:600ad299-fc0c-4bf6-a1e6-a8cfdf97a5f2'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "The Photo of Santiago McKinn"', piece.title_en = 'By the Dawn’s Early Light: The Photo of Santiago McKinn', piece.editor_locked = 1
WHERE piece.id = 24225 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24286 AND linked.composer_id = 399), 'musicbrainz:66a00bb4-595e-4cfd-ba6a-4fc1a4e2cc1f', 6, NULL, 'The Corpse at the Shooting Gallery', 'The Corpse at the Shooting Gallery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66a00bb4-595e-4cfd-ba6a-4fc1a4e2cc1f'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "The Corpse at the Shooting Gallery"', piece.title_en = 'By the Dawn’s Early Light: The Corpse at the Shooting Gallery', piece.editor_locked = 1
WHERE piece.id = 24286 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24356 AND linked.composer_id = 399), 'musicbrainz:6cdcb92e-3d0d-46a3-9505-4182b4ec019b', 7, NULL, 'Albion Farewell (Homage to Delius, for Gavin Bryars)', 'Albion Farewell (Homage to Delius, for Gavin Bryars)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cdcb92e-3d0d-46a3-9505-4182b4ec019b'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Albion Farewell (Homage to Delius, for Gavin Bryars)"', piece.title_en = 'By the Dawn’s Early Light: Albion Farewell (Homage to Delius, for Gavin Bryars)', piece.editor_locked = 1
WHERE piece.id = 24356 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24434 AND linked.composer_id = 399), 'musicbrainz:73616ead-800c-4ade-ad97-f926182a023f', 8, NULL, 'Poem: Distant Lights of Olancha Recede', 'Poem: Distant Lights of Olancha Recede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73616ead-800c-4ade-ad97-f926182a023f'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Poem: Distant Lights of Olancha Recede"', piece.title_en = 'By the Dawn’s Early Light: Poem: Distant Lights of Olancha Recede', piece.editor_locked = 1
WHERE piece.id = 24434 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25357 AND linked.composer_id = 399), 'musicbrainz:c5e7d2ce-7f00-407d-a68a-0512bafb745c', 9, NULL, 'Down the Slopes to the Meadow (For Ruben Garcia)', 'Down the Slopes to the Meadow (For Ruben Garcia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e7d2ce-7f00-407d-a68a-0512bafb745c'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Down the Slopes to the Meadow (For Ruben Garcia)"', piece.title_en = 'By the Dawn’s Early Light: Down the Slopes to the Meadow (For Ruben Garcia)', piece.editor_locked = 1
WHERE piece.id = 25357 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24760 AND linked.composer_id = 399), 'musicbrainz:8fb33fff-51d2-404b-8b06-f72cd3cf447b', 10, NULL, 'She Dances by the Light of the Silvery Moon', 'She Dances by the Light of the Silvery Moon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fb33fff-51d2-404b-8b06-f72cd3cf447b'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "She Dances by the Light of the Silvery Moon"', piece.title_en = 'By the Dawn’s Early Light: She Dances by the Light of the Silvery Moon', piece.editor_locked = 1
WHERE piece.id = 24760 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23358 AND linked.composer_id = 399), 'musicbrainz:0edaa600-04b0-42ae-89da-ecf00db92404', 11, NULL, 'Blind Bird', 'Blind Bird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0edaa600-04b0-42ae-89da-ecf00db92404'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Blind Bird"', piece.title_en = 'By the Dawn’s Early Light: Blind Bird', piece.editor_locked = 1
WHERE piece.id = 23358 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25225 AND linked.composer_id = 399), 'musicbrainz:b920d080-beb9-449b-bba0-fd2f26755e1e', 12, NULL, 'Saint’s Name Spoken', 'Saint’s Name Spoken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b920d080-beb9-449b-bba0-fd2f26755e1e'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "Saint’s Name Spoken"', piece.title_en = 'By the Dawn’s Early Light: Saint’s Name Spoken', piece.editor_locked = 1
WHERE piece.id = 25225 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35eb9661-e419-46c5-b4ee-3c6795bc9e72', 13, NULL, 'The Place of Dead Roads', 'The Place of Dead Roads', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35eb9661-e419-46c5-b4ee-3c6795bc9e72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23459 AND linked.composer_id = 399), 'musicbrainz:174955ac-f618-4ad7-aec8-6cb7c3878b00', 14, NULL, 'A Child in a Sylvan Field', 'A Child in a Sylvan Field', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'By the Dawn’s Early Light' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:174955ac-f618-4ad7-aec8-6cb7c3878b00'
);

UPDATE pieces piece
SET piece.title = 'By the Dawn’s Early Light 중 "A Child in a Sylvan Field"', piece.title_en = 'By the Dawn’s Early Light: A Child in a Sylvan Field', piece.editor_locked = 1
WHERE piece.id = 23459 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In the Mist

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'In the Mist', 'In the Mist', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 399
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'In the Mist'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23730 AND linked.composer_id = 399), 'musicbrainz:31843ce5-4751-46c9-bbe5-05d6aa5de3d8', 1, NULL, 'Haru Spring', 'Haru Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31843ce5-4751-46c9-bbe5-05d6aa5de3d8'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "Haru Spring"', piece.title_en = 'In the Mist: Haru Spring', piece.editor_locked = 1
WHERE piece.id = 23730 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25826 AND linked.composer_id = 399), 'musicbrainz:f100d9d0-f20a-41ac-b145-2fe5270d42c0', 2, NULL, 'The Whispers', 'The Whispers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f100d9d0-f20a-41ac-b145-2fe5270d42c0'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "The Whispers"', piece.title_en = 'In the Mist: The Whispers', piece.editor_locked = 1
WHERE piece.id = 25826 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24682 AND linked.composer_id = 399), 'musicbrainz:88c0fd62-ac56-4d1e-9774-cfcfb0b9800a', 3, NULL, 'The Startled', 'The Startled', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88c0fd62-ac56-4d1e-9774-cfcfb0b9800a'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "The Startled"', piece.title_en = 'In the Mist: The Startled', piece.editor_locked = 1
WHERE piece.id = 24682 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25524 AND linked.composer_id = 399), 'musicbrainz:d6128074-ba14-4ce8-a1b7-3426737a1a99', 4, NULL, 'The Foundry (For Mika Vainio)', 'The Foundry (For Mika Vainio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6128074-ba14-4ce8-a1b7-3426737a1a99'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "The Foundry (For Mika Vainio)"', piece.title_en = 'In the Mist: The Foundry (For Mika Vainio)', piece.editor_locked = 1
WHERE piece.id = 25524 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23269 AND linked.composer_id = 399), 'musicbrainz:08374674-8363-4b97-add9-9f96ca154541', 5, NULL, 'The Art of Mirrors (After Derek Jarman)', 'The Art of Mirrors (After Derek Jarman)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08374674-8363-4b97-add9-9f96ca154541'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "The Art of Mirrors (After Derek Jarman)"', piece.title_en = 'In the Mist: The Art of Mirrors (After Derek Jarman)', piece.editor_locked = 1
WHERE piece.id = 23269 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25612 AND linked.composer_id = 399), 'musicbrainz:dd1ac47a-c11b-48f2-bd60-4eb7be65f92d', 6, NULL, 'Three-Fingered Jack', 'Three-Fingered Jack', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd1ac47a-c11b-48f2-bd60-4eb7be65f92d'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "Three-Fingered Jack"', piece.title_en = 'In the Mist: Three-Fingered Jack', piece.editor_locked = 1
WHERE piece.id = 25612 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25856 AND linked.composer_id = 399), 'musicbrainz:f320d674-2786-42ea-83b2-9738c7821d82', 7, NULL, 'Greek George', 'Greek George', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f320d674-2786-42ea-83b2-9738c7821d82'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "Greek George"', piece.title_en = 'In the Mist: Greek George', piece.editor_locked = 1
WHERE piece.id = 25856 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24137 AND linked.composer_id = 399), 'musicbrainz:5873d5e8-7ab7-4292-810d-d2bac80685b5', 8, NULL, 'Black Bart', 'Black Bart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5873d5e8-7ab7-4292-810d-d2bac80685b5'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "Black Bart"', piece.title_en = 'In the Mist: Black Bart', piece.editor_locked = 1
WHERE piece.id = 24137 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25776 AND linked.composer_id = 399), 'musicbrainz:ebd905ad-ae7d-4107-9963-76252713c988', 9, NULL, 'Come Back to Me in Dreams', 'Come Back to Me in Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebd905ad-ae7d-4107-9963-76252713c988'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "Come Back to Me in Dreams"', piece.title_en = 'In the Mist: Come Back to Me in Dreams', piece.editor_locked = 1
WHERE piece.id = 25776 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24988 AND linked.composer_id = 399), 'musicbrainz:a2649af1-d0cd-4ab1-8ef8-79f0fde3071e', 10, NULL, 'Parallel Night', 'Parallel Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2649af1-d0cd-4ab1-8ef8-79f0fde3071e'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "Parallel Night"', piece.title_en = 'In the Mist: Parallel Night', piece.editor_locked = 1
WHERE piece.id = 24988 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25321 AND linked.composer_id = 399), 'musicbrainz:c2ce17fe-0f6d-40c2-9682-4df454490ba6', 11, NULL, 'Sun at 6 Windows', 'Sun at 6 Windows', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2ce17fe-0f6d-40c2-9682-4df454490ba6'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "Sun at 6 Windows"', piece.title_en = 'In the Mist: Sun at 6 Windows', piece.editor_locked = 1
WHERE piece.id = 25321 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24198 AND linked.composer_id = 399), 'musicbrainz:5e58829b-ae74-4a35-bc60-3217aed779be', 12, NULL, 'The Panther of Small Favors', 'The Panther of Small Favors', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e58829b-ae74-4a35-bc60-3217aed779be'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "The Panther of Small Favors"', piece.title_en = 'In the Mist: The Panther of Small Favors', piece.editor_locked = 1
WHERE piece.id = 24198 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24652 AND linked.composer_id = 399), 'musicbrainz:8594e489-6388-4a45-988f-069a67fc2bbc', 13, NULL, 'Mars and the Artist (After Cy Twombly)', 'Mars and the Artist (After Cy Twombly)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'In the Mist' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8594e489-6388-4a45-988f-069a67fc2bbc'
);

UPDATE pieces piece
SET piece.title = 'In the Mist 중 "Mars and the Artist (After Cy Twombly)"', piece.title_en = 'In the Mist: Mars and the Artist (After Cy Twombly)', piece.editor_locked = 1
WHERE piece.id = 24652 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Know This Much Is True (Music From The HBO Series)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'I Know This Much Is True (Music From The HBO Series)', 'I Know This Much Is True (Music From The HBO Series)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 399
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'I Know This Much Is True (Music From The HBO Series)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23924 AND linked.composer_id = 399), 'musicbrainz:43bb483a-f705-473d-ac2c-65f4c9fd663c', 1, NULL, 'Penny Ann Drinkwater', 'Penny Ann Drinkwater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43bb483a-f705-473d-ac2c-65f4c9fd663c'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "Penny Ann Drinkwater"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): Penny Ann Drinkwater', piece.editor_locked = 1
WHERE piece.id = 23924 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25774 AND linked.composer_id = 399), 'musicbrainz:eba3abe6-182b-489c-b452-1ecd09750771', 2, NULL, 'The Serpent (In Quicksilver)', 'The Serpent (In Quicksilver)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eba3abe6-182b-489c-b452-1ecd09750771'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "The Serpent (In Quicksilver)"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): The Serpent (In Quicksilver)', piece.editor_locked = 1
WHERE piece.id = 25774 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23679 AND linked.composer_id = 399), 'musicbrainz:2b56d78d-ee72-4060-9ad9-fb1b30b73984', 3, NULL, 'Give Me Your Hand', 'Give Me Your Hand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b56d78d-ee72-4060-9ad9-fb1b30b73984'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "Give Me Your Hand"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): Give Me Your Hand', piece.editor_locked = 1
WHERE piece.id = 23679 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25747 AND linked.composer_id = 399), 'musicbrainz:e8fc1d5e-5b40-43c3-8e17-689589af65f1', 4, NULL, 'The Twins', 'The Twins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8fc1d5e-5b40-43c3-8e17-689589af65f1'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "The Twins"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): The Twins', piece.editor_locked = 1
WHERE piece.id = 25747 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7513b44-61a9-445f-b536-6b37dd61e6e0', 5, NULL, 'The Kiss', 'The Kiss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7513b44-61a9-445f-b536-6b37dd61e6e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25219 AND linked.composer_id = 399), 'musicbrainz:b8d5b83e-2825-423e-9da7-83b4f6365102', 6, NULL, 'In America', 'In America', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d5b83e-2825-423e-9da7-83b4f6365102'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "In America"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): In America', piece.editor_locked = 1
WHERE piece.id = 25219 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25324 AND linked.composer_id = 399), 'musicbrainz:c319a895-85c8-4847-88a0-a61c669fca2c', 7, NULL, 'Angela', 'Angela', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c319a895-85c8-4847-88a0-a61c669fca2c'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "Angela"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): Angela', piece.editor_locked = 1
WHERE piece.id = 25324 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25803 AND linked.composer_id = 399), 'musicbrainz:ee88bcf8-c82b-4de2-971d-b2b953a68004', 8, NULL, 'To the Falls', 'To the Falls', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee88bcf8-c82b-4de2-971d-b2b953a68004'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "To the Falls"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): To the Falls', piece.editor_locked = 1
WHERE piece.id = 25803 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24082 AND linked.composer_id = 399), 'musicbrainz:535a2ccf-c9e4-41e3-9983-b983389bea2f', 9, NULL, 'Domenico', 'Domenico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:535a2ccf-c9e4-41e3-9983-b983389bea2f'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "Domenico"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): Domenico', piece.editor_locked = 1
WHERE piece.id = 24082 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24188 AND linked.composer_id = 399), 'musicbrainz:5d3da629-3320-4930-8135-b804394ef176', 10, NULL, 'That Place for Lunatics', 'That Place for Lunatics', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d3da629-3320-4930-8135-b804394ef176'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "That Place for Lunatics"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): That Place for Lunatics', piece.editor_locked = 1
WHERE piece.id = 24188 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23886 AND linked.composer_id = 399), 'musicbrainz:406f812d-e958-4b90-bfaa-d31bedbe5004', 11, NULL, 'Yellow', 'Yellow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:406f812d-e958-4b90-bfaa-d31bedbe5004'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "Yellow"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): Yellow', piece.editor_locked = 1
WHERE piece.id = 23886 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc2bf0fd-b8d2-4f11-9c68-edc340d1fce6', 12, NULL, 'A Sidelong Glance From My Round Nefertiti', 'A Sidelong Glance From My Round Nefertiti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc2bf0fd-b8d2-4f11-9c68-edc340d1fce6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23810 AND linked.composer_id = 399), 'musicbrainz:38a23f43-f3a6-4cec-ba0a-1197f980c7a7', 13, NULL, 'Three Rivers', 'Three Rivers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38a23f43-f3a6-4cec-ba0a-1197f980c7a7'
);

UPDATE pieces piece
SET piece.title = 'I Know This Much Is True (Music From The HBO Series) 중 "Three Rivers"', piece.title_en = 'I Know This Much Is True (Music From The HBO Series): Three Rivers', piece.editor_locked = 1
WHERE piece.id = 23810 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5e7d2ce-7f00-407d-a68a-0512bafb745c', 14, NULL, 'Down the Slopes to the Meadow (For Ruben Garcia)', 'Down the Slopes to the Meadow (For Ruben Garcia)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'I Know This Much Is True (Music From The HBO Series)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e7d2ce-7f00-407d-a68a-0512bafb745c'
);


-- None Avalon Sutra

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Avalon Sutra', 'Avalon Sutra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 399
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Avalon Sutra'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33c5877f-7f18-3676-bc19-fff76878fc43', 1, NULL, 'Arabesque 3', 'Arabesque 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33c5877f-7f18-3676-bc19-fff76878fc43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25126 AND linked.composer_id = 399), 'musicbrainz:aee0722b-3ed3-3d28-a368-fe4d61be84fb', 2, NULL, 'It''s Steeper Near the Roses (For David Sylvian)', 'It''s Steeper Near the Roses (For David Sylvian)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aee0722b-3ed3-3d28-a368-fe4d61be84fb'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "It''s Steeper Near the Roses (For David Sylvian)"', piece.title_en = 'Avalon Sutra: It''s Steeper Near the Roses (For David Sylvian)', piece.editor_locked = 1
WHERE piece.id = 25126 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25544 AND linked.composer_id = 399), 'musicbrainz:d7a84e25-7e03-3904-bf22-548475570ef6', 3, NULL, 'L''Enfant perdu', 'L''Enfant perdu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a84e25-7e03-3904-bf22-548475570ef6'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "L''Enfant perdu"', piece.title_en = 'Avalon Sutra: L''Enfant perdu', piece.editor_locked = 1
WHERE piece.id = 25544 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23229 AND linked.composer_id = 399), 'musicbrainz:03a4f832-40b8-3669-93cf-1399ee13ff65', 4, NULL, 'Chrysalis Nu (To Barney''s Memory)', 'Chrysalis Nu (To Barney''s Memory)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a4f832-40b8-3669-93cf-1399ee13ff65'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "Chrysalis Nu (To Barney''s Memory)"', piece.title_en = 'Avalon Sutra: Chrysalis Nu (To Barney''s Memory)', piece.editor_locked = 1
WHERE piece.id = 23229 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25069 AND linked.composer_id = 399), 'musicbrainz:a9bbedec-47b0-34c4-956c-411820c802fe', 5, NULL, 'Three Faces West (Billy Al Bengston''s)', 'Three Faces West (Billy Al Bengston''s)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9bbedec-47b0-34c4-956c-411820c802fe'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "Three Faces West (Billy Al Bengston''s)"', piece.title_en = 'Avalon Sutra: Three Faces West (Billy Al Bengston''s)', piece.editor_locked = 1
WHERE piece.id = 25069 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdb6166f-b054-38f7-aac7-034fb5a065e9', 6, NULL, 'Arabesque 2', 'Arabesque 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdb6166f-b054-38f7-aac7-034fb5a065e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25228 AND linked.composer_id = 399), 'musicbrainz:b96646d6-b1af-3c4a-9e82-c84d0596f065', 7, NULL, 'Little Heart', 'Little Heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b96646d6-b1af-3c4a-9e82-c84d0596f065'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "Little Heart"', piece.title_en = 'Avalon Sutra: Little Heart', piece.editor_locked = 1
WHERE piece.id = 25228 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3901ca83-3918-30d7-ab07-6c1914a7c2b3', 8, NULL, 'How Vacantly You Stare at Me', 'How Vacantly You Stare at Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3901ca83-3918-30d7-ab07-6c1914a7c2b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24239 AND linked.composer_id = 399), 'musicbrainz:60fef02e-1087-3ea1-a472-5af10160a8f0', 9, NULL, 'A Walk in the Park With Nancy (In Memory)', 'A Walk in the Park With Nancy (In Memory)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60fef02e-1087-3ea1-a472-5af10160a8f0'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "A Walk in the Park With Nancy (In Memory)"', piece.title_en = 'Avalon Sutra: A Walk in the Park With Nancy (In Memory)', piece.editor_locked = 1
WHERE piece.id = 24239 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24419 AND linked.composer_id = 399), 'musicbrainz:71ea0fca-c01d-35c3-94ed-7fcca8610f43', 10, NULL, 'Rue Casimir Delavigne (For Daniel Lentz)', 'Rue Casimir Delavigne (For Daniel Lentz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71ea0fca-c01d-35c3-94ed-7fcca8610f43'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "Rue Casimir Delavigne (For Daniel Lentz)"', piece.title_en = 'Avalon Sutra: Rue Casimir Delavigne (For Daniel Lentz)', piece.editor_locked = 1
WHERE piece.id = 24419 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:965ea299-b6a1-33a1-8270-4610dbcfd3e7', 11, NULL, 'Arabesque 1', 'Arabesque 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:965ea299-b6a1-33a1-8270-4610dbcfd3e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23353 AND linked.composer_id = 399), 'musicbrainz:0e693f96-918f-39c0-b019-55a804176369', 12, NULL, 'Porcelain Ginger', 'Porcelain Ginger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e693f96-918f-39c0-b019-55a804176369'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "Porcelain Ginger"', piece.title_en = 'Avalon Sutra: Porcelain Ginger', piece.editor_locked = 1
WHERE piece.id = 23353 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24786 AND linked.composer_id = 399), 'musicbrainz:9269b9cc-8b8c-3a68-bfb1-2ac1beb93a8c', 13, NULL, 'Faraon', 'Faraon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9269b9cc-8b8c-3a68-bfb1-2ac1beb93a8c'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "Faraon"', piece.title_en = 'Avalon Sutra: Faraon', piece.editor_locked = 1
WHERE piece.id = 24786 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25968 AND linked.composer_id = 399), 'musicbrainz:fcd603a0-6b77-355f-86b6-7907e90c1cd3', 14, NULL, 'As Long as I Can Hold My Breath', 'As Long as I Can Hold My Breath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'Avalon Sutra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcd603a0-6b77-355f-86b6-7907e90c1cd3'
);

UPDATE pieces piece
SET piece.title = 'Avalon Sutra 중 "As Long as I Can Hold My Breath"', piece.title_en = 'Avalon Sutra: As Long as I Can Hold My Breath', piece.editor_locked = 1
WHERE piece.id = 25968 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The White Arcades (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The White Arcades (음반)', 'The White Arcades', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 399
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The White Arcades (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24777 AND linked.composer_id = 399), 'musicbrainz:91d64d6e-9009-4868-ac32-38b26202687c', 1, NULL, 'The White Arcades', 'The White Arcades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91d64d6e-9009-4868-ac32-38b26202687c'
);

UPDATE pieces piece
SET piece.title = 'The White Arcades (음반) 중 "The White Arcades"', piece.title_en = 'The White Arcades: The White Arcades', piece.editor_locked = 1
WHERE piece.id = 24777 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24575 AND linked.composer_id = 399), 'musicbrainz:7efa1022-e77b-4397-a0fb-c6c1dc2d6b3e', 2, NULL, 'Balthus Bemused by Color', 'Balthus Bemused by Color', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7efa1022-e77b-4397-a0fb-c6c1dc2d6b3e'
);

UPDATE pieces piece
SET piece.title = 'The White Arcades (음반) 중 "Balthus Bemused by Color"', piece.title_en = 'The White Arcades: Balthus Bemused by Color', piece.editor_locked = 1
WHERE piece.id = 24575 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23540 AND linked.composer_id = 399), 'musicbrainz:1ddf12ed-2a07-4a72-bfe7-89c4a713a3db', 3, NULL, 'The Child With a Lion', 'The Child With a Lion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ddf12ed-2a07-4a72-bfe7-89c4a713a3db'
);

UPDATE pieces piece
SET piece.title = 'The White Arcades (음반) 중 "The Child With a Lion"', piece.title_en = 'The White Arcades: The Child With a Lion', piece.editor_locked = 1
WHERE piece.id = 23540 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25304 AND linked.composer_id = 399), 'musicbrainz:c0e2cbe0-cd00-4c32-82f0-9d6b4aac7504', 4, NULL, 'The Real Dream of Sails', 'The Real Dream of Sails', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0e2cbe0-cd00-4c32-82f0-9d6b4aac7504'
);

UPDATE pieces piece
SET piece.title = 'The White Arcades (음반) 중 "The Real Dream of Sails"', piece.title_en = 'The White Arcades: The Real Dream of Sails', piece.editor_locked = 1
WHERE piece.id = 25304 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24754 AND linked.composer_id = 399), 'musicbrainz:8f0ca7d7-e96b-4cd0-8bcc-1ecd44f3e87f', 5, NULL, 'Algebra of Darkness', 'Algebra of Darkness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f0ca7d7-e96b-4cd0-8bcc-1ecd44f3e87f'
);

UPDATE pieces piece
SET piece.title = 'The White Arcades (음반) 중 "Algebra of Darkness"', piece.title_en = 'The White Arcades: Algebra of Darkness', piece.editor_locked = 1
WHERE piece.id = 24754 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b9f02ac-7358-44d1-957b-bec17856e496', 6, NULL, 'Totems of the Red-Sleeved Warrior', 'Totems of the Red-Sleeved Warrior', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b9f02ac-7358-44d1-957b-bec17856e496'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25155 AND linked.composer_id = 399), 'musicbrainz:b2039d9b-7bea-42b5-8006-67ce0349fb7c', 7, NULL, 'The Room', 'The Room', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2039d9b-7bea-42b5-8006-67ce0349fb7c'
);

UPDATE pieces piece
SET piece.title = 'The White Arcades (음반) 중 "The Room"', piece.title_en = 'The White Arcades: The Room', piece.editor_locked = 1
WHERE piece.id = 25155 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24654 AND linked.composer_id = 399), 'musicbrainz:859a94c0-ce38-4d64-8fe6-db8b99032de2', 8, NULL, 'Coyote', 'Coyote', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:859a94c0-ce38-4d64-8fe6-db8b99032de2'
);

UPDATE pieces piece
SET piece.title = 'The White Arcades (음반) 중 "Coyote"', piece.title_en = 'The White Arcades: Coyote', piece.editor_locked = 1
WHERE piece.id = 24654 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7513b44-61a9-445f-b536-6b37dd61e6e0', 9, NULL, 'The Kiss', 'The Kiss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The White Arcades (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7513b44-61a9-445f-b536-6b37dd61e6e0'
);


-- None The Pavilion of Dreams

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Pavilion of Dreams', 'The Pavilion of Dreams', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 399
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Pavilion of Dreams'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23111 AND linked.composer_id = 399), 'musicbrainz:6b16af6f-158e-40b9-9ec6-a08186256931', 1, NULL, 'Bismillahi ’Rrahman ’Rrahim', 'Bismillahi ’Rrahman ’Rrahim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The Pavilion of Dreams' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b16af6f-158e-40b9-9ec6-a08186256931'
);

UPDATE pieces piece
SET piece.title = 'The Pavilion of Dreams 중 "Bismillahi ’Rrahman ’Rrahim"', piece.title_en = 'The Pavilion of Dreams: Bismillahi ’Rrahman ’Rrahim', piece.editor_locked = 1
WHERE piece.id = 23111 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23105 AND linked.composer_id = 399), 'musicbrainz:11acfae1-db1a-4dfe-b6e8-9e6aa13c95be', 2, NULL, 'Butterfly Sunday', 'Butterfly Sunday', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The Pavilion of Dreams' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11acfae1-db1a-4dfe-b6e8-9e6aa13c95be'
);

UPDATE pieces piece
SET piece.title = 'The Pavilion of Dreams 중 "Butterfly Sunday"', piece.title_en = 'The Pavilion of Dreams: Butterfly Sunday', piece.editor_locked = 1
WHERE piece.id = 23105 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25937 AND linked.composer_id = 399), 'musicbrainz:fa5c0c4e-5bbb-4952-92fd-edeb08409f58', 3, NULL, 'Let Us Go Into the House of the Lord', 'Let Us Go Into the House of the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The Pavilion of Dreams' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa5c0c4e-5bbb-4952-92fd-edeb08409f58'
);

UPDATE pieces piece
SET piece.title = 'The Pavilion of Dreams 중 "Let Us Go Into the House of the Lord"', piece.title_en = 'The Pavilion of Dreams: Let Us Go Into the House of the Lord', piece.editor_locked = 1
WHERE piece.id = 25937 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23195 AND linked.composer_id = 399), 'musicbrainz:a41576fb-a583-43f9-bd86-f9505d9abca9', 4, NULL, 'Madrigals of the Rose Angel', 'Madrigals of the Rose Angel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The Pavilion of Dreams' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a41576fb-a583-43f9-bd86-f9505d9abca9'
);

UPDATE pieces piece
SET piece.title = 'The Pavilion of Dreams 중 "Madrigals of the Rose Angel"', piece.title_en = 'The Pavilion of Dreams: Madrigals of the Rose Angel', piece.editor_locked = 1
WHERE piece.id = 23195 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23118 AND linked.composer_id = 399), 'musicbrainz:f5efdf58-4fa7-4fbf-8922-1adf1d5850cd', 5, NULL, 'Juno', 'Juno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The Pavilion of Dreams' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5efdf58-4fa7-4fbf-8922-1adf1d5850cd'
);

UPDATE pieces piece
SET piece.title = 'The Pavilion of Dreams 중 "Juno"', piece.title_en = 'The Pavilion of Dreams: Juno', piece.editor_locked = 1
WHERE piece.id = 23118 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Serpent (In Quicksilver) (음반)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Serpent (In Quicksilver) (음반)', 'The Serpent (In Quicksilver)', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 399
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Serpent (In Quicksilver) (음반)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25054 AND linked.composer_id = 399), 'musicbrainz:a84d6c34-e6b8-4375-a36d-b25eb941ae38', 1, NULL, 'Children on the Hill', 'Children on the Hill', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The Serpent (In Quicksilver) (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a84d6c34-e6b8-4375-a36d-b25eb941ae38'
);

UPDATE pieces piece
SET piece.title = 'The Serpent (In Quicksilver) (음반) 중 "Children on the Hill"', piece.title_en = 'The Serpent (In Quicksilver): Children on the Hill', piece.editor_locked = 1
WHERE piece.id = 25054 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24183 AND linked.composer_id = 399), 'musicbrainz:5c781ef8-d0b6-4fc8-b137-ade56ece12eb', 2, NULL, 'Widows Charm', 'Widows Charm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The Serpent (In Quicksilver) (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c781ef8-d0b6-4fc8-b137-ade56ece12eb'
);

UPDATE pieces piece
SET piece.title = 'The Serpent (In Quicksilver) (음반) 중 "Widows Charm"', piece.title_en = 'The Serpent (In Quicksilver): Widows Charm', piece.editor_locked = 1
WHERE piece.id = 24183 AND piece.composer_id = 399
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eba3abe6-182b-489c-b452-1ecd09750771', 3, NULL, 'The Serpent (In Quicksilver)', 'The Serpent (In Quicksilver)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 399 AND p.title = 'The Serpent (In Quicksilver) (음반)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eba3abe6-182b-489c-b452-1ecd09750771'
);

-- 숨길 seed 작품 없음
