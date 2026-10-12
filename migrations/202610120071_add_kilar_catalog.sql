-- 보이치에흐 킬라르 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 153개(묶음 3, 다악장 4, 낱곡 146),
-- 새 작품 18개, part 37개, 그 아래 0개.
-- seed 139개 중 135개를 작품·part 에 잇고, 1개를 숨기고, 3개는 그대로 둔다.
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
SET piece.title = 'Vocalise – Theme From The Ninth Gate (중복 16654)'
WHERE piece.id = 16654 AND piece.composer_id = 290 AND piece.title = 'Vocalise – Theme From The Ninth Gate'
  AND piece.origin = 'seed' AND piece.editor_locked = 0
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);


-- None A Certain Light

UPDATE pieces piece
SET piece.title = 'A Certain Light', piece.title_en = 'A Certain Light',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19060 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Agata's Theme

UPDATE pieces piece
SET piece.title = 'Agata''s Theme', piece.title_en = 'Agata''s Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17438 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Agata's Theme - Version 1

UPDATE pieces piece
SET piece.title = 'Agata''s Theme - Version 1', piece.title_en = 'Agata''s Theme - Version 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17470 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Agnus Dei - Clarissas Thema

UPDATE pieces piece
SET piece.title = 'Agnus Dei - Clarissas Thema', piece.title_en = 'Agnus Dei - Clarissas Thema',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17742 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Angelus

UPDATE pieces piece
SET piece.title = 'Angelus', piece.title_en = 'Angelus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18440 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Balkan’s Death

UPDATE pieces piece
SET piece.title = 'Balkan’s Death', piece.title_en = 'Balkan’s Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19889 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bernie Is Dead

UPDATE pieces piece
SET piece.title = 'Bernie Is Dead', piece.title_en = 'Bernie Is Dead',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20039 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Blood On His Face

UPDATE pieces piece
SET piece.title = 'Blood On His Face', piece.title_en = 'Blood On His Face',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16828 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Bram Stoker’s Dracula>

UPDATE pieces piece
SET piece.title = '영화음악 <Bram Stoker’s Dracula>', piece.title_en = 'Bram Stoker’s Dracula',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16066 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Ring of Fire', part.name_en = 'The Ring of Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:08ca4d94-a4a8-421e-9a5a-f492fb66c71d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08ca4d94-a4a8-421e-9a5a-f492fb66c71d', 1, NULL, 'The Ring of Fire', 'The Ring of Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08ca4d94-a4a8-421e-9a5a-f492fb66c71d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Love Song for a Vampire', part.name_en = 'Love Song for a Vampire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:0ed959df-9e91-328f-a77e-b7fc4a8b477c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ed959df-9e91-328f-a77e-b7fc4a8b477c', 2, NULL, 'Love Song for a Vampire', 'Love Song for a Vampire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ed959df-9e91-328f-a77e-b7fc4a8b477c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vampire Hunters', part.name_en = 'Vampire Hunters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:1fd1379b-6688-48ba-8fe2-3086fcff5b67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fd1379b-6688-48ba-8fe2-3086fcff5b67', 3, NULL, 'Vampire Hunters', 'Vampire Hunters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fd1379b-6688-48ba-8fe2-3086fcff5b67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Love Remembered', part.name_en = 'Love Remembered',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:2ac60b8a-5f4e-49e1-af8b-bd9be1af5ddb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ac60b8a-5f4e-49e1-af8b-bd9be1af5ddb', 4, NULL, 'Love Remembered', 'Love Remembered', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac60b8a-5f4e-49e1-af8b-bd9be1af5ddb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Hunters Prelude', part.name_en = 'The Hunters Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:43aafe23-cd47-4ccf-8147-0aff6c32d096' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43aafe23-cd47-4ccf-8147-0aff6c32d096', 5, NULL, 'The Hunters Prelude', 'The Hunters Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43aafe23-cd47-4ccf-8147-0aff6c32d096'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Mina’s Photo', part.name_en = 'Mina’s Photo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:47477fd4-4469-4ee6-a431-cc902010d402' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47477fd4-4469-4ee6-a431-cc902010d402', 6, NULL, 'Mina’s Photo', 'Mina’s Photo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47477fd4-4469-4ee6-a431-cc902010d402'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Lucy’s Party', part.name_en = 'Lucy’s Party',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:586f6c74-0bfc-456f-861c-ce9781af530f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:586f6c74-0bfc-456f-861c-ce9781af530f', 7, NULL, 'Lucy’s Party', 'Lucy’s Party', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:586f6c74-0bfc-456f-861c-ce9781af530f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'End Credits', part.name_en = 'End Credits',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:87607884-4b89-4e5a-b452-ecf6c71a5c7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87607884-4b89-4e5a-b452-ecf6c71a5c7b', 8, NULL, 'End Credits', 'End Credits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87607884-4b89-4e5a-b452-ecf6c71a5c7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Storm', part.name_en = 'The Storm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:a525dd57-a859-47cc-8efb-60b02ab04076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a525dd57-a859-47cc-8efb-60b02ab04076', 9, NULL, 'The Storm', 'The Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a525dd57-a859-47cc-8efb-60b02ab04076'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Mina/Dracula', part.name_en = 'Mina/Dracula',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:ab9d2cd3-25ce-4c3d-ab1d-d118a2207937' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab9d2cd3-25ce-4c3d-ab1d-d118a2207937', 10, NULL, 'Mina/Dracula', 'Mina/Dracula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab9d2cd3-25ce-4c3d-ab1d-d118a2207937'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Dracula — The Beginning', part.name_en = 'Dracula — The Beginning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:bfb8fd1e-2ca4-47fc-8d54-f30e69982e48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfb8fd1e-2ca4-47fc-8d54-f30e69982e48', 11, NULL, 'Dracula — The Beginning', 'Dracula — The Beginning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb8fd1e-2ca4-47fc-8d54-f30e69982e48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Love Eternal', part.name_en = 'Love Eternal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:c542219b-246a-4753-947b-13d6af0a0eb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c542219b-246a-4753-947b-13d6af0a0eb3', 12, NULL, 'Love Eternal', 'Love Eternal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c542219b-246a-4753-947b-13d6af0a0eb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'The Brides', part.name_en = 'The Brides',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:d7c99e43-e6f1-4d99-8f92-627c76656b05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7c99e43-e6f1-4d99-8f92-627c76656b05', 13, NULL, 'The Brides', 'The Brides', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7c99e43-e6f1-4d99-8f92-627c76656b05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'The Hunt Builds', part.name_en = 'The Hunt Builds',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:e7487f54-21e3-49f0-8f98-dda1b28317bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7487f54-21e3-49f0-8f98-dda1b28317bf', 14, NULL, 'The Hunt Builds', 'The Hunt Builds', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7487f54-21e3-49f0-8f98-dda1b28317bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Ascension', part.name_en = 'Ascension',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:fbf2f271-8a16-4287-b213-879c2a0e8d70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbf2f271-8a16-4287-b213-879c2a0e8d70', 15, NULL, 'Ascension', 'Ascension', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbf2f271-8a16-4287-b213-879c2a0e8d70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Green Mist', part.name_en = 'The Green Mist',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16066 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:fc6ea40b-5bc4-4b6d-9d78-fc4e255353a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc6ea40b-5bc4-4b6d-9d78-fc4e255353a4', 16, NULL, 'The Green Mist', 'The Green Mist', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16066 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc6ea40b-5bc4-4b6d-9d78-fc4e255353a4'
);


-- None Carillon

UPDATE pieces piece
SET piece.title = 'Carillon', piece.title_en = 'Carillon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19069 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chateau Saint Martin

UPDATE pieces piece
SET piece.title = 'Chateau Saint Martin', piece.title_en = 'Chateau Saint Martin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19300 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chez Toutankhamon

UPDATE pieces piece
SET piece.title = 'Chez Toutankhamon', piece.title_en = 'Chez Toutankhamon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19967 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Clarissas Tod

UPDATE pieces piece
SET piece.title = 'Clarissas Tod', piece.title_en = 'Clarissas Tod',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19740 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Corso

UPDATE pieces piece
SET piece.title = 'Corso', piece.title_en = 'Corso',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19637 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Corso And The Girl

UPDATE pieces piece
SET piece.title = 'Corso And The Girl', piece.title_en = 'Corso And The Girl',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17472 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cypresses

UPDATE pieces piece
SET piece.title = 'Cypresses', piece.title_en = 'Cypresses',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16178 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Der falsche Engel

UPDATE pieces piece
SET piece.title = 'Der falsche Engel', piece.title_en = 'Der falsche Engel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18055 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Deux fantômes au paradis

UPDATE pieces piece
SET piece.title = 'Deux fantômes au paradis', piece.title_en = 'Deux fantômes au paradis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18434 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Belagerung

UPDATE pieces piece
SET piece.title = 'Die Belagerung', piece.title_en = 'Die Belagerung',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17013 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Eroberung

UPDATE pieces piece
SET piece.title = 'Die Eroberung', piece.title_en = 'Die Eroberung',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18448 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die Hinrichtung

UPDATE pieces piece
SET piece.title = 'Die Hinrichtung', piece.title_en = 'Die Hinrichtung',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16161 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Die unmögliche Liebe

UPDATE pieces piece
SET piece.title = 'Die unmögliche Liebe', piece.title_en = 'Die unmögliche Liebe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18054 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dracula Revealed

UPDATE pieces piece
SET piece.title = 'Dracula Revealed', piece.title_en = 'Dracula Revealed',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17996 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dracula Toolbox D18A

UPDATE pieces piece
SET piece.title = 'Dracula Toolbox D18A', piece.title_en = 'Dracula Toolbox D18A',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19498 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dracula Toolbox D18B

UPDATE pieces piece
SET piece.title = 'Dracula Toolbox D18B', piece.title_en = 'Dracula Toolbox D18B',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16680 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dracula Toolbox D18C

UPDATE pieces piece
SET piece.title = 'Dracula Toolbox D18C', piece.title_en = 'Dracula Toolbox D18C',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17401 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dracula Toolbox D21

UPDATE pieces piece
SET piece.title = 'Dracula Toolbox D21', piece.title_en = 'Dracula Toolbox D21',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18422 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Engele - Melodie

UPDATE pieces piece
SET piece.title = 'Engele - Melodie', piece.title_en = 'Engele - Melodie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16313 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Engeles Traum

UPDATE pieces piece
SET piece.title = 'Engeles Traum', piece.title_en = 'Engeles Traum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17714 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Epilogue: The Portrait of a Lady

UPDATE pieces piece
SET piece.title = 'Epilogue: The Portrait of a Lady', piece.title_en = 'Epilogue: The Portrait of a Lady',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20024 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Exodus

UPDATE pieces piece
SET piece.title = 'Exodus', piece.title_en = 'Exodus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18983 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Flowers of Firenze

UPDATE pieces piece
SET piece.title = 'Flowers of Firenze', piece.title_en = 'Flowers of Firenze',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18709 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None From a Far Countrty

UPDATE pieces piece
SET piece.title = 'From a Far Countrty', piece.title_en = 'From a Far Countrty',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16361 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ghetto

UPDATE pieces piece
SET piece.title = 'Ghetto', piece.title_en = 'Ghetto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19011 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gloria (Schluß)

UPDATE pieces piece
SET piece.title = 'Gloria (Schluß)', piece.title_en = 'Gloria (Schluß)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16878 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gloria - Die Wiedertäufer

UPDATE pieces piece
SET piece.title = 'Gloria - Die Wiedertäufer', piece.title_en = 'Gloria - Die Wiedertäufer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19955 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Générique Fin

UPDATE pieces piece
SET piece.title = 'Générique Fin', piece.title_en = 'Générique Fin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17203 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hymn paschalny

UPDATE pieces piece
SET piece.title = 'Hymn paschalny', piece.title_en = 'Hymn paschalny',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16640 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Jo Z Opola>

UPDATE pieces piece
SET piece.title = '가곡 <Jo Z Opola>', piece.title_en = 'Jo Z Opola',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18687 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kalwaria

UPDATE pieces piece
SET piece.title = 'Kalwaria', piece.title_en = 'Kalwaria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19184 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Knipperdollings Tanz

UPDATE pieces piece
SET piece.title = 'Knipperdollings Tanz', piece.title_en = 'Knipperdollings Tanz',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18115 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kościelec 1909

UPDATE pieces piece
SET piece.title = 'Kościelec 1909', piece.title_en = 'Kościelec 1909',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17525 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Krzesany

UPDATE pieces piece
SET piece.title = 'Krzesany', piece.title_en = 'Krzesany',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16745 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None L'escalier Aux Cent-Mille Marches

UPDATE pieces piece
SET piece.title = 'L''escalier Aux Cent-Mille Marches', piece.title_en = 'L''escalier Aux Cent-Mille Marches',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17348 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Bergère et le Ramoneur

UPDATE pieces piece
SET piece.title = 'La Bergère et le Ramoneur', piece.title_en = 'La Bergère et le Ramoneur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16008 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Fin du Grand Automate

UPDATE pieces piece
SET piece.title = 'La Fin du Grand Automate', piece.title_en = 'La Fin du Grand Automate',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18764 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Marche Nuptiale

UPDATE pieces piece
SET piece.title = 'La Marche Nuptiale', piece.title_en = 'La Marche Nuptiale',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19207 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Polka Des Lions

UPDATE pieces piece
SET piece.title = 'La Polka Des Lions', piece.title_en = 'La Polka Des Lions',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17312 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Révolte Des Fauves

UPDATE pieces piece
SET piece.title = 'La Révolte Des Fauves', piece.title_en = 'La Révolte Des Fauves',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19542 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La Table Tournante

UPDATE pieces piece
SET piece.title = 'La Table Tournante', piece.title_en = 'La Table Tournante',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17380 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La chasse à l'oiseau

UPDATE pieces piece
SET piece.title = 'La chasse à l''oiseau', piece.title_en = 'La chasse à l''oiseau',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16669 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La complainte de l'aveugle

UPDATE pieces piece
SET piece.title = 'La complainte de l''aveugle', piece.title_en = 'La complainte de l''aveugle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17004 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None La course du fils à travers les puces

UPDATE pieces piece
SET piece.title = 'La course du fils à travers les puces', piece.title_en = 'La course du fils à travers les puces',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16970 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Cardinal

UPDATE pieces piece
SET piece.title = 'Le Cardinal', piece.title_en = 'Le Cardinal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19491 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Fantôme, son Fils, son Chauffeur et sa Voiture

UPDATE pieces piece
SET piece.title = 'Le Fantôme, son Fils, son Chauffeur et sa Voiture', piece.title_en = 'Le Fantôme, son Fils, son Chauffeur et sa Voiture',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18355 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Fou du Roi

UPDATE pieces piece
SET piece.title = 'Le Fou du Roi', piece.title_en = 'Le Fou du Roi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18097 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Petit Clown

UPDATE pieces piece
SET piece.title = 'Le Petit Clown', piece.title_en = 'Le Petit Clown',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17030 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Portrait du Roi

UPDATE pieces piece
SET piece.title = 'Le Portrait du Roi', piece.title_en = 'Le Portrait du Roi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16312 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Le roi et l'oiseau>

UPDATE pieces piece
SET piece.title = '영화음악 <Le roi et l''oiseau>', piece.title_en = 'Le roi et l''oiseau',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19166 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Générique (From "Le Roi et l''Oiseau")', part.name_en = 'Générique (From "Le Roi et l''Oiseau")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19166 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:cc5723fe-ba1d-429c-bb94-b78145b6fcf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc5723fe-ba1d-429c-bb94-b78145b6fcf1', 1, NULL, 'Générique (From "Le Roi et l''Oiseau")', 'Générique (From "Le Roi et l''Oiseau")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19166 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc5723fe-ba1d-429c-bb94-b78145b6fcf1'
);


-- None Les Appartements Secrets

UPDATE pieces piece
SET piece.title = 'Les Appartements Secrets', piece.title_en = 'Les Appartements Secrets',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16694 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Deux Rois

UPDATE pieces piece
SET piece.title = 'Les Deux Rois', piece.title_en = 'Les Deux Rois',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19347 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Les Grands Ateliers du Roi

UPDATE pieces piece
SET piece.title = 'Les Grands Ateliers du Roi', piece.title_en = 'Les Grands Ateliers du Roi',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19647 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Liana

UPDATE pieces piece
SET piece.title = 'Liana', piece.title_en = 'Liana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19407 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Liana’s Death

UPDATE pieces piece
SET piece.title = 'Liana’s Death', piece.title_en = 'Liana’s Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18822 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Love Remains

UPDATE pieces piece
SET piece.title = 'Love Remains', piece.title_en = 'Love Remains',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20074 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lucy Squirms

UPDATE pieces piece
SET piece.title = 'Lucy Squirms', piece.title_en = 'Lucy Squirms',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17426 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lucy’s Lullaby

UPDATE pieces piece
SET piece.title = 'Lucy’s Lullaby', piece.title_en = 'Lucy’s Lullaby',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17492 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lucy’s Neck

UPDATE pieces piece
SET piece.title = 'Lucy’s Neck', piece.title_en = 'Lucy’s Neck',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16474 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lucy’s Window

UPDATE pieces piece
SET piece.title = 'Lucy’s Window', piece.title_en = 'Lucy’s Window',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20081 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None L’Envol

UPDATE pieces piece
SET piece.title = 'L’Envol', piece.title_en = 'L’Envol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17836 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Manfredi's Death

UPDATE pieces piece
SET piece.title = 'Manfredi''s Death', piece.title_en = 'Manfredi''s Death',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20056 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Meditation

UPDATE pieces piece
SET piece.title = 'Meditation', piece.title_en = 'Meditation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19325 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mina / Jonathan

UPDATE pieces piece
SET piece.title = 'Mina / Jonathan', piece.title_en = 'Mina / Jonathan',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16102 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mina Possessed

UPDATE pieces piece
SET piece.title = 'Mina Possessed', piece.title_en = 'Mina Possessed',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16391 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Miserere - Die Büßer

UPDATE pieces piece
SET piece.title = 'Miserere - Die Büßer', piece.title_en = 'Miserere - Die Büßer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16756 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Miserere - Engeles Kind

UPDATE pieces piece
SET piece.title = 'Miserere - Engeles Kind', piece.title_en = 'Miserere - Engeles Kind',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19685 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Missa Pro Pace A. D. 2000

UPDATE pieces piece
SET piece.title = 'Missa Pro Pace A. D. 2000', piece.title_en = 'Missa Pro Pace A. D. 2000',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19502 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Missa Pro Pace: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19502 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:c5b02f88-794d-4ddd-9e23-5f40fe002571' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5b02f88-794d-4ddd-9e23-5f40fe002571', 1, 'I', 'Kyrie', 'Missa Pro Pace: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19502 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5b02f88-794d-4ddd-9e23-5f40fe002571'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Missa Pro Pace: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19502 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:80c29eab-fbae-45ae-b8c9-cb0bd6d6c5bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80c29eab-fbae-45ae-b8c9-cb0bd6d6c5bf', 2, 'II', 'Gloria', 'Missa Pro Pace: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19502 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80c29eab-fbae-45ae-b8c9-cb0bd6d6c5bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Credo', part.name_en = 'Missa Pro Pace: III. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19502 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:429f6ef8-335c-46a0-ba1a-ca248a1ecd3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:429f6ef8-335c-46a0-ba1a-ca248a1ecd3f', 3, 'III', 'Credo', 'Missa Pro Pace: III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19502 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:429f6ef8-335c-46a0-ba1a-ca248a1ecd3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sanctus', part.name_en = 'Missa Pro Pace: IV. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19502 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:43f83d26-0da5-42d3-b6e9-8604cfe2751c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43f83d26-0da5-42d3-b6e9-8604cfe2751c', 4, 'IV', 'Sanctus', 'Missa Pro Pace: IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19502 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43f83d26-0da5-42d3-b6e9-8604cfe2751c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Agnus Dei', part.name_en = 'Missa Pro Pace: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19502 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:8543def9-786a-4ce2-9b93-f605de5cc9e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8543def9-786a-4ce2-9b93-f605de5cc9e4', 5, 'V', 'Agnus Dei', 'Missa Pro Pace: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19502 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8543def9-786a-4ce2-9b93-f605de5cc9e4'
);


-- None Missing Book / Stalking Corso

UPDATE pieces piece
SET piece.title = 'Missing Book / Stalking Corso', piece.title_en = 'Missing Book / Stalking Corso',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20033 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Moving to the Ghetto Oct. 31, 1940

UPDATE pieces piece
SET piece.title = 'Moving to the Ghetto Oct. 31, 1940', piece.title_en = 'Moving to the Ghetto Oct. 31, 1940',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20095 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Nowa Huta

UPDATE pieces piece
SET piece.title = 'Nowa Huta', piece.title_en = 'Nowa Huta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19351 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oboe Solo

UPDATE pieces piece
SET piece.title = 'Oboe Solo', piece.title_en = 'Oboe Solo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18118 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Odwiązała Mi Się>

UPDATE pieces piece
SET piece.title = '가곡 <Odwiązała Mi Się>', piece.title_en = 'Odwiązała Mi Się',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17254 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Orawa

UPDATE pieces piece
SET piece.title = 'Orawa', piece.title_en = 'Orawa',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18912 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Papa, tu es toujours là ?

UPDATE pieces piece
SET piece.title = 'Papa, tu es toujours là ?', piece.title_en = 'Papa, tu es toujours là ?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19445 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paulina In Charge

UPDATE pieces piece
SET piece.title = 'Paulina In Charge', piece.title_en = 'Paulina In Charge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18881 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paulina's Escape

UPDATE pieces piece
SET piece.title = 'Paulina''s Escape', piece.title_en = 'Paulina''s Escape',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17972 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paulina's Revenge

UPDATE pieces piece
SET piece.title = 'Paulina''s Revenge', piece.title_en = 'Paulina''s Revenge',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18428 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paulina's Secret

UPDATE pieces piece
SET piece.title = 'Paulina''s Secret', piece.title_en = 'Paulina''s Secret',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19827 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paulina's Theme

UPDATE pieces piece
SET piece.title = 'Paulina''s Theme', piece.title_en = 'Paulina''s Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18591 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paulina's Vigil

UPDATE pieces piece
SET piece.title = 'Paulina''s Vigil', piece.title_en = 'Paulina''s Vigil',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17065 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Phantasms of Love

UPDATE pieces piece
SET piece.title = 'Phantasms of Love', piece.title_en = 'Phantasms of Love',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17553 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Piano Solo

UPDATE pieces piece
SET piece.title = 'Piano Solo', piece.title_en = 'Piano Solo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19556 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Plane To Spain

UPDATE pieces piece
SET piece.title = 'Plane To Spain', piece.title_en = 'Plane To Spain',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16078 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Prélude au mariage

UPDATE pieces piece
SET piece.title = 'Prélude au mariage', piece.title_en = 'Prélude au mariage',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16771 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Que la vie était belle

UPDATE pieces piece
SET piece.title = 'Que la vie était belle', piece.title_en = 'Que la vie était belle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16783 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Race Against the Sunset

UPDATE pieces piece
SET piece.title = 'Race Against the Sunset', piece.title_en = 'Race Against the Sunset',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16064 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Riff 62

UPDATE pieces piece
SET piece.title = 'Riff 62', piece.title_en = 'Riff 62',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16200 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Roberto Trapped

UPDATE pieces piece
SET piece.title = 'Roberto Trapped', piece.title_en = 'Roberto Trapped',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19936 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Roberto's Last Chance

UPDATE pieces piece
SET piece.title = 'Roberto''s Last Chance', piece.title_en = 'Roberto''s Last Chance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20032 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rules Café

UPDATE pieces piece
SET piece.title = 'Rules Café', piece.title_en = 'Rules Café',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17557 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rules Café Waltz

UPDATE pieces piece
SET piece.title = 'Rules Café Waltz', piece.title_en = 'Rules Café Waltz',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17422 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Salvo's Theme

UPDATE pieces piece
SET piece.title = 'Salvo''s Theme', piece.title_en = 'Salvo''s Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17104 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sanctus - Der Prophet

UPDATE pieces piece
SET piece.title = 'Sanctus - Der Prophet', piece.title_en = 'Sanctus - Der Prophet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19822 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Siwa mgła

UPDATE pieces piece
SET piece.title = 'Siwa mgła', piece.title_en = 'Siwa mgła',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15793 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None So Cold

UPDATE pieces piece
SET piece.title = 'So Cold', piece.title_en = 'So Cold',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16003 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Spilled Ink

UPDATE pieces piece
SET piece.title = 'Spilled Ink', piece.title_en = 'Spilled Ink',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17489 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Szepty i łzy (Whispers and Tears)>

UPDATE pieces piece
SET piece.title = '가곡 <Szepty i łzy (Whispers and Tears)>', piece.title_en = 'Szepty i łzy (Whispers and Tears)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16194 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Black Sun

UPDATE pieces piece
SET piece.title = 'The Black Sun', piece.title_en = 'The Black Sun',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19938 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Black Sun - Version 1

UPDATE pieces piece
SET piece.title = 'The Black Sun - Version 1', piece.title_en = 'The Black Sun - Version 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16996 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Book

UPDATE pieces piece
SET piece.title = 'The Book', piece.title_en = 'The Book',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19134 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Castle

UPDATE pieces piece
SET piece.title = 'The Castle', piece.title_en = 'The Castle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19928 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Cinema

UPDATE pieces piece
SET piece.title = 'The Cinema', piece.title_en = 'The Cinema',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16240 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Confession

UPDATE pieces piece
SET piece.title = 'The Confession', piece.title_en = 'The Confession',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19512 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Fire

UPDATE pieces piece
SET piece.title = 'The Fire', piece.title_en = 'The Fire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19365 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Funeral

UPDATE pieces piece
SET piece.title = 'The Funeral', piece.title_en = 'The Funeral',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18412 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Journey>

UPDATE pieces piece
SET piece.title = '가곡 <The Journey>', piece.title_en = 'The Journey',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17948 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Kiss

UPDATE pieces piece
SET piece.title = 'The Kiss', piece.title_en = 'The Kiss',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18037 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Legacy

UPDATE pieces piece
SET piece.title = 'The Legacy', piece.title_en = 'The Legacy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19523 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Letter II

UPDATE pieces piece
SET piece.title = 'The Letter II', piece.title_en = 'The Letter II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19458 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Motorbike

UPDATE pieces piece
SET piece.title = 'The Motorbike', piece.title_en = 'The Motorbike',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19396 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Ninth Gate

UPDATE pieces piece
SET piece.title = 'The Ninth Gate', piece.title_en = 'The Ninth Gate',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18433 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Stake

UPDATE pieces piece
SET piece.title = 'The Stake', piece.title_en = 'The Stake',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16851 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Theme for Oboe and Orchestra

UPDATE pieces piece
SET piece.title = 'Theme for Oboe and Orchestra', piece.title_en = 'Theme for Oboe and Orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18185 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None To the Brides

UPDATE pieces piece
SET piece.title = 'To the Brides', piece.title_en = 'To the Brides',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19866 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Twilight Cellos

UPDATE pieces piece
SET piece.title = 'Twilight Cellos', piece.title_en = 'Twilight Cellos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17847 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Une Française à New-York

UPDATE pieces piece
SET piece.title = 'Une Française à New-York', piece.title_en = 'Une Française à New-York',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17837 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Uwertura uroczysta

UPDATE pieces piece
SET piece.title = 'Uwertura uroczysta', piece.title_en = 'Uwertura uroczysta',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18861 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None V Symfonia "Adwentowa"

UPDATE pieces piece
SET piece.title = 'V Symfonia "Adwentowa"', piece.title_en = 'V Symfonia "Adwentowa"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19030 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Larghetto meditativo', part.name_en = 'V Symfonia "Adwentowa": I. Larghetto meditativo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19030 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:0a0826ad-4baa-48fe-bef0-18569acf6eff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a0826ad-4baa-48fe-bef0-18569acf6eff', 1, 'I', 'Larghetto meditativo', 'V Symfonia "Adwentowa": I. Larghetto meditativo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19030 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a0826ad-4baa-48fe-bef0-18569acf6eff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo religiosamente', part.name_en = 'V Symfonia "Adwentowa": II. Largo religiosamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19030 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:d3beb71d-9607-4b2f-835a-efdd60df897c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3beb71d-9607-4b2f-835a-efdd60df897c', 2, 'II', 'Largo religiosamente', 'V Symfonia "Adwentowa": II. Largo religiosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19030 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3beb71d-9607-4b2f-835a-efdd60df897c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante solennemente', part.name_en = 'V Symfonia "Adwentowa": III. Andante solennemente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19030 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:de4dbac7-7009-4e69-b690-ca4dc57411c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de4dbac7-7009-4e69-b690-ca4dc57411c4', 3, 'III', 'Andante solennemente', 'V Symfonia "Adwentowa": III. Andante solennemente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19030 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de4dbac7-7009-4e69-b690-ca4dc57411c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Largo supplichevolmente', part.name_en = 'V Symfonia "Adwentowa": IV. Largo supplichevolmente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19030 AND p.composer_id = 290 AND part.part_key = 'musicbrainz:bd187d66-d51a-43cf-9d6a-df306a29e9f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd187d66-d51a-43cf-9d6a-df306a29e9f9', 4, 'IV', 'Largo supplichevolmente', 'V Symfonia "Adwentowa": IV. Largo supplichevolmente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19030 AND p.composer_id = 290
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd187d66-d51a-43cf-9d6a-df306a29e9f9'
);


-- None Valse des Fantômes

UPDATE pieces piece
SET piece.title = 'Valse des Fantômes', piece.title_en = 'Valse des Fantômes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17564 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Victoria

UPDATE pieces piece
SET piece.title = 'Victoria', piece.title_en = 'Victoria',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17171 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vocalise – Theme From The Ninth Gate

UPDATE pieces piece
SET piece.title = 'Vocalise – Theme From The Ninth Gate', piece.title_en = 'Vocalise – Theme From The Ninth Gate',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16286 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Walc

UPDATE pieces piece
SET piece.title = 'Walc', piece.title_en = 'Walc',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15970 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Whispered Drac

UPDATE pieces piece
SET piece.title = 'Whispered Drac', piece.title_en = 'Whispered Drac',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16813 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None À Biarritz, au Casino un soir d'été

UPDATE pieces piece
SET piece.title = 'À Biarritz, au Casino un soir d''été', piece.title_en = 'À Biarritz, au Casino un soir d''été',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17572 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None “BOO !” / The Chase

UPDATE pieces piece
SET piece.title = '“BOO !” / The Chase', piece.title_en = '“BOO !” / The Chase',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19690 AND piece.composer_id = 290
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Agnus Dei

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Agnus Dei', 'Agnus Dei', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Agnus Dei'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb3d9091-27e5-4da5-8f2c-1ed52decc9bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb3d9091-27e5-4da5-8f2c-1ed52decc9bf'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Agnus Dei' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb3d9091-27e5-4da5-8f2c-1ed52decc9bf'
);


-- None Bogurodzica

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Bogurodzica', 'Bogurodzica', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Bogurodzica'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be9fb699-4434-4887-ab7f-a2b57b50ede4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be9fb699-4434-4887-ab7f-a2b57b50ede4'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Bogurodzica' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be9fb699-4434-4887-ab7f-a2b57b50ede4'
);


-- None Die Nacht

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Die Nacht', 'Die Nacht', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Die Nacht'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f7710c3-d499-4365-b055-8c3d30f46601'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f7710c3-d499-4365-b055-8c3d30f46601'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Die Nacht' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f7710c3-d499-4365-b055-8c3d30f46601'
);


-- None End Credits

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'End Credits', 'End Credits', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'End Credits'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ab1ef36-0521-4372-b103-d93b23822d68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ab1ef36-0521-4372-b103-d93b23822d68'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'End Credits' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ab1ef36-0521-4372-b103-d93b23822d68'
);


-- None End Titles

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'End Titles', 'End Titles', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'End Titles'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6f3830c-11a5-43da-b29b-42c51eb21a11'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f6f3830c-11a5-43da-b29b-42c51eb21a11'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'End Titles' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6f3830c-11a5-43da-b29b-42c51eb21a11'
);


-- None Epilogue

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Epilogue', 'Epilogue', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Epilogue'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '323090d0-9777-460b-b8cb-8c59a58c1622'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '323090d0-9777-460b-b8cb-8c59a58c1622'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Epilogue' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '323090d0-9777-460b-b8cb-8c59a58c1622'
);


-- None Father Kolbe's Preaching

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Father Kolbe''s Preaching', 'Father Kolbe''s Preaching', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Father Kolbe''s Preaching'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf4b8bad-2c19-4f7f-8d73-39e4b38d707b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf4b8bad-2c19-4f7f-8d73-39e4b38d707b'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Father Kolbe''s Preaching' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf4b8bad-2c19-4f7f-8d73-39e4b38d707b'
);


-- None Générique

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Générique', 'Générique', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Générique'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44fd9491-205b-467b-9865-214f1882487c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44fd9491-205b-467b-9865-214f1882487c'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Générique' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44fd9491-205b-467b-9865-214f1882487c'
);


-- None 마니피카트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마니피카트', 'Magnificat', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마니피카트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c508553-692f-4fd4-b2ac-ace2ab24ec8e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c508553-692f-4fd4-b2ac-ace2ab24ec8e'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c508553-692f-4fd4-b2ac-ace2ab24ec8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e2261f6-975c-41eb-a1d0-827965c3a6d7', 1, 'I', 'Magnificat (chór)', 'Magnificat: I. Magnificat (chór)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e2261f6-975c-41eb-a1d0-827965c3a6d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d523f85-7549-4b6f-b340-1544c5ff7d89', 2, 'II', 'Magnificat anima mea Dominum (sopran)', 'Magnificat: II. Magnificat anima mea Dominum (sopran)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d523f85-7549-4b6f-b340-1544c5ff7d89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c35ada5d-9f76-48d6-aae4-612068756215', 3, 'III', 'Quia respexit humilitatem (sopran, chór)', 'Magnificat: III. Quia respexit humilitatem (sopran, chór)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c35ada5d-9f76-48d6-aae4-612068756215'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bf355f0-61b2-41e8-93b0-d69b48555f11', 4, 'IV', 'Quia fecit mihi magna (sopran, bas, chór)', 'Magnificat: IV. Quia fecit mihi magna (sopran, bas, chór)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bf355f0-61b2-41e8-93b0-d69b48555f11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e03a7fc7-28d4-48fb-aceb-d7c2246ecd53', 5, 'V', 'Fecit potentiam (chór)', 'Magnificat: V. Fecit potentiam (chór)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e03a7fc7-28d4-48fb-aceb-d7c2246ecd53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4507df57-f44f-4473-97a1-f69a9cedc551', 6, 'VI', 'Esurientes implevit bonis (sopran, tenor, bas)', 'Magnificat: VI. Esurientes implevit bonis (sopran, tenor, bas)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4507df57-f44f-4473-97a1-f69a9cedc551'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e14f5171-6a77-4ca9-92e5-8cc7ba8dd750', 7, 'VII', 'Suscepit Israel (sopran, tenor, bas, chór)', 'Magnificat: VII. Suscepit Israel (sopran, tenor, bas, chór)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '마니피카트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e14f5171-6a77-4ca9-92e5-8cc7ba8dd750'
);


-- None Opening Titles

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Opening Titles', 'Opening Titles', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Opening Titles'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9dd2d3fd-f945-48f3-9e18-2262a668fcc9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9dd2d3fd-f945-48f3-9e18-2262a668fcc9'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Opening Titles' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9dd2d3fd-f945-48f3-9e18-2262a668fcc9'
);


-- None 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Piano Concerto', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c61db4c-1f77-4017-a894-9c2035c9d4f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c61db4c-1f77-4017-a894-9c2035c9d4f8'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c61db4c-1f77-4017-a894-9c2035c9d4f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16637b68-a046-495b-b47e-0b7f73021504', 1, 'I', 'Andante con moto', 'Piano Concerto: I. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16637b68-a046-495b-b47e-0b7f73021504'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d19a5be-a448-4ebd-8551-d159336850e4', 2, 'II', 'Corale', 'Piano Concerto: II. Corale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d19a5be-a448-4ebd-8551-d159336850e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80f6cdb6-72b1-4fc8-a9d9-d7016b5b2044', 3, 'III', 'Toccata', 'Piano Concerto: III. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f6cdb6-72b1-4fc8-a9d9-d7016b5b2044'
);


-- None Ring of Fire

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ring of Fire', 'Ring of Fire', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ring of Fire'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e7f1791-adc2-484d-b241-6be86fea5986'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8e7f1791-adc2-484d-b241-6be86fea5986'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Ring of Fire' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e7f1791-adc2-484d-b241-6be86fea5986'
);


-- None The End

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The End', 'The End', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The End'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00ceb92a-e942-47fc-a201-b78d77b36daa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00ceb92a-e942-47fc-a201-b78d77b36daa'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'The End' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00ceb92a-e942-47fc-a201-b78d77b36daa'
);


-- None The Fall

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Fall', 'The Fall', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Fall'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc2de52f-74f2-4a78-b050-a57115fc15dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc2de52f-74f2-4a78-b050-a57115fc15dc'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'The Fall' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc2de52f-74f2-4a78-b050-a57115fc15dc'
);


-- None The Letter

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'The Letter', 'The Letter', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'The Letter'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e882dde-1e99-4093-9072-28156e194768'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e882dde-1e99-4093-9072-28156e194768'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'The Letter' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e882dde-1e99-4093-9072-28156e194768'
);


-- None 영화음악 <The Portrait of a Lady>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <The Portrait of a Lady>', 'The Portrait of a Lady', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <The Portrait of a Lady>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23d2f844-b603-4673-b3c7-bf19224c0b31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '23d2f844-b603-4673-b3c7-bf19224c0b31'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '영화음악 <The Portrait of a Lady>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '23d2f844-b603-4673-b3c7-bf19224c0b31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c17e35ce-2a29-464d-8aec-3614ed3cc26f', 1, NULL, 'My Life Before Me', 'My Life Before Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 290 AND p.title = '영화음악 <The Portrait of a Lady>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c17e35ce-2a29-464d-8aec-3614ed3cc26f'
);


-- None Theme

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Theme', 'Theme', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Theme'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '112f8f8a-ecc0-4fdd-8cdc-6f601c96c368'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '112f8f8a-ecc0-4fdd-8cdc-6f601c96c368'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'Theme' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '112f8f8a-ecc0-4fdd-8cdc-6f601c96c368'
);


-- None V Symfonia "Adwentowa": I. Larghetto meditativo

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'V Symfonia "Adwentowa": I. Larghetto meditativo', 'V Symfonia "Adwentowa": I. Larghetto meditativo', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 290
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'V Symfonia "Adwentowa": I. Larghetto meditativo'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92ea9f27-8b68-4ef9-8fad-b24f477880fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92ea9f27-8b68-4ef9-8fad-b24f477880fa'
FROM pieces p
WHERE p.composer_id = 290 AND p.title = 'V Symfonia "Adwentowa": I. Larghetto meditativo' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92ea9f27-8b68-4ef9-8fad-b24f477880fa'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 290 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16654
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
