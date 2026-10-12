-- 케이지 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 209개(묶음 33, 다악장 12, 낱곡 164),
-- 새 작품 14개, part 327개, 그 아래 143개.
-- seed 215개 중 194개를 작품·part 에 잇고, 20개를 숨기고, 1개는 그대로 둔다.
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
SET piece.title = 'Four Dances (중복 1368)'
WHERE piece.id = 1368 AND piece.composer_id = 92 AND piece.title = 'Four Dances'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

UPDATE pieces piece
SET piece.title = 'Sonatas and Interludes for Prepared Piano (중복 2992)'
WHERE piece.id = 2992 AND piece.composer_id = 92 AND piece.title = 'Sonatas and Interludes for Prepared Piano'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None 0′00″

UPDATE pieces piece
SET piece.title = '0′00″', piece.title_en = '0′00″',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1379 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 103

UPDATE pieces piece
SET piece.title = '103', piece.title_en = '103',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1349 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 108

UPDATE pieces piece
SET piece.title = '108', piece.title_en = '108',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 855 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 1O1

UPDATE pieces piece
SET piece.title = '1O1', piece.title_en = '1O1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 466 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 26′1.1499″

UPDATE pieces piece
SET piece.title = '26′1.1499″', piece.title_en = '26′1.1499″',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1886 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 27′10.554″

UPDATE pieces piece
SET piece.title = '27′10.554″', piece.title_en = '27′10.554″',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2560 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 31′57.9864″

UPDATE pieces piece
SET piece.title = '31′57.9864″', piece.title_en = '31′57.9864″',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2950 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 34′46.776″

UPDATE pieces piece
SET piece.title = '34′46.776″', piece.title_en = '34′46.776″',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 882 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 4′33″

UPDATE pieces piece
SET piece.title = '4′33″', piece.title_en = '4′33″',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 767 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = '4′33″: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 767 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:648c944d-a8c2-4c0b-b5a7-00cac614b8e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:648c944d-a8c2-4c0b-b5a7-00cac614b8e2', 1, NULL, 'I', '4′33″: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 767 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:648c944d-a8c2-4c0b-b5a7-00cac614b8e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = '4′33″: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 767 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:00d49e11-b501-4bf4-8743-8a037219c4b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00d49e11-b501-4bf4-8743-8a037219c4b4', 2, NULL, 'II', '4′33″: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 767 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00d49e11-b501-4bf4-8743-8a037219c4b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = '4′33″: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 767 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d3ee1628-1ea9-4faf-8984-23d17cef3824' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3ee1628-1ea9-4faf-8984-23d17cef3824', 3, NULL, 'III', '4′33″: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 767 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3ee1628-1ea9-4faf-8984-23d17cef3824'
);


-- None 5개의 가곡

UPDATE pieces piece
SET piece.title = '5개의 가곡', piece.title_en = '5 Songs for Contralto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2519 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Little Four Paws', part.name_en = '5 Songs for Contralto: No. 1. Little Four Paws',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2519 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:852d2276-8627-4340-a8b9-1f5ead5159d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:852d2276-8627-4340-a8b9-1f5ead5159d8', 1, NULL, 'Little Four Paws', '5 Songs for Contralto: No. 1. Little Four Paws', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2519 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:852d2276-8627-4340-a8b9-1f5ead5159d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Little Christmas Tree', part.name_en = '5 Songs for Contralto: No. 2. Little Christmas Tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2519 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1ac56443-3fb4-4dc5-99b2-a63c50a6aac0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ac56443-3fb4-4dc5-99b2-a63c50a6aac0', 2, NULL, 'Little Christmas Tree', '5 Songs for Contralto: No. 2. Little Christmas Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2519 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ac56443-3fb4-4dc5-99b2-a63c50a6aac0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'In Just-Spring', part.name_en = '5 Songs for Contralto: No. 3. In Just-Spring',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2519 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b6a16f19-ad90-43e4-a67a-156680c4d1f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6a16f19-ad90-43e4-a67a-156680c4d1f9', 3, NULL, 'In Just-Spring', '5 Songs for Contralto: No. 3. In Just-Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2519 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6a16f19-ad90-43e4-a67a-156680c4d1f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Hist Whist', part.name_en = '5 Songs for Contralto: No. 4. Hist Whist',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2519 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f185d416-c729-4597-8e2f-41a65836138e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f185d416-c729-4597-8e2f-41a65836138e', 4, NULL, 'Hist Whist', '5 Songs for Contralto: No. 4. Hist Whist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2519 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f185d416-c729-4597-8e2f-41a65836138e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Another Comes', part.name_en = '5 Songs for Contralto: No. 5. Another Comes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2519 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5fe45c52-143f-47fc-92dc-b18884c21903' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fe45c52-143f-47fc-92dc-b18884c21903', 5, NULL, 'Another Comes', '5 Songs for Contralto: No. 5. Another Comes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2519 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fe45c52-143f-47fc-92dc-b18884c21903'
);


-- None 59 1/2 seconds

UPDATE pieces piece
SET piece.title = '59 1/2 seconds', piece.title_en = '59 1/2 seconds',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2606 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 62 Mesostics Re Merce Cunningham

UPDATE pieces piece
SET piece.title = '62 Mesostics Re Merce Cunningham', piece.title_en = '62 Mesostics Re Merce Cunningham',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2639 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Book of Music

UPDATE pieces piece
SET piece.title = 'A Book of Music', piece.title_en = 'A Book of Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2397 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part 1', part.name_en = 'A Book of Music, Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2397 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:409b2988-4093-46aa-ba58-212efce003a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:409b2988-4093-46aa-ba58-212efce003a4', 1, NULL, 'Part 1', 'A Book of Music, Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2397 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:409b2988-4093-46aa-ba58-212efce003a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part 2', part.name_en = 'A Book of Music, Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2397 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8c5761a7-c466-4004-9344-549f6fb0dd3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c5761a7-c466-4004-9344-549f6fb0dd3c', 2, NULL, 'Part 2', 'A Book of Music, Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2397 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c5761a7-c466-4004-9344-549f6fb0dd3c'
);


-- None A Chant with Claps

UPDATE pieces piece
SET piece.title = 'A Chant with Claps', piece.title_en = 'A Chant with Claps',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2879 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Dip in the Lake

UPDATE pieces piece
SET piece.title = 'A Dip in the Lake', piece.title_en = 'A Dip in the Lake',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1364 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ten Quicksteps', part.name_en = 'A Dip in the Lake: I. Ten Quicksteps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1364 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2339b02f-6d15-41e9-bb71-c85d688d33c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2339b02f-6d15-41e9-bb71-c85d688d33c4', 1, 'I', 'Ten Quicksteps', 'A Dip in the Lake: I. Ten Quicksteps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1364 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2339b02f-6d15-41e9-bb71-c85d688d33c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sixty-One Waltzes', part.name_en = 'A Dip in the Lake: II. Sixty-One Waltzes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1364 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1d0d06d0-a450-493c-b1bf-443317014a01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d0d06d0-a450-493c-b1bf-443317014a01', 2, 'II', 'Sixty-One Waltzes', 'A Dip in the Lake: II. Sixty-One Waltzes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1364 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0d06d0-a450-493c-b1bf-443317014a01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fifty-Six Marches', part.name_en = 'A Dip in the Lake: III. Fifty-Six Marches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1364 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5c1101a1-6833-4a05-8379-0535d9650cad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c1101a1-6833-4a05-8379-0535d9650cad', 3, 'III', 'Fifty-Six Marches', 'A Dip in the Lake: III. Fifty-Six Marches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1364 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c1101a1-6833-4a05-8379-0535d9650cad'
);


-- None 가곡 <A Flower>

UPDATE pieces piece
SET piece.title = '가곡 <A Flower>', piece.title_en = 'A Flower',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2240 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Room

UPDATE pieces piece
SET piece.title = 'A Room', piece.title_en = 'A Room',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2901 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Valentine Out of Season

UPDATE pieces piece
SET piece.title = 'A Valentine Out of Season', piece.title_en = 'A Valentine Out of Season',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2493 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'A Valentine Out of Season: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2493 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:52a2178b-110b-315d-b73a-f2f87198da4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52a2178b-110b-315d-b73a-f2f87198da4b', 1, NULL, 'I', 'A Valentine Out of Season: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2493 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52a2178b-110b-315d-b73a-f2f87198da4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'A Valentine Out of Season: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2493 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3a38c550-61f1-3ed9-8ea2-ebdf7985d428' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a38c550-61f1-3ed9-8ea2-ebdf7985d428', 2, NULL, 'II', 'A Valentine Out of Season: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2493 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a38c550-61f1-3ed9-8ea2-ebdf7985d428'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'A Valentine Out of Season: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2493 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:40450ee5-65ab-3eac-9f91-07df0861933e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40450ee5-65ab-3eac-9f91-07df0861933e', 3, NULL, 'III', 'A Valentine Out of Season: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2493 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40450ee5-65ab-3eac-9f91-07df0861933e'
);


-- None ASLSP

UPDATE pieces piece
SET piece.title = 'ASLSP', piece.title_en = 'ASLSP',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 923 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'ASLSP: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 923 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:fc245c99-42ad-4792-af63-ef21f689e3f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc245c99-42ad-4792-af63-ef21f689e3f7', 1, NULL, 'I', 'ASLSP: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 923 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc245c99-42ad-4792-af63-ef21f689e3f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'ASLSP: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 923 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7e630e85-53ea-4453-b1ae-9779e2dafbeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e630e85-53ea-4453-b1ae-9779e2dafbeb', 2, NULL, 'II', 'ASLSP: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 923 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e630e85-53ea-4453-b1ae-9779e2dafbeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'ASLSP: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 923 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:efc82c78-d7b5-46a3-a02c-5ccb292dd5c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efc82c78-d7b5-46a3-a02c-5ccb292dd5c3', 3, NULL, 'III', 'ASLSP: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 923 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efc82c78-d7b5-46a3-a02c-5ccb292dd5c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'ASLSP: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 923 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:52c0f889-f881-4278-8cac-3be8745b90e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52c0f889-f881-4278-8cac-3be8745b90e1', 4, NULL, 'IV', 'ASLSP: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 923 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c0f889-f881-4278-8cac-3be8745b90e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'ASLSP: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 923 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9efc2cdb-6d30-4b61-a157-f1647f7fbbe2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9efc2cdb-6d30-4b61-a157-f1647f7fbbe2', 5, NULL, 'V', 'ASLSP: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 923 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9efc2cdb-6d30-4b61-a157-f1647f7fbbe2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'ASLSP: VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 923 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:0fd9a887-821c-422e-9c9d-e3e05ca4cedc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fd9a887-821c-422e-9c9d-e3e05ca4cedc', 6, NULL, 'VI', 'ASLSP: VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 923 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fd9a887-821c-422e-9c9d-e3e05ca4cedc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'VII', part.name_en = 'ASLSP: VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 923 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f7c8df8b-7868-4d21-82cf-354687c1a8f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7c8df8b-7868-4d21-82cf-354687c1a8f5', 7, NULL, 'VII', 'ASLSP: VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 923 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7c8df8b-7868-4d21-82cf-354687c1a8f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'VIII', part.name_en = 'ASLSP: VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 923 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:16b31ba8-2214-46b4-9436-32b3731dfb20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16b31ba8-2214-46b4-9436-32b3731dfb20', 8, NULL, 'VIII', 'ASLSP: VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 923 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16b31ba8-2214-46b4-9436-32b3731dfb20'
);


-- None Ad Lib

UPDATE pieces piece
SET piece.title = 'Ad Lib', piece.title_en = 'Ad Lib',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1187 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None All Sides of the Small Stone for Erik Satie and (Secretly Given to Jim Tenney as a Koan)

UPDATE pieces piece
SET piece.title = 'All Sides of the Small Stone for Erik Satie and (Secretly Given to Jim Tenney as a Koan)', piece.title_en = 'All Sides of the Small Stone for Erik Satie and (Secretly Given to Jim Tenney as a Koan)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 878 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amores

UPDATE pieces piece
SET piece.title = 'Amores', piece.title_en = 'Amores',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1064 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Solo for Prepared Piano', part.name_en = 'Amores: I. Solo for Prepared Piano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1064 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:bd938c1f-3523-418a-9564-d57102643097' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd938c1f-3523-418a-9564-d57102643097', 1, 'I', 'Solo for Prepared Piano', 'Amores: I. Solo for Prepared Piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1064 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd938c1f-3523-418a-9564-d57102643097'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Trio for 9 tom-toms and a pod rattle', part.name_en = 'Amores: II. Trio for 9 tom-toms and a pod rattle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1064 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1e25bb19-eaf5-4c65-981b-7ace7c0bbe35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e25bb19-eaf5-4c65-981b-7ace7c0bbe35', 2, 'II', 'Trio for 9 tom-toms and a pod rattle', 'Amores: II. Trio for 9 tom-toms and a pod rattle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1064 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e25bb19-eaf5-4c65-981b-7ace7c0bbe35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Trio for 7 wood blocks', part.name_en = 'Amores: III. Trio for 7 wood blocks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1064 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4e4c2d6f-7f6c-4bf8-84f2-7d73ea4a4a93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e4c2d6f-7f6c-4bf8-84f2-7d73ea4a4a93', 3, 'III', 'Trio for 7 wood blocks', 'Amores: III. Trio for 7 wood blocks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1064 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e4c2d6f-7f6c-4bf8-84f2-7d73ea4a4a93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Solo for Prepared Piano', part.name_en = 'Amores: IV. Solo for Prepared Piano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1064 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:897db345-a04d-4891-b264-eb75b7d04df5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:897db345-a04d-4891-b264-eb75b7d04df5', 4, 'IV', 'Solo for Prepared Piano', 'Amores: IV. Solo for Prepared Piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1064 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:897db345-a04d-4891-b264-eb75b7d04df5'
);


-- None And the Earth Shall Bear Again

UPDATE pieces piece
SET piece.title = 'And the Earth Shall Bear Again', piece.title_en = 'And the Earth Shall Bear Again',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2147 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Apartment House 1776

UPDATE pieces piece
SET piece.title = 'Apartment House 1776', piece.title_en = 'Apartment House 1776',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 912 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aria

UPDATE pieces piece
SET piece.title = 'Aria', piece.title_en = 'Aria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2818 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Atlas Eclipticalis

UPDATE pieces piece
SET piece.title = 'Atlas Eclipticalis', piece.title_en = 'Atlas Eclipticalis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1027 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bacchanale

UPDATE pieces piece
SET piece.title = 'Bacchanale', piece.title_en = 'Bacchanale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2467 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bird Cage

UPDATE pieces piece
SET piece.title = 'Bird Cage', piece.title_en = 'Bird Cage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1272 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Branches

UPDATE pieces piece
SET piece.title = 'Branches', piece.title_en = 'Branches',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2524 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None But what about the noise of crumpling paper which he used to do in order to paint the series of "papiers froisses" or tearing up paper to make "papiers dechires?" Arp was stimulated by water (sea, lake, and flowing waters like rivers), forests

UPDATE pieces piece
SET piece.title = 'But what about the noise of crumpling paper which he used to do in order to paint the series of "papiers froisses" or tearing up paper to make "papiers dechires?" Arp was stimulated by water (sea, lake, and flowing waters like rivers), forests', piece.title_en = 'But what about the noise of crumpling paper which he used to do in order to paint the series of "papiers froisses" or tearing up paper to make "papiers dechires?" Arp was stimulated by water (sea, lake, and flowing waters like rivers), forests',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2054 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cartridge Music

UPDATE pieces piece
SET piece.title = 'Cartridge Music', piece.title_en = 'Cartridge Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1586 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Child of Tree

UPDATE pieces piece
SET piece.title = 'Child of Tree', piece.title_en = 'Child of Tree',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1703 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chorals

UPDATE pieces piece
SET piece.title = 'Chorals', piece.title_en = 'Chorals',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1406 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concert for Piano and Orchestra

UPDATE pieces piece
SET piece.title = 'Concert for Piano and Orchestra', piece.title_en = 'Concert for Piano and Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 575 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto for Prepared Piano and Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Concerto for Prepared Piano and Chamber Orchestra', piece.title_en = 'Concerto for Prepared Piano and Chamber Orchestra',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2763 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Concerto for Prepared Piano and Chamber Orchestra: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2763 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6e00343c-8b1e-4054-af95-97b6d5a8e4ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e00343c-8b1e-4054-af95-97b6d5a8e4ae', 1, NULL, 'I', 'Concerto for Prepared Piano and Chamber Orchestra: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2763 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e00343c-8b1e-4054-af95-97b6d5a8e4ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Concerto for Prepared Piano and Chamber Orchestra: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2763 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:42f10089-2119-40e1-add9-1d4e6f648118' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42f10089-2119-40e1-add9-1d4e6f648118', 2, NULL, 'II', 'Concerto for Prepared Piano and Chamber Orchestra: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2763 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42f10089-2119-40e1-add9-1d4e6f648118'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Concerto for Prepared Piano and Chamber Orchestra: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2763 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f607c2d9-a822-41d9-918d-e7ddcd2cfc7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f607c2d9-a822-41d9-918d-e7ddcd2cfc7b', 3, NULL, 'III', 'Concerto for Prepared Piano and Chamber Orchestra: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2763 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f607c2d9-a822-41d9-918d-e7ddcd2cfc7b'
);


-- None Credo in US

UPDATE pieces piece
SET piece.title = 'Credo in US', piece.title_en = 'Credo in US',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1955 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Crete

UPDATE pieces piece
SET piece.title = 'Crete', piece.title_en = 'Crete',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1961 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dad

UPDATE pieces piece
SET piece.title = 'Dad', piece.title_en = 'Dad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1219 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dance Music for Elfrid Ide

UPDATE pieces piece
SET piece.title = 'Dance Music for Elfrid Ide', piece.title_en = 'Dance Music for Elfrid Ide',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1284 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Dance Music for Elfrid Ide: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1284 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d6f89aac-0c12-4d36-a89b-20b0d0e78c0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6f89aac-0c12-4d36-a89b-20b0d0e78c0b', 1, NULL, 'I', 'Dance Music for Elfrid Ide: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1284 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6f89aac-0c12-4d36-a89b-20b0d0e78c0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Dance Music for Elfrid Ide: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1284 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f6ca3e2b-577a-45cf-8b4f-60546a2681e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6ca3e2b-577a-45cf-8b4f-60546a2681e7', 2, NULL, 'II', 'Dance Music for Elfrid Ide: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1284 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6ca3e2b-577a-45cf-8b4f-60546a2681e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Dance Music for Elfrid Ide: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1284 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ffaa578f-0a92-4c99-9155-2f433dcb36ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffaa578f-0a92-4c99-9155-2f433dcb36ac', 3, NULL, 'III', 'Dance Music for Elfrid Ide: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1284 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffaa578f-0a92-4c99-9155-2f433dcb36ac'
);


-- None Daughters of the Lonesome Isle

UPDATE pieces piece
SET piece.title = 'Daughters of the Lonesome Isle', piece.title_en = 'Daughters of the Lonesome Isle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2309 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Duet for Cymbal

UPDATE pieces piece
SET piece.title = 'Duet for Cymbal', piece.title_en = 'Duet for Cymbal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1661 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eight

UPDATE pieces piece
SET piece.title = 'Eight', piece.title_en = 'Eight',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2022 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Eighty

UPDATE pieces piece
SET piece.title = 'Eighty', piece.title_en = 'Eighty',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1068 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Electronic Music for Piano

UPDATE pieces piece
SET piece.title = 'Electronic Music for Piano', piece.title_en = 'Electronic Music for Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1645 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Etudes Australes

UPDATE pieces piece
SET piece.title = 'Etudes Australes', piece.title_en = 'Etudes Australes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2337 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Book 1', part.name_en = 'Etudes Australes, Book 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8', 1, NULL, 'Book 1', 'Etudes Australes, Book 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Etudes Australes, Book 1: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:09c61b42-3f1d-4b86-9171-d1b16636f491' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09c61b42-3f1d-4b86-9171-d1b16636f491', 1, NULL, 'I', 'Etudes Australes, Book 1: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09c61b42-3f1d-4b86-9171-d1b16636f491'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Etudes Australes, Book 1: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:da5c9cd9-5812-4f09-ad47-2772d18a8174' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da5c9cd9-5812-4f09-ad47-2772d18a8174', 2, NULL, 'II', 'Etudes Australes, Book 1: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da5c9cd9-5812-4f09-ad47-2772d18a8174'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Etudes Australes, Book 1: III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:81d22b0a-d77d-4e18-bcb1-cd0df8750764' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81d22b0a-d77d-4e18-bcb1-cd0df8750764', 3, NULL, 'III', 'Etudes Australes, Book 1: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81d22b0a-d77d-4e18-bcb1-cd0df8750764'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Etudes Australes, Book 1: IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b086a6e0-3622-4b23-9474-651f98dbe579' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b086a6e0-3622-4b23-9474-651f98dbe579', 4, NULL, 'IV', 'Etudes Australes, Book 1: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b086a6e0-3622-4b23-9474-651f98dbe579'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Etudes Australes, Book 1: V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:916d0007-6128-4d92-b3a0-8a16e5b94e83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:916d0007-6128-4d92-b3a0-8a16e5b94e83', 5, NULL, 'V', 'Etudes Australes, Book 1: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:916d0007-6128-4d92-b3a0-8a16e5b94e83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Etudes Australes, Book 1: VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a4bb5b48-a404-4b95-ae1a-bf699ee70179' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4bb5b48-a404-4b95-ae1a-bf699ee70179', 6, NULL, 'VI', 'Etudes Australes, Book 1: VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4bb5b48-a404-4b95-ae1a-bf699ee70179'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'VII', part.name_en = 'Etudes Australes, Book 1: VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5a803362-0893-40ac-b5ad-ef22964d5a90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a803362-0893-40ac-b5ad-ef22964d5a90', 7, NULL, 'VII', 'Etudes Australes, Book 1: VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a803362-0893-40ac-b5ad-ef22964d5a90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'VIII', part.name_en = 'Etudes Australes, Book 1: VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b0ce02b9-d192-4e94-a77c-e462fac4d20a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0ce02b9-d192-4e94-a77c-e462fac4d20a', 8, NULL, 'VIII', 'Etudes Australes, Book 1: VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2040a34-d87a-47af-8a27-92a2fa76afd8'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0ce02b9-d192-4e94-a77c-e462fac4d20a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Book 2', part.name_en = 'Etudes Australes, Book 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa', 2, NULL, 'Book 2', 'Etudes Australes, Book 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'IX', part.name_en = 'Etudes Australes, Book 2: IX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a2f05d40-2601-41a8-8320-e545ee66a5c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2f05d40-2601-41a8-8320-e545ee66a5c4', 1, NULL, 'IX', 'Etudes Australes, Book 2: IX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2f05d40-2601-41a8-8320-e545ee66a5c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'X', part.name_en = 'Etudes Australes, Book 2: X',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6d63b53a-09d9-450e-95e8-b9cd676d22b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d63b53a-09d9-450e-95e8-b9cd676d22b4', 2, NULL, 'X', 'Etudes Australes, Book 2: X', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d63b53a-09d9-450e-95e8-b9cd676d22b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'XI', part.name_en = 'Etudes Australes, Book 2: XI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c07c2039-f49f-403c-9467-8955291dc938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c07c2039-f49f-403c-9467-8955291dc938', 3, NULL, 'XI', 'Etudes Australes, Book 2: XI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c07c2039-f49f-403c-9467-8955291dc938'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'XII', part.name_en = 'Etudes Australes, Book 2: XII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:efecc523-1aab-4c9a-8bad-d75e0bf0d414' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efecc523-1aab-4c9a-8bad-d75e0bf0d414', 4, NULL, 'XII', 'Etudes Australes, Book 2: XII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efecc523-1aab-4c9a-8bad-d75e0bf0d414'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'XIII', part.name_en = 'Etudes Australes, Book 2: XIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4bf150b9-6856-40e3-afd1-568157c29dda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bf150b9-6856-40e3-afd1-568157c29dda', 5, NULL, 'XIII', 'Etudes Australes, Book 2: XIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bf150b9-6856-40e3-afd1-568157c29dda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'XIV', part.name_en = 'Etudes Australes, Book 2: XIV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2a1220a8-886a-4084-bc4a-0d7ba90ddf53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a1220a8-886a-4084-bc4a-0d7ba90ddf53', 6, NULL, 'XIV', 'Etudes Australes, Book 2: XIV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a1220a8-886a-4084-bc4a-0d7ba90ddf53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'XV', part.name_en = 'Etudes Australes, Book 2: XV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a9cd309e-c34f-45bb-b050-6e84e1ecfefa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9cd309e-c34f-45bb-b050-6e84e1ecfefa', 7, NULL, 'XV', 'Etudes Australes, Book 2: XV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9cd309e-c34f-45bb-b050-6e84e1ecfefa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'XVI', part.name_en = 'Etudes Australes, Book 2: XVI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8f3ede3d-45eb-481f-9168-72d5d0506e31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f3ede3d-45eb-481f-9168-72d5d0506e31', 8, NULL, 'XVI', 'Etudes Australes, Book 2: XVI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:96451477-19a9-41ed-942b-e5b2b683dafa'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f3ede3d-45eb-481f-9168-72d5d0506e31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Book 3', part.name_en = 'Etudes Australes, Book 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32', 3, NULL, 'Book 3', 'Etudes Australes, Book 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'XVII', part.name_en = 'Etudes Australes, Book 3: XVII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8301b439-e3df-4e67-9f9c-a383296da931' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8301b439-e3df-4e67-9f9c-a383296da931', 1, NULL, 'XVII', 'Etudes Australes, Book 3: XVII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8301b439-e3df-4e67-9f9c-a383296da931'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'XVIII', part.name_en = 'Etudes Australes, Book 3: XVIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:62b44ccf-2fde-4f2b-bdde-effa44d57575' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62b44ccf-2fde-4f2b-bdde-effa44d57575', 2, NULL, 'XVIII', 'Etudes Australes, Book 3: XVIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62b44ccf-2fde-4f2b-bdde-effa44d57575'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'XIX', part.name_en = 'Etudes Australes, Book 3: XIX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:24586d22-bffc-4ca7-871b-e9039ca2bc85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24586d22-bffc-4ca7-871b-e9039ca2bc85', 3, NULL, 'XIX', 'Etudes Australes, Book 3: XIX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24586d22-bffc-4ca7-871b-e9039ca2bc85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'XX', part.name_en = 'Etudes Australes, Book 3: XX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:917490ed-3819-42c4-8b24-6250372839ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:917490ed-3819-42c4-8b24-6250372839ce', 4, NULL, 'XX', 'Etudes Australes, Book 3: XX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:917490ed-3819-42c4-8b24-6250372839ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'XXI', part.name_en = 'Etudes Australes, Book 3: XXI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6b0bdd4a-edf4-4145-818d-5945274f39d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b0bdd4a-edf4-4145-818d-5945274f39d9', 5, NULL, 'XXI', 'Etudes Australes, Book 3: XXI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b0bdd4a-edf4-4145-818d-5945274f39d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'XXII', part.name_en = 'Etudes Australes, Book 3: XXII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:62c4df80-32bd-44c3-a3d1-aa6a92b18555' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62c4df80-32bd-44c3-a3d1-aa6a92b18555', 6, NULL, 'XXII', 'Etudes Australes, Book 3: XXII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62c4df80-32bd-44c3-a3d1-aa6a92b18555'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'XXIII', part.name_en = 'Etudes Australes, Book 3: XXIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e021a977-6eec-4af2-9ece-f7f72d824540' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e021a977-6eec-4af2-9ece-f7f72d824540', 7, NULL, 'XXIII', 'Etudes Australes, Book 3: XXIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e021a977-6eec-4af2-9ece-f7f72d824540'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'XXIV', part.name_en = 'Etudes Australes, Book 3: XXIV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2c1211c0-abb4-46cd-ad46-d15de1cf2b30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c1211c0-abb4-46cd-ad46-d15de1cf2b30', 8, NULL, 'XXIV', 'Etudes Australes, Book 3: XXIV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c0c321b4-b8e3-493d-a84a-672b38795d32'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c1211c0-abb4-46cd-ad46-d15de1cf2b30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Book 4', part.name_en = 'Etudes Australes, Book 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f', 4, NULL, 'Book 4', 'Etudes Australes, Book 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'XXV', part.name_en = 'Etudes Australes, Book 4: XXV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:90a834f1-9ad5-4737-b648-8701891a867f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:90a834f1-9ad5-4737-b648-8701891a867f', 1, NULL, 'XXV', 'Etudes Australes, Book 4: XXV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90a834f1-9ad5-4737-b648-8701891a867f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'XXVI', part.name_en = 'Etudes Australes, Book 4: XXVI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f6279989-5622-438d-ab44-a3b8cdc60114' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f6279989-5622-438d-ab44-a3b8cdc60114', 2, NULL, 'XXVI', 'Etudes Australes, Book 4: XXVI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6279989-5622-438d-ab44-a3b8cdc60114'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'XXVII', part.name_en = 'Etudes Australes, Book 4: XXVII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f793c560-5535-440b-a2bf-99135c9907f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f793c560-5535-440b-a2bf-99135c9907f4', 3, NULL, 'XXVII', 'Etudes Australes, Book 4: XXVII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f793c560-5535-440b-a2bf-99135c9907f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'XXVIII', part.name_en = 'Etudes Australes, Book 4: XXVIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ac1154a2-1de4-40f0-9763-2321fe9464a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac1154a2-1de4-40f0-9763-2321fe9464a6', 4, NULL, 'XXVIII', 'Etudes Australes, Book 4: XXVIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac1154a2-1de4-40f0-9763-2321fe9464a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'XXIX', part.name_en = 'Etudes Australes, Book 4: XXIX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:26948b21-4c9b-447f-834d-9d6f72365b13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:26948b21-4c9b-447f-834d-9d6f72365b13', 5, NULL, 'XXIX', 'Etudes Australes, Book 4: XXIX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26948b21-4c9b-447f-834d-9d6f72365b13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'XXX', part.name_en = 'Etudes Australes, Book 4: XXX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:0c73568c-06ac-4d59-a7c5-e4560d2a3fea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c73568c-06ac-4d59-a7c5-e4560d2a3fea', 6, NULL, 'XXX', 'Etudes Australes, Book 4: XXX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c73568c-06ac-4d59-a7c5-e4560d2a3fea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'XXXI', part.name_en = 'Etudes Australes, Book 4: XXXI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:73fb0a51-20d7-44dd-915a-01b22a00fc80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73fb0a51-20d7-44dd-915a-01b22a00fc80', 7, NULL, 'XXXI', 'Etudes Australes, Book 4: XXXI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73fb0a51-20d7-44dd-915a-01b22a00fc80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'XXXII', part.name_en = 'Etudes Australes, Book 4: XXXII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2337 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c1a68d7f-b679-4f95-92fb-481ff75bbb1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1a68d7f-b679-4f95-92fb-481ff75bbb1c', 8, NULL, 'XXXII', 'Etudes Australes, Book 4: XXXII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8acfc512-a2fb-4dce-b252-7614a41d6d7f'
WHERE p.id = 2337 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1a68d7f-b679-4f95-92fb-481ff75bbb1c'
);


-- None Europera 3

UPDATE pieces piece
SET piece.title = 'Europera 3', piece.title_en = 'Europera 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2344 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Europera 4

UPDATE pieces piece
SET piece.title = 'Europera 4', piece.title_en = 'Europera 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2589 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Europera 5>

UPDATE pieces piece
SET piece.title = '오페라 <Europera 5>', piece.title_en = 'Europera 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1458 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Experiences

UPDATE pieces piece
SET piece.title = 'Experiences', piece.title_en = 'Experiences',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2647 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Experiences no. 2

UPDATE pieces piece
SET piece.title = 'Experiences no. 2', piece.title_en = 'Experiences no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2000 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fads and Fancies in the Academy

UPDATE pieces piece
SET piece.title = 'Fads and Fancies in the Academy', piece.title_en = 'Fads and Fancies in the Academy',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1589 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Axioms: A. The Pupil Is Eager to Learn', part.name_en = 'Fads and Fancies in the Academy: I. Axioms: A. The Pupil Is Eager to Learn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1589 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2ac8e4c4-1a56-4ffd-9f5d-ec4ea6b8447b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ac8e4c4-1a56-4ffd-9f5d-ec4ea6b8447b', 1, 'I', 'Axioms: A. The Pupil Is Eager to Learn', 'Fads and Fancies in the Academy: I. Axioms: A. The Pupil Is Eager to Learn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1589 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac8e4c4-1a56-4ffd-9f5d-ec4ea6b8447b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = 'Axioms: B. The Pupil Is Constitutionally Lazy', part.name_en = 'Fads and Fancies in the Academy: I. Axioms: B. The Pupil Is Constitutionally Lazy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1589 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d1717f9c-c473-463f-ad7c-c367de96c27a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1717f9c-c473-463f-ad7c-c367de96c27a', 2, 'I', 'Axioms: B. The Pupil Is Constitutionally Lazy', 'Fads and Fancies in the Academy: I. Axioms: B. The Pupil Is Constitutionally Lazy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1589 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1717f9c-c473-463f-ad7c-c367de96c27a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Axioms: C. We Deal With the Total Child', part.name_en = 'Fads and Fancies in the Academy: I. Axioms: C. We Deal With the Total Child',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1589 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:03ec031f-0fd6-45b4-82df-fff51d7c0573' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03ec031f-0fd6-45b4-82df-fff51d7c0573', 3, 'I', 'Axioms: C. We Deal With the Total Child', 'Fads and Fancies in the Academy: I. Axioms: C. We Deal With the Total Child', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1589 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03ec031f-0fd6-45b4-82df-fff51d7c0573'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'A Short Historical Sketch: A. Reactionaries', part.name_en = 'Fads and Fancies in the Academy: II. A Short Historical Sketch: A. Reactionaries',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1589 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e1ce5784-79c3-40ec-a814-4e09a23978da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1ce5784-79c3-40ec-a814-4e09a23978da', 4, 'II', 'A Short Historical Sketch: A. Reactionaries', 'Fads and Fancies in the Academy: II. A Short Historical Sketch: A. Reactionaries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1589 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1ce5784-79c3-40ec-a814-4e09a23978da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'II',
    part.name_ko = 'A Short Historical Sketch: B. Revolutionaries - Pitched Battle', part.name_en = 'Fads and Fancies in the Academy: II. A Short Historical Sketch: B. Revolutionaries - Pitched Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1589 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3e3441ac-5b4c-4c71-9366-10a1fb7c7817' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e3441ac-5b4c-4c71-9366-10a1fb7c7817', 5, 'II', 'A Short Historical Sketch: B. Revolutionaries - Pitched Battle', 'Fads and Fancies in the Academy: II. A Short Historical Sketch: B. Revolutionaries - Pitched Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1589 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e3441ac-5b4c-4c71-9366-10a1fb7c7817'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'III',
    part.name_ko = 'Vistas of the Future: A. Pessimist', part.name_en = 'Fads and Fancies in the Academy: III. Vistas of the Future: A. Pessimist',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1589 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d0722b86-c6c7-426c-8c73-163bc737b8fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0722b86-c6c7-426c-8c73-163bc737b8fc', 6, 'III', 'Vistas of the Future: A. Pessimist', 'Fads and Fancies in the Academy: III. Vistas of the Future: A. Pessimist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1589 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0722b86-c6c7-426c-8c73-163bc737b8fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'III',
    part.name_ko = 'Vistas of the Future: B. Optimist', part.name_en = 'Fads and Fancies in the Academy: III. Vistas of the Future: B. Optimist',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1589 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5f3371a2-545e-4e35-890d-f73dc9c92aa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f3371a2-545e-4e35-890d-f73dc9c92aa2', 7, 'III', 'Vistas of the Future: B. Optimist', 'Fads and Fancies in the Academy: III. Vistas of the Future: B. Optimist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1589 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f3371a2-545e-4e35-890d-f73dc9c92aa2'
);


-- None Fifty-Eight

UPDATE pieces piece
SET piece.title = 'Fifty-Eight', piece.title_en = 'Fifty-Eight',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2278 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None First Construction (In Metal)

UPDATE pieces piece
SET piece.title = 'First Construction (In Metal)', piece.title_en = 'First Construction (In Metal)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2635 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five

UPDATE pieces piece
SET piece.title = 'Five', piece.title_en = 'Five',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2319 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five²

UPDATE pieces piece
SET piece.title = 'Five²', piece.title_en = 'Five²',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1936 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five³

UPDATE pieces piece
SET piece.title = 'Five³', piece.title_en = 'Five³',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1865 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five⁴

UPDATE pieces piece
SET piece.title = 'Five⁴', piece.title_en = 'Five⁴',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1877 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Five⁵

UPDATE pieces piece
SET piece.title = 'Five⁵', piece.title_en = 'Five⁵',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2138 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fontana Mix

UPDATE pieces piece
SET piece.title = 'Fontana Mix', piece.title_en = 'Fontana Mix',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2049 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For M.C. and D.T.

UPDATE pieces piece
SET piece.title = 'For M.C. and D.T.', piece.title_en = 'For M.C. and D.T.',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1363 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None For Paul Taylor and Anita Dencks

UPDATE pieces piece
SET piece.title = 'For Paul Taylor and Anita Dencks', piece.title_en = 'For Paul Taylor and Anita Dencks',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2869 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Forever and Sunsmell

UPDATE pieces piece
SET piece.title = 'Forever and Sunsmell', piece.title_en = 'Forever and Sunsmell',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2478 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four

UPDATE pieces piece
SET piece.title = 'Four', piece.title_en = 'Four',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1042 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four Dances

UPDATE pieces piece
SET piece.title = 'Four Dances', piece.title_en = 'Four Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 513 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dance I', part.name_en = 'Four Dances: Dance I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 513 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:13ecdced-6a90-43ff-b9f9-b85f61673085' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ecdced-6a90-43ff-b9f9-b85f61673085', 1, NULL, 'Dance I', 'Four Dances: Dance I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 513 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ecdced-6a90-43ff-b9f9-b85f61673085'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dance II', part.name_en = 'Four Dances: Dance II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 513 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:731e7811-263e-4c76-8c2a-ad8eb752bd76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:731e7811-263e-4c76-8c2a-ad8eb752bd76', 2, NULL, 'Dance II', 'Four Dances: Dance II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 513 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:731e7811-263e-4c76-8c2a-ad8eb752bd76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dance III', part.name_en = 'Four Dances: Dance III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 513 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3f6abbd6-08d7-41fb-af53-3d18e37d63df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f6abbd6-08d7-41fb-af53-3d18e37d63df', 3, NULL, 'Dance III', 'Four Dances: Dance III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 513 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f6abbd6-08d7-41fb-af53-3d18e37d63df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dance IV', part.name_en = 'Four Dances: Dance IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 513 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d37e93c0-b3e3-421a-8da6-444b4275339f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d37e93c0-b3e3-421a-8da6-444b4275339f', 4, NULL, 'Dance IV', 'Four Dances: Dance IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 513 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d37e93c0-b3e3-421a-8da6-444b4275339f'
);


-- None 발레 <Four Walls>

UPDATE pieces piece
SET piece.title = '발레 <Four Walls>', piece.title_en = 'Four Walls',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1452 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Four Walls: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a', 1, NULL, 'Act I', 'Four Walls: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I', part.name_en = 'Four Walls: Act I: Scene I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:24583f7c-4b99-4f34-b12a-00d7268cfc11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24583f7c-4b99-4f34-b12a-00d7268cfc11', 1, NULL, 'Scene I', 'Four Walls: Act I: Scene I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24583f7c-4b99-4f34-b12a-00d7268cfc11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II', part.name_en = 'Four Walls: Act I: Scene II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9121d4db-55c9-423e-b73d-7dfba25acea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9121d4db-55c9-423e-b73d-7dfba25acea7', 2, NULL, 'Scene II', 'Four Walls: Act I: Scene II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9121d4db-55c9-423e-b73d-7dfba25acea7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene III', part.name_en = 'Four Walls: Act I: Scene III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:0a23d75a-d025-4e2c-8a74-c8abdb61a1f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a23d75a-d025-4e2c-8a74-c8abdb61a1f1', 3, NULL, 'Scene III', 'Four Walls: Act I: Scene III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a23d75a-d025-4e2c-8a74-c8abdb61a1f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene IV', part.name_en = 'Four Walls: Act I: Scene IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9affdde0-a01d-49b4-9b74-46ddbe08f1d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9affdde0-a01d-49b4-9b74-46ddbe08f1d3', 4, NULL, 'Scene IV', 'Four Walls: Act I: Scene IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9affdde0-a01d-49b4-9b74-46ddbe08f1d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene V', part.name_en = 'Four Walls: Act I: Scene V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:107a9850-366d-42d9-9a18-2f80b242172f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:107a9850-366d-42d9-9a18-2f80b242172f', 5, NULL, 'Scene V', 'Four Walls: Act I: Scene V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:107a9850-366d-42d9-9a18-2f80b242172f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene VI', part.name_en = 'Four Walls: Act I: Scene VI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6e8243f7-ee9f-4c44-880e-47e95e1d5d26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e8243f7-ee9f-4c44-880e-47e95e1d5d26', 6, NULL, 'Scene VI', 'Four Walls: Act I: Scene VI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e8243f7-ee9f-4c44-880e-47e95e1d5d26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene VII', part.name_en = 'Four Walls: Act I: Scene VII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1c038ba8-9ce5-44b0-af15-7d5cc79814f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c038ba8-9ce5-44b0-af15-7d5cc79814f7', 7, NULL, 'Scene VII', 'Four Walls: Act I: Scene VII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c038ba8-9ce5-44b0-af15-7d5cc79814f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene VIII', part.name_en = 'Four Walls: Act I: Scene VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:eef13432-00de-4b90-b1c6-3fdb4e30cb03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eef13432-00de-4b90-b1c6-3fdb4e30cb03', 8, NULL, 'Scene VIII', 'Four Walls: Act I: Scene VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0232d61-df69-433d-914a-837c3788439a'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eef13432-00de-4b90-b1c6-3fdb4e30cb03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Four Walls: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0', 2, NULL, 'Act II', 'Four Walls: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene IX', part.name_en = 'Four Walls: Act II: Scene IX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:08008a5d-6d4c-42f8-9a61-95d736fb6b60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08008a5d-6d4c-42f8-9a61-95d736fb6b60', 1, NULL, 'Scene IX', 'Four Walls: Act II: Scene IX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08008a5d-6d4c-42f8-9a61-95d736fb6b60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene X', part.name_en = 'Four Walls: Act II: Scene X',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:49b6ade4-35c1-4bc7-9b70-f95fb548cae3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49b6ade4-35c1-4bc7-9b70-f95fb548cae3', 2, NULL, 'Scene X', 'Four Walls: Act II: Scene X', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49b6ade4-35c1-4bc7-9b70-f95fb548cae3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene XI', part.name_en = 'Four Walls: Act II: Scene XI',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:daf4ebbc-d0db-4156-b756-8905a4903956' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:daf4ebbc-d0db-4156-b756-8905a4903956', 3, NULL, 'Scene XI', 'Four Walls: Act II: Scene XI', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daf4ebbc-d0db-4156-b756-8905a4903956'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene XII', part.name_en = 'Four Walls: Act II: Scene XII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:623fd0e4-1078-40ca-b2d1-2b4eb307b0b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:623fd0e4-1078-40ca-b2d1-2b4eb307b0b4', 4, NULL, 'Scene XII', 'Four Walls: Act II: Scene XII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:623fd0e4-1078-40ca-b2d1-2b4eb307b0b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene XIII', part.name_en = 'Four Walls: Act II: Scene XIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8028c461-ef4c-4842-976b-804ebd9a9afc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8028c461-ef4c-4842-976b-804ebd9a9afc', 5, NULL, 'Scene XIII', 'Four Walls: Act II: Scene XIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f202328b-e99c-42a7-8bc5-8623623190b0'
WHERE p.id = 1452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8028c461-ef4c-4842-976b-804ebd9a9afc'
);


-- None Fourteen

UPDATE pieces piece
SET piece.title = 'Fourteen', piece.title_en = 'Fourteen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 964 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four²

UPDATE pieces piece
SET piece.title = 'Four²', piece.title_en = 'Four²',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2629 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four³

UPDATE pieces piece
SET piece.title = 'Four³', piece.title_en = 'Four³',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 993 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four⁴

UPDATE pieces piece
SET piece.title = 'Four⁴', piece.title_en = 'Four⁴',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2856 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four⁵

UPDATE pieces piece
SET piece.title = 'Four⁵', piece.title_en = 'Four⁵',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1097 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four⁶

UPDATE pieces piece
SET piece.title = 'Four⁶', piece.title_en = 'Four⁶',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1041 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Haikai for Flute and Zoomoozophone

UPDATE pieces piece
SET piece.title = 'Haikai for Flute and Zoomoozophone', piece.title_en = 'Haikai for Flute and Zoomoozophone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 853 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Haikus

UPDATE pieces piece
SET piece.title = 'Haikus', piece.title_en = 'Haikus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2289 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'For My Dear Friend, Who', part.name_en = 'Haikus: I. For My Dear Friend, Who',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2289 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8fa05d55-13bc-46de-8dda-806fcc009ad8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fa05d55-13bc-46de-8dda-806fcc009ad8', 1, NULL, 'For My Dear Friend, Who', 'Haikus: I. For My Dear Friend, Who', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2289 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fa05d55-13bc-46de-8dda-806fcc009ad8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'What Stillness', part.name_en = 'Haikus: II. What Stillness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2289 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b75d8c42-9edb-472c-9d0c-1dc6c07bac8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b75d8c42-9edb-472c-9d0c-1dc6c07bac8e', 2, NULL, 'What Stillness', 'Haikus: II. What Stillness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2289 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b75d8c42-9edb-472c-9d0c-1dc6c07bac8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Green Frog''s Voice', part.name_en = 'Haikus: III. The Green Frog''s Voice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2289 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:dcb96802-a0a9-4a1c-b7f3-99200d52bb61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb96802-a0a9-4a1c-b7f3-99200d52bb61', 3, NULL, 'The Green Frog''s Voice', 'Haikus: III. The Green Frog''s Voice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2289 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb96802-a0a9-4a1c-b7f3-99200d52bb61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The River Phurabelle', part.name_en = 'Haikus: IV. The River Phurabelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2289 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e7649f63-aac3-4652-b84c-595728ddbc3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7649f63-aac3-4652-b84c-595728ddbc3a', 4, NULL, 'The River Phurabelle', 'Haikus: IV. The River Phurabelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2289 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7649f63-aac3-4652-b84c-595728ddbc3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Haikus: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2289 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7afe7ea7-8212-4262-8c32-3be42545d7b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7afe7ea7-8212-4262-8c32-3be42545d7b0', 5, NULL, 'V', 'Haikus: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2289 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7afe7ea7-8212-4262-8c32-3be42545d7b0'
);


-- None Hymnkus

UPDATE pieces piece
SET piece.title = 'Hymnkus', piece.title_en = 'Hymnkus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1207 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hymns and Variations

UPDATE pieces piece
SET piece.title = 'Hymns and Variations', piece.title_en = 'Hymns and Variations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1684 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hymn A', part.name_en = 'Hymns and Variations: Hymn A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1043462e-4444-4653-b0ea-fd70a9b683d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1043462e-4444-4653-b0ea-fd70a9b683d9', 1, NULL, 'Hymn A', 'Hymns and Variations: Hymn A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1043462e-4444-4653-b0ea-fd70a9b683d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hymn B', part.name_en = 'Hymns and Variations: Hymn B',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f699d79e-64bf-428c-9571-9571aaf35e9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f699d79e-64bf-428c-9571-9571aaf35e9c', 2, NULL, 'Hymn B', 'Hymns and Variations: Hymn B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f699d79e-64bf-428c-9571-9571aaf35e9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation 1', part.name_en = 'Hymns and Variations: Variation 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:11c0c8a6-c641-465a-b53c-fcf5d870e1a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11c0c8a6-c641-465a-b53c-fcf5d870e1a2', 3, NULL, 'Variation 1', 'Hymns and Variations: Variation 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11c0c8a6-c641-465a-b53c-fcf5d870e1a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation 2', part.name_en = 'Hymns and Variations: Variation 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:92c3ddad-8f00-49ca-b252-52adc5e7b64f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92c3ddad-8f00-49ca-b252-52adc5e7b64f', 4, NULL, 'Variation 2', 'Hymns and Variations: Variation 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92c3ddad-8f00-49ca-b252-52adc5e7b64f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation 3', part.name_en = 'Hymns and Variations: Variation 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:53fc8349-e89c-4d27-8f72-88b99d629efe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53fc8349-e89c-4d27-8f72-88b99d629efe', 5, NULL, 'Variation 3', 'Hymns and Variations: Variation 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53fc8349-e89c-4d27-8f72-88b99d629efe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation 4', part.name_en = 'Hymns and Variations: Variation 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a4b5b367-a378-409c-ba5f-c4b02b1547be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4b5b367-a378-409c-ba5f-c4b02b1547be', 6, NULL, 'Variation 4', 'Hymns and Variations: Variation 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4b5b367-a378-409c-ba5f-c4b02b1547be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation 5', part.name_en = 'Hymns and Variations: Variation 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:495033aa-d5ae-4738-9e89-a1d74041b1fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:495033aa-d5ae-4738-9e89-a1d74041b1fc', 7, NULL, 'Variation 5', 'Hymns and Variations: Variation 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:495033aa-d5ae-4738-9e89-a1d74041b1fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation 6', part.name_en = 'Hymns and Variations: Variation 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2c2e37e8-ac44-4169-b433-f31fbb123860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c2e37e8-ac44-4169-b433-f31fbb123860', 8, NULL, 'Variation 6', 'Hymns and Variations: Variation 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c2e37e8-ac44-4169-b433-f31fbb123860'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variation 7', part.name_en = 'Hymns and Variations: Variation 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8e667539-261f-45b8-ae7e-69565945e4fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e667539-261f-45b8-ae7e-69565945e4fa', 9, NULL, 'Variation 7', 'Hymns and Variations: Variation 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e667539-261f-45b8-ae7e-69565945e4fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Variation 8', part.name_en = 'Hymns and Variations: Variation 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:047bac12-ecef-43b8-a72f-27b8b3316606' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:047bac12-ecef-43b8-a72f-27b8b3316606', 10, NULL, 'Variation 8', 'Hymns and Variations: Variation 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:047bac12-ecef-43b8-a72f-27b8b3316606'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Variation 9', part.name_en = 'Hymns and Variations: Variation 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5e44dddd-393c-4fa8-ae41-32383b263b8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e44dddd-393c-4fa8-ae41-32383b263b8f', 11, NULL, 'Variation 9', 'Hymns and Variations: Variation 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e44dddd-393c-4fa8-ae41-32383b263b8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Variation 10', part.name_en = 'Hymns and Variations: Variation 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1684 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d66a337e-3170-41b4-af59-0fc9f5cd6aa5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d66a337e-3170-41b4-af59-0fc9f5cd6aa5', 12, NULL, 'Variation 10', 'Hymns and Variations: Variation 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1684 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d66a337e-3170-41b4-af59-0fc9f5cd6aa5'
);


-- None Imaginary Landscape no. 1

UPDATE pieces piece
SET piece.title = 'Imaginary Landscape no. 1', piece.title_en = 'Imaginary Landscape no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1992 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Imaginary Landscape no. 2

UPDATE pieces piece
SET piece.title = 'Imaginary Landscape no. 2', piece.title_en = 'Imaginary Landscape no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1985 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Imaginary Landscape no. 3

UPDATE pieces piece
SET piece.title = 'Imaginary Landscape no. 3', piece.title_en = 'Imaginary Landscape no. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1840 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Imaginary Landscape no. 4

UPDATE pieces piece
SET piece.title = 'Imaginary Landscape no. 4', piece.title_en = 'Imaginary Landscape no. 4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2735 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Imaginary Landscape no. 5

UPDATE pieces piece
SET piece.title = 'Imaginary Landscape no. 5', piece.title_en = 'Imaginary Landscape no. 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2214 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Imitations II

UPDATE pieces piece
SET piece.title = 'Imitations II', piece.title_en = 'Imitations II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2966 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Improvisation III

UPDATE pieces piece
SET piece.title = 'Improvisation III', piece.title_en = 'Improvisation III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1319 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None In the Name of the Holocaust

UPDATE pieces piece
SET piece.title = 'In the Name of the Holocaust', piece.title_en = 'In the Name of the Holocaust',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2043 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'In the Name of the Holocaust: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2043 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cc986b08-e920-348d-9976-ed1d9e0772e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc986b08-e920-348d-9976-ed1d9e0772e7', 1, NULL, 'I', 'In the Name of the Holocaust: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2043 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc986b08-e920-348d-9976-ed1d9e0772e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'In the Name of the Holocaust: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2043 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b500203d-ad01-39c0-9c96-0692c90f9fe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b500203d-ad01-39c0-9c96-0692c90f9fe4', 2, NULL, 'II', 'In the Name of the Holocaust: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2043 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b500203d-ad01-39c0-9c96-0692c90f9fe4'
);


-- None Inlets

UPDATE pieces piece
SET piece.title = 'Inlets', piece.title_en = 'Inlets',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2759 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jazz Study

UPDATE pieces piece
SET piece.title = 'Jazz Study', piece.title_en = 'Jazz Study',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2055 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Litany for the Whale

UPDATE pieces piece
SET piece.title = 'Litany for the Whale', piece.title_en = 'Litany for the Whale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 901 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Living Room Music

UPDATE pieces piece
SET piece.title = 'Living Room Music', piece.title_en = 'Living Room Music',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2146 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '(For Household Objects)', part.name_en = 'Living Room Music: I. (For Household Objects)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2146 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:598afd6c-a04e-3038-9c73-9f4eab57481b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:598afd6c-a04e-3038-9c73-9f4eab57481b', 1, 'I', '(For Household Objects)', 'Living Room Music: I. (For Household Objects)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2146 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:598afd6c-a04e-3038-9c73-9f4eab57481b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Once Upon a Time the World Is Round (Gertrude Stein), Dedicated to Xenia', part.name_en = 'Living Room Music: II. Once Upon a Time the World Is Round (Gertrude Stein), Dedicated to Xenia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2146 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:57c32f8a-5857-3904-8c58-b9b2e4f10e56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57c32f8a-5857-3904-8c58-b9b2e4f10e56', 2, 'II', 'Once Upon a Time the World Is Round (Gertrude Stein), Dedicated to Xenia', 'Living Room Music: II. Once Upon a Time the World Is Round (Gertrude Stein), Dedicated to Xenia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2146 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c32f8a-5857-3904-8c58-b9b2e4f10e56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '(Solo)', part.name_en = 'Living Room Music: III. (Solo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2146 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:287458c1-08d3-31f7-a75f-c050fd82c01e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:287458c1-08d3-31f7-a75f-c050fd82c01e', 3, 'III', '(Solo)', 'Living Room Music: III. (Solo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2146 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:287458c1-08d3-31f7-a75f-c050fd82c01e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '(For Household Objects)', part.name_en = 'Living Room Music: IV. (For Household Objects)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2146 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:97b24757-d8b6-3d06-8319-cffa36d3dd90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97b24757-d8b6-3d06-8319-cffa36d3dd90', 4, 'IV', '(For Household Objects)', 'Living Room Music: IV. (For Household Objects)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2146 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97b24757-d8b6-3d06-8319-cffa36d3dd90'
);


-- None Mirakus²

UPDATE pieces piece
SET piece.title = 'Mirakus²', piece.title_en = 'Mirakus²',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2396 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for "Works of Calder"

UPDATE pieces piece
SET piece.title = 'Music for "Works of Calder"', piece.title_en = 'Music for "Works of Calder"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 976 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Music for "Works of Calder": I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 976 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:fbbfb241-9472-448f-8970-4f85cfa117a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbbfb241-9472-448f-8970-4f85cfa117a9', 1, NULL, 'I', 'Music for "Works of Calder": I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 976 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbbfb241-9472-448f-8970-4f85cfa117a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Music for "Works of Calder": II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 976 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6f52098f-b3c0-4832-bce6-98ea31da0483' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f52098f-b3c0-4832-bce6-98ea31da0483', 2, NULL, 'II', 'Music for "Works of Calder": II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 976 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f52098f-b3c0-4832-bce6-98ea31da0483'
);


-- None Music for "Works of Calder": III

UPDATE pieces piece
SET piece.title = 'Music for "Works of Calder": III', piece.title_en = 'Music for "Works of Calder": III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2320 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for "Works of Calder": IV

UPDATE pieces piece
SET piece.title = 'Music for "Works of Calder": IV', piece.title_en = 'Music for "Works of Calder": IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1075 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Amplified Toy Pianos

UPDATE pieces piece
SET piece.title = 'Music for Amplified Toy Pianos', piece.title_en = 'Music for Amplified Toy Pianos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1257 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Carillon no. 1

UPDATE pieces piece
SET piece.title = 'Music for Carillon no. 1', piece.title_en = 'Music for Carillon no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2317 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Carillon no. 2

UPDATE pieces piece
SET piece.title = 'Music for Carillon no. 2', piece.title_en = 'Music for Carillon no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1561 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Carillon no. 3

UPDATE pieces piece
SET piece.title = 'Music for Carillon no. 3', piece.title_en = 'Music for Carillon no. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2412 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Carillon no. 5

UPDATE pieces piece
SET piece.title = 'Music for Carillon no. 5', piece.title_en = 'Music for Carillon no. 5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2605 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Piano

UPDATE pieces piece
SET piece.title = 'Music for Piano', piece.title_en = 'Music for Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1278 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 1', part.name_en = 'Music for Piano 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:56c73647-072d-3601-85df-7858e1a639f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56c73647-072d-3601-85df-7858e1a639f5', 1, NULL, 'Music for Piano 1', 'Music for Piano 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56c73647-072d-3601-85df-7858e1a639f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 2', part.name_en = 'Music for Piano 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:10d676eb-720e-3358-a92d-e2fd0c21d784' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10d676eb-720e-3358-a92d-e2fd0c21d784', 2, NULL, 'Music for Piano 2', 'Music for Piano 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10d676eb-720e-3358-a92d-e2fd0c21d784'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 3', part.name_en = 'Music for Piano 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:77f836b8-c1f4-332d-8de9-4f41510c302a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77f836b8-c1f4-332d-8de9-4f41510c302a', 3, NULL, 'Music for Piano 3', 'Music for Piano 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77f836b8-c1f4-332d-8de9-4f41510c302a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 4-19', part.name_en = 'Music for Piano 4-19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a', 4, NULL, 'Music for Piano 4-19', 'Music for Piano 4-19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 4', part.name_en = 'Music for Piano 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4021b003-d861-3e91-8b1c-27eedee77760' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4021b003-d861-3e91-8b1c-27eedee77760', 1, NULL, 'Music for Piano 4', 'Music for Piano 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4021b003-d861-3e91-8b1c-27eedee77760'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 5', part.name_en = 'Music for Piano 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d7feba3c-da34-469e-b97a-0906ad5fea1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7feba3c-da34-469e-b97a-0906ad5fea1d', 2, NULL, 'Music for Piano 5', 'Music for Piano 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7feba3c-da34-469e-b97a-0906ad5fea1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 6', part.name_en = 'Music for Piano 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4b4985ba-2a0c-320a-8a25-199d65121342' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b4985ba-2a0c-320a-8a25-199d65121342', 3, NULL, 'Music for Piano 6', 'Music for Piano 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b4985ba-2a0c-320a-8a25-199d65121342'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 7', part.name_en = 'Music for Piano 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9dfbb005-d8be-45b3-88df-ac95478ae5c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9dfbb005-d8be-45b3-88df-ac95478ae5c3', 4, NULL, 'Music for Piano 7', 'Music for Piano 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dfbb005-d8be-45b3-88df-ac95478ae5c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 8', part.name_en = 'Music for Piano 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a0c5b78d-3480-4cb8-8724-7b790a7a90df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0c5b78d-3480-4cb8-8724-7b790a7a90df', 5, NULL, 'Music for Piano 8', 'Music for Piano 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0c5b78d-3480-4cb8-8724-7b790a7a90df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 9', part.name_en = 'Music for Piano 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:57c0b6c0-1e52-4a72-b99d-7bb3be3e292e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57c0b6c0-1e52-4a72-b99d-7bb3be3e292e', 6, NULL, 'Music for Piano 9', 'Music for Piano 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c0b6c0-1e52-4a72-b99d-7bb3be3e292e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 10', part.name_en = 'Music for Piano 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6aff841d-6bd3-4aac-97b1-541834096609' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6aff841d-6bd3-4aac-97b1-541834096609', 7, NULL, 'Music for Piano 10', 'Music for Piano 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6aff841d-6bd3-4aac-97b1-541834096609'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 11', part.name_en = 'Music for Piano 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b9dbbd9a-3731-46c8-8917-e21c9212edca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9dbbd9a-3731-46c8-8917-e21c9212edca', 8, NULL, 'Music for Piano 11', 'Music for Piano 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9dbbd9a-3731-46c8-8917-e21c9212edca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 12', part.name_en = 'Music for Piano 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4bd49403-a4d3-4dd1-8c02-bad3dd099c4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bd49403-a4d3-4dd1-8c02-bad3dd099c4d', 9, NULL, 'Music for Piano 12', 'Music for Piano 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bd49403-a4d3-4dd1-8c02-bad3dd099c4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 13', part.name_en = 'Music for Piano 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9118a920-42e5-420a-a853-e2eafe0503f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9118a920-42e5-420a-a853-e2eafe0503f7', 10, NULL, 'Music for Piano 13', 'Music for Piano 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9118a920-42e5-420a-a853-e2eafe0503f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 14', part.name_en = 'Music for Piano 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:73685b26-1d8c-3ed2-9b26-7057b586d6a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73685b26-1d8c-3ed2-9b26-7057b586d6a7', 11, NULL, 'Music for Piano 14', 'Music for Piano 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73685b26-1d8c-3ed2-9b26-7057b586d6a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 15', part.name_en = 'Music for Piano 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f437c05a-229f-466e-abed-0d3739850b5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f437c05a-229f-466e-abed-0d3739850b5f', 12, NULL, 'Music for Piano 15', 'Music for Piano 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f437c05a-229f-466e-abed-0d3739850b5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 16', part.name_en = 'Music for Piano 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2b933359-281b-4180-87ec-186c1c7ec88c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b933359-281b-4180-87ec-186c1c7ec88c', 13, NULL, 'Music for Piano 16', 'Music for Piano 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b933359-281b-4180-87ec-186c1c7ec88c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 17', part.name_en = 'Music for Piano 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:21735212-719e-481a-8cb3-c4b3834d57df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21735212-719e-481a-8cb3-c4b3834d57df', 14, NULL, 'Music for Piano 17', 'Music for Piano 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21735212-719e-481a-8cb3-c4b3834d57df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 18', part.name_en = 'Music for Piano 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:76e32ba3-9cef-44d0-b96d-4de31291c46c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:76e32ba3-9cef-44d0-b96d-4de31291c46c', 15, NULL, 'Music for Piano 18', 'Music for Piano 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76e32ba3-9cef-44d0-b96d-4de31291c46c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 19', part.name_en = 'Music for Piano 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:931461da-24bf-316d-bf80-cf3f6c3941df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:931461da-24bf-316d-bf80-cf3f6c3941df', 16, NULL, 'Music for Piano 19', 'Music for Piano 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc2c675-6508-4572-96e1-b24583b5e59a'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:931461da-24bf-316d-bf80-cf3f6c3941df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 20', part.name_en = 'Music for Piano 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ea60139b-7fda-3bc5-9381-0e5cdeea13d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea60139b-7fda-3bc5-9381-0e5cdeea13d8', 5, NULL, 'Music for Piano 20', 'Music for Piano 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea60139b-7fda-3bc5-9381-0e5cdeea13d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 21-36', part.name_en = 'Music for Piano 21-36',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564', 6, NULL, 'Music for Piano 21-36', 'Music for Piano 21-36', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 21', part.name_en = 'Music for Piano 21',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:75ca9801-6acb-3ba8-964a-75c1cfd79c2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75ca9801-6acb-3ba8-964a-75c1cfd79c2d', 1, NULL, 'Music for Piano 21', 'Music for Piano 21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75ca9801-6acb-3ba8-964a-75c1cfd79c2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 22', part.name_en = 'Music for Piano 22',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:916cc9b1-d25a-42ad-aa4b-442c3b99a301' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:916cc9b1-d25a-42ad-aa4b-442c3b99a301', 2, NULL, 'Music for Piano 22', 'Music for Piano 22', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:916cc9b1-d25a-42ad-aa4b-442c3b99a301'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 23', part.name_en = 'Music for Piano 23',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:439b3d62-4596-4fac-bd2b-d596e83fa56f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:439b3d62-4596-4fac-bd2b-d596e83fa56f', 3, NULL, 'Music for Piano 23', 'Music for Piano 23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:439b3d62-4596-4fac-bd2b-d596e83fa56f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 24', part.name_en = 'Music for Piano 24',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a7f34352-b467-481d-8836-bbbdfd4d8d9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7f34352-b467-481d-8836-bbbdfd4d8d9c', 4, NULL, 'Music for Piano 24', 'Music for Piano 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7f34352-b467-481d-8836-bbbdfd4d8d9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 25', part.name_en = 'Music for Piano 25',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f99ac070-e17e-4fbd-aca8-0c01b04632b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f99ac070-e17e-4fbd-aca8-0c01b04632b9', 5, NULL, 'Music for Piano 25', 'Music for Piano 25', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f99ac070-e17e-4fbd-aca8-0c01b04632b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 26', part.name_en = 'Music for Piano 26',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7bf98ea3-36f6-4442-afca-1707dc5a7a3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7bf98ea3-36f6-4442-afca-1707dc5a7a3c', 6, NULL, 'Music for Piano 26', 'Music for Piano 26', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bf98ea3-36f6-4442-afca-1707dc5a7a3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 27', part.name_en = 'Music for Piano 27',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7e7db234-f2f0-4ddf-80e0-0524cd2cd879' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e7db234-f2f0-4ddf-80e0-0524cd2cd879', 7, NULL, 'Music for Piano 27', 'Music for Piano 27', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e7db234-f2f0-4ddf-80e0-0524cd2cd879'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 28', part.name_en = 'Music for Piano 28',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:fb45be7f-0887-3ea5-9180-d85cd8067bbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb45be7f-0887-3ea5-9180-d85cd8067bbe', 8, NULL, 'Music for Piano 28', 'Music for Piano 28', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb45be7f-0887-3ea5-9180-d85cd8067bbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 29', part.name_en = 'Music for Piano 29',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1dc56494-42ed-437f-8129-06056fad7504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1dc56494-42ed-437f-8129-06056fad7504', 9, NULL, 'Music for Piano 29', 'Music for Piano 29', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dc56494-42ed-437f-8129-06056fad7504'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 30', part.name_en = 'Music for Piano 30',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:88734a41-dd43-4de1-8ed8-b534d2611f3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88734a41-dd43-4de1-8ed8-b534d2611f3a', 10, NULL, 'Music for Piano 30', 'Music for Piano 30', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88734a41-dd43-4de1-8ed8-b534d2611f3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 31', part.name_en = 'Music for Piano 31',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c337e42e-4f61-3417-959d-c482ed4c6f47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c337e42e-4f61-3417-959d-c482ed4c6f47', 11, NULL, 'Music for Piano 31', 'Music for Piano 31', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c337e42e-4f61-3417-959d-c482ed4c6f47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 32', part.name_en = 'Music for Piano 32',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6e30b78f-1ec8-4a51-9f21-6f4cc24a8a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e30b78f-1ec8-4a51-9f21-6f4cc24a8a67', 12, NULL, 'Music for Piano 32', 'Music for Piano 32', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e30b78f-1ec8-4a51-9f21-6f4cc24a8a67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 33', part.name_en = 'Music for Piano 33',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cd83a20b-e6b3-4d03-b311-d925f35dc605' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd83a20b-e6b3-4d03-b311-d925f35dc605', 13, NULL, 'Music for Piano 33', 'Music for Piano 33', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd83a20b-e6b3-4d03-b311-d925f35dc605'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 34', part.name_en = 'Music for Piano 34',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:869c2825-e2c9-4ef9-b85c-8999871407dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:869c2825-e2c9-4ef9-b85c-8999871407dc', 14, NULL, 'Music for Piano 34', 'Music for Piano 34', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:869c2825-e2c9-4ef9-b85c-8999871407dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 35', part.name_en = 'Music for Piano 35',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9b826d96-0550-449a-b42a-1982e06b1db2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b826d96-0550-449a-b42a-1982e06b1db2', 15, NULL, 'Music for Piano 35', 'Music for Piano 35', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b826d96-0550-449a-b42a-1982e06b1db2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 36', part.name_en = 'Music for Piano 36',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:462f56f3-e952-44b4-a59a-b68d292bc3f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:462f56f3-e952-44b4-a59a-b68d292bc3f6', 16, NULL, 'Music for Piano 36', 'Music for Piano 36', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91965294-0f95-42de-8878-e5ad78c4a564'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:462f56f3-e952-44b4-a59a-b68d292bc3f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 37-52', part.name_en = 'Music for Piano 37-52',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc', 7, NULL, 'Music for Piano 37-52', 'Music for Piano 37-52', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 37', part.name_en = 'Music for Piano 37',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a4ec5639-6a0e-3cf2-9d15-7fb58b2293ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4ec5639-6a0e-3cf2-9d15-7fb58b2293ca', 1, NULL, 'Music for Piano 37', 'Music for Piano 37', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4ec5639-6a0e-3cf2-9d15-7fb58b2293ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 38', part.name_en = 'Music for Piano 38',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a7ca479c-8576-4134-aeee-2b2f4cfd5249' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7ca479c-8576-4134-aeee-2b2f4cfd5249', 2, NULL, 'Music for Piano 38', 'Music for Piano 38', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7ca479c-8576-4134-aeee-2b2f4cfd5249'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 39', part.name_en = 'Music for Piano 39',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:13a2d157-293d-4e73-96bb-518e6c44c8b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13a2d157-293d-4e73-96bb-518e6c44c8b7', 3, NULL, 'Music for Piano 39', 'Music for Piano 39', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13a2d157-293d-4e73-96bb-518e6c44c8b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 40', part.name_en = 'Music for Piano 40',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:667650f6-56ee-421b-956d-f9ae8ef1b3f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:667650f6-56ee-421b-956d-f9ae8ef1b3f2', 4, NULL, 'Music for Piano 40', 'Music for Piano 40', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:667650f6-56ee-421b-956d-f9ae8ef1b3f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 41', part.name_en = 'Music for Piano 41',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1a2b67c7-4bc8-3fd0-b292-9405ef9a75b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a2b67c7-4bc8-3fd0-b292-9405ef9a75b0', 5, NULL, 'Music for Piano 41', 'Music for Piano 41', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a2b67c7-4bc8-3fd0-b292-9405ef9a75b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 42', part.name_en = 'Music for Piano 42',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8fb963eb-55ec-482f-90bf-dff70eba4372' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8fb963eb-55ec-482f-90bf-dff70eba4372', 6, NULL, 'Music for Piano 42', 'Music for Piano 42', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fb963eb-55ec-482f-90bf-dff70eba4372'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 43', part.name_en = 'Music for Piano 43',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:94f31843-2ec8-44d2-a5fe-3849a0c7e67a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94f31843-2ec8-44d2-a5fe-3849a0c7e67a', 7, NULL, 'Music for Piano 43', 'Music for Piano 43', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94f31843-2ec8-44d2-a5fe-3849a0c7e67a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 44', part.name_en = 'Music for Piano 44',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e0d3f205-a7a1-41da-ab87-dfd93af68d1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0d3f205-a7a1-41da-ab87-dfd93af68d1b', 8, NULL, 'Music for Piano 44', 'Music for Piano 44', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0d3f205-a7a1-41da-ab87-dfd93af68d1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 45', part.name_en = 'Music for Piano 45',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9ebef75e-6f5b-3ace-bf43-fd3ad638c57c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ebef75e-6f5b-3ace-bf43-fd3ad638c57c', 9, NULL, 'Music for Piano 45', 'Music for Piano 45', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ebef75e-6f5b-3ace-bf43-fd3ad638c57c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 46', part.name_en = 'Music for Piano 46',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b5360b94-8d39-4c11-813b-3a72198ba5d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5360b94-8d39-4c11-813b-3a72198ba5d9', 10, NULL, 'Music for Piano 46', 'Music for Piano 46', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5360b94-8d39-4c11-813b-3a72198ba5d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 47', part.name_en = 'Music for Piano 47',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4f14af42-760c-4e6b-866e-bcc5f73d5ec8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f14af42-760c-4e6b-866e-bcc5f73d5ec8', 11, NULL, 'Music for Piano 47', 'Music for Piano 47', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f14af42-760c-4e6b-866e-bcc5f73d5ec8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 48', part.name_en = 'Music for Piano 48',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:be0a46db-5a35-435e-95ae-701c1285e6eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be0a46db-5a35-435e-95ae-701c1285e6eb', 12, NULL, 'Music for Piano 48', 'Music for Piano 48', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be0a46db-5a35-435e-95ae-701c1285e6eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 49', part.name_en = 'Music for Piano 49',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b0448892-ad33-3786-8375-36b2d7ed400c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0448892-ad33-3786-8375-36b2d7ed400c', 13, NULL, 'Music for Piano 49', 'Music for Piano 49', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0448892-ad33-3786-8375-36b2d7ed400c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 50', part.name_en = 'Music for Piano 50',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2a06d9d9-aa75-4427-a004-839d21974c63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a06d9d9-aa75-4427-a004-839d21974c63', 14, NULL, 'Music for Piano 50', 'Music for Piano 50', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a06d9d9-aa75-4427-a004-839d21974c63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 51', part.name_en = 'Music for Piano 51',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:327fd4ba-216b-4bf1-94ff-f4afc6480d30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:327fd4ba-216b-4bf1-94ff-f4afc6480d30', 15, NULL, 'Music for Piano 51', 'Music for Piano 51', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:327fd4ba-216b-4bf1-94ff-f4afc6480d30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 52', part.name_en = 'Music for Piano 52',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:dd45e9ba-d816-425b-a434-b31d41787102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd45e9ba-d816-425b-a434-b31d41787102', 16, NULL, 'Music for Piano 52', 'Music for Piano 52', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:830a2bdb-cca5-433e-b33a-0138212daffc'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd45e9ba-d816-425b-a434-b31d41787102'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 53-68', part.name_en = 'Music for Piano 53-68',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6', 8, NULL, 'Music for Piano 53-68', 'Music for Piano 53-68', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 53', part.name_en = 'Music for Piano 53',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c44822a3-555e-475b-9f75-2692c14aff6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c44822a3-555e-475b-9f75-2692c14aff6d', 1, NULL, 'Music for Piano 53', 'Music for Piano 53', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c44822a3-555e-475b-9f75-2692c14aff6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 54', part.name_en = 'Music for Piano 54',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:35f06680-328d-4c67-b985-f29c4e091e5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35f06680-328d-4c67-b985-f29c4e091e5a', 2, NULL, 'Music for Piano 54', 'Music for Piano 54', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35f06680-328d-4c67-b985-f29c4e091e5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 55', part.name_en = 'Music for Piano 55',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8a10211f-8315-4806-9399-9c04f83e6d92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a10211f-8315-4806-9399-9c04f83e6d92', 3, NULL, 'Music for Piano 55', 'Music for Piano 55', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a10211f-8315-4806-9399-9c04f83e6d92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 56', part.name_en = 'Music for Piano 56',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:61ac7218-a4ab-4885-9516-b0ea8206f5a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:61ac7218-a4ab-4885-9516-b0ea8206f5a9', 4, NULL, 'Music for Piano 56', 'Music for Piano 56', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61ac7218-a4ab-4885-9516-b0ea8206f5a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 57', part.name_en = 'Music for Piano 57',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e76c3a0c-e69e-42b9-b861-241b7680c37e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e76c3a0c-e69e-42b9-b861-241b7680c37e', 5, NULL, 'Music for Piano 57', 'Music for Piano 57', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e76c3a0c-e69e-42b9-b861-241b7680c37e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 58', part.name_en = 'Music for Piano 58',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:184464c0-87e9-46e3-9892-7d7a539de935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:184464c0-87e9-46e3-9892-7d7a539de935', 6, NULL, 'Music for Piano 58', 'Music for Piano 58', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:184464c0-87e9-46e3-9892-7d7a539de935'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 59', part.name_en = 'Music for Piano 59',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ca99b7dd-3bcf-4225-94ba-febbb70cd360' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca99b7dd-3bcf-4225-94ba-febbb70cd360', 7, NULL, 'Music for Piano 59', 'Music for Piano 59', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca99b7dd-3bcf-4225-94ba-febbb70cd360'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 60', part.name_en = 'Music for Piano 60',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:46a73976-fafc-40c2-8443-1888b41ba6b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46a73976-fafc-40c2-8443-1888b41ba6b8', 8, NULL, 'Music for Piano 60', 'Music for Piano 60', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46a73976-fafc-40c2-8443-1888b41ba6b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 61', part.name_en = 'Music for Piano 61',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e7cf8c7b-a355-4e02-8402-d7885bf6b470' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7cf8c7b-a355-4e02-8402-d7885bf6b470', 9, NULL, 'Music for Piano 61', 'Music for Piano 61', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7cf8c7b-a355-4e02-8402-d7885bf6b470'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 62', part.name_en = 'Music for Piano 62',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:86af05d7-fbec-4d45-be1d-eb0a51f04452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:86af05d7-fbec-4d45-be1d-eb0a51f04452', 10, NULL, 'Music for Piano 62', 'Music for Piano 62', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86af05d7-fbec-4d45-be1d-eb0a51f04452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 63', part.name_en = 'Music for Piano 63',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6c81e43c-f565-469c-a3e5-897e4d63243c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c81e43c-f565-469c-a3e5-897e4d63243c', 11, NULL, 'Music for Piano 63', 'Music for Piano 63', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c81e43c-f565-469c-a3e5-897e4d63243c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 64', part.name_en = 'Music for Piano 64',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:325557e6-8394-42b0-a7f9-d54da3e850b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:325557e6-8394-42b0-a7f9-d54da3e850b5', 12, NULL, 'Music for Piano 64', 'Music for Piano 64', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:325557e6-8394-42b0-a7f9-d54da3e850b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 65', part.name_en = 'Music for Piano 65',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:60f1a9ab-bb32-4e23-91e5-25b56de7e0bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60f1a9ab-bb32-4e23-91e5-25b56de7e0bb', 13, NULL, 'Music for Piano 65', 'Music for Piano 65', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60f1a9ab-bb32-4e23-91e5-25b56de7e0bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 66', part.name_en = 'Music for Piano 66',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8ccf3242-0d5b-401b-bed9-54068ff9243f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8ccf3242-0d5b-401b-bed9-54068ff9243f', 14, NULL, 'Music for Piano 66', 'Music for Piano 66', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ccf3242-0d5b-401b-bed9-54068ff9243f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 67', part.name_en = 'Music for Piano 67',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e3184ba3-18ee-4436-8889-f1001f42a904' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3184ba3-18ee-4436-8889-f1001f42a904', 15, NULL, 'Music for Piano 67', 'Music for Piano 67', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3184ba3-18ee-4436-8889-f1001f42a904'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 68', part.name_en = 'Music for Piano 68',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:92ff22bb-b030-47ac-bca3-2cf6bdad0d2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92ff22bb-b030-47ac-bca3-2cf6bdad0d2f', 16, NULL, 'Music for Piano 68', 'Music for Piano 68', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40988d40-6613-3355-8494-8869c40108a6'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92ff22bb-b030-47ac-bca3-2cf6bdad0d2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 69-84', part.name_en = 'Music for Piano 69-84',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f', 9, NULL, 'Music for Piano 69-84', 'Music for Piano 69-84', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 69', part.name_en = 'Music for Piano 69',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:617879b0-3df3-33a4-a4d6-18a4ede13b54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:617879b0-3df3-33a4-a4d6-18a4ede13b54', 1, NULL, 'Music for Piano 69', 'Music for Piano 69', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:617879b0-3df3-33a4-a4d6-18a4ede13b54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 70', part.name_en = 'Music for Piano 70',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b8488603-edc6-3d81-a0f7-fffb129b6eb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8488603-edc6-3d81-a0f7-fffb129b6eb2', 2, NULL, 'Music for Piano 70', 'Music for Piano 70', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8488603-edc6-3d81-a0f7-fffb129b6eb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 71', part.name_en = 'Music for Piano 71',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1b5f32c4-1aef-36e9-8c74-0c7997a0db96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1b5f32c4-1aef-36e9-8c74-0c7997a0db96', 3, NULL, 'Music for Piano 71', 'Music for Piano 71', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b5f32c4-1aef-36e9-8c74-0c7997a0db96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 72', part.name_en = 'Music for Piano 72',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:91381217-e35c-3f77-a394-515f01f2c174' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91381217-e35c-3f77-a394-515f01f2c174', 4, NULL, 'Music for Piano 72', 'Music for Piano 72', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91381217-e35c-3f77-a394-515f01f2c174'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 73', part.name_en = 'Music for Piano 73',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4bd538c5-abc7-324a-b0d8-8ac5666c63f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bd538c5-abc7-324a-b0d8-8ac5666c63f6', 5, NULL, 'Music for Piano 73', 'Music for Piano 73', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bd538c5-abc7-324a-b0d8-8ac5666c63f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 74', part.name_en = 'Music for Piano 74',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9dc80e6a-25ef-33cc-9420-23c2531b8c4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9dc80e6a-25ef-33cc-9420-23c2531b8c4c', 6, NULL, 'Music for Piano 74', 'Music for Piano 74', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dc80e6a-25ef-33cc-9420-23c2531b8c4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 75', part.name_en = 'Music for Piano 75',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:17d3bd60-9785-3742-ae6a-b57f4f71d928' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17d3bd60-9785-3742-ae6a-b57f4f71d928', 7, NULL, 'Music for Piano 75', 'Music for Piano 75', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17d3bd60-9785-3742-ae6a-b57f4f71d928'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 76', part.name_en = 'Music for Piano 76',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ee252bca-aa48-370a-8b7d-38aae2fee5dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee252bca-aa48-370a-8b7d-38aae2fee5dd', 8, NULL, 'Music for Piano 76', 'Music for Piano 76', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee252bca-aa48-370a-8b7d-38aae2fee5dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 77', part.name_en = 'Music for Piano 77',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:aef6e1f0-0558-3074-accf-e86847491754' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aef6e1f0-0558-3074-accf-e86847491754', 9, NULL, 'Music for Piano 77', 'Music for Piano 77', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aef6e1f0-0558-3074-accf-e86847491754'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 78', part.name_en = 'Music for Piano 78',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c25b4828-4679-30ce-86d9-25d162ce1cb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c25b4828-4679-30ce-86d9-25d162ce1cb7', 10, NULL, 'Music for Piano 78', 'Music for Piano 78', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c25b4828-4679-30ce-86d9-25d162ce1cb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 79', part.name_en = 'Music for Piano 79',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5abcd13c-3c3e-3c09-8330-f7ac9f224508' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5abcd13c-3c3e-3c09-8330-f7ac9f224508', 11, NULL, 'Music for Piano 79', 'Music for Piano 79', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5abcd13c-3c3e-3c09-8330-f7ac9f224508'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 80', part.name_en = 'Music for Piano 80',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1524aae8-29ad-30ed-a369-bca0d5391746' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1524aae8-29ad-30ed-a369-bca0d5391746', 12, NULL, 'Music for Piano 80', 'Music for Piano 80', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1524aae8-29ad-30ed-a369-bca0d5391746'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 81', part.name_en = 'Music for Piano 81',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3011b8d7-a9c1-3aec-9e56-05bab545b607' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3011b8d7-a9c1-3aec-9e56-05bab545b607', 13, NULL, 'Music for Piano 81', 'Music for Piano 81', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3011b8d7-a9c1-3aec-9e56-05bab545b607'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 82', part.name_en = 'Music for Piano 82',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8d496229-a3fc-333d-a6dc-8017d7bd9d9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d496229-a3fc-333d-a6dc-8017d7bd9d9f', 14, NULL, 'Music for Piano 82', 'Music for Piano 82', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d496229-a3fc-333d-a6dc-8017d7bd9d9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 83', part.name_en = 'Music for Piano 83',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e9f77249-c54d-3ef4-bafe-8c4a032e8bf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9f77249-c54d-3ef4-bafe-8c4a032e8bf6', 15, NULL, 'Music for Piano 83', 'Music for Piano 83', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9f77249-c54d-3ef4-bafe-8c4a032e8bf6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 84', part.name_en = 'Music for Piano 84',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3ac12e9f-5b7f-393a-9c1f-2c58fb8d93b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ac12e9f-5b7f-393a-9c1f-2c58fb8d93b5', 16, NULL, 'Music for Piano 84', 'Music for Piano 84', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f43e7d3-42f9-40b5-b03a-d86e4d0b5a2f'
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ac12e9f-5b7f-393a-9c1f-2c58fb8d93b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Music for Piano 85', part.name_en = 'Music for Piano 85',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1278 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f8e4f745-f1e6-386f-b0e6-ced66d121636' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8e4f745-f1e6-386f-b0e6-ced66d121636', 10, NULL, 'Music for Piano 85', 'Music for Piano 85', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1278 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8e4f745-f1e6-386f-b0e6-ced66d121636'
);


-- None Music for Two

UPDATE pieces piece
SET piece.title = 'Music for Two', piece.title_en = 'Music for Two',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2626 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music for Wind Instruments

UPDATE pieces piece
SET piece.title = 'Music for Wind Instruments', piece.title_en = 'Music for Wind Instruments',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2401 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Trio', part.name_en = 'Music for Wind Instruments: I. Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2401 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:93962e72-ee73-40bb-b105-63c2105d9410' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93962e72-ee73-40bb-b105-63c2105d9410', 1, 'I', 'Trio', 'Music for Wind Instruments: I. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2401 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93962e72-ee73-40bb-b105-63c2105d9410'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Duo', part.name_en = 'Music for Wind Instruments: II. Duo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2401 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b613039d-f060-432b-8d73-ba51a5240b94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b613039d-f060-432b-8d73-ba51a5240b94', 2, 'II', 'Duo', 'Music for Wind Instruments: II. Duo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2401 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b613039d-f060-432b-8d73-ba51a5240b94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quintet', part.name_en = 'Music for Wind Instruments: III. Quintet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2401 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:872fbb55-2dd3-4ba8-96f2-9f7cf7a7f206' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:872fbb55-2dd3-4ba8-96f2-9f7cf7a7f206', 3, 'III', 'Quintet', 'Music for Wind Instruments: III. Quintet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2401 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:872fbb55-2dd3-4ba8-96f2-9f7cf7a7f206'
);


-- None Music for ________

UPDATE pieces piece
SET piece.title = 'Music for ________', piece.title_en = 'Music for ________',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 897 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Music of Changes

UPDATE pieces piece
SET piece.title = 'Music of Changes', piece.title_en = 'Music of Changes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1217 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Music of Changes I', part.name_en = 'Music of Changes I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1217 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:61f1042b-8e5c-3c8a-a7ad-450a402621f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61f1042b-8e5c-3c8a-a7ad-450a402621f4', 1, NULL, 'Music of Changes I', 'Music of Changes I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1217 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61f1042b-8e5c-3c8a-a7ad-450a402621f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Music of Changes II', part.name_en = 'Music of Changes II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1217 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:99d14100-8253-4cd6-b9da-6a14313f999b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99d14100-8253-4cd6-b9da-6a14313f999b', 2, NULL, 'Music of Changes II', 'Music of Changes II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1217 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99d14100-8253-4cd6-b9da-6a14313f999b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Music of Changes III', part.name_en = 'Music of Changes III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1217 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:341c0258-60a9-496d-a456-3db514ddb9cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:341c0258-60a9-496d-a456-3db514ddb9cf', 3, NULL, 'Music of Changes III', 'Music of Changes III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1217 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:341c0258-60a9-496d-a456-3db514ddb9cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Music of Changes IV', part.name_en = 'Music of Changes IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1217 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d7b596f9-3872-4ef5-bdaf-438098db1e82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7b596f9-3872-4ef5-bdaf-438098db1e82', 4, NULL, 'Music of Changes IV', 'Music of Changes IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1217 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7b596f9-3872-4ef5-bdaf-438098db1e82'
);


-- None Mysterious Adventure

UPDATE pieces piece
SET piece.title = 'Mysterious Adventure', piece.title_en = 'Mysterious Adventure',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1539 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바이올린과 피아노를 위한 녹턴

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 녹턴', piece.title_en = 'Nocturne for Violin and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 946 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Nowth Upon Nacht>

UPDATE pieces piece
SET piece.title = '가곡 <Nowth Upon Nacht>', piece.title_en = 'Nowth Upon Nacht',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2970 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One²

UPDATE pieces piece
SET piece.title = 'One²', piece.title_en = 'One²',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 489 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One¹⁰

UPDATE pieces piece
SET piece.title = 'One¹⁰', piece.title_en = 'One¹⁰',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 896 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One⁴

UPDATE pieces piece
SET piece.title = 'One⁴', piece.title_en = 'One⁴',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1910 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One⁵

UPDATE pieces piece
SET piece.title = 'One⁵', piece.title_en = 'One⁵',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 509 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One⁶

UPDATE pieces piece
SET piece.title = 'One⁶', piece.title_en = 'One⁶',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1366 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One⁸

UPDATE pieces piece
SET piece.title = 'One⁸', piece.title_en = 'One⁸',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2569 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Opening Dance

UPDATE pieces piece
SET piece.title = 'Opening Dance', piece.title_en = 'Opening Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2699 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ophelia

UPDATE pieces piece
SET piece.title = 'Ophelia', piece.title_en = 'Ophelia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2079 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Our Spring Will Come

UPDATE pieces piece
SET piece.title = 'Our Spring Will Come', piece.title_en = 'Our Spring Will Come',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2614 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Postcard from Heaven

UPDATE pieces piece
SET piece.title = 'Postcard from Heaven', piece.title_en = 'Postcard from Heaven',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2921 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prelude for Meditation

UPDATE pieces piece
SET piece.title = 'Prelude for Meditation', piece.title_en = 'Prelude for Meditation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1161 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 전주곡 A단조

UPDATE pieces piece
SET piece.title = '전주곡 A단조', piece.title_en = 'Prelude for Six Instruments in A minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1769 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Primitive

UPDATE pieces piece
SET piece.title = 'Primitive', piece.title_en = 'Primitive',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2004 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 4중주

UPDATE pieces piece
SET piece.title = '4중주', piece.title_en = 'Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2710 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Quartet: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2710 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2f4326c0-0cb9-4781-b165-6433117791f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f4326c0-0cb9-4781-b165-6433117791f0', 1, 'I', 'Moderato', 'Quartet: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2710 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f4326c0-0cb9-4781-b165-6433117791f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Very Slow', part.name_en = 'Quartet: II. Very Slow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2710 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4f89f0bd-75ac-44c6-bb27-e3d5d0c440b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f89f0bd-75ac-44c6-bb27-e3d5d0c440b1', 2, 'II', 'Very Slow', 'Quartet: II. Very Slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2710 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f89f0bd-75ac-44c6-bb27-e3d5d0c440b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Axial Asymmetry - Slow', part.name_en = 'Quartet: III. Axial Asymmetry - Slow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2710 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c2ed6626-6de7-4c18-b6d2-f8c97e77537f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2ed6626-6de7-4c18-b6d2-f8c97e77537f', 3, 'III', 'Axial Asymmetry - Slow', 'Quartet: III. Axial Asymmetry - Slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2710 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2ed6626-6de7-4c18-b6d2-f8c97e77537f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fast', part.name_en = 'Quartet: IV. Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2710 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:86029cf7-608d-4dee-99cd-4aaf8563290e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86029cf7-608d-4dee-99cd-4aaf8563290e', 4, 'IV', 'Fast', 'Quartet: IV. Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2710 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86029cf7-608d-4dee-99cd-4aaf8563290e'
);


-- None Quartets I - VIII

UPDATE pieces piece
SET piece.title = 'Quartets I - VIII', piece.title_en = 'Quartets I - VIII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1789 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quest

UPDATE pieces piece
SET piece.title = 'Quest', piece.title_en = 'Quest',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1146 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Radio Music

UPDATE pieces piece
SET piece.title = 'Radio Music', piece.title_en = 'Radio Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1347 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Renga

UPDATE pieces piece
SET piece.title = 'Renga', piece.title_en = 'Renga',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2506 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Root of an Unfocus

UPDATE pieces piece
SET piece.title = 'Root of an Unfocus', piece.title_en = 'Root of an Unfocus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1706 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rozart Mix

UPDATE pieces piece
SET piece.title = 'Rozart Mix', piece.title_en = 'Rozart Mix',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2930 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ryoanji

UPDATE pieces piece
SET piece.title = 'Ryoanji', piece.title_en = 'Ryoanji',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2165 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sculptures Musicales

UPDATE pieces piece
SET piece.title = 'Sculptures Musicales', piece.title_en = 'Sculptures Musicales',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2075 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Second Construction

UPDATE pieces piece
SET piece.title = 'Second Construction', piece.title_en = 'Second Construction',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2753 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seven

UPDATE pieces piece
SET piece.title = 'Seven', piece.title_en = 'Seven',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2223 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seven Haiku

UPDATE pieces piece
SET piece.title = 'Seven Haiku', piece.title_en = 'Seven Haiku',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2315 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'For Elsa', part.name_en = 'Seven Haiku: For Elsa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2315 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e645863e-f118-4e59-bf55-84b4872ffea6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e645863e-f118-4e59-bf55-84b4872ffea6', 1, NULL, 'For Elsa', 'Seven Haiku: For Elsa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2315 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e645863e-f118-4e59-bf55-84b4872ffea6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'For Merle Armitage', part.name_en = 'Seven Haiku: For Merle Armitage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2315 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e21afa4a-4797-4770-857c-3a7237a1d5ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e21afa4a-4797-4770-857c-3a7237a1d5ae', 2, NULL, 'For Merle Armitage', 'Seven Haiku: For Merle Armitage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2315 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e21afa4a-4797-4770-857c-3a7237a1d5ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'For Aghavni Uomini', part.name_en = 'Seven Haiku: For Aghavni Uomini',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2315 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cb80860a-0732-493c-8149-797fae114d00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb80860a-0732-493c-8149-797fae114d00', 3, NULL, 'For Aghavni Uomini', 'Seven Haiku: For Aghavni Uomini', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2315 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb80860a-0732-493c-8149-797fae114d00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'For Richard Lippold', part.name_en = 'Seven Haiku: For Richard Lippold',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2315 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:076c4841-48f1-41e3-adb6-2901ae52be0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:076c4841-48f1-41e3-adb6-2901ae52be0b', 4, NULL, 'For Richard Lippold', 'Seven Haiku: For Richard Lippold', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2315 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:076c4841-48f1-41e3-adb6-2901ae52be0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'For Maro', part.name_en = 'Seven Haiku: For Maro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2315 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:aafa913b-1c7d-40f2-af5a-cd9c6ea168b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aafa913b-1c7d-40f2-af5a-cd9c6ea168b1', 5, NULL, 'For Maro', 'Seven Haiku: For Maro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2315 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aafa913b-1c7d-40f2-af5a-cd9c6ea168b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'For Willem de Kooning', part.name_en = 'Seven Haiku: For Willem de Kooning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2315 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f9afd48a-82af-42ea-a5ab-2460b87451c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9afd48a-82af-42ea-a5ab-2460b87451c6', 6, NULL, 'For Willem de Kooning', 'Seven Haiku: For Willem de Kooning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2315 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9afd48a-82af-42ea-a5ab-2460b87451c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'For Sonia Sekula', part.name_en = 'Seven Haiku: For Sonia Sekula',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2315 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:caed2b95-be9c-4473-9288-7ee8603d5d48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caed2b95-be9c-4473-9288-7ee8603d5d48', 7, NULL, 'For Sonia Sekula', 'Seven Haiku: For Sonia Sekula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2315 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caed2b95-be9c-4473-9288-7ee8603d5d48'
);


-- None Seventy-Four

UPDATE pieces piece
SET piece.title = 'Seventy-Four', piece.title_en = 'Seventy-Four',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2847 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seven²

UPDATE pieces piece
SET piece.title = 'Seven²', piece.title_en = 'Seven²',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2808 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Six

UPDATE pieces piece
SET piece.title = 'Six', piece.title_en = 'Six',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 472 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Six Melodies

UPDATE pieces piece
SET piece.title = 'Six Melodies', piece.title_en = 'Six Melodies',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2636 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Melody 1', part.name_en = 'Six Melodies: Melody 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2636 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:0d297de7-9a03-4042-9bb8-becef63c8c4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d297de7-9a03-4042-9bb8-becef63c8c4b', 1, NULL, 'Melody 1', 'Six Melodies: Melody 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2636 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d297de7-9a03-4042-9bb8-becef63c8c4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Melody 2', part.name_en = 'Six Melodies: Melody 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2636 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:02924018-2039-4edc-961c-ec5e9e7d55cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02924018-2039-4edc-961c-ec5e9e7d55cb', 2, NULL, 'Melody 2', 'Six Melodies: Melody 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2636 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02924018-2039-4edc-961c-ec5e9e7d55cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Melody 3', part.name_en = 'Six Melodies: Melody 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2636 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:33dd4912-a079-4672-a51d-4833ec67b48c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33dd4912-a079-4672-a51d-4833ec67b48c', 3, NULL, 'Melody 3', 'Six Melodies: Melody 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2636 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33dd4912-a079-4672-a51d-4833ec67b48c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Melody 4', part.name_en = 'Six Melodies: Melody 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2636 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ecf57c82-993c-4d49-b1ba-a924027b37a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecf57c82-993c-4d49-b1ba-a924027b37a4', 4, NULL, 'Melody 4', 'Six Melodies: Melody 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2636 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecf57c82-993c-4d49-b1ba-a924027b37a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Melody 5', part.name_en = 'Six Melodies: Melody 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2636 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:270d214e-735f-4f41-aa6c-9ac91540a66f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:270d214e-735f-4f41-aa6c-9ac91540a66f', 5, NULL, 'Melody 5', 'Six Melodies: Melody 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2636 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:270d214e-735f-4f41-aa6c-9ac91540a66f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Melody 6', part.name_en = 'Six Melodies: Melody 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2636 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:00adbeb5-c64d-45d1-997a-f696c45f3026' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00adbeb5-c64d-45d1-997a-f696c45f3026', 6, NULL, 'Melody 6', 'Six Melodies: Melody 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2636 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00adbeb5-c64d-45d1-997a-f696c45f3026'
);


-- None Sixteen Dances for Soloists and Company of 3

UPDATE pieces piece
SET piece.title = 'Sixteen Dances for Soloists and Company of 3', piece.title_en = 'Sixteen Dances for Soloists and Company of 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1546 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '(Anger)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 1 (Anger)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:84f4644f-19f3-49f8-bcf5-5e06046f7406' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84f4644f-19f3-49f8-bcf5-5e06046f7406', 1, NULL, '(Anger)', 'Sixteen Dances for Soloists and Company of 3: No. 1 (Anger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84f4644f-19f3-49f8-bcf5-5e06046f7406'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '(Interlude)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 2 (Interlude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b4d82825-e43a-4070-96d0-f913355b575e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4d82825-e43a-4070-96d0-f913355b575e', 2, NULL, '(Interlude)', 'Sixteen Dances for Soloists and Company of 3: No. 2 (Interlude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4d82825-e43a-4070-96d0-f913355b575e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '(Humor)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 3 (Humor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3c3ef464-11b5-4d6a-b722-5541ffff605c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c3ef464-11b5-4d6a-b722-5541ffff605c', 3, NULL, '(Humor)', 'Sixteen Dances for Soloists and Company of 3: No. 3 (Humor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c3ef464-11b5-4d6a-b722-5541ffff605c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '(Interlude)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 4 (Interlude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1210adeb-d533-4e69-9c40-4bf375263590' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1210adeb-d533-4e69-9c40-4bf375263590', 4, NULL, '(Interlude)', 'Sixteen Dances for Soloists and Company of 3: No. 4 (Interlude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1210adeb-d533-4e69-9c40-4bf375263590'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '(Sorrow)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 5 (Sorrow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:0a0e8378-e42b-44e5-b3c8-143b9b08797e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a0e8378-e42b-44e5-b3c8-143b9b08797e', 5, NULL, '(Sorrow)', 'Sixteen Dances for Soloists and Company of 3: No. 5 (Sorrow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a0e8378-e42b-44e5-b3c8-143b9b08797e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '(Interlude)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 6 (Interlude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6a2d144e-9c81-4514-b134-a358e1b83e38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a2d144e-9c81-4514-b134-a358e1b83e38', 6, NULL, '(Interlude)', 'Sixteen Dances for Soloists and Company of 3: No. 6 (Interlude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a2d144e-9c81-4514-b134-a358e1b83e38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '(The Heroic)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 7 (The Heroic)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cb0c68a4-c2ec-4aa6-a020-6c7d03222a43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb0c68a4-c2ec-4aa6-a020-6c7d03222a43', 7, NULL, '(The Heroic)', 'Sixteen Dances for Soloists and Company of 3: No. 7 (The Heroic)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb0c68a4-c2ec-4aa6-a020-6c7d03222a43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '(Interlude)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 8 (Interlude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:39b1128f-17fc-4fea-9122-e2d39125eb16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39b1128f-17fc-4fea-9122-e2d39125eb16', 8, NULL, '(Interlude)', 'Sixteen Dances for Soloists and Company of 3: No. 8 (Interlude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39b1128f-17fc-4fea-9122-e2d39125eb16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '(The Odious)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 9 (The Odious)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:02d6c463-1e1a-4ed8-b9b0-f41eea22c5bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02d6c463-1e1a-4ed8-b9b0-f41eea22c5bb', 9, NULL, '(The Odious)', 'Sixteen Dances for Soloists and Company of 3: No. 9 (The Odious)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02d6c463-1e1a-4ed8-b9b0-f41eea22c5bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '(Interlude)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 10 (Interlude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:38882d93-23c3-4e43-8afd-b95a39d3ef0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38882d93-23c3-4e43-8afd-b95a39d3ef0f', 10, NULL, '(Interlude)', 'Sixteen Dances for Soloists and Company of 3: No. 10 (Interlude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38882d93-23c3-4e43-8afd-b95a39d3ef0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '(The Wonderous)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 11 (The Wonderous)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5bc03bec-b808-4ba5-b537-9fb12330898b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bc03bec-b808-4ba5-b537-9fb12330898b', 11, NULL, '(The Wonderous)', 'Sixteen Dances for Soloists and Company of 3: No. 11 (The Wonderous)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bc03bec-b808-4ba5-b537-9fb12330898b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '(Interlude)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 12 (Interlude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:950d2956-0542-4676-9592-7a165453c61d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:950d2956-0542-4676-9592-7a165453c61d', 12, NULL, '(Interlude)', 'Sixteen Dances for Soloists and Company of 3: No. 12 (Interlude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:950d2956-0542-4676-9592-7a165453c61d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '(Fear)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 13 (Fear)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3c40e70c-a1de-40ce-aad3-f3f4d667ef6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c40e70c-a1de-40ce-aad3-f3f4d667ef6c', 13, NULL, '(Fear)', 'Sixteen Dances for Soloists and Company of 3: No. 13 (Fear)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c40e70c-a1de-40ce-aad3-f3f4d667ef6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '(Interlude)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 14 (Interlude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:30f2974a-1401-40b5-93f8-b7f08639786c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30f2974a-1401-40b5-93f8-b7f08639786c', 14, NULL, '(Interlude)', 'Sixteen Dances for Soloists and Company of 3: No. 14 (Interlude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30f2974a-1401-40b5-93f8-b7f08639786c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '(The Erotic)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 15 (The Erotic)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:31e062f8-70ca-4238-8e0d-da4b3e1b6ce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31e062f8-70ca-4238-8e0d-da4b3e1b6ce5', 15, NULL, '(The Erotic)', 'Sixteen Dances for Soloists and Company of 3: No. 15 (The Erotic)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31e062f8-70ca-4238-8e0d-da4b3e1b6ce5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '(Tranquility)', part.name_en = 'Sixteen Dances for Soloists and Company of 3: No. 16 (Tranquility)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1546 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1eed0531-38ae-4c43-b4f7-b6cfa4faa7c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1eed0531-38ae-4c43-b4f7-b6cfa4faa7c8', 16, NULL, '(Tranquility)', 'Sixteen Dances for Soloists and Company of 3: No. 16 (Tranquility)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1546 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1eed0531-38ae-4c43-b4f7-b6cfa4faa7c8'
);


-- None Sixty-Eight

UPDATE pieces piece
SET piece.title = 'Sixty-Eight', piece.title_en = 'Sixty-Eight',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1581 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sixty-two Mesostics re Merce Cunningham

UPDATE pieces piece
SET piece.title = 'Sixty-two Mesostics re Merce Cunningham', piece.title_en = 'Sixty-two Mesostics re Merce Cunningham',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2730 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo for Sliding Trombone

UPDATE pieces piece
SET piece.title = 'Solo for Sliding Trombone', piece.title_en = 'Solo for Sliding Trombone',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1569 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo for Voice 1

UPDATE pieces piece
SET piece.title = 'Solo for Voice 1', piece.title_en = 'Solo for Voice 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2824 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo for Voice 2

UPDATE pieces piece
SET piece.title = 'Solo for Voice 2', piece.title_en = 'Solo for Voice 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2414 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo

UPDATE pieces piece
SET piece.title = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo', piece.title_en = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2574 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Grave adagio', part.name_en = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Grave adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2574 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6f8b2397-235a-4d0b-b35f-a8d21fb149cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f8b2397-235a-4d0b-b35f-a8d21fb149cc', 1, NULL, 'Grave adagio', 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Grave adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2574 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f8b2397-235a-4d0b-b35f-a8d21fb149cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Invention no. 1', part.name_en = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2574 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a50eae49-4c26-4726-b5e1-e0821adefb72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a50eae49-4c26-4726-b5e1-e0821adefb72', 2, NULL, 'Invention no. 1', 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2574 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a50eae49-4c26-4726-b5e1-e0821adefb72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Invention no. 2', part.name_en = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2574 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e903f331-d6f3-46bf-a49c-3e7112817d16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e903f331-d6f3-46bf-a49c-3e7112817d16', 3, NULL, 'Invention no. 2', 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2574 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e903f331-d6f3-46bf-a49c-3e7112817d16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Invention no. 3', part.name_en = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2574 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2244cf13-4f43-4495-9e4a-95daa2556374' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2244cf13-4f43-4495-9e4a-95daa2556374', 4, NULL, 'Invention no. 3', 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2574 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2244cf13-4f43-4495-9e4a-95daa2556374'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Invention no. 4', part.name_en = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2574 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4a15c571-a2f8-4b0d-8909-9ef148d19e62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a15c571-a2f8-4b0d-8909-9ef148d19e62', 5, NULL, 'Invention no. 4', 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2574 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a15c571-a2f8-4b0d-8909-9ef148d19e62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Invention no. 5', part.name_en = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2574 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1755fe74-9950-4462-b27e-ca40ca12e0f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1755fe74-9950-4462-b27e-ca40ca12e0f4', 6, NULL, 'Invention no. 5', 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2574 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1755fe74-9950-4462-b27e-ca40ca12e0f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Invention no. 6', part.name_en = 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2574 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6922b8e4-bdf5-474f-8f1a-bb67f89fac87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6922b8e4-bdf5-474f-8f1a-bb67f89fac87', 7, NULL, 'Invention no. 6', 'Solo with Obbligato Accompaniment of Two Voices in Canon, and Six Short Inventions on the Subjects of the Solo: Invention no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2574 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6922b8e4-bdf5-474f-8f1a-bb67f89fac87'
);


-- None Some of "The Harmony of Maine"

UPDATE pieces piece
SET piece.title = 'Some of "The Harmony of Maine"', piece.title_en = 'Some of "The Harmony of Maine"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2379 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 클라리넷 소나타

UPDATE pieces piece
SET piece.title = '클라리넷 소나타', piece.title_en = 'Sonata for Clarinet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1343 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vivace', part.name_en = 'Sonata for Clarinet: I. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1343 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b6848a92-a9e1-4bab-945c-8b0cd67bf73a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6848a92-a9e1-4bab-945c-8b0cd67bf73a', 1, 'I', 'Vivace', 'Sonata for Clarinet: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1343 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6848a92-a9e1-4bab-945c-8b0cd67bf73a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Sonata for Clarinet: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1343 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d65b3160-3dc0-41f2-b3be-912639e8a39d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d65b3160-3dc0-41f2-b3be-912639e8a39d', 2, 'II', 'Lento', 'Sonata for Clarinet: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1343 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d65b3160-3dc0-41f2-b3be-912639e8a39d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Sonata for Clarinet: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1343 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d52570b2-e01c-4948-99d3-5e080b187408' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d52570b2-e01c-4948-99d3-5e080b187408', 3, 'III', 'Vivace', 'Sonata for Clarinet: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1343 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d52570b2-e01c-4948-99d3-5e080b187408'
);


-- None Sonata for Two Voices

UPDATE pieces piece
SET piece.title = 'Sonata for Two Voices', piece.title_en = 'Sonata for Two Voices',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2005 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sonata (Allegro)', part.name_en = 'Sonata For Two Voices: I. Sonata (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2005 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:165e35fa-797d-4cef-aaff-2ff5e9ac90e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:165e35fa-797d-4cef-aaff-2ff5e9ac90e8', 1, 'I', 'Sonata (Allegro)', 'Sonata For Two Voices: I. Sonata (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2005 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:165e35fa-797d-4cef-aaff-2ff5e9ac90e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fugato (Lento)', part.name_en = 'Sonata For Two Voices: II. Fugato (Lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2005 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:aaa7f626-1149-495d-b45b-0446d5d117d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaa7f626-1149-495d-b45b-0446d5d117d2', 2, 'II', 'Fugato (Lento)', 'Sonata For Two Voices: II. Fugato (Lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2005 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa7f626-1149-495d-b45b-0446d5d117d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rondo (Tempo Primo)', part.name_en = 'Sonata For Two Voices: III. Rondo (Tempo Primo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2005 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cf5a35e0-acbb-4e0c-8f82-9da6c1744e1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf5a35e0-acbb-4e0c-8f82-9da6c1744e1a', 3, 'III', 'Rondo (Tempo Primo)', 'Sonata For Two Voices: III. Rondo (Tempo Primo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2005 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf5a35e0-acbb-4e0c-8f82-9da6c1744e1a'
);


-- None Sonatas and Interludes for Prepared Piano

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 1', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:03c20aef-03dd-3931-bd6e-5b410e5365c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03c20aef-03dd-3931-bd6e-5b410e5365c5', 1, NULL, 'Sonata no. 1', 'Sonatas and Interludes for Prepared Piano: Sonata no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03c20aef-03dd-3931-bd6e-5b410e5365c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 2', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5eaec26a-2857-3461-846a-02ca16421fc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eaec26a-2857-3461-846a-02ca16421fc8', 2, NULL, 'Sonata no. 2', 'Sonatas and Interludes for Prepared Piano: Sonata no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eaec26a-2857-3461-846a-02ca16421fc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 3', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:82bfb30b-d25d-3cd6-a9d6-c087257034b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82bfb30b-d25d-3cd6-a9d6-c087257034b1', 3, NULL, 'Sonata no. 3', 'Sonatas and Interludes for Prepared Piano: Sonata no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82bfb30b-d25d-3cd6-a9d6-c087257034b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 4', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:413c296c-8b97-3f87-a2d7-b53ed6a4a877' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:413c296c-8b97-3f87-a2d7-b53ed6a4a877', 4, NULL, 'Sonata no. 4', 'Sonatas and Interludes for Prepared Piano: Sonata no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:413c296c-8b97-3f87-a2d7-b53ed6a4a877'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Interlude no. 1', part.name_en = 'Sonatas and Interludes for Prepared Piano: Interlude no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a21796d0-cfd5-30da-bac8-509b015a93d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a21796d0-cfd5-30da-bac8-509b015a93d1', 5, NULL, 'Interlude no. 1', 'Sonatas and Interludes for Prepared Piano: Interlude no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a21796d0-cfd5-30da-bac8-509b015a93d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 5', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a46bd830-22dd-3d43-8b41-211eb7a184ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a46bd830-22dd-3d43-8b41-211eb7a184ce', 6, NULL, 'Sonata no. 5', 'Sonatas and Interludes for Prepared Piano: Sonata no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a46bd830-22dd-3d43-8b41-211eb7a184ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 6', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:009e3c03-e20a-356e-8729-47605d3a8cc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:009e3c03-e20a-356e-8729-47605d3a8cc9', 7, NULL, 'Sonata no. 6', 'Sonatas and Interludes for Prepared Piano: Sonata no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:009e3c03-e20a-356e-8729-47605d3a8cc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 7', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9087f202-0184-3814-aa96-bf0fa8fbbda9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9087f202-0184-3814-aa96-bf0fa8fbbda9', 8, NULL, 'Sonata no. 7', 'Sonatas and Interludes for Prepared Piano: Sonata no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9087f202-0184-3814-aa96-bf0fa8fbbda9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 8', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a630cf83-70ae-3ff4-98ab-103ad19e3eed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a630cf83-70ae-3ff4-98ab-103ad19e3eed', 9, NULL, 'Sonata no. 8', 'Sonatas and Interludes for Prepared Piano: Sonata no. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a630cf83-70ae-3ff4-98ab-103ad19e3eed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Interlude no. 2', part.name_en = 'Sonatas and Interludes for Prepared Piano: Interlude no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3fdf1eba-4b21-3617-9ff1-0426479174c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fdf1eba-4b21-3617-9ff1-0426479174c1', 10, NULL, 'Interlude no. 2', 'Sonatas and Interludes for Prepared Piano: Interlude no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fdf1eba-4b21-3617-9ff1-0426479174c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Interlude no. 3', part.name_en = 'Sonatas and Interludes for Prepared Piano: Interlude no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:bfd75a45-1e90-3e6c-b297-ad0d4fbc5f2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd75a45-1e90-3e6c-b297-ad0d4fbc5f2f', 11, NULL, 'Interlude no. 3', 'Sonatas and Interludes for Prepared Piano: Interlude no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd75a45-1e90-3e6c-b297-ad0d4fbc5f2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 9', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:984fbe79-3e00-3e19-b8cd-bba29c02ae46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:984fbe79-3e00-3e19-b8cd-bba29c02ae46', 12, NULL, 'Sonata no. 9', 'Sonatas and Interludes for Prepared Piano: Sonata no. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:984fbe79-3e00-3e19-b8cd-bba29c02ae46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 10', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2e1cabfd-3a57-3f80-9f48-a0494db3275d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e1cabfd-3a57-3f80-9f48-a0494db3275d', 13, NULL, 'Sonata no. 10', 'Sonatas and Interludes for Prepared Piano: Sonata no. 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e1cabfd-3a57-3f80-9f48-a0494db3275d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 11', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e1d93a5f-8b93-305c-8db4-a35744ba6fd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1d93a5f-8b93-305c-8db4-a35744ba6fd8', 14, NULL, 'Sonata no. 11', 'Sonatas and Interludes for Prepared Piano: Sonata no. 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d93a5f-8b93-305c-8db4-a35744ba6fd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 12', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2d312deb-b2f7-37c8-b5eb-18a14d3a7c34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d312deb-b2f7-37c8-b5eb-18a14d3a7c34', 15, NULL, 'Sonata no. 12', 'Sonatas and Interludes for Prepared Piano: Sonata no. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d312deb-b2f7-37c8-b5eb-18a14d3a7c34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Interlude no. 4', part.name_en = 'Sonatas and Interludes for Prepared Piano: Interlude no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:687f2005-e768-3ee7-a132-3c71eb3fffc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:687f2005-e768-3ee7-a132-3c71eb3fffc8', 16, NULL, 'Interlude no. 4', 'Sonatas and Interludes for Prepared Piano: Interlude no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:687f2005-e768-3ee7-a132-3c71eb3fffc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 13', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2197df0e-f303-3ed9-a486-a0725636bf4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2197df0e-f303-3ed9-a486-a0725636bf4a', 17, NULL, 'Sonata no. 13', 'Sonatas and Interludes for Prepared Piano: Sonata no. 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2197df0e-f303-3ed9-a486-a0725636bf4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 14', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ab837b9e-004e-3bc3-b484-e47706877735' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab837b9e-004e-3bc3-b484-e47706877735', 18, NULL, 'Sonata no. 14', 'Sonatas and Interludes for Prepared Piano: Sonata no. 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab837b9e-004e-3bc3-b484-e47706877735'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 15', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7fafc440-16a8-3e2f-bcf3-190971187ab4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fafc440-16a8-3e2f-bcf3-190971187ab4', 19, NULL, 'Sonata no. 15', 'Sonatas and Interludes for Prepared Piano: Sonata no. 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fafc440-16a8-3e2f-bcf3-190971187ab4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Sonata no. 16', part.name_en = 'Sonatas and Interludes for Prepared Piano: Sonata no. 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 352 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b9ca7fbf-59f9-396c-8eed-40003a7b4c6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9ca7fbf-59f9-396c-8eed-40003a7b4c6a', 20, NULL, 'Sonata no. 16', 'Sonatas and Interludes for Prepared Piano: Sonata no. 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 352 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9ca7fbf-59f9-396c-8eed-40003a7b4c6a'
);


-- None Song Books

UPDATE pieces piece
SET piece.title = 'Song Books', piece.title_en = 'Song Books',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1026 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 35', part.name_en = 'Solo for Voice 35',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:051e71a7-c487-4c3c-ab46-d868ae07c199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:051e71a7-c487-4c3c-ab46-d868ae07c199', 1, NULL, 'Solo for Voice 35', 'Solo for Voice 35', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:051e71a7-c487-4c3c-ab46-d868ae07c199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 28', part.name_en = 'Solo for Voice 28',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:0c083d9b-ff54-400b-aa1b-8119798c9f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c083d9b-ff54-400b-aa1b-8119798c9f19', 2, NULL, 'Solo for Voice 28', 'Solo for Voice 28', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c083d9b-ff54-400b-aa1b-8119798c9f19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 18', part.name_en = 'Solo for Voice 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:0cabb2fe-9cdf-4705-9ac1-6468ad4101e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cabb2fe-9cdf-4705-9ac1-6468ad4101e1', 3, NULL, 'Solo for Voice 18', 'Solo for Voice 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cabb2fe-9cdf-4705-9ac1-6468ad4101e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 62', part.name_en = 'Solo for Voice 62',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:16481f40-436e-44f7-ad5f-e592a6494ffe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16481f40-436e-44f7-ad5f-e592a6494ffe', 4, NULL, 'Solo for Voice 62', 'Solo for Voice 62', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16481f40-436e-44f7-ad5f-e592a6494ffe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 17', part.name_en = 'Solo for Voice 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1a2e51a7-4dd9-4a47-895a-6e9aaa3d4af2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a2e51a7-4dd9-4a47-895a-6e9aaa3d4af2', 5, NULL, 'Solo for Voice 17', 'Solo for Voice 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a2e51a7-4dd9-4a47-895a-6e9aaa3d4af2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 80', part.name_en = 'Solo for Voice 80',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1a35eb3f-bf78-439c-a297-48d5ac600e07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a35eb3f-bf78-439c-a297-48d5ac600e07', 6, NULL, 'Solo for Voice 80', 'Solo for Voice 80', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a35eb3f-bf78-439c-a297-48d5ac600e07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 3', part.name_en = 'Solo for Voice 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1b598ce9-9fa2-468b-82ee-f88033481a0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b598ce9-9fa2-468b-82ee-f88033481a0b', 7, NULL, 'Solo for Voice 3', 'Solo for Voice 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b598ce9-9fa2-468b-82ee-f88033481a0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 23', part.name_en = 'Solo for Voice 23',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1d78bd26-8954-410e-97bf-29f3d15e1876' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d78bd26-8954-410e-97bf-29f3d15e1876', 8, NULL, 'Solo for Voice 23', 'Solo for Voice 23', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d78bd26-8954-410e-97bf-29f3d15e1876'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 51', part.name_en = 'Solo for Voice 51',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1fd07306-2741-486f-980c-b93c2c78c2bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fd07306-2741-486f-980c-b93c2c78c2bc', 9, NULL, 'Solo for Voice 51', 'Solo for Voice 51', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fd07306-2741-486f-980c-b93c2c78c2bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 4', part.name_en = 'Solo for Voice 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:22473d00-5a32-4ffe-bc41-171c6e36c8be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22473d00-5a32-4ffe-bc41-171c6e36c8be', 10, NULL, 'Solo for Voice 4', 'Solo for Voice 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22473d00-5a32-4ffe-bc41-171c6e36c8be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 31', part.name_en = 'Solo for Voice 31',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2281fa15-c3e4-4beb-be8b-b4c89e34e312' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2281fa15-c3e4-4beb-be8b-b4c89e34e312', 11, NULL, 'Solo for Voice 31', 'Solo for Voice 31', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2281fa15-c3e4-4beb-be8b-b4c89e34e312'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 55', part.name_en = 'Solo for Voice 55',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:22f134b2-09c0-4d22-9599-1b5e27214908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22f134b2-09c0-4d22-9599-1b5e27214908', 12, NULL, 'Solo for Voice 55', 'Solo for Voice 55', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22f134b2-09c0-4d22-9599-1b5e27214908'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 11', part.name_en = 'Solo for Voice 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:23ef98dd-246f-49f8-a3c0-e61d4e208316' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23ef98dd-246f-49f8-a3c0-e61d4e208316', 13, NULL, 'Solo for Voice 11', 'Solo for Voice 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ef98dd-246f-49f8-a3c0-e61d4e208316'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 73', part.name_en = 'Solo for Voice 73',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:25c93ea6-0eb4-4a9d-bbd0-71fad20783d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25c93ea6-0eb4-4a9d-bbd0-71fad20783d9', 14, NULL, 'Solo for Voice 73', 'Solo for Voice 73', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c93ea6-0eb4-4a9d-bbd0-71fad20783d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 63', part.name_en = 'Solo for Voice 63',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2c78f071-7a14-4549-8125-b05f78a87f01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c78f071-7a14-4549-8125-b05f78a87f01', 15, NULL, 'Solo for Voice 63', 'Solo for Voice 63', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c78f071-7a14-4549-8125-b05f78a87f01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 29', part.name_en = 'Solo for Voice 29',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2e066c67-ef43-4c96-a0e0-cba406f1bbbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e066c67-ef43-4c96-a0e0-cba406f1bbbe', 16, NULL, 'Solo for Voice 29', 'Solo for Voice 29', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e066c67-ef43-4c96-a0e0-cba406f1bbbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 90', part.name_en = 'Solo for Voice 90',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:302060fd-f461-41d8-9fab-31e0b660f3f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:302060fd-f461-41d8-9fab-31e0b660f3f1', 17, NULL, 'Solo for Voice 90', 'Solo for Voice 90', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:302060fd-f461-41d8-9fab-31e0b660f3f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 50', part.name_en = 'Solo for Voice 50',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3436962f-4b92-492c-ab2c-85fdf7f6fabc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3436962f-4b92-492c-ab2c-85fdf7f6fabc', 18, NULL, 'Solo for Voice 50', 'Solo for Voice 50', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3436962f-4b92-492c-ab2c-85fdf7f6fabc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 72', part.name_en = 'Solo for Voice 72',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3447f968-20d6-4a6b-a08b-1254aa59fdad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3447f968-20d6-4a6b-a08b-1254aa59fdad', 19, NULL, 'Solo for Voice 72', 'Solo for Voice 72', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3447f968-20d6-4a6b-a08b-1254aa59fdad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 22', part.name_en = 'Solo for Voice 22',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:35cb9f43-f191-4815-9582-bba47114b94d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35cb9f43-f191-4815-9582-bba47114b94d', 20, NULL, 'Solo for Voice 22', 'Solo for Voice 22', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35cb9f43-f191-4815-9582-bba47114b94d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 26', part.name_en = 'Solo for Voice 26',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:38675d81-b388-42cf-b493-644945700f58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38675d81-b388-42cf-b493-644945700f58', 21, NULL, 'Solo for Voice 26', 'Solo for Voice 26', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38675d81-b388-42cf-b493-644945700f58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 67', part.name_en = 'Solo for Voice 67',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3cb11010-2c98-4e5e-9b8b-78f8f2002232' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cb11010-2c98-4e5e-9b8b-78f8f2002232', 22, NULL, 'Solo for Voice 67', 'Solo for Voice 67', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cb11010-2c98-4e5e-9b8b-78f8f2002232'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 89', part.name_en = 'Solo for Voice 89',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3d45f1a4-177d-44ee-9ec4-77de519ce685' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d45f1a4-177d-44ee-9ec4-77de519ce685', 23, NULL, 'Solo for Voice 89', 'Solo for Voice 89', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d45f1a4-177d-44ee-9ec4-77de519ce685'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 33', part.name_en = 'Solo for Voice 33',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3e426b3c-db2f-4e86-aa0d-89de47af8dba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e426b3c-db2f-4e86-aa0d-89de47af8dba', 24, NULL, 'Solo for Voice 33', 'Solo for Voice 33', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e426b3c-db2f-4e86-aa0d-89de47af8dba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 12', part.name_en = 'Solo for Voice 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3f1a6f9c-e7a1-4503-89f7-3fdc23e179c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f1a6f9c-e7a1-4503-89f7-3fdc23e179c4', 25, NULL, 'Solo for Voice 12', 'Solo for Voice 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f1a6f9c-e7a1-4503-89f7-3fdc23e179c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 9', part.name_en = 'Solo for Voice 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:421f73f2-0b9d-4f6d-9da8-a4fd610ac65d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:421f73f2-0b9d-4f6d-9da8-a4fd610ac65d', 26, NULL, 'Solo for Voice 9', 'Solo for Voice 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:421f73f2-0b9d-4f6d-9da8-a4fd610ac65d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 66', part.name_en = 'Solo for Voice 66',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:445fdbe4-ee07-4347-b23b-ed9a3b754b5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:445fdbe4-ee07-4347-b23b-ed9a3b754b5f', 27, NULL, 'Solo for Voice 66', 'Solo for Voice 66', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:445fdbe4-ee07-4347-b23b-ed9a3b754b5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 24', part.name_en = 'Solo for Voice 24',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:472fffe5-f061-40b8-a357-bcfd8aff88be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:472fffe5-f061-40b8-a357-bcfd8aff88be', 28, NULL, 'Solo for Voice 24', 'Solo for Voice 24', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:472fffe5-f061-40b8-a357-bcfd8aff88be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 70', part.name_en = 'Solo for Voice 70',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4b639f16-15ff-4818-9887-075b1d2b991b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b639f16-15ff-4818-9887-075b1d2b991b', 29, NULL, 'Solo for Voice 70', 'Solo for Voice 70', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b639f16-15ff-4818-9887-075b1d2b991b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = '18 Microtonal Ragas', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8', 30, NULL, '18 Microtonal Ragas', 'Solo for Voice 58: 18 Microtonal Ragas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Raga 1', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1790bd4a-9918-413a-b937-e22f0783c690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1790bd4a-9918-413a-b937-e22f0783c690', 1, NULL, 'Raga 1', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1790bd4a-9918-413a-b937-e22f0783c690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Raga 2', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:24d82bfb-a92f-42f6-adb2-8d3364ba5a8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24d82bfb-a92f-42f6-adb2-8d3364ba5a8e', 2, NULL, 'Raga 2', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24d82bfb-a92f-42f6-adb2-8d3364ba5a8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Raga 3', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3c8941ec-cc95-41fd-8c40-8562fd901d71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c8941ec-cc95-41fd-8c40-8562fd901d71', 3, NULL, 'Raga 3', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c8941ec-cc95-41fd-8c40-8562fd901d71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Raga 4', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ff868bd2-9394-4731-8299-9ce72b23c746' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff868bd2-9394-4731-8299-9ce72b23c746', 4, NULL, 'Raga 4', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff868bd2-9394-4731-8299-9ce72b23c746'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Raga 5', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:0c470979-949e-4cc5-bfb1-98df6d551b10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c470979-949e-4cc5-bfb1-98df6d551b10', 5, NULL, 'Raga 5', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c470979-949e-4cc5-bfb1-98df6d551b10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Raga 6', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d6417964-85a7-43fc-8382-bb340f15d090' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6417964-85a7-43fc-8382-bb340f15d090', 6, NULL, 'Raga 6', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6417964-85a7-43fc-8382-bb340f15d090'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Raga 7', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3817b0f8-c69b-42cb-bf1c-71557eaac267' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3817b0f8-c69b-42cb-bf1c-71557eaac267', 7, NULL, 'Raga 7', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3817b0f8-c69b-42cb-bf1c-71557eaac267'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Raga 8', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:462c0679-92b6-4194-a81b-9eaff43c733f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:462c0679-92b6-4194-a81b-9eaff43c733f', 8, NULL, 'Raga 8', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:462c0679-92b6-4194-a81b-9eaff43c733f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Raga 9', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c32fac0f-7acf-46b1-8e03-940de7683e2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c32fac0f-7acf-46b1-8e03-940de7683e2e', 9, NULL, 'Raga 9', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c32fac0f-7acf-46b1-8e03-940de7683e2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Raga 10', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:789f865b-06ba-4839-9710-f768656c6829' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:789f865b-06ba-4839-9710-f768656c6829', 10, NULL, 'Raga 10', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:789f865b-06ba-4839-9710-f768656c6829'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Raga 11', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 11',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:33b66eff-cd7a-4264-a16f-75ff072da156' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:33b66eff-cd7a-4264-a16f-75ff072da156', 11, NULL, 'Raga 11', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 11', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33b66eff-cd7a-4264-a16f-75ff072da156'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Raga 12', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2bbf150f-eb0b-4ec1-8e9b-5c8663daeda3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2bbf150f-eb0b-4ec1-8e9b-5c8663daeda3', 12, NULL, 'Raga 12', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bbf150f-eb0b-4ec1-8e9b-5c8663daeda3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Raga 13', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b8f66fcb-e267-4e92-b54c-dc707b3b309c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8f66fcb-e267-4e92-b54c-dc707b3b309c', 13, NULL, 'Raga 13', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8f66fcb-e267-4e92-b54c-dc707b3b309c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Raga 14', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a6be192f-1540-452c-8fb8-0eb6e8a44ba1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6be192f-1540-452c-8fb8-0eb6e8a44ba1', 14, NULL, 'Raga 14', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6be192f-1540-452c-8fb8-0eb6e8a44ba1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Raga 15', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f8bf585f-3f6f-4ded-a235-37b79e7b1278' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8bf585f-3f6f-4ded-a235-37b79e7b1278', 15, NULL, 'Raga 15', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8bf585f-3f6f-4ded-a235-37b79e7b1278'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Raga 16', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:12de6b82-cb71-4bde-963f-1abd9cb27c13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12de6b82-cb71-4bde-963f-1abd9cb27c13', 16, NULL, 'Raga 16', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12de6b82-cb71-4bde-963f-1abd9cb27c13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Raga 17', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 17',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:98a2216d-fbde-4fba-ad90-3a0bfabb8265' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:98a2216d-fbde-4fba-ad90-3a0bfabb8265', 17, NULL, 'Raga 17', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 17', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98a2216d-fbde-4fba-ad90-3a0bfabb8265'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Raga 18', part.name_en = 'Solo for Voice 58: 18 Microtonal Ragas: Raga 18',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:74fdb333-c6a3-44ac-b69e-98322682c05e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74fdb333-c6a3-44ac-b69e-98322682c05e', 18, NULL, 'Raga 18', 'Solo for Voice 58: 18 Microtonal Ragas: Raga 18', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d2310d7-92ed-46c6-b87a-4bccf3d5e3c8'
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74fdb333-c6a3-44ac-b69e-98322682c05e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 83', part.name_en = 'Solo for Voice 83',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:54be8525-2a42-44d4-b5d3-292da212cd8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54be8525-2a42-44d4-b5d3-292da212cd8c', 31, NULL, 'Solo for Voice 83', 'Solo for Voice 83', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54be8525-2a42-44d4-b5d3-292da212cd8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 76', part.name_en = 'Solo for Voice 76',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5601fd98-0463-4d85-a92a-358d7705b227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5601fd98-0463-4d85-a92a-358d7705b227', 32, NULL, 'Solo for Voice 76', 'Solo for Voice 76', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5601fd98-0463-4d85-a92a-358d7705b227'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 33, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 41', part.name_en = 'Solo for Voice 41',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:56ca2e04-70a9-4be9-882b-5aa47d09135f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56ca2e04-70a9-4be9-882b-5aa47d09135f', 33, NULL, 'Solo for Voice 41', 'Solo for Voice 41', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56ca2e04-70a9-4be9-882b-5aa47d09135f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 34, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 14', part.name_en = 'Solo for Voice 14',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:60da78c9-9c6d-4ca8-ba64-98ac672787ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60da78c9-9c6d-4ca8-ba64-98ac672787ee', 34, NULL, 'Solo for Voice 14', 'Solo for Voice 14', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60da78c9-9c6d-4ca8-ba64-98ac672787ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 35, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 27', part.name_en = 'Solo for Voice 27',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:64a73501-a375-4694-8a08-37462c47b32a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64a73501-a375-4694-8a08-37462c47b32a', 35, NULL, 'Solo for Voice 27', 'Solo for Voice 27', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64a73501-a375-4694-8a08-37462c47b32a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 36, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 53', part.name_en = 'Solo for Voice 53',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6697f505-ca90-4264-96e6-707f9c5084fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6697f505-ca90-4264-96e6-707f9c5084fa', 36, NULL, 'Solo for Voice 53', 'Solo for Voice 53', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6697f505-ca90-4264-96e6-707f9c5084fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 37, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 13', part.name_en = 'Solo for Voice 13',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6793d513-b496-49eb-a775-e72e2e0ca370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6793d513-b496-49eb-a775-e72e2e0ca370', 37, NULL, 'Solo for Voice 13', 'Solo for Voice 13', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6793d513-b496-49eb-a775-e72e2e0ca370'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 38, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 64', part.name_en = 'Solo for Voice 64',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:67b94579-b07a-4c43-a96c-45902b3d96aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67b94579-b07a-4c43-a96c-45902b3d96aa', 38, NULL, 'Solo for Voice 64', 'Solo for Voice 64', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67b94579-b07a-4c43-a96c-45902b3d96aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 39, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 79', part.name_en = 'Solo for Voice 79',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:67f173a9-3e74-4201-8ae1-ac8b840ef5ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f173a9-3e74-4201-8ae1-ac8b840ef5ce', 39, NULL, 'Solo for Voice 79', 'Solo for Voice 79', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f173a9-3e74-4201-8ae1-ac8b840ef5ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 40, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 74', part.name_en = 'Solo for Voice 74',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:68a7f0ac-a8e7-4fb9-baac-054b66186f94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68a7f0ac-a8e7-4fb9-baac-054b66186f94', 40, NULL, 'Solo for Voice 74', 'Solo for Voice 74', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68a7f0ac-a8e7-4fb9-baac-054b66186f94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 41, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 92', part.name_en = 'Solo for Voice 92',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6932c667-392c-4d44-9034-58f07cf48981' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6932c667-392c-4d44-9034-58f07cf48981', 41, NULL, 'Solo for Voice 92', 'Solo for Voice 92', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6932c667-392c-4d44-9034-58f07cf48981'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 42, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 7', part.name_en = 'Solo for Voice 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:72273065-8afb-4ef1-ab1f-2f0be4c2009a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72273065-8afb-4ef1-ab1f-2f0be4c2009a', 42, NULL, 'Solo for Voice 7', 'Solo for Voice 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72273065-8afb-4ef1-ab1f-2f0be4c2009a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 43, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 78', part.name_en = 'Solo for Voice 78',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:75564363-7025-4b3a-905a-5ab30c0b102d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75564363-7025-4b3a-905a-5ab30c0b102d', 43, NULL, 'Solo for Voice 78', 'Solo for Voice 78', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75564363-7025-4b3a-905a-5ab30c0b102d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 44, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 20', part.name_en = 'Solo for Voice 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:771e79c4-840e-42e0-9fc9-3dd6a254e993' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:771e79c4-840e-42e0-9fc9-3dd6a254e993', 44, NULL, 'Solo for Voice 20', 'Solo for Voice 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:771e79c4-840e-42e0-9fc9-3dd6a254e993'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 45, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 38', part.name_en = 'Solo for Voice 38',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:78a49246-ae3d-446a-abe0-1ef1dd46d68a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78a49246-ae3d-446a-abe0-1ef1dd46d68a', 45, NULL, 'Solo for Voice 38', 'Solo for Voice 38', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78a49246-ae3d-446a-abe0-1ef1dd46d68a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 46, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 71', part.name_en = 'Solo for Voice 71',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7c9dedd2-b015-47f8-80fe-db8c88ebe54e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c9dedd2-b015-47f8-80fe-db8c88ebe54e', 46, NULL, 'Solo for Voice 71', 'Solo for Voice 71', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c9dedd2-b015-47f8-80fe-db8c88ebe54e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 47, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 45', part.name_en = 'Solo for Voice 45',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7dad3e24-996b-4c73-8437-706d52ed2388' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dad3e24-996b-4c73-8437-706d52ed2388', 47, NULL, 'Solo for Voice 45', 'Solo for Voice 45', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dad3e24-996b-4c73-8437-706d52ed2388'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 48, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 82', part.name_en = 'Solo for Voice 82',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7de82172-9a88-40ef-96bd-ac692a49f2f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7de82172-9a88-40ef-96bd-ac692a49f2f0', 48, NULL, 'Solo for Voice 82', 'Solo for Voice 82', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7de82172-9a88-40ef-96bd-ac692a49f2f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 49, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 6', part.name_en = 'Solo for Voice 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7dedf146-6f47-4832-86f2-6f43a2b8b3ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dedf146-6f47-4832-86f2-6f43a2b8b3ac', 49, NULL, 'Solo for Voice 6', 'Solo for Voice 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dedf146-6f47-4832-86f2-6f43a2b8b3ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 50, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 86', part.name_en = 'Solo for Voice 86',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7ecddef4-8a8a-45de-b903-f355df9e8bde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ecddef4-8a8a-45de-b903-f355df9e8bde', 50, NULL, 'Solo for Voice 86', 'Solo for Voice 86', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ecddef4-8a8a-45de-b903-f355df9e8bde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 51, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 10', part.name_en = 'Solo for Voice 10',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7ef0fdea-c196-463f-a7b1-9fbda9a9d6ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ef0fdea-c196-463f-a7b1-9fbda9a9d6ec', 51, NULL, 'Solo for Voice 10', 'Solo for Voice 10', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ef0fdea-c196-463f-a7b1-9fbda9a9d6ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 52, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 25', part.name_en = 'Solo for Voice 25',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:81156dd0-19e8-4605-b965-9c9213a1a28b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81156dd0-19e8-4605-b965-9c9213a1a28b', 52, NULL, 'Solo for Voice 25', 'Solo for Voice 25', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81156dd0-19e8-4605-b965-9c9213a1a28b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 53, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 54', part.name_en = 'Solo for Voice 54',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:84fdf47c-84c4-4282-bede-6c1041b95e59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84fdf47c-84c4-4282-bede-6c1041b95e59', 53, NULL, 'Solo for Voice 54', 'Solo for Voice 54', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84fdf47c-84c4-4282-bede-6c1041b95e59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 54, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 57', part.name_en = 'Solo for Voice 57',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8d6480cf-de62-4f98-9c43-eb2134ad84ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d6480cf-de62-4f98-9c43-eb2134ad84ff', 54, NULL, 'Solo for Voice 57', 'Solo for Voice 57', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d6480cf-de62-4f98-9c43-eb2134ad84ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 55, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 47', part.name_en = 'Solo for Voice 47',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8fed650e-2ce7-4df8-bd0d-08316a5bcca2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fed650e-2ce7-4df8-bd0d-08316a5bcca2', 55, NULL, 'Solo for Voice 47', 'Solo for Voice 47', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fed650e-2ce7-4df8-bd0d-08316a5bcca2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 56, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 85', part.name_en = 'Solo for Voice 85',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:93053f38-9ef8-4574-8c83-a72dfdfa2523' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93053f38-9ef8-4574-8c83-a72dfdfa2523', 56, NULL, 'Solo for Voice 85', 'Solo for Voice 85', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93053f38-9ef8-4574-8c83-a72dfdfa2523'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 57, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 5', part.name_en = 'Solo for Voice 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:94aeeb82-5631-48dd-a60a-20ca72170fb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94aeeb82-5631-48dd-a60a-20ca72170fb5', 57, NULL, 'Solo for Voice 5', 'Solo for Voice 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94aeeb82-5631-48dd-a60a-20ca72170fb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 58, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 16', part.name_en = 'Solo for Voice 16',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:94b27c4b-d773-4b4c-b804-972773c62c65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94b27c4b-d773-4b4c-b804-972773c62c65', 58, NULL, 'Solo for Voice 16', 'Solo for Voice 16', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94b27c4b-d773-4b4c-b804-972773c62c65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 59, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 68', part.name_en = 'Solo for Voice 68',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:94c41dce-a916-4946-b1ff-18b85b045f53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94c41dce-a916-4946-b1ff-18b85b045f53', 59, NULL, 'Solo for Voice 68', 'Solo for Voice 68', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94c41dce-a916-4946-b1ff-18b85b045f53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 60, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 39', part.name_en = 'Solo for Voice 39',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:95491ef3-036c-4244-999b-f17d5c01a4b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95491ef3-036c-4244-999b-f17d5c01a4b6', 60, NULL, 'Solo for Voice 39', 'Solo for Voice 39', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95491ef3-036c-4244-999b-f17d5c01a4b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 61, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 56', part.name_en = 'Solo for Voice 56',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9bd062ef-c5e9-4922-8c43-2c569278cfc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bd062ef-c5e9-4922-8c43-2c569278cfc3', 61, NULL, 'Solo for Voice 56', 'Solo for Voice 56', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bd062ef-c5e9-4922-8c43-2c569278cfc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 62, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 81', part.name_en = 'Solo for Voice 81',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9c133c8b-6bea-47b0-abe5-d13752c01867' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c133c8b-6bea-47b0-abe5-d13752c01867', 62, NULL, 'Solo for Voice 81', 'Solo for Voice 81', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c133c8b-6bea-47b0-abe5-d13752c01867'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 63, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 34', part.name_en = 'Solo for Voice 34',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a466b0a4-d412-4d40-bc2f-3e395aef985c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a466b0a4-d412-4d40-bc2f-3e395aef985c', 63, NULL, 'Solo for Voice 34', 'Solo for Voice 34', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a466b0a4-d412-4d40-bc2f-3e395aef985c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 64, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 87', part.name_en = 'Solo for Voice 87',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a4749357-2eda-42c1-a9dc-aeed904a44a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4749357-2eda-42c1-a9dc-aeed904a44a0', 64, NULL, 'Solo for Voice 87', 'Solo for Voice 87', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4749357-2eda-42c1-a9dc-aeed904a44a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 65, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 37', part.name_en = 'Solo for Voice 37',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a76eb291-65bf-400e-baf7-3c8724f67dc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a76eb291-65bf-400e-baf7-3c8724f67dc2', 65, NULL, 'Solo for Voice 37', 'Solo for Voice 37', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a76eb291-65bf-400e-baf7-3c8724f67dc2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 66, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 42', part.name_en = 'Solo for Voice 42',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:aa74dec2-b186-4e17-b399-a465fb5e51aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa74dec2-b186-4e17-b399-a465fb5e51aa', 66, NULL, 'Solo for Voice 42', 'Solo for Voice 42', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa74dec2-b186-4e17-b399-a465fb5e51aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 67, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 40', part.name_en = 'Solo for Voice 40',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:af61ed0f-150a-426f-b951-0ee157dcf3f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af61ed0f-150a-426f-b951-0ee157dcf3f4', 67, NULL, 'Solo for Voice 40', 'Solo for Voice 40', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af61ed0f-150a-426f-b951-0ee157dcf3f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 68, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 21', part.name_en = 'Solo for Voice 21',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b1d0d528-59ff-48ce-826d-ed55a004ec42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1d0d528-59ff-48ce-826d-ed55a004ec42', 68, NULL, 'Solo for Voice 21', 'Solo for Voice 21', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d0d528-59ff-48ce-826d-ed55a004ec42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 69, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 36', part.name_en = 'Solo for Voice 36',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b2ea4f6a-1ab9-45f6-9c64-3b3ec6c70a41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2ea4f6a-1ab9-45f6-9c64-3b3ec6c70a41', 69, NULL, 'Solo for Voice 36', 'Solo for Voice 36', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2ea4f6a-1ab9-45f6-9c64-3b3ec6c70a41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 70, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 52 "Aria no. 2"', part.name_en = 'Solo for Voice 52 "Aria no. 2"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b8303959-8b37-4879-a24c-e9ad6a996f53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8303959-8b37-4879-a24c-e9ad6a996f53', 70, NULL, 'Solo for Voice 52 "Aria no. 2"', 'Solo for Voice 52 "Aria no. 2"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8303959-8b37-4879-a24c-e9ad6a996f53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 71, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 59', part.name_en = 'Solo for Voice 59',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:bb381850-31a9-4f3e-b715-1b57dbb89318' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb381850-31a9-4f3e-b715-1b57dbb89318', 71, NULL, 'Solo for Voice 59', 'Solo for Voice 59', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb381850-31a9-4f3e-b715-1b57dbb89318'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 72, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 61', part.name_en = 'Solo for Voice 61',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:bcd115ee-06a7-4219-afe5-69f17bed14fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcd115ee-06a7-4219-afe5-69f17bed14fa', 72, NULL, 'Solo for Voice 61', 'Solo for Voice 61', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcd115ee-06a7-4219-afe5-69f17bed14fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 73, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 48', part.name_en = 'Solo for Voice 48',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:bdc63c2a-b227-46ee-9f08-9c8f47623f82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdc63c2a-b227-46ee-9f08-9c8f47623f82', 73, NULL, 'Solo for Voice 48', 'Solo for Voice 48', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdc63c2a-b227-46ee-9f08-9c8f47623f82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 74, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 60', part.name_en = 'Solo for Voice 60',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c0298467-7de6-4988-9f0e-8c4d8838058d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0298467-7de6-4988-9f0e-8c4d8838058d', 74, NULL, 'Solo for Voice 60', 'Solo for Voice 60', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0298467-7de6-4988-9f0e-8c4d8838058d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 75, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 65', part.name_en = 'Solo for Voice 65',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cbb7b97e-d1fc-49b9-b838-bd8343672bee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbb7b97e-d1fc-49b9-b838-bd8343672bee', 75, NULL, 'Solo for Voice 65', 'Solo for Voice 65', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbb7b97e-d1fc-49b9-b838-bd8343672bee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 76, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 32', part.name_en = 'Solo for Voice 32',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cdc862a7-3033-4cb3-b4b1-d9eae3a5bb90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdc862a7-3033-4cb3-b4b1-d9eae3a5bb90', 76, NULL, 'Solo for Voice 32', 'Solo for Voice 32', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdc862a7-3033-4cb3-b4b1-d9eae3a5bb90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 77, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 88', part.name_en = 'Solo for Voice 88',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cde333e8-ba16-4927-bf7e-07f5053384aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cde333e8-ba16-4927-bf7e-07f5053384aa', 77, NULL, 'Solo for Voice 88', 'Solo for Voice 88', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cde333e8-ba16-4927-bf7e-07f5053384aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 78, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 43', part.name_en = 'Solo for Voice 43',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d1558c46-3292-4cfe-90b9-51ace7313e26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1558c46-3292-4cfe-90b9-51ace7313e26', 78, NULL, 'Solo for Voice 43', 'Solo for Voice 43', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1558c46-3292-4cfe-90b9-51ace7313e26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 79, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 84', part.name_en = 'Solo for Voice 84',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d3a468f1-73a8-4d8f-b335-cc627af9f86f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3a468f1-73a8-4d8f-b335-cc627af9f86f', 79, NULL, 'Solo for Voice 84', 'Solo for Voice 84', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3a468f1-73a8-4d8f-b335-cc627af9f86f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 80, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 30', part.name_en = 'Solo for Voice 30',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:dde871e6-8153-4078-ba41-129e278f184f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dde871e6-8153-4078-ba41-129e278f184f', 80, NULL, 'Solo for Voice 30', 'Solo for Voice 30', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dde871e6-8153-4078-ba41-129e278f184f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 81, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 49 "The Year Begins to Be Ripe"', part.name_en = 'Solo for Voice 49 "The Year Begins to Be Ripe"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e8a30de0-675d-4491-b6ab-843b24608af2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8a30de0-675d-4491-b6ab-843b24608af2', 81, NULL, 'Solo for Voice 49 "The Year Begins to Be Ripe"', 'Solo for Voice 49 "The Year Begins to Be Ripe"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8a30de0-675d-4491-b6ab-843b24608af2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 82, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 69', part.name_en = 'Solo for Voice 69',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ede5e0ec-a0bf-405a-8456-047bac16c6d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ede5e0ec-a0bf-405a-8456-047bac16c6d7', 82, NULL, 'Solo for Voice 69', 'Solo for Voice 69', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ede5e0ec-a0bf-405a-8456-047bac16c6d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 83, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 8', part.name_en = 'Solo for Voice 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f023a9f4-1b53-4d9f-9da8-8271faecc77d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f023a9f4-1b53-4d9f-9da8-8271faecc77d', 83, NULL, 'Solo for Voice 8', 'Solo for Voice 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f023a9f4-1b53-4d9f-9da8-8271faecc77d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 84, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 46', part.name_en = 'Solo for Voice 46',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f16c43cd-462d-4281-b898-a737c356be08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f16c43cd-462d-4281-b898-a737c356be08', 84, NULL, 'Solo for Voice 46', 'Solo for Voice 46', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f16c43cd-462d-4281-b898-a737c356be08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 85, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 44', part.name_en = 'Solo for Voice 44',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f1ab67d4-cc6b-4ff5-97b0-6e7404a6b45a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1ab67d4-cc6b-4ff5-97b0-6e7404a6b45a', 85, NULL, 'Solo for Voice 44', 'Solo for Voice 44', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1ab67d4-cc6b-4ff5-97b0-6e7404a6b45a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 86, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 77', part.name_en = 'Solo for Voice 77',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f28d1277-6384-489d-b930-cbaed484dbec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f28d1277-6384-489d-b930-cbaed484dbec', 86, NULL, 'Solo for Voice 77', 'Solo for Voice 77', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f28d1277-6384-489d-b930-cbaed484dbec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 87, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 75', part.name_en = 'Solo for Voice 75',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f68ef4b2-ac00-4a54-a48c-cd6e3c77e9e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f68ef4b2-ac00-4a54-a48c-cd6e3c77e9e3', 87, NULL, 'Solo for Voice 75', 'Solo for Voice 75', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f68ef4b2-ac00-4a54-a48c-cd6e3c77e9e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 88, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 15', part.name_en = 'Solo for Voice 15',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f810fe5a-0d66-421d-a2de-d8226b0a4560' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f810fe5a-0d66-421d-a2de-d8226b0a4560', 88, NULL, 'Solo for Voice 15', 'Solo for Voice 15', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f810fe5a-0d66-421d-a2de-d8226b0a4560'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 89, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 91', part.name_en = 'Solo for Voice 91',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:fabffd57-286d-4ce4-956b-45f282c464b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fabffd57-286d-4ce4-956b-45f282c464b5', 89, NULL, 'Solo for Voice 91', 'Solo for Voice 91', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fabffd57-286d-4ce4-956b-45f282c464b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 90, part.movement_number = NULL,
    part.name_ko = 'Solo for Voice 19', part.name_en = 'Solo for Voice 19',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1026 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:fe56bfef-6607-4908-9fcc-360056db9810' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe56bfef-6607-4908-9fcc-360056db9810', 90, NULL, 'Solo for Voice 19', 'Solo for Voice 19', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1026 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe56bfef-6607-4908-9fcc-360056db9810'
);


-- None Sonnekus²

UPDATE pieces piece
SET piece.title = 'Sonnekus²', piece.title_en = 'Sonnekus²',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 650 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Souvenir

UPDATE pieces piece
SET piece.title = 'Souvenir', piece.title_en = 'Souvenir',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2822 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Spontaneous Earth

UPDATE pieces piece
SET piece.title = 'Spontaneous Earth', piece.title_en = 'Spontaneous Earth',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2994 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None String Quartet in four parts

UPDATE pieces piece
SET piece.title = 'String Quartet in four parts', piece.title_en = 'String Quartet in four parts',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2765 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Quietly Flowing Along', part.name_en = 'String Quartet in four parts: I. Quietly Flowing Along',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2765 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c3f9d949-0193-4870-990f-bd00b1f5efd2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3f9d949-0193-4870-990f-bd00b1f5efd2', 1, 'I', 'Quietly Flowing Along', 'String Quartet in four parts: I. Quietly Flowing Along', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2765 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3f9d949-0193-4870-990f-bd00b1f5efd2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Slowly Rocking', part.name_en = 'String Quartet in four parts: II. Slowly Rocking',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2765 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7e24491e-9f45-48a7-8025-5714da4baf5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e24491e-9f45-48a7-8025-5714da4baf5e', 2, 'II', 'Slowly Rocking', 'String Quartet in four parts: II. Slowly Rocking', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2765 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e24491e-9f45-48a7-8025-5714da4baf5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nearly Stationary', part.name_en = 'String Quartet in four parts: III. Nearly Stationary',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2765 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e4e11c37-c9d0-4d12-831c-04a696fde073' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4e11c37-c9d0-4d12-831c-04a696fde073', 3, 'III', 'Nearly Stationary', 'String Quartet in four parts: III. Nearly Stationary', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2765 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e11c37-c9d0-4d12-831c-04a696fde073'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Quodlibet', part.name_en = 'String Quartet in four parts: IV. Quodlibet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2765 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9e63249c-ee46-4102-b85a-709866dbaad9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e63249c-ee46-4102-b85a-709866dbaad9', 4, 'IV', 'Quodlibet', 'String Quartet in four parts: IV. Quodlibet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2765 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e63249c-ee46-4102-b85a-709866dbaad9'
);


-- None Suite for Toy Harp

UPDATE pieces piece
SET piece.title = 'Suite for Toy Harp', piece.title_en = 'Suite for Toy Harp',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2359 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '𝅗𝅥 = 64', part.name_en = 'Suite for Toy Harp: I. 𝅗𝅥 = 64',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2359 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ed8ae4cc-0cc8-46ff-984e-d280238604dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed8ae4cc-0cc8-46ff-984e-d280238604dc', 1, 'I', '𝅗𝅥 = 64', 'Suite for Toy Harp: I. 𝅗𝅥 = 64', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2359 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed8ae4cc-0cc8-46ff-984e-d280238604dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Same Speed', part.name_en = 'Suite for Toy Harp: II. Same Speed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2359 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:eec3c867-6fa9-4536-b6fc-0606d2adf705' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eec3c867-6fa9-4536-b6fc-0606d2adf705', 2, 'II', 'Same Speed', 'Suite for Toy Harp: II. Same Speed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2359 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eec3c867-6fa9-4536-b6fc-0606d2adf705'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Slower', part.name_en = 'Suite for Toy Harp: III. Slower',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2359 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:66af3de2-88e4-4e76-8e3f-316c381e533c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66af3de2-88e4-4e76-8e3f-316c381e533c', 3, 'III', 'Slower', 'Suite for Toy Harp: III. Slower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2359 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66af3de2-88e4-4e76-8e3f-316c381e533c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Same tempo of III', part.name_en = 'Suite for Toy Harp: IV. Same tempo of III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2359 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:267a6847-a12b-4f1d-9b91-4d25cad77fce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:267a6847-a12b-4f1d-9b91-4d25cad77fce', 4, 'IV', 'Same tempo of III', 'Suite for Toy Harp: IV. Same tempo of III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2359 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:267a6847-a12b-4f1d-9b91-4d25cad77fce'
);


-- None TV Koln

UPDATE pieces piece
SET piece.title = 'TV Koln', piece.title_en = 'TV Koln',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1978 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ten

UPDATE pieces piece
SET piece.title = 'Ten', piece.title_en = 'Ten',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2978 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Beatles 1962-1970

UPDATE pieces piece
SET piece.title = 'The Beatles 1962-1970', piece.title_en = 'The Beatles 1962-1970',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2019 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <The City Wears a Slouch Hat>

UPDATE pieces piece
SET piece.title = '부수음악 <The City Wears a Slouch Hat>', piece.title_en = 'The City Wears a Slouch Hat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1095 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Perilous Night

UPDATE pieces piece
SET piece.title = 'The Perilous Night', piece.title_en = 'The Perilous Night',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2817 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'The Perilous Night: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2817 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:03d7a415-e079-37b6-a036-dcded663a7e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03d7a415-e079-37b6-a036-dcded663a7e4', 1, NULL, 'I', 'The Perilous Night: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2817 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d7a415-e079-37b6-a036-dcded663a7e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'The Perilous Night: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2817 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2f509e97-45bc-3ff8-ac8f-2f900e7641ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f509e97-45bc-3ff8-ac8f-2f900e7641ed', 2, NULL, 'II', 'The Perilous Night: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2817 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f509e97-45bc-3ff8-ac8f-2f900e7641ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'The Perilous Night: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2817 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2b846655-dcfe-305b-b9b0-d3ac5ed1e25b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b846655-dcfe-305b-b9b0-d3ac5ed1e25b', 3, NULL, 'III', 'The Perilous Night: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2817 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b846655-dcfe-305b-b9b0-d3ac5ed1e25b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'The Perilous Night: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2817 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a0eb938f-3da9-34b1-97e6-c3348502e37c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0eb938f-3da9-34b1-97e6-c3348502e37c', 4, NULL, 'IV', 'The Perilous Night: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2817 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0eb938f-3da9-34b1-97e6-c3348502e37c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'The Perilous Night: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2817 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:077208f5-3d78-37d3-8cdb-c6da45065cb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:077208f5-3d78-37d3-8cdb-c6da45065cb0', 5, NULL, 'V', 'The Perilous Night: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2817 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:077208f5-3d78-37d3-8cdb-c6da45065cb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'The Perilous Night: VI.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2817 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:609479a6-78f6-34d8-a54c-81d0d898646c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:609479a6-78f6-34d8-a54c-81d0d898646c', 6, NULL, 'VI', 'The Perilous Night: VI.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2817 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:609479a6-78f6-34d8-a54c-81d0d898646c'
);


-- None 발레 <The Seasons>

UPDATE pieces piece
SET piece.title = '발레 <The Seasons>', piece.title_en = 'The Seasons',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1160 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude I', part.name_en = 'The Seasons: Prelude I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1164c14d-4c9c-4814-add5-d3e7724d80b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1164c14d-4c9c-4814-add5-d3e7724d80b8', 1, NULL, 'Prelude I', 'The Seasons: Prelude I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1164c14d-4c9c-4814-add5-d3e7724d80b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Winter', part.name_en = 'The Seasons: Winter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:099fca0d-f744-4192-ac60-c9c145f9d7ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:099fca0d-f744-4192-ac60-c9c145f9d7ff', 2, NULL, 'Winter', 'The Seasons: Winter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:099fca0d-f744-4192-ac60-c9c145f9d7ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prelude II', part.name_en = 'The Seasons: Prelude II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9dd370aa-d304-47b6-afd0-25eadd284523' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dd370aa-d304-47b6-afd0-25eadd284523', 3, NULL, 'Prelude II', 'The Seasons: Prelude II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dd370aa-d304-47b6-afd0-25eadd284523'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Spring', part.name_en = 'The Seasons: Spring',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:e758ed03-4fc7-489c-b983-0d51dd74f1d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e758ed03-4fc7-489c-b983-0d51dd74f1d2', 4, NULL, 'Spring', 'The Seasons: Spring', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e758ed03-4fc7-489c-b983-0d51dd74f1d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Prelude III', part.name_en = 'The Seasons: Prelude III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:fc1accce-f058-49c6-83fa-9cfdb2b61663' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc1accce-f058-49c6-83fa-9cfdb2b61663', 5, NULL, 'Prelude III', 'The Seasons: Prelude III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc1accce-f058-49c6-83fa-9cfdb2b61663'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Summer', part.name_en = 'The Seasons: Summer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:3bab54b7-ac41-4aa2-80ac-b1ce3acd598f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bab54b7-ac41-4aa2-80ac-b1ce3acd598f', 6, NULL, 'Summer', 'The Seasons: Summer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bab54b7-ac41-4aa2-80ac-b1ce3acd598f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Prelude IV', part.name_en = 'The Seasons: Prelude IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1d287d4d-bb08-4e40-a4dc-d5ff62614c78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d287d4d-bb08-4e40-a4dc-d5ff62614c78', 7, NULL, 'Prelude IV', 'The Seasons: Prelude IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d287d4d-bb08-4e40-a4dc-d5ff62614c78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Fall', part.name_en = 'The Seasons: Fall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a0b9ab18-ce1c-42e2-a5aa-19b6e6996fb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b9ab18-ce1c-42e2-a5aa-19b6e6996fb8', 8, NULL, 'Fall', 'The Seasons: Fall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b9ab18-ce1c-42e2-a5aa-19b6e6996fb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Finale (Prelude I)', part.name_en = 'The Seasons: Finale (Prelude I)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1160 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:25643a8f-9024-490d-95dd-e5cb4288b338' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25643a8f-9024-490d-95dd-e5cb4288b338', 9, NULL, 'Finale (Prelude I)', 'The Seasons: Finale (Prelude I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1160 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25643a8f-9024-490d-95dd-e5cb4288b338'
);


-- None The Unavailable Memory Of

UPDATE pieces piece
SET piece.title = 'The Unavailable Memory Of', piece.title_en = 'The Unavailable Memory Of',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 573 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Wonderful Widow of Eighteen Springs

UPDATE pieces piece
SET piece.title = 'The Wonderful Widow of Eighteen Springs', piece.title_en = 'The Wonderful Widow of Eighteen Springs',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1292 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Third Construction

UPDATE pieces piece
SET piece.title = 'Third Construction', piece.title_en = 'Third Construction',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2542 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thirteen

UPDATE pieces piece
SET piece.title = 'Thirteen', piece.title_en = 'Thirteen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1377 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thirty Pieces for Five Orchestras

UPDATE pieces piece
SET piece.title = 'Thirty Pieces for Five Orchestras', piece.title_en = 'Thirty Pieces for Five Orchestras',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 974 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thirty Pieces for String Quartet

UPDATE pieces piece
SET piece.title = 'Thirty Pieces for String Quartet', piece.title_en = 'Thirty Pieces for String Quartet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2565 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three

UPDATE pieces piece
SET piece.title = 'Three', piece.title_en = 'Three',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1841 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1', part.name_en = 'Three: 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5659e275-e540-4379-89ff-cc92635ecbe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5659e275-e540-4379-89ff-cc92635ecbe4', 1, NULL, '1', 'Three: 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5659e275-e540-4379-89ff-cc92635ecbe4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A', part.name_en = 'Three: A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a514e538-8445-495a-a193-1909ba8d38e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a514e538-8445-495a-a193-1909ba8d38e8', 2, NULL, 'A', 'Three: A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a514e538-8445-495a-a193-1909ba8d38e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'B', part.name_en = 'Three: B',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4a569158-814d-4a56-8a69-d9d96d9ab3f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a569158-814d-4a56-8a69-d9d96d9ab3f2', 3, NULL, 'B', 'Three: B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a569158-814d-4a56-8a69-d9d96d9ab3f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C', part.name_en = 'Three: C',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:059f5faf-4a42-498a-b5a4-982a8ec34f1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:059f5faf-4a42-498a-b5a4-982a8ec34f1c', 4, NULL, 'C', 'Three: C', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:059f5faf-4a42-498a-b5a4-982a8ec34f1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'D', part.name_en = 'Three: D',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:70113b75-ea8c-45cb-861a-6dc59667ebac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70113b75-ea8c-45cb-861a-6dc59667ebac', 5, NULL, 'D', 'Three: D', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70113b75-ea8c-45cb-861a-6dc59667ebac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'E', part.name_en = 'Three: E',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:61d273c4-275a-48f8-b591-9fa53a763e84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61d273c4-275a-48f8-b591-9fa53a763e84', 6, NULL, 'E', 'Three: E', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61d273c4-275a-48f8-b591-9fa53a763e84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'F', part.name_en = 'Three: F',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1ab894ea-3208-4781-a4ef-5effaeb024cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ab894ea-3208-4781-a4ef-5effaeb024cb', 7, NULL, 'F', 'Three: F', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab894ea-3208-4781-a4ef-5effaeb024cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'G', part.name_en = 'Three: G',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1aa353f5-ae62-4090-b2f6-fe6ae1c69e16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aa353f5-ae62-4090-b2f6-fe6ae1c69e16', 8, NULL, 'G', 'Three: G', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aa353f5-ae62-4090-b2f6-fe6ae1c69e16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'H', part.name_en = 'Three: H',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:676d6f96-166f-44f4-8d7c-96d9e6e66770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:676d6f96-166f-44f4-8d7c-96d9e6e66770', 9, NULL, 'H', 'Three: H', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:676d6f96-166f-44f4-8d7c-96d9e6e66770'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Three: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f3d4dc3c-d1f0-453f-a0f4-de1bfdd0e4ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3d4dc3c-d1f0-453f-a0f4-de1bfdd0e4ba', 10, NULL, 'I', 'Three: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3d4dc3c-d1f0-453f-a0f4-de1bfdd0e4ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Three: 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1841 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:7a37b6e9-83db-424d-8b4b-b482351def39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a37b6e9-83db-424d-8b4b-b482351def39', 11, NULL, '2', 'Three: 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1841 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a37b6e9-83db-424d-8b4b-b482351def39'
);


-- None Three Easy Pieces

UPDATE pieces piece
SET piece.title = 'Three Easy Pieces', piece.title_en = 'Three Easy Pieces',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1265 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Infinite Canon (For C.M.)', part.name_en = 'Three Easy Pieces: Infinite Canon (For C.M.)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1265 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:10a0e549-82d1-4ab7-88ee-86abc07b83d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10a0e549-82d1-4ab7-88ee-86abc07b83d0', 1, NULL, 'Infinite Canon (For C.M.)', 'Three Easy Pieces: Infinite Canon (For C.M.)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1265 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10a0e549-82d1-4ab7-88ee-86abc07b83d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Duo (For M.M.)', part.name_en = 'Three Easy Pieces: Duo (For M.M.)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1265 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:66d92e39-b787-4116-b207-98841bb751ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66d92e39-b787-4116-b207-98841bb751ef', 2, NULL, 'Duo (For M.M.)', 'Three Easy Pieces: Duo (For M.M.)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1265 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66d92e39-b787-4116-b207-98841bb751ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Round (For E.P.S.)', part.name_en = 'Three Easy Pieces: Round (For E.P.S.)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1265 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d2f040ac-03e9-48a0-bb95-bbdb783c4e27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2f040ac-03e9-48a0-bb95-bbdb783c4e27', 3, NULL, 'Round (For E.P.S.)', 'Three Easy Pieces: Round (For E.P.S.)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1265 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2f040ac-03e9-48a0-bb95-bbdb783c4e27'
);


-- None 3개의 가곡

UPDATE pieces piece
SET piece.title = '3개의 가곡', piece.title_en = 'Three Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2452 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Twenty years after', part.name_en = 'Three Songs: No. 1. Twenty years after',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6ee0204f-6b85-4b49-bd86-e86f1e654e8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ee0204f-6b85-4b49-bd86-e86f1e654e8d', 1, NULL, 'Twenty years after', 'Three Songs: No. 1. Twenty years after', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ee0204f-6b85-4b49-bd86-e86f1e654e8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'If it was to be', part.name_en = 'Three Songs: No. 2. If it was to be',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:bc1c6128-ce79-42c4-9103-5d12f32f149b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc1c6128-ce79-42c4-9103-5d12f32f149b', 2, NULL, 'If it was to be', 'Three Songs: No. 2. If it was to be', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc1c6128-ce79-42c4-9103-5d12f32f149b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'At East and ingredients', part.name_en = 'Three Songs: No. 3. At East and ingredients',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2452 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a63bfd4f-c0c0-4ce8-bb85-c647f03c5297' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a63bfd4f-c0c0-4ce8-bb85-c647f03c5297', 3, NULL, 'At East and ingredients', 'Three Songs: No. 3. At East and ingredients', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2452 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a63bfd4f-c0c0-4ce8-bb85-c647f03c5297'
);


-- None Three²

UPDATE pieces piece
SET piece.title = 'Three²', piece.title_en = 'Three²',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2048 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tossed as It Is Untroubled (Meditation)

UPDATE pieces piece
SET piece.title = 'Tossed as It Is Untroubled (Meditation)', piece.title_en = 'Tossed as It Is Untroubled (Meditation)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 636 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trio

UPDATE pieces piece
SET piece.title = 'Trio', piece.title_en = 'Trio',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1770 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Trio: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1770 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8ea0b03c-3c54-44e8-afee-ec02db7016f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ea0b03c-3c54-44e8-afee-ec02db7016f9', 1, 'I', 'Allegro', 'Trio: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1770 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ea0b03c-3c54-44e8-afee-ec02db7016f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'March', part.name_en = 'Trio: II. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1770 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:2779cd31-2662-4442-a068-932424228eb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2779cd31-2662-4442-a068-932424228eb2', 2, 'II', 'March', 'Trio: II. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1770 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2779cd31-2662-4442-a068-932424228eb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Waltz', part.name_en = 'Trio: III. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1770 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:893a6559-4c03-4815-9c0b-087191ce3913' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:893a6559-4c03-4815-9c0b-087191ce3913', 3, 'III', 'Waltz', 'Trio: III. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1770 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:893a6559-4c03-4815-9c0b-087191ce3913'
);


-- None Twenty-Eight

UPDATE pieces piece
SET piece.title = 'Twenty-Eight', piece.title_en = 'Twenty-Eight',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2034 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Twenty-Nine

UPDATE pieces piece
SET piece.title = 'Twenty-Nine', piece.title_en = 'Twenty-Nine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2331 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Twenty-Six

UPDATE pieces piece
SET piece.title = 'Twenty-Six', piece.title_en = 'Twenty-Six',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1622 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Twenty-Three

UPDATE pieces piece
SET piece.title = 'Twenty-Three', piece.title_en = 'Twenty-Three',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2956 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two

UPDATE pieces piece
SET piece.title = 'Two', piece.title_en = 'Two',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2521 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 2개의 파스토랄

UPDATE pieces piece
SET piece.title = '2개의 파스토랄', piece.title_en = 'Two Pastorales',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1427 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Two Pastorales: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1427 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b63800f1-9006-3914-b1ec-8c30420f6be8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b63800f1-9006-3914-b1ec-8c30420f6be8', 1, NULL, 'No. 1', 'Two Pastorales: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1427 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b63800f1-9006-3914-b1ec-8c30420f6be8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Two Pastorales: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1427 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:f5b7507b-a703-3f2a-bf6c-5a13a90de504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5b7507b-a703-3f2a-bf6c-5a13a90de504', 2, NULL, 'No. 2', 'Two Pastorales: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1427 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5b7507b-a703-3f2a-bf6c-5a13a90de504'
);


-- None Two²

UPDATE pieces piece
SET piece.title = 'Two²', piece.title_en = 'Two²',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2010 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two³

UPDATE pieces piece
SET piece.title = 'Two³', piece.title_en = 'Two³',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2724 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1', part.name_en = 'Two³: 1.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:cf264f04-74f4-47db-b1ff-ae1096fa9935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf264f04-74f4-47db-b1ff-ae1096fa9935', 1, NULL, '1', 'Two³: 1.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf264f04-74f4-47db-b1ff-ae1096fa9935'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2', part.name_en = 'Two³: 2.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:c835b92c-1fc3-49fa-8cc1-146796b21d2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c835b92c-1fc3-49fa-8cc1-146796b21d2e', 2, NULL, '2', 'Two³: 2.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c835b92c-1fc3-49fa-8cc1-146796b21d2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3', part.name_en = 'Two³: 3.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:a25cf661-a375-4327-98f1-d366944dbd80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a25cf661-a375-4327-98f1-d366944dbd80', 3, NULL, '3', 'Two³: 3.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a25cf661-a375-4327-98f1-d366944dbd80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '4', part.name_en = 'Two³: 4.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:5174a95d-dc8c-4ef4-b7f2-88c231d9f5f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5174a95d-dc8c-4ef4-b7f2-88c231d9f5f0', 4, NULL, '4', 'Two³: 4.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5174a95d-dc8c-4ef4-b7f2-88c231d9f5f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '5', part.name_en = 'Two³: 5.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:8102f132-817f-4d9a-8d57-4934cf497986' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8102f132-817f-4d9a-8d57-4934cf497986', 5, NULL, '5', 'Two³: 5.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8102f132-817f-4d9a-8d57-4934cf497986'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '6', part.name_en = 'Two³: 6.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:6181b115-1243-4f5f-bfbd-3e05e9a2f1c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6181b115-1243-4f5f-bfbd-3e05e9a2f1c1', 6, NULL, '6', 'Two³: 6.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6181b115-1243-4f5f-bfbd-3e05e9a2f1c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '7', part.name_en = 'Two³: 7.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4e7735b2-5405-4970-8dbb-2844aca6215b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7735b2-5405-4970-8dbb-2844aca6215b', 7, NULL, '7', 'Two³: 7.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7735b2-5405-4970-8dbb-2844aca6215b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '8', part.name_en = 'Two³: 8.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:b5deccaf-781c-42d2-b86d-e1d85a752912' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5deccaf-781c-42d2-b86d-e1d85a752912', 8, NULL, '8', 'Two³: 8.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5deccaf-781c-42d2-b86d-e1d85a752912'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '9', part.name_en = 'Two³: 9.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:75cb9308-f613-445e-969c-6c5b2a0262a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75cb9308-f613-445e-969c-6c5b2a0262a4', 9, NULL, '9', 'Two³: 9.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75cb9308-f613-445e-969c-6c5b2a0262a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '10', part.name_en = 'Two³: 10.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2724 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:9ebc4f35-55d7-4cdd-9bb4-f4df48a64a5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ebc4f35-55d7-4cdd-9bb4-f4df48a64a5c', 10, NULL, '10', 'Two³: 10.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2724 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ebc4f35-55d7-4cdd-9bb4-f4df48a64a5c'
);


-- None Two⁴

UPDATE pieces piece
SET piece.title = 'Two⁴', piece.title_en = 'Two⁴',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1707 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '(sho)', part.name_en = 'Two⁴: I. (sho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1707 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:20ab8d01-22aa-4b54-ad01-d6692358bdcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20ab8d01-22aa-4b54-ad01-d6692358bdcf', 1, 'I', '(sho)', 'Two⁴: I. (sho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1707 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20ab8d01-22aa-4b54-ad01-d6692358bdcf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'I',
    part.name_ko = '(violin)', part.name_en = 'Two⁴: I. (violin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1707 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:ab898c2b-eefc-4830-99c1-434d17525318' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab898c2b-eefc-4830-99c1-434d17525318', 2, 'I', '(violin)', 'Two⁴: I. (violin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1707 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab898c2b-eefc-4830-99c1-434d17525318'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'II',
    part.name_ko = '(sho)', part.name_en = 'Two⁴: II. (sho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1707 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:4d6181e8-678a-4e07-a89d-047e3b9ec04c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d6181e8-678a-4e07-a89d-047e3b9ec04c', 3, 'II', '(sho)', 'Two⁴: II. (sho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1707 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d6181e8-678a-4e07-a89d-047e3b9ec04c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = '(violin)', part.name_en = 'Two⁴: II. (violin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1707 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:fba49d59-546c-4471-bef3-5880671daa97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fba49d59-546c-4471-bef3-5880671daa97', 4, 'II', '(violin)', 'Two⁴: II. (violin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1707 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba49d59-546c-4471-bef3-5880671daa97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'III',
    part.name_ko = '(sho)', part.name_en = 'Two⁴: III. (sho)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1707 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:d1d6dd9d-d5c4-4343-a095-1cac545f08db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1d6dd9d-d5c4-4343-a095-1cac545f08db', 5, 'III', '(sho)', 'Two⁴: III. (sho)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1707 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1d6dd9d-d5c4-4343-a095-1cac545f08db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'III',
    part.name_ko = '(violin)', part.name_en = 'Two⁴: III. (violin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1707 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:1b143b15-0a76-4608-afdd-a19ab075005f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b143b15-0a76-4608-afdd-a19ab075005f', 6, 'III', '(violin)', 'Two⁴: III. (violin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1707 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b143b15-0a76-4608-afdd-a19ab075005f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'IV',
    part.name_ko = '(violin)', part.name_en = 'Two⁴: IV. (violin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1707 AND p.composer_id = 92 AND part.part_key = 'musicbrainz:74b9e014-9aa1-403b-8d0d-a722fd541603' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74b9e014-9aa1-403b-8d0d-a722fd541603', 7, 'IV', '(violin)', 'Two⁴: IV. (violin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1707 AND p.composer_id = 92
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74b9e014-9aa1-403b-8d0d-a722fd541603'
);


-- None Two⁵

UPDATE pieces piece
SET piece.title = 'Two⁵', piece.title_en = 'Two⁵',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1889 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two⁶

UPDATE pieces piece
SET piece.title = 'Two⁶', piece.title_en = 'Two⁶',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1754 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations I

UPDATE pieces piece
SET piece.title = 'Variations I', piece.title_en = 'Variations I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2594 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations III

UPDATE pieces piece
SET piece.title = 'Variations III', piece.title_en = 'Variations III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2321 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations IV

UPDATE pieces piece
SET piece.title = 'Variations IV', piece.title_en = 'Variations IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2424 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations V

UPDATE pieces piece
SET piece.title = 'Variations V', piece.title_en = 'Variations V',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 885 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations VI

UPDATE pieces piece
SET piece.title = 'Variations VI', piece.title_en = 'Variations VI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2566 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations VII

UPDATE pieces piece
SET piece.title = 'Variations VII', piece.title_en = 'Variations VII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2294 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations VIII

UPDATE pieces piece
SET piece.title = 'Variations VIII', piece.title_en = 'Variations VIII',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1339 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Voiceless Essay

UPDATE pieces piece
SET piece.title = 'Voiceless Essay', piece.title_en = 'Voiceless Essay',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1329 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None WBAI

UPDATE pieces piece
SET piece.title = 'WBAI', piece.title_en = 'WBAI',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2796 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Waiting

UPDATE pieces piece
SET piece.title = 'Waiting', piece.title_en = 'Waiting',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1222 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Water Music

UPDATE pieces piece
SET piece.title = 'Water Music', piece.title_en = 'Water Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2530 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Williams Mix

UPDATE pieces piece
SET piece.title = 'Williams Mix', piece.title_en = 'Williams Mix',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2047 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Winter Music

UPDATE pieces piece
SET piece.title = 'Winter Music', piece.title_en = 'Winter Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1763 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None ear for EAR

UPDATE pieces piece
SET piece.title = 'ear for EAR', piece.title_en = 'ear for EAR',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1866 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None ¢Composed Improvisation

UPDATE pieces piece
SET piece.title = '¢Composed Improvisation', piece.title_en = '¢Composed Improvisation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 608 AND piece.composer_id = 92
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dream

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Dream', 'Dream', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Dream'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61cc1e22-28c3-4448-ab22-29ab2581444b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61cc1e22-28c3-4448-ab22-29ab2581444b'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Dream' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61cc1e22-28c3-4448-ab22-29ab2581444b'
);


-- None Eight Whiskus

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Eight Whiskus', 'Eight Whiskus', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Eight Whiskus'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '119a3e18-ed59-4cfa-978c-79b84ae97648'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '119a3e18-ed59-4cfa-978c-79b84ae97648'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Eight Whiskus' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '119a3e18-ed59-4cfa-978c-79b84ae97648'
);


-- None In a Landscape

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'In a Landscape', 'In a Landscape', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'In a Landscape'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a1fc308-f90e-306e-9507-1894e772c8e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a1fc308-f90e-306e-9507-1894e772c8e2'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'In a Landscape' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a1fc308-f90e-306e-9507-1894e772c8e2'
);


-- None Metamorphosis

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Metamorphosis', 'Metamorphosis', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Metamorphosis'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be6c508d-d04c-4f22-8aa4-55fa8e7e8d17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be6c508d-d04c-4f22-8aa4-55fa8e7e8d17'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Metamorphosis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be6c508d-d04c-4f22-8aa4-55fa8e7e8d17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4f3457f-10be-452a-92be-518d946e48ad', 1, NULL, 'I', 'Metamorphosis: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Metamorphosis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4f3457f-10be-452a-92be-518d946e48ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0111213-08b0-4cbf-8a4e-d3c0884d0ad3', 2, NULL, 'II', 'Metamorphosis: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Metamorphosis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0111213-08b0-4cbf-8a4e-d3c0884d0ad3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1543b020-e2e4-41f5-899c-37430e20b114', 3, NULL, 'III', 'Metamorphosis: III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Metamorphosis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1543b020-e2e4-41f5-899c-37430e20b114'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16524f53-dd7c-4f40-adbf-9f4d1597dbfd', 4, NULL, 'IV', 'Metamorphosis: IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Metamorphosis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16524f53-dd7c-4f40-adbf-9f4d1597dbfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a606117-b8eb-422e-b71a-600061eddfe2', 5, NULL, 'V', 'Metamorphosis: V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Metamorphosis' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a606117-b8eb-422e-b71a-600061eddfe2'
);


-- None Music for Marcel Duchamp

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Music for Marcel Duchamp', 'Music for Marcel Duchamp', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Music for Marcel Duchamp'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf6fccf1-4e3c-387f-93fc-a9d1b6823e43'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf6fccf1-4e3c-387f-93fc-a9d1b6823e43'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Music for Marcel Duchamp' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf6fccf1-4e3c-387f-93fc-a9d1b6823e43'
);


-- None One

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'One', 'One', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'One'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3dfcda2-5762-46a8-8644-9431727925dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3dfcda2-5762-46a8-8644-9431727925dc'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'One' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3dfcda2-5762-46a8-8644-9431727925dc'
);


-- None She Is Asleep

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'She Is Asleep', 'She Is Asleep', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'She Is Asleep'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc7acfec-bd89-4535-b207-18c35114eb91'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc7acfec-bd89-4535-b207-18c35114eb91'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'She Is Asleep' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc7acfec-bd89-4535-b207-18c35114eb91'
);


-- None Soliloquy

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Soliloquy', 'Soliloquy', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Soliloquy'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6461f10-cf7b-483b-8c9b-ddae61701899'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f6461f10-cf7b-483b-8c9b-ddae61701899'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Soliloquy' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6461f10-cf7b-483b-8c9b-ddae61701899'
);


-- None Suite for Toy Piano

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Suite for Toy Piano', 'Suite for Toy Piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Suite for Toy Piano'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b824539-0aa1-40a9-a137-7e5ba14eb6a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b824539-0aa1-40a9-a137-7e5ba14eb6a4'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Suite for Toy Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b824539-0aa1-40a9-a137-7e5ba14eb6a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bd05d51-3f65-4a13-a565-7e8099af1d1f', 1, NULL, 'I', 'Suite for Toy Piano: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Suite for Toy Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bd05d51-3f65-4a13-a565-7e8099af1d1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bb0faa0-503c-4eca-85ce-1dac1a6f2acc', 2, NULL, 'II', 'Suite for Toy Piano: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Suite for Toy Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bb0faa0-503c-4eca-85ce-1dac1a6f2acc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22eaf2ec-cc5b-469e-a90c-d2ccd40d61f4', 3, NULL, 'III', 'Suite for Toy Piano: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Suite for Toy Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22eaf2ec-cc5b-469e-a90c-d2ccd40d61f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f371520e-f4a7-4779-9f98-90354d07cfc6', 4, NULL, 'IV', 'Suite for Toy Piano: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Suite for Toy Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f371520e-f4a7-4779-9f98-90354d07cfc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75c02fb4-c8a5-453e-86d8-da52f6b6916f', 5, NULL, 'V', 'Suite for Toy Piano: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Suite for Toy Piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75c02fb4-c8a5-453e-86d8-da52f6b6916f'
);


-- None Totem Ancestor

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Totem Ancestor', 'Totem Ancestor', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Totem Ancestor'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b0b86e6-ea36-3a99-9b74-6bfbda6d04d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b0b86e6-ea36-3a99-9b74-6bfbda6d04d5'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Totem Ancestor' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b0b86e6-ea36-3a99-9b74-6bfbda6d04d5'
);


-- None Triple-Paced

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Triple-Paced', 'Triple-Paced', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Triple-Paced'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25d7384a-2cb3-42f3-ad19-115acbc83141'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25d7384a-2cb3-42f3-ad19-115acbc83141'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Triple-Paced' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25d7384a-2cb3-42f3-ad19-115acbc83141'
);


-- None 2개의 피아노 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 피아노 소품', 'Two Pieces for Piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 피아노 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7268f088-9f8e-41f1-b108-ef533a61d484'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7268f088-9f8e-41f1-b108-ef533a61d484'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = '2개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7268f088-9f8e-41f1-b108-ef533a61d484'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:effed475-3cdb-43d4-aefd-c0d4a80bf0d0', 1, NULL, 'I', 'Two Pieces for Piano: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = '2개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:effed475-3cdb-43d4-aefd-c0d4a80bf0d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dca89d6-43f7-40e1-adcc-ba3e8e581deb', 2, NULL, 'II', 'Two Pieces for Piano: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = '2개의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dca89d6-43f7-40e1-adcc-ba3e8e581deb'
);


-- None Variations II

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Variations II', 'Variations II', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Variations II'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ddbcd7f-21e7-4f50-8631-da82f0b06ff7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ddbcd7f-21e7-4f50-8631-da82f0b06ff7'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Variations II' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ddbcd7f-21e7-4f50-8631-da82f0b06ff7'
);


-- None Études Boréales

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Études Boréales', 'Études Boréales', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 92
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Études Boréales'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5818bb9-b0d2-4cb1-92e3-74f2b46a5d46'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5818bb9-b0d2-4cb1-92e3-74f2b46a5d46'
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Études Boréales' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5818bb9-b0d2-4cb1-92e3-74f2b46a5d46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d206632-444a-40c2-bd17-c9134fcc4927', 1, NULL, 'No. 1', 'Études Boréales: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Études Boréales' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d206632-444a-40c2-bd17-c9134fcc4927'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59c3ec56-7c14-45c7-b1d2-917ebd1651bc', 2, NULL, 'No. 2', 'Études Boréales: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Études Boréales' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59c3ec56-7c14-45c7-b1d2-917ebd1651bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dbcba34-c2f8-491d-8932-04204e948beb', 3, NULL, 'No. 3', 'Études Boréales: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Études Boréales' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dbcba34-c2f8-491d-8932-04204e948beb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70f6174f-f495-4015-b0ff-7ee777916699', 4, NULL, 'No. 4', 'Études Boréales: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 92 AND p.title = 'Études Boréales' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70f6174f-f495-4015-b0ff-7ee777916699'
);


-- 카탈로그에 대응이 없는 seed 작품 20개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 92 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    1058, 1069, 1175, 1368, 1430, 1640, 1779, 1794, 1812, 2006, 2148, 2345, 2555, 2630, 2691, 2874, 2896, 2933, 2983, 2992
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
