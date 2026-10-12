-- 야나체크 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 92개(묶음 15, 다악장 22, 낱곡 55),
-- 새 작품 7개, part 194개, 그 아래 168개.
-- seed 108개 중 83개를 작품·part 에 잇고, 18개를 숨기고, 7개는 그대로 둔다.
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

-- None 15 Moravian Folksongs, JW VIII/23

UPDATE pieces piece
SET piece.title = '15 Moravian Folksongs, JW VIII/23', piece.title_en = '15 Moravian Folksongs, JW VIII/23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8614 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'That Clock in Vivany', part.name_en = 'Moravian Folksongs: I. That Clock in Vivany',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9796d726-0688-4f4e-b5f5-296444b99ae8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9796d726-0688-4f4e-b5f5-296444b99ae8', 1, 'I', 'That Clock in Vivany', 'Moravian Folksongs: I. That Clock in Vivany', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9796d726-0688-4f4e-b5f5-296444b99ae8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'When I Sing a Song', part.name_en = 'Moravian Folksongs: II. When I Sing a Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d932f49c-65e4-4634-a251-f9df3ff9c3c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d932f49c-65e4-4634-a251-f9df3ff9c3c9', 2, 'II', 'When I Sing a Song', 'Moravian Folksongs: II. When I Sing a Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d932f49c-65e4-4634-a251-f9df3ff9c3c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Oh Georgie, Georgie Dear', part.name_en = 'Moravian Folksongs: III. Oh Georgie, Georgie Dear',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e58f793a-9edb-4502-9513-58db81258dae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e58f793a-9edb-4502-9513-58db81258dae', 3, 'III', 'Oh Georgie, Georgie Dear', 'Moravian Folksongs: III. Oh Georgie, Georgie Dear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e58f793a-9edb-4502-9513-58db81258dae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Mary, My Mary', part.name_en = 'Moravian Folksongs: IV. Mary, My Mary',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b7955e42-e68e-450b-8482-735fdcf18e1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7955e42-e68e-450b-8482-735fdcf18e1c', 4, 'IV', 'Mary, My Mary', 'Moravian Folksongs: IV. Mary, My Mary', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7955e42-e68e-450b-8482-735fdcf18e1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'My Darling''s Already Leaving', part.name_en = 'Moravian Folksongs: V. My Darling''s Already Leaving',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:5765ee49-c45a-4809-abf9-29388ec73aab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5765ee49-c45a-4809-abf9-29388ec73aab', 5, 'V', 'My Darling''s Already Leaving', 'Moravian Folksongs: V. My Darling''s Already Leaving', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5765ee49-c45a-4809-abf9-29388ec73aab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'A Girl Was Weaving Flax', part.name_en = 'Moravian Folksongs: VI. A Girl Was Weaving Flax',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:f4be3f1d-a697-4d3a-9b1b-74c99074a9ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4be3f1d-a697-4d3a-9b1b-74c99074a9ed', 6, 'VI', 'A Girl Was Weaving Flax', 'Moravian Folksongs: VI. A Girl Was Weaving Flax', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4be3f1d-a697-4d3a-9b1b-74c99074a9ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'You Promised to Marry Me', part.name_en = 'Moravian Folksongs: VII. You Promised to Marry Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:878bc294-fc8a-4a44-924e-8b37776d2271' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:878bc294-fc8a-4a44-924e-8b37776d2271', 7, 'VII', 'You Promised to Marry Me', 'Moravian Folksongs: VII. You Promised to Marry Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:878bc294-fc8a-4a44-924e-8b37776d2271'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Whose Lad', part.name_en = 'Moravian Folksongs: VIII. Whose Lad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:11789bce-8318-48bb-a040-0eed1a7a0364' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11789bce-8318-48bb-a040-0eed1a7a0364', 8, 'VIII', 'Whose Lad', 'Moravian Folksongs: VIII. Whose Lad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11789bce-8318-48bb-a040-0eed1a7a0364'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Whose Lass', part.name_en = 'Moravian Folksongs: IX. Whose Lass',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:43a87cf5-962d-486d-8686-4a36627e68e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43a87cf5-962d-486d-8686-4a36627e68e3', 9, 'IX', 'Whose Lass', 'Moravian Folksongs: IX. Whose Lass', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43a87cf5-962d-486d-8686-4a36627e68e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'When I Lie Down', part.name_en = 'Moravian Folksongs: X. When I Lie Down',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:42672f70-d902-434b-b535-47065a8a0d45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42672f70-d902-434b-b535-47065a8a0d45', 10, 'X', 'When I Lie Down', 'Moravian Folksongs: X. When I Lie Down', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42672f70-d902-434b-b535-47065a8a0d45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'A Stream Is Running', part.name_en = 'Moravian Folksongs: XI. A Stream Is Running',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:96c6484b-62be-4336-a2e1-987772232da5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96c6484b-62be-4336-a2e1-987772232da5', 11, 'XI', 'A Stream Is Running', 'Moravian Folksongs: XI. A Stream Is Running', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96c6484b-62be-4336-a2e1-987772232da5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'The Hradcany Clock', part.name_en = 'Moravian Folksongs: XII. The Hradcany Clock',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:f0e65f05-1467-4d0f-a156-b45fed0cc141' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0e65f05-1467-4d0f-a156-b45fed0cc141', 12, 'XII', 'The Hradcany Clock', 'Moravian Folksongs: XII. The Hradcany Clock', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0e65f05-1467-4d0f-a156-b45fed0cc141'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'On a Black Mountain', part.name_en = 'Moravian Folksongs: XIII. On a Black Mountain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e18ab931-a380-4a4a-bc45-c9cc0fc16d43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e18ab931-a380-4a4a-bc45-c9cc0fc16d43', 13, 'XIII', 'On a Black Mountain', 'Moravian Folksongs: XIII. On a Black Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e18ab931-a380-4a4a-bc45-c9cc0fc16d43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'On That Javorina Plain', part.name_en = 'Moravian Folksongs: XIV. On That Javorina Plain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:447f9757-3e99-4d69-8952-455f7b68072e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:447f9757-3e99-4d69-8952-455f7b68072e', 14, 'XIV', 'On That Javorina Plain', 'Moravian Folksongs: XIV. On That Javorina Plain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:447f9757-3e99-4d69-8952-455f7b68072e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'On That Clear Field of Hurasky', part.name_en = 'Moravian Folksongs: XV. On That Clear Field of Hurasky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8614 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:21bd4bf4-a763-4247-9363-619b622ae7ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21bd4bf4-a763-4247-9363-619b622ae7ac', 15, 'XV', 'On That Clear Field of Hurasky', 'Moravian Folksongs: XV. On That Clear Field of Hurasky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8614 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21bd4bf4-a763-4247-9363-619b622ae7ac'
);


-- None Adagio, JW VI/5

UPDATE pieces piece
SET piece.title = 'Adagio, JW VI/5', piece.title_en = 'Adagio, JW VI/5',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8109 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Allegro (discarded from the Violin Sonata)

UPDATE pieces piece
SET piece.title = 'Allegro (discarded from the Violin Sonata)', piece.title_en = 'Allegro (discarded from the Violin Sonata)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8594 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Allegro, JW IX/9

UPDATE pieces piece
SET piece.title = 'Allegro, JW IX/9', piece.title_en = 'Allegro, JW IX/9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10362 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Amarus>

UPDATE pieces piece
SET piece.title = '칸타타 <Amarus>', piece.title_en = 'Amarus',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9974 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Amarus: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9974 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:209af5fc-e166-4f5a-abdc-704fe7d48860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:209af5fc-e166-4f5a-abdc-704fe7d48860', 1, 'I', 'Moderato', 'Amarus: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9974 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:209af5fc-e166-4f5a-abdc-704fe7d48860'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Amarus: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9974 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:76668ff2-0432-4ea0-9d12-89cb5df4f08b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76668ff2-0432-4ea0-9d12-89cb5df4f08b', 2, 'II', 'Andante', 'Amarus: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9974 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76668ff2-0432-4ea0-9d12-89cb5df4f08b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'Amarus: III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9974 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:de1bbd6a-13b1-42f6-97ee-7079f200cc31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de1bbd6a-13b1-42f6-97ee-7079f200cc31', 3, 'III', 'Moderato', 'Amarus: III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9974 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de1bbd6a-13b1-42f6-97ee-7079f200cc31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'Amarus: IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9974 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d4ec2442-c630-4177-9922-a4dd4177db72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4ec2442-c630-4177-9922-a4dd4177db72', 4, 'IV', 'Adagio', 'Amarus: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9974 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4ec2442-c630-4177-9922-a4dd4177db72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Epilogue. Tempo di marcia funebre', part.name_en = 'Amarus: V. Epilogue. Tempo di marcia funebre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9974 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9ecf51ae-8e87-4ee4-b11d-8d85e054f3e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ecf51ae-8e87-4ee4-b11d-8d85e054f3e6', 5, 'V', 'Epilogue. Tempo di marcia funebre', 'Amarus: V. Epilogue. Tempo di marcia funebre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9974 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ecf51ae-8e87-4ee4-b11d-8d85e054f3e6'
);


-- None Andante

UPDATE pieces piece
SET piece.title = 'Andante', piece.title_en = 'Andante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8189 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Balada Blanická

UPDATE pieces piece
SET piece.title = 'Balada Blanická', piece.title_en = 'Balada Blanická',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7620 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 7/12 카프리치오 "Defiance"

UPDATE pieces piece
SET piece.title = '카프리치오 "Defiance"', piece.title_en = 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12',
    piece.type = 'album', piece.opus_number = 'JW 7/12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8004 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8004 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c89e599b-3a9b-4018-8b8c-a8bb373edb3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c89e599b-3a9b-4018-8b8c-a8bb373edb3a', 1, 'I', 'Allegro', 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8004 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c89e599b-3a9b-4018-8b8c-a8bb373edb3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8004 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:accc5ab4-9a4d-46ba-b49a-8cbf853ec84d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:accc5ab4-9a4d-46ba-b49a-8cbf853ec84d', 2, 'II', 'Adagio', 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8004 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:accc5ab4-9a4d-46ba-b49a-8cbf853ec84d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8004 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:8c8bc7e8-2187-4ca6-92a6-67fe8e76fb8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c8bc7e8-2187-4ca6-92a6-67fe8e76fb8d', 3, 'III', 'Allegretto', 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8004 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c8bc7e8-2187-4ca6-92a6-67fe8e76fb8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante', part.name_en = 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12: IV. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8004 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:79732b74-98de-401b-a25e-928aaab7357b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79732b74-98de-401b-a25e-928aaab7357b', 4, 'IV', 'Andante', 'Capriccio for Piano (Left Hand) & Seven Wind Instruments "Defiance", JW 7/12: IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8004 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79732b74-98de-401b-a25e-928aaab7357b'
);


-- JW 7/11 Concertino for Piano & Chamber Orchestra

UPDATE pieces piece
SET piece.title = 'Concertino for Piano & Chamber Orchestra', piece.title_en = 'Concertino for Piano & Chamber Orchestra, JW 7/11',
    piece.type = 'album', piece.opus_number = 'JW 7/11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10921 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Concertino for Piano & Chamber Orchestra, JW 7/11: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10921 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d98e2321-ff7c-4f96-ab4a-b3b54ee44322' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d98e2321-ff7c-4f96-ab4a-b3b54ee44322', 1, 'I', 'Moderato', 'Concertino for Piano & Chamber Orchestra, JW 7/11: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10921 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d98e2321-ff7c-4f96-ab4a-b3b54ee44322'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Più mosso', part.name_en = 'Concertino for Piano & Chamber Orchestra, JW 7/11: II. Più mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10921 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:5b041168-875d-4f32-99f1-42d3c70a8172' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b041168-875d-4f32-99f1-42d3c70a8172', 2, 'II', 'Più mosso', 'Concertino for Piano & Chamber Orchestra, JW 7/11: II. Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10921 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b041168-875d-4f32-99f1-42d3c70a8172'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Con moto', part.name_en = 'Concertino for Piano & Chamber Orchestra, JW 7/11: III. Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10921 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3eaf6364-f929-40b0-afcf-fd2f5239c886' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eaf6364-f929-40b0-afcf-fd2f5239c886', 3, 'III', 'Con moto', 'Concertino for Piano & Chamber Orchestra, JW 7/11: III. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10921 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eaf6364-f929-40b0-afcf-fd2f5239c886'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Concertino for Piano & Chamber Orchestra, JW 7/11: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10921 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fffed11f-b0bc-4d68-8f71-b239f92c5b96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fffed11f-b0bc-4d68-8f71-b239f92c5b96', 4, 'IV', 'Allegro', 'Concertino for Piano & Chamber Orchestra, JW 7/11: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10921 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fffed11f-b0bc-4d68-8f71-b239f92c5b96'
);


-- None 가곡 <Což ta naše bříza, JW IV/22>

UPDATE pieces piece
SET piece.title = '가곡 <Což ta naše bříza, JW IV/22>', piece.title_en = 'Což ta naše bříza, JW IV/22',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7555 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dumka, JW VII/4

UPDATE pieces piece
SET piece.title = 'Dumka, JW VII/4', piece.title_en = 'Dumka, JW VII/4',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8802 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dunaj, JW IX / 7: IV. Vivo

UPDATE pieces piece
SET piece.title = 'Dunaj, JW IX / 7: IV. Vivo', piece.title_en = 'Dunaj, JW IX / 7: IV. Vivo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10719 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dunaj, JW IX / 7', part.name_en = 'Dunaj, JW IX / 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10719 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:efbf5287-c1ad-48de-8096-0139f052a26d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efbf5287-c1ad-48de-8096-0139f052a26d', 1, NULL, 'Dunaj, JW IX / 7', 'Dunaj, JW IX / 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10719 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efbf5287-c1ad-48de-8096-0139f052a26d'
);


-- None Dvĕ sklaydby pro varhany, JW VIII/7

UPDATE pieces piece
SET piece.title = 'Dvĕ sklaydby pro varhany, JW VIII/7', piece.title_en = 'Dvĕ sklaydby pro varhany, JW VIII/7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7524 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Dvĕ sklaydby pro varhany, JW VIII/7: No. 1. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7524 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:56c18136-e908-4179-b17e-40117f22ab0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56c18136-e908-4179-b17e-40117f22ab0f', 1, NULL, 'Adagio', 'Dvĕ sklaydby pro varhany, JW VIII/7: No. 1. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7524 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56c18136-e908-4179-b17e-40117f22ab0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Dvĕ sklaydby pro varhany, JW VIII/7: No. 2. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7524 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1ecd262d-0fc0-4d3d-ad15-1df6fa073e54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ecd262d-0fc0-4d3d-ad15-1df6fa073e54', 2, NULL, 'Adagio', 'Dvĕ sklaydby pro varhany, JW VIII/7: No. 2. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7524 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ecd262d-0fc0-4d3d-ad15-1df6fa073e54'
);


-- None 가곡 <Eligie na smrt dcery Olgy>

UPDATE pieces piece
SET piece.title = '가곡 <Eligie na smrt dcery Olgy>', piece.title_en = 'Eligie na smrt dcery Olgy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8451 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 2/3 모테트 <Exaudi Deus>

UPDATE pieces piece
SET piece.title = '모테트 <Exaudi Deus>', piece.title_en = 'Exaudi Deus, JW 2/3',
    piece.type = 'song', piece.opus_number = 'JW 2/3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10476 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None From the House of the Dead: Act II. The Play of Kedril and Juan

UPDATE pieces piece
SET piece.title = 'From the House of the Dead: Act II. The Play of Kedril and Juan', piece.title_en = 'From the House of the Dead: Act II. The Play of Kedril and Juan',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10491 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None From the House of the Dead: Finale

UPDATE pieces piece
SET piece.title = 'From the House of the Dead: Finale', piece.title_en = 'From the House of the Dead: Finale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9732 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Holubička>

UPDATE pieces piece
SET piece.title = '가곡 <Holubička>', piece.title_en = 'Holubička',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9893 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hudba ke kroužení kužely

UPDATE pieces piece
SET piece.title = 'Hudba ke kroužení kužely', piece.title_en = 'Hudba ke kroužení kužely',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7608 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Idyll for String Orchestra, JW VI/3

UPDATE pieces piece
SET piece.title = 'Idyll for String Orchestra, JW VI/3', piece.title_en = 'Idyll for String Orchestra, JW VI/3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8673 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Idyll for String Orchestra: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8673 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e426b84b-05ab-43e1-94ca-8acdef6b0d4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e426b84b-05ab-43e1-94ca-8acdef6b0d4c', 1, 'I', 'Andante', 'Idyll for String Orchestra: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8673 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e426b84b-05ab-43e1-94ca-8acdef6b0d4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Idyll for String Orchestra: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8673 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0b1fe1b2-b971-49d6-bfc8-32424e0d7a04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b1fe1b2-b971-49d6-bfc8-32424e0d7a04', 2, 'II', 'Allegro', 'Idyll for String Orchestra: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8673 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b1fe1b2-b971-49d6-bfc8-32424e0d7a04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'Idyll for String Orchestra: III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8673 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ff7ac1b3-d643-40d8-b680-7db27875c91b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff7ac1b3-d643-40d8-b680-7db27875c91b', 3, 'III', 'Moderato', 'Idyll for String Orchestra: III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8673 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff7ac1b3-d643-40d8-b680-7db27875c91b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Idyll for String Orchestra: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8673 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:423d972c-3d3e-4fd4-83c3-8d8a16796438' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:423d972c-3d3e-4fd4-83c3-8d8a16796438', 4, 'IV', 'Allegro', 'Idyll for String Orchestra: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8673 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:423d972c-3d3e-4fd4-83c3-8d8a16796438'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Adagio', part.name_en = 'Idyll for String Orchestra: V. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8673 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:cd1e0055-9745-4281-a743-01e508d0a0e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd1e0055-9745-4281-a743-01e508d0a0e9', 5, 'V', 'Adagio', 'Idyll for String Orchestra: V. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8673 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd1e0055-9745-4281-a743-01e508d0a0e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Scherzo', part.name_en = 'Idyll for String Orchestra: VI. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8673 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b23ec05e-22c1-46b0-8610-1fe1d2341d96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b23ec05e-22c1-46b0-8610-1fe1d2341d96', 6, 'VI', 'Scherzo', 'Idyll for String Orchestra: VI. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8673 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b23ec05e-22c1-46b0-8610-1fe1d2341d96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Moderato', part.name_en = 'Idyll for String Orchestra: VII. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8673 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b6dafa1b-2cba-4a81-8914-bb6e3d567bf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6dafa1b-2cba-4a81-8914-bb6e3d567bf4', 7, 'VII', 'Moderato', 'Idyll for String Orchestra: VII. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8673 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6dafa1b-2cba-4a81-8914-bb6e3d567bf4'
);


-- None 모테트 <In Nomine Jesu>

UPDATE pieces piece
SET piece.title = '모테트 <In Nomine Jesu>', piece.title_en = 'In Nomine Jesu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8473 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Intimní skici

UPDATE pieces piece
SET piece.title = 'Intimní skici', piece.title_en = 'Intimní skici',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10413 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ukolébavka', part.name_en = 'Ukolébavka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:33366d1c-2d11-3769-a146-531879e6dea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33366d1c-2d11-3769-a146-531879e6dea8', 1, NULL, 'Ukolébavka', 'Ukolébavka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33366d1c-2d11-3769-a146-531879e6dea8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Melodie (Con moto)', part.name_en = 'Melodie (Con moto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3852c0e9-2453-31bd-9d8c-588093127bb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3852c0e9-2453-31bd-9d8c-588093127bb5', 2, NULL, 'Melodie (Con moto)', 'Melodie (Con moto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3852c0e9-2453-31bd-9d8c-588093127bb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Malostranský palác', part.name_en = 'Malostranský palác',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:59b01d4a-0128-3302-ae81-98cf5bb54bbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59b01d4a-0128-3302-ae81-98cf5bb54bbc', 3, NULL, 'Malostranský palác', 'Malostranský palác', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59b01d4a-0128-3302-ae81-98cf5bb54bbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:690385ae-edcd-319a-9fc7-4f6162d61db7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:690385ae-edcd-319a-9fc7-4f6162d61db7', 4, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:690385ae-edcd-319a-9fc7-4f6162d61db7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Zlatý kroužek', part.name_en = 'Zlatý kroužek',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:875cd4de-0edd-3013-b510-3808557e0a3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:875cd4de-0edd-3013-b510-3808557e0a3d', 5, NULL, 'Zlatý kroužek', 'Zlatý kroužek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:875cd4de-0edd-3013-b510-3808557e0a3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Bez názvu', part.name_en = 'Bez názvu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:af19fd52-e039-3a12-819f-1870f1b83587' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af19fd52-e039-3a12-819f-1870f1b83587', 6, NULL, 'Bez názvu', 'Bez názvu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af19fd52-e039-3a12-819f-1870f1b83587'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Čekám Tě!', part.name_en = 'Čekám Tě!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b1cbdc5c-9d44-3c75-afab-2296e682dbf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1cbdc5c-9d44-3c75-afab-2296e682dbf9', 7, NULL, 'Čekám Tě!', 'Čekám Tě!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1cbdc5c-9d44-3c75-afab-2296e682dbf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Jen slepý osud?', part.name_en = 'Jen slepý osud?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ce07cc0b-02eb-3040-ad61-724d05e45a7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce07cc0b-02eb-3040-ad61-724d05e45a7e', 8, NULL, 'Jen slepý osud?', 'Jen slepý osud?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce07cc0b-02eb-3040-ad61-724d05e45a7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Narodil se Kristus Pán', part.name_en = 'Narodil se Kristus Pán',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e10bb2a4-7c21-3898-ba19-f813d84cae44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e10bb2a4-7c21-3898-ba19-f813d84cae44', 9, NULL, 'Narodil se Kristus Pán', 'Narodil se Kristus Pán', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e10bb2a4-7c21-3898-ba19-f813d84cae44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Aby už se nemohlo jíti nikdy zpět', part.name_en = 'Aby už se nemohlo jíti nikdy zpět',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10413 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ee2c9335-7ac4-32fe-b5c6-334cadd1e08e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee2c9335-7ac4-32fe-b5c6-334cadd1e08e', 10, NULL, 'Aby už se nemohlo jíti nikdy zpět', 'Aby už se nemohlo jíti nikdy zpět', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10413 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee2c9335-7ac4-32fe-b5c6-334cadd1e08e'
);


-- None 오페라 <Jenůfa>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jednání III', part.name_en = 'Jenůfa: Jednání III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786', 1, NULL, 'Jednání III', 'Jenůfa: Jednání III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III: Co Dite? Co S Dítetem Tam Kricejí? [Kostelnicka / Jano / Mayor / Steva]', part.name_en = 'Jenufa: Act III: Co Dite? Co S Dítetem Tam Kricejí? [Kostelnicka / Jano / Mayor / Steva]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0148028a-9ce5-4772-8f4b-c075d9d4757e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0148028a-9ce5-4772-8f4b-c075d9d4757e', 1, NULL, 'Act III: Co Dite? Co S Dítetem Tam Kricejí? [Kostelnicka / Jano / Mayor / Steva]', 'Jenufa: Act III: Co Dite? Co S Dítetem Tam Kricejí? [Kostelnicka / Jano / Mayor / Steva]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0148028a-9ce5-4772-8f4b-c075d9d4757e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "Chud''átko!" (Žena)', part.name_en = 'Jenůfa: Jednání III. "Chud''átko!" (Žena)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:107a8432-6fd8-4b91-a33d-425e373dd9cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:107a8432-6fd8-4b91-a33d-425e373dd9cb', 2, NULL, 'Jednání III. "Chud''átko!" (Žena)', 'Jenůfa: Jednání III. "Chud''átko!" (Žena)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:107a8432-6fd8-4b91-a33d-425e373dd9cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "Vidíš Laco, já to tušila" (Jenůfa)', part.name_en = 'Jenůfa: Jednání III. "Vidíš Laco, já to tušila" (Jenůfa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:14bf1200-c4cc-48f8-8984-063b6007b349' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:14bf1200-c4cc-48f8-8984-063b6007b349', 3, NULL, 'Jednání III. "Vidíš Laco, já to tušila" (Jenůfa)', 'Jenůfa: Jednání III. "Vidíš Laco, já to tušila" (Jenůfa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14bf1200-c4cc-48f8-8984-063b6007b349'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III: Prelude [Orchestra]', part.name_en = 'Jenufa: Act III: Prelude [Orchestra]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:22b8e96d-366d-4fff-9e81-b8ade7b37bb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22b8e96d-366d-4fff-9e81-b8ade7b37bb0', 4, NULL, 'Act III: Prelude [Orchestra]', 'Jenufa: Act III: Prelude [Orchestra]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22b8e96d-366d-4fff-9e81-b8ade7b37bb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III: Ha - Vidíte, Jeho Poviják [Jenufa / Mayor''s Wife / Woman/Mayor / People / Laca]', part.name_en = 'Jenufa: Act III: Ha - Vidíte, Jeho Poviják [Jenufa / Mayor''s Wife / Woman/Mayor / People / Laca]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:2648adc6-28bf-4d5e-a902-d5ea624b7fb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2648adc6-28bf-4d5e-a902-d5ea624b7fb5', 5, NULL, 'Act III: Ha - Vidíte, Jeho Poviják [Jenufa / Mayor''s Wife / Woman/Mayor / People / Laca]', 'Jenufa: Act III: Ha - Vidíte, Jeho Poviják [Jenufa / Mayor''s Wife / Woman/Mayor / People / Laca]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2648adc6-28bf-4d5e-a902-d5ea624b7fb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act III: O Pobezte, O Probezte! [Jano / Kostelnicka / Grandmother]', part.name_en = 'Jenufa: Act III: O Pobezte, O Probezte! [Jano / Kostelnicka / Grandmother]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:409adbcd-c5ae-4208-92c3-fe7a1f15e6b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:409adbcd-c5ae-4208-92c3-fe7a1f15e6b0', 6, NULL, 'Act III: O Pobezte, O Probezte! [Jano / Kostelnicka / Grandmother]', 'Jenufa: Act III: O Pobezte, O Probezte! [Jano / Kostelnicka / Grandmother]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:409adbcd-c5ae-4208-92c3-fe7a1f15e6b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "To bylo ňákého" (Rychtář)', part.name_en = 'Jenůfa: Jednání III. "To bylo ňákého" (Rychtář)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:40f0bcb4-1bc7-4b68-b933-1cc495f5d59f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40f0bcb4-1bc7-4b68-b933-1cc495f5d59f', 7, NULL, 'Jednání III. "To bylo ňákého" (Rychtář)', 'Jenůfa: Jednání III. "To bylo ňákého" (Rychtář)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40f0bcb4-1bc7-4b68-b933-1cc495f5d59f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act III: Pán Buh Rac Dát Dobry Den [Barena / Girls / Mayor / Jenufa / Laca]', part.name_en = 'Jenufa: Act III: Pán Buh Rac Dát Dobry Den [Barena / Girls / Mayor / Jenufa / Laca]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4cc5628b-9ea3-4b67-805a-6a1d99bc6133' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4cc5628b-9ea3-4b67-805a-6a1d99bc6133', 8, NULL, 'Act III: Pán Buh Rac Dát Dobry Den [Barena / Girls / Mayor / Jenufa / Laca]', 'Jenufa: Act III: Pán Buh Rac Dát Dobry Den [Barena / Girls / Mayor / Jenufa / Laca]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cc5628b-9ea3-4b67-805a-6a1d99bc6133'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "Není ti teskno, Jenůfko?" (Pastuchyňa)', part.name_en = 'Jenůfa: Jednání III. "Není ti teskno, Jenůfko?" (Pastuchyňa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:811df310-29a1-45d9-82c9-ee2e0cacc82f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:811df310-29a1-45d9-82c9-ee2e0cacc82f', 9, NULL, 'Jednání III. "Není ti teskno, Jenůfko?" (Pastuchyňa)', 'Jenůfa: Jednání III. "Není ti teskno, Jenůfko?" (Pastuchyňa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:811df310-29a1-45d9-82c9-ee2e0cacc82f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act III: Odpust'' Mi Jenom Ty - [Kostelnicka / Jenufa]', part.name_en = 'Jenufa: Act III: Odpust'' Mi Jenom Ty - [Kostelnicka / Jenufa]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:8d8911c4-ead1-43de-bb86-b3090864dc0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d8911c4-ead1-43de-bb86-b3090864dc0d', 10, NULL, 'Act III: Odpust'' Mi Jenom Ty - [Kostelnicka / Jenufa]', 'Jenufa: Act III: Odpust'' Mi Jenom Ty - [Kostelnicka / Jenufa]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d8911c4-ead1-43de-bb86-b3090864dc0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "Vstaňte, pěstounko moja!" (Jenůfa)', part.name_en = 'Jenůfa: Jednání III. "Vstaňte, pěstounko moja!" (Jenůfa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9af4b66b-035f-4799-9aae-f3b7f7fb391e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9af4b66b-035f-4799-9aae-f3b7f7fb391e', 11, NULL, 'Jednání III. "Vstaňte, pěstounko moja!" (Jenůfa)', 'Jenůfa: Jednání III. "Vstaňte, pěstounko moja!" (Jenůfa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9af4b66b-035f-4799-9aae-f3b7f7fb391e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act III: Stevo, To Je Ti Strasné ... [Karolka / Jenufa / Steva / Laca]', part.name_en = 'Jenufa: Act III: Stevo, To Je Ti Strasné ... [Karolka / Jenufa / Steva / Laca]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:a53c9e1b-978a-4559-87c6-f340e1e374af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a53c9e1b-978a-4559-87c6-f340e1e374af', 12, NULL, 'Act III: Stevo, To Je Ti Strasné ... [Karolka / Jenufa / Steva / Laca]', 'Jenufa: Act III: Stevo, To Je Ti Strasné ... [Karolka / Jenufa / Steva / Laca]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a53c9e1b-978a-4559-87c6-f340e1e374af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "Odešli" (Jenůfa)', part.name_en = 'Jenůfa: Jednání III. "Odešli" (Jenůfa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c7ea0454-754e-4772-b37d-510bc757b051' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7ea0454-754e-4772-b37d-510bc757b051', 13, NULL, 'Jednání III. "Odešli" (Jenůfa)', 'Jenůfa: Jednání III. "Odešli" (Jenůfa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ea0454-754e-4772-b37d-510bc757b051'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act III: Pán Buh Rac Dát Dobry Den [Karolka / Steva / Jenufa / Laca]', part.name_en = 'Jenufa: Act III: Pán Buh Rac Dát Dobry Den [Karolka / Steva / Jenufa / Laca]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d1864278-3da4-495c-af69-00ef2ead1f92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1864278-3da4-495c-af69-00ef2ead1f92', 14, NULL, 'Act III: Pán Buh Rac Dát Dobry Den [Karolka / Steva / Jenufa / Laca]', 'Jenufa: Act III: Pán Buh Rac Dát Dobry Den [Karolka / Steva / Jenufa / Laca]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1864278-3da4-495c-af69-00ef2ead1f92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "A hen... už jsou tu!" (Laca)', part.name_en = 'Jenůfa: Jednání III. "A hen... už jsou tu!" (Laca)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e3351dc6-5d86-44a3-9007-c944528b1015' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3351dc6-5d86-44a3-9007-c944528b1015', 15, NULL, 'Jednání III. "A hen... už jsou tu!" (Laca)', 'Jenůfa: Jednání III. "A hen... už jsou tu!" (Laca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3351dc6-5d86-44a3-9007-c944528b1015'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act III: Dnes Je Tvá Veselka, Jenufko [Kostelnicka / Mayor / Shepherdess]', part.name_en = 'Jenufa: Act III: Dnes Je Tvá Veselka, Jenufko [Kostelnicka / Mayor / Shepherdess]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e51e5a2b-912c-4ddd-bc34-0bb1ee1a98e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e51e5a2b-912c-4ddd-bc34-0bb1ee1a98e1', 16, NULL, 'Act III: Dnes Je Tvá Veselka, Jenufko [Kostelnicka / Mayor / Shepherdess]', 'Jenufa: Act III: Dnes Je Tvá Veselka, Jenufko [Kostelnicka / Mayor / Shepherdess]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e51e5a2b-912c-4ddd-bc34-0bb1ee1a98e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "Dej Bůh štěsti" (Rychtář)', part.name_en = 'Jenůfa: Jednání III. "Dej Bůh štěsti" (Rychtář)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:f227aafd-f696-46c7-b274-e8912b675f09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f227aafd-f696-46c7-b274-e8912b675f09', 17, NULL, 'Jednání III. "Dej Bůh štěsti" (Rychtář)', 'Jenůfa: Jednání III. "Dej Bůh štěsti" (Rychtář)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f227aafd-f696-46c7-b274-e8912b675f09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Act III: Uctivo Vás Prosím [Laca / Grandmother / Mayor]', part.name_en = 'Jenufa: Act III: Uctivo Vás Prosím [Laca / Grandmother / Mayor]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:f30f7aec-32c4-4295-bb07-e1bc5d9b3a66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f30f7aec-32c4-4295-bb07-e1bc5d9b3a66', 18, NULL, 'Act III: Uctivo Vás Prosím [Laca / Grandmother / Mayor]', 'Jenufa: Act III: Uctivo Vás Prosím [Laca / Grandmother / Mayor]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f30f7aec-32c4-4295-bb07-e1bc5d9b3a66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Jednání III. "Ještě jsem tu já!" (Kostelnička)', part.name_en = 'Jenůfa: Jednání III. "Ještě jsem tu já!" (Kostelnička)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:f4c97ba5-b876-4922-9430-6c00ac81a997' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4c97ba5-b876-4922-9430-6c00ac81a997', 19, NULL, 'Jednání III. "Ještě jsem tu já!" (Kostelnička)', 'Jenůfa: Jednání III. "Ještě jsem tu já!" (Kostelnička)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:489595c8-0c87-4832-bc7b-49d7e27cc786'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4c97ba5-b876-4922-9430-6c00ac81a997'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Jenufa: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:967a1951-8993-4068-9b5e-9fe49f60fc23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:967a1951-8993-4068-9b5e-9fe49f60fc23', 2, NULL, 'Prelude', 'Jenufa: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:967a1951-8993-4068-9b5e-9fe49f60fc23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jednání II', part.name_en = 'Jenůfa: Jednání II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387', 3, NULL, 'Jednání II', 'Jenůfa: Jednání II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jednání II. "Nechám ještě dveře otevřeny" (Kostelnička)', part.name_en = 'Jenůfa: Jednání II. "Nechám ještě dveře otevřeny" (Kostelnička)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:025df2a1-6fdf-4b36-9dda-ccc3f7127de4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:025df2a1-6fdf-4b36-9dda-ccc3f7127de4', 1, NULL, 'Jednání II. "Nechám ještě dveře otevřeny" (Kostelnička)', 'Jenůfa: Jednání II. "Nechám ještě dveře otevřeny" (Kostelnička)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:025df2a1-6fdf-4b36-9dda-ccc3f7127de4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II: Kde To Jsem? [Jenufa]', part.name_en = 'Jenufa: Act II: Kde To Jsem? [Jenufa]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0837630d-037b-4d30-bb17-6f08daaef158' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0837630d-037b-4d30-bb17-6f08daaef158', 2, NULL, 'Act II: Kde To Jsem? [Jenufa]', 'Jenufa: Act II: Kde To Jsem? [Jenufa]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0837630d-037b-4d30-bb17-6f08daaef158'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II: Ba, Ta Tvoje Okenicka [Kostelnicka]', part.name_en = 'Jenufa: Act II: Ba, Ta Tvoje Okenicka [Kostelnicka]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0ab4c597-c765-443c-9ee5-630224535705' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ab4c597-c765-443c-9ee5-630224535705', 3, NULL, 'Act II: Ba, Ta Tvoje Okenicka [Kostelnicka]', 'Jenufa: Act II: Ba, Ta Tvoje Okenicka [Kostelnicka]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ab4c597-c765-443c-9ee5-630224535705'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II: Toz Jenom Vejdi [Steva / Kostelnicka]', part.name_en = 'Jenufa: Act II: Toz Jenom Vejdi [Steva / Kostelnicka]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:11ef565b-e21a-4713-880b-37ca706136a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11ef565b-e21a-4713-880b-37ca706136a8', 4, NULL, 'Act II: Toz Jenom Vejdi [Steva / Kostelnicka]', 'Jenufa: Act II: Toz Jenom Vejdi [Steva / Kostelnicka]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ef565b-e21a-4713-880b-37ca706136a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Jednání II. "Tot'' zrovna jde!" (Kostelnička)', part.name_en = 'Jenůfa: Jednání II. "Tot'' zrovna jde!" (Kostelnička)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:264c1f46-8b24-4ac7-a2be-90813d982bdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:264c1f46-8b24-4ac7-a2be-90813d982bdb', 5, NULL, 'Jednání II. "Tot'' zrovna jde!" (Kostelnička)', 'Jenůfa: Jednání II. "Tot'' zrovna jde!" (Kostelnička)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:264c1f46-8b24-4ac7-a2be-90813d982bdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Jednání II. "Ba zabedněna ta tvoje okenička už přes dvacet neděl" (Kostelnička)', part.name_en = 'Jenůfa: Jednání II. "Ba zabedněna ta tvoje okenička už přes dvacet neděl" (Kostelnička)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:2f805bd1-e01e-429f-9396-a3da504a3beb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f805bd1-e01e-429f-9396-a3da504a3beb', 6, NULL, 'Jednání II. "Ba zabedněna ta tvoje okenička už přes dvacet neděl" (Kostelnička)', 'Jenůfa: Jednání II. "Ba zabedněna ta tvoje okenička už přes dvacet neděl" (Kostelnička)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f805bd1-e01e-429f-9396-a3da504a3beb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Jednání II. "Tetko Kostelničko, poslala jste cedulku" (Števa)', part.name_en = 'Jenůfa: Jednání II. "Tetko Kostelničko, poslala jste cedulku" (Števa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4b19aa6b-3cbb-4fc6-9c23-17f1dbceeab5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b19aa6b-3cbb-4fc6-9c23-17f1dbceeab5', 7, NULL, 'Jednání II. "Tetko Kostelničko, poslala jste cedulku" (Števa)', 'Jenůfa: Jednání II. "Tetko Kostelničko, poslala jste cedulku" (Števa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b19aa6b-3cbb-4fc6-9c23-17f1dbceeab5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Jednání II. "Ale viděl jsem vcházet šohaje" (Laca)', part.name_en = 'Jenůfa: Jednání II. "Ale viděl jsem vcházet šohaje" (Laca)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:500fdfb5-1ce1-4b98-8890-7a6ecf551964' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:500fdfb5-1ce1-4b98-8890-7a6ecf551964', 8, NULL, 'Jednání II. "Ale viděl jsem vcházet šohaje" (Laca)', 'Jenůfa: Jednání II. "Ale viděl jsem vcházet šohaje" (Laca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:500fdfb5-1ce1-4b98-8890-7a6ecf551964'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II: Chci, Jenufka, Chci Jenufa Jen Kdyz [Laca / Kostelnicka / Jenufa]', part.name_en = 'Jenufa: Act II: Chci, Jenufka, Chci Jenufa Jen Kdyz [Laca / Kostelnicka / Jenufa]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:8be56a6f-e26c-4182-9326-479b036d397c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8be56a6f-e26c-4182-9326-479b036d397c', 9, NULL, 'Act II: Chci, Jenufka, Chci Jenufa Jen Kdyz [Laca / Kostelnicka / Jenufa]', 'Jenufa: Act II: Chci, Jenufka, Chci Jenufa Jen Kdyz [Laca / Kostelnicka / Jenufa]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8be56a6f-e26c-4182-9326-479b036d397c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Jednání II. "Kdo to je?" (Jenůfa)', part.name_en = 'Jenůfa: Jednání II. "Kdo to je?" (Jenůfa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:93875877-35d6-4752-99d3-6aaf4bb6085c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:93875877-35d6-4752-99d3-6aaf4bb6085c', 10, NULL, 'Jednání II. "Kdo to je?" (Jenůfa)', 'Jenůfa: Jednání II. "Kdo to je?" (Jenůfa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93875877-35d6-4752-99d3-6aaf4bb6085c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Jednání II. Úvod', part.name_en = 'Jenůfa: Jednání II. Úvod',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:942252a4-d09a-45a9-bdc5-3cd94f34db6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:942252a4-d09a-45a9-bdc5-3cd94f34db6b', 11, NULL, 'Jednání II. Úvod', 'Jenůfa: Jednání II. Úvod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:942252a4-d09a-45a9-bdc5-3cd94f34db6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act II: Tetko Kostelnicko, Postala Jste Cedulku', part.name_en = 'Jenufa: Act II: Tetko Kostelnicko, Postala Jste Cedulku',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:98be62b2-9b21-42d6-8dea-04f96b54237a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:98be62b2-9b21-42d6-8dea-04f96b54237a', 12, NULL, 'Act II: Tetko Kostelnicko, Postala Jste Cedulku', 'Jenufa: Act II: Tetko Kostelnicko, Postala Jste Cedulku', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98be62b2-9b21-42d6-8dea-04f96b54237a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act II: A Coz Steva? [Jenufa / Kostelnicka]', part.name_en = 'Jenufa: Act II: A Coz Steva? [Jenufa / Kostelnicka]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:aad99b12-c1f7-4e7d-afdf-f03ee171e85c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aad99b12-c1f7-4e7d-afdf-f03ee171e85c', 13, NULL, 'Act II: A Coz Steva? [Jenufa / Kostelnicka]', 'Jenufa: Act II: A Coz Steva? [Jenufa / Kostelnicka]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aad99b12-c1f7-4e7d-afdf-f03ee171e85c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Jednání II. "Co chvíla... co chvíla" (Kostelnička)', part.name_en = 'Jenůfa: Jednání II. "Co chvíla... co chvíla" (Kostelnička)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ab8576ad-04dc-42e5-b910-20ff2662d10d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab8576ad-04dc-42e5-b910-20ff2662d10d', 14, NULL, 'Jednání II. "Co chvíla... co chvíla" (Kostelnička)', 'Jenůfa: Jednání II. "Co chvíla... co chvíla" (Kostelnička)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab8576ad-04dc-42e5-b910-20ff2662d10d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act II: Prelude [Orchestra]', part.name_en = 'Jenufa: Act II: Prelude [Orchestra]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b3ef892f-70ad-47f3-b70a-0757f45d4253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3ef892f-70ad-47f3-b70a-0757f45d4253', 15, NULL, 'Act II: Prelude [Orchestra]', 'Jenufa: Act II: Prelude [Orchestra]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3ef892f-70ad-47f3-b70a-0757f45d4253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act II: Toz Umrel - Toz Umrel - Muj Chlapcok', part.name_en = 'Jenufa: Act II: Toz Umrel - Toz Umrel - Muj Chlapcok',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:bceec34e-c0f3-428c-8434-d83e10a9d460' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bceec34e-c0f3-428c-8434-d83e10a9d460', 16, NULL, 'Act II: Toz Umrel - Toz Umrel - Muj Chlapcok', 'Jenufa: Act II: Toz Umrel - Toz Umrel - Muj Chlapcok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bceec34e-c0f3-428c-8434-d83e10a9d460'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act II: Porád Se S Tím Deckem Mazes [Kostelnicka / Jenufa]', part.name_en = 'Jenufa: Act II: Porád Se S Tím Deckem Mazes [Kostelnicka / Jenufa]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e9fe7c99-9ec8-4ba5-a389-7e62a4c1d858' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9fe7c99-9ec8-4ba5-a389-7e62a4c1d858', 17, NULL, 'Act II: Porád Se S Tím Deckem Mazes [Kostelnicka / Jenufa]', 'Jenufa: Act II: Porád Se S Tím Deckem Mazes [Kostelnicka / Jenufa]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9fe7c99-9ec8-4ba5-a389-7e62a4c1d858'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Jednání II. "Mamičko, mám těžkou hlavu" (Jenůfa)', part.name_en = 'Jenůfa: Jednání II. "Mamičko, mám těžkou hlavu" (Jenůfa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ed0e53b0-fdfe-4921-a1a1-8c9187663042' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed0e53b0-fdfe-4921-a1a1-8c9187663042', 18, NULL, 'Jednání II. "Mamičko, mám těžkou hlavu" (Jenůfa)', 'Jenůfa: Jednání II. "Mamičko, mám těžkou hlavu" (Jenůfa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed0e53b0-fdfe-4921-a1a1-8c9187663042'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Act II: Tetusko, Kamen By Se Ustrnul [Steva / Kostelnicka / Jenufa]', part.name_en = 'Jenufa: Act II: Tetusko, Kamen By Se Ustrnul [Steva / Kostelnicka / Jenufa]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fb07da2f-2e72-438b-a6b3-63ec62df0ba2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb07da2f-2e72-438b-a6b3-63ec62df0ba2', 19, NULL, 'Act II: Tetusko, Kamen By Se Ustrnul [Steva / Kostelnicka / Jenufa]', 'Jenufa: Act II: Tetusko, Kamen By Se Ustrnul [Steva / Kostelnicka / Jenufa]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb07da2f-2e72-438b-a6b3-63ec62df0ba2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Act II: Jenufa: Bedna Devcíca [Laca / Kostelnicka]', part.name_en = 'Jenufa: Act II: Jenufa: Bedna Devcíca [Laca / Kostelnicka]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fb8c3dc2-58c7-401d-81d7-7591f8f85cd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fb8c3dc2-58c7-401d-81d7-7591f8f85cd6', 20, NULL, 'Act II: Jenufa: Bedna Devcíca [Laca / Kostelnicka]', 'Jenufa: Act II: Jenufa: Bedna Devcíca [Laca / Kostelnicka]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:defb97dc-ed49-4d0f-8142-e2ced0810387'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb8c3dc2-58c7-401d-81d7-7591f8f85cd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jednání I', part.name_en = 'Jenůfa: Jednání I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5', 4, NULL, 'Jednání I', 'Jenůfa: Jednání I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jednání I. "A tak bychom šli celým životem" (Kostelnička)', part.name_en = 'Jenůfa: Jednání I. "A tak bychom šli celým životem" (Kostelnička)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:03050424-9f10-4ca7-ac48-9d87e3be8b1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03050424-9f10-4ca7-ac48-9d87e3be8b1b', 1, NULL, 'Jednání I. "A tak bychom šli celým životem" (Kostelnička)', 'Jenůfa: Jednání I. "A tak bychom šli celým životem" (Kostelnička)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03050424-9f10-4ca7-ac48-9d87e3be8b1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I: Vseci Sa Zenija [Recruits / Steva / Jenufa / Miller / Milllworkers / Laca]', part.name_en = 'Jenufa: Act I: Vseci Sa Zenija [Recruits / Steva / Jenufa / Miller / Milllworkers / Laca]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0423e77d-8e04-4d47-9808-a99af95bd932' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0423e77d-8e04-4d47-9808-a99af95bd932', 2, NULL, 'Act I: Vseci Sa Zenija [Recruits / Steva / Jenufa / Miller / Milllworkers / Laca]', 'Jenufa: Act I: Vseci Sa Zenija [Recruits / Steva / Jenufa / Miller / Milllworkers / Laca]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0423e77d-8e04-4d47-9808-a99af95bd932'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jednání I. "Števo, Števo, já vím" (Jenůfa)', part.name_en = 'Jenůfa: Jednání I. "Števo, Števo, já vím" (Jenůfa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1e5a48d6-ae7e-449d-a618-1ee062a55310' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e5a48d6-ae7e-449d-a618-1ee062a55310', 3, NULL, 'Jednání I. "Števo, Števo, já vím" (Jenůfa)', 'Jenůfa: Jednání I. "Števo, Števo, já vím" (Jenůfa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e5a48d6-ae7e-449d-a618-1ee062a55310'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I: Daleko Siroko [Millworks / Steva]', part.name_en = 'Jenufa: Act I: Daleko Siroko [Millworks / Steva]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:37028535-0745-4527-b1e2-34fdabf30b0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37028535-0745-4527-b1e2-34fdabf30b0d', 4, NULL, 'Act I: Daleko Siroko [Millworks / Steva]', 'Jenufa: Act I: Daleko Siroko [Millworks / Steva]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37028535-0745-4527-b1e2-34fdabf30b0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I: To Bude Pekná Svagrina [Laca / Miller / Jenufa / Grandmother]', part.name_en = 'Jenufa: Act I: To Bude Pekná Svagrina [Laca / Miller / Jenufa / Grandmother]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3a6d28ec-8fc9-4d69-9696-b1ccb786b61c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3a6d28ec-8fc9-4d69-9696-b1ccb786b61c', 5, NULL, 'Act I: To Bude Pekná Svagrina [Laca / Miller / Jenufa / Grandmother]', 'Jenufa: Act I: To Bude Pekná Svagrina [Laca / Miller / Jenufa / Grandmother]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a6d28ec-8fc9-4d69-9696-b1ccb786b61c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I: Neskleb Se! [Steva / Jenufa / Grandmother]', part.name_en = 'Jenufa: Act I: Neskleb Se! [Steva / Jenufa / Grandmother]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:52caff51-c1bf-473c-a34f-8655b21d4bdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52caff51-c1bf-473c-a34f-8655b21d4bdb', 6, NULL, 'Act I: Neskleb Se! [Steva / Jenufa / Grandmother]', 'Jenufa: Act I: Neskleb Se! [Steva / Jenufa / Grandmother]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52caff51-c1bf-473c-a34f-8655b21d4bdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I: Co To Más Za Radost! [Grandmother / Jenufa]', part.name_en = 'Jenufa: Act I: Co To Más Za Radost! [Grandmother / Jenufa]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:588f8d7d-6813-4b78-9c54-3027f7ea7745' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:588f8d7d-6813-4b78-9c54-3027f7ea7745', 7, NULL, 'Act I: Co To Más Za Radost! [Grandmother / Jenufa]', 'Jenufa: Act I: Co To Más Za Radost! [Grandmother / Jenufa]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:588f8d7d-6813-4b78-9c54-3027f7ea7745'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I: Starenko, Nehnevejte Se [Jenufa]', part.name_en = 'Jenufa: Act I: Starenko, Nehnevejte Se [Jenufa]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:798defee-bc96-4235-a6f1-351786310545' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:798defee-bc96-4235-a6f1-351786310545', 8, NULL, 'Act I: Starenko, Nehnevejte Se [Jenufa]', 'Jenufa: Act I: Starenko, Nehnevejte Se [Jenufa]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:798defee-bc96-4235-a6f1-351786310545'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Jednání I. Úvod', part.name_en = 'Jenůfa: Jednání I. Úvod',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7c27752b-44c8-48c7-8def-a1590bae3c54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c27752b-44c8-48c7-8def-a1590bae3c54', 9, NULL, 'Jednání I. Úvod', 'Jenůfa: Jednání I. Úvod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c27752b-44c8-48c7-8def-a1590bae3c54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I: Vy Starenko, Uz Tak Na Vselicos [Laca / Jenufa / Grandmother]', part.name_en = 'Jenufa: Act I: Vy Starenko, Uz Tak Na Vselicos [Laca / Jenufa / Grandmother]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7db1e78a-3198-44e1-ad78-71b810394136' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7db1e78a-3198-44e1-ad78-71b810394136', 10, NULL, 'Act I: Vy Starenko, Uz Tak Na Vselicos [Laca / Jenufa / Grandmother]', 'Jenufa: Act I: Vy Starenko, Uz Tak Na Vselicos [Laca / Jenufa / Grandmother]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7db1e78a-3198-44e1-ad78-71b810394136'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Jednání I. "Duša moja, Števo, Števuško!" (Jenůfa)', part.name_en = 'Jenůfa: Jednání I. "Duša moja, Števo, Števuško!" (Jenůfa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:8000e00d-2691-477e-a0ab-54d6f2b16707' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8000e00d-2691-477e-a0ab-54d6f2b16707', 11, NULL, 'Jednání I. "Duša moja, Števo, Števuško!" (Jenůfa)', 'Jenůfa: Jednání I. "Duša moja, Števo, Števuško!" (Jenůfa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8000e00d-2691-477e-a0ab-54d6f2b16707'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Jednání I. "Co to robíš, mládku?" (Stárek)', part.name_en = 'Jenůfa: Jednání I. "Co to robíš, mládku?" (Stárek)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:801c8d8b-7f94-4722-96c9-f2e1a53a140b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:801c8d8b-7f94-4722-96c9-f2e1a53a140b', 12, NULL, 'Jednání I. "Co to robíš, mládku?" (Stárek)', 'Jenůfa: Jednání I. "Co to robíš, mládku?" (Stárek)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:801c8d8b-7f94-4722-96c9-f2e1a53a140b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Jednání I. "Jak rázem všecko to Števkovo vypínání schlíplo" (Laca)', part.name_en = 'Jenůfa: Jednání I. "Jak rázem všecko to Števkovo vypínání schlíplo" (Laca)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:839b6a04-7100-40f8-9f90-00a83acc83cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:839b6a04-7100-40f8-9f90-00a83acc83cb', 13, NULL, 'Jednání I. "Jak rázem všecko to Števkovo vypínání schlíplo" (Laca)', 'Jenůfa: Jednání I. "Jak rázem všecko to Števkovo vypínání schlíplo" (Laca)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:839b6a04-7100-40f8-9f90-00a83acc83cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act I: Jaka Rázem Vsecko To Stekkovo', part.name_en = 'Jenufa: Act I: Jaka Rázem Vsecko To Stekkovo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9db2162f-fd54-412d-8af3-f2be7376b759' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9db2162f-fd54-412d-8af3-f2be7376b759', 14, NULL, 'Act I: Jaka Rázem Vsecko To Stekkovo', 'Jenufa: Act I: Jaka Rázem Vsecko To Stekkovo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9db2162f-fd54-412d-8af3-f2be7376b759'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act I: Jenufka, Ej [Jano / Jenufa]', part.name_en = 'Jenufa: Act I: Jenufka, Ej [Jano / Jenufa]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ba6ffcde-b9f8-48ad-999d-6e95f80e2515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba6ffcde-b9f8-48ad-999d-6e95f80e2515', 15, NULL, 'Act I: Jenufka, Ej [Jano / Jenufa]', 'Jenufa: Act I: Jenufka, Ej [Jano / Jenufa]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba6ffcde-b9f8-48ad-999d-6e95f80e2515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Jednání I. "Co ty, Jenůfo" (Stářenka)', part.name_en = 'Jenůfa: Jednání I. "Co ty, Jenůfo" (Stářenka)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d9f9451a-f9ae-40d5-9b0c-808251de496c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9f9451a-f9ae-40d5-9b0c-808251de496c', 16, NULL, 'Jednání I. "Co ty, Jenůfo" (Stářenka)', 'Jenůfa: Jednání I. "Co ty, Jenůfo" (Stářenka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9f9451a-f9ae-40d5-9b0c-808251de496c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act I: A On Na Tobe Nevidí [Laca / Jenufa / Grandmother / Miller / Barena]', part.name_en = 'Jenufa: Act I: A On Na Tobe Nevidí [Laca / Jenufa / Grandmother / Miller / Barena]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:da7f1230-6f44-455e-9101-e1633af56112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da7f1230-6f44-455e-9101-e1633af56112', 17, NULL, 'Act I: A On Na Tobe Nevidí [Laca / Jenufa / Grandmother / Miller / Barena]', 'Jenufa: Act I: A On Na Tobe Nevidí [Laca / Jenufa / Grandmother / Miller / Barena]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da7f1230-6f44-455e-9101-e1633af56112'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Act I: A Ty, Jenufo, Neplac, Neplac! [Grandmother / Miller / Laca / Millworkers]', part.name_en = 'Jenufa: Act I: A Ty, Jenufo, Neplac, Neplac! [Grandmother / Miller / Laca / Millworkers]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e479fa0c-66f6-4297-9edf-99852084eaf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e479fa0c-66f6-4297-9edf-99852084eaf9', 18, NULL, 'Act I: A Ty, Jenufo, Neplac, Neplac! [Grandmother / Miller / Laca / Millworkers]', 'Jenufa: Act I: A Ty, Jenufo, Neplac, Neplac! [Grandmother / Miller / Laca / Millworkers]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e479fa0c-66f6-4297-9edf-99852084eaf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Jednání I. "Už se večer chýli" (Jenůfa)', part.name_en = 'Jenůfa: Jednání I. "Už se večer chýli" (Jenůfa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 393 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ff5287d9-deea-4f99-a1ca-9d342af6f25a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff5287d9-deea-4f99-a1ca-9d342af6f25a', 19, NULL, 'Jednání I. "Už se večer chýli" (Jenůfa)', 'Jenůfa: Jednání I. "Už se večer chýli" (Jenůfa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1c9399-c5c3-4261-9544-8a060e0c25a5'
WHERE p.id = 393 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff5287d9-deea-4f99-a1ca-9d342af6f25a'
);


-- None 가곡 <Kantor Halfar>

UPDATE pieces piece
SET piece.title = '가곡 <Kantor Halfar>', piece.title_en = 'Kantor Halfar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7457 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 4/18 가곡 <Kačena divoká>

UPDATE pieces piece
SET piece.title = '가곡 <Kačena divoká>', piece.title_en = 'Kačena divoká, JW 4/18',
    piece.type = 'song', piece.opus_number = 'JW 4/18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7506 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kašpar Rucký

UPDATE pieces piece
SET piece.title = 'Kašpar Rucký', piece.title_en = 'Kašpar Rucký',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8512 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 6/12 Kozácek

UPDATE pieces piece
SET piece.title = 'Kozácek', piece.title_en = 'Kozácek, JW 6/12',
    piece.type = 'song', piece.opus_number = 'JW 6/12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7513 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Káťa Kabanová>

UPDATE pieces piece
SET piece.title = '오페라 <Káťa Kabanová>', piece.title_en = 'Káťa Kabanová',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7601 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Káťa Kabanová: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6', 1, NULL, 'Act I', 'Káťa Kabanová: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. "Chceš-li matky poslechnout..."', part.name_en = 'Káťa Kabanová: Act I. "Chceš-li matky poslechnout..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:2d5c4066-95e6-4764-9e19-01f064ded4bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d5c4066-95e6-4764-9e19-01f064ded4bf', 1, NULL, 'Act I. "Chceš-li matky poslechnout..."', 'Káťa Kabanová: Act I. "Chceš-li matky poslechnout..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d5c4066-95e6-4764-9e19-01f064ded4bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. Intermezzo', part.name_en = 'Káťa Kabanová: Act I. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3969a1b6-183a-4d2e-8208-dfd7d8774b0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3969a1b6-183a-4d2e-8208-dfd7d8774b0d', 2, NULL, 'Act I. Intermezzo', 'Káťa Kabanová: Act I. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3969a1b6-183a-4d2e-8208-dfd7d8774b0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. "Copak s ním máte za jednání?"', part.name_en = 'Káťa Kabanová: Act I. "Copak s ním máte za jednání?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3e0a3249-b437-446c-8516-a6145ab7b6c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e0a3249-b437-446c-8516-a6145ab7b6c8', 3, NULL, 'Act I. "Copak s ním máte za jednání?"', 'Káťa Kabanová: Act I. "Copak s ním máte za jednání?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e0a3249-b437-446c-8516-a6145ab7b6c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. "Darmochlebe!"', part.name_en = 'Káťa Kabanová: Act I. "Darmochlebe!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:90c006a3-3ef9-418a-a43a-85a82a1b76e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:90c006a3-3ef9-418a-a43a-85a82a1b76e3', 4, NULL, 'Act I. "Darmochlebe!"', 'Káťa Kabanová: Act I. "Darmochlebe!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90c006a3-3ef9-418a-a43a-85a82a1b76e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. "Zázrak! Vskutku, třeba říci..."', part.name_en = 'Káťa Kabanová: Act I. "Zázrak! Vskutku, třeba říci..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9dcacd05-f17d-457c-9933-4335236b1e9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9dcacd05-f17d-457c-9933-4335236b1e9d', 5, NULL, 'Act I. "Zázrak! Vskutku, třeba říci..."', 'Káťa Kabanová: Act I. "Zázrak! Vskutku, třeba říci..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dcacd05-f17d-457c-9933-4335236b1e9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. "Víš, co mi napadlo?"', part.name_en = 'Káťa Kabanová: Act I. "Víš, co mi napadlo?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b7e71c6d-3b04-4124-bd54-f04a77fc525b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b7e71c6d-3b04-4124-bd54-f04a77fc525b', 6, NULL, 'Act I. "Víš, co mi napadlo?"', 'Káťa Kabanová: Act I. "Víš, co mi napadlo?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7e71c6d-3b04-4124-bd54-f04a77fc525b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. "Ale nač tobě to vykládám?"', part.name_en = 'Káťa Kabanová: Act I. "Ale nač tobě to vykládám?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e7b17276-c6e1-4e55-a13f-745ff067d569' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7b17276-c6e1-4e55-a13f-745ff067d569', 7, NULL, 'Act I. "Ale nač tobě to vykládám?"', 'Káťa Kabanová: Act I. "Ale nač tobě to vykládám?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7b17276-c6e1-4e55-a13f-745ff067d569'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. Introduction', part.name_en = 'Káťa Kabanová: Act I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:f1a9669e-15e7-44cf-8f85-fdd3472e5893' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1a9669e-15e7-44cf-8f85-fdd3472e5893', 8, NULL, 'Act I. Introduction', 'Káťa Kabanová: Act I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c84ec9d8-c0aa-4bc8-9bf6-7be2445452c6'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1a9669e-15e7-44cf-8f85-fdd3472e5893'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Káťa Kabanová: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61', 2, NULL, 'Act II', 'Káťa Kabanová: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. "Vida! Neštěstí!"', part.name_en = 'Káťa Kabanová: Act II. "Vida! Neštěstí!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1acc6a1d-bf1b-414b-9e50-0f793e0b9faa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1acc6a1d-bf1b-414b-9e50-0f793e0b9faa', 1, NULL, 'Act II. "Vida! Neštěstí!"', 'Káťa Kabanová: Act II. "Vida! Neštěstí!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1acc6a1d-bf1b-414b-9e50-0f793e0b9faa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II. "Za vodou, za vodičkou..."', part.name_en = 'Káťa Kabanová: Act II. "Za vodou, za vodičkou..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:584fd4ed-a545-4341-ad16-bc14673ce948' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:584fd4ed-a545-4341-ad16-bc14673ce948', 2, NULL, 'Act II. "Za vodou, za vodičkou..."', 'Káťa Kabanová: Act II. "Za vodou, za vodičkou..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:584fd4ed-a545-4341-ad16-bc14673ce948'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II. "Všecko domů, domů..."', part.name_en = 'Káťa Kabanová: Act II. "Všecko domů, domů..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:69ab9a3c-d973-4aca-a3e2-d2cac8260f40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69ab9a3c-d973-4aca-a3e2-d2cac8260f40', 3, NULL, 'Act II. "Všecko domů, domů..."', 'Káťa Kabanová: Act II. "Všecko domů, domů..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ab9a3c-d973-4aca-a3e2-d2cac8260f40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II. "To jste si vymysleli pěknou věc!"', part.name_en = 'Káťa Kabanová: Act II. "To jste si vymysleli pěknou věc!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:753089b3-4c98-4ec1-9f62-41ee49724a0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:753089b3-4c98-4ec1-9f62-41ee49724a0d', 4, NULL, 'Act II. "To jste si vymysleli pěknou věc!"', 'Káťa Kabanová: Act II. "To jste si vymysleli pěknou věc!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:753089b3-4c98-4ec1-9f62-41ee49724a0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II. "Půjdu též se projít!"', part.name_en = 'Káťa Kabanová: Act II. "Půjdu též se projít!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:902306ff-32da-437a-b4d7-6efdbd976613' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:902306ff-32da-437a-b4d7-6efdbd976613', 5, NULL, 'Act II. "Půjdu též se projít!"', 'Káťa Kabanová: Act II. "Půjdu též se projít!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:902306ff-32da-437a-b4d7-6efdbd976613'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act II. "Nic zvláštního..."', part.name_en = 'Káťa Kabanová: Act II. "Nic zvláštního..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c56774b8-8d84-4dcc-85cc-31066c65acec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c56774b8-8d84-4dcc-85cc-31066c65acec', 6, NULL, 'Act II. "Nic zvláštního..."', 'Káťa Kabanová: Act II. "Nic zvláštního..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c56774b8-8d84-4dcc-85cc-31066c65acec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II. "Nikoho tu není!"', part.name_en = 'Káťa Kabanová: Act II. "Nikoho tu není!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:dd4b45d2-52d4-408f-a194-78c7ae6c066f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd4b45d2-52d4-408f-a194-78c7ae6c066f', 7, NULL, 'Act II. "Nikoho tu není!"', 'Káťa Kabanová: Act II. "Nikoho tu není!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd4b45d2-52d4-408f-a194-78c7ae6c066f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act II. "Jste to vy, Katěrino Petrovno?"', part.name_en = 'Káťa Kabanová: Act II. "Jste to vy, Katěrino Petrovno?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:eeeb3efe-d1e5-45a0-9acf-8bb39a4658e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eeeb3efe-d1e5-45a0-9acf-8bb39a4658e2', 8, NULL, 'Act II. "Jste to vy, Katěrino Petrovno?"', 'Káťa Kabanová: Act II. "Jste to vy, Katěrino Petrovno?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeeb3efe-d1e5-45a0-9acf-8bb39a4658e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II. Intermezzo', part.name_en = 'Káťa Kabanová: Act II. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fa8939f9-90f3-4db1-98de-59e187edd241' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa8939f9-90f3-4db1-98de-59e187edd241', 9, NULL, 'Act II. Intermezzo', 'Káťa Kabanová: Act II. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8939f9-90f3-4db1-98de-59e187edd241'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II. "Vida chvástala jsi se..."', part.name_en = 'Káťa Kabanová: Act II. "Vida chvástala jsi se..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fc71a044-d4fb-4efb-ac0f-fccce57d29fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc71a044-d4fb-4efb-ac0f-fccce57d29fa', 10, NULL, 'Act II. "Vida chvástala jsi se..."', 'Káťa Kabanová: Act II. "Vida chvástala jsi se..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdef06a0-981d-46d0-96dc-2a9107a37b61'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc71a044-d4fb-4efb-ac0f-fccce57d29fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Káťa Kabanová: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7', 3, NULL, 'Act III', 'Káťa Kabanová: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III. "Ale smrt nepřichází..."', part.name_en = 'Káťa Kabanová: Act III. "Ale smrt nepřichází..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:2c06eb8c-3cf1-4db4-a6f7-f167db33b6cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c06eb8c-3cf1-4db4-a6f7-f167db33b6cd', 1, NULL, 'Act III. "Ale smrt nepřichází..."', 'Káťa Kabanová: Act III. "Ale smrt nepřichází..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c06eb8c-3cf1-4db4-a6f7-f167db33b6cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III. "Krápe! - Přijde bouře"', part.name_en = 'Káťa Kabanová: Act III. "Krápe! - Přijde bouře"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3d4d13e0-e1be-485a-babe-0768b71f3c58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d4d13e0-e1be-485a-babe-0768b71f3c58', 2, NULL, 'Act III. "Krápe! - Přijde bouře"', 'Káťa Kabanová: Act III. "Krápe! - Přijde bouře"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d4d13e0-e1be-485a-babe-0768b71f3c58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III. "Vidět se s ním, rozloučit..."', part.name_en = 'Káťa Kabanová: Act III. "Vidět se s ním, rozloučit..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:403933ae-6ca8-4301-b6c2-4c3d6e801ac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:403933ae-6ca8-4301-b6c2-4c3d6e801ac6', 3, NULL, 'Act III. "Vidět se s ním, rozloučit..."', 'Káťa Kabanová: Act III. "Vidět se s ním, rozloučit..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:403933ae-6ca8-4301-b6c2-4c3d6e801ac6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III. "Ach, Glašo!"', part.name_en = 'Káťa Kabanová: Act III. "Ach, Glašo!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:5fec449c-7669-4f7d-8bb2-9faa1c820f60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5fec449c-7669-4f7d-8bb2-9faa1c820f60', 4, NULL, 'Act III. "Ach, Glašo!"', 'Káťa Kabanová: Act III. "Ach, Glašo!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fec449c-7669-4f7d-8bb2-9faa1c820f60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III. "Nějaká ženská skočila do vody!"', part.name_en = 'Káťa Kabanová: Act III. "Nějaká ženská skočila do vody!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7c9c7023-a172-4f20-9cb2-52782aee492b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c9c7023-a172-4f20-9cb2-52782aee492b', 5, NULL, 'Act III. "Nějaká ženská skočila do vody!"', 'Káťa Kabanová: Act III. "Nějaká ženská skočila do vody!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c9c7023-a172-4f20-9cb2-52782aee492b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act III. "Pst! Pst! Zdá se, že je to on!"', part.name_en = 'Káťa Kabanová: Act III. "Pst! Pst! Zdá se, že je to on!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7601 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:af687cad-fe1e-4a6f-be6f-2f29e6d097ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af687cad-fe1e-4a6f-be6f-2f29e6d097ad', 6, NULL, 'Act III. "Pst! Pst! Zdá se, že je to on!"', 'Káťa Kabanová: Act III. "Pst! Pst! Zdá se, že je to on!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6b3edeb0-f425-4c8b-b341-c30e4d7e62e7'
WHERE p.id = 7601 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af687cad-fe1e-4a6f-be6f-2f29e6d097ad'
);


-- JW 4/8 가곡 <Láska opravdivá>

UPDATE pieces piece
SET piece.title = '가곡 <Láska opravdivá>', piece.title_en = 'Láska opravdivá, JW 4/8',
    piece.type = 'song', piece.opus_number = 'JW 4/8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7477 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Maryčka Magdónova, JW IV/34>

UPDATE pieces piece
SET piece.title = '가곡 <Maryčka Magdónova, JW IV/34>', piece.title_en = 'Maryčka Magdónova, JW IV/34',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10690 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Moravian Dances: Dymák - Starodávný - Valaška - Požehnanyý - Pilky Kalamajka - Trojky - Sekerečka - Kolo - Čeladenský

UPDATE pieces piece
SET piece.title = 'Moravian Dances: Dymák - Starodávný - Valaška - Požehnanyý - Pilky Kalamajka - Trojky - Sekerečka - Kolo - Čeladenský', piece.title_en = 'Moravian Dances: Dymák - Starodávný - Valaška - Požehnanyý - Pilky Kalamajka - Trojky - Sekerečka - Kolo - Čeladenský',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10132 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 5/2 Moravská lidová poezie v písních JW 5/2

UPDATE pieces piece
SET piece.title = 'Moravská lidová poezie v písních JW 5/2', piece.title_en = 'Moravská lidová poezie v písních, JW 5/2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'JW', piece.catalogue_number = '5/2',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8684 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Památky, JW V/2 No. 22', part.name_en = 'Památky, JW V/2 No. 22',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0460ca49-d239-4b48-8f14-b40f3c9d14d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0460ca49-d239-4b48-8f14-b40f3c9d14d1', 1, NULL, 'Památky, JW V/2 No. 22', 'Památky, JW V/2 No. 22', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0460ca49-d239-4b48-8f14-b40f3c9d14d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Muzikanti, JW V/2 No. 50', part.name_en = 'Muzikanti, JW V/2 No. 50',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:15e963d9-c8ae-4504-a08c-e3fc047978c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15e963d9-c8ae-4504-a08c-e3fc047978c6', 2, NULL, 'Muzikanti, JW V/2 No. 50', 'Muzikanti, JW V/2 No. 50', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15e963d9-c8ae-4504-a08c-e3fc047978c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Loucení', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 38. Loucení',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1acfd84f-3fc2-4a05-9889-2b46b90e5d51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1acfd84f-3fc2-4a05-9889-2b46b90e5d51', 3, NULL, 'Loucení', 'Moravská lidová poezie v písních, JW 5/2: No. 38. Loucení', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1acfd84f-3fc2-4a05-9889-2b46b90e5d51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Záře od milého, JW V/2 No. 4', part.name_en = 'Záře od milého, JW V/2 No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:23d1c762-dbbe-4652-9949-5b3ed361fdc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23d1c762-dbbe-4652-9949-5b3ed361fdc0', 4, NULL, 'Záře od milého, JW V/2 No. 4', 'Záře od milého, JW V/2 No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23d1c762-dbbe-4652-9949-5b3ed361fdc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Rozmarýn, JW V/2 No. 30', part.name_en = 'Rozmarýn, JW V/2 No. 30',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:240cf599-f8c1-499b-a116-501c64b29ebf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:240cf599-f8c1-499b-a116-501c64b29ebf', 5, NULL, 'Rozmarýn, JW V/2 No. 30', 'Rozmarýn, JW V/2 No. 30', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240cf599-f8c1-499b-a116-501c64b29ebf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Obrázek milého', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 5. Obrázek milého',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:52cae44b-85ef-402e-bcee-eb6c5206910a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52cae44b-85ef-402e-bcee-eb6c5206910a', 6, NULL, 'Obrázek milého', 'Moravská lidová poezie v písních, JW 5/2: No. 5. Obrázek milého', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52cae44b-85ef-402e-bcee-eb6c5206910a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Nejistota, JW V/2 No. 28', part.name_en = 'Nejistota, JW V/2 No. 28',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:617753d0-5963-4330-87a0-897e01eb9226' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:617753d0-5963-4330-87a0-897e01eb9226', 7, NULL, 'Nejistota, JW V/2 No. 28', 'Nejistota, JW V/2 No. 28', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:617753d0-5963-4330-87a0-897e01eb9226'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Pérecko', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 19. Pérecko',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7b512d2c-2e50-4271-a873-dcd248822b01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b512d2c-2e50-4271-a873-dcd248822b01', 8, NULL, 'Pérecko', 'Moravská lidová poezie v písních, JW 5/2: No. 19. Pérecko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b512d2c-2e50-4271-a873-dcd248822b01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Polajka, JW V/2 No. 8', part.name_en = 'Polajka, JW V/2 No. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7d427ba4-3d89-4ae0-abcc-053cd767b11c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d427ba4-3d89-4ae0-abcc-053cd767b11c', 9, NULL, 'Polajka, JW V/2 No. 8', 'Polajka, JW V/2 No. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d427ba4-3d89-4ae0-abcc-053cd767b11c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Lavečka, JW V/2 no. 37', part.name_en = 'Lavečka, JW V/2 no. 37',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7d8cb7da-d6e5-4f5a-90fa-15fd03763a56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d8cb7da-d6e5-4f5a-90fa-15fd03763a56', 10, NULL, 'Lavečka, JW V/2 no. 37', 'Lavečka, JW V/2 no. 37', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d8cb7da-d6e5-4f5a-90fa-15fd03763a56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Hájny', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 27. Hájny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7ef2aa54-53c6-45f1-b81c-667822235a45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ef2aa54-53c6-45f1-b81c-667822235a45', 11, NULL, 'Hájny', 'Moravská lidová poezie v písních, JW 5/2: No. 27. Hájny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ef2aa54-53c6-45f1-b81c-667822235a45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Stálost’', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 16. Stálost’',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:871de0e0-331e-4c23-bb0b-e786b066465d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:871de0e0-331e-4c23-bb0b-e786b066465d', 12, NULL, 'Stálost’', 'Moravská lidová poezie v písních, JW 5/2: No. 16. Stálost’', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:871de0e0-331e-4c23-bb0b-e786b066465d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Láska', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 1. Láska',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:90ab8837-1ded-4711-9ed1-dd13b421a716' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90ab8837-1ded-4711-9ed1-dd13b421a716', 13, NULL, 'Láska', 'Moravská lidová poezie v písních, JW 5/2: No. 1. Láska', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90ab8837-1ded-4711-9ed1-dd13b421a716'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Komu kytka', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 17. Komu kytka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9d82f0e3-fbe4-46aa-a024-31655f3c529b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d82f0e3-fbe4-46aa-a024-31655f3c529b', 14, NULL, 'Komu kytka', 'Moravská lidová poezie v písních, JW 5/2: No. 17. Komu kytka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d82f0e3-fbe4-46aa-a024-31655f3c529b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Tužba, JW V/2 No. 20', part.name_en = 'Tužba, JW V/2 No. 20',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b99ad292-d88f-476f-b235-b528f87f27ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b99ad292-d88f-476f-b235-b528f87f27ee', 15, NULL, 'Tužba, JW V/2 No. 20', 'Tužba, JW V/2 No. 20', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b99ad292-d88f-476f-b235-b528f87f27ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Bolavá hlava', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 47. Bolavá hlava',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:dcb74658-5e1e-4adb-a78a-d75e34a790d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb74658-5e1e-4adb-a78a-d75e34a790d0', 16, NULL, 'Bolavá hlava', 'Moravská lidová poezie v písních, JW 5/2: No. 47. Bolavá hlava', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb74658-5e1e-4adb-a78a-d75e34a790d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Psanícko', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 29. Psanícko',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e61cf56b-a8c6-496d-96d4-1d81b2103f29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e61cf56b-a8c6-496d-96d4-1d81b2103f29', 17, NULL, 'Psanícko', 'Moravská lidová poezie v písních, JW 5/2: No. 29. Psanícko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e61cf56b-a8c6-496d-96d4-1d81b2103f29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Konícky milého "Dybych já vedela"', part.name_en = 'Moravská lidová poezie v písních, JW 5/2: No. 18. Konícky milého "Dybych já vedela"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e896d0c8-27d6-457e-809d-e43cad11de40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e896d0c8-27d6-457e-809d-e43cad11de40', 18, NULL, 'Konícky milého "Dybych já vedela"', 'Moravská lidová poezie v písních, JW 5/2: No. 18. Konícky milého "Dybych já vedela"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e896d0c8-27d6-457e-809d-e43cad11de40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Jabúcko, JW V/2 no. 12', part.name_en = 'Jabúcko, JW V/2 no. 12',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ed6757e1-034a-47c0-9e25-fe62bf0f59ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed6757e1-034a-47c0-9e25-fe62bf0f59ee', 19, NULL, 'Jabúcko, JW V/2 no. 12', 'Jabúcko, JW V/2 no. 12', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed6757e1-034a-47c0-9e25-fe62bf0f59ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Pomluva, JW V/2 No. 33', part.name_en = 'Pomluva, JW V/2 No. 33',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8684 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:edc28dfa-e1c4-4383-b824-d7682af9db11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edc28dfa-e1c4-4383-b824-d7682af9db11', 20, NULL, 'Pomluva, JW V/2 No. 33', 'Pomluva, JW V/2 No. 33', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8684 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edc28dfa-e1c4-4383-b824-d7682af9db11'
);


-- JW 6/7 Moravské tance

UPDATE pieces piece
SET piece.title = 'Moravské tance', piece.title_en = 'Moravské tance, JW 6/7',
    piece.type = 'album', piece.opus_number = 'JW 6/7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7606 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kožich', part.name_en = 'Moravian Dances: I. Kožich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7606 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:89b116e1-ce8b-40fe-80fc-79cd652ac682' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89b116e1-ce8b-40fe-80fc-79cd652ac682', 1, 'I', 'Kožich', 'Moravian Dances: I. Kožich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7606 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89b116e1-ce8b-40fe-80fc-79cd652ac682'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Kalamajka', part.name_en = 'Moravian Dances: II. Kalamajka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7606 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:37ea76ae-ba1d-4730-ad97-92ed0c0e74dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37ea76ae-ba1d-4730-ad97-92ed0c0e74dc', 2, 'II', 'Kalamajka', 'Moravian Dances: II. Kalamajka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7606 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37ea76ae-ba1d-4730-ad97-92ed0c0e74dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Trojky', part.name_en = 'Moravian Dances: III. Trojky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7606 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:bdde12fa-7be2-4c47-ab38-d03ea88bb67e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdde12fa-7be2-4c47-ab38-d03ea88bb67e', 3, 'III', 'Trojky', 'Moravian Dances: III. Trojky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7606 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdde12fa-7be2-4c47-ab38-d03ea88bb67e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Silnice', part.name_en = 'Moravian Dances: IV. Silnice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7606 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ae7a485e-f5da-4f7e-8b3e-2f413b773fbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae7a485e-f5da-4f7e-8b3e-2f413b773fbf', 4, 'IV', 'Silnice', 'Moravian Dances: IV. Silnice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7606 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae7a485e-f5da-4f7e-8b3e-2f413b773fbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Rožek', part.name_en = 'Moravian Dances: V. Rožek',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7606 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4ed2f589-9fa1-4eae-9024-6b09c0bd7403' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ed2f589-9fa1-4eae-9024-6b09c0bd7403', 5, 'V', 'Rožek', 'Moravian Dances: V. Rožek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7606 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ed2f589-9fa1-4eae-9024-6b09c0bd7403'
);


-- None Music for the Gymnastics

UPDATE pieces piece
SET piece.title = 'Music for the Gymnastics', piece.title_en = 'Music for the Gymnastics',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9402 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Na památku

UPDATE pieces piece
SET piece.title = 'Na památku', piece.title_en = 'Na památku',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7552 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None On an Overgrown Path

UPDATE pieces piece
SET piece.title = 'On an Overgrown Path', piece.title_en = 'On an Overgrown Path',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7434 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Book 1', part.name_en = 'On an Overgrown Path, Book 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8', 1, NULL, 'Book 1', 'On an Overgrown Path, Book 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Our Evenings', part.name_en = 'On an Overgrown Path, Book 1: No. 1. Our Evenings',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:16311f86-d8f9-3a01-a7d8-ab781e58a20b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16311f86-d8f9-3a01-a7d8-ab781e58a20b', 1, NULL, 'Our Evenings', 'On an Overgrown Path, Book 1: No. 1. Our Evenings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16311f86-d8f9-3a01-a7d8-ab781e58a20b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Come With Us!', part.name_en = 'On an Overgrown Path, Book 1: No. 3. Come With Us!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b5005649-e30c-33f3-bfe7-6e64de1104a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5005649-e30c-33f3-bfe7-6e64de1104a7', 2, NULL, 'Come With Us!', 'On an Overgrown Path, Book 1: No. 3. Come With Us!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5005649-e30c-33f3-bfe7-6e64de1104a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Madonna of Frýdek', part.name_en = 'On an Overgrown Path, Book 1: No. 4. The Madonna of Frýdek',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e93cfc03-05ee-3bba-87c9-bc65d392dac9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e93cfc03-05ee-3bba-87c9-bc65d392dac9', 3, NULL, 'The Madonna of Frýdek', 'On an Overgrown Path, Book 1: No. 4. The Madonna of Frýdek', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e93cfc03-05ee-3bba-87c9-bc65d392dac9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'They Chattered Like Swallows', part.name_en = 'On an Overgrown Path, Book 1: No. 5. They Chattered Like Swallows',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d3b33d63-44ad-3607-b9b7-e3506077befc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3b33d63-44ad-3607-b9b7-e3506077befc', 4, NULL, 'They Chattered Like Swallows', 'On an Overgrown Path, Book 1: No. 5. They Chattered Like Swallows', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3b33d63-44ad-3607-b9b7-e3506077befc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Words Fail!', part.name_en = 'On an Overgrown Path, Book 1: No. 6. Words Fail!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4790877d-80d6-3dff-8248-f5f7f28457de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4790877d-80d6-3dff-8248-f5f7f28457de', 5, NULL, 'Words Fail!', 'On an Overgrown Path, Book 1: No. 6. Words Fail!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4790877d-80d6-3dff-8248-f5f7f28457de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Good Night!', part.name_en = 'On an Overgrown Path, Book 1: No. 7. Good Night!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7858cd4a-9288-3cf7-9b5e-01c24d70ee24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7858cd4a-9288-3cf7-9b5e-01c24d70ee24', 6, NULL, 'Good Night!', 'On an Overgrown Path, Book 1: No. 7. Good Night!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7858cd4a-9288-3cf7-9b5e-01c24d70ee24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Unutterable Anguish', part.name_en = 'On an Overgrown Path, Book 1: No. 8. Unutterable Anguish',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:feacd4e4-2503-315b-941b-4eebc3af9b5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:feacd4e4-2503-315b-941b-4eebc3af9b5a', 7, NULL, 'Unutterable Anguish', 'On an Overgrown Path, Book 1: No. 8. Unutterable Anguish', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feacd4e4-2503-315b-941b-4eebc3af9b5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'In Tears', part.name_en = 'On an Overgrown Path, Book 1: No. 9. In Tears',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c428b585-8785-3dcd-8733-e02a43b467e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c428b585-8785-3dcd-8733-e02a43b467e0', 8, NULL, 'In Tears', 'On an Overgrown Path, Book 1: No. 9. In Tears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c428b585-8785-3dcd-8733-e02a43b467e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Barn Owl Has Not Flown Away!', part.name_en = 'On an Overgrown Path, Book 1: No. 10. The Barn Owl Has Not Flown Away!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:53cac05a-3c82-38e5-ad69-76254c9f57cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53cac05a-3c82-38e5-ad69-76254c9f57cc', 9, NULL, 'The Barn Owl Has Not Flown Away!', 'On an Overgrown Path, Book 1: No. 10. The Barn Owl Has Not Flown Away!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:276c05fb-c53e-4107-aeef-3efea0bae6d8'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53cac05a-3c82-38e5-ad69-76254c9f57cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Book 2', part.name_en = 'On an Overgrown Path, Book 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7', 2, NULL, 'Book 2', 'On an Overgrown Path, Book 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'On an Overgrown Path, Book 2: No. 1. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:2ae3bcf2-ccad-3ad0-88d1-cd25e1f519b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ae3bcf2-ccad-3ad0-88d1-cd25e1f519b3', 1, NULL, 'Andante', 'On an Overgrown Path, Book 2: No. 1. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ae3bcf2-ccad-3ad0-88d1-cd25e1f519b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'On an Overgrown Path, Book 2: No. 2. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1695d2e0-acc3-3137-9130-4195f2af8b08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1695d2e0-acc3-3137-9130-4195f2af8b08', 2, NULL, 'Allegretto', 'On an Overgrown Path, Book 2: No. 2. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1695d2e0-acc3-3137-9130-4195f2af8b08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Più mosso', part.name_en = 'On an Overgrown Path, Book 2: No. 3. Più mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:17fc7b0e-7348-3302-8ffc-39f6218e424c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17fc7b0e-7348-3302-8ffc-39f6218e424c', 3, NULL, 'Più mosso', 'On an Overgrown Path, Book 2: No. 3. Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17fc7b0e-7348-3302-8ffc-39f6218e424c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'On an Overgrown Path, Book 2: No. 5. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7434 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:19d482de-b523-3898-a89d-c7dadaf3a567' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:19d482de-b523-3898-a89d-c7dadaf3a567', 4, NULL, 'Allegro', 'On an Overgrown Path, Book 2: No. 5. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:85275fb7-9009-4849-a989-600abde729c7'
WHERE p.id = 7434 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19d482de-b523-3898-a89d-c7dadaf3a567'
);


-- None 가곡 <Orání, JW IV/1>

UPDATE pieces piece
SET piece.title = '가곡 <Orání, JW IV/1>', piece.title_en = 'Orání, JW IV/1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7462 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 1/5 Osud

UPDATE pieces piece
SET piece.title = 'Osud', piece.title_en = 'Osud, JW 1/5',
    piece.type = 'song', piece.opus_number = 'JW 1/5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7455 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <Otče náš>

UPDATE pieces piece
SET piece.title = '칸타타 <Otče náš>', piece.title_en = 'Otče náš',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7450 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Otče náš', part.name_en = 'Otče náš: I. Otče náš',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7450 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:75c6b277-ff53-495a-968e-ad046f180309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75c6b277-ff53-495a-968e-ad046f180309', 1, 'I', 'Otče náš', 'Otče náš: I. Otče náš', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7450 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75c6b277-ff53-495a-968e-ad046f180309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Bud'' vůle tvá', part.name_en = 'Otče náš: II. Bud'' vůle tvá',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7450 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1842ec1b-4230-4b30-851e-524cbfae383a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1842ec1b-4230-4b30-851e-524cbfae383a', 2, 'II', 'Bud'' vůle tvá', 'Otče náš: II. Bud'' vůle tvá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7450 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1842ec1b-4230-4b30-851e-524cbfae383a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chléb náš', part.name_en = 'Otče náš: III. Chléb náš',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7450 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3c6143b5-2225-46e0-800b-b29c3bb28523' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c6143b5-2225-46e0-800b-b29c3bb28523', 3, 'III', 'Chléb náš', 'Otče náš: III. Chléb náš', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7450 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c6143b5-2225-46e0-800b-b29c3bb28523'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'A odpust'' nám', part.name_en = 'Otče náš: IV. A odpust'' nám',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7450 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fbadade5-d77f-48ea-96c8-8e556deaa911' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbadade5-d77f-48ea-96c8-8e556deaa911', 4, 'IV', 'A odpust'' nám', 'Otče náš: IV. A odpust'' nám', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7450 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbadade5-d77f-48ea-96c8-8e556deaa911'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Neuvod'' nás', part.name_en = 'Otče náš: V. Neuvod'' nás',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7450 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c3751f3a-4f6a-46e9-acde-a5fec5fb76b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3751f3a-4f6a-46e9-acde-a5fec5fb76b6', 5, 'V', 'Neuvod'' nás', 'Otče náš: V. Neuvod'' nás', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7450 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3751f3a-4f6a-46e9-acde-a5fec5fb76b6'
);


-- None 가곡 <Perina, JW IV/38>

UPDATE pieces piece
SET piece.title = '가곡 <Perina, JW IV/38>', piece.title_en = 'Perina, JW IV/38',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7472 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pochod modráčků

UPDATE pieces piece
SET piece.title = 'Pochod modráčků', piece.title_en = 'Pochod modráčků',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7526 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 7/9 Pochod modráčků JW 7/9

UPDATE pieces piece
SET piece.title = 'Pochod modráčků JW 7/9', piece.title_en = 'Pochod modráčků, JW 7/9',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'JW', piece.catalogue_number = '7/9',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8542 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Potulný šílenec, JW IV/43>

UPDATE pieces piece
SET piece.title = '가곡 <Potulný šílenec, JW IV/43>', piece.title_en = 'Potulný šílenec, JW IV/43',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7576 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 7/6 Presto for cello & piano

UPDATE pieces piece
SET piece.title = 'Presto for cello & piano', piece.title_en = 'Presto for cello & piano, JW 7/6',
    piece.type = 'song', piece.opus_number = 'JW 7/6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10750 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Putování dušičky

UPDATE pieces piece
SET piece.title = 'Putování dušičky', piece.title_en = 'Putování dušičky',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7516 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Příhody lišky Bystroušky>

UPDATE pieces piece
SET piece.title = '오페라 <Příhody lišky Bystroušky>', piece.title_en = 'Příhody lišky Bystroušky',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7604 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'JW I/9: Act I', part.name_en = 'Příhody lišky Bystroušky, JW I/9: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd', 1, NULL, 'JW I/9: Act I', 'Příhody lišky Bystroušky, JW I/9: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. Prelude', part.name_en = 'The Cunning Little Vixen: Act I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:743825e6-19f9-42e1-8b6d-fef9904d5810' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:743825e6-19f9-42e1-8b6d-fef9904d5810', 1, NULL, 'Act I. Prelude', 'The Cunning Little Vixen: Act I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:743825e6-19f9-42e1-8b6d-fef9904d5810'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. “Dostaneme bouřku” (Revírník)', part.name_en = 'The Cunning Little Vixen: Act I. “Dostaneme bouřku” (Revírník)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:21a0e321-6fe2-4045-b86a-1214c64f257e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21a0e321-6fe2-4045-b86a-1214c64f257e', 2, NULL, 'Act I. “Dostaneme bouřku” (Revírník)', 'The Cunning Little Vixen: Act I. “Dostaneme bouřku” (Revírník)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21a0e321-6fe2-4045-b86a-1214c64f257e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I. “Kmotřenka zakoncertovala si také?” (Cvrček)', part.name_en = 'The Cunning Little Vixen: Act I. “Kmotřenka zakoncertovala si také?” (Cvrček)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c203c37c-f264-49aa-b192-0da7ef2242a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c203c37c-f264-49aa-b192-0da7ef2242a1', 3, NULL, 'Act I. “Kmotřenka zakoncertovala si také?” (Cvrček)', 'The Cunning Little Vixen: Act I. “Kmotřenka zakoncertovala si také?” (Cvrček)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c203c37c-f264-49aa-b192-0da7ef2242a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act I. “Mami!” (Bystrouška)', part.name_en = 'The Cunning Little Vixen: Act I. “Mami!” (Bystrouška)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:021729d8-405f-48b6-b0ff-fc0d506cd326' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:021729d8-405f-48b6-b0ff-fc0d506cd326', 4, NULL, 'Act I. “Mami!” (Bystrouška)', 'The Cunning Little Vixen: Act I. “Mami!” (Bystrouška)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:021729d8-405f-48b6-b0ff-fc0d506cd326'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act I. Pantomime #1', part.name_en = 'The Cunning Little Vixen: Act I. Pantomime #1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:db82352e-c60a-4739-82ee-b4c0ffc1342d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db82352e-c60a-4739-82ee-b4c0ffc1342d', 5, NULL, 'Act I. Pantomime #1', 'The Cunning Little Vixen: Act I. Pantomime #1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db82352e-c60a-4739-82ee-b4c0ffc1342d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act I. Interlude #1 (Na dvore jézerské myslivny)', part.name_en = 'The Cunning Little Vixen: Act I. Interlude #1 (Na dvore jézerské myslivny)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:11235fde-8e11-4fa4-aaba-5013c5c7c13b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11235fde-8e11-4fa4-aaba-5013c5c7c13b', 6, NULL, 'Act I. Interlude #1 (Na dvore jézerské myslivny)', 'The Cunning Little Vixen: Act I. Interlude #1 (Na dvore jézerské myslivny)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11235fde-8e11-4fa4-aaba-5013c5c7c13b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act I. “To čučíc Lapáku!?” (Revírník)', part.name_en = 'The Cunning Little Vixen: Act I. “To čučíc Lapáku!?” (Revírník)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:8d49bd0f-8cf7-43ee-95a1-71b3fb076b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d49bd0f-8cf7-43ee-95a1-71b3fb076b21', 7, NULL, 'Act I. “To čučíc Lapáku!?” (Revírník)', 'The Cunning Little Vixen: Act I. “To čučíc Lapáku!?” (Revírník)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d49bd0f-8cf7-43ee-95a1-71b3fb076b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act I. “Ze neviš, co máme?” (Pepík)', part.name_en = 'The Cunning Little Vixen: Act I. “Ze neviš, co máme?” (Pepík)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3dc6e0f3-75ba-4612-b388-b4bfa8e951b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3dc6e0f3-75ba-4612-b388-b4bfa8e951b4', 8, NULL, 'Act I. “Ze neviš, co máme?” (Pepík)', 'The Cunning Little Vixen: Act I. “Ze neviš, co máme?” (Pepík)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dc6e0f3-75ba-4612-b388-b4bfa8e951b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act I. Pantomime #2', part.name_en = 'The Cunning Little Vixen: Act I. Pantomime #2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:194fec99-f9e5-428c-a26d-981f62257792' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:194fec99-f9e5-428c-a26d-981f62257792', 9, NULL, 'Act I. Pantomime #2', 'The Cunning Little Vixen: Act I. Pantomime #2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:194fec99-f9e5-428c-a26d-981f62257792'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act I. Interlude #2 (Svitáni)', part.name_en = 'The Cunning Little Vixen: Act I. Interlude #2 (Svitáni)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:daa09f83-67e9-48d3-b285-791d8ce0e9b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:daa09f83-67e9-48d3-b285-791d8ce0e9b9', 10, NULL, 'Act I. Interlude #2 (Svitáni)', 'The Cunning Little Vixen: Act I. Interlude #2 (Svitáni)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daa09f83-67e9-48d3-b285-791d8ce0e9b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act I. “Mělas dělat podlivá mně!” (Lapák)', part.name_en = 'The Cunning Little Vixen: Act I. “Mělas dělat podlivá mně!” (Lapák)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:87b4d67a-2cdd-4f27-bff4-a91901945a17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87b4d67a-2cdd-4f27-bff4-a91901945a17', 11, NULL, 'Act I. “Mělas dělat podlivá mně!” (Lapák)', 'The Cunning Little Vixen: Act I. “Mělas dělat podlivá mně!” (Lapák)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87b4d67a-2cdd-4f27-bff4-a91901945a17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act I. “Hled’te, sestry jakého máte vůdce!” (Bystrouška)', part.name_en = 'The Cunning Little Vixen: Act I. “Hled’te, sestry jakého máte vůdce!” (Bystrouška)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0593140d-05be-4db1-b272-0f60a97236f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0593140d-05be-4db1-b272-0f60a97236f7', 12, NULL, 'Act I. “Hled’te, sestry jakého máte vůdce!” (Bystrouška)', 'The Cunning Little Vixen: Act I. “Hled’te, sestry jakého máte vůdce!” (Bystrouška)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0593140d-05be-4db1-b272-0f60a97236f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act I. “Zbabělče, podivé se, jeli už mrtvá?”', part.name_en = 'The Cunning Little Vixen: Act I. “Zbabělče, podivé se, jeli už mrtvá?”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b9bd70e9-fbca-4db3-bd36-df8b708e592f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9bd70e9-fbca-4db3-bd36-df8b708e592f', 13, NULL, 'Act I. “Zbabělče, podivé se, jeli už mrtvá?”', 'The Cunning Little Vixen: Act I. “Zbabělče, podivé se, jeli už mrtvá?”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:95c298de-a941-452d-a01a-0b9bbfe18dfd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9bd70e9-fbca-4db3-bd36-df8b708e592f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'JW I/9: Act II', part.name_en = 'Příhody lišky Bystroušky, JW I/9: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675', 2, NULL, 'JW I/9: Act II', 'Příhody lišky Bystroušky, JW I/9: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. Prelude', part.name_en = 'The Cunning Little Vixen: Act II. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c9aab8af-2a58-44f6-adf7-478df0f6d0e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9aab8af-2a58-44f6-adf7-478df0f6d0e2', 1, NULL, 'Act II. Prelude', 'The Cunning Little Vixen: Act II. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9aab8af-2a58-44f6-adf7-478df0f6d0e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II. “Ach!” (Bystrouška)', part.name_en = 'The Cunning Little Vixen: Act II. “Ach!” (Bystrouška)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:261cd938-5ab4-4397-af91-880ad87ac0c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:261cd938-5ab4-4397-af91-880ad87ac0c1', 2, NULL, 'Act II. “Ach!” (Bystrouška)', 'The Cunning Little Vixen: Act II. “Ach!” (Bystrouška)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:261cd938-5ab4-4397-af91-880ad87ac0c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II. Interlude (Proměna) [2]', part.name_en = 'The Cunning Little Vixen: Act II. Interlude (Proměna) [2]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fd00eabc-f1a5-4133-aa22-8b3f8a85344a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd00eabc-f1a5-4133-aa22-8b3f8a85344a', 3, NULL, 'Act II. Interlude (Proměna) [2]', 'The Cunning Little Vixen: Act II. Interlude (Proměna) [2]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd00eabc-f1a5-4133-aa22-8b3f8a85344a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II. “Ano, ve Stráni bude daleko lépe” (Farář)', part.name_en = 'The Cunning Little Vixen: Act II. “Ano, ve Stráni bude daleko lépe” (Farář)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:8d2205ef-1c24-4239-b2c3-43a67f6ab2aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d2205ef-1c24-4239-b2c3-43a67f6ab2aa', 4, NULL, 'Act II. “Ano, ve Stráni bude daleko lépe” (Farář)', 'The Cunning Little Vixen: Act II. “Ano, ve Stráni bude daleko lépe” (Farář)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d2205ef-1c24-4239-b2c3-43a67f6ab2aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act II. “Bývalo, bývalo, dávno už neni”', part.name_en = 'The Cunning Little Vixen: Act II. “Bývalo, bývalo, dávno už neni”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:cbbc7001-caa8-4a73-b230-42f31953b6a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbbc7001-caa8-4a73-b230-42f31953b6a5', 5, NULL, 'Act II. “Bývalo, bývalo, dávno už neni”', 'The Cunning Little Vixen: Act II. “Bývalo, bývalo, dávno už neni”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbbc7001-caa8-4a73-b230-42f31953b6a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act II. “Domů? Pro ten šňupec tvého spaní?” (Revírník)', part.name_en = 'The Cunning Little Vixen: Act II. “Domů? Pro ten šňupec tvého spaní?” (Revírník)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0de7aa7c-3844-4e6c-835d-a916598b4b3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0de7aa7c-3844-4e6c-835d-a916598b4b3a', 6, NULL, 'Act II. “Domů? Pro ten šňupec tvého spaní?” (Revírník)', 'The Cunning Little Vixen: Act II. “Domů? Pro ten šňupec tvého spaní?” (Revírník)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0de7aa7c-3844-4e6c-835d-a916598b4b3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act II. Interlude (Proměna) [3]', part.name_en = 'The Cunning Little Vixen: Act II. Interlude (Proměna) [3]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:6ac9ddf5-4ce9-4a5b-9b21-1b1184807e27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ac9ddf5-4ce9-4a5b-9b21-1b1184807e27', 7, NULL, 'Act II. Interlude (Proměna) [3]', 'The Cunning Little Vixen: Act II. Interlude (Proměna) [3]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ac9ddf5-4ce9-4a5b-9b21-1b1184807e27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act II. “Buďto mám těžiště pohyblivé” (Rechtor)', part.name_en = 'The Cunning Little Vixen: Act II. “Buďto mám těžiště pohyblivé” (Rechtor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:16c834fd-4007-4514-821a-045c65d8ef16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16c834fd-4007-4514-821a-045c65d8ef16', 8, NULL, 'Act II. “Buďto mám těžiště pohyblivé” (Rechtor)', 'The Cunning Little Vixen: Act II. “Buďto mám těžiště pohyblivé” (Rechtor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16c834fd-4007-4514-821a-045c65d8ef16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act II. “Staccato! Flageoletto!”', part.name_en = 'The Cunning Little Vixen: Act II. “Staccato! Flageoletto!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:edbc9020-557e-436d-81e2-acc64f353e3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:edbc9020-557e-436d-81e2-acc64f353e3d', 9, NULL, 'Act II. “Staccato! Flageoletto!”', 'The Cunning Little Vixen: Act II. “Staccato! Flageoletto!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edbc9020-557e-436d-81e2-acc64f353e3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act II. “Pomni, abys byl dobrým mužem!” (Farář)', part.name_en = 'The Cunning Little Vixen: Act II. “Pomni, abys byl dobrým mužem!” (Farář)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:93209761-ecff-41c9-98c4-7d210b84e0bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:93209761-ecff-41c9-98c4-7d210b84e0bd', 10, NULL, 'Act II. “Pomni, abys byl dobrým mužem!” (Farář)', 'The Cunning Little Vixen: Act II. “Pomni, abys byl dobrým mužem!” (Farář)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93209761-ecff-41c9-98c4-7d210b84e0bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act II. “Memnesthó anér agathos einai”', part.name_en = 'The Cunning Little Vixen: Act II. “Memnesthó anér agathos einai”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:05723ee0-c900-40dd-9ba2-89ad052ca1d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05723ee0-c900-40dd-9ba2-89ad052ca1d4', 11, NULL, 'Act II. “Memnesthó anér agathos einai”', 'The Cunning Little Vixen: Act II. “Memnesthó anér agathos einai”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05723ee0-c900-40dd-9ba2-89ad052ca1d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act II. Interlude (Proměna) [4]', part.name_en = 'The Cunning Little Vixen: Act II. Interlude (Proměna) [4]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3da72eca-934f-4fcc-8e12-6ac3b4b0eb47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3da72eca-934f-4fcc-8e12-6ac3b4b0eb47', 12, NULL, 'Act II. Interlude (Proměna) [4]', 'The Cunning Little Vixen: Act II. Interlude (Proměna) [4]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3da72eca-934f-4fcc-8e12-6ac3b4b0eb47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act II. “Bóžinku, ten je hezké!” (Bystrouška)', part.name_en = 'The Cunning Little Vixen: Act II. “Bóžinku, ten je hezké!” (Bystrouška)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1216ecff-9839-482f-96f1-77315126725c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1216ecff-9839-482f-96f1-77315126725c', 13, NULL, 'Act II. “Bóžinku, ten je hezké!” (Bystrouška)', 'The Cunning Little Vixen: Act II. “Bóžinku, ten je hezké!” (Bystrouška)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1216ecff-9839-482f-96f1-77315126725c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act II. “Kradla jsem!” (Bystrouška)', part.name_en = 'The Cunning Little Vixen: Act II. “Kradla jsem!” (Bystrouška)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ca49032c-9b94-4cac-89c2-38a1fe1d00fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca49032c-9b94-4cac-89c2-38a1fe1d00fe', 14, NULL, 'Act II. “Kradla jsem!” (Bystrouška)', 'The Cunning Little Vixen: Act II. “Kradla jsem!” (Bystrouška)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca49032c-9b94-4cac-89c2-38a1fe1d00fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act II. “Zlatohřbítek, Lišák s kroužkovými pesíky” (Lišák)', part.name_en = 'The Cunning Little Vixen: Act II. “Zlatohřbítek, Lišák s kroužkovými pesíky” (Lišák)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:04878058-7c99-4ba6-bbd2-f22f3c9d6b15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04878058-7c99-4ba6-bbd2-f22f3c9d6b15', 15, NULL, 'Act II. “Zlatohřbítek, Lišák s kroužkovými pesíky” (Lišák)', 'The Cunning Little Vixen: Act II. “Zlatohřbítek, Lišák s kroužkovými pesíky” (Lišák)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04878058-7c99-4ba6-bbd2-f22f3c9d6b15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Act II. “Jsemli opravdu tak krásná?”', part.name_en = 'The Cunning Little Vixen: Act II. “Jsemli opravdu tak krásná?”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e59232c0-1fc5-4579-80d2-91ed63798aed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e59232c0-1fc5-4579-80d2-91ed63798aed', 16, NULL, 'Act II. “Jsemli opravdu tak krásná?”', 'The Cunning Little Vixen: Act II. “Jsemli opravdu tak krásná?”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e59232c0-1fc5-4579-80d2-91ed63798aed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Act II. “Pusťte mě!”', part.name_en = 'The Cunning Little Vixen: Act II. “Pusťte mě!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:739bf7b4-9aa9-451c-a64e-e815fc149522' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:739bf7b4-9aa9-451c-a64e-e815fc149522', 17, NULL, 'Act II. “Pusťte mě!”', 'The Cunning Little Vixen: Act II. “Pusťte mě!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:739bf7b4-9aa9-451c-a64e-e815fc149522'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Act II. “Kdybyste věděli, co já viděla” (Sova)', part.name_en = 'The Cunning Little Vixen: Act II. “Kdybyste věděli, co já viděla” (Sova)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b50be2ac-0ed6-404f-b271-7b80ab841112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b50be2ac-0ed6-404f-b271-7b80ab841112', 18, NULL, 'Act II. “Kdybyste věděli, co já viděla” (Sova)', 'The Cunning Little Vixen: Act II. “Kdybyste věděli, co já viděla” (Sova)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b50be2ac-0ed6-404f-b271-7b80ab841112'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Act II. “Když je to tak”', part.name_en = 'The Cunning Little Vixen: Act II. “Když je to tak”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:cb92ee7b-04e9-496e-99a4-e1d04168099b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb92ee7b-04e9-496e-99a4-e1d04168099b', 19, NULL, 'Act II. “Když je to tak”', 'The Cunning Little Vixen: Act II. “Když je to tak”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:82f6f316-1ced-494a-a821-ca267c01d675'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb92ee7b-04e9-496e-99a4-e1d04168099b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'JW I/9: Act III', part.name_en = 'Příhody lišky Bystroušky, JW I/9: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd', 3, NULL, 'JW I/9: Act III', 'Příhody lišky Bystroušky, JW I/9: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III. Prelude', part.name_en = 'The Cunning Little Vixen: Act III. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:73524d2e-4330-40af-b527-b186c35f517e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73524d2e-4330-40af-b527-b186c35f517e', 1, NULL, 'Act III. Prelude', 'The Cunning Little Vixen: Act III. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73524d2e-4330-40af-b527-b186c35f517e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III. "Déž sem vandroval, mozeka hrála" (Harašta)', part.name_en = 'The Cunning Little Vixen: Act III. "Déž sem vandroval, mozeka hrála" (Harašta)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:788f0927-3605-42d6-b46e-5e25e66cc7c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:788f0927-3605-42d6-b46e-5e25e66cc7c1', 2, NULL, 'Act III. "Déž sem vandroval, mozeka hrála" (Harašta)', 'The Cunning Little Vixen: Act III. "Déž sem vandroval, mozeka hrála" (Harašta)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:788f0927-3605-42d6-b46e-5e25e66cc7c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III. “Tož co, Harašto, máš se dobře?”', part.name_en = 'The Cunning Little Vixen: Act III. “Tož co, Harašto, máš se dobře?”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:43b8de3a-67c6-48db-9d04-de51fc16f71b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43b8de3a-67c6-48db-9d04-de51fc16f71b', 3, NULL, 'Act III. “Tož co, Harašto, máš se dobře?”', 'The Cunning Little Vixen: Act III. “Tož co, Harašto, máš se dobře?”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43b8de3a-67c6-48db-9d04-de51fc16f71b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III. "Béží liška k Táboru" (Liščičky)', part.name_en = 'The Cunning Little Vixen: Act III. "Béží liška k Táboru" (Liščičky)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:708dbbc6-97a2-4e25-a164-0ff530f93085' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:708dbbc6-97a2-4e25-a164-0ff530f93085', 4, NULL, 'Act III. "Béží liška k Táboru" (Liščičky)', 'The Cunning Little Vixen: Act III. "Béží liška k Táboru" (Liščičky)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:708dbbc6-97a2-4e25-a164-0ff530f93085'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III. "Kolik jsme už měli dětí?"', part.name_en = 'The Cunning Little Vixen: Act III. "Kolik jsme už měli dětí?"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:67e56bb2-8010-4108-960c-565149a4bd51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67e56bb2-8010-4108-960c-565149a4bd51', 5, NULL, 'Act III. "Kolik jsme už měli dětí?"', 'The Cunning Little Vixen: Act III. "Kolik jsme už měli dětí?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67e56bb2-8010-4108-960c-565149a4bd51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act III. "Nůšu důle!" (Harašta)', part.name_en = 'The Cunning Little Vixen: Act III. "Nůšu důle!" (Harašta)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:202a59c8-fa12-4ad2-bed7-1b280045bb47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:202a59c8-fa12-4ad2-bed7-1b280045bb47', 6, NULL, 'Act III. "Nůšu důle!" (Harašta)', 'The Cunning Little Vixen: Act III. "Nůšu důle!" (Harašta)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:202a59c8-fa12-4ad2-bed7-1b280045bb47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act III. Interlude #1', part.name_en = 'The Cunning Little Vixen: Act III. Interlude #1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:a90d0807-5304-4334-a3e5-1646e3f3d5d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a90d0807-5304-4334-a3e5-1646e3f3d5d7', 7, NULL, 'Act III. Interlude #1', 'The Cunning Little Vixen: Act III. Interlude #1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a90d0807-5304-4334-a3e5-1646e3f3d5d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act III. "A kde otec Pásek?" (Revírník)', part.name_en = 'The Cunning Little Vixen: Act III. "A kde otec Pásek?" (Revírník)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c0662fab-54a1-45f0-8096-bbc61d26814d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c0662fab-54a1-45f0-8096-bbc61d26814d', 8, NULL, 'Act III. "A kde otec Pásek?" (Revírník)', 'The Cunning Little Vixen: Act III. "A kde otec Pásek?" (Revírník)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0662fab-54a1-45f0-8096-bbc61d26814d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act III. “Do hroma!”', part.name_en = 'The Cunning Little Vixen: Act III. “Do hroma!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:68d4d2cd-1b34-4798-941e-5b9c74fa877a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68d4d2cd-1b34-4798-941e-5b9c74fa877a', 9, NULL, 'Act III. “Do hroma!”', 'The Cunning Little Vixen: Act III. “Do hroma!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68d4d2cd-1b34-4798-941e-5b9c74fa877a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act III. "To už ne!" (Rechtor)', part.name_en = 'The Cunning Little Vixen: Act III. "To už ne!" (Rechtor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:630fc1dd-aa84-4009-a188-e7405927981f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:630fc1dd-aa84-4009-a188-e7405927981f', 10, NULL, 'Act III. "To už ne!" (Rechtor)', 'The Cunning Little Vixen: Act III. "To už ne!" (Rechtor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:630fc1dd-aa84-4009-a188-e7405927981f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act III. Interlude #2', part.name_en = 'The Cunning Little Vixen: Act III. Interlude #2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:bba8130a-46f8-4ef0-bf9f-a8d925f7ee7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bba8130a-46f8-4ef0-bf9f-a8d925f7ee7a', 11, NULL, 'Act III. Interlude #2', 'The Cunning Little Vixen: Act III. Interlude #2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba8130a-46f8-4ef0-bf9f-a8d925f7ee7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Act III. "Neříkal jsem to?" (Revírník)', part.name_en = 'The Cunning Little Vixen: Act III. "Neříkal jsem to?" (Revírník)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:62e4bb7b-86d7-4ee1-b64a-eacd19062ce4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:62e4bb7b-86d7-4ee1-b64a-eacd19062ce4', 12, NULL, 'Act III. "Neříkal jsem to?" (Revírník)', 'The Cunning Little Vixen: Act III. "Neříkal jsem to?" (Revírník)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e4bb7b-86d7-4ee1-b64a-eacd19062ce4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Act III. “A přece su rád”', part.name_en = 'The Cunning Little Vixen: Act III. “A přece su rád”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:cda59953-c70d-48df-970e-da151c187db4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cda59953-c70d-48df-970e-da151c187db4', 13, NULL, 'Act III. “A přece su rád”', 'The Cunning Little Vixen: Act III. “A přece su rád”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cda59953-c70d-48df-970e-da151c187db4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Act III. "Hoj! Ale není tu Bystroušky!"', part.name_en = 'The Cunning Little Vixen: Act III. "Hoj! Ale není tu Bystroušky!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:de27093e-2ce9-4f1b-a8d8-1b6339452d55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de27093e-2ce9-4f1b-a8d8-1b6339452d55', 14, NULL, 'Act III. "Hoj! Ale není tu Bystroušky!"', 'The Cunning Little Vixen: Act III. "Hoj! Ale není tu Bystroušky!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de27093e-2ce9-4f1b-a8d8-1b6339452d55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Act III. "Totok nejsem já" (Skokánek)', part.name_en = 'The Cunning Little Vixen: Act III. "Totok nejsem já" (Skokánek)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7604 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e7432c9f-c72c-4846-8a01-c6076c6b36c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7432c9f-c72c-4846-8a01-c6076c6b36c9', 15, NULL, 'Act III. "Totok nejsem já" (Skokánek)', 'The Cunning Little Vixen: Act III. "Totok nejsem já" (Skokánek)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:096cceb7-054c-4c21-8515-0a5f637c09dd'
WHERE p.id = 7604 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7432c9f-c72c-4846-8a01-c6076c6b36c9'
);


-- None Quatuor n° 1 (Con moto)

UPDATE pieces piece
SET piece.title = 'Quatuor n° 1 (Con moto)', piece.title_en = 'Quatuor n° 1 (Con moto)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10639 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatuor à cordes n° 2 (Andante - Con moto - Allegro)

UPDATE pieces piece
SET piece.title = 'Quatuor à cordes n° 2 (Andante - Con moto - Allegro)', piece.title_en = 'Quatuor à cordes n° 2 (Andante - Con moto - Allegro)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7799 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 2/7 모테트 <Regnum Mundi>

UPDATE pieces piece
SET piece.title = '모테트 <Regnum Mundi>', piece.title_en = 'Regnum Mundi, JW 2/7',
    piece.type = 'song', piece.opus_number = 'JW 2/7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11224 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Romance, JW VII/3

UPDATE pieces piece
SET piece.title = 'Romance, JW VII/3', piece.title_en = 'Romance, JW VII/3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9359 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 발레 <Rákos Rákoczy, JW I/2>

UPDATE pieces piece
SET piece.title = '발레 <Rákos Rákoczy, JW I/2>', piece.title_en = 'Rákos Rákoczy, JW I/2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10221 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Schulk und Jau

UPDATE pieces piece
SET piece.title = 'Schulk und Jau', piece.title_en = 'Schulk und Jau',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9841 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Schluck und Jau: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9841 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9d681172-af22-4d8a-901b-c6ae96072ddd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d681172-af22-4d8a-901b-c6ae96072ddd', 1, 'I', 'Andante', 'Schluck und Jau: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9841 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d681172-af22-4d8a-901b-c6ae96072ddd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'Schluck und Jau: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9841 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:efda722b-609c-40be-8244-ea92d716c1a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efda722b-609c-40be-8244-ea92d716c1a3', 2, 'II', 'Allegretto', 'Schluck und Jau: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9841 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efda722b-609c-40be-8244-ea92d716c1a3'
);


-- None Sedmdesát tisíc

UPDATE pieces piece
SET piece.title = 'Sedmdesát tisíc', piece.title_en = 'Sedmdesát tisíc',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7592 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 신포니에타

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto - Allegro - Maestoso (Fanfares)', part.name_en = 'Sinfonietta: I. Allegretto - Allegro - Maestoso (Fanfares)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 392 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fb446a5d-6360-3dca-95fe-5996d394cfaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb446a5d-6360-3dca-95fe-5996d394cfaf', 1, 'I', 'Allegretto - Allegro - Maestoso (Fanfares)', 'Sinfonietta: I. Allegretto - Allegro - Maestoso (Fanfares)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 392 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb446a5d-6360-3dca-95fe-5996d394cfaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante - Allegretto (The Castle)', part.name_en = 'Sinfonietta: II. Andante - Allegretto (The Castle)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 392 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7e122abf-6d1a-3782-b2ab-6c01b22f5997' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e122abf-6d1a-3782-b2ab-6c01b22f5997', 2, 'II', 'Andante - Allegretto (The Castle)', 'Sinfonietta: II. Andante - Allegretto (The Castle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 392 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e122abf-6d1a-3782-b2ab-6c01b22f5997'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato (The Queen''s Monastery)', part.name_en = 'Sinfonietta: III. Moderato (The Queen''s Monastery)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 392 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:14881bac-7ae6-3466-8fdb-fae5b9871b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14881bac-7ae6-3466-8fdb-fae5b9871b7f', 3, 'III', 'Moderato (The Queen''s Monastery)', 'Sinfonietta: III. Moderato (The Queen''s Monastery)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 392 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14881bac-7ae6-3466-8fdb-fae5b9871b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto (The Street)', part.name_en = 'Sinfonietta: IV. Allegretto (The Street)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 392 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4d8bf225-5f42-36d2-ba95-ef56049e6823' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d8bf225-5f42-36d2-ba95-ef56049e6823', 4, 'IV', 'Allegretto (The Street)', 'Sinfonietta: IV. Allegretto (The Street)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 392 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d8bf225-5f42-36d2-ba95-ef56049e6823'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Andante con moto (The Town Hall)', part.name_en = 'Sinfonietta: V. Andante con moto (The Town Hall)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 392 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:8d15d5d1-12fa-384d-95c4-267cec7d4add' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d15d5d1-12fa-384d-95c4-267cec7d4add', 5, 'V', 'Andante con moto (The Town Hall)', 'Sinfonietta: V. Andante con moto (The Town Hall)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 392 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d15d5d1-12fa-384d-95c4-267cec7d4add'
);


-- JW 8/7 Skladby JW 8/7

UPDATE pieces piece
SET piece.title = 'Skladby JW 8/7', piece.title_en = 'Skladby, JW 8/7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'JW', piece.catalogue_number = '8/7',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9579 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Adagio I', part.name_en = 'Skladby, JW 8/7: Adagio I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9579 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:48e8391c-c85c-4562-979d-f94b5293c517' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48e8391c-c85c-4562-979d-f94b5293c517', 1, NULL, 'Adagio I', 'Skladby, JW 8/7: Adagio I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9579 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48e8391c-c85c-4562-979d-f94b5293c517'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adagio II', part.name_en = 'Skladby, JW 8/7: Adagio II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9579 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:fc3b74a1-e1dd-45bb-be49-30543df19b0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc3b74a1-e1dd-45bb-be49-30543df19b0c', 2, NULL, 'Adagio II', 'Skladby, JW 8/7: Adagio II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9579 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc3b74a1-e1dd-45bb-be49-30543df19b0c'
);


-- None Sonata 1. X. 1905

UPDATE pieces piece
SET piece.title = 'Sonata 1. X. 1905', piece.title_en = 'Sonata 1. X. 1905',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8080 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Foreboding', part.name_en = 'Sonata 1. X. 1905: I. Foreboding',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8080 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:6d683e71-9204-3fa6-91e0-ac8801e0725a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d683e71-9204-3fa6-91e0-ac8801e0725a', 1, 'I', 'Foreboding', 'Sonata 1. X. 1905: I. Foreboding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8080 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d683e71-9204-3fa6-91e0-ac8801e0725a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Death', part.name_en = 'Sonata 1. X. 1905: II. Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8080 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:41d12436-3e0c-3b80-afab-0474dd063313' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41d12436-3e0c-3b80-afab-0474dd063313', 2, 'II', 'Death', 'Sonata 1. X. 1905: II. Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8080 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41d12436-3e0c-3b80-afab-0474dd063313'
);


-- None Sonata for Violin & Piano, JW VII/7

UPDATE pieces piece
SET piece.title = 'Sonata for Violin & Piano, JW VII/7', piece.title_en = 'Sonata for Violin & Piano, JW VII/7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8114 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Con moto', part.name_en = 'Sonata for Violin & Piano, JW 7/7: I. Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8114 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1e8e00d4-875f-3453-bb7f-e4fc5f11e7b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e8e00d4-875f-3453-bb7f-e4fc5f11e7b0', 1, 'I', 'Con moto', 'Sonata for Violin & Piano, JW 7/7: I. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8114 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e8e00d4-875f-3453-bb7f-e4fc5f11e7b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ballada', part.name_en = 'Sonata for Violin & Piano, JW 7/7: II. Ballada',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8114 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d4c69087-8224-37d5-bba2-409fe795590a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4c69087-8224-37d5-bba2-409fe795590a', 2, 'II', 'Ballada', 'Sonata for Violin & Piano, JW 7/7: II. Ballada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8114 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4c69087-8224-37d5-bba2-409fe795590a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Sonata for Violin & Piano, JW 7/7: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8114 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:03213816-52ee-367b-87f0-3dc516493b20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03213816-52ee-367b-87f0-3dc516493b20', 3, 'III', 'Allegretto', 'Sonata for Violin & Piano, JW 7/7: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8114 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03213816-52ee-367b-87f0-3dc516493b20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'Sonata for Violin & Piano, JW 7/7: IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8114 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:24e1d0fa-e2ed-31d2-824f-bb41fe5e778b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24e1d0fa-e2ed-31d2-824f-bb41fe5e778b', 4, 'IV', 'Adagio', 'Sonata for Violin & Piano, JW 7/7: IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8114 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24e1d0fa-e2ed-31d2-824f-bb41fe5e778b'
);


-- JW 6/13 Srbské kolo

UPDATE pieces piece
SET piece.title = 'Srbské kolo', piece.title_en = 'Srbské kolo, JW 6/13',
    piece.type = 'song', piece.opus_number = 'JW 6/13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7566 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 1번 "Kreutzer Sonata"

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 "Kreutzer Sonata"', piece.title_en = 'String Quartet no. 1, JW VII/8 “Kreutzer Sonata”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7619 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio – Con moto', part.name_en = 'String Quartet no. 1: I. Adagio – Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7619 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0be27267-5d36-3335-b53d-35a5ee927ac1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0be27267-5d36-3335-b53d-35a5ee927ac1', 1, 'I', 'Adagio – Con moto', 'String Quartet no. 1: I. Adagio – Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7619 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0be27267-5d36-3335-b53d-35a5ee927ac1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Con moto', part.name_en = 'String Quartet no. 1: II. Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7619 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e5034ea2-f337-3f5c-bd4a-28144e841b18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5034ea2-f337-3f5c-bd4a-28144e841b18', 2, 'II', 'Con moto', 'String Quartet no. 1: II. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7619 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5034ea2-f337-3f5c-bd4a-28144e841b18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Con moto – Vivo – Andante', part.name_en = 'String Quartet no. 1: III. Con moto – Vivo – Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7619 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:08e7342a-47b3-35b1-a284-4b504eb2af41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08e7342a-47b3-35b1-a284-4b504eb2af41', 3, 'III', 'Con moto – Vivo – Andante', 'String Quartet no. 1: III. Con moto – Vivo – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7619 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08e7342a-47b3-35b1-a284-4b504eb2af41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Con moto – Adagio – Maestoso', part.name_en = 'String Quartet no. 1: IV. Con moto – Adagio – Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7619 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3e490bfb-1581-3ad5-ae6c-72b3eadcafd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e490bfb-1581-3ad5-ae6c-72b3eadcafd5', 4, 'IV', 'Con moto – Adagio – Maestoso', 'String Quartet no. 1: IV. Con moto – Adagio – Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7619 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e490bfb-1581-3ad5-ae6c-72b3eadcafd5'
);


-- None 현악 4중주 2번 "Intimate Letters"

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 "Intimate Letters"', piece.title_en = 'String Quartet no. 2 “Intimate Letters”',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9846 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'String Quartet no. 2 “Intimate Letters”: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9846 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9dab0a2a-3bcd-3cf5-8fa3-abab390c21ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dab0a2a-3bcd-3cf5-8fa3-abab390c21ff', 1, 'I', 'Andante', 'String Quartet no. 2 “Intimate Letters”: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9846 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dab0a2a-3bcd-3cf5-8fa3-abab390c21ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'String Quartet no. 2 “Intimate Letters”: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9846 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:541ad45a-7fb4-31ec-ac47-1afc34e173fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:541ad45a-7fb4-31ec-ac47-1afc34e173fe', 2, 'II', 'Adagio', 'String Quartet no. 2 “Intimate Letters”: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9846 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:541ad45a-7fb4-31ec-ac47-1afc34e173fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'String Quartet no. 2 “Intimate Letters”: III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9846 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:a7046124-41c4-39b4-9c68-d6b18fb9554f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7046124-41c4-39b4-9c68-d6b18fb9554f', 3, 'III', 'Moderato', 'String Quartet no. 2 “Intimate Letters”: III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9846 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7046124-41c4-39b4-9c68-d6b18fb9554f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'String Quartet no. 2 “Intimate Letters”: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9846 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:41e8d68a-dffb-3bd7-be53-88951a07e7d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41e8d68a-dffb-3bd7-be53-88951a07e7d1', 4, 'IV', 'Allegro', 'String Quartet no. 2 “Intimate Letters”: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9846 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41e8d68a-dffb-3bd7-be53-88951a07e7d1'
);


-- None Suite, JW VI/2

UPDATE pieces piece
SET piece.title = 'Suite, JW VI/2', piece.title_en = 'Suite, JW VI/2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8984 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Suite, JW VI/2: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8984 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:cc240756-78a5-4f46-a30f-c51f4e8226b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc240756-78a5-4f46-a30f-c51f4e8226b7', 1, 'I', 'Moderato', 'Suite, JW VI/2: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8984 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc240756-78a5-4f46-a30f-c51f4e8226b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio - Meno', part.name_en = 'Suite, JW VI/2: II. Adagio - Meno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8984 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:a703507c-a9f2-4786-ae02-4a19fa7729fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a703507c-a9f2-4786-ae02-4a19fa7729fe', 2, 'II', 'Adagio - Meno', 'Suite, JW VI/2: II. Adagio - Meno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8984 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a703507c-a9f2-4786-ae02-4a19fa7729fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante con moto', part.name_en = 'Suite, JW VI/2: III. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8984 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0bb7a6b1-7631-4260-96cf-94bb348f62d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bb7a6b1-7631-4260-96cf-94bb348f62d3', 3, 'III', 'Andante con moto', 'Suite, JW VI/2: III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8984 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bb7a6b1-7631-4260-96cf-94bb348f62d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto - Andante - Presto', part.name_en = 'Suite, JW VI/2: IV. Presto - Andante - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8984 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:f8313b4e-4ff1-40d9-a9b7-e19dbd2cf5aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8313b4e-4ff1-40d9-a9b7-e19dbd2cf5aa', 4, 'IV', 'Presto - Andante - Presto', 'Suite, JW VI/2: IV. Presto - Andante - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8984 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8313b4e-4ff1-40d9-a9b7-e19dbd2cf5aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Adagio', part.name_en = 'Suite, JW VI/2: V. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8984 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:68c0b124-84b3-4a52-a478-782f3e4cf95a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68c0b124-84b3-4a52-a478-782f3e4cf95a', 5, 'V', 'Adagio', 'Suite, JW VI/2: V. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8984 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68c0b124-84b3-4a52-a478-782f3e4cf95a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Andante', part.name_en = 'Suite, JW VI/2: VI. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8984 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:04ed5945-be3f-4de3-a34d-b2d45027dbde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04ed5945-be3f-4de3-a34d-b2d45027dbde', 6, 'VI', 'Andante', 'Suite, JW VI/2: VI. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8984 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04ed5945-be3f-4de3-a34d-b2d45027dbde'
);


-- None Suite, op. 3, JW VI/6

UPDATE pieces piece
SET piece.title = 'Suite, op. 3, JW VI/6', piece.title_en = 'Suite, op. 3, JW VI/6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10886 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Con moto', part.name_en = 'Suite, op. 3, JW VI/6: I. Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10886 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4039581c-ac66-4b84-a797-b08c652e9f71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4039581c-ac66-4b84-a797-b08c652e9f71', 1, 'I', 'Con moto', 'Suite, op. 3, JW VI/6: I. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10886 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4039581c-ac66-4b84-a797-b08c652e9f71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Suite, op. 3, JW VI/6: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10886 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:1dccd941-259c-4983-a61f-a4a3272e2582' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dccd941-259c-4983-a61f-a4a3272e2582', 2, 'II', 'Adagio', 'Suite, op. 3, JW VI/6: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10886 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dccd941-259c-4983-a61f-a4a3272e2582'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'Suite, op. 3, JW VI/6: III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10886 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ca445056-56a4-448e-9418-94242d228d9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca445056-56a4-448e-9418-94242d228d9f', 3, 'III', 'Allegretto', 'Suite, op. 3, JW VI/6: III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10886 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca445056-56a4-448e-9418-94242d228d9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Con moto, allegro', part.name_en = 'Suite, op. 3, JW VI/6: IV. Con moto, allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10886 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0e18e2d9-42b5-47e3-8d6a-04736ceba79e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e18e2d9-42b5-47e3-8d6a-04736ceba79e', 4, 'IV', 'Con moto, allegro', 'Suite, op. 3, JW VI/6: IV. Con moto, allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10886 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e18e2d9-42b5-47e3-8d6a-04736ceba79e'
);


-- JW 2/9 모테트 <Suscepimus Deus>

UPDATE pieces piece
SET piece.title = '모테트 <Suscepimus Deus>', piece.title_en = 'Suscepimus Deus, JW 2/9',
    piece.type = 'song', piece.opus_number = 'JW 2/9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8211 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Taras Bulba

UPDATE pieces piece
SET piece.title = 'Taras Bulba', piece.title_en = 'Taras Bulba',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10414 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Death of Andrey', part.name_en = 'Taras Bulba: I. Death of Andrey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10414 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d20f77e2-b0bb-4a6b-8306-1d5e3c979ae5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d20f77e2-b0bb-4a6b-8306-1d5e3c979ae5', 1, 'I', 'Death of Andrey', 'Taras Bulba: I. Death of Andrey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10414 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d20f77e2-b0bb-4a6b-8306-1d5e3c979ae5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Death of Ostap', part.name_en = 'Taras Bulba: II. Death of Ostap',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10414 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:57af9122-c2b2-4bca-926b-608c9e10e7ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57af9122-c2b2-4bca-926b-608c9e10e7ce', 2, 'II', 'Death of Ostap', 'Taras Bulba: II. Death of Ostap', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10414 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57af9122-c2b2-4bca-926b-608c9e10e7ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Prophecy and Death of Taras Bulba', part.name_en = 'Taras Bulba: III. Prophecy and Death of Taras Bulba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10414 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:5839ba2b-b035-4810-9c3e-c44104ff6c91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5839ba2b-b035-4810-9c3e-c44104ff6c91', 3, 'III', 'Prophecy and Death of Taras Bulba', 'Taras Bulba: III. Prophecy and Death of Taras Bulba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10414 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5839ba2b-b035-4810-9c3e-c44104ff6c91'
);


-- None Tema con variazioni

UPDATE pieces piece
SET piece.title = 'Tema con variazioni', piece.title_en = 'Tema con variazioni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7464 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 3개의 푸가

UPDATE pieces piece
SET piece.title = '3개의 푸가', piece.title_en = 'Three Fugues',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9436 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fuga in G minor: Allegro', part.name_en = 'Three Fugues: Fuga in G minor: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9436 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:65e8fc58-c2d5-4363-bb50-d935592f8c45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e8fc58-c2d5-4363-bb50-d935592f8c45', 1, NULL, 'Fuga in G minor: Allegro', 'Three Fugues: Fuga in G minor: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9436 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e8fc58-c2d5-4363-bb50-d935592f8c45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuga in A major: Moderato', part.name_en = 'Three Fugues: Fuga in A major: Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9436 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:6c5883cc-a4e1-4df5-a957-66224eed9c76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c5883cc-a4e1-4df5-a957-66224eed9c76', 2, NULL, 'Fuga in A major: Moderato', 'Three Fugues: Fuga in A major: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9436 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c5883cc-a4e1-4df5-a957-66224eed9c76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Fuga in A minor: Moderato', part.name_en = 'Three Fugues: Fuga in A minor: Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9436 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7ba936d0-e6b6-4d68-9f3a-26e1f72a1b78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ba936d0-e6b6-4d68-9f3a-26e1f72a1b78', 3, NULL, 'Fuga in A minor: Moderato', 'Three Fugues: Fuga in A minor: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9436 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ba936d0-e6b6-4d68-9f3a-26e1f72a1b78'
);


-- None Three Moravian Dances

UPDATE pieces piece
SET piece.title = 'Three Moravian Dances', piece.title_en = 'Three Moravian Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9477 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ej, danaj!', part.name_en = 'Three Moravian Dances: No. 1. Ej, danaj!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9477 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:dea7e40d-2076-30f9-9e01-8c479dcbd120' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea7e40d-2076-30f9-9e01-8c479dcbd120', 1, NULL, 'Ej, danaj!', 'Three Moravian Dances: No. 1. Ej, danaj!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9477 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea7e40d-2076-30f9-9e01-8c479dcbd120'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Čeladenský', part.name_en = 'Three Moravian Dances: No. 2. Čeladenský',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9477 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9d82f6ff-558a-43ef-a2bc-82a6fd410120' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d82f6ff-558a-43ef-a2bc-82a6fd410120', 2, NULL, 'Čeladenský', 'Three Moravian Dances: No. 2. Čeladenský', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9477 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d82f6ff-558a-43ef-a2bc-82a6fd410120'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pilky', part.name_en = 'Three Moravian Dances: No. 3. Pilky',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9477 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d5a76cef-6b79-4db2-b8cb-a9c26ca727a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5a76cef-6b79-4db2-b8cb-a9c26ca727a6', 3, NULL, 'Pilky', 'Three Moravian Dances: No. 3. Pilky', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9477 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5a76cef-6b79-4db2-b8cb-a9c26ca727a6'
);


-- None To My Olga

UPDATE pieces piece
SET piece.title = 'To My Olga', piece.title_en = 'To My Olga',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11192 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- JW 4/19 Tři mužské sbory JW 4/19

UPDATE pieces piece
SET piece.title = 'Tři mužské sbory JW 4/19', piece.title_en = 'Tři mužské sbory, JW 4/19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'JW', piece.catalogue_number = '4/19',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7534 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Loučení, JW 4/19/1', part.name_en = 'Loučení, JW 4/19/1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7534 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0f4abe0a-2607-4d7f-bdc7-3627cf48c23c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f4abe0a-2607-4d7f-bdc7-3627cf48c23c', 1, NULL, 'Loučení, JW 4/19/1', 'Loučení, JW 4/19/1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7534 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f4abe0a-2607-4d7f-bdc7-3627cf48c23c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Holubička, JW 4/19/2', part.name_en = 'Holubička, JW 4/19/2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7534 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:42cd6b4b-f375-443b-b488-64a548ec94c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42cd6b4b-f375-443b-b488-64a548ec94c6', 2, NULL, 'Holubička, JW 4/19/2', 'Holubička, JW 4/19/2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7534 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42cd6b4b-f375-443b-b488-64a548ec94c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Žárlivec, JW 4/19/3', part.name_en = 'Žárlivec, JW 4/19/3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7534 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:a082222d-6b3d-41d9-9e9e-7d4856ba72e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a082222d-6b3d-41d9-9e9e-7d4856ba72e0', 3, NULL, 'Žárlivec, JW 4/19/3', 'Žárlivec, JW 4/19/3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7534 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a082222d-6b3d-41d9-9e9e-7d4856ba72e0'
);


-- None Ukvalská lidová poezie v písních

UPDATE pieces piece
SET piece.title = 'Ukvalská lidová poezie v písních', piece.title_en = 'Ukvalská lidová poezie v písních',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7540 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None V mlhách

UPDATE pieces piece
SET piece.title = 'V mlhách', piece.title_en = 'V mlhách',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7556 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante - Poco mosso', part.name_en = 'V mlhách: I. Andante - Poco mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7556 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:44074e9a-a883-3bf8-b295-3e38bcfede51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44074e9a-a883-3bf8-b295-3e38bcfede51', 1, 'I', 'Andante - Poco mosso', 'V mlhách: I. Andante - Poco mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7556 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44074e9a-a883-3bf8-b295-3e38bcfede51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto adagio - Presto', part.name_en = 'V mlhách: II. Molto adagio - Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7556 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:04ea34b8-2b59-3218-858c-253b1933bb75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04ea34b8-2b59-3218-858c-253b1933bb75', 2, 'II', 'Molto adagio - Presto', 'V mlhách: II. Molto adagio - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7556 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04ea34b8-2b59-3218-858c-253b1933bb75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino - Poco mosso', part.name_en = 'V mlhách: III. Andantino - Poco mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7556 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:44f50ddd-fd4b-3e7f-b27e-5cea2fa55837' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44f50ddd-fd4b-3e7f-b27e-5cea2fa55837', 3, 'III', 'Andantino - Poco mosso', 'V mlhách: III. Andantino - Poco mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7556 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44f50ddd-fd4b-3e7f-b27e-5cea2fa55837'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto - Meno mosso - Andante', part.name_en = 'V mlhách: IV. Presto - Meno mosso - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7556 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ec0f2e0d-81be-3db7-8008-3f804f042d06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec0f2e0d-81be-3db7-8008-3f804f042d06', 4, 'IV', 'Presto - Meno mosso - Andante', 'V mlhách: IV. Presto - Meno mosso - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7556 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec0f2e0d-81be-3db7-8008-3f804f042d06'
);


-- None 가곡 <VIčí stopa>

UPDATE pieces piece
SET piece.title = '가곡 <VIčí stopa>', piece.title_en = 'VIčí stopa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7819 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Valašské tance

UPDATE pieces piece
SET piece.title = 'Valašské tance', piece.title_en = 'Valašské tance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7466 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Veni sancte spiritus

UPDATE pieces piece
SET piece.title = 'Veni sancte spiritus', piece.title_en = 'Veni sancte spiritus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10938 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vzpomínka

UPDATE pieces piece
SET piece.title = 'Vzpomínka', piece.title_en = 'Vzpomínka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7495 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Vínek, JW IV/31>

UPDATE pieces piece
SET piece.title = '가곡 <Vínek, JW IV/31>', piece.title_en = 'Vínek, JW IV/31',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7451 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Výlety páně Broučkovy>

UPDATE pieces piece
SET piece.title = '오페라 <Výlety páně Broučkovy>', piece.title_en = 'Výlety páně Broučkovy',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7478 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '"Výlet pana Broučka do Měsíce"', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc', 1, NULL, '"Výlet pana Broučka do Měsíce"', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'díl: Dance - Tatramane!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Dance - Tatramane!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:2ac59214-b402-4bcc-83ba-16e85f0a362e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ac59214-b402-4bcc-83ba-16e85f0a362e', 1, NULL, 'díl: Dance - Tatramane!', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Dance - Tatramane!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac59214-b402-4bcc-83ba-16e85f0a362e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'díl: Introduction - Tuto melodii, ale do bombardonu!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Introduction - Tuto melodii, ale do bombardonu!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4550d5bf-d52d-4d53-9970-ce117ec7c0dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4550d5bf-d52d-4d53-9970-ce117ec7c0dc', 2, NULL, 'díl: Introduction - Tuto melodii, ale do bombardonu!', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Introduction - Tuto melodii, ale do bombardonu!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4550d5bf-d52d-4d53-9970-ce117ec7c0dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'díl: Pak věřit mužům', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Pak věřit mužům',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4a940454-c76e-498d-af63-78d53401e083' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a940454-c76e-498d-af63-78d53401e083', 3, NULL, 'díl: Pak věřit mužům', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Pak věřit mužům', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a940454-c76e-498d-af63-78d53401e083'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'díl: Pojd'' sem!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Pojd'' sem!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4d513952-82a0-4720-a002-1783a658a2c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d513952-82a0-4720-a002-1783a658a2c8', 4, NULL, 'díl: Pojd'' sem!', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Pojd'' sem!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d513952-82a0-4720-a002-1783a658a2c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'díl: Introduction', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:53631ff0-aeb0-465c-8ec9-4688a012fad5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53631ff0-aeb0-465c-8ec9-4688a012fad5', 5, NULL, 'díl: Introduction', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53631ff0-aeb0-465c-8ec9-4688a012fad5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'díl: Hubo nevymáchaná!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Hubo nevymáchaná!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7634dbc9-a9b0-4834-96f5-2631c68ecb7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7634dbc9-a9b0-4834-96f5-2631c68ecb7c', 6, NULL, 'díl: Hubo nevymáchaná!', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Hubo nevymáchaná!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7634dbc9-a9b0-4834-96f5-2631c68ecb7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'díl: Děs vane od tebe jak od Meduzy', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Děs vane od tebe jak od Meduzy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9ee8a499-aaee-4083-8bcf-c473e9f8e139' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ee8a499-aaee-4083-8bcf-c473e9f8e139', 7, NULL, 'díl: Děs vane od tebe jak od Meduzy', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Děs vane od tebe jak od Meduzy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ee8a499-aaee-4083-8bcf-c473e9f8e139'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'díl: Bouře šilenstvi mnou smýká', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Bouře šilenstvi mnou smýká',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:a339dacd-14d0-4f50-9de8-fca24a47a8a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a339dacd-14d0-4f50-9de8-fca24a47a8a4', 8, NULL, 'díl: Bouře šilenstvi mnou smýká', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Bouře šilenstvi mnou smýká', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a339dacd-14d0-4f50-9de8-fca24a47a8a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'díl: Málinko!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Málinko!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b1b05207-8768-44b1-a9cf-5d49b8ef129d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1b05207-8768-44b1-a9cf-5d49b8ef129d', 9, NULL, 'díl: Málinko!', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Málinko!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b05207-8768-44b1-a9cf-5d49b8ef129d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'díl: Etherea! Etherea!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Etherea! Etherea!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d01d2e77-04a3-4381-93c2-c5fdfdbaefda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d01d2e77-04a3-4381-93c2-c5fdfdbaefda', 10, NULL, 'díl: Etherea! Etherea!', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Etherea! Etherea!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d01d2e77-04a3-4381-93c2-c5fdfdbaefda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'díl: Interlude - Cupřiny tvé stále věnče', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Interlude - Cupřiny tvé stále věnče',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:df1c4d6f-33fa-43d7-a702-736255d49b4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df1c4d6f-33fa-43d7-a702-736255d49b4b', 11, NULL, 'díl: Interlude - Cupřiny tvé stále věnče', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Interlude - Cupřiny tvé stále věnče', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df1c4d6f-33fa-43d7-a702-736255d49b4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'díl: Pros veleducha', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Pros veleducha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:df502ad2-c0d0-4c27-9fd8-a6ea5abe65f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df502ad2-c0d0-4c27-9fd8-a6ea5abe65f0', 12, NULL, 'díl: Pros veleducha', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 2. díl: Pros veleducha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df502ad2-c0d0-4c27-9fd8-a6ea5abe65f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'díl: Račte nás zas brzo navštivit', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Račte nás zas brzo navštivit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:eafc726a-e7c4-4df5-9c19-6a30d344439a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eafc726a-e7c4-4df5-9c19-6a30d344439a', 13, NULL, 'díl: Račte nás zas brzo navštivit', 'Výlety páně Broučkovy: "Výlet pana Broučka do Měsíce": 1. díl: Račte nás zas brzo navštivit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3024aa2a-2073-4388-8009-34db673560fc'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eafc726a-e7c4-4df5-9c19-6a30d344439a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '"Výlet pana Broučka do XV. století"', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41', 2, NULL, '"Výlet pana Broučka do XV. století"', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'díl: O, slunce velkého dne', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: O, slunce velkého dne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:0ac55d7b-0cc1-452c-b714-b97e9b516264' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ac55d7b-0cc1-452c-b714-b97e9b516264', 1, NULL, 'díl: O, slunce velkého dne', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: O, slunce velkého dne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ac55d7b-0cc1-452c-b714-b97e9b516264'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'díl: Byly podzemní chodby', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: Byly podzemní chodby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3645be49-aac7-4262-94a6-cba2c41ac0e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3645be49-aac7-4262-94a6-cba2c41ac0e6', 2, NULL, 'díl: Byly podzemní chodby', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: Byly podzemní chodby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3645be49-aac7-4262-94a6-cba2c41ac0e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'díl: Hle, tu skrčen jeden!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Hle, tu skrčen jeden!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:3e8ded22-6301-4e04-9b9d-99a67ba1b02d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e8ded22-6301-4e04-9b9d-99a67ba1b02d', 3, NULL, 'díl: Hle, tu skrčen jeden!', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Hle, tu skrčen jeden!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e8ded22-6301-4e04-9b9d-99a67ba1b02d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'díl: Change of scene - Hejsasa! Hejsasa!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Change of scene - Hejsasa! Hejsasa!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:413037aa-6dfa-4d47-9786-abfb62f14dce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:413037aa-6dfa-4d47-9786-abfb62f14dce', 4, NULL, 'díl: Change of scene - Hejsasa! Hejsasa!', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Change of scene - Hejsasa! Hejsasa!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:413037aa-6dfa-4d47-9786-abfb62f14dce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'díl: Začíná se den Páně!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: Začíná se den Páně!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:437af7b0-d4c4-4d6c-a7d3-6372e5cd740b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:437af7b0-d4c4-4d6c-a7d3-6372e5cd740b', 5, NULL, 'díl: Začíná se den Páně!', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: Začíná se den Páně!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:437af7b0-d4c4-4d6c-a7d3-6372e5cd740b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'díl: Introduction', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:75d6d2f6-34a3-498e-a3a7-a5707d5dc684' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75d6d2f6-34a3-498e-a3a7-a5707d5dc684', 6, NULL, 'díl: Introduction', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75d6d2f6-34a3-498e-a3a7-a5707d5dc684'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'díl: Jsi-li dobrý, stuoj!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: Jsi-li dobrý, stuoj!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7973928f-22b9-4760-852b-7a77551e1da7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7973928f-22b9-4760-852b-7a77551e1da7', 7, NULL, 'díl: Jsi-li dobrý, stuoj!', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 1. díl: Jsi-li dobrý, stuoj!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7973928f-22b9-4760-852b-7a77551e1da7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'díl: Šel v našem šiku - Change of scene - Ach! Ach! Ach!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Šel v našem šiku - Change of scene - Ach! Ach! Ach!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:854e6f8f-6bd6-471e-ba29-d128112c821e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:854e6f8f-6bd6-471e-ba29-d128112c821e', 8, NULL, 'díl: Šel v našem šiku - Change of scene - Ach! Ach! Ach!', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Šel v našem šiku - Change of scene - Ach! Ach! Ach!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:854e6f8f-6bd6-471e-ba29-d128112c821e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'díl: Vezmi škorně', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Vezmi škorně',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9d1bb758-6f8a-480c-b955-8daf31cf5924' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d1bb758-6f8a-480c-b955-8daf31cf5924', 9, NULL, 'díl: Vezmi škorně', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Vezmi škorně', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d1bb758-6f8a-480c-b955-8daf31cf5924'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'díl: Introduction - Kdybych zde neseděl', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Introduction - Kdybych zde neseděl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:a0d611e0-bac2-42c6-b5a0-7e7bd09ff41a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0d611e0-bac2-42c6-b5a0-7e7bd09ff41a', 10, NULL, 'díl: Introduction - Kdybych zde neseděl', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Introduction - Kdybych zde neseděl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d611e0-bac2-42c6-b5a0-7e7bd09ff41a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'díl: Dítky, v hromadu se senděme', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Dítky, v hromadu se senděme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:aa794474-d550-465e-9d33-64d1b7f2750b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa794474-d550-465e-9d33-64d1b7f2750b', 11, NULL, 'díl: Dítky, v hromadu se senděme', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Dítky, v hromadu se senděme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa794474-d550-465e-9d33-64d1b7f2750b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'díl: Vzhůru! Vzhůru!', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Vzhůru! Vzhůru!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:b1dc10fd-ac7e-48aa-a65b-9c41b85ca7e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1dc10fd-ac7e-48aa-a65b-9c41b85ca7e6', 12, NULL, 'díl: Vzhůru! Vzhůru!', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Vzhůru! Vzhůru!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1dc10fd-ac7e-48aa-a65b-9c41b85ca7e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'díl: Aj, kázáni Rokycanovo', part.name_en = 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Aj, kázáni Rokycanovo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7478 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:f3c22c48-566a-413d-ae41-4ed6b2706e51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f3c22c48-566a-413d-ae41-4ed6b2706e51', 13, NULL, 'díl: Aj, kázáni Rokycanovo', 'Výlety páně Broučkovy: "Výlet pana Broučka do XV. století": 2. díl: Aj, kázáni Rokycanovo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e12b1b1f-da5f-4143-af8f-83b3ca0b4f41'
WHERE p.id = 7478 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3c22c48-566a-413d-ae41-4ed6b2706e51'
);


-- None 칸타타 <Věčné evangelium>

UPDATE pieces piece
SET piece.title = '칸타타 <Věčné evangelium>', piece.title_en = 'Věčné evangelium',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7600 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zdrávas Maria

UPDATE pieces piece
SET piece.title = 'Zdrávas Maria', piece.title_en = 'Zdrávas Maria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8151 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Zárlivost

UPDATE pieces piece
SET piece.title = 'Zárlivost', piece.title_en = 'Zárlivost',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7505 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Česká legie, JW IV/42>

UPDATE pieces piece
SET piece.title = '가곡 <Česká legie, JW IV/42>', piece.title_en = 'Česká legie, JW IV/42',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7432 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Čtvero mužských sborů moravských, JW IV/28

UPDATE pieces piece
SET piece.title = 'Čtvero mužských sborů moravských, JW IV/28', piece.title_en = 'Čtvero mužských sborů moravských, JW IV/28',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7479 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dež viš, JW IV/28/1', part.name_en = 'Dež viš, JW IV/28/1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7479 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:08b2a706-551a-4ef6-aa1b-4b2ddf925d5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08b2a706-551a-4ef6-aa1b-4b2ddf925d5a', 1, NULL, 'Dež viš, JW IV/28/1', 'Dež viš, JW IV/28/1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7479 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b2a706-551a-4ef6-aa1b-4b2ddf925d5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Komáři, JW IV/28/2', part.name_en = 'Komáři, JW IV/28/2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7479 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:6d04e456-f33b-40ef-bc66-2c1766a7ed59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d04e456-f33b-40ef-bc66-2c1766a7ed59', 2, NULL, 'Komáři, JW IV/28/2', 'Komáři, JW IV/28/2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7479 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d04e456-f33b-40ef-bc66-2c1766a7ed59'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Klekánica, JW IV/28/3', part.name_en = 'Klekánica, JW IV/28/3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7479 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:94726611-767f-43f6-a8c7-49decbab46f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94726611-767f-43f6-a8c7-49decbab46f9', 3, NULL, 'Klekánica, JW IV/28/3', 'Klekánica, JW IV/28/3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7479 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94726611-767f-43f6-a8c7-49decbab46f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rozloučení, JW IV/28/4', part.name_en = 'Rozloučení, JW IV/28/4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7479 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9423c135-e9c1-4f73-8abe-88b88a4ab609' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9423c135-e9c1-4f73-8abe-88b88a4ab609', 4, NULL, 'Rozloučení, JW IV/28/4', 'Rozloučení, JW IV/28/4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7479 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9423c135-e9c1-4f73-8abe-88b88a4ab609'
);


-- None Čtveřice mužských sborů, JW IV/17

UPDATE pieces piece
SET piece.title = 'Čtveřice mužských sborů, JW IV/17', piece.title_en = 'Čtveřice mužských sborů, JW IV/17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7501 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vyhrůžka, JW IV/17/1', part.name_en = 'Vyhrůžka, JW IV/17/1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7501 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:61fe43d5-7a8a-4c29-91fa-dbc9d7b3ab45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61fe43d5-7a8a-4c29-91fa-dbc9d7b3ab45', 1, NULL, 'Vyhrůžka, JW IV/17/1', 'Vyhrůžka, JW IV/17/1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7501 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61fe43d5-7a8a-4c29-91fa-dbc9d7b3ab45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ó lásko, JW IV/17/2', part.name_en = 'Ó lásko, JW IV/17/2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7501 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:d6a87933-2740-46db-98bc-50cf8ee01840' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6a87933-2740-46db-98bc-50cf8ee01840', 2, NULL, 'Ó lásko, JW IV/17/2', 'Ó lásko, JW IV/17/2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7501 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6a87933-2740-46db-98bc-50cf8ee01840'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ach vojna, vojna, JW IV/17/3', part.name_en = 'Ach vojna, vojna, JW IV/17/3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7501 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:8db290a6-770e-445d-a71d-da2be173c4d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8db290a6-770e-445d-a71d-da2be173c4d6', 3, NULL, 'Ach vojna, vojna, JW IV/17/3', 'Ach vojna, vojna, JW IV/17/3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7501 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8db290a6-770e-445d-a71d-da2be173c4d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Krásné oči tvé, JW IV/17/4', part.name_en = 'Krásné oči tvé, JW IV/17/4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7501 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:4ec5cd07-7c05-4030-87be-652c188df9e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ec5cd07-7c05-4030-87be-652c188df9e3', 4, NULL, 'Krásné oči tvé, JW IV/17/4', 'Krásné oči tvé, JW IV/17/4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7501 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ec5cd07-7c05-4030-87be-652c188df9e3'
);


-- None Říkadla, JW V/16

UPDATE pieces piece
SET piece.title = 'Říkadla, JW V/16', piece.title_en = 'Říkadla, JW V/16',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9137 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Leze krtek podle meze', part.name_en = 'Říkadla, JW V/16: I. Leze krtek podle meze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9137 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:6f28fd29-39cb-4371-a1cc-68488083644e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f28fd29-39cb-4371-a1cc-68488083644e', 1, 'I', 'Leze krtek podle meze', 'Říkadla, JW V/16: I. Leze krtek podle meze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9137 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f28fd29-39cb-4371-a1cc-68488083644e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Karel do pekla zajel', part.name_en = 'Říkadla, JW V/16: II. Karel do pekla zajel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9137 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:7ec1a99d-a257-4d89-aa6c-e5e5d6a7bbc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ec1a99d-a257-4d89-aa6c-e5e5d6a7bbc5', 2, 'II', 'Karel do pekla zajel', 'Říkadla, JW V/16: II. Karel do pekla zajel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9137 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ec1a99d-a257-4d89-aa6c-e5e5d6a7bbc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Franta rasů, hrál na basu', part.name_en = 'Říkadla, JW V/16: III. Franta rasů, hrál na basu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9137 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c109c952-1531-496b-9ec0-6cf6f0a72a0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c109c952-1531-496b-9ec0-6cf6f0a72a0f', 3, 'III', 'Franta rasů, hrál na basu', 'Říkadla, JW V/16: III. Franta rasů, hrál na basu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9137 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c109c952-1531-496b-9ec0-6cf6f0a72a0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Dělám, dělám kázání', part.name_en = 'Říkadla, JW V/16: IV. Dělám, dělám kázání',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9137 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:00cb66a9-7586-4850-8adc-a5fa85e40e71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00cb66a9-7586-4850-8adc-a5fa85e40e71', 4, 'IV', 'Dělám, dělám kázání', 'Říkadla, JW V/16: IV. Dělám, dělám kázání', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9137 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00cb66a9-7586-4850-8adc-a5fa85e40e71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Hó, hó, krávy dó', part.name_en = 'Říkadla, JW V/16: V. Hó, hó, krávy dó',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9137 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:55ce261d-9f45-452a-9814-eef248ab88a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55ce261d-9f45-452a-9814-eef248ab88a2', 5, 'V', 'Hó, hó, krávy dó', 'Říkadla, JW V/16: V. Hó, hó, krávy dó', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9137 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ce261d-9f45-452a-9814-eef248ab88a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Koza bílá hrušky sbírá', part.name_en = 'Říkadla, JW V/16: VI. Koza bílá hrušky sbírá',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9137 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:9a2eb6fb-f7b4-43cf-9019-e07791d37979' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a2eb6fb-f7b4-43cf-9019-e07791d37979', 6, 'VI', 'Koza bílá hrušky sbírá', 'Říkadla, JW V/16: VI. Koza bílá hrušky sbírá', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9137 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a2eb6fb-f7b4-43cf-9019-e07791d37979'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Vašek, pašek, bubeník', part.name_en = 'Říkadla, JW V/16: VII. Vašek, pašek, bubeník',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9137 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:c1ac05ee-6ca4-44eb-8dc2-4d96308983c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1ac05ee-6ca4-44eb-8dc2-4d96308983c0', 7, 'VII', 'Vašek, pašek, bubeník', 'Říkadla, JW V/16: VII. Vašek, pašek, bubeník', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9137 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1ac05ee-6ca4-44eb-8dc2-4d96308983c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Frantíku, Frantíku', part.name_en = 'Říkadla, JW V/16: VIII. Frantíku, Frantíku',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9137 AND p.composer_id = 104 AND part.part_key = 'musicbrainz:ced0bcaf-7cbc-4713-abce-f8dc8e01ac5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ced0bcaf-7cbc-4713-abce-f8dc8e01ac5a', 8, 'VIII', 'Frantíku, Frantíku', 'Říkadla, JW V/16: VIII. Frantíku, Frantíku', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9137 AND p.composer_id = 104
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ced0bcaf-7cbc-4713-abce-f8dc8e01ac5a'
);


-- JW 6/14 Šumařovo dítě

UPDATE pieces piece
SET piece.title = 'Šumařovo dítě', piece.title_en = 'Šumařovo dítě, JW 6/14',
    piece.type = 'song', piece.opus_number = 'JW 6/14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7440 AND piece.composer_id = 104
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ave Maria

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ave Maria', 'Ave Maria', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ave Maria'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f03a4ff7-34f3-4131-b7a9-69bddd40a5d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f03a4ff7-34f3-4131-b7a9-69bddd40a5d2'
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Ave Maria' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f03a4ff7-34f3-4131-b7a9-69bddd40a5d2'
);


-- JW 7/5 Fairy Tale for cello & piano "The Story of Tsar Berendyey"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Fairy Tale for cello & piano "The Story of Tsar Berendyey"', 'Fairy Tale for cello & piano "The Story of Tsar Berendyey", JW 7/5', 'album', 'JW 7/5', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Fairy Tale for cello & piano "The Story of Tsar Berendyey"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '508ebf85-0932-42f3-9a03-0c755640811a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '508ebf85-0932-42f3-9a03-0c755640811a'
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Fairy Tale for cello & piano "The Story of Tsar Berendyey"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '508ebf85-0932-42f3-9a03-0c755640811a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccaff25c-b9fa-48c9-bdef-1dd11580669a', 1, 'I', 'Introduction-Andante', 'Fairy Tale for cello & piano "The Story of Tsar Berendyey", JW 7/5: I. Introduction-Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Fairy Tale for cello & piano "The Story of Tsar Berendyey"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccaff25c-b9fa-48c9-bdef-1dd11580669a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da047fd8-1657-49ce-820a-1c9eec40a6cc', 2, 'II', 'Con moto', 'Fairy Tale for cello & piano "The Story of Tsar Berendyey", JW 7/5: II. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Fairy Tale for cello & piano "The Story of Tsar Berendyey"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da047fd8-1657-49ce-820a-1c9eec40a6cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a320aa2-8c26-443d-ac58-5eea59e228e1', 3, 'III', 'Con moto', 'Fairy Tale for cello & piano "The Story of Tsar Berendyey", JW 7/5: III. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Fairy Tale for cello & piano "The Story of Tsar Berendyey"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a320aa2-8c26-443d-ac58-5eea59e228e1'
);


-- None Glagolská mše

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Glagolská mše', 'Glagolská mše', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Glagolská mše'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '987e6de6-e7c3-440f-98ea-77b6cfb0dbe7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '987e6de6-e7c3-440f-98ea-77b6cfb0dbe7'
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '987e6de6-e7c3-440f-98ea-77b6cfb0dbe7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fdde847-ff73-3470-aff1-db2a388124fe', 1, 'I', 'Úvod', 'Glagolská mše: I. Úvod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fdde847-ff73-3470-aff1-db2a388124fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1717936-037e-31de-a76d-5f02d83c6c54', 2, 'II', 'Gospodi pomiluj', 'Glagolská mše: II. Gospodi pomiluj', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1717936-037e-31de-a76d-5f02d83c6c54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d28a991b-e38e-35d0-8611-bbfb80362332', 3, 'III', 'Slava', 'Glagolská mše: III. Slava', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d28a991b-e38e-35d0-8611-bbfb80362332'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf7df317-581d-3ef7-8258-06ed6d90b97e', 4, 'IV', 'Věruju', 'Glagolská mše: IV. Věruju', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf7df317-581d-3ef7-8258-06ed6d90b97e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cac8a8f3-0afb-33c2-a61a-c8c4840158c6', 5, 'V', 'Svet', 'Glagolská mše: V. Svet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cac8a8f3-0afb-33c2-a61a-c8c4840158c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c0effef-bcd2-3266-b381-60ad96dfae10', 6, 'VI', 'Agneče Božij', 'Glagolská mše: VI. Agneče Božij', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c0effef-bcd2-3266-b381-60ad96dfae10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa722136-5edc-3c1d-8ee4-b0158e73b4f7', 7, 'VII', 'Varhany sólo', 'Glagolská mše: VII. Varhany sólo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa722136-5edc-3c1d-8ee4-b0158e73b4f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99598f7a-b06e-3027-bfc0-f9ab6402c419', 8, 'VIII', 'Intrada', 'Glagolská mše: VIII. Intrada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Glagolská mše' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99598f7a-b06e-3027-bfc0-f9ab6402c419'
);


-- None Mládí

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Mládí', 'Mládí', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Mládí'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a39f5ce-26a5-4490-aec5-9fd9f2d9439a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a39f5ce-26a5-4490-aec5-9fd9f2d9439a'
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Mládí' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a39f5ce-26a5-4490-aec5-9fd9f2d9439a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11babaa9-a286-39fb-b886-b85bfb808cfb', 1, 'I', 'Allegro', 'Mládí: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Mládí' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11babaa9-a286-39fb-b886-b85bfb808cfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbb3d818-d0ca-3e0d-9f13-2d2108e7981d', 2, 'II', 'Andante sostenuto', 'Mládí: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Mládí' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbb3d818-d0ca-3e0d-9f13-2d2108e7981d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20dbbf2a-1255-3deb-affe-1856c2977033', 3, 'III', 'Vivace', 'Mládí: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Mládí' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20dbbf2a-1255-3deb-affe-1856c2977033'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e48a70ba-d21f-36a0-b776-dba7a9e635e0', 4, 'IV', 'Allegro animato', 'Mládí: IV. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Mládí' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48a70ba-d21f-36a0-b776-dba7a9e635e0'
);


-- None Sonnet in A major, JW VII/1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sonnet in A major, JW VII/1', 'Sonnet in A major, JW VII/1', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sonnet in A major, JW VII/1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5a0abc7-ce4a-4136-bc03-c5b6ba88dc51'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5a0abc7-ce4a-4136-bc03-c5b6ba88dc51'
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Sonnet in A major, JW VII/1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5a0abc7-ce4a-4136-bc03-c5b6ba88dc51'
);


-- None Sonnet in D minor, JW VII/2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sonnet in D minor, JW VII/2', 'Sonnet in D minor, JW VII/2', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sonnet in D minor, JW VII/2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58d42467-08a9-46d6-8386-e267833f55c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58d42467-08a9-46d6-8386-e267833f55c3'
FROM pieces p
WHERE p.composer_id = 104 AND p.title = 'Sonnet in D minor, JW VII/2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58d42467-08a9-46d6-8386-e267833f55c3'
);


-- None 연가곡집 <Zápisník zmizelého>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <Zápisník zmizelého>', 'Zápisník zmizelého', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 104
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <Zápisník zmizelého>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c9a8f38-d93c-4471-baf3-24ec58aae139'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c9a8f38-d93c-4471-baf3-24ec58aae139'
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c9a8f38-d93c-4471-baf3-24ec58aae139'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6f8e2d3-5581-48de-8c8e-84663e18c297', 1, NULL, '"Potkal jsem cigánku"', 'Zápisník zmizelého: "Potkal jsem cigánku"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6f8e2d3-5581-48de-8c8e-84663e18c297'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a08d2ba3-b7f3-4124-8a93-50ffe168c646', 2, NULL, '"Ta černá cigánka"', 'Zápisník zmizelého: "Ta černá cigánka"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a08d2ba3-b7f3-4124-8a93-50ffe168c646'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32da4bd6-a9c5-47f1-a981-9656df4fbbc1', 3, NULL, '"Svatojánské mušky"', 'Zápisník zmizelého: "Svatojánské mušky"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32da4bd6-a9c5-47f1-a981-9656df4fbbc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e23e693-3041-4b56-8013-2485e51f1764', 4, NULL, '"Už mlade vlaštůvky"', 'Zápisník zmizelého: "Už mlade vlaštůvky"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e23e693-3041-4b56-8013-2485e51f1764'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:403aa7f2-6667-406b-8616-eab9f5f1f955', 5, NULL, '"Táhne vůňa k lesu"', 'Zápisník zmizelého: "Táhne vůňa k lesu"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:403aa7f2-6667-406b-8616-eab9f5f1f955'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7cfa08e-e492-4edc-b801-37ea7653c47a', 6, NULL, '"Hajsi, vy sivi volci"', 'Zápisník zmizelého: "Hajsi, vy sivi volci"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7cfa08e-e492-4edc-b801-37ea7653c47a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5619168c-7c88-4ce4-8047-420e803b0e59', 7, NULL, '"Ztratil jsem kolíček"', 'Zápisník zmizelého: "Ztratil jsem kolíček"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5619168c-7c88-4ce4-8047-420e803b0e59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcc12270-42f4-4b4b-a7c2-9b3428bed4d1', 8, NULL, '"Nehled''te, volečci"', 'Zápisník zmizelého: "Nehled''te, volečci"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcc12270-42f4-4b4b-a7c2-9b3428bed4d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e4400eb-85c4-4fa4-aa64-47a0aed43ff0', 9, NULL, '"Vítaj, Janíčku"', 'Zápisník zmizelého: "Vítaj, Janíčku"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e4400eb-85c4-4fa4-aa64-47a0aed43ff0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba7f0812-b91a-4d63-9cd3-10f64cbd5e77', 10, NULL, '"Bože, dálny, nesmrtelný"', 'Zápisník zmizelého: "Bože, dálny, nesmrtelný"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba7f0812-b91a-4d63-9cd3-10f64cbd5e77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46574152-94d6-4526-ae3f-19f94d33403c', 11, NULL, '"Těžko sa mi oře"', 'Zápisník zmizelého: "Těžko sa mi oře"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46574152-94d6-4526-ae3f-19f94d33403c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a689e9b-1189-460f-b924-1b641ba4d05f', 12, NULL, '"Tmavá olšinka"', 'Zápisník zmizelého: "Tmavá olšinka"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a689e9b-1189-460f-b924-1b641ba4d05f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d9e37e1-6dc3-41fa-bda1-02725b8438f1', 13, NULL, '(Klavier solo, Intermezzo erotico)', 'Zápisník zmizelého: (Klavier solo, Intermezzo erotico)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d9e37e1-6dc3-41fa-bda1-02725b8438f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84f725cf-1505-4b92-9af5-0274defa7bc0', 14, NULL, '"Slunéčkočse zdvihá"', 'Zápisník zmizelého: "Slunéčkočse zdvihá"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84f725cf-1505-4b92-9af5-0274defa7bc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65dd35cc-27c3-448a-a9fc-d5f572cafd89', 15, NULL, '"Moji siví volci"', 'Zápisník zmizelého: "Moji siví volci"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65dd35cc-27c3-448a-a9fc-d5f572cafd89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e64b5db-4802-4427-93ef-80c857305c29', 16, NULL, '"Co jsem to udělal"', 'Zápisník zmizelého: "Co jsem to udělal"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e64b5db-4802-4427-93ef-80c857305c29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6f35d8a-5678-4df2-9389-0fb10a054fa7', 17, NULL, '"Co komu súzeno"', 'Zápisník zmizelého: "Co komu súzeno"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6f35d8a-5678-4df2-9389-0fb10a054fa7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6609d0d-7c94-4e73-9b6c-ee78e26beffa', 18, NULL, '"Nedbám já včil o nic"', 'Zápisník zmizelého: "Nedbám já včil o nic"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6609d0d-7c94-4e73-9b6c-ee78e26beffa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe01e4b1-fbec-47e7-bc3a-39e64afcbcdc', 19, NULL, '"Letí Straka letí"', 'Zápisník zmizelého: "Letí Straka letí"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe01e4b1-fbec-47e7-bc3a-39e64afcbcdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61c7f361-7242-4923-8281-b3b645f5ca9f', 20, NULL, '"Mám já panenku"', 'Zápisník zmizelého: "Mám já panenku"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61c7f361-7242-4923-8281-b3b645f5ca9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48e99101-be5d-4d5f-95d7-264a0da04377', 21, NULL, '"Můj drahý tatičku"', 'Zápisník zmizelého: "Můj drahý tatičku"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48e99101-be5d-4d5f-95d7-264a0da04377'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:836e383a-1b28-4817-ba20-1d0e28304e6b', 22, NULL, '"Sbohem, rodný kraju"', 'Zápisník zmizelého: "Sbohem, rodný kraju"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 104 AND p.title = '연가곡집 <Zápisník zmizelého>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:836e383a-1b28-4817-ba20-1d0e28304e6b'
);


-- 카탈로그에 대응이 없는 seed 작품 18개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 104 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7435, 7473, 7509, 7579, 8251, 8610, 9267, 9296, 9401, 9651, 10798, 10822, 10852, 10955, 11203, 11233, 11271, 11273
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
