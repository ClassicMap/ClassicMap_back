-- 남은 원어 seed 정리(2/2). 작곡가 7명, seed 80개:
-- 잇기 10, 묶음 안 곡 65(이름 묶음 13·음반 묶음 0), 숨김 0, 그대로 5.
--
-- 4·5·6차 자동 카탈로그가 판단하지 못한 seed(origin=seed, 잠기지 않음, 숨기지 않음)다. 대부분
-- 「Antigonae: I. …」처럼 MusicBrainz 에서 부모 작품 관계가 없는 악장·대목 work 라 목록 맨 위에 낱곡으로
-- 흩어져 보였다. 결정과 근거는 seed_pipeline/curation/leftover-seeds-2026-11-11/decisions.jsonl, 규칙은 tools/leftover.py.
--   잇기: 카탈로그 작품의 part 와 같은 곡(MB 제목이 같거나, 작품번호가 겹치고 악장 번호·이름이 같음)이면
--     그 part 에 잇고 제목을 「<작품> 중 "<곡>"」으로 바꾼다. part 가 이미 다른 작품을 가리키면 숨긴다.
--   이름 묶음: 콜론 앞 이름이 같은 seed 가 둘 이상이면 그 이름으로 작품(manual, 묶음)을 새로 만들고
--     seed 를 그 안 곡으로 잇는다. 제목은 seed 의 우리말 제목 앞부분, 없으면 4차 제목 규칙.
--   음반 묶음: 낱개 seed 는 녹음이 실린 MB 음반이 같은 것끼리 셋 이상이면 음반 이름으로 묶는다
--     (모음집·실황·전집 음반과 작품번호가 있는 seed 는 빼고).
--   숨김: hidden_reason='catalog_unmatched'(지우지 않음). 비교 구간이 있거나 part 가 가리키면 숨기지 않는다.
--   두 번 넣어도 같다.

-- ===== 아서 벤저민 (composer_id 323) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 0

-- None <The Conquest of Everest> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<The Conquest of Everest> 모음곡', 'Suite from "The Conquest of Everest"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 323
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<The Conquest of Everest> 모음곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19329 AND linked.composer_id = 323), 'musicbrainz:cde7fb92-610b-4581-9ecf-ea3faa457909', 1, 'I', '타이틀 음악', 'Title Music -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '<The Conquest of Everest> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cde7fb92-610b-4581-9ecf-ea3faa457909'
);

UPDATE pieces piece
SET piece.title = '<The Conquest of Everest> 모음곡 중 "타이틀 음악"', piece.title_en = 'Suite from "The Conquest of Everest": Title Music -', piece.editor_locked = 1
WHERE piece.id = 19329 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18927 AND linked.composer_id = 323), 'musicbrainz:b3e2a847-0a82-4717-b5c8-73006199977a', 2, 'II', 'Walls that Surpass the Imagination', 'Walls that Surpass the Imagination -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '<The Conquest of Everest> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3e2a847-0a82-4717-b5c8-73006199977a'
);

UPDATE pieces piece
SET piece.title = '<The Conquest of Everest> 모음곡 중 "Walls that Surpass the Imagination"', piece.title_en = 'Suite from "The Conquest of Everest": Walls that Surpass the Imagination -', piece.editor_locked = 1
WHERE piece.id = 18927 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16114 AND linked.composer_id = 323), 'musicbrainz:073c2be7-8005-4751-a586-0dac413094fb', 3, 'III', 'The Great Lift', 'The Great Lift -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '<The Conquest of Everest> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:073c2be7-8005-4751-a586-0dac413094fb'
);

UPDATE pieces piece
SET piece.title = '<The Conquest of Everest> 모음곡 중 "The Great Lift"', piece.title_en = 'Suite from "The Conquest of Everest": The Great Lift -', piece.editor_locked = 1
WHERE piece.id = 16114 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 20013 AND linked.composer_id = 323), 'musicbrainz:fa3f452b-aee7-4fcb-9b2f-236ff6a8f2de', 4, 'IV', 'Top of the World and Final Bars', 'Top of the World and Final Bars', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '<The Conquest of Everest> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa3f452b-aee7-4fcb-9b2f-236ff6a8f2de'
);

UPDATE pieces piece
SET piece.title = '<The Conquest of Everest> 모음곡 중 "Top of the World and Final Bars"', piece.title_en = 'Suite from "The Conquest of Everest": Top of the World and Final Bars', piece.editor_locked = 1
WHERE piece.id = 20013 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None <An Ideal Husband> 왈츠와 하이드 파크 갈롭

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<An Ideal Husband> 왈츠와 하이드 파크 갈롭', 'Waltz and Hyde Park Galop from "An Ideal Husband"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 323
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<An Ideal Husband> 왈츠와 하이드 파크 갈롭'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16588 AND linked.composer_id = 323), 'musicbrainz:2375af78-476d-4480-a0f5-a4f79349f6cc', 1, 'I', '왈츠', 'Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '<An Ideal Husband> 왈츠와 하이드 파크 갈롭' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2375af78-476d-4480-a0f5-a4f79349f6cc'
);

UPDATE pieces piece
SET piece.title = '<An Ideal Husband> 왈츠와 하이드 파크 갈롭 중 "왈츠"', piece.title_en = 'Waltz and Hyde Park Galop from "An Ideal Husband": Waltz', piece.editor_locked = 1
WHERE piece.id = 16588 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17758 AND linked.composer_id = 323), 'musicbrainz:6a170d36-2769-4d45-887f-c65aa0e8b3d9', 2, 'II', '하이드 파크 갈롭', 'Hyde Park Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 323 AND p.title = '<An Ideal Husband> 왈츠와 하이드 파크 갈롭' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a170d36-2769-4d45-887f-c65aa0e8b3d9'
);

UPDATE pieces piece
SET piece.title = '<An Ideal Husband> 왈츠와 하이드 파크 갈롭 중 "하이드 파크 갈롭"', piece.title_en = 'Waltz and Hyde Park Galop from "An Ideal Husband": Hyde Park Galop', piece.editor_locked = 1
WHERE piece.id = 17758 AND piece.composer_id = 323
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'orchestral', piece.form_key = 'orch_suite'
WHERE piece.composer_id = 323 AND piece.title = '<The Conquest of Everest> 모음곡' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'orchestral', piece.form_key = 'dance_march'
WHERE piece.composer_id = 323 AND piece.title = '<An Ideal Husband> 왈츠와 하이드 파크 갈롭' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 레오폴드 고도프스키 (composer_id 331) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 0

-- None 18세기의 에어

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '18세기의 에어', 'Airs of the Eighteenth Century', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 331
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '18세기의 에어'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16011 AND linked.composer_id = 331), 'musicbrainz:01a24869-ce5a-49cc-a66c-a592e25f830a', 1, NULL, 'Exaudet’s Minuet', 'Exaudet’s Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '18세기의 에어' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01a24869-ce5a-49cc-a66c-a592e25f830a'
);

UPDATE pieces piece
SET piece.title = '18세기의 에어 중 "Exaudet’s Minuet"', piece.title_en = 'Airs of the Eighteenth Century: Exaudet’s Minuet', piece.editor_locked = 1
WHERE piece.id = 16011 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17558 AND linked.composer_id = 331), 'musicbrainz:5e6ea795-4fbc-427f-8347-8250a6f00a15', 2, NULL, 'Lisette', 'Lisette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '18세기의 에어' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e6ea795-4fbc-427f-8347-8250a6f00a15'
);

UPDATE pieces piece
SET piece.title = '18세기의 에어 중 "Lisette"', piece.title_en = 'Airs of the Eighteenth Century: Lisette', piece.editor_locked = 1
WHERE piece.id = 17558 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18575 AND linked.composer_id = 331), 'musicbrainz:9d593169-eb90-4e2f-a903-1e5166cdf9cd', 3, NULL, 'Good Old Granny', 'Good Old Granny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '18세기의 에어' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d593169-eb90-4e2f-a903-1e5166cdf9cd'
);

UPDATE pieces piece
SET piece.title = '18세기의 에어 중 "Good Old Granny"', piece.title_en = 'Airs of the Eighteenth Century: Good Old Granny', piece.editor_locked = 1
WHERE piece.id = 18575 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17720 AND linked.composer_id = 331), 'musicbrainz:681c0892-2d37-4a0f-a1b8-14deeb7d16e2', 4, NULL, 'Mother, Please explain', 'Mother, Please explain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '18세기의 에어' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:681c0892-2d37-4a0f-a1b8-14deeb7d16e2'
);

UPDATE pieces piece
SET piece.title = '18세기의 에어 중 "Mother, Please explain"', piece.title_en = 'Airs of the Eighteenth Century: Mother, Please explain', piece.editor_locked = 1
WHERE piece.id = 17720 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 16324 AND linked.composer_id = 331), 'musicbrainz:131ba48c-d358-4a02-92f0-ce637ed7da79', 5, NULL, 'Capricious Shepherd Maid', 'Capricious Shepherd Maid', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '18세기의 에어' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:131ba48c-d358-4a02-92f0-ce637ed7da79'
);

UPDATE pieces piece
SET piece.title = '18세기의 에어 중 "Capricious Shepherd Maid"', piece.title_en = 'Airs of the Eighteenth Century: Capricious Shepherd Maid', piece.editor_locked = 1
WHERE piece.id = 16324 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17068 AND linked.composer_id = 331), 'musicbrainz:40561a2a-febc-4288-afe6-fa78ed91ded1', 6, NULL, 'Would that I were the lowly fern', 'Would that I were the lowly fern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '18세기의 에어' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40561a2a-febc-4288-afe6-fa78ed91ded1'
);

UPDATE pieces piece
SET piece.title = '18세기의 에어 중 "Would that I were the lowly fern"', piece.title_en = 'Airs of the Eighteenth Century: Would that I were the lowly fern', piece.editor_locked = 1
WHERE piece.id = 17068 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17036 AND linked.composer_id = 331), 'musicbrainz:3e32f618-e5b1-4a83-9dff-9fe73b7ca2a1', 7, NULL, 'Oh, come again, beautiful Spring', 'Oh, come again, beautiful Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '18세기의 에어' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e32f618-e5b1-4a83-9dff-9fe73b7ca2a1'
);

UPDATE pieces piece
SET piece.title = '18세기의 에어 중 "Oh, come again, beautiful Spring"', piece.title_en = 'Airs of the Eighteenth Century: Oh, come again, beautiful Spring', piece.editor_locked = 1
WHERE piece.id = 17036 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 양손을 위한 6개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '양손을 위한 6개의 소품', 'Six Pieces for Both Hands', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 331
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '양손을 위한 6개의 소품'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19590 AND linked.composer_id = 331), 'musicbrainz:df91ae7a-44b6-4ff3-a76b-6d344f37d5ae', 1, 'I', 'Meditation', 'Meditation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '양손을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df91ae7a-44b6-4ff3-a76b-6d344f37d5ae'
);

UPDATE pieces piece
SET piece.title = '양손을 위한 6개의 소품 중 "Meditation"', piece.title_en = 'Six Pieces for Both Hands: Meditation', piece.editor_locked = 1
WHERE piece.id = 19590 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17717 AND linked.composer_id = 331), 'musicbrainz:67ee6288-bdc4-4372-bbe2-e52a6a4c6300', 2, 'II', 'Impromptu', 'Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '양손을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67ee6288-bdc4-4372-bbe2-e52a6a4c6300'
);

UPDATE pieces piece
SET piece.title = '양손을 위한 6개의 소품 중 "Impromptu"', piece.title_en = 'Six Pieces for Both Hands: Impromptu', piece.editor_locked = 1
WHERE piece.id = 17717 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18264 AND linked.composer_id = 331), 'musicbrainz:8af0fe1b-9fba-4948-bd25-2a9977d0091d', 3, 'III', 'Capriccio', 'Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '양손을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8af0fe1b-9fba-4948-bd25-2a9977d0091d'
);

UPDATE pieces piece
SET piece.title = '양손을 위한 6개의 소품 중 "Capriccio"', piece.title_en = 'Six Pieces for Both Hands: Capriccio', piece.editor_locked = 1
WHERE piece.id = 18264 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 19516 AND linked.composer_id = 331), 'musicbrainz:da78f4f1-6d6e-42e0-b755-236667f8c1e4', 4, 'IV', 'Intermezzo', 'Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '양손을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da78f4f1-6d6e-42e0-b755-236667f8c1e4'
);

UPDATE pieces piece
SET piece.title = '양손을 위한 6개의 소품 중 "Intermezzo"', piece.title_en = 'Six Pieces for Both Hands: Intermezzo', piece.editor_locked = 1
WHERE piece.id = 19516 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 17392 AND linked.composer_id = 331), 'musicbrainz:543af6e6-afe1-4638-b068-0cccea65ed2a', 5, 'V', 'Elegy', 'Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '양손을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:543af6e6-afe1-4638-b068-0cccea65ed2a'
);

UPDATE pieces piece
SET piece.title = '양손을 위한 6개의 소품 중 "Elegy"', piece.title_en = 'Six Pieces for Both Hands: Elegy', piece.editor_locked = 1
WHERE piece.id = 17392 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 18668 AND linked.composer_id = 331), 'musicbrainz:a412dacd-e1fa-4b3e-b012-9fcc292b676b', 6, 'VI', 'Etude macabre', 'Etude macabre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 331 AND p.title = '양손을 위한 6개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a412dacd-e1fa-4b3e-b012-9fcc292b676b'
);

UPDATE pieces piece
SET piece.title = '양손을 위한 6개의 소품 중 "Etude macabre"', piece.title_en = 'Six Pieces for Both Hands: Etude macabre', piece.editor_locked = 1
WHERE piece.id = 18668 AND piece.composer_id = 331
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'piano', piece.form_key = 'character'
WHERE piece.composer_id = 331 AND piece.title = '양손을 위한 6개의 소품' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== Kalevi Aho (composer_id 359) =====
-- 잇기 0, 새 묶음 2(이름) + 0(음반), 숨김 0, 그대로 1

-- None 더블베이스와 관현악을 위한 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '더블베이스와 관현악을 위한 협주곡', 'Concerto for Double Bass and Orchestra', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '더블베이스와 관현악을 위한 협주곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24412 AND linked.composer_id = 359), 'musicbrainz:71534d67-9217-4296-bd23-d032aa41dcd0', 1, 'I', 'Moderato, Passionato', 'Moderato, Passionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '더블베이스와 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71534d67-9217-4296-bd23-d032aa41dcd0'
);

UPDATE pieces piece
SET piece.title = '더블베이스와 관현악을 위한 협주곡 중 "Moderato, Passionato"', piece.title_en = 'Concerto for Double Bass and Orchestra: Moderato, Passionato', piece.editor_locked = 1
WHERE piece.id = 24412 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25010 AND linked.composer_id = 359), 'musicbrainz:a4226e2b-9b1b-4f48-9162-f0b6d747653f', 2, 'II', 'Cadenza (Pizzicato)', 'Cadenza (Pizzicato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '더블베이스와 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4226e2b-9b1b-4f48-9162-f0b6d747653f'
);

UPDATE pieces piece
SET piece.title = '더블베이스와 관현악을 위한 협주곡 중 "Cadenza (Pizzicato)"', piece.title_en = 'Concerto for Double Bass and Orchestra: Cadenza (Pizzicato)', piece.editor_locked = 1
WHERE piece.id = 25010 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23233 AND linked.composer_id = 359), 'musicbrainz:0423d7f2-8aa1-4e5f-bd83-9268db000e29', 3, 'III', 'Presto - Tranquillo - Presto', 'Presto - Tranquillo - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '더블베이스와 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0423d7f2-8aa1-4e5f-bd83-9268db000e29'
);

UPDATE pieces piece
SET piece.title = '더블베이스와 관현악을 위한 협주곡 중 "Presto - Tranquillo - Presto"', piece.title_en = 'Concerto for Double Bass and Orchestra: Presto - Tranquillo - Presto', piece.editor_locked = 1
WHERE piece.id = 23233 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23572 AND linked.composer_id = 359), 'musicbrainz:215e6c5f-8d5f-4867-b459-dd3a92aacae2', 4, 'IV', 'Misterioso (Cadenza II)', 'Misterioso (Cadenza II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '더블베이스와 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:215e6c5f-8d5f-4867-b459-dd3a92aacae2'
);

UPDATE pieces piece
SET piece.title = '더블베이스와 관현악을 위한 협주곡 중 "Misterioso (Cadenza II)"', piece.title_en = 'Concerto for Double Bass and Orchestra: Misterioso (Cadenza II)', piece.editor_locked = 1
WHERE piece.id = 23572 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25132 AND linked.composer_id = 359), 'musicbrainz:af468e7f-c6fe-4458-a0e2-6a3a0d4c5de1', 5, 'V', 'Andante - Allegro ritmico', 'Andante - Allegro ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '더블베이스와 관현악을 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af468e7f-c6fe-4458-a0e2-6a3a0d4c5de1'
);

UPDATE pieces piece
SET piece.title = '더블베이스와 관현악을 위한 협주곡 중 "Andante - Allegro ritmico"', piece.title_en = 'Concerto for Double Bass and Orchestra: Andante - Allegro ritmico', piece.editor_locked = 1
WHERE piece.id = 25132 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 교향곡 15번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 15번', 'Symphony no. 15', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 359
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 15번'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23918 AND linked.composer_id = 359), 'musicbrainz:433b25dc-08c9-49d2-af03-569bb01b76fa', 1, 'I', 'Nebbia', 'Nebbia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 15번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:433b25dc-08c9-49d2-af03-569bb01b76fa'
);

UPDATE pieces piece
SET piece.title = '교향곡 15번 중 "Nebbia"', piece.title_en = 'Symphony no. 15: Nebbia', piece.editor_locked = 1
WHERE piece.id = 23918 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25701 AND linked.composer_id = 359), 'musicbrainz:e58e47f2-d257-4764-a586-1d66fb24ef75', 2, 'II', 'Musica bizzarra', 'Musica bizzarra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 15번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e58e47f2-d257-4764-a586-1d66fb24ef75'
);

UPDATE pieces piece
SET piece.title = '교향곡 15번 중 "Musica bizzarra"', piece.title_en = 'Symphony no. 15: Musica bizzarra', piece.editor_locked = 1
WHERE piece.id = 25701 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24430 AND linked.composer_id = 359), 'musicbrainz:73370fc6-0f59-4c38-9fa6-cde7da60f636', 3, 'III', 'Interludio', 'Interludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 15번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73370fc6-0f59-4c38-9fa6-cde7da60f636'
);

UPDATE pieces piece
SET piece.title = '교향곡 15번 중 "Interludio"', piece.title_en = 'Symphony no. 15: Interludio', piece.editor_locked = 1
WHERE piece.id = 24430 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24315 AND linked.composer_id = 359), 'musicbrainz:6982489a-9bc6-4ecd-bae6-e164a295f468', 4, 'IV', 'Musica strana', 'Musica strana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 359 AND p.title = '교향곡 15번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6982489a-9bc6-4ecd-bae6-e164a295f468'
);

UPDATE pieces piece
SET piece.title = '교향곡 15번 중 "Musica strana"', piece.title_en = 'Symphony no. 15: Musica strana', piece.editor_locked = 1
WHERE piece.id = 24315 AND piece.composer_id = 359
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'concerto', piece.form_key = 'concertante'
WHERE piece.composer_id = 359 AND piece.title = '더블베이스와 관현악을 위한 협주곡' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'symphony', piece.form_key = 'symphony'
WHERE piece.composer_id = 359 AND piece.title = '교향곡 15번' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== Bernardo Adam Ferrero (composer_id 416) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 0

-- None 모음곡 <Homenaje a Joaquín Soralla>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 <Homenaje a Joaquín Soralla>', 'Homenaje a Joaquín Soralla', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 416
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 <Homenaje a Joaquín Soralla>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24569 AND linked.composer_id = 416), 'musicbrainz:7e815219-28b3-46f0-8471-a63100f1338b', 1, NULL, 'El Grito del Palleter', 'El Grito del Palleter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 416 AND p.title = '모음곡 <Homenaje a Joaquín Soralla>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e815219-28b3-46f0-8471-a63100f1338b'
);

UPDATE pieces piece
SET piece.title = '모음곡 <Homenaje a Joaquín Soralla> 중 "El Grito del Palleter"', piece.title_en = 'Homenaje a Joaquín Soralla: El Grito del Palleter', piece.editor_locked = 1
WHERE piece.id = 24569 AND piece.composer_id = 416
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25820 AND linked.composer_id = 416), 'musicbrainz:f06bc6e8-7516-409f-be38-08d25c61d549', 2, NULL, 'Pescadoras valencianas', 'Pescadoras valencianas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 416 AND p.title = '모음곡 <Homenaje a Joaquín Soralla>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06bc6e8-7516-409f-be38-08d25c61d549'
);

UPDATE pieces piece
SET piece.title = '모음곡 <Homenaje a Joaquín Soralla> 중 "Pescadoras valencianas"', piece.title_en = 'Homenaje a Joaquín Soralla: Pescadoras valencianas', piece.editor_locked = 1
WHERE piece.id = 25820 AND piece.composer_id = 416
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23416 AND linked.composer_id = 416), 'musicbrainz:13a9ac93-29a4-4f77-b53d-7805346e0b8b', 3, NULL, 'Sol de la tarde', 'Sol de la tarde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 416 AND p.title = '모음곡 <Homenaje a Joaquín Soralla>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13a9ac93-29a4-4f77-b53d-7805346e0b8b'
);

UPDATE pieces piece
SET piece.title = '모음곡 <Homenaje a Joaquín Soralla> 중 "Sol de la tarde"', piece.title_en = 'Homenaje a Joaquín Soralla: Sol de la tarde', piece.editor_locked = 1
WHERE piece.id = 23416 AND piece.composer_id = 416
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23414 AND linked.composer_id = 416), 'musicbrainz:1365ee77-3388-4531-a068-aa472f0c81f7', 4, NULL, 'Las Grupas', 'Las Grupas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 416 AND p.title = '모음곡 <Homenaje a Joaquín Soralla>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1365ee77-3388-4531-a068-aa472f0c81f7'
);

UPDATE pieces piece
SET piece.title = '모음곡 <Homenaje a Joaquín Soralla> 중 "Las Grupas"', piece.title_en = 'Homenaje a Joaquín Soralla: Las Grupas', piece.editor_locked = 1
WHERE piece.id = 23414 AND piece.composer_id = 416
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'orchestral', piece.form_key = 'orch_suite'
WHERE piece.composer_id = 416 AND piece.title = '모음곡 <Homenaje a Joaquín Soralla>' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== 프랑수아 쿠프랭 (composer_id 431) =====
-- 잇기 10, 새 묶음 4(이름) + 0(음반), 숨김 0, 그대로 4

-- 카탈로그 part 에 잇기
UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 23646 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 23802 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:7efbfabb-6f41-4813-9e8f-319f64c879b3' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 2번 A장조 중 "La Chemise-blanche"', piece.title_en = 'Deuxième suite: La Chemise-blanche', piece.editor_locked = 1
WHERE piece.id = 23646 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 23802 AND part.part_key = 'musicbrainz:7efbfabb-6f41-4813-9e8f-319f64c879b3'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 24653 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 23802 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:9bf1ddf5-80dd-43ca-95f5-7d761169c71e' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 2번 A장조 중 "Pompe funèbre"', piece.title_en = 'Deuxième suite: Pompe funèbre', piece.editor_locked = 1
WHERE piece.id = 24653 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 23802 AND part.part_key = 'musicbrainz:9bf1ddf5-80dd-43ca-95f5-7d761169c71e'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 24680 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 23802 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:5129dcee-4056-4207-bfad-7ea192dc0bbc' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 2번 A장조 중 "Prélude"', piece.title_en = 'Deuxième suite: Prelude', piece.editor_locked = 1
WHERE piece.id = 24680 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 23802 AND part.part_key = 'musicbrainz:5129dcee-4056-4207-bfad-7ea192dc0bbc'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 23299 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 24592 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:a843d6ad-e2cb-453d-a928-3ff1c862a361' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 1번 E단조 중 "Prélude"', piece.title_en = 'Première suite: Prelude', piece.editor_locked = 1
WHERE piece.id = 23299 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 24592 AND part.part_key = 'musicbrainz:a843d6ad-e2cb-453d-a928-3ff1c862a361'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 23731 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 24592 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:5c2c7ecf-c820-4376-9c45-48058a4cb92b' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 1번 E단조 중 "Courante"', piece.title_en = 'Première suite: Courante', piece.editor_locked = 1
WHERE piece.id = 23731 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 24592 AND part.part_key = 'musicbrainz:5c2c7ecf-c820-4376-9c45-48058a4cb92b'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 24341 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 24592 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:02d257d6-a8e2-4592-bea8-b7e0daaff253' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 1번 E단조 중 "Gavotte"', piece.title_en = 'Première suite: Gavotte', piece.editor_locked = 1
WHERE piece.id = 24341 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 24592 AND part.part_key = 'musicbrainz:02d257d6-a8e2-4592-bea8-b7e0daaff253'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 24805 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 24592 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:191a8727-2896-4104-a468-41bfc88b0a6f' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 1번 E단조 중 "Allemande Légère"', piece.title_en = 'Première suite: Allemande', piece.editor_locked = 1
WHERE piece.id = 24805 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 24592 AND part.part_key = 'musicbrainz:191a8727-2896-4104-a468-41bfc88b0a6f'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 25100 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 24592 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:afab922c-5d48-48eb-b61c-47d2614239e8' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 1번 E단조 중 "Sarabande grave"', piece.title_en = 'Première suite: Sarabande', piece.editor_locked = 1
WHERE piece.id = 25100 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 24592 AND part.part_key = 'musicbrainz:afab922c-5d48-48eb-b61c-47d2614239e8'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 25464 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 24592 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:16e533e4-25f4-460c-92b9-f6c39307f36a' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 1번 E단조 중 "Passacaille ou Chaconne"', piece.title_en = 'Première suite: Passacaille ou chaconne', piece.editor_locked = 1
WHERE piece.id = 25464 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 24592 AND part.part_key = 'musicbrainz:16e533e4-25f4-460c-92b9-f6c39307f36a'
      AND part.linked_piece_id = piece.id
  );

UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = (SELECT seed.id FROM pieces seed WHERE seed.id = 25665 AND seed.composer_id = 431 AND seed.origin = 'seed')
WHERE owner.id = 24592 AND owner.composer_id = 431
  AND part.part_key = 'musicbrainz:56aaffca-c396-4c34-a30a-37d85d470626' AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = '비올 모음곡 1번 E단조 중 "Gigue"', piece.title_en = 'Première suite: Gigue', piece.editor_locked = 1
WHERE piece.id = 25665 AND piece.composer_id = 431 AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = 24592 AND part.part_key = 'musicbrainz:56aaffca-c396-4c34-a30a-37d85d470626'
      AND part.linked_piece_id = piece.id
  );

-- None 콩세르 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콩세르 2번', 'Deuxième concert', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 431
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콩세르 2번'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25626 AND linked.composer_id = 431), 'musicbrainz:defe93bf-f0e3-4e05-ad68-f13830a05482', 1, NULL, 'La Seduisante', 'La Seduisante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '콩세르 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:defe93bf-f0e3-4e05-ad68-f13830a05482'
);

UPDATE pieces piece
SET piece.title = '콩세르 2번 중 "La Seduisante"', piece.title_en = 'Deuxième concert: La Seduisante', piece.editor_locked = 1
WHERE piece.id = 25626 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25115 AND linked.composer_id = 431), 'musicbrainz:ae2d4b23-78be-4059-89c8-80aab67cb67d', 2, NULL, 'Les Vergers fleuris', 'Les Vergers fleuris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '콩세르 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae2d4b23-78be-4059-89c8-80aab67cb67d'
);

UPDATE pieces piece
SET piece.title = '콩세르 2번 중 "Les Vergers fleuris"', piece.title_en = 'Deuxième concert: Les Vergers fleuris', piece.editor_locked = 1
WHERE piece.id = 25115 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23258 AND linked.composer_id = 431), 'musicbrainz:06cf1f59-3536-4811-892b-a088fd7d248f', 3, NULL, 'Plainte pour les violes', 'Plainte pour les violes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '콩세르 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06cf1f59-3536-4811-892b-a088fd7d248f'
);

UPDATE pieces piece
SET piece.title = '콩세르 2번 중 "Plainte pour les violes"', piece.title_en = 'Deuxième concert: Plainte pour les violes', piece.editor_locked = 1
WHERE piece.id = 23258 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25521 AND linked.composer_id = 431), 'musicbrainz:d5f32644-64ca-42e2-89e2-e41549769584', 4, NULL, 'L''Angélique', 'L''Angélique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '콩세르 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5f32644-64ca-42e2-89e2-e41549769584'
);

UPDATE pieces piece
SET piece.title = '콩세르 2번 중 "L''Angélique"', piece.title_en = 'Deuxième concert: L''Angélique', piece.editor_locked = 1
WHERE piece.id = 25521 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 콩세르 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콩세르 1번', 'Première concert', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 431
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콩세르 1번'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24094 AND linked.composer_id = 431), 'musicbrainz:548b4205-4ad6-4d1b-a46c-7d035899ee81', 1, NULL, 'Les Satires, chevre-pieds', 'Les Satires, chevre-pieds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '콩세르 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:548b4205-4ad6-4d1b-a46c-7d035899ee81'
);

UPDATE pieces piece
SET piece.title = '콩세르 1번 중 "Les Satires, chevre-pieds"', piece.title_en = 'Première concert: Les Satires, chevre-pieds', piece.editor_locked = 1
WHERE piece.id = 24094 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24003 AND linked.composer_id = 431), 'musicbrainz:4b6f81f3-fa87-4bcc-9daf-5a3a45f9e678', 2, NULL, 'L''Enchanteresse', 'L''Enchanteresse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '콩세르 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b6f81f3-fa87-4bcc-9daf-5a3a45f9e678'
);

UPDATE pieces piece
SET piece.title = '콩세르 1번 중 "L''Enchanteresse"', piece.title_en = 'Première concert: L''Enchanteresse', piece.editor_locked = 1
WHERE piece.id = 24003 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23526 AND linked.composer_id = 431), 'musicbrainz:1cbd8cf8-527a-4fc9-a565-17e42c9c8ca7', 3, NULL, 'La Flore', 'La Flore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '콩세르 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cbd8cf8-527a-4fc9-a565-17e42c9c8ca7'
);

UPDATE pieces piece
SET piece.title = '콩세르 1번 중 "La Flore"', piece.title_en = 'Première concert: La Flore', piece.editor_locked = 1
WHERE piece.id = 23526 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25704 AND linked.composer_id = 431), 'musicbrainz:e5a29a3b-ba1b-4e08-94db-3b9d174a41c1', 4, NULL, 'Les Silvains', 'Les Silvains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '콩세르 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5a29a3b-ba1b-4e08-94db-3b9d174a41c1'
);

UPDATE pieces piece
SET piece.title = '콩세르 1번 중 "Les Silvains"', piece.title_en = 'Première concert: Les Silvains', piece.editor_locked = 1
WHERE piece.id = 25704 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 모테트의 4개 절

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트의 4개 절', 'Quatre versets du motet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 431
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트의 4개 절'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23797 AND linked.composer_id = 431), 'musicbrainz:3763c8d5-d37c-4def-9d0d-21510457ac52', 1, 'I', 'Tabescere me fecit', 'Tabescere me fecit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 4개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3763c8d5-d37c-4def-9d0d-21510457ac52'
);

UPDATE pieces piece
SET piece.title = '모테트의 4개 절 중 "Tabescere me fecit"', piece.title_en = 'Quatre versets du motet: Tabescere me fecit', piece.editor_locked = 1
WHERE piece.id = 23797 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24272 AND linked.composer_id = 431), 'musicbrainz:652a2ee7-5ee4-4ac5-9d1b-0402edfca132', 2, 'II', 'Ignitum eloquium', 'Ignitum eloquium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 4개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:652a2ee7-5ee4-4ac5-9d1b-0402edfca132'
);

UPDATE pieces piece
SET piece.title = '모테트의 4개 절 중 "Ignitum eloquium"', piece.title_en = 'Quatre versets du motet: Ignitum eloquium', piece.editor_locked = 1
WHERE piece.id = 24272 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24414 AND linked.composer_id = 431), 'musicbrainz:716491e8-4fa7-40c2-a301-35fdc44d8733', 3, 'III', 'Adolescentus sum ego', 'Adolescentus sum ego', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 4개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:716491e8-4fa7-40c2-a301-35fdc44d8733'
);

UPDATE pieces piece
SET piece.title = '모테트의 4개 절 중 "Adolescentus sum ego"', piece.title_en = 'Quatre versets du motet: Adolescentus sum ego', piece.editor_locked = 1
WHERE piece.id = 24414 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25907 AND linked.composer_id = 431), 'musicbrainz:f74c517c-4ea3-4fbf-a8bb-3b98f8ab7401', 4, 'IV', 'Justitia tua', 'Justitia tua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 4개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f74c517c-4ea3-4fbf-a8bb-3b98f8ab7401'
);

UPDATE pieces piece
SET piece.title = '모테트의 4개 절 중 "Justitia tua"', piece.title_en = 'Quatre versets du motet: Justitia tua', piece.editor_locked = 1
WHERE piece.id = 25907 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- None 모테트의 7개 절

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트의 7개 절', 'Sept versets d''un motet', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 431
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트의 7개 절'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23510 AND linked.composer_id = 431), 'musicbrainz:1b67a22d-9c22-4ffb-aed0-2ee37ed84161', 1, NULL, 'Converte nos Deus', 'I. v4 "Converte nos Deus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b67a22d-9c22-4ffb-aed0-2ee37ed84161'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Converte nos Deus"', piece.title_en = 'Sept versets d''un motet: I. v4 "Converte nos Deus"', piece.editor_locked = 1
WHERE piece.id = 23510 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24979 AND linked.composer_id = 431), 'musicbrainz:a19f814c-1c80-4ac1-94ee-1036211e431b', 2, NULL, 'Qui regis Israel', 'I. v1 "Qui regis Israel"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a19f814c-1c80-4ac1-94ee-1036211e431b'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Qui regis Israel"', piece.title_en = 'Sept versets d''un motet: I. v1 "Qui regis Israel"', piece.editor_locked = 1
WHERE piece.id = 24979 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24095 AND linked.composer_id = 431), 'musicbrainz:5492f885-7ca6-4bd6-ab8f-c93857a72ce4', 3, NULL, 'Numquid in aeternum', 'II. v5 "Numquid in aeternum"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5492f885-7ca6-4bd6-ab8f-c93857a72ce4'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Numquid in aeternum"', piece.title_en = 'Sept versets d''un motet: II. v5 "Numquid in aeternum"', piece.editor_locked = 1
WHERE piece.id = 24095 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25660 AND linked.composer_id = 431), 'musicbrainz:e1ed6909-171e-46ec-bd2d-6f4b0a4366fb', 4, NULL, 'Excita potentiam tuam', 'II. v3 "Excita potentiam tuam"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1ed6909-171e-46ec-bd2d-6f4b0a4366fb'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Excita potentiam tuam"', piece.title_en = 'Sept versets d''un motet: II. v3 "Excita potentiam tuam"', piece.editor_locked = 1
WHERE piece.id = 25660 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25694 AND linked.composer_id = 431), 'musicbrainz:e51f74df-7d26-4472-b287-0cd53b145e8d', 5, NULL, 'Ostende nobis Domine', 'III. v7 "Ostende nobis Domine"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e51f74df-7d26-4472-b287-0cd53b145e8d'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Ostende nobis Domine"', piece.title_en = 'Sept versets d''un motet: III. v7 "Ostende nobis Domine"', piece.editor_locked = 1
WHERE piece.id = 25694 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24697 AND linked.composer_id = 431), 'musicbrainz:8a200687-b5f2-48b4-8674-cdafae5d9dc0', 6, NULL, 'Vineam de Aegypto', 'III. v9 "Vineam de Aegypto"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a200687-b5f2-48b4-8674-cdafae5d9dc0'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Vineam de Aegypto"', piece.title_en = 'Sept versets d''un motet: III. v9 "Vineam de Aegypto"', piece.editor_locked = 1
WHERE piece.id = 24697 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23754 AND linked.composer_id = 431), 'musicbrainz:33d715a9-31f6-48c0-af69-e7088228bd31', 7, NULL, 'Audiam quid loquatur', 'IV. v8 "Audiam quid loquatur"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33d715a9-31f6-48c0-af69-e7088228bd31'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Audiam quid loquatur"', piece.title_en = 'Sept versets d''un motet: IV. v8 "Audiam quid loquatur"', piece.editor_locked = 1
WHERE piece.id = 23754 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23207 AND linked.composer_id = 431), 'musicbrainz:01101a3a-07b8-4209-ad6a-646a37085bda', 8, NULL, 'Dux itineris fuisti', 'IV. v10 "Dux itineris fuisti"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01101a3a-07b8-4209-ad6a-646a37085bda'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Dux itineris fuisti"', piece.title_en = 'Sept versets d''un motet: IV. v10 "Dux itineris fuisti"', piece.editor_locked = 1
WHERE piece.id = 23207 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25622 AND linked.composer_id = 431), 'musicbrainz:dec29c19-0022-4814-bdab-3c3fe23c1e0f', 9, NULL, 'Misericordia et veritas', 'V. v11 "Misericordia et veritas"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dec29c19-0022-4814-bdab-3c3fe23c1e0f'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Misericordia et veritas"', piece.title_en = 'Sept versets d''un motet: V. v11 "Misericordia et veritas"', piece.editor_locked = 1
WHERE piece.id = 25622 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23245 AND linked.composer_id = 431), 'musicbrainz:0585f837-c76e-4cf0-aa0a-0fda9d7a7a19', 10, NULL, 'Operuit montes umbra ejus', 'V. v11 "Operuit montes umbra ejus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0585f837-c76e-4cf0-aa0a-0fda9d7a7a19'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Operuit montes umbra ejus"', piece.title_en = 'Sept versets d''un motet: V. v11 "Operuit montes umbra ejus"', piece.editor_locked = 1
WHERE piece.id = 23245 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25690 AND linked.composer_id = 431), 'musicbrainz:e4e6ac4c-edd4-41e0-bfcd-1daefa6c01ad', 11, NULL, 'Veritas de terra', 'VI. v12 "Veritas de terra"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e6ac4c-edd4-41e0-bfcd-1daefa6c01ad'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Veritas de terra"', piece.title_en = 'Sept versets d''un motet: VI. v12 "Veritas de terra"', piece.editor_locked = 1
WHERE piece.id = 25690 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25133 AND linked.composer_id = 431), 'musicbrainz:af550eea-7fd7-4658-863c-146742e9fbb1', 12, NULL, 'Extendit palmitos suos', 'VI. v12 "Extendit palmitos suos"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af550eea-7fd7-4658-863c-146742e9fbb1'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Extendit palmitos suos"', piece.title_en = 'Sept versets d''un motet: VI. v12 "Extendit palmitos suos"', piece.editor_locked = 1
WHERE piece.id = 25133 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25177 AND linked.composer_id = 431), 'musicbrainz:b4a9c7f2-f8e9-42d3-a12f-23d41cbfe029', 13, NULL, 'Etenim Dominus', 'VII. v13 "Etenim Dominus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4a9c7f2-f8e9-42d3-a12f-23d41cbfe029'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Etenim Dominus"', piece.title_en = 'Sept versets d''un motet: VII. v13 "Etenim Dominus"', piece.editor_locked = 1
WHERE piece.id = 25177 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23367 AND linked.composer_id = 431), 'musicbrainz:0fa9a485-e817-4b1f-a20d-1b5509b18099', 14, NULL, 'Deus virtutum convertere', 'VII. v15 "Deus virtutum convertere"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 431 AND p.title = '모테트의 7개 절' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fa9a485-e817-4b1f-a20d-1b5509b18099'
);

UPDATE pieces piece
SET piece.title = '모테트의 7개 절 중 "Deus virtutum convertere"', piece.title_en = 'Sept versets d''un motet: VII. v15 "Deus virtutum convertere"', piece.editor_locked = 1
WHERE piece.id = 23367 AND piece.composer_id = 431
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'sacred'
WHERE piece.composer_id = 431 AND piece.title = '모테트의 4개 절' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'sacred'
WHERE piece.composer_id = 431 AND piece.title = '모테트의 7개 절' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;


-- ===== Nicolas Gombert (composer_id 467) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 0

-- None 3개의 모테트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 모테트', 'Three Motets', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 467
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 모테트'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23255 AND linked.composer_id = 467), 'musicbrainz:0688c4cb-fce3-4777-affb-07fcf7ea5677', 1, NULL, 'Ave Maria', 'Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 467 AND p.title = '3개의 모테트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0688c4cb-fce3-4777-affb-07fcf7ea5677'
);

UPDATE pieces piece
SET piece.title = '3개의 모테트 중 "Ave Maria"', piece.title_en = 'Three Motets: Ave Maria', piece.editor_locked = 1
WHERE piece.id = 23255 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 25923 AND linked.composer_id = 467), 'musicbrainz:f89f75bf-f6c8-4e6e-bc06-81ed93c75895', 2, NULL, 'Ave Sanctissima Maria', 'Ave Sanctissima Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 467 AND p.title = '3개의 모테트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f89f75bf-f6c8-4e6e-bc06-81ed93c75895'
);

UPDATE pieces piece
SET piece.title = '3개의 모테트 중 "Ave Sanctissima Maria"', piece.title_en = 'Three Motets: Ave Sanctissima Maria', piece.editor_locked = 1
WHERE piece.id = 25923 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24166 AND linked.composer_id = 467), 'musicbrainz:5ac95e36-6004-425e-9300-2ad15477db78', 3, NULL, 'Pater Noster', 'Pater Noster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 467 AND p.title = '3개의 모테트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ac95e36-6004-425e-9300-2ad15477db78'
);

UPDATE pieces piece
SET piece.title = '3개의 모테트 중 "Pater Noster"', piece.title_en = 'Three Motets: Pater Noster', piece.editor_locked = 1
WHERE piece.id = 24166 AND piece.composer_id = 467
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- ===== 얀 마클라키에비치 (composer_id 494) =====
-- 잇기 0, 새 묶음 1(이름) + 0(음반), 숨김 0, 그대로 0

-- None 폴란드 미사

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴란드 미사', 'Polish Mass', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 494
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴란드 미사'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23988 AND linked.composer_id = 494), 'musicbrainz:49b3a678-70b3-4224-9ee1-c15aeee28612', 1, NULL, '키리에 (합창)', 'Kyrie (Choir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 494 AND p.title = '폴란드 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49b3a678-70b3-4224-9ee1-c15aeee28612'
);

UPDATE pieces piece
SET piece.title = '폴란드 미사 중 "키리에 (합창)"', piece.title_en = 'Polish Mass: Kyrie (Choir)', piece.editor_locked = 1
WHERE piece.id = 23988 AND piece.composer_id = 494
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24291 AND linked.composer_id = 494), 'musicbrainz:672127d6-3917-4e93-8da7-8361cee20906', 2, NULL, '키리에 (독창)', 'Kyrie (Soloist)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 494 AND p.title = '폴란드 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:672127d6-3917-4e93-8da7-8361cee20906'
);

UPDATE pieces piece
SET piece.title = '폴란드 미사 중 "키리에 (독창)"', piece.title_en = 'Polish Mass: Kyrie (Soloist)', piece.editor_locked = 1
WHERE piece.id = 24291 AND piece.composer_id = 494
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 24139 AND linked.composer_id = 494), 'musicbrainz:588152d3-3057-4f91-9d37-da14fb3f72f9', 3, NULL, '크레도 (3중창)', 'Credo (Trio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 494 AND p.title = '폴란드 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:588152d3-3057-4f91-9d37-da14fb3f72f9'
);

UPDATE pieces piece
SET piece.title = '폴란드 미사 중 "크레도 (3중창)"', piece.title_en = 'Polish Mass: Credo (Trio)', piece.editor_locked = 1
WHERE piece.id = 24139 AND piece.composer_id = 494
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 23616 AND linked.composer_id = 494), 'musicbrainz:25d03810-f48c-4a27-beb5-ff5f16dd9d80', 4, NULL, '키리에 (3중창)', 'Kyrie (Trio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 494 AND p.title = '폴란드 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25d03810-f48c-4a27-beb5-ff5f16dd9d80'
);

UPDATE pieces piece
SET piece.title = '폴란드 미사 중 "키리에 (3중창)"', piece.title_en = 'Polish Mass: Kyrie (Trio)', piece.editor_locked = 1
WHERE piece.id = 23616 AND piece.composer_id = 494
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 새 묶음 갈래·형식(4차 이후 형식 규칙 classify.py)
UPDATE pieces piece
SET piece.genre = 'vocal', piece.form_key = 'mass_requiem'
WHERE piece.composer_id = 494 AND piece.title = '폴란드 미사' AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;

