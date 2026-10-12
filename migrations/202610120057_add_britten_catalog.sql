-- 브리튼 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 201개(묶음 42, 다악장 50, 낱곡 109),
-- 새 작품 10개, part 537개, 그 아래 87개.
-- seed 234개 중 187개를 작품·part 에 잇고, 29개를 숨기고, 18개는 그대로 둔다.
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

-- Op. 92 연가곡집 <A Birthday Hansel>

UPDATE pieces piece
SET piece.title = '연가곡집 <A Birthday Hansel>', piece.title_en = 'A Birthday Hansel, op. 92',
    piece.type = 'song', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1191 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 3 A Boy Was Born Op. 3

UPDATE pieces piece
SET piece.title = 'A Boy Was Born Op. 3', piece.title_en = 'A Boy Was Born, op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1144 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Theme. A boy was born', part.name_en = 'A Boy Was Born, op. 3: Theme. A boy was born',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1144 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cdf996a8-8a19-4536-a8fe-0036ce800816' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf996a8-8a19-4536-a8fe-0036ce800816', 1, NULL, 'Theme. A boy was born', 'A Boy Was Born, op. 3: Theme. A boy was born', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1144 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf996a8-8a19-4536-a8fe-0036ce800816'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation I. Lullay, Jesu', part.name_en = 'A Boy Was Born, op. 3: Variation I. Lullay, Jesu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1144 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ced17cdd-e09d-4b90-8dc0-881effd985bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ced17cdd-e09d-4b90-8dc0-881effd985bf', 2, NULL, 'Variation I. Lullay, Jesu', 'A Boy Was Born, op. 3: Variation I. Lullay, Jesu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1144 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ced17cdd-e09d-4b90-8dc0-881effd985bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation II. Herod', part.name_en = 'A Boy Was Born, op. 3: Variation II. Herod',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1144 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8070be33-c007-4ffb-b5b1-1312c8ca4c13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8070be33-c007-4ffb-b5b1-1312c8ca4c13', 3, NULL, 'Variation II. Herod', 'A Boy Was Born, op. 3: Variation II. Herod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1144 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8070be33-c007-4ffb-b5b1-1312c8ca4c13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation III. Jesu, as Thou art our Saviour', part.name_en = 'A Boy Was Born, op. 3: Variation III. Jesu, as Thou art our Saviour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1144 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:87867a92-7ff7-4127-a28d-eac5d4871c7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87867a92-7ff7-4127-a28d-eac5d4871c7b', 4, NULL, 'Variation III. Jesu, as Thou art our Saviour', 'A Boy Was Born, op. 3: Variation III. Jesu, as Thou art our Saviour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1144 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87867a92-7ff7-4127-a28d-eac5d4871c7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation IV. The three kings', part.name_en = 'A Boy Was Born, op. 3: Variation IV. The three kings',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1144 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fb1991f8-ae13-4c23-b1c8-a0dd03c4fa44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb1991f8-ae13-4c23-b1c8-a0dd03c4fa44', 5, NULL, 'Variation IV. The three kings', 'A Boy Was Born, op. 3: Variation IV. The three kings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1144 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb1991f8-ae13-4c23-b1c8-a0dd03c4fa44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation V. In the bleak mid-winter', part.name_en = 'A Boy Was Born, op. 3: Variation V. In the bleak mid-winter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1144 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f1ade710-5f9e-4bef-94f7-8c10a74ec72d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1ade710-5f9e-4bef-94f7-8c10a74ec72d', 6, NULL, 'Variation V. In the bleak mid-winter', 'A Boy Was Born, op. 3: Variation V. In the bleak mid-winter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1144 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1ade710-5f9e-4bef-94f7-8c10a74ec72d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1ade710-5f9e-4bef-94f7-8c10a74ec72d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Corpus Christi Carol', part.name_en = 'Corpus Christi Carol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1144 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8c8559e1-20b9-342a-ab79-9f98a1095060' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c8559e1-20b9-342a-ab79-9f98a1095060', 1, NULL, 'Corpus Christi Carol', 'Corpus Christi Carol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1ade710-5f9e-4bef-94f7-8c10a74ec72d'
WHERE p.id = 1144 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c8559e1-20b9-342a-ab79-9f98a1095060'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation VI (Finale). Noel!', part.name_en = 'A Boy Was Born, op. 3: Variation VI (Finale). Noel!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1144 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:38e17615-3d4d-45be-8298-81a35116bc60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38e17615-3d4d-45be-8298-81a35116bc60', 7, NULL, 'Variation VI (Finale). Noel!', 'A Boy Was Born, op. 3: Variation VI (Finale). Noel!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1144 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38e17615-3d4d-45be-8298-81a35116bc60'
);


-- None A Fanfare for June 30th 1970

UPDATE pieces piece
SET piece.title = 'A Fanfare for June 30th 1970', piece.title_en = 'A Fanfare for June 30th 1970',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1194 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Hymn of St Columba

UPDATE pieces piece
SET piece.title = 'A Hymn of St Columba', piece.title_en = 'A Hymn of St Columba',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2100 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Little Idyll

UPDATE pieces piece
SET piece.title = 'A Little Idyll', piece.title_en = 'A Little Idyll',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2801 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <A Poison Tree>

UPDATE pieces piece
SET piece.title = '가곡 <A Poison Tree>', piece.title_en = 'A Poison Tree',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2609 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Shepherd's Carol

UPDATE pieces piece
SET piece.title = 'A Shepherd''s Carol', piece.title_en = 'A Shepherd''s Carol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2634 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None A Suite on English Folk Tunes, op. 90 "A Time There Was"

UPDATE pieces piece
SET piece.title = 'A Suite on English Folk Tunes, op. 90 "A Time There Was"', piece.title_en = 'A Suite on English Folk Tunes, op. 90 "A Time There Was"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1007 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Cakes and Ale', part.name_en = 'A Suite on English Folk Tunes, op. 90 "A Time There Was": I. Cakes and Ale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1007 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:65fccc72-d100-4293-bc82-62f5842fcedd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65fccc72-d100-4293-bc82-62f5842fcedd', 1, 'I', 'Cakes and Ale', 'A Suite on English Folk Tunes, op. 90 "A Time There Was": I. Cakes and Ale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1007 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65fccc72-d100-4293-bc82-62f5842fcedd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Bitter Withy', part.name_en = 'A Suite on English Folk Tunes, op. 90 "A Time There Was": II. The Bitter Withy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1007 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:99a8db85-b451-43d9-92f9-04c91ac4301d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99a8db85-b451-43d9-92f9-04c91ac4301d', 2, 'II', 'The Bitter Withy', 'A Suite on English Folk Tunes, op. 90 "A Time There Was": II. The Bitter Withy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1007 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99a8db85-b451-43d9-92f9-04c91ac4301d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Hankin Booby', part.name_en = 'A Suite on English Folk Tunes, op. 90 "A Time There Was": III. Hankin Booby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1007 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3b0c4ab0-28be-4163-8a0d-a6a721da3988' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b0c4ab0-28be-4163-8a0d-a6a721da3988', 3, 'III', 'Hankin Booby', 'A Suite on English Folk Tunes, op. 90 "A Time There Was": III. Hankin Booby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1007 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b0c4ab0-28be-4163-8a0d-a6a721da3988'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Hunt the Squirrel', part.name_en = 'A Suite on English Folk Tunes, op. 90 "A Time There Was": IV. Hunt the Squirrel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1007 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9a625e4d-9c0e-46f1-beeb-04a9d9985622' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a625e4d-9c0e-46f1-beeb-04a9d9985622', 4, 'IV', 'Hunt the Squirrel', 'A Suite on English Folk Tunes, op. 90 "A Time There Was": IV. Hunt the Squirrel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1007 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a625e4d-9c0e-46f1-beeb-04a9d9985622'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lord Melbourne', part.name_en = 'A Suite on English Folk Tunes, op. 90 "A Time There Was": V. Lord Melbourne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1007 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4c973613-5944-4b80-96f0-e764f41efe12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c973613-5944-4b80-96f0-e764f41efe12', 5, 'V', 'Lord Melbourne', 'A Suite on English Folk Tunes, op. 90 "A Time There Was": V. Lord Melbourne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1007 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c973613-5944-4b80-96f0-e764f41efe12'
);


-- None A Sweet Lullaby

UPDATE pieces piece
SET piece.title = 'A Sweet Lullaby', piece.title_en = 'A Sweet Lullaby',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2656 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 46 A Wedding Anthem

UPDATE pieces piece
SET piece.title = 'A Wedding Anthem', piece.title_en = 'A Wedding Anthem, op. 46',
    piece.type = 'song', piece.opus_number = 'Op. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2833 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 칸타타 <A.M.D.G.>

UPDATE pieces piece
SET piece.title = '칸타타 <A.M.D.G.>', piece.title_en = 'A.M.D.G.',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 566 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prayer I', part.name_en = 'A.M.D.G.: I. Prayer I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 566 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ae2d2c97-0c2d-48e7-8a4e-666e4eafd28d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae2d2c97-0c2d-48e7-8a4e-666e4eafd28d', 1, 'I', 'Prayer I', 'A.M.D.G.: I. Prayer I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 566 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae2d2c97-0c2d-48e7-8a4e-666e4eafd28d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rosa Mystica', part.name_en = 'A.M.D.G.: II. Rosa Mystica',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 566 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2c2fa17a-fb51-41b3-a21c-e7390af4d0e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c2fa17a-fb51-41b3-a21c-e7390af4d0e3', 2, 'II', 'Rosa Mystica', 'A.M.D.G.: II. Rosa Mystica', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 566 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c2fa17a-fb51-41b3-a21c-e7390af4d0e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'God’s Grandeur', part.name_en = 'A.M.D.G.: III. God’s Grandeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 566 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cb161807-3092-40a5-b4ec-65efdbd3c054' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb161807-3092-40a5-b4ec-65efdbd3c054', 3, 'III', 'God’s Grandeur', 'A.M.D.G.: III. God’s Grandeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 566 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb161807-3092-40a5-b4ec-65efdbd3c054'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Prayer II', part.name_en = 'A.M.D.G.: IV. Prayer II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 566 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b272045d-5733-4382-9a48-f19bcbb18437' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b272045d-5733-4382-9a48-f19bcbb18437', 4, 'IV', 'Prayer II', 'A.M.D.G.: IV. Prayer II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 566 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b272045d-5733-4382-9a48-f19bcbb18437'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'O Deus, ego amo te', part.name_en = 'A.M.D.G.: V. O Deus, ego amo te',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 566 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8de479a1-c565-487c-b41c-aa3d578f9f3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8de479a1-c565-487c-b41c-aa3d578f9f3c', 5, 'V', 'O Deus, ego amo te', 'A.M.D.G.: V. O Deus, ego amo te', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 566 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8de479a1-c565-487c-b41c-aa3d578f9f3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'The Soldier', part.name_en = 'A.M.D.G.: VI. The Soldier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 566 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c9faef9a-f308-40b6-b850-a0ab445df50e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9faef9a-f308-40b6-b850-a0ab445df50e', 6, 'VI', 'The Soldier', 'A.M.D.G.: VI. The Soldier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 566 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9faef9a-f308-40b6-b850-a0ab445df50e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Heaven-Haven', part.name_en = 'A.M.D.G.: VII. Heaven-Haven',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 566 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fe576232-f87f-48e9-84ea-4011e1fc10f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe576232-f87f-48e9-84ea-4011e1fc10f9', 7, 'VII', 'Heaven-Haven', 'A.M.D.G.: VII. Heaven-Haven', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 566 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe576232-f87f-48e9-84ea-4011e1fc10f9'
);


-- None Advance Democracy

UPDATE pieces piece
SET piece.title = 'Advance Democracy', piece.title_en = 'Advance Democracy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1471 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 39 오페라 <Albert Herring> Op. 39

UPDATE pieces piece
SET piece.title = '오페라 <Albert Herring> Op. 39', piece.title_en = 'Albert Herring, op. 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2095 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Albert Herring, op. 39: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29', 1, NULL, 'Act I', 'Albert Herring, op. 39: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Stuffy!" (Lady Billows)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. "Stuffy!" (Lady Billows)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0012ca58-568e-300a-b43f-e9693a027ebf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0012ca58-568e-300a-b43f-e9693a027ebf', 1, NULL, 'Scene I. "Stuffy!" (Lady Billows)', 'Albert Herring, op. 39: Act I, Scene I. "Stuffy!" (Lady Billows)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0012ca58-568e-300a-b43f-e9693a027ebf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Bounce me high" (Kids)', part.name_en = 'Albert Herring, op. 39: Act I, Scene II. "Bounce me high" (Kids)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:11883ec6-1593-3263-82c6-657e8ce5ca5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11883ec6-1593-3263-82c6-657e8ce5ca5d', 2, NULL, 'Scene II. "Bounce me high" (Kids)', 'Albert Herring, op. 39: Act I, Scene II. "Bounce me high" (Kids)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11883ec6-1593-3263-82c6-657e8ce5ca5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Is this all you can bring?" (Lady Billows)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. "Is this all you can bring?" (Lady Billows)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:119c23d8-4131-34e9-ace9-dc46dc328c0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:119c23d8-4131-34e9-ace9-dc46dc328c0e', 3, NULL, 'Scene I. "Is this all you can bring?" (Lady Billows)', 'Albert Herring, op. 39: Act I, Scene I. "Is this all you can bring?" (Lady Billows)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:119c23d8-4131-34e9-ace9-dc46dc328c0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Now then! Notebook, Florence!" (Lady Billows)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. "Now then! Notebook, Florence!" (Lady Billows)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2735aede-e232-3011-ae5f-64166c42ac90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2735aede-e232-3011-ae5f-64166c42ac90', 4, NULL, 'Scene I. "Now then! Notebook, Florence!" (Lady Billows)', 'Albert Herring, op. 39: Act I, Scene I. "Now then! Notebook, Florence!" (Lady Billows)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2735aede-e232-3011-ae5f-64166c42ac90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Tickling a trout" (Sid)', part.name_en = 'Albert Herring, op. 39: Act I, Scene II. "Tickling a trout" (Sid)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4c40d979-465f-332f-8a8e-af6e2d2b7376' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c40d979-465f-332f-8a8e-af6e2d2b7376', 5, NULL, 'Scene II. "Tickling a trout" (Sid)', 'Albert Herring, op. 39: Act I, Scene II. "Tickling a trout" (Sid)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c40d979-465f-332f-8a8e-af6e2d2b7376'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene II. "He''s much too busy" (Albert)', part.name_en = 'Albert Herring, op. 39: Act I, Scene II. "He''s much too busy" (Albert)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5aa64946-3491-32b0-bff7-cc4bba9c660c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5aa64946-3491-32b0-bff7-cc4bba9c660c', 6, NULL, 'Scene II. "He''s much too busy" (Albert)', 'Albert Herring, op. 39: Act I, Scene II. "He''s much too busy" (Albert)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aa64946-3491-32b0-bff7-cc4bba9c660c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Shop! Hi! Albert!" (Sid)', part.name_en = 'Albert Herring, op. 39: Act I, Scene II. "Shop! Hi! Albert!" (Sid)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6b72046b-9775-3112-adbc-b4f5c8ae35ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b72046b-9775-3112-adbc-b4f5c8ae35ad', 7, NULL, 'Scene II. "Shop! Hi! Albert!" (Sid)', 'Albert Herring, op. 39: Act I, Scene II. "Shop! Hi! Albert!" (Sid)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b72046b-9775-3112-adbc-b4f5c8ae35ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene I. Interlude', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7d99c390-38cf-380b-b17a-1d1f3eb91375' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d99c390-38cf-380b-b17a-1d1f3eb91375', 8, NULL, 'Scene I. Interlude', 'Albert Herring, op. 39: Act I, Scene I. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d99c390-38cf-380b-b17a-1d1f3eb91375'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Beggin'' your pardon" (Superintendent Budd)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. "Beggin'' your pardon" (Superintendent Budd)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8f5756b4-958d-3534-93f1-88bf45f23a99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8f5756b4-958d-3534-93f1-88bf45f23a99', 9, NULL, 'Scene I. "Beggin'' your pardon" (Superintendent Budd)', 'Albert Herring, op. 39: Act I, Scene I. "Beggin'' your pardon" (Superintendent Budd)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f5756b4-958d-3534-93f1-88bf45f23a99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene I. "The first suggestion on my list" (Vicar)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. "The first suggestion on my list" (Vicar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b0f678ab-1eef-38ef-8989-6c562eec23bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0f678ab-1eef-38ef-8989-6c562eec23bd', 10, NULL, 'Scene I. "The first suggestion on my list" (Vicar)', 'Albert Herring, op. 39: Act I, Scene I. "The first suggestion on my list" (Vicar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0f678ab-1eef-38ef-8989-6c562eec23bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Good morning, young man" (Florence)', part.name_en = 'Albert Herring, op. 39: Act I, Scene II. "Good morning, young man" (Florence)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b699a52f-7b15-3f65-95ba-ceb902da7b31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b699a52f-7b15-3f65-95ba-ceb902da7b31', 11, NULL, 'Scene II. "Good morning, young man" (Florence)', 'Albert Herring, op. 39: Act I, Scene II. "Good morning, young man" (Florence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b699a52f-7b15-3f65-95ba-ceb902da7b31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene I. “I hope we’re not too early, Florence?” (Miss Wordsworth)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. “I hope we’re not too early, Florence?” (Miss Wordsworth)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cd525004-5723-36f8-a200-ce1559eaf813' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd525004-5723-36f8-a200-ce1559eaf813', 12, NULL, 'Scene I. “I hope we’re not too early, Florence?” (Miss Wordsworth)', 'Albert Herring, op. 39: Act I, Scene I. “I hope we’re not too early, Florence?” (Miss Wordsworth)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd525004-5723-36f8-a200-ce1559eaf813'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Meet me at a quarter past eight" (Sid)', part.name_en = 'Albert Herring, op. 39: Act I, Scene II. "Meet me at a quarter past eight" (Sid)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d35bdcee-bbcd-3209-a99d-36030fdf4e9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d35bdcee-bbcd-3209-a99d-36030fdf4e9d', 13, NULL, 'Scene II. "Meet me at a quarter past eight" (Sid)', 'Albert Herring, op. 39: Act I, Scene II. "Meet me at a quarter past eight" (Sid)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d35bdcee-bbcd-3209-a99d-36030fdf4e9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Scene II. "We bring great news to you" (Lady Billows)', part.name_en = 'Albert Herring, op. 39: Act I, Scene II. "We bring great news to you" (Lady Billows)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d8e1b865-9804-3644-98de-748ca1ebce73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8e1b865-9804-3644-98de-748ca1ebce73', 14, NULL, 'Scene II. "We bring great news to you" (Lady Billows)', 'Albert Herring, op. 39: Act I, Scene II. "We bring great news to you" (Lady Billows)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8e1b865-9804-3644-98de-748ca1ebce73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Right! We''ll have him!" (Lady Billows)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. "Right! We''ll have him!" (Lady Billows)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e97f6ecd-e730-3ec3-b316-b173b50ee52e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e97f6ecd-e730-3ec3-b316-b173b50ee52e', 15, NULL, 'Scene I. "Right! We''ll have him!" (Lady Billows)', 'Albert Herring, op. 39: Act I, Scene I. "Right! We''ll have him!" (Lady Billows)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e97f6ecd-e730-3ec3-b316-b173b50ee52e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Doctor Jessop''s midwife" (Florence)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. "Doctor Jessop''s midwife" (Florence)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ea4b4824-47de-38e5-bafb-d26a81c7ee6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea4b4824-47de-38e5-bafb-d26a81c7ee6a', 16, NULL, 'Scene I. "Doctor Jessop''s midwife" (Florence)', 'Albert Herring, op. 39: Act I, Scene I. "Doctor Jessop''s midwife" (Florence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea4b4824-47de-38e5-bafb-d26a81c7ee6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Flor-ence!...tell the midwife!" (Lady Billows)', part.name_en = 'Albert Herring, op. 39: Act I, Scene I. "Flor-ence!...tell the midwife!" (Lady Billows)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f988dd6e-ff7e-3d32-8889-a6513808cfac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f988dd6e-ff7e-3d32-8889-a6513808cfac', 17, NULL, 'Scene I. "Flor-ence!...tell the midwife!" (Lady Billows)', 'Albert Herring, op. 39: Act I, Scene I. "Flor-ence!...tell the midwife!" (Lady Billows)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbacfe34-61f1-48cb-bd6c-df7fd4595b29'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f988dd6e-ff7e-3d32-8889-a6513808cfac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Albert Herring, op. 39: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2', 2, NULL, 'Act II', 'Albert Herring, op. 39: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Isn''t he here?" (Florence)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "Isn''t he here?" (Florence)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2816bc84-84db-365c-810e-2891dc1d1a01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2816bc84-84db-365c-810e-2891dc1d1a01', 1, NULL, 'Scene I. "Isn''t he here?" (Florence)', 'Albert Herring, op. 39: Act II, Scene I. "Isn''t he here?" (Florence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2816bc84-84db-365c-810e-2891dc1d1a01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene I. "My flowers are few" (Harry)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "My flowers are few" (Harry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:302bb381-6e9e-3988-93cd-8ac8ef31e083' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:302bb381-6e9e-3988-93cd-8ac8ef31e083', 2, NULL, 'Scene I. "My flowers are few" (Harry)', 'Albert Herring, op. 39: Act II, Scene I. "My flowers are few" (Harry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:302bb381-6e9e-3988-93cd-8ac8ef31e083'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Here they are dears!" (Miss Wordsworth)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "Here they are dears!" (Miss Wordsworth)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4771c86e-a09c-32ce-9d83-aa97cfd0f453' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4771c86e-a09c-32ce-9d83-aa97cfd0f453', 3, NULL, 'Scene I. "Here they are dears!" (Miss Wordsworth)', 'Albert Herring, op. 39: Act II, Scene I. "Here they are dears!" (Miss Wordsworth)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4771c86e-a09c-32ce-9d83-aa97cfd0f453'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Scene I. "For three precious weeks" (Florence)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "For three precious weeks" (Florence)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4c986e87-4a94-3411-b275-319d667d1cef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c986e87-4a94-3411-b275-319d667d1cef', 4, NULL, 'Scene I. "For three precious weeks" (Florence)', 'Albert Herring, op. 39: Act II, Scene I. "For three precious weeks" (Florence)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c986e87-4a94-3411-b275-319d667d1cef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Scene II. "You oughtn''t to whistle!" (Nancy)', part.name_en = 'Albert Herring, op. 39: Act II, Scene II. "You oughtn''t to whistle!" (Nancy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5bd85fe5-469f-39af-a108-14f1457d7801' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5bd85fe5-469f-39af-a108-14f1457d7801', 5, NULL, 'Scene II. "You oughtn''t to whistle!" (Nancy)', 'Albert Herring, op. 39: Act II, Scene II. "You oughtn''t to whistle!" (Nancy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bd85fe5-469f-39af-a108-14f1457d7801'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Quickly, quickly, come along!" (Miss Wordsworth)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "Quickly, quickly, come along!" (Miss Wordsworth)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:848ae69e-29ab-37d1-b1c0-0bc6137a8ad0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:848ae69e-29ab-37d1-b1c0-0bc6137a8ad0', 6, NULL, 'Scene I. "Quickly, quickly, come along!" (Miss Wordsworth)', 'Albert Herring, op. 39: Act II, Scene I. "Quickly, quickly, come along!" (Miss Wordsworth)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:848ae69e-29ab-37d1-b1c0-0bc6137a8ad0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Scene I. "My heart leaps up with joy" (Miss Wordsworth)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "My heart leaps up with joy" (Miss Wordsworth)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:84d8cec8-665a-31eb-b068-54a946d56901' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84d8cec8-665a-31eb-b068-54a946d56901', 7, NULL, 'Scene I. "My heart leaps up with joy" (Miss Wordsworth)', 'Albert Herring, op. 39: Act II, Scene I. "My heart leaps up with joy" (Miss Wordsworth)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84d8cec8-665a-31eb-b068-54a946d56901'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Albert the Good!" (Albert)', part.name_en = 'Albert Herring, op. 39: Act II, Scene II. "Albert the Good!" (Albert)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a72671b3-7881-308e-8daf-74590b7ae8fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a72671b3-7881-308e-8daf-74590b7ae8fd', 8, NULL, 'Scene II. "Albert the Good!" (Albert)', 'Albert Herring, op. 39: Act II, Scene II. "Albert the Good!" (Albert)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a72671b3-7881-308e-8daf-74590b7ae8fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Well tried, Albert!" (Vicar)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "Well tried, Albert!" (Vicar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:abfc4dc2-e916-3a80-83c8-f3039ee8cf0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:abfc4dc2-e916-3a80-83c8-f3039ee8cf0f', 9, NULL, 'Scene I. "Well tried, Albert!" (Vicar)', 'Albert Herring, op. 39: Act II, Scene I. "Well tried, Albert!" (Vicar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abfc4dc2-e916-3a80-83c8-f3039ee8cf0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Scene I. Interlude', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ac374dec-f5c7-39f4-af8b-572dac57a9f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac374dec-f5c7-39f4-af8b-572dac57a9f8', 10, NULL, 'Scene I. Interlude', 'Albert Herring, op. 39: Act II, Scene I. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac374dec-f5c7-39f4-af8b-572dac57a9f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Scene I. "I''m full of happiness" (Lady Billows)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "I''m full of happiness" (Lady Billows)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bcb84784-e2af-3f22-a42a-3cf170f592f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bcb84784-e2af-3f22-a42a-3cf170f592f2', 11, NULL, 'Scene I. "I''m full of happiness" (Lady Billows)', 'Albert Herring, op. 39: Act II, Scene I. "I''m full of happiness" (Lady Billows)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcb84784-e2af-3f22-a42a-3cf170f592f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Scene I. "Er-humph! Er-humph! I''m no great shakes" (Superintendent Budd)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "Er-humph! Er-humph! I''m no great shakes" (Superintendent Budd)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:db3269e0-0593-3fd9-974a-55e9de331b69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db3269e0-0593-3fd9-974a-55e9de331b69', 12, NULL, 'Scene I. "Er-humph! Er-humph! I''m no great shakes" (Superintendent Budd)', 'Albert Herring, op. 39: Act II, Scene I. "Er-humph! Er-humph! I''m no great shakes" (Superintendent Budd)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db3269e0-0593-3fd9-974a-55e9de331b69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Scene I. "As representing the local Council" (Mayor)', part.name_en = 'Albert Herring, op. 39: Act II, Scene I. "As representing the local Council" (Mayor)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ee19e5ca-79f2-32a9-8b9f-063c2e3bd432' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee19e5ca-79f2-32a9-8b9f-063c2e3bd432', 13, NULL, 'Scene I. "As representing the local Council" (Mayor)', 'Albert Herring, op. 39: Act II, Scene I. "As representing the local Council" (Mayor)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee19e5ca-79f2-32a9-8b9f-063c2e3bd432'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Scene II. "Heaven helps those who help themselves!" (Albert)', part.name_en = 'Albert Herring, op. 39: Act II, Scene II. "Heaven helps those who help themselves!" (Albert)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f6b87998-5f29-3c53-a030-c5e16807684f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f6b87998-5f29-3c53-a030-c5e16807684f', 14, NULL, 'Scene II. "Heaven helps those who help themselves!" (Albert)', 'Albert Herring, op. 39: Act II, Scene II. "Heaven helps those who help themselves!" (Albert)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:008d0435-2a64-42cb-93de-3dd84f24a7d2'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6b87998-5f29-3c53-a030-c5e16807684f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Albert Herring, op. 39: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda', 3, NULL, 'Act III', 'Albert Herring, op. 39: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act III. "Have you found him?" (Mum)', part.name_en = 'Albert Herring, op. 39: Act III. "Have you found him?" (Mum)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0f749bfb-ecf1-35d4-be12-3613d0bdb605' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f749bfb-ecf1-35d4-be12-3613d0bdb605', 1, NULL, 'Act III. "Have you found him?" (Mum)', 'Albert Herring, op. 39: Act III. "Have you found him?" (Mum)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f749bfb-ecf1-35d4-be12-3613d0bdb605'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act III. "Is she asleep?" (Emmie)', part.name_en = 'Albert Herring, op. 39: Act III. "Is she asleep?" (Emmie)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1ccdb8bd-3e63-3542-baca-5dc6c89fd726' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ccdb8bd-3e63-3542-baca-5dc6c89fd726', 2, NULL, 'Act III. "Is she asleep?" (Emmie)', 'Albert Herring, op. 39: Act III. "Is she asleep?" (Emmie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ccdb8bd-3e63-3542-baca-5dc6c89fd726'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III. "Albert...!" (All)', part.name_en = 'Albert Herring, op. 39: Act III. "Albert...!" (All)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:382b1996-cc9f-3b47-b24e-8c9fb25bd934' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:382b1996-cc9f-3b47-b24e-8c9fb25bd934', 3, NULL, 'Act III. "Albert...!" (All)', 'Albert Herring, op. 39: Act III. "Albert...!" (All)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:382b1996-cc9f-3b47-b24e-8c9fb25bd934'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III. "Albert''s come back to stay" (Nancy, Sid, Emmie, Cis, Harry)', part.name_en = 'Albert Herring, op. 39: Act III. "Albert''s come back to stay" (Nancy, Sid, Emmie, Cis, Harry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:481946b0-105f-39be-9f61-11e07868cb44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:481946b0-105f-39be-9f61-11e07868cb44', 4, NULL, 'Act III. "Albert''s come back to stay" (Nancy, Sid, Emmie, Cis, Harry)', 'Albert Herring, op. 39: Act III. "Albert''s come back to stay" (Nancy, Sid, Emmie, Cis, Harry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:481946b0-105f-39be-9f61-11e07868cb44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Act III. "Fools! Fools! Blundering fools!" (Lady Billows)', part.name_en = 'Albert Herring, op. 39: Act III. "Fools! Fools! Blundering fools!" (Lady Billows)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:58d0da3c-651b-39cc-af10-57f29d6b3622' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58d0da3c-651b-39cc-af10-57f29d6b3622', 5, NULL, 'Act III. "Fools! Fools! Blundering fools!" (Lady Billows)', 'Albert Herring, op. 39: Act III. "Fools! Fools! Blundering fools!" (Lady Billows)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58d0da3c-651b-39cc-af10-57f29d6b3622'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Act III. "I''m sorry about that" (Albert)', part.name_en = 'Albert Herring, op. 39: Act III. "I''m sorry about that" (Albert)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7be6abed-0de4-3e53-9d89-072a7a0d00e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7be6abed-0de4-3e53-9d89-072a7a0d00e3', 6, NULL, 'Act III. "I''m sorry about that" (Albert)', 'Albert Herring, op. 39: Act III. "I''m sorry about that" (Albert)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7be6abed-0de4-3e53-9d89-072a7a0d00e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Act III. "Give me a decent murder with a corpse!" (Superintendent Budd)', part.name_en = 'Albert Herring, op. 39: Act III. "Give me a decent murder with a corpse!" (Superintendent Budd)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:80f145fd-564a-375e-94f3-b849e42389aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80f145fd-564a-375e-94f3-b849e42389aa', 7, NULL, 'Act III. "Give me a decent murder with a corpse!" (Superintendent Budd)', 'Albert Herring, op. 39: Act III. "Give me a decent murder with a corpse!" (Superintendent Budd)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f145fd-564a-375e-94f3-b849e42389aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Act III. Introduction', part.name_en = 'Albert Herring, op. 39: Act III. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:adf8feac-b9c3-35c9-b97d-123092bc3505' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:adf8feac-b9c3-35c9-b97d-123092bc3505', 8, NULL, 'Act III. Introduction', 'Albert Herring, op. 39: Act III. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adf8feac-b9c3-35c9-b97d-123092bc3505'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Act III. "In the midst of life is death" (All)', part.name_en = 'Albert Herring, op. 39: Act III. "In the midst of life is death" (All)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d6b30c94-4ea6-3305-8ef7-01d5fbcb8b1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6b30c94-4ea6-3305-8ef7-01d5fbcb8b1e', 9, NULL, 'Act III. "In the midst of life is death" (All)', 'Albert Herring, op. 39: Act III. "In the midst of life is death" (All)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6b30c94-4ea6-3305-8ef7-01d5fbcb8b1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Act III. "I''m hungry, I''m tired" (Sid)', part.name_en = 'Albert Herring, op. 39: Act III. "I''m hungry, I''m tired" (Sid)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ea008adb-efed-332f-a52e-0feab71e3513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea008adb-efed-332f-a52e-0feab71e3513', 10, NULL, 'Act III. "I''m hungry, I''m tired" (Sid)', 'Albert Herring, op. 39: Act III. "I''m hungry, I''m tired" (Sid)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea008adb-efed-332f-a52e-0feab71e3513'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Act III. "I can''t remember everything" (Albert)', part.name_en = 'Albert Herring, op. 39: Act III. "I can''t remember everything" (Albert)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2095 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fba8fa0d-9439-3034-99f9-f2cccf431889' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fba8fa0d-9439-3034-99f9-f2cccf431889', 11, NULL, 'Act III. "I can''t remember everything" (Albert)', 'Albert Herring, op. 39: Act III. "I can''t remember everything" (Albert)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f5b76424-661f-40a1-a6d5-f60046833fda'
WHERE p.id = 2095 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba8fa0d-9439-3034-99f9-f2cccf431889'
);


-- None Alla Marcia

UPDATE pieces piece
SET piece.title = 'Alla Marcia', piece.title_en = 'Alla Marcia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2062 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Alpine Suite

UPDATE pieces piece
SET piece.title = 'Alpine Suite', piece.title_en = 'Alpine Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1669 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Arrival at Zermatt', part.name_en = 'Alpine Suite for Recorder Trio: I. Arrival at Zermatt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1669 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b428a322-66dc-4de0-8c06-8a44682a8ba7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b428a322-66dc-4de0-8c06-8a44682a8ba7', 1, 'I', 'Arrival at Zermatt', 'Alpine Suite for Recorder Trio: I. Arrival at Zermatt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1669 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b428a322-66dc-4de0-8c06-8a44682a8ba7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Swiss Clock (Romance)', part.name_en = 'Alpine Suite for Recorder Trio: II. Swiss Clock (Romance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1669 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5833aeeb-71c3-49f3-a10e-b3b1d90959a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5833aeeb-71c3-49f3-a10e-b3b1d90959a4', 2, 'II', 'Swiss Clock (Romance)', 'Alpine Suite for Recorder Trio: II. Swiss Clock (Romance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1669 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5833aeeb-71c3-49f3-a10e-b3b1d90959a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nursery Slopes', part.name_en = 'Alpine Suite for Recorder Trio: III. Nursery Slopes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1669 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2b8a1916-8f14-4369-8d10-293398319f24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b8a1916-8f14-4369-8d10-293398319f24', 3, 'III', 'Nursery Slopes', 'Alpine Suite for Recorder Trio: III. Nursery Slopes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1669 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b8a1916-8f14-4369-8d10-293398319f24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Alpine Scene', part.name_en = 'Alpine Suite for Recorder Trio: IV. Alpine Scene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1669 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:12c943fe-2386-448c-b99c-ba4f3945340d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12c943fe-2386-448c-b99c-ba4f3945340d', 4, 'IV', 'Alpine Scene', 'Alpine Suite for Recorder Trio: IV. Alpine Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1669 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12c943fe-2386-448c-b99c-ba4f3945340d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Moto Perpetuo: Down the Piste', part.name_en = 'Alpine Suite for Recorder Trio: V. Moto Perpetuo: Down the Piste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1669 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:077166e2-5656-4a11-b9c4-e4a5333d04d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:077166e2-5656-4a11-b9c4-e4a5333d04d5', 5, 'V', 'Moto Perpetuo: Down the Piste', 'Alpine Suite for Recorder Trio: V. Moto Perpetuo: Down the Piste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1669 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:077166e2-5656-4a11-b9c4-e4a5333d04d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Farewell to Zermatt', part.name_en = 'Alpine Suite for Recorder Trio: VI. Farewell to Zermatt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1669 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:41c5ad42-9946-459e-b786-2dbacba839d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c5ad42-9946-459e-b786-2dbacba839d4', 6, 'VI', 'Farewell to Zermatt', 'Alpine Suite for Recorder Trio: VI. Farewell to Zermatt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1669 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c5ad42-9946-459e-b786-2dbacba839d4'
);


-- None 영화음악 <An American in England>

UPDATE pieces piece
SET piece.title = '영화음악 <An American in England>', piece.title_en = 'An American in England',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1772 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Women of Britain - London', part.name_en = 'An American in England: Women of Britain - London',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:068c0516-72ae-49fe-802d-acca40c83333' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:068c0516-72ae-49fe-802d-acca40c83333', 1, NULL, 'Women of Britain - London', 'An American in England: Women of Britain - London', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:068c0516-72ae-49fe-802d-acca40c83333'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Women of Britain - Your First Factory', part.name_en = 'An American in England: Women of Britain - Your First Factory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:36731ba7-6207-40bf-9db8-175cea43cc93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36731ba7-6207-40bf-9db8-175cea43cc93', 2, NULL, 'Women of Britain - Your First Factory', 'An American in England: Women of Britain - Your First Factory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36731ba7-6207-40bf-9db8-175cea43cc93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Women of Britain - Warren. To my dearly beloved Boy', part.name_en = 'An American in England: Women of Britain - Warren. To my dearly beloved Boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:508af7fb-e98a-464e-978d-c4ffbeff3605' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:508af7fb-e98a-464e-978d-c4ffbeff3605', 3, NULL, 'Women of Britain - Warren. To my dearly beloved Boy', 'An American in England: Women of Britain - Warren. To my dearly beloved Boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:508af7fb-e98a-464e-978d-c4ffbeff3605'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Women of Britain - After the Last War', part.name_en = 'An American in England: Women of Britain - After the Last War',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6df8392b-622c-4de0-bc82-64baec85053a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6df8392b-622c-4de0-bc82-64baec85053a', 4, NULL, 'Women of Britain - After the Last War', 'An American in England: Women of Britain - After the Last War', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6df8392b-622c-4de0-bc82-64baec85053a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'London by Clipper', part.name_en = 'An American in England: London by Clipper',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:766dc35a-cf0d-4688-96a9-ec7a25b42bc4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:766dc35a-cf0d-4688-96a9-ec7a25b42bc4', 5, NULL, 'London by Clipper', 'An American in England: London by Clipper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:766dc35a-cf0d-4688-96a9-ec7a25b42bc4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Women of Britain - Within 50 Yards', part.name_en = 'An American in England: Women of Britain - Within 50 Yards',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:82a9704a-f629-4949-84b0-4a9b00360950' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82a9704a-f629-4949-84b0-4a9b00360950', 6, NULL, 'Women of Britain - Within 50 Yards', 'An American in England: Women of Britain - Within 50 Yards', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82a9704a-f629-4949-84b0-4a9b00360950'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Dover to London', part.name_en = 'An American in England: Dover to London',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8afb172b-bbfe-4fc6-8b53-4f1d0a49e069' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8afb172b-bbfe-4fc6-8b53-4f1d0a49e069', 7, NULL, 'Dover to London', 'An American in England: Dover to London', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8afb172b-bbfe-4fc6-8b53-4f1d0a49e069'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Women of Britain - It''s a beautiful August Morning', part.name_en = 'An American in England: Women of Britain - It''s a beautiful August Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8b2f8f57-2d4c-42b5-a5cf-571b9400c5a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b2f8f57-2d4c-42b5-a5cf-571b9400c5a6', 8, NULL, 'Women of Britain - It''s a beautiful August Morning', 'An American in England: Women of Britain - It''s a beautiful August Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b2f8f57-2d4c-42b5-a5cf-571b9400c5a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Women of Britain - You walk down to a part of the City', part.name_en = 'An American in England: Women of Britain - You walk down to a part of the City',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:aa4668fc-83b6-42c7-b850-1100275d8809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa4668fc-83b6-42c7-b850-1100275d8809', 9, NULL, 'Women of Britain - You walk down to a part of the City', 'An American in England: Women of Britain - You walk down to a part of the City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa4668fc-83b6-42c7-b850-1100275d8809'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Women of Britain - You set out for a Training Camp', part.name_en = 'An American in England: Women of Britain - You set out for a Training Camp',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bb7f488f-80ec-4494-b5b7-1a1224b84da2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb7f488f-80ec-4494-b5b7-1a1224b84da2', 10, NULL, 'Women of Britain - You set out for a Training Camp', 'An American in England: Women of Britain - You set out for a Training Camp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb7f488f-80ec-4494-b5b7-1a1224b84da2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ration Island', part.name_en = 'An American in England: Ration Island',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1772 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e2f09c4c-8893-4685-8848-534195d8bb19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2f09c4c-8893-4685-8848-534195d8bb19', 11, NULL, 'Ration Island', 'An American in England: Ration Island', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1772 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2f09c4c-8893-4685-8848-534195d8bb19'
);


-- Op. 56b Antiphon

UPDATE pieces piece
SET piece.title = 'Antiphon', piece.title_en = 'Antiphon, op. 56b',
    piece.type = 'song', piece.opus_number = 'Op. 56b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2353 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None As It Is, Plenty

UPDATE pieces piece
SET piece.title = 'As It Is, Plenty', piece.title_en = 'As It Is, Plenty',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1143 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <At the Mid Hour of Night>

UPDATE pieces piece
SET piece.title = '가곡 <At the Mid Hour of Night>', piece.title_en = 'At the Mid Hour of Night',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2917 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 14 Ballad of Heroes

UPDATE pieces piece
SET piece.title = 'Ballad of Heroes', piece.title_en = 'Ballad of Heroes, op. 14',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3013 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Funeral March', part.name_en = 'Ballad of Heroes, op. 14: I. Funeral March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3013 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9669dd7f-7c97-3f47-8bf7-3e6d9c21d444' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9669dd7f-7c97-3f47-8bf7-3e6d9c21d444', 1, 'I', 'Funeral March', 'Ballad of Heroes, op. 14: I. Funeral March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3013 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9669dd7f-7c97-3f47-8bf7-3e6d9c21d444'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo: Dance of Death', part.name_en = 'Ballad of Heroes, op. 14: II. Scherzo: Dance of Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3013 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8bbaf53a-31bf-3b3b-9a77-0685ab2be755' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bbaf53a-31bf-3b3b-9a77-0685ab2be755', 2, 'II', 'Scherzo: Dance of Death', 'Ballad of Heroes, op. 14: II. Scherzo: Dance of Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3013 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bbaf53a-31bf-3b3b-9a77-0685ab2be755'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Recitative and Choral', part.name_en = 'Ballad of Heroes, op. 14: III. Recitative and Choral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3013 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9f8358b3-71fc-390b-8270-64549a89b992' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f8358b3-71fc-390b-8270-64549a89b992', 3, 'III', 'Recitative and Choral', 'Ballad of Heroes, op. 14: III. Recitative and Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3013 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f8358b3-71fc-390b-8270-64549a89b992'
);


-- None 가곡 <Birthday Song for Erwin>

UPDATE pieces piece
SET piece.title = '가곡 <Birthday Song for Erwin>', piece.title_en = 'Birthday Song for Erwin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2473 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <Cabaret Songs>

UPDATE pieces piece
SET piece.title = '연가곡집 <Cabaret Songs>', piece.title_en = 'Cabaret Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2989 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tell me the truth about love', part.name_en = 'Cabaret Songs: No. 1. Tell me the truth about love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2989 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3fea2795-b03f-4526-bf1f-ecbdf1c7878c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fea2795-b03f-4526-bf1f-ecbdf1c7878c', 1, NULL, 'Tell me the truth about love', 'Cabaret Songs: No. 1. Tell me the truth about love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2989 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fea2795-b03f-4526-bf1f-ecbdf1c7878c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Funeral Blues', part.name_en = 'Cabaret Songs: No. 2. Funeral Blues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2989 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bf0404d2-7203-42e2-a789-9943c9ffa20c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf0404d2-7203-42e2-a789-9943c9ffa20c', 2, NULL, 'Funeral Blues', 'Cabaret Songs: No. 2. Funeral Blues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2989 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf0404d2-7203-42e2-a789-9943c9ffa20c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Johnny', part.name_en = 'Cabaret Songs: No. 3. Johnny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2989 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:004daf00-4319-44c5-9cbc-decd81858e36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:004daf00-4319-44c5-9cbc-decd81858e36', 3, NULL, 'Johnny', 'Cabaret Songs: No. 3. Johnny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2989 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:004daf00-4319-44c5-9cbc-decd81858e36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Calypso', part.name_en = 'Cabaret Songs: No. 4. Calypso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2989 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cc00349e-4361-41f6-94d5-06b274578712' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc00349e-4361-41f6-94d5-06b274578712', 4, NULL, 'Calypso', 'Cabaret Songs: No. 4. Calypso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2989 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc00349e-4361-41f6-94d5-06b274578712'
);


-- Op. 19 Canadian Carnival

UPDATE pieces piece
SET piece.title = 'Canadian Carnival', piece.title_en = 'Canadian Carnival, op. 19',
    piece.type = 'song', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1972 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 62 칸타타 <Cantata academica>

UPDATE pieces piece
SET piece.title = '칸타타 <Cantata academica>', piece.title_en = 'Cantata academica, op. 62',
    piece.type = 'song', piece.opus_number = 'Op. 62',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1563 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 69 칸타타 <Cantata misericordium>

UPDATE pieces piece
SET piece.title = '칸타타 <Cantata misericordium>', piece.title_en = 'Cantata misericordium, op. 69',
    piece.type = 'song', piece.opus_number = 'Op. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2432 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canticle II, op. 51 "Abraham and Isaac"

UPDATE pieces piece
SET piece.title = 'Canticle II, op. 51 "Abraham and Isaac"', piece.title_en = 'Canticle II, op. 51 "Abraham and Isaac"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 867 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canticle III, op. 55 "Still Falls the Rain - the Raids, 1940, Night and Dawn"

UPDATE pieces piece
SET piece.title = 'Canticle III, op. 55 "Still Falls the Rain - the Raids, 1940, Night and Dawn"', piece.title_en = 'Canticle III, op. 55 "Still Falls the Rain - the Raids, 1940, Night and Dawn"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2613 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canticle IV, op. 86 "The Journey of the Magi"

UPDATE pieces piece
SET piece.title = 'Canticle IV, op. 86 "The Journey of the Magi"', piece.title_en = 'Canticle IV, op. 86 "The Journey of the Magi"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2472 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canticle V, op. 89 "The Death of Saint Narcissus"

UPDATE pieces piece
SET piece.title = 'Canticle V, op. 89 "The Death of Saint Narcissus"', piece.title_en = 'Canticle V, op. 89 "The Death of Saint Narcissus"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1862 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 65 첼로 소나타 C장조

UPDATE pieces piece
SET piece.title = '첼로 소나타 C장조', piece.title_en = 'Cello Sonata in C major, op. 65',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2831 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Dialogo', part.name_en = 'Cello Sonata in C major, op. 65: I. Dialogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2831 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bc4d0600-c791-489f-b6b8-44d35413fd6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc4d0600-c791-489f-b6b8-44d35413fd6c', 1, 'I', 'Dialogo', 'Cello Sonata in C major, op. 65: I. Dialogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2831 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc4d0600-c791-489f-b6b8-44d35413fd6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo: pizzicato', part.name_en = 'Cello Sonata in C major, op. 65: II. Scherzo: pizzicato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2831 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f14623d4-f468-411b-8ae4-4f45ee5fad7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f14623d4-f468-411b-8ae4-4f45ee5fad7e', 2, 'II', 'Scherzo: pizzicato', 'Cello Sonata in C major, op. 65: II. Scherzo: pizzicato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2831 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f14623d4-f468-411b-8ae4-4f45ee5fad7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Elegia', part.name_en = 'Cello Sonata in C major, op. 65: III. Elegia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2831 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:08e7ab1f-2716-4162-a8db-548c174b2e53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08e7ab1f-2716-4162-a8db-548c174b2e53', 3, 'III', 'Elegia', 'Cello Sonata in C major, op. 65: III. Elegia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2831 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08e7ab1f-2716-4162-a8db-548c174b2e53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Marcia', part.name_en = 'Cello Sonata in C major, op. 65: IV. Marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2831 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9ff49ddf-b9fa-4321-8ec4-968d6cab3571' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ff49ddf-b9fa-4321-8ec4-968d6cab3571', 4, 'IV', 'Marcia', 'Cello Sonata in C major, op. 65: IV. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2831 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ff49ddf-b9fa-4321-8ec4-968d6cab3571'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Moto perpetuo', part.name_en = 'Cello Sonata in C major, op. 65: V. Moto perpetuo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2831 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9201818d-fe74-46ff-886c-8b090f4640fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9201818d-fe74-46ff-886c-8b090f4640fb', 5, 'V', 'Moto perpetuo', 'Cello Sonata in C major, op. 65: V. Moto perpetuo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2831 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9201818d-fe74-46ff-886c-8b090f4640fb'
);


-- Op. 72 첼로 모음곡 1번 Op. 72

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Canto Primo. Sostenuto e largamente', part.name_en = 'Cello Suite no. 1, op. 72: I. Canto Primo. Sostenuto e largamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c3cbed4d-5c8f-3355-9ef7-569eb48a035d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3cbed4d-5c8f-3355-9ef7-569eb48a035d', 1, NULL, 'Canto Primo. Sostenuto e largamente', 'Cello Suite no. 1, op. 72: I. Canto Primo. Sostenuto e largamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3cbed4d-5c8f-3355-9ef7-569eb48a035d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fuga. Andante moderato', part.name_en = 'Cello Suite no. 1, op. 72: 1. Fuga. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0c0533de-678a-319a-a30f-d90f6ebd9ad9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c0533de-678a-319a-a30f-d90f6ebd9ad9', 2, NULL, 'Fuga. Andante moderato', 'Cello Suite no. 1, op. 72: 1. Fuga. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c0533de-678a-319a-a30f-d90f6ebd9ad9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lamento. Lento rubato', part.name_en = 'Cello Suite no. 1, op. 72: 2. Lamento. Lento rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:77de3459-7dfd-308b-8ca0-89f21d43e387' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77de3459-7dfd-308b-8ca0-89f21d43e387', 3, NULL, 'Lamento. Lento rubato', 'Cello Suite no. 1, op. 72: 2. Lamento. Lento rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77de3459-7dfd-308b-8ca0-89f21d43e387'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Canto secondo. Sostenuto', part.name_en = 'Cello Suite no. 1, op. 72: II. Canto secondo. Sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a32b684c-e983-33dc-8c17-fee9d015a1bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a32b684c-e983-33dc-8c17-fee9d015a1bf', 4, NULL, 'Canto secondo. Sostenuto', 'Cello Suite no. 1, op. 72: II. Canto secondo. Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a32b684c-e983-33dc-8c17-fee9d015a1bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Serenata. Allegretto pizzicato', part.name_en = 'Cello Suite no. 1, op. 72: 3. Serenata. Allegretto pizzicato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f1eedae1-85fe-3d99-85b2-c61dac5ae829' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1eedae1-85fe-3d99-85b2-c61dac5ae829', 5, NULL, 'Serenata. Allegretto pizzicato', 'Cello Suite no. 1, op. 72: 3. Serenata. Allegretto pizzicato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1eedae1-85fe-3d99-85b2-c61dac5ae829'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Marcia. Alla marcia moderato', part.name_en = 'Cello Suite no. 1, op. 72: 4. Marcia. Alla marcia moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4216d237-a222-3126-9d30-ce0273d9bca0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4216d237-a222-3126-9d30-ce0273d9bca0', 6, NULL, 'Marcia. Alla marcia moderato', 'Cello Suite no. 1, op. 72: 4. Marcia. Alla marcia moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4216d237-a222-3126-9d30-ce0273d9bca0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Canto terzo. Sostenuto', part.name_en = 'Cello Suite no. 1, op. 72: III. Canto terzo. Sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:391257e8-c174-35ea-8ce7-4b15e21bf508' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:391257e8-c174-35ea-8ce7-4b15e21bf508', 7, NULL, 'Canto terzo. Sostenuto', 'Cello Suite no. 1, op. 72: III. Canto terzo. Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:391257e8-c174-35ea-8ce7-4b15e21bf508'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Bordone. Moderato quasi recitativo', part.name_en = 'Cello Suite no. 1, op. 72: 5. Bordone. Moderato quasi recitativo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bc0ab6fe-8d13-3658-8402-67672b341dbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc0ab6fe-8d13-3658-8402-67672b341dbe', 8, NULL, 'Bordone. Moderato quasi recitativo', 'Cello Suite no. 1, op. 72: 5. Bordone. Moderato quasi recitativo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc0ab6fe-8d13-3658-8402-67672b341dbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Moto perpetuo e canto quarto. Presto', part.name_en = 'Cello Suite no. 1, op. 72: 6. Moto perpetuo e canto quarto. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 359 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d77b5de3-20db-3e8f-ab65-c0858569f105' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d77b5de3-20db-3e8f-ab65-c0858569f105', 9, NULL, 'Moto perpetuo e canto quarto. Presto', 'Cello Suite no. 1, op. 72: 6. Moto perpetuo e canto quarto. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 359 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d77b5de3-20db-3e8f-ab65-c0858569f105'
);


-- Op. 80 첼로 모음곡 2번

UPDATE pieces piece
SET piece.title = '첼로 모음곡 2번', piece.title_en = 'Cello Suite no. 2, op. 80',
    piece.type = 'album', piece.opus_number = 'Op. 80',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2185 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Declamato. Largo', part.name_en = 'Cello Suite no. 2, op. 80: I. Declamato. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2185 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:559ab7ba-47b9-30c3-880b-7a1e92f5f4ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:559ab7ba-47b9-30c3-880b-7a1e92f5f4ce', 1, 'I', 'Declamato. Largo', 'Cello Suite no. 2, op. 80: I. Declamato. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2185 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:559ab7ba-47b9-30c3-880b-7a1e92f5f4ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Fuga. Andante', part.name_en = 'Cello Suite no. 2, op. 80: II. Fuga. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2185 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ea61628b-079e-339f-afd2-6a98dec1b5d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea61628b-079e-339f-afd2-6a98dec1b5d2', 2, 'II', 'Fuga. Andante', 'Cello Suite no. 2, op. 80: II. Fuga. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2185 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea61628b-079e-339f-afd2-6a98dec1b5d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Allegro molto', part.name_en = 'Cello Suite no. 2, op. 80: III. Scherzo. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2185 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4c2602bd-7efa-3161-9a74-053b76326d46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c2602bd-7efa-3161-9a74-053b76326d46', 3, 'III', 'Scherzo. Allegro molto', 'Cello Suite no. 2, op. 80: III. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2185 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c2602bd-7efa-3161-9a74-053b76326d46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante lento', part.name_en = 'Cello Suite no. 2, op. 80: IV. Andante lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2185 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:803dde90-a448-30c1-85e4-cf7e63f7c955' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:803dde90-a448-30c1-85e4-cf7e63f7c955', 4, 'IV', 'Andante lento', 'Cello Suite no. 2, op. 80: IV. Andante lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2185 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:803dde90-a448-30c1-85e4-cf7e63f7c955'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ciaccona. Allegro', part.name_en = 'Cello Suite no. 2, op. 80: V. Ciaccona. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2185 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8c24547f-2e24-36b0-8d23-c7286f4f8c42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c24547f-2e24-36b0-8d23-c7286f4f8c42', 5, 'V', 'Ciaccona. Allegro', 'Cello Suite no. 2, op. 80: V. Ciaccona. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2185 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c24547f-2e24-36b0-8d23-c7286f4f8c42'
);


-- Op. 87 첼로 모음곡 3번

UPDATE pieces piece
SET piece.title = '첼로 모음곡 3번', piece.title_en = 'Cello Suite no. 3, op. 87',
    piece.type = 'album', piece.opus_number = 'Op. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1755 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduzione', part.name_en = 'Cello Suite no. 3, op. 87: I. Introduzione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1c25e9e1-2649-465a-943b-4b9d7d11647c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c25e9e1-2649-465a-943b-4b9d7d11647c', 1, 'I', 'Introduzione', 'Cello Suite no. 3, op. 87: I. Introduzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c25e9e1-2649-465a-943b-4b9d7d11647c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Marcia', part.name_en = 'Cello Suite no. 3, op. 87: II. Marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5659c840-c055-4a08-9d43-a7c3f065f58c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5659c840-c055-4a08-9d43-a7c3f065f58c', 2, 'II', 'Marcia', 'Cello Suite no. 3, op. 87: II. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5659c840-c055-4a08-9d43-a7c3f065f58c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Canto', part.name_en = 'Cello Suite no. 3, op. 87: III. Canto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8ca0fb75-44a9-4425-8248-adc0710173a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ca0fb75-44a9-4425-8248-adc0710173a2', 3, 'III', 'Canto', 'Cello Suite no. 3, op. 87: III. Canto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ca0fb75-44a9-4425-8248-adc0710173a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Barcarola', part.name_en = 'Cello Suite no. 3, op. 87: IV. Barcarola',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9872b850-2e55-4932-aabc-55aa42042c5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9872b850-2e55-4932-aabc-55aa42042c5c', 4, 'IV', 'Barcarola', 'Cello Suite no. 3, op. 87: IV. Barcarola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9872b850-2e55-4932-aabc-55aa42042c5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dialogo', part.name_en = 'Cello Suite no. 3, op. 87: V. Dialogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:48508e9b-81fe-47e7-91d8-a6b59ee23375' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48508e9b-81fe-47e7-91d8-a6b59ee23375', 5, 'V', 'Dialogo', 'Cello Suite no. 3, op. 87: V. Dialogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48508e9b-81fe-47e7-91d8-a6b59ee23375'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Fuga', part.name_en = 'Cello Suite no. 3, op. 87: VI. Fuga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5b951f1d-a90c-4da9-bce2-54bbf1263a1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b951f1d-a90c-4da9-bce2-54bbf1263a1c', 6, 'VI', 'Fuga', 'Cello Suite no. 3, op. 87: VI. Fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b951f1d-a90c-4da9-bce2-54bbf1263a1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Recitativo', part.name_en = 'Cello Suite no. 3, op. 87: VII. Recitativo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3c6867a7-e6e2-4928-b8ca-a0e5ebb0ca85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c6867a7-e6e2-4928-b8ca-a0e5ebb0ca85', 7, 'VII', 'Recitativo', 'Cello Suite no. 3, op. 87: VII. Recitativo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c6867a7-e6e2-4928-b8ca-a0e5ebb0ca85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Moto perpetuo', part.name_en = 'Cello Suite no. 3, op. 87: VIII. Moto perpetuo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:64670a43-9b06-41de-bf7d-c1cd3a5fa97c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64670a43-9b06-41de-bf7d-c1cd3a5fa97c', 8, 'VIII', 'Moto perpetuo', 'Cello Suite no. 3, op. 87: VIII. Moto perpetuo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64670a43-9b06-41de-bf7d-c1cd3a5fa97c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Passacaglia', part.name_en = 'Cello Suite no. 3, op. 87: IX. Passacaglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1755 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:530ef2d7-58be-4352-9983-2efdb941f086' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:530ef2d7-58be-4352-9983-2efdb941f086', 9, 'IX', 'Passacaglia', 'Cello Suite no. 3, op. 87: IX. Passacaglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1755 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:530ef2d7-58be-4352-9983-2efdb941f086'
);


-- Op. 82 Children's Crusade

UPDATE pieces piece
SET piece.title = 'Children''s Crusade', piece.title_en = 'Children''s Crusade, op. 82',
    piece.type = 'song', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2996 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Chorale After an Old French Carol

UPDATE pieces piece
SET piece.title = 'Chorale After an Old French Carol', piece.title_en = 'Chorale After an Old French Carol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2307 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Christ’s Nativity

UPDATE pieces piece
SET piece.title = 'Christ’s Nativity', piece.title_en = 'Christ’s Nativity',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2670 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Christ’s Nativity', part.name_en = 'Christ’s Nativity: I. Christ’s Nativity',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2670 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8aa156f8-c36a-4397-a93c-acb50066f70e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aa156f8-c36a-4397-a93c-acb50066f70e', 1, 'I', 'Christ’s Nativity', 'Christ’s Nativity: I. Christ’s Nativity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2670 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aa156f8-c36a-4397-a93c-acb50066f70e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sweet was the Song', part.name_en = 'Christ’s Nativity: II. Sweet was the Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2670 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c1e66107-f4e2-4bd2-972e-6f60b563d7e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1e66107-f4e2-4bd2-972e-6f60b563d7e4', 2, 'II', 'Sweet was the Song', 'Christ’s Nativity: II. Sweet was the Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2670 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1e66107-f4e2-4bd2-972e-6f60b563d7e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Preparations', part.name_en = 'Christ’s Nativity: III. Preparations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2670 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c856d383-a88a-46f3-ad46-4bcc02d08d0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c856d383-a88a-46f3-ad46-4bcc02d08d0e', 3, 'III', 'Preparations', 'Christ’s Nativity: III. Preparations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2670 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c856d383-a88a-46f3-ad46-4bcc02d08d0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'New Prince, New Pomp', part.name_en = 'Christ’s Nativity: IV. New Prince, New Pomp',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2670 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:542a8901-4d56-4b97-9e48-6c9f777da73f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:542a8901-4d56-4b97-9e48-6c9f777da73f', 4, 'IV', 'New Prince, New Pomp', 'Christ’s Nativity: IV. New Prince, New Pomp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2670 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:542a8901-4d56-4b97-9e48-6c9f777da73f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Carol of King Cnut', part.name_en = 'Christ’s Nativity: V. Carol of King Cnut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2670 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fcfe46dc-fc4a-4dce-90c7-f8a40e15dbb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcfe46dc-fc4a-4dce-90c7-f8a40e15dbb7', 5, 'V', 'Carol of King Cnut', 'Christ’s Nativity: V. Carol of King Cnut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2670 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcfe46dc-fc4a-4dce-90c7-f8a40e15dbb7'
);


-- None 가곡 <Cradle Song for Eleanor>

UPDATE pieces piece
SET piece.title = '가곡 <Cradle Song for Eleanor>', piece.title_en = 'Cradle Song for Eleanor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1457 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 71 Curlew River

UPDATE pieces piece
SET piece.title = 'Curlew River', piece.title_en = 'Curlew River, op. 71',
    piece.type = 'song', piece.opus_number = 'Op. 71',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1105 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Dawtie’s Devotion>

UPDATE pieces piece
SET piece.title = '가곡 <Dawtie’s Devotion>', piece.title_en = 'Dawtie’s Devotion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2476 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Death in Venice>

UPDATE pieces piece
SET piece.title = '오페라 <Death in Venice>', piece.title_en = 'Death in Venice',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2786 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Death in Venice: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2786 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a529300a-1621-4e2d-80f5-c30a86c44eaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a529300a-1621-4e2d-80f5-c30a86c44eaa', 1, NULL, 'Act I', 'Death in Venice: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2786 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a529300a-1621-4e2d-80f5-c30a86c44eaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Death in Venice: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2786 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fc769793-f029-48e1-a0b5-ad24c4c4a57c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc769793-f029-48e1-a0b5-ad24c4c4a57c', 2, NULL, 'Act II', 'Death in Venice: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2786 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc769793-f029-48e1-a0b5-ad24c4c4a57c'
);


-- None Deus in adjutorium meum

UPDATE pieces piece
SET piece.title = 'Deus in adjutorium meum', piece.title_en = 'Deus in adjutorium meum',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1513 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 21 Diversions for Piano Left Hand and Orchestra Op. 21

UPDATE pieces piece
SET piece.title = 'Diversions for Piano Left Hand and Orchestra Op. 21', piece.title_en = 'Diversions for Piano Left Hand and Orchestra, op. 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '21',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1468 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Theme', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Theme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:464e3c37-dc2b-4378-8dc8-0d138825db33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:464e3c37-dc2b-4378-8dc8-0d138825db33', 1, NULL, 'Theme', 'Diversions for Piano Left Hand and Orchestra, op. 21: Theme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:464e3c37-dc2b-4378-8dc8-0d138825db33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation I. Recitative', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation I. Recitative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:dc7c7724-ea6d-45ea-88af-d8b42478acfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc7c7724-ea6d-45ea-88af-d8b42478acfc', 2, NULL, 'Variation I. Recitative', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation I. Recitative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc7c7724-ea6d-45ea-88af-d8b42478acfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation II. Romance', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation II. Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8565c751-8b41-4a1f-9514-4fd710ce9b36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8565c751-8b41-4a1f-9514-4fd710ce9b36', 3, NULL, 'Variation II. Romance', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation II. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8565c751-8b41-4a1f-9514-4fd710ce9b36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation III. March', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation III. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c7be5f4c-e710-4f84-9fdf-5b1f99c3a65b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7be5f4c-e710-4f84-9fdf-5b1f99c3a65b', 4, NULL, 'Variation III. March', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation III. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7be5f4c-e710-4f84-9fdf-5b1f99c3a65b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation IV. Arabesque', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation IV. Arabesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:10973f9e-acf0-46ce-8c17-0d073755e699' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10973f9e-acf0-46ce-8c17-0d073755e699', 5, NULL, 'Variation IV. Arabesque', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation IV. Arabesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10973f9e-acf0-46ce-8c17-0d073755e699'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation V. Chant', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation V. Chant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3e227cb2-ff4b-47b8-a1fa-ab16b00b1d02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e227cb2-ff4b-47b8-a1fa-ab16b00b1d02', 6, NULL, 'Variation V. Chant', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation V. Chant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e227cb2-ff4b-47b8-a1fa-ab16b00b1d02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation VI. Nocturne', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation VI. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:369267db-72f4-4807-b3c2-44938ff63817' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:369267db-72f4-4807-b3c2-44938ff63817', 7, NULL, 'Variation VI. Nocturne', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation VI. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:369267db-72f4-4807-b3c2-44938ff63817'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation VII. Badinerie', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation VII. Badinerie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:17b30ed0-3b58-4bc9-a97b-f60ce390e967' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17b30ed0-3b58-4bc9-a97b-f60ce390e967', 8, NULL, 'Variation VII. Badinerie', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation VII. Badinerie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17b30ed0-3b58-4bc9-a97b-f60ce390e967'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variation VIII. Burlesque', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation VIII. Burlesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b325b6c5-2b8e-4fcc-a131-d0c7afab3e29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b325b6c5-2b8e-4fcc-a131-d0c7afab3e29', 9, NULL, 'Variation VIII. Burlesque', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation VIII. Burlesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b325b6c5-2b8e-4fcc-a131-d0c7afab3e29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Variation IXa. Toccata I', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation IXa. Toccata I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7a5951a7-07f1-4272-b03a-a372606dd5bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a5951a7-07f1-4272-b03a-a372606dd5bb', 10, NULL, 'Variation IXa. Toccata I', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation IXa. Toccata I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a5951a7-07f1-4272-b03a-a372606dd5bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Variation IXb. Toccata II', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation IXb. Toccata II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:428adeaf-f5b7-4970-88fb-5282b4c533bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:428adeaf-f5b7-4970-88fb-5282b4c533bf', 11, NULL, 'Variation IXb. Toccata II', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation IXb. Toccata II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:428adeaf-f5b7-4970-88fb-5282b4c533bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Variation X. Adagio', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation X. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:989d612e-335b-4fdb-86c3-9b4f5341e9a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:989d612e-335b-4fdb-86c3-9b4f5341e9a2', 12, NULL, 'Variation X. Adagio', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation X. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:989d612e-335b-4fdb-86c3-9b4f5341e9a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Variation XI. Tarantella', part.name_en = 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation XI. Tarantella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1468 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4099fbdc-3349-42fb-aa24-e7c2933e8496' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4099fbdc-3349-42fb-aa24-e7c2933e8496', 13, NULL, 'Variation XI. Tarantella', 'Diversions for Piano Left Hand and Orchestra, op. 21: Variation XI. Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1468 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4099fbdc-3349-42fb-aa24-e7c2933e8496'
);


-- None Elegy for Strings

UPDATE pieces piece
SET piece.title = 'Elegy for Strings', piece.title_en = 'Elegy for Strings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2858 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Elegy for viola solo

UPDATE pieces piece
SET piece.title = 'Elegy for viola solo', piece.title_en = 'Elegy for viola solo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2516 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Fancie>

UPDATE pieces piece
SET piece.title = '가곡 <Fancie>', piece.title_en = 'Fancie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2680 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare "The Eagle has two Heads"

UPDATE pieces piece
SET piece.title = 'Fanfare "The Eagle has two Heads"', piece.title_en = 'Fanfare "The Eagle has two Heads"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 996 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare for St. Edmondsbury

UPDATE pieces piece
SET piece.title = 'Fanfare for St. Edmondsbury', piece.title_en = 'Fanfare for St. Edmondsbury',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1059 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fanfare for St. Edmundsbury

UPDATE pieces piece
SET piece.title = 'Fanfare for St. Edmundsbury', piece.title_en = 'Fanfare for St. Edmundsbury',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2284 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 32 Festival Te Deum

UPDATE pieces piece
SET piece.title = 'Festival Te Deum', piece.title_en = 'Festival Te Deum, op. 32',
    piece.type = 'song', piece.opus_number = 'Op. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1306 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Fish in the Unruffled Lakes>

UPDATE pieces piece
SET piece.title = '가곡 <Fish in the Unruffled Lakes>', piece.title_en = 'Fish in the Unruffled Lakes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1630 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 47 Five Flower Songs Op. 47

UPDATE pieces piece
SET piece.title = 'Five Flower Songs Op. 47', piece.title_en = 'Five Flower Songs, op. 47',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '47',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 818 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'To Daffodils', part.name_en = 'Five Flower Songs, op. 47: No. 1. To Daffodils',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 818 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0c8a86af-90eb-4e12-8a08-b6c2b1deb8d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c8a86af-90eb-4e12-8a08-b6c2b1deb8d8', 1, NULL, 'To Daffodils', 'Five Flower Songs, op. 47: No. 1. To Daffodils', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 818 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c8a86af-90eb-4e12-8a08-b6c2b1deb8d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Succession of the Four Sweet Months', part.name_en = 'Five Flower Songs, op. 47: No. 2. The Succession of the Four Sweet Months',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 818 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:191a0b68-8e14-4f65-bb8a-9135c4b028ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:191a0b68-8e14-4f65-bb8a-9135c4b028ef', 2, NULL, 'The Succession of the Four Sweet Months', 'Five Flower Songs, op. 47: No. 2. The Succession of the Four Sweet Months', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 818 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:191a0b68-8e14-4f65-bb8a-9135c4b028ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Marsh Flowers', part.name_en = 'Five Flower Songs, op. 47: No. 3. Marsh Flowers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 818 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c42499cd-71ff-4148-afe8-e19d302fbfb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c42499cd-71ff-4148-afe8-e19d302fbfb6', 3, NULL, 'Marsh Flowers', 'Five Flower Songs, op. 47: No. 3. Marsh Flowers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 818 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c42499cd-71ff-4148-afe8-e19d302fbfb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Evening Primrose', part.name_en = 'Five Flower Songs, op. 47: No. 4. The Evening Primrose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 818 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:67630398-3904-4f1f-910b-7af0b7a51886' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67630398-3904-4f1f-910b-7af0b7a51886', 4, NULL, 'The Evening Primrose', 'Five Flower Songs, op. 47: No. 4. The Evening Primrose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 818 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67630398-3904-4f1f-910b-7af0b7a51886'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ballad of Green Broom', part.name_en = 'Five Flower Songs, op. 47: No. 5. Ballad of Green Broom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 818 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:221dc951-27d7-440c-b21f-32c9abaec3ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:221dc951-27d7-440c-b21f-32c9abaec3ec', 5, NULL, 'Ballad of Green Broom', 'Five Flower Songs, op. 47: No. 5. Ballad of Green Broom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 818 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:221dc951-27d7-440c-b21f-32c9abaec3ec'
);


-- None Five Waltzes

UPDATE pieces piece
SET piece.title = 'Five Waltzes', piece.title_en = 'Five Waltzes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2766 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rather fast and nervous', part.name_en = 'Five Waltzes: No. 1. Rather fast and nervous',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2766 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d9dd9aaa-b0af-4a8c-9694-a0507c09ed42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9dd9aaa-b0af-4a8c-9694-a0507c09ed42', 1, NULL, 'Rather fast and nervous', 'Five Waltzes: No. 1. Rather fast and nervous', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2766 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9dd9aaa-b0af-4a8c-9694-a0507c09ed42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Quick, with wit', part.name_en = 'Five Waltzes: No. 2. Quick, with wit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2766 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9b0d9ac8-1257-4b11-8b9c-b116d52cf22a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b0d9ac8-1257-4b11-8b9c-b116d52cf22a', 2, NULL, 'Quick, with wit', 'Five Waltzes: No. 2. Quick, with wit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2766 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b0d9ac8-1257-4b11-8b9c-b116d52cf22a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dramatic', part.name_en = 'Five Waltzes: No. 3. Dramatic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2766 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cc007377-759a-4793-b9a3-b05da7bab69e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc007377-759a-4793-b9a3-b05da7bab69e', 3, NULL, 'Dramatic', 'Five Waltzes: No. 3. Dramatic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2766 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc007377-759a-4793-b9a3-b05da7bab69e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rhythmic: not fast', part.name_en = 'Five Waltzes: No. 4. Rhythmic: not fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2766 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0c1747ad-3f5c-44c4-bc0d-f8c83b7b5368' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c1747ad-3f5c-44c4-bc0d-f8c83b7b5368', 4, NULL, 'Rhythmic: not fast', 'Five Waltzes: No. 4. Rhythmic: not fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2766 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c1747ad-3f5c-44c4-bc0d-f8c83b7b5368'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variations: Quiet and simple; Flowing, slow and sad', part.name_en = 'Five Waltzes: No. 5. Variations: Quiet and simple; Flowing, slow and sad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2766 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b169ef79-d27a-4faa-ac23-abba44192373' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b169ef79-d27a-4faa-ac23-abba44192373', 5, NULL, 'Variations: Quiet and simple; Flowing, slow and sad', 'Five Waltzes: No. 5. Variations: Quiet and simple; Flowing, slow and sad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2766 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b169ef79-d27a-4faa-ac23-abba44192373'
);


-- Op. 7 Friday Afternoons Op. 7

UPDATE pieces piece
SET piece.title = 'Friday Afternoons Op. 7', piece.title_en = 'Friday Afternoons, op. 7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '7',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2666 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Begone, Dull Care!', part.name_en = 'Friday Afternoons, op. 7: No. 1. Begone, Dull Care!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:69485d50-58aa-4c55-82e4-522ceba8ceef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69485d50-58aa-4c55-82e4-522ceba8ceef', 1, NULL, 'Begone, Dull Care!', 'Friday Afternoons, op. 7: No. 1. Begone, Dull Care!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69485d50-58aa-4c55-82e4-522ceba8ceef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A Tragic Story', part.name_en = 'Friday Afternoons, op. 7: No. 2. A Tragic Story',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:873d0c00-8679-407e-9413-9f0f976cb24f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:873d0c00-8679-407e-9413-9f0f976cb24f', 2, NULL, 'A Tragic Story', 'Friday Afternoons, op. 7: No. 2. A Tragic Story', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:873d0c00-8679-407e-9413-9f0f976cb24f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Cuckoo!', part.name_en = 'Friday Afternoons, op. 7: No. 3. Cuckoo!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:eb9c9aa2-eef9-4e04-9abd-0ae2e6777d2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb9c9aa2-eef9-4e04-9abd-0ae2e6777d2c', 3, NULL, 'Cuckoo!', 'Friday Afternoons, op. 7: No. 3. Cuckoo!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb9c9aa2-eef9-4e04-9abd-0ae2e6777d2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '“Ee‐oh!”', part.name_en = 'Friday Afternoons, op. 7: No. 4. “Ee‐oh!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0e427bb5-dc12-4f1a-a0ed-9e7a1e23f3f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e427bb5-dc12-4f1a-a0ed-9e7a1e23f3f6', 4, NULL, '“Ee‐oh!”', 'Friday Afternoons, op. 7: No. 4. “Ee‐oh!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e427bb5-dc12-4f1a-a0ed-9e7a1e23f3f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'A New Year Carol', part.name_en = 'Friday Afternoons, op. 7: No. 5. A New Year Carol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8d5c5000-6301-44a6-87bf-0b9e73be99da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d5c5000-6301-44a6-87bf-0b9e73be99da', 5, NULL, 'A New Year Carol', 'Friday Afternoons, op. 7: No. 5. A New Year Carol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d5c5000-6301-44a6-87bf-0b9e73be99da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'I Mun Be Married on Sunday', part.name_en = 'Friday Afternoons, op. 7: No. 6. I Mun Be Married on Sunday',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:45d7e4f0-f04f-43f8-aad7-6778b07f7528' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45d7e4f0-f04f-43f8-aad7-6778b07f7528', 6, NULL, 'I Mun Be Married on Sunday', 'Friday Afternoons, op. 7: No. 6. I Mun Be Married on Sunday', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45d7e4f0-f04f-43f8-aad7-6778b07f7528'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'There Was a Man of Newington', part.name_en = 'Friday Afternoons, op. 7: No. 7. There Was a Man of Newington',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ea622855-6729-46a5-813e-8a1263295f0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea622855-6729-46a5-813e-8a1263295f0b', 7, NULL, 'There Was a Man of Newington', 'Friday Afternoons, op. 7: No. 7. There Was a Man of Newington', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea622855-6729-46a5-813e-8a1263295f0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Fishing song', part.name_en = 'Friday Afternoons, op. 7: No. 8. Fishing song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f808691b-2297-4753-ba78-3923e3225520' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f808691b-2297-4753-ba78-3923e3225520', 8, NULL, 'Fishing song', 'Friday Afternoons, op. 7: No. 8. Fishing song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f808691b-2297-4753-ba78-3923e3225520'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'The Useful Plough', part.name_en = 'Friday Afternoons, op. 7: No. 9. The Useful Plough',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5dbd1d2f-0406-4922-b766-e826e84c1a8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dbd1d2f-0406-4922-b766-e826e84c1a8e', 9, NULL, 'The Useful Plough', 'Friday Afternoons, op. 7: No. 9. The Useful Plough', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dbd1d2f-0406-4922-b766-e826e84c1a8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Jazz‐Man', part.name_en = 'Friday Afternoons, op. 7: No. 10. Jazz‐Man',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d1c49124-b14e-4fad-8e0d-5e4a5a68dc33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c49124-b14e-4fad-8e0d-5e4a5a68dc33', 10, NULL, 'Jazz‐Man', 'Friday Afternoons, op. 7: No. 10. Jazz‐Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c49124-b14e-4fad-8e0d-5e4a5a68dc33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'There Was a Monkey', part.name_en = 'Friday Afternoons, op. 7: No. 11. There Was a Monkey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bfdaa415-c8b1-44c6-b249-0bf0ef164e26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfdaa415-c8b1-44c6-b249-0bf0ef164e26', 11, NULL, 'There Was a Monkey', 'Friday Afternoons, op. 7: No. 11. There Was a Monkey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfdaa415-c8b1-44c6-b249-0bf0ef164e26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Old Abram Brown', part.name_en = 'Friday Afternoons, op. 7: No. 12. Old Abram Brown',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2666 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:02938444-7f7d-442d-a825-51732e96385a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02938444-7f7d-442d-a825-51732e96385a', 12, NULL, 'Old Abram Brown', 'Friday Afternoons, op. 7: No. 12. Old Abram Brown', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2666 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02938444-7f7d-442d-a825-51732e96385a'
);


-- Op. 73 Gemini Variations, Twelve Variations and Fugue on an Epigram of Zoltàn Kodaly Op. 73

UPDATE pieces piece
SET piece.title = 'Gemini Variations, Twelve Variations and Fugue on an Epigram of Zoltàn Kodaly Op. 73', piece.title_en = 'Gemini Variations, Twelve Variations and Fugue on an Epigram of Zoltàn Kodaly, op. 73',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '73',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2343 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Theme - Maestoso', part.name_en = 'Gemini Variations, op. 73: Theme - Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:25284d0c-70cd-4f82-8910-f4c99eee65bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25284d0c-70cd-4f82-8910-f4c99eee65bd', 1, NULL, 'Theme - Maestoso', 'Gemini Variations, op. 73: Theme - Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25284d0c-70cd-4f82-8910-f4c99eee65bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation I - Prestissimo scherzando', part.name_en = 'Gemini Variations, op. 73: Variation I - Prestissimo scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0cc74334-2a27-42b3-accb-7b4cf3cfe335' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cc74334-2a27-42b3-accb-7b4cf3cfe335', 2, NULL, 'Variation I - Prestissimo scherzando', 'Gemini Variations, op. 73: Variation I - Prestissimo scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cc74334-2a27-42b3-accb-7b4cf3cfe335'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation II - Moderato', part.name_en = 'Gemini Variations, op. 73: Variation II - Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:73c15e02-c8e8-46e0-a436-ae4c337dbbf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73c15e02-c8e8-46e0-a436-ae4c337dbbf8', 3, NULL, 'Variation II - Moderato', 'Gemini Variations, op. 73: Variation II - Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73c15e02-c8e8-46e0-a436-ae4c337dbbf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation III - Allegro con brio', part.name_en = 'Gemini Variations, op. 73: Variation III - Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e357a48e-b0b1-4e26-87fb-2d362329ceb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e357a48e-b0b1-4e26-87fb-2d362329ceb4', 4, NULL, 'Variation III - Allegro con brio', 'Gemini Variations, op. 73: Variation III - Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e357a48e-b0b1-4e26-87fb-2d362329ceb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation IV - Grazioso', part.name_en = 'Gemini Variations, op. 73: Variation IV - Grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:24cc3720-d778-4afa-b539-5214698e3827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24cc3720-d778-4afa-b539-5214698e3827', 5, NULL, 'Variation IV - Grazioso', 'Gemini Variations, op. 73: Variation IV - Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24cc3720-d778-4afa-b539-5214698e3827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation V - Canone - Vivace', part.name_en = 'Gemini Variations, op. 73: Variation V - Canone - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0ac06f7b-f4b6-421a-8e2e-e316cd6d34f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ac06f7b-f4b6-421a-8e2e-e316cd6d34f8', 6, NULL, 'Variation V - Canone - Vivace', 'Gemini Variations, op. 73: Variation V - Canone - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ac06f7b-f4b6-421a-8e2e-e316cd6d34f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation VI - Specchio I - Lento tranquillo', part.name_en = 'Gemini Variations, op. 73: Variation VI - Specchio I - Lento tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ed486280-df55-431e-a79b-c1dd2ded11cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed486280-df55-431e-a79b-c1dd2ded11cd', 7, NULL, 'Variation VI - Specchio I - Lento tranquillo', 'Gemini Variations, op. 73: Variation VI - Specchio I - Lento tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed486280-df55-431e-a79b-c1dd2ded11cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation VII - Cadenza', part.name_en = 'Gemini Variations, op. 73: Variation VII - Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fea21667-603a-4063-b7a4-dd9274d54e36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fea21667-603a-4063-b7a4-dd9274d54e36', 8, NULL, 'Variation VII - Cadenza', 'Gemini Variations, op. 73: Variation VII - Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fea21667-603a-4063-b7a4-dd9274d54e36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variation VIII - Appassionato', part.name_en = 'Gemini Variations, op. 73: Variation VIII - Appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8f05658c-ea4b-478e-80b6-52f4cce679d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f05658c-ea4b-478e-80b6-52f4cce679d7', 9, NULL, 'Variation VIII - Appassionato', 'Gemini Variations, op. 73: Variation VIII - Appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f05658c-ea4b-478e-80b6-52f4cce679d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Variation IX - Fanfara - Allegro', part.name_en = 'Gemini Variations, op. 73: Variation IX - Fanfara - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4cd9c593-15c0-4a1d-9597-c685756237dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cd9c593-15c0-4a1d-9597-c685756237dd', 10, NULL, 'Variation IX - Fanfara - Allegro', 'Gemini Variations, op. 73: Variation IX - Fanfara - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cd9c593-15c0-4a1d-9597-c685756237dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Variation X - Marcia - Lo stesso tempo (Allegro)', part.name_en = 'Gemini Variations, op. 73: Variation X - Marcia - Lo stesso tempo (Allegro)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d6b30072-0852-4e39-be5d-bf70e677dca5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6b30072-0852-4e39-be5d-bf70e677dca5', 11, NULL, 'Variation X - Marcia - Lo stesso tempo (Allegro)', 'Gemini Variations, op. 73: Variation X - Marcia - Lo stesso tempo (Allegro)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6b30072-0852-4e39-be5d-bf70e677dca5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Variation XI - Specchio II - Misterioso', part.name_en = 'Gemini Variations, op. 73: Variation XI - Specchio II - Misterioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d557f944-88e6-4a11-bd87-7256b2aeec93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d557f944-88e6-4a11-bd87-7256b2aeec93', 12, NULL, 'Variation XI - Specchio II - Misterioso', 'Gemini Variations, op. 73: Variation XI - Specchio II - Misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d557f944-88e6-4a11-bd87-7256b2aeec93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Variation XII - Romanza - Andante rubato', part.name_en = 'Gemini Variations, op. 73: Variation XII - Romanza - Andante rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:dbdbc22e-c14c-4235-af59-c31d2eccb3b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbdbc22e-c14c-4235-af59-c31d2eccb3b2', 13, NULL, 'Variation XII - Romanza - Andante rubato', 'Gemini Variations, op. 73: Variation XII - Romanza - Andante rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbdbc22e-c14c-4235-af59-c31d2eccb3b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Fugue - Molto moderato', part.name_en = 'Gemini Variations, op. 73: Fugue - Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2343 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:62c1cf3f-1dd7-44b2-8140-e643700ba0f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62c1cf3f-1dd7-44b2-8140-e643700ba0f2', 14, NULL, 'Fugue - Molto moderato', 'Gemini Variations, op. 73: Fugue - Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2343 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62c1cf3f-1dd7-44b2-8140-e643700ba0f2'
);


-- None 오페라 <Gloriana>

UPDATE pieces piece
SET piece.title = '오페라 <Gloriana>', piece.title_en = 'Gloriana',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2914 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Gloriana: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2914 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8093c92f-d024-4aa6-823a-aa3fdd4e3828' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8093c92f-d024-4aa6-823a-aa3fdd4e3828', 1, NULL, 'Act I', 'Gloriana: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2914 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8093c92f-d024-4aa6-823a-aa3fdd4e3828'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Gloriana: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2914 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6876a486-92ec-408d-81c3-1b443f59e9c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6876a486-92ec-408d-81c3-1b443f59e9c0', 2, NULL, 'Act II', 'Gloriana: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2914 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6876a486-92ec-408d-81c3-1b443f59e9c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Gloriana: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2914 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:39ac673a-e734-431e-8613-8dbf20adb4eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39ac673a-e734-431e-8613-8dbf20adb4eb', 3, NULL, 'Act III', 'Gloriana: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2914 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39ac673a-e734-431e-8613-8dbf20adb4eb'
);


-- Op. 5 Holiday Diary

UPDATE pieces piece
SET piece.title = 'Holiday Diary', piece.title_en = 'Holiday Diary, op. 5',
    piece.type = 'album', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2129 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Early Morning Bath', part.name_en = 'Holiday Diary, op. 5: I. Early Morning Bath',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2129 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:73ab9fbf-fa97-48b4-89f3-e3a45dc72027' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73ab9fbf-fa97-48b4-89f3-e3a45dc72027', 1, 'I', 'Early Morning Bath', 'Holiday Diary, op. 5: I. Early Morning Bath', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2129 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73ab9fbf-fa97-48b4-89f3-e3a45dc72027'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sailing', part.name_en = 'Holiday Diary, op. 5: II. Sailing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2129 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:dae7d871-0659-446c-b853-9b826dfe6e64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dae7d871-0659-446c-b853-9b826dfe6e64', 2, 'II', 'Sailing', 'Holiday Diary, op. 5: II. Sailing', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2129 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dae7d871-0659-446c-b853-9b826dfe6e64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fun-Fair', part.name_en = 'Holiday Diary, op. 5: III. Fun-Fair',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2129 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:734fa814-edfc-43a2-965b-1f3b63a06131' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:734fa814-edfc-43a2-965b-1f3b63a06131', 3, 'III', 'Fun-Fair', 'Holiday Diary, op. 5: III. Fun-Fair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2129 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:734fa814-edfc-43a2-965b-1f3b63a06131'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Night', part.name_en = 'Holiday Diary, op. 5: IV. Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2129 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3d8e8f17-113e-45c3-94ef-3abdc9687ddd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d8e8f17-113e-45c3-94ef-3abdc9687ddd', 4, 'IV', 'Night', 'Holiday Diary, op. 5: IV. Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2129 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d8e8f17-113e-45c3-94ef-3abdc9687ddd'
);


-- Op. 27 Hymn to St. Cecilia

UPDATE pieces piece
SET piece.title = 'Hymn to St. Cecilia', piece.title_en = 'Hymn to St. Cecilia, op. 27',
    piece.type = 'album', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 756 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'In a Garden Shady', part.name_en = 'Hymn to St. Cecilia, op. 27: I. In a Garden Shady',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 756 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:952992e5-7a85-4efe-8ab0-00f41bd4c0ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:952992e5-7a85-4efe-8ab0-00f41bd4c0ac', 1, 'I', 'In a Garden Shady', 'Hymn to St. Cecilia, op. 27: I. In a Garden Shady', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 756 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:952992e5-7a85-4efe-8ab0-00f41bd4c0ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'I Cannot Grow', part.name_en = 'Hymn to St. Cecilia, op. 27: II. I Cannot Grow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 756 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a1a345a2-aee9-4b57-a4cf-c6c2cc76a809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a345a2-aee9-4b57-a4cf-c6c2cc76a809', 2, 'II', 'I Cannot Grow', 'Hymn to St. Cecilia, op. 27: II. I Cannot Grow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 756 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a345a2-aee9-4b57-a4cf-c6c2cc76a809'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'O Ear Whose Creatures Cannot Wish to Fall', part.name_en = 'Hymn to St. Cecilia, op. 27: III. O Ear Whose Creatures Cannot Wish to Fall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 756 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:61a01952-215c-46e2-9985-26bb8a4aaa26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61a01952-215c-46e2-9985-26bb8a4aaa26', 3, 'III', 'O Ear Whose Creatures Cannot Wish to Fall', 'Hymn to St. Cecilia, op. 27: III. O Ear Whose Creatures Cannot Wish to Fall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 756 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61a01952-215c-46e2-9985-26bb8a4aaa26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'O Cry Created as the Bow of Sin', part.name_en = 'Hymn to St. Cecilia, op. 27: IV. O Cry Created as the Bow of Sin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 756 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c2aaca5f-0d58-4143-b82b-c0426b01b669' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2aaca5f-0d58-4143-b82b-c0426b01b669', 4, 'IV', 'O Cry Created as the Bow of Sin', 'Hymn to St. Cecilia, op. 27: IV. O Cry Created as the Bow of Sin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 756 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2aaca5f-0d58-4143-b82b-c0426b01b669'
);


-- Op. 56a 칸타타 <Hymn to St. Peter>

UPDATE pieces piece
SET piece.title = '칸타타 <Hymn to St. Peter>', piece.title_en = 'Hymn to St. Peter, op. 56a',
    piece.type = 'song', piece.opus_number = 'Op. 56a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2829 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <I Lov'd a Lass>

UPDATE pieces piece
SET piece.title = '가곡 <I Lov''d a Lass>', piece.title_en = 'I Lov''d a Lass',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1453 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Will Give My Love an Apple

UPDATE pieces piece
SET piece.title = 'I Will Give My Love an Apple', piece.title_en = 'I Will Give My Love an Apple',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1249 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <If Thou Wilt Ease Thine Heart>

UPDATE pieces piece
SET piece.title = '가곡 <If Thou Wilt Ease Thine Heart>', piece.title_en = 'If Thou Wilt Ease Thine Heart',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1338 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <If it's ever Spring again>

UPDATE pieces piece
SET piece.title = '가곡 <If it''s ever Spring again>', piece.title_en = 'If it''s ever Spring again',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 924 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Irish Reel

UPDATE pieces piece
SET piece.title = 'Irish Reel', piece.title_en = 'Irish Reel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1372 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 부수음악 <Johnson over Jordan>

UPDATE pieces piece
SET piece.title = '부수음악 <Johnson over Jordan>', piece.title_en = 'Johnson over Jordan',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1728 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jubilate Deo in C major

UPDATE pieces piece
SET piece.title = 'Jubilate Deo in C major', piece.title_en = 'Jubilate Deo in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 641 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Jubilate Deo in E-flat

UPDATE pieces piece
SET piece.title = 'Jubilate Deo in E-flat', piece.title_en = 'Jubilate Deo in E-flat',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1130 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 48a Lacrymae

UPDATE pieces piece
SET piece.title = 'Lacrymae', piece.title_en = 'Lacrymae, op. 48a',
    piece.type = 'song', piece.opus_number = 'Op. 48a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2206 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 18 연가곡집 <Les Illuminations> Op. 18

UPDATE pieces piece
SET piece.title = '연가곡집 <Les Illuminations> Op. 18', piece.title_en = 'Les Illuminations, op. 18',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '18',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1421 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fanfare', part.name_en = 'Les Illuminations, op. 18: I. Fanfare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7d0a6ad0-518c-4c2e-8ddb-c2702c976865' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d0a6ad0-518c-4c2e-8ddb-c2702c976865', 1, NULL, 'Fanfare', 'Les Illuminations, op. 18: I. Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d0a6ad0-518c-4c2e-8ddb-c2702c976865'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Villes', part.name_en = 'Les Illuminations, op. 18: II. Villes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:405ac02b-7dc0-411c-a232-ebb6b989c921' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:405ac02b-7dc0-411c-a232-ebb6b989c921', 2, NULL, 'Villes', 'Les Illuminations, op. 18: II. Villes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:405ac02b-7dc0-411c-a232-ebb6b989c921'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'IIIa. Phrase', part.name_en = 'Les Illuminations, op. 18: IIIa. Phrase',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ac335ea4-3f89-4d29-939c-fb5095d56350' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac335ea4-3f89-4d29-939c-fb5095d56350', 3, NULL, 'IIIa. Phrase', 'Les Illuminations, op. 18: IIIa. Phrase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac335ea4-3f89-4d29-939c-fb5095d56350'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IIIb. Antique', part.name_en = 'Les Illuminations, op. 18: IIIb. Antique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f6b0c387-fd6a-431d-b3f9-2580cfb574bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6b0c387-fd6a-431d-b3f9-2580cfb574bd', 4, NULL, 'IIIb. Antique', 'Les Illuminations, op. 18: IIIb. Antique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6b0c387-fd6a-431d-b3f9-2580cfb574bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Royauté', part.name_en = 'Les Illuminations, op. 18: IV. Royauté',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e266c1da-04c2-4906-a43a-d20ed2b1cd5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e266c1da-04c2-4906-a43a-d20ed2b1cd5e', 5, NULL, 'Royauté', 'Les Illuminations, op. 18: IV. Royauté', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e266c1da-04c2-4906-a43a-d20ed2b1cd5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Marine', part.name_en = 'Les Illuminations, op. 18: V. Marine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:57c00082-7746-4a1d-8918-b1c71c96c6cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57c00082-7746-4a1d-8918-b1c71c96c6cd', 6, NULL, 'Marine', 'Les Illuminations, op. 18: V. Marine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c00082-7746-4a1d-8918-b1c71c96c6cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Interlude', part.name_en = 'Les Illuminations, op. 18: VI. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:823a8564-0629-4c66-9c8c-308d0fd55773' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:823a8564-0629-4c66-9c8c-308d0fd55773', 7, NULL, 'Interlude', 'Les Illuminations, op. 18: VI. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:823a8564-0629-4c66-9c8c-308d0fd55773'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Being Beauteous', part.name_en = 'Les Illuminations, op. 18: VII. Being Beauteous',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:389d4cab-aacc-4961-9821-c12471ba13a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389d4cab-aacc-4961-9821-c12471ba13a8', 8, NULL, 'Being Beauteous', 'Les Illuminations, op. 18: VII. Being Beauteous', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389d4cab-aacc-4961-9821-c12471ba13a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Parade', part.name_en = 'Les Illuminations, op. 18: VIII. Parade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7cfcc789-291c-42c4-9fb4-6a9e1e2a9da3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cfcc789-291c-42c4-9fb4-6a9e1e2a9da3', 9, NULL, 'Parade', 'Les Illuminations, op. 18: VIII. Parade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cfcc789-291c-42c4-9fb4-6a9e1e2a9da3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Départ', part.name_en = 'Les Illuminations, op. 18: IX. Départ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1421 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e7ebd2ec-d542-4ccc-8929-f43b9c01adeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7ebd2ec-d542-4ccc-8929-f43b9c01adeb', 10, NULL, 'Départ', 'Les Illuminations, op. 18: IX. Départ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1421 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7ebd2ec-d542-4ccc-8929-f43b9c01adeb'
);


-- None Let the Florid Music Praise!

UPDATE pieces piece
SET piece.title = 'Let the Florid Music Praise!', piece.title_en = 'Let the Florid Music Praise!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1511 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Lift Boy>

UPDATE pieces piece
SET piece.title = '가곡 <Lift Boy>', piece.title_en = 'Lift Boy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1893 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Love From a Stranger>

UPDATE pieces piece
SET piece.title = '영화음악 <Love From a Stranger>', piece.title_en = 'Love From a Stranger',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2184 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 24 Matinées musicales

UPDATE pieces piece
SET piece.title = 'Matinées musicales', piece.title_en = 'Matinées musicales, op. 24',
    piece.type = 'album', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2339 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'March', part.name_en = 'Matinées musicales, op. 24: I. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2339 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:23ccb227-334a-485f-b473-9045c6a9caf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23ccb227-334a-485f-b473-9045c6a9caf4', 1, 'I', 'March', 'Matinées musicales, op. 24: I. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2339 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ccb227-334a-485f-b473-9045c6a9caf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne', part.name_en = 'Matinées musicales, op. 24: II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2339 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:eb5d6bb4-21b8-465c-af03-9a9f9d3736a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb5d6bb4-21b8-465c-af03-9a9f9d3736a7', 2, 'II', 'Nocturne', 'Matinées musicales, op. 24: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2339 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb5d6bb4-21b8-465c-af03-9a9f9d3736a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Waltz', part.name_en = 'Matinées musicales, op. 24: III. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2339 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e9b0bd33-2c5a-4a6d-813b-2bf4a0074310' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9b0bd33-2c5a-4a6d-813b-2bf4a0074310', 3, 'III', 'Waltz', 'Matinées musicales, op. 24: III. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2339 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9b0bd33-2c5a-4a6d-813b-2bf4a0074310'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Pantomime', part.name_en = 'Matinées musicales, op. 24: IV. Pantomime',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2339 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c608912d-b64a-43b1-b6ff-d96fc8dfd1ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c608912d-b64a-43b1-b6ff-d96fc8dfd1ef', 4, 'IV', 'Pantomime', 'Matinées musicales, op. 24: IV. Pantomime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2339 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c608912d-b64a-43b1-b6ff-d96fc8dfd1ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Moto perpetuo (solfeggi e gorgheggi)', part.name_en = 'Matinées musicales, op. 24: V. Moto perpetuo (solfeggi e gorgheggi)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2339 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:139b1c9e-2927-42f5-a240-b5897204305e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:139b1c9e-2927-42f5-a240-b5897204305e', 5, 'V', 'Moto perpetuo (solfeggi e gorgheggi)', 'Matinées musicales, op. 24: V. Moto perpetuo (solfeggi e gorgheggi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2339 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139b1c9e-2927-42f5-a240-b5897204305e'
);


-- None Miniature Suite

UPDATE pieces piece
SET piece.title = 'Miniature Suite', piece.title_en = 'Miniature Suite',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3000 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Novelette', part.name_en = 'Miniature Suite: I. Novelette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3000 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e44f14db-9bab-44c5-bddc-94baa5cc57e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e44f14db-9bab-44c5-bddc-94baa5cc57e9', 1, 'I', 'Novelette', 'Miniature Suite: I. Novelette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3000 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e44f14db-9bab-44c5-bddc-94baa5cc57e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Menuetto', part.name_en = 'Miniature Suite: II. Menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3000 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ca4c570c-c547-4069-878a-1e5a5c93fa15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca4c570c-c547-4069-878a-1e5a5c93fa15', 2, 'II', 'Menuetto', 'Miniature Suite: II. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3000 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca4c570c-c547-4069-878a-1e5a5c93fa15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Romanza', part.name_en = 'Miniature Suite: III. Romanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3000 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0e547377-fa94-4b7e-ad93-01dc7ef29399' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e547377-fa94-4b7e-ad93-01dc7ef29399', 3, 'III', 'Romanza', 'Miniature Suite: III. Romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3000 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e547377-fa94-4b7e-ad93-01dc7ef29399'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Gavotte', part.name_en = 'Miniature Suite: IV. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3000 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6da0ebbc-d2f7-4b32-8b7b-0d207367a3a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6da0ebbc-d2f7-4b32-8b7b-0d207367a3a5', 4, 'IV', 'Gavotte', 'Miniature Suite: IV. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3000 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6da0ebbc-d2f7-4b32-8b7b-0d207367a3a5'
);


-- Op. 63 Missa Brevis in D major

UPDATE pieces piece
SET piece.title = 'Missa Brevis in D major', piece.title_en = 'Missa Brevis in D major, op. 63',
    piece.type = 'album', piece.opus_number = 'Op. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1193 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Missa Brevis in D major, op. 63: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5144ece2-c7ee-3321-acdc-0f9fc8e7df74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5144ece2-c7ee-3321-acdc-0f9fc8e7df74', 1, 'I', 'Kyrie', 'Missa Brevis in D major, op. 63: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5144ece2-c7ee-3321-acdc-0f9fc8e7df74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Missa Brevis in D major, op. 63: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fbdd2176-b262-38be-92ff-267e9e60b161' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbdd2176-b262-38be-92ff-267e9e60b161', 2, 'II', 'Gloria', 'Missa Brevis in D major, op. 63: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbdd2176-b262-38be-92ff-267e9e60b161'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sanctus and Benedictus', part.name_en = 'Missa Brevis in D major, op. 63: III. Sanctus and Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:85b8464e-70ad-3901-a307-d5a9e3b906c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85b8464e-70ad-3901-a307-d5a9e3b906c7', 3, 'III', 'Sanctus and Benedictus', 'Missa Brevis in D major, op. 63: III. Sanctus and Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85b8464e-70ad-3901-a307-d5a9e3b906c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Agnus Dei', part.name_en = 'Missa Brevis in D major, op. 63: IV. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a833a857-4a8a-3e0d-b7c1-d961298dd876' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a833a857-4a8a-3e0d-b7c1-d961298dd876', 4, 'IV', 'Agnus Dei', 'Missa Brevis in D major, op. 63: IV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a833a857-4a8a-3e0d-b7c1-d961298dd876'
);


-- None Movement for Wind Sextet

UPDATE pieces piece
SET piece.title = 'Movement for Wind Sextet', piece.title_en = 'Movement for Wind Sextet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 958 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Night Covers Up the Rigid Land>

UPDATE pieces piece
SET piece.title = '가곡 <Night Covers Up the Rigid Land>', piece.title_en = 'Night Covers Up the Rigid Land',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 933 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <Night Mail>

UPDATE pieces piece
SET piece.title = '영화음악 <Night Mail>', piece.title_en = 'Night Mail',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1848 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Night Piece "Notturno"

UPDATE pieces piece
SET piece.title = 'Night Piece "Notturno"', piece.title_en = 'Night Piece "Notturno"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2226 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 60 녹턴 Op. 60

UPDATE pieces piece
SET piece.title = '녹턴 Op. 60', piece.title_en = 'Nocturne, op. 60',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '60',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1582 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'On a poet''s lips I slept', part.name_en = 'Nocturne, op. 60: I. On a poet''s lips I slept',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1582 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:76400c17-f009-481a-ba1d-33fe65d9c772' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76400c17-f009-481a-ba1d-33fe65d9c772', 1, 'I', 'On a poet''s lips I slept', 'Nocturne, op. 60: I. On a poet''s lips I slept', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1582 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76400c17-f009-481a-ba1d-33fe65d9c772'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Below the thunders of the upper deep', part.name_en = 'Nocturne, op. 60: II. Below the thunders of the upper deep',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1582 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d97f3e15-65a1-4547-9fa5-085780beefee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d97f3e15-65a1-4547-9fa5-085780beefee', 2, 'II', 'Below the thunders of the upper deep', 'Nocturne, op. 60: II. Below the thunders of the upper deep', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1582 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d97f3e15-65a1-4547-9fa5-085780beefee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Encinctured', part.name_en = 'Nocturne, op. 60: III. Encinctured',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1582 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0027a613-a3b4-4033-8e57-6651c21e0c82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0027a613-a3b4-4033-8e57-6651c21e0c82', 3, 'III', 'Encinctured', 'Nocturne, op. 60: III. Encinctured', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1582 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0027a613-a3b4-4033-8e57-6651c21e0c82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Midnight''s bell', part.name_en = 'Nocturne, op. 60: IV. Midnight''s bell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1582 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a06c48bb-ad96-4cbf-9f28-f13a73db126c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a06c48bb-ad96-4cbf-9f28-f13a73db126c', 4, 'IV', 'Midnight''s bell', 'Nocturne, op. 60: IV. Midnight''s bell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1582 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a06c48bb-ad96-4cbf-9f28-f13a73db126c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'But that night', part.name_en = 'Nocturne, op. 60: V. But that night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1582 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1955129e-6708-4dc4-a612-88d13869423b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1955129e-6708-4dc4-a612-88d13869423b', 5, 'V', 'But that night', 'Nocturne, op. 60: V. But that night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1582 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1955129e-6708-4dc4-a612-88d13869423b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'She sleeps', part.name_en = 'Nocturne, op. 60: VI. She sleeps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1582 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e6c0dd87-9bbd-4cb3-b4e5-41c1db65881f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6c0dd87-9bbd-4cb3-b4e5-41c1db65881f', 6, 'VI', 'She sleeps', 'Nocturne, op. 60: VI. She sleeps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1582 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6c0dd87-9bbd-4cb3-b4e5-41c1db65881f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'What is more gentle', part.name_en = 'Nocturne, op. 60: VII. What is more gentle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1582 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a273dc32-fe40-4fc2-8f1f-82f7964d5f08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a273dc32-fe40-4fc2-8f1f-82f7964d5f08', 7, 'VII', 'What is more gentle', 'Nocturne, op. 60: VII. What is more gentle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1582 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a273dc32-fe40-4fc2-8f1f-82f7964d5f08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'When most I wink, then do mine eyes best see', part.name_en = 'Nocturne, op. 60: VIII. When most I wink, then do mine eyes best see',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1582 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:eaca1813-cb3a-4272-93bf-a8d49d5b524b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaca1813-cb3a-4272-93bf-a8d49d5b524b', 8, 'VIII', 'When most I wink, then do mine eyes best see', 'Nocturne, op. 60: VIII. When most I wink, then do mine eyes best see', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1582 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaca1813-cb3a-4272-93bf-a8d49d5b524b'
);


-- None 가곡 <Not Even Summer Yet>

UPDATE pieces piece
SET piece.title = '가곡 <Not Even Summer Yet>', piece.title_en = 'Not Even Summer Yet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 938 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Now the Leaves Are Falling Fast

UPDATE pieces piece
SET piece.title = 'Now the Leaves Are Falling Fast', piece.title_en = 'Now the Leaves Are Falling Fast',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1499 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 59 오페라 <Noye's Fludde>

UPDATE pieces piece
SET piece.title = '오페라 <Noye''s Fludde>', piece.title_en = 'Noye''s Fludde, op. 59',
    piece.type = 'album', piece.opus_number = 'Op. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1805 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lord Jesus, think on me', part.name_en = 'Noye''s Fludde, op. 59: I. Lord Jesus, think on me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:aaa18e59-f89c-34c5-b2e9-4ff20d286b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaa18e59-f89c-34c5-b2e9-4ff20d286b21', 1, 'I', 'Lord Jesus, think on me', 'Noye''s Fludde, op. 59: I. Lord Jesus, think on me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa18e59-f89c-34c5-b2e9-4ff20d286b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'I God, that all this worlde hath wroughte', part.name_en = 'Noye''s Fludde, op. 59: II. I God, that all this worlde hath wroughte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fc10f4bb-efa0-3096-9c6c-a7fa30da59be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc10f4bb-efa0-3096-9c6c-a7fa30da59be', 2, 'II', 'I God, that all this worlde hath wroughte', 'Noye''s Fludde, op. 59: II. I God, that all this worlde hath wroughte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc10f4bb-efa0-3096-9c6c-a7fa30da59be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Have done, you men and wemen all', part.name_en = 'Noye''s Fludde, op. 59: III. Have done, you men and wemen all',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ae647b1b-7fc0-3184-9bd8-cbcfbab9fbf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae647b1b-7fc0-3184-9bd8-cbcfbab9fbf3', 3, 'III', 'Have done, you men and wemen all', 'Noye''s Fludde, op. 59: III. Have done, you men and wemen all', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae647b1b-7fc0-3184-9bd8-cbcfbab9fbf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Now in the name of God I will begyne', part.name_en = 'Noye''s Fludde, op. 59: IV. Now in the name of God I will begyne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:28c7a0d0-d634-35d3-9915-f644f0c6871b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28c7a0d0-d634-35d3-9915-f644f0c6871b', 4, 'IV', 'Now in the name of God I will begyne', 'Noye''s Fludde, op. 59: IV. Now in the name of God I will begyne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28c7a0d0-d634-35d3-9915-f644f0c6871b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Noye, Noye, take thou thy company', part.name_en = 'Noye''s Fludde, op. 59: V. Noye, Noye, take thou thy company',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:790add31-5d93-3362-80a1-5fe88c9e6971' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:790add31-5d93-3362-80a1-5fe88c9e6971', 5, 'V', 'Noye, Noye, take thou thy company', 'Noye''s Fludde, op. 59: V. Noye, Noye, take thou thy company', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:790add31-5d93-3362-80a1-5fe88c9e6971'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Wiffe, come in! why standes thou their?', part.name_en = 'Noye''s Fludde, op. 59: VI. Wiffe, come in! why standes thou their?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:449673fd-5ef3-3a82-83a0-51ed313a6366' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:449673fd-5ef3-3a82-83a0-51ed313a6366', 6, 'VI', 'Wiffe, come in! why standes thou their?', 'Noye''s Fludde, op. 59: VI. Wiffe, come in! why standes thou their?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:449673fd-5ef3-3a82-83a0-51ed313a6366'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Ha! Children, me thinkes my botte removes', part.name_en = 'Noye''s Fludde, op. 59: VII. Ha! Children, me thinkes my botte removes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a8ff80bc-7260-3d6f-99d3-e50018eb5d0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8ff80bc-7260-3d6f-99d3-e50018eb5d0e', 7, 'VII', 'Ha! Children, me thinkes my botte removes', 'Noye''s Fludde, op. 59: VII. Ha! Children, me thinkes my botte removes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8ff80bc-7260-3d6f-99d3-e50018eb5d0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Now forty dayes are fullie gone', part.name_en = 'Noye''s Fludde, op. 59: VIII. Now forty dayes are fullie gone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:dabc3c3a-da6b-395b-9cd6-8351e24f2014' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dabc3c3a-da6b-395b-9cd6-8351e24f2014', 8, 'VIII', 'Now forty dayes are fullie gone', 'Noye''s Fludde, op. 59: VIII. Now forty dayes are fullie gone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dabc3c3a-da6b-395b-9cd6-8351e24f2014'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Noye, take thy wife anone', part.name_en = 'Noye''s Fludde, op. 59: IX. Noye, take thy wife anone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e1393731-2091-3d9c-a5fe-9fc16bceb4bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1393731-2091-3d9c-a5fe-9fc16bceb4bf', 9, 'IX', 'Noye, take thy wife anone', 'Noye''s Fludde, op. 59: IX. Noye, take thy wife anone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1393731-2091-3d9c-a5fe-9fc16bceb4bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Noye, heare I behette thee a heste', part.name_en = 'Noye''s Fludde, op. 59: X. Noye, heare I behette thee a heste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cddadfcc-dd4a-3fff-9387-1a36bdd3f3ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cddadfcc-dd4a-3fff-9387-1a36bdd3f3ad', 10, 'X', 'Noye, heare I behette thee a heste', 'Noye''s Fludde, op. 59: X. Noye, heare I behette thee a heste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cddadfcc-dd4a-3fff-9387-1a36bdd3f3ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'The spacious firmament on high', part.name_en = 'Noye''s Fludde, op. 59: XI. The spacious firmament on high',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1805 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:47339870-6c20-315d-89be-34c2fb2c9dcf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47339870-6c20-315d-89be-34c2fb2c9dcf', 11, 'XI', 'The spacious firmament on high', 'Noye''s Fludde, op. 59: XI. The spacious firmament on high', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1805 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47339870-6c20-315d-89be-34c2fb2c9dcf'
);


-- None Occasional Overture, op. 27 "An American Overture"

UPDATE pieces piece
SET piece.title = 'Occasional Overture, op. 27 "An American Overture"', piece.title_en = 'Occasional Overture, op. 27 "An American Overture"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2406 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 11 연가곡집 <On This Island>

UPDATE pieces piece
SET piece.title = '연가곡집 <On This Island>', piece.title_en = 'On This Island, op. 11',
    piece.type = 'album', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2720 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Let the Florid Music Praise!', part.name_en = 'On This Island: I. Let the Florid Music Praise!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2720 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8effb415-a285-3873-9829-e0d7e79859f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8effb415-a285-3873-9829-e0d7e79859f6', 1, 'I', 'Let the Florid Music Praise!', 'On This Island: I. Let the Florid Music Praise!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2720 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8effb415-a285-3873-9829-e0d7e79859f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Now the Leaves Are Falling Fast', part.name_en = 'On This Island: II. Now the Leaves Are Falling Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2720 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b3229040-84cd-389e-94db-c307f78db869' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3229040-84cd-389e-94db-c307f78db869', 2, 'II', 'Now the Leaves Are Falling Fast', 'On This Island: II. Now the Leaves Are Falling Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2720 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3229040-84cd-389e-94db-c307f78db869'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Seascape', part.name_en = 'On This Island: III. Seascape',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2720 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:86b6856a-432e-3680-8a99-03f066d6fac5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86b6856a-432e-3680-8a99-03f066d6fac5', 3, 'III', 'Seascape', 'On This Island: III. Seascape', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2720 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86b6856a-432e-3680-8a99-03f066d6fac5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Nocturne', part.name_en = 'On This Island: IV. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2720 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:dabbfafb-7ee4-3bc5-9e5a-df0a2ecea970' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dabbfafb-7ee4-3bc5-9e5a-df0a2ecea970', 4, 'IV', 'Nocturne', 'On This Island: IV. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2720 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dabbfafb-7ee4-3bc5-9e5a-df0a2ecea970'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'As It Is, Plenty', part.name_en = 'On This Island: V. As It Is, Plenty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2720 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:79f334a6-e709-3cc4-9d84-719ef86da84f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79f334a6-e709-3cc4-9d84-719ef86da84f', 5, 'V', 'As It Is, Plenty', 'On This Island: V. As It Is, Plenty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2720 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79f334a6-e709-3cc4-9d84-719ef86da84f'
);


-- None 부수음악 <On the Frontier>

UPDATE pieces piece
SET piece.title = '부수음악 <On the Frontier>', piece.title_en = 'On the Frontier',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2202 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fanfare, Act III Scene 2', part.name_en = 'On the Frontier: Fanfare, Act III Scene 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:08ae3ee9-b868-44b9-92c3-1205f7a25934' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08ae3ee9-b868-44b9-92c3-1205f7a25934', 1, NULL, 'Fanfare, Act III Scene 2', 'On the Frontier: Fanfare, Act III Scene 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08ae3ee9-b868-44b9-92c3-1205f7a25934'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prisoner''s Monologue. Industrialists, Bankers, in Comfortable Chairs', part.name_en = 'On the Frontier: Prisoner''s Monologue. Industrialists, Bankers, in Comfortable Chairs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1d7fce76-74a9-41c6-82f3-0204295af94d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d7fce76-74a9-41c6-82f3-0204295af94d', 2, NULL, 'Prisoner''s Monologue. Industrialists, Bankers, in Comfortable Chairs', 'On the Frontier: Prisoner''s Monologue. Industrialists, Bankers, in Comfortable Chairs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d7fce76-74a9-41c6-82f3-0204295af94d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Fanfare, Act I Scene 1', part.name_en = 'On the Frontier: Fanfare, Act I Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:71622677-f55b-44a7-8509-41bd0eff813e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71622677-f55b-44a7-8509-41bd0eff813e', 3, NULL, 'Fanfare, Act I Scene 1', 'On the Frontier: Fanfare, Act I Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71622677-f55b-44a7-8509-41bd0eff813e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ad libitum', part.name_en = 'On the Frontier: Ad libitum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:781d7a99-e036-423f-a47f-d93c0f6752f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:781d7a99-e036-423f-a47f-d93c0f6752f6', 4, NULL, 'Ad libitum', 'On the Frontier: Ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:781d7a99-e036-423f-a47f-d93c0f6752f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Journalists'' Song. We fly to a Cabinet Crisis', part.name_en = 'On the Frontier: Journalists'' Song. We fly to a Cabinet Crisis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:78e76075-e9db-4ea8-b75d-9ba62eb158f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e76075-e9db-4ea8-b75d-9ba62eb158f5', 5, NULL, 'Journalists'' Song. We fly to a Cabinet Crisis', 'On the Frontier: Journalists'' Song. We fly to a Cabinet Crisis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e76075-e9db-4ea8-b75d-9ba62eb158f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Waltz. The papers say there''ll be War before long', part.name_en = 'On the Frontier: Waltz. The papers say there''ll be War before long',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8ec297f9-a47e-49a0-897f-06d72d737ecd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ec297f9-a47e-49a0-897f-06d72d737ecd', 6, NULL, 'Waltz. The papers say there''ll be War before long', 'On the Frontier: Waltz. The papers say there''ll be War before long', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ec297f9-a47e-49a0-897f-06d72d737ecd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'The Clock on the Wall', part.name_en = 'On the Frontier: The Clock on the Wall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:af002dff-941e-4fe7-83dd-2d6edae12a72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af002dff-941e-4fe7-83dd-2d6edae12a72', 7, NULL, 'The Clock on the Wall', 'On the Frontier: The Clock on the Wall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af002dff-941e-4fe7-83dd-2d6edae12a72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Interlude after Act III Scene 2', part.name_en = 'On the Frontier: Interlude after Act III Scene 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:afca674d-c2fa-48d1-9bf1-9660a624eb0d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afca674d-c2fa-48d1-9bf1-9660a624eb0d', 8, NULL, 'Interlude after Act III Scene 2', 'On the Frontier: Interlude after Act III Scene 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afca674d-c2fa-48d1-9bf1-9660a624eb0d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Moderato, after Act I Scene 1', part.name_en = 'On the Frontier: Moderato, after Act I Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bc903542-dd6f-4127-866e-eecf7b82ab31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc903542-dd6f-4127-866e-eecf7b82ab31', 9, NULL, 'Moderato, after Act I Scene 1', 'On the Frontier: Moderato, after Act I Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc903542-dd6f-4127-866e-eecf7b82ab31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'End Chorus. To build a City', part.name_en = 'On the Frontier: End Chorus. To build a City',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c6c0792a-d0fb-4fc4-8e0d-9e91795bb543' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6c0792a-d0fb-4fc4-8e0d-9e91795bb543', 10, NULL, 'End Chorus. To build a City', 'On the Frontier: End Chorus. To build a City', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6c0792a-d0fb-4fc4-8e0d-9e91795bb543'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Chorus. Marching Songs. Brightly the Sun on our Weapons is Gleaming', part.name_en = 'On the Frontier: Chorus. Marching Songs. Brightly the Sun on our Weapons is Gleaming',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c84aa0b4-e851-420c-b505-5c952008883b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c84aa0b4-e851-420c-b505-5c952008883b', 11, NULL, 'Chorus. Marching Songs. Brightly the Sun on our Weapons is Gleaming', 'On the Frontier: Chorus. Marching Songs. Brightly the Sun on our Weapons is Gleaming', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c84aa0b4-e851-420c-b505-5c952008883b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'On the Frontier: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f4d0a0af-d85e-419e-a698-69d024f29068' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4d0a0af-d85e-419e-a698-69d024f29068', 12, NULL, 'Overture', 'On the Frontier: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4d0a0af-d85e-419e-a698-69d024f29068'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Chorus. Ostnian National Anthem', part.name_en = 'On the Frontier: Chorus. Ostnian National Anthem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2202 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f7c07083-4b0e-4f63-9f4c-100a71869eea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7c07083-4b0e-4f63-9f4c-100a71869eea', 13, NULL, 'Chorus. Ostnian National Anthem', 'On the Frontier: Chorus. Ostnian National Anthem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2202 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7c07083-4b0e-4f63-9f4c-100a71869eea'
);


-- Op. 8 연가곡집 <Our Hunting Fathers> Op. 8

UPDATE pieces piece
SET piece.title = '연가곡집 <Our Hunting Fathers> Op. 8', piece.title_en = 'Our Hunting Fathers, op. 8',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '8',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2193 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Our Hunting Fathers, op. 8: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:914e0f81-e182-41cc-b187-1c58928c78a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:914e0f81-e182-41cc-b187-1c58928c78a0', 1, NULL, 'Prologue', 'Our Hunting Fathers, op. 8: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:914e0f81-e182-41cc-b187-1c58928c78a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A. Rats Away!', part.name_en = 'Our Hunting Fathers, op. 8: A. Rats Away!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a64aac55-8df1-4c89-b6dd-5e2a61d17fe6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a64aac55-8df1-4c89-b6dd-5e2a61d17fe6', 2, NULL, 'A. Rats Away!', 'Our Hunting Fathers, op. 8: A. Rats Away!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a64aac55-8df1-4c89-b6dd-5e2a61d17fe6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'B. Messalina', part.name_en = 'Our Hunting Fathers, op. 8: B. Messalina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:de1dd8d1-3efc-4c91-9062-97eb941a217a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de1dd8d1-3efc-4c91-9062-97eb941a217a', 3, NULL, 'B. Messalina', 'Our Hunting Fathers, op. 8: B. Messalina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de1dd8d1-3efc-4c91-9062-97eb941a217a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C. Dance of Death', part.name_en = 'Our Hunting Fathers, op. 8: C. Dance of Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1b544f51-789b-469c-9cda-21c1989c5f78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b544f51-789b-469c-9cda-21c1989c5f78', 4, NULL, 'C. Dance of Death', 'Our Hunting Fathers, op. 8: C. Dance of Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b544f51-789b-469c-9cda-21c1989c5f78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Epilogue and Funeral March', part.name_en = 'Our Hunting Fathers, op. 8: Epilogue and Funeral March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2193 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2f21df88-b45e-44ee-8912-e93fe21472c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f21df88-b45e-44ee-8912-e93fe21472c6', 5, NULL, 'Epilogue and Funeral March', 'Our Hunting Fathers, op. 8: Epilogue and Funeral March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2193 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f21df88-b45e-44ee-8912-e93fe21472c6'
);


-- None 오페라 <Owen Wingrave>

UPDATE pieces piece
SET piece.title = '오페라 <Owen Wingrave>', piece.title_en = 'Owen Wingrave',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1545 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Owen Wingrave: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1545 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:80df932d-58a9-4621-9519-a5283d31f744' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80df932d-58a9-4621-9519-a5283d31f744', 1, NULL, 'Act I', 'Owen Wingrave: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1545 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80df932d-58a9-4621-9519-a5283d31f744'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Owen Wingrave: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1545 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1593a30a-b4ff-4d5c-be04-8cd885f1f442' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1593a30a-b4ff-4d5c-be04-8cd885f1f442', 2, NULL, 'Act II', 'Owen Wingrave: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1545 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1593a30a-b4ff-4d5c-be04-8cd885f1f442'
);


-- Op. 17 오페레타 <Paul Bunyan> Op. 17

UPDATE pieces piece
SET piece.title = '오페레타 <Paul Bunyan> Op. 17', piece.title_en = 'Paul Bunyan, op. 17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '17',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2668 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction', part.name_en = 'Paul Bunyan, op. 17: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2668 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:625ca7be-2230-4d71-bd5d-445df9371d90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:625ca7be-2230-4d71-bd5d-445df9371d90', 1, NULL, 'Introduction', 'Paul Bunyan, op. 17: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2668 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:625ca7be-2230-4d71-bd5d-445df9371d90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'First Ballad Interlude (Narrator)', part.name_en = 'Paul Bunyan, op. 17: First Ballad Interlude (Narrator)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2668 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0889c800-db7a-48df-80cb-f5cd17142ce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0889c800-db7a-48df-80cb-f5cd17142ce5', 2, NULL, 'First Ballad Interlude (Narrator)', 'Paul Bunyan, op. 17: First Ballad Interlude (Narrator)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2668 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0889c800-db7a-48df-80cb-f5cd17142ce5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Paul Bunyan, op. 17: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2668 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0e785c8f-8367-4446-b590-1460eb225d2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e785c8f-8367-4446-b590-1460eb225d2f', 3, NULL, 'Act I', 'Paul Bunyan, op. 17: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2668 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e785c8f-8367-4446-b590-1460eb225d2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e785c8f-8367-4446-b590-1460eb225d2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I. Scene 1', part.name_en = 'Paul Bunyan, op. 17: Act I. Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2668 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e1d8c82a-6d9f-471b-8d97-bfd95f0c74f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1d8c82a-6d9f-471b-8d97-bfd95f0c74f6', 1, NULL, 'Act I. Scene 1', 'Paul Bunyan, op. 17: Act I. Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e785c8f-8367-4446-b590-1460eb225d2f'
WHERE p.id = 2668 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d8c82a-6d9f-471b-8d97-bfd95f0c74f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e785c8f-8367-4446-b590-1460eb225d2f'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I. Scene 2', part.name_en = 'Paul Bunyan, op. 17: Act I. Scene 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2668 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7fa1f473-5f6c-4286-994d-5608e4c6a7c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7fa1f473-5f6c-4286-994d-5608e4c6a7c4', 2, NULL, 'Act I. Scene 2', 'Paul Bunyan, op. 17: Act I. Scene 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e785c8f-8367-4446-b590-1460eb225d2f'
WHERE p.id = 2668 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fa1f473-5f6c-4286-994d-5608e4c6a7c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Paul Bunyan, op. 17: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2668 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f33069a2-b3e6-4061-9161-593d05505aee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f33069a2-b3e6-4061-9161-593d05505aee', 4, NULL, 'Act II', 'Paul Bunyan, op. 17: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2668 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f33069a2-b3e6-4061-9161-593d05505aee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f33069a2-b3e6-4061-9161-593d05505aee'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act II. Scene 1', part.name_en = 'Paul Bunyan, op. 17: Act II. Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2668 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:20da8874-caea-447f-a69e-40a54ad8788b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20da8874-caea-447f-a69e-40a54ad8788b', 1, NULL, 'Act II. Scene 1', 'Paul Bunyan, op. 17: Act II. Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f33069a2-b3e6-4061-9161-593d05505aee'
WHERE p.id = 2668 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20da8874-caea-447f-a69e-40a54ad8788b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f33069a2-b3e6-4061-9161-593d05505aee'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II. Scene 2', part.name_en = 'Paul Bunyan, op. 17: Act II. Scene 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2668 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4e576e50-9604-46d9-9fce-165a291f7b11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e576e50-9604-46d9-9fce-165a291f7b11', 2, NULL, 'Act II. Scene 2', 'Paul Bunyan, op. 17: Act II. Scene 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f33069a2-b3e6-4061-9161-593d05505aee'
WHERE p.id = 2668 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e576e50-9604-46d9-9fce-165a291f7b11'
);


-- Op. 33 오페라 <Peter Grimes> Op. 33

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue', part.name_en = 'Peter Grimes: Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b', 1, NULL, 'Prologue', 'Peter Grimes: Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '"Peter Grimes!" (Hobson)', part.name_en = 'Peter Grimes: Prologue: "Peter Grimes!" (Hobson)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5ecd048c-c93d-3c8c-b752-86c3b5715aab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ecd048c-c93d-3c8c-b752-86c3b5715aab', 1, NULL, '"Peter Grimes!" (Hobson)', 'Peter Grimes: Prologue: "Peter Grimes!" (Hobson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ecd048c-c93d-3c8c-b752-86c3b5715aab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '"You sailed your boat round the coast" (Swallow)', part.name_en = 'Peter Grimes: Prologue: "You sailed your boat round the coast" (Swallow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:751e24e2-a5a8-3b94-a4a8-02a4861ce969' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:751e24e2-a5a8-3b94-a4a8-02a4861ce969', 2, NULL, '"You sailed your boat round the coast" (Swallow)', 'Peter Grimes: Prologue: "You sailed your boat round the coast" (Swallow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:751e24e2-a5a8-3b94-a4a8-02a4861ce969'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '"Peter Grimes: I here advise you!" (Swallow)', part.name_en = 'Peter Grimes: Prologue: "Peter Grimes: I here advise you!" (Swallow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7563b94f-22c4-3ec2-8458-87f7d8c33d5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7563b94f-22c4-3ec2-8458-87f7d8c33d5a', 3, NULL, '"Peter Grimes: I here advise you!" (Swallow)', 'Peter Grimes: Prologue: "Peter Grimes: I here advise you!" (Swallow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7563b94f-22c4-3ec2-8458-87f7d8c33d5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '"The truth...the pity...and the truth" (Peter)', part.name_en = 'Peter Grimes: Prologue: "The truth...the pity...and the truth" (Peter)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0630e655-334c-32d8-9ae2-b002c903ae22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0630e655-334c-32d8-9ae2-b002c903ae22', 4, NULL, '"The truth...the pity...and the truth" (Peter)', 'Peter Grimes: Prologue: "The truth...the pity...and the truth" (Peter)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0630e655-334c-32d8-9ae2-b002c903ae22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Interlude I', part.name_en = 'Peter Grimes: Prologue: Interlude I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c1ebb134-a45f-38fa-bec8-0c3a6e82a592' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1ebb134-a45f-38fa-bec8-0c3a6e82a592', 5, NULL, 'Interlude I', 'Peter Grimes: Prologue: Interlude I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:159d6732-8920-4617-a238-840458a6fc4b'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1ebb134-a45f-38fa-bec8-0c3a6e82a592'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'Peter Grimes: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b14c1760-509f-4ff6-a699-fd05010f3a32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b14c1760-509f-4ff6-a699-fd05010f3a32', 2, NULL, 'Act I', 'Peter Grimes: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b14c1760-509f-4ff6-a699-fd05010f3a32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b14c1760-509f-4ff6-a699-fd05010f3a32'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Interlude II The Storm', part.name_en = 'Peter Grimes: Act I: Interlude II The Storm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:974ef166-a361-32bd-bcb0-9b131414b685' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:974ef166-a361-32bd-bcb0-9b131414b685', 1, NULL, 'Interlude II The Storm', 'Peter Grimes: Act I: Interlude II The Storm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b14c1760-509f-4ff6-a699-fd05010f3a32'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:974ef166-a361-32bd-bcb0-9b131414b685'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'Peter Grimes: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340', 3, NULL, 'Act II', 'Peter Grimes: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Interlude III', part.name_en = 'Peter Grimes: Act II: Interlude III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5343c6cb-99b3-3728-80c9-f2fd2dec92b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5343c6cb-99b3-3728-80c9-f2fd2dec92b4', 1, NULL, 'Interlude III', 'Peter Grimes: Act II: Interlude III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5343c6cb-99b3-3728-80c9-f2fd2dec92b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scene 1', part.name_en = 'Peter Grimes: Act II: Scene 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4c37c24e-240b-46d4-9229-be1c37eb2260' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c37c24e-240b-46d4-9229-be1c37eb2260', 2, NULL, 'Scene 1', 'Peter Grimes: Act II: Scene 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c37c24e-240b-46d4-9229-be1c37eb2260'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scene I: Interlude IV. Passacaglia', part.name_en = 'Peter Grimes: Act II: Scene I: Interlude IV. Passacaglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ce1cfbd6-4519-3db1-852f-70d87e31911e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce1cfbd6-4519-3db1-852f-70d87e31911e', 3, NULL, 'Scene I: Interlude IV. Passacaglia', 'Peter Grimes: Act II: Scene I: Interlude IV. Passacaglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b6196a30-f5b3-40d4-8b15-97a25a0b2340'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce1cfbd6-4519-3db1-852f-70d87e31911e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'Peter Grimes: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e483865a-9caa-4403-ab26-19b745a19cab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e483865a-9caa-4403-ab26-19b745a19cab', 4, NULL, 'Act III', 'Peter Grimes: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e483865a-9caa-4403-ab26-19b745a19cab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e483865a-9caa-4403-ab26-19b745a19cab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Interlude V. Evening', part.name_en = 'Peter Grimes: Act III: Interlude V. Evening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1c6d346a-8eec-3359-80ce-dcf4e60a0142' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c6d346a-8eec-3359-80ce-dcf4e60a0142', 1, NULL, 'Interlude V. Evening', 'Peter Grimes: Act III: Interlude V. Evening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e483865a-9caa-4403-ab26-19b745a19cab'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c6d346a-8eec-3359-80ce-dcf4e60a0142'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e483865a-9caa-4403-ab26-19b745a19cab'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Interlude VI Fog', part.name_en = 'Peter Grimes: Act III: Interlude VI Fog',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 357 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0680d59b-e19d-3765-b34d-92709b346813' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0680d59b-e19d-3765-b34d-92709b346813', 2, NULL, 'Interlude VI Fog', 'Peter Grimes: Act III: Interlude VI Fog', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e483865a-9caa-4403-ab26-19b745a19cab'
WHERE p.id = 357 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0680d59b-e19d-3765-b34d-92709b346813'
);


-- Op. 93 칸타타 <Phaedra>

UPDATE pieces piece
SET piece.title = '칸타타 <Phaedra>', piece.title_en = 'Phaedra, op. 93',
    piece.type = 'song', piece.opus_number = 'Op. 93',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1602 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 2 Phantasy Quartet

UPDATE pieces piece
SET piece.title = 'Phantasy Quartet', piece.title_en = 'Phantasy Quartet, op. 2',
    piece.type = 'song', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 551 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Phantasy in F minor

UPDATE pieces piece
SET piece.title = 'Phantasy in F minor', piece.title_en = 'Phantasy in F minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 589 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 23 Pieces for 2 pianos Op. 23

UPDATE pieces piece
SET piece.title = 'Pieces for 2 pianos Op. 23', piece.title_en = 'Pieces for 2 pianos, op. 23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '23',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1533 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction and Rondo alla burlesca, op. 23 no. 1', part.name_en = 'Introduction and Rondo alla burlesca, op. 23 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1533 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b02fc015-cacd-450e-ba42-87aa34f74355' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b02fc015-cacd-450e-ba42-87aa34f74355', 1, NULL, 'Introduction and Rondo alla burlesca, op. 23 no. 1', 'Introduction and Rondo alla burlesca, op. 23 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1533 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b02fc015-cacd-450e-ba42-87aa34f74355'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b02fc015-cacd-450e-ba42-87aa34f74355'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Grave', part.name_en = 'Introduction and Rondo alla burlesca, op. 23 no. 1: I. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1533 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:258b11b5-23b3-4b58-a6c8-9027fca56b3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:258b11b5-23b3-4b58-a6c8-9027fca56b3c', 1, NULL, 'Grave', 'Introduction and Rondo alla burlesca, op. 23 no. 1: I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b02fc015-cacd-450e-ba42-87aa34f74355'
WHERE p.id = 1533 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:258b11b5-23b3-4b58-a6c8-9027fca56b3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b02fc015-cacd-450e-ba42-87aa34f74355'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato, ma con spirito', part.name_en = 'Introduction and Rondo alla burlesca, op. 23 no. 1: II. Allegro moderato, ma con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1533 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d0b3adaf-689d-480e-9a22-bfa939498669' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0b3adaf-689d-480e-9a22-bfa939498669', 2, NULL, 'Allegro moderato, ma con spirito', 'Introduction and Rondo alla burlesca, op. 23 no. 1: II. Allegro moderato, ma con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b02fc015-cacd-450e-ba42-87aa34f74355'
WHERE p.id = 1533 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0b3adaf-689d-480e-9a22-bfa939498669'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mazurka elegiaca, op. 23 no. 2', part.name_en = 'Mazurka elegiaca, op. 23 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1533 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0a490709-1c28-4a90-8c73-ff825a17b0a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a490709-1c28-4a90-8c73-ff825a17b0a9', 2, NULL, 'Mazurka elegiaca, op. 23 no. 2', 'Mazurka elegiaca, op. 23 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1533 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a490709-1c28-4a90-8c73-ff825a17b0a9'
);


-- None 발레 <Plymouth Town>

UPDATE pieces piece
SET piece.title = '발레 <Plymouth Town>', piece.title_en = 'Plymouth Town',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1173 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 29 Prelude and Fugue for 18-Part String Orchestra Op. 29

UPDATE pieces piece
SET piece.title = 'Prelude and Fugue for 18-Part String Orchestra Op. 29', piece.title_en = 'Prelude and Fugue for 18-Part String Orchestra, op. 29',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '29',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 564 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude. Grave', part.name_en = 'Prelude and Fugue for 18-Part String Orchestra, op. 29: Prelude. Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 564 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:88e225ff-ae89-43d3-806a-405a4e065a4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88e225ff-ae89-43d3-806a-405a4e065a4e', 1, NULL, 'Prelude. Grave', 'Prelude and Fugue for 18-Part String Orchestra, op. 29: Prelude. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 564 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88e225ff-ae89-43d3-806a-405a4e065a4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fugue. Allegro energico - Coda', part.name_en = 'Prelude and Fugue for 18-Part String Orchestra, op. 29: Fugue. Allegro energico - Coda',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 564 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bd46b313-3355-4f0b-b7fd-b8055de55058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd46b313-3355-4f0b-b7fd-b8055de55058', 2, NULL, 'Fugue. Allegro energico - Coda', 'Prelude and Fugue for 18-Part String Orchestra, op. 29: Fugue. Allegro energico - Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 564 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd46b313-3355-4f0b-b7fd-b8055de55058'
);


-- None Prelude on "They Walk Alone"

UPDATE pieces piece
SET piece.title = 'Prelude on "They Walk Alone"', piece.title_en = 'Prelude on "They Walk Alone"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2767 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 67 Psalm 150

UPDATE pieces piece
SET piece.title = 'Psalm 150', piece.title_en = 'Psalm 150, op. 67',
    piece.type = 'song', piece.opus_number = 'Op. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 927 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quartettino

UPDATE pieces piece
SET piece.title = 'Quartettino', piece.title_en = 'Quartettino',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2806 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Quartettino: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2806 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:31c9bcb2-624a-3854-9481-a101471a7fb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31c9bcb2-624a-3854-9481-a101471a7fb6', 1, 'I', 'Andante', 'Quartettino: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2806 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31c9bcb2-624a-3854-9481-a101471a7fb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Poco adagio ma con moto', part.name_en = 'Quartettino: II. Poco adagio ma con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2806 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cc2faf9b-2a3e-388e-8b25-4fb21202580b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc2faf9b-2a3e-388e-8b25-4fb21202580b', 2, 'II', 'Poco adagio ma con moto', 'Quartettino: II. Poco adagio ma con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2806 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc2faf9b-2a3e-388e-8b25-4fb21202580b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto vivace', part.name_en = 'Quartettino: III. Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2806 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:025e00ca-29e7-3843-8c68-95f70415dbc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:025e00ca-29e7-3843-8c68-95f70415dbc7', 3, 'III', 'Allegro molto vivace', 'Quartettino: III. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2806 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:025e00ca-29e7-3843-8c68-95f70415dbc7'
);


-- None Quatre chansons françaises

UPDATE pieces piece
SET piece.title = 'Quatre chansons françaises', piece.title_en = 'Quatre chansons françaises',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 565 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nuits de juin', part.name_en = 'Nuits de juin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 565 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6be771ba-672e-441d-a3da-12b2267b379a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6be771ba-672e-441d-a3da-12b2267b379a', 1, NULL, 'Nuits de juin', 'Nuits de juin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 565 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6be771ba-672e-441d-a3da-12b2267b379a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sagesse', part.name_en = 'Sagesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 565 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:eacf035e-fbca-407e-83d7-57852b4b7643' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eacf035e-fbca-407e-83d7-57852b4b7643', 2, NULL, 'Sagesse', 'Sagesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 565 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eacf035e-fbca-407e-83d7-57852b4b7643'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'L''Enfance', part.name_en = 'L''Enfance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 565 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:acf6d97e-53eb-4fae-a6d1-0f6f5ae1bdc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acf6d97e-53eb-4fae-a6d1-0f6f5ae1bdc0', 3, NULL, 'L''Enfance', 'L''Enfance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 565 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acf6d97e-53eb-4fae-a6d1-0f6f5ae1bdc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Chanson d''automne', part.name_en = 'Chanson d''automne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 565 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6fac2de5-4e3f-46f6-906a-4674e8d326bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fac2de5-4e3f-46f6-906a-4674e8d326bf', 4, NULL, 'Chanson d''automne', 'Chanson d''automne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 565 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fac2de5-4e3f-46f6-906a-4674e8d326bf'
);


-- None Reflection

UPDATE pieces piece
SET piece.title = 'Reflection', piece.title_en = 'Reflection',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1238 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Reveille

UPDATE pieces piece
SET piece.title = 'Reveille', piece.title_en = 'Reveille',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1098 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 랩소디

UPDATE pieces piece
SET piece.title = '랩소디', piece.title_en = 'Rhapsody',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 558 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Rondo concertante

UPDATE pieces piece
SET piece.title = 'Rondo concertante', piece.title_en = 'Rondo concertante',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 986 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto', part.name_en = 'Rondo concertante: I. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 986 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9e07728d-2714-4488-9cdb-0414683d0526' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e07728d-2714-4488-9cdb-0414683d0526', 1, 'I', 'Allegro molto', 'Rondo concertante: I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 986 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e07728d-2714-4488-9cdb-0414683d0526'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'Rondo concertante: II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 986 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:26b63cb3-6985-46b4-b22b-58c343781fbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26b63cb3-6985-46b4-b22b-58c343781fbf', 2, 'II', 'Lento', 'Rondo concertante: II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 986 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26b63cb3-6985-46b4-b22b-58c343781fbf'
);


-- None Russian Funeral

UPDATE pieces piece
SET piece.title = 'Russian Funeral', piece.title_en = 'Russian Funeral',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2235 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 91 연가곡집 <Sacred and Profane> Op. 91

UPDATE pieces piece
SET piece.title = '연가곡집 <Sacred and Profane> Op. 91', piece.title_en = 'Sacred and Profane, op. 91',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '91',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1907 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'St. Godric''s Hymn', part.name_en = 'Sacred and Profane, op. 91: No. 1. St. Godric''s Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1907 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:af887213-9bba-494a-bc85-378d3e7e043c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af887213-9bba-494a-bc85-378d3e7e043c', 1, NULL, 'St. Godric''s Hymn', 'Sacred and Profane, op. 91: No. 1. St. Godric''s Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1907 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af887213-9bba-494a-bc85-378d3e7e043c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'I mon waxe wod', part.name_en = 'Sacred and Profane, op. 91: No. 2. I mon waxe wod',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1907 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:200c42b0-215f-4b25-86c6-0f66e8eb7882' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:200c42b0-215f-4b25-86c6-0f66e8eb7882', 2, NULL, 'I mon waxe wod', 'Sacred and Profane, op. 91: No. 2. I mon waxe wod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1907 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:200c42b0-215f-4b25-86c6-0f66e8eb7882'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lenten is come', part.name_en = 'Sacred and Profane, op. 91: No. 3. Lenten is come',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1907 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:24245e01-b4e6-4662-9338-b685ee2a4ac3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24245e01-b4e6-4662-9338-b685ee2a4ac3', 3, NULL, 'Lenten is come', 'Sacred and Profane, op. 91: No. 3. Lenten is come', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1907 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24245e01-b4e6-4662-9338-b685ee2a4ac3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The long night', part.name_en = 'Sacred and Profane, op. 91: No. 4. The long night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1907 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:47c14ecd-0a79-4647-ae19-cc14698853fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47c14ecd-0a79-4647-ae19-cc14698853fc', 4, NULL, 'The long night', 'Sacred and Profane, op. 91: No. 4. The long night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1907 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c14ecd-0a79-4647-ae19-cc14698853fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Yif ic of luve can', part.name_en = 'Sacred and Profane, op. 91: No. 5. Yif ic of luve can',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1907 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6b3d0d9b-3c43-4537-8cbc-4e9913414528' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b3d0d9b-3c43-4537-8cbc-4e9913414528', 5, NULL, 'Yif ic of luve can', 'Sacred and Profane, op. 91: No. 5. Yif ic of luve can', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1907 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b3d0d9b-3c43-4537-8cbc-4e9913414528'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Carol', part.name_en = 'Sacred and Profane, op. 91: No. 6. Carol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1907 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d0d44f7c-d64c-4a22-bbe9-a94b53e257ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0d44f7c-d64c-4a22-bbe9-a94b53e257ea', 6, NULL, 'Carol', 'Sacred and Profane, op. 91: No. 6. Carol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1907 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0d44f7c-d64c-4a22-bbe9-a94b53e257ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ye that pasen by', part.name_en = 'Sacred and Profane, op. 91: No. 7. Ye that pasen by',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1907 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:342f8e59-a8de-454b-b94f-df67797c0e84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:342f8e59-a8de-454b-b94f-df67797c0e84', 7, NULL, 'Ye that pasen by', 'Sacred and Profane, op. 91: No. 7. Ye that pasen by', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1907 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:342f8e59-a8de-454b-b94f-df67797c0e84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A death', part.name_en = 'Sacred and Profane, op. 91: No. 8. A death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1907 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:dc57d798-82e8-4929-a327-aabecbca9332' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc57d798-82e8-4929-a327-aabecbca9332', 8, NULL, 'A death', 'Sacred and Profane, op. 91: No. 8. A death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1907 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc57d798-82e8-4929-a327-aabecbca9332'
);


-- None Scherzo for Recorder Quartet

UPDATE pieces piece
SET piece.title = 'Scherzo for Recorder Quartet', piece.title_en = 'Scherzo for Recorder Quartet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2999 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 26 Scottish Ballad

UPDATE pieces piece
SET piece.title = 'Scottish Ballad', piece.title_en = 'Scottish Ballad, op. 26',
    piece.type = 'song', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1335 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Seascape

UPDATE pieces piece
SET piece.title = 'Seascape', piece.title_en = 'Seascape',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2760 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 61 연가곡집 <Sechs Hölderlin‐Fragmente>

UPDATE pieces piece
SET piece.title = '연가곡집 <Sechs Hölderlin‐Fragmente>', piece.title_en = 'Sechs Hölderlin‐Fragmente, op. 61',
    piece.type = 'album', piece.opus_number = 'Op. 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 528 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Menschenbeifall', part.name_en = 'Six Hölderlin Fragments, op. 61: I. Menschenbeifall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 528 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:19a7ac35-e5a4-4fba-82b5-85c80721a057' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19a7ac35-e5a4-4fba-82b5-85c80721a057', 1, 'I', 'Menschenbeifall', 'Six Hölderlin Fragments, op. 61: I. Menschenbeifall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 528 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19a7ac35-e5a4-4fba-82b5-85c80721a057'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Die Heimat', part.name_en = 'Six Hölderlin Fragments, op. 61: II. Die Heimat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 528 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7bba6a12-ad3d-4121-84fe-1a7855e64537' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bba6a12-ad3d-4121-84fe-1a7855e64537', 2, 'II', 'Die Heimat', 'Six Hölderlin Fragments, op. 61: II. Die Heimat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 528 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bba6a12-ad3d-4121-84fe-1a7855e64537'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sokrates und Alcibiades', part.name_en = 'Six Hölderlin Fragments, op. 61: III. Sokrates und Alcibiades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 528 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:05d59422-ee94-4a07-9b64-11f02a7f8d1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05d59422-ee94-4a07-9b64-11f02a7f8d1f', 3, 'III', 'Sokrates und Alcibiades', 'Six Hölderlin Fragments, op. 61: III. Sokrates und Alcibiades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 528 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05d59422-ee94-4a07-9b64-11f02a7f8d1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Die Jugend', part.name_en = 'Six Hölderlin Fragments, op. 61: IV. Die Jugend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 528 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:90036440-06e2-42f8-9723-82a7a772ab4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90036440-06e2-42f8-9723-82a7a772ab4d', 4, 'IV', 'Die Jugend', 'Six Hölderlin Fragments, op. 61: IV. Die Jugend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 528 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90036440-06e2-42f8-9723-82a7a772ab4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Hälfte des Lebens', part.name_en = 'Six Hölderlin Fragments, op. 61: V. Hälfte des Lebens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 528 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b385ec5c-becb-4956-bee9-41151d6a04eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b385ec5c-becb-4956-bee9-41151d6a04eb', 5, 'V', 'Hälfte des Lebens', 'Six Hölderlin Fragments, op. 61: V. Hälfte des Lebens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 528 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b385ec5c-becb-4956-bee9-41151d6a04eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Die Linien des Lebens', part.name_en = 'Six Hölderlin Fragments, op. 61: VI. Die Linien des Lebens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 528 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b11201bb-ec2c-4c21-89c5-5e9294cde096' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b11201bb-ec2c-4c21-89c5-5e9294cde096', 6, 'VI', 'Die Linien des Lebens', 'Six Hölderlin Fragments, op. 61: VI. Die Linien des Lebens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 528 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b11201bb-ec2c-4c21-89c5-5e9294cde096'
);


-- Op. 31 Serenade for Tenor, Horn and Strings

UPDATE pieces piece
SET piece.title = 'Serenade for Tenor, Horn and Strings', piece.title_en = 'Serenade for Tenor, Horn and Strings, op. 31',
    piece.type = 'album', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1777 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prologue', part.name_en = 'Serenade for Tenor, Horn and Strings, op. 31: I. Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1777 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cb4d7d69-264f-3df0-9617-0799b02116a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb4d7d69-264f-3df0-9617-0799b02116a8', 1, 'I', 'Prologue', 'Serenade for Tenor, Horn and Strings, op. 31: I. Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1777 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb4d7d69-264f-3df0-9617-0799b02116a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pastoral', part.name_en = 'Serenade for Tenor, Horn and Strings, op. 31: II. Pastoral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1777 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9c7816d8-bf58-31b7-8775-64b1197b5df5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c7816d8-bf58-31b7-8775-64b1197b5df5', 2, 'II', 'Pastoral', 'Serenade for Tenor, Horn and Strings, op. 31: II. Pastoral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1777 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c7816d8-bf58-31b7-8775-64b1197b5df5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nocturne', part.name_en = 'Serenade for Tenor, Horn and Strings, op. 31: III. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1777 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c75cd344-00a0-304d-ac90-da0c38c2685f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c75cd344-00a0-304d-ac90-da0c38c2685f', 3, 'III', 'Nocturne', 'Serenade for Tenor, Horn and Strings, op. 31: III. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1777 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c75cd344-00a0-304d-ac90-da0c38c2685f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Elegy', part.name_en = 'Serenade for Tenor, Horn and Strings, op. 31: IV. Elegy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1777 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:50072579-9ea8-337e-94f6-d38e4df68451' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50072579-9ea8-337e-94f6-d38e4df68451', 4, 'IV', 'Elegy', 'Serenade for Tenor, Horn and Strings, op. 31: IV. Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1777 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50072579-9ea8-337e-94f6-d38e4df68451'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Dirge', part.name_en = 'Serenade for Tenor, Horn and Strings, op. 31: V. Dirge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1777 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7fad466d-348b-3274-b987-af29855a8b51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fad466d-348b-3274-b987-af29855a8b51', 5, 'V', 'Dirge', 'Serenade for Tenor, Horn and Strings, op. 31: V. Dirge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1777 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fad466d-348b-3274-b987-af29855a8b51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Hymn', part.name_en = 'Serenade for Tenor, Horn and Strings, op. 31: VI. Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1777 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8ee1c0cf-af07-3802-b0b5-1cfdaedef107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ee1c0cf-af07-3802-b0b5-1cfdaedef107', 6, 'VI', 'Hymn', 'Serenade for Tenor, Horn and Strings, op. 31: VI. Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1777 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee1c0cf-af07-3802-b0b5-1cfdaedef107'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Sonnet', part.name_en = 'Serenade for Tenor, Horn and Strings, op. 31: VII. Sonnet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1777 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c78d2156-a1fe-305e-9fd1-6093d837cd73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c78d2156-a1fe-305e-9fd1-6093d837cd73', 7, 'VII', 'Sonnet', 'Serenade for Tenor, Horn and Strings, op. 31: VII. Sonnet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1777 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c78d2156-a1fe-305e-9fd1-6093d837cd73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Epilogue', part.name_en = 'Serenade for Tenor, Horn and Strings, op. 31: VIII. Epilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1777 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:db25ac2c-65ee-3a51-b554-29a223a48320' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db25ac2c-65ee-3a51-b554-29a223a48320', 8, 'VIII', 'Epilogue', 'Serenade for Tenor, Horn and Strings, op. 31: VIII. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1777 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db25ac2c-65ee-3a51-b554-29a223a48320'
);


-- Op. 22 연가곡집 <Seven Sonnets of Michelangelo> Op. 22

UPDATE pieces piece
SET piece.title = '연가곡집 <Seven Sonnets of Michelangelo> Op. 22', piece.title_en = 'Seven Sonnets of Michelangelo, op. 22',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '22',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2561 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonetto XVI: Si come nella penna e nell''inchiostro', part.name_en = 'Seven Sonnets of Michelangelo, op. 22: 1. Sonetto XVI: Si come nella penna e nell''inchiostro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2561 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5691f512-f35e-4786-af76-076dd95b07f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5691f512-f35e-4786-af76-076dd95b07f1', 1, NULL, 'Sonetto XVI: Si come nella penna e nell''inchiostro', 'Seven Sonnets of Michelangelo, op. 22: 1. Sonetto XVI: Si come nella penna e nell''inchiostro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2561 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5691f512-f35e-4786-af76-076dd95b07f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sonetto XXXI: A che piu debb''io mai l''intensa voglia', part.name_en = 'Seven Sonnets of Michelangelo, op. 22: 2. Sonetto XXXI: A che piu debb''io mai l''intensa voglia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2561 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:834ef832-c761-4dfb-8f2c-d8f19cac35a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:834ef832-c761-4dfb-8f2c-d8f19cac35a8', 2, NULL, 'Sonetto XXXI: A che piu debb''io mai l''intensa voglia', 'Seven Sonnets of Michelangelo, op. 22: 2. Sonetto XXXI: A che piu debb''io mai l''intensa voglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2561 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:834ef832-c761-4dfb-8f2c-d8f19cac35a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sonetto XXX: Veggio co'' be'' vostri occhi un dolce lume', part.name_en = 'Seven Sonnets of Michelangelo, op. 22: 3. Sonetto XXX: Veggio co'' be'' vostri occhi un dolce lume',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2561 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:835d2695-8bad-4237-b52a-82446c46870e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:835d2695-8bad-4237-b52a-82446c46870e', 3, NULL, 'Sonetto XXX: Veggio co'' be'' vostri occhi un dolce lume', 'Seven Sonnets of Michelangelo, op. 22: 3. Sonetto XXX: Veggio co'' be'' vostri occhi un dolce lume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2561 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:835d2695-8bad-4237-b52a-82446c46870e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sonetto LV: Tu sa'' ch''io so, signior mie, che tu sai', part.name_en = 'Seven Sonnets of Michelangelo, op. 22: 4. Sonetto LV: Tu sa'' ch''io so, signior mie, che tu sai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2561 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:676f8f0c-92b7-4373-8583-5f3050199fd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:676f8f0c-92b7-4373-8583-5f3050199fd0', 4, NULL, 'Sonetto LV: Tu sa'' ch''io so, signior mie, che tu sai', 'Seven Sonnets of Michelangelo, op. 22: 4. Sonetto LV: Tu sa'' ch''io so, signior mie, che tu sai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2561 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:676f8f0c-92b7-4373-8583-5f3050199fd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sonetto XXXVIII: Rendete a gli occhi miei, o fonte o fiume', part.name_en = 'Seven Sonnets of Michelangelo, op. 22: 5. Sonetto XXXVIII: Rendete a gli occhi miei, o fonte o fiume',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2561 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:48100281-a05e-4c2a-ae24-b3a7aff1cfae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48100281-a05e-4c2a-ae24-b3a7aff1cfae', 5, NULL, 'Sonetto XXXVIII: Rendete a gli occhi miei, o fonte o fiume', 'Seven Sonnets of Michelangelo, op. 22: 5. Sonetto XXXVIII: Rendete a gli occhi miei, o fonte o fiume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2561 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48100281-a05e-4c2a-ae24-b3a7aff1cfae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Sonetto XXXII: S''un casto amor, s''una pieta superna', part.name_en = 'Seven Sonnets of Michelangelo, op. 22: 6. Sonetto XXXII: S''un casto amor, s''una pieta superna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2561 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f8a1ae24-d670-4abe-81e4-eb5e521ff331' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8a1ae24-d670-4abe-81e4-eb5e521ff331', 6, NULL, 'Sonetto XXXII: S''un casto amor, s''una pieta superna', 'Seven Sonnets of Michelangelo, op. 22: 6. Sonetto XXXII: S''un casto amor, s''una pieta superna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2561 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a1ae24-d670-4abe-81e4-eb5e521ff331'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Sonetto XXIV: Spirto ben nato, in cui si specchia e vede', part.name_en = 'Seven Sonnets of Michelangelo, op. 22: 7. Sonetto XXIV: Spirto ben nato, in cui si specchia e vede',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2561 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5f70ec43-a92a-42d2-afa2-d42b5d57f544' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f70ec43-a92a-42d2-afa2-d42b5d57f544', 7, NULL, 'Sonetto XXIV: Spirto ben nato, in cui si specchia e vede', 'Seven Sonnets of Michelangelo, op. 22: 7. Sonetto XXIV: Spirto ben nato, in cui si specchia e vede', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2561 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f70ec43-a92a-42d2-afa2-d42b5d57f544'
);


-- Op. 4 Simple Symphony

UPDATE pieces piece
SET piece.title = 'Simple Symphony', piece.title_en = 'Simple Symphony, op. 4',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1811 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Boisterous Bourrée', part.name_en = 'Simple Symphony, op. 4: I. Boisterous Bourrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1811 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c26e6270-420d-3516-852b-14a6d52cddf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c26e6270-420d-3516-852b-14a6d52cddf4', 1, 'I', 'Boisterous Bourrée', 'Simple Symphony, op. 4: I. Boisterous Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1811 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c26e6270-420d-3516-852b-14a6d52cddf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Playful Pizzicato', part.name_en = 'Simple Symphony, op. 4: II. Playful Pizzicato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1811 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5f755aec-97b1-3d89-a7b6-732e1f9518e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f755aec-97b1-3d89-a7b6-732e1f9518e8', 2, 'II', 'Playful Pizzicato', 'Simple Symphony, op. 4: II. Playful Pizzicato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1811 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f755aec-97b1-3d89-a7b6-732e1f9518e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sentimental Saraband', part.name_en = 'Simple Symphony, op. 4: III. Sentimental Saraband',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1811 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f801d002-d7ce-3544-9964-31b15a4aaa18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f801d002-d7ce-3544-9964-31b15a4aaa18', 3, 'III', 'Sentimental Saraband', 'Simple Symphony, op. 4: III. Sentimental Saraband', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1811 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f801d002-d7ce-3544-9964-31b15a4aaa18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Frolicsome Finale', part.name_en = 'Simple Symphony, op. 4: IV. Frolicsome Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1811 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8d90d9ae-4058-3016-bcac-0115065633da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d90d9ae-4058-3016-bcac-0115065633da', 4, 'IV', 'Frolicsome Finale', 'Simple Symphony, op. 4: IV. Frolicsome Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1811 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d90d9ae-4058-3016-bcac-0115065633da'
);


-- Op. 20 Sinfonia da Requiem

UPDATE pieces piece
SET piece.title = 'Sinfonia da Requiem', piece.title_en = 'Sinfonia da Requiem, op. 20',
    piece.type = 'album', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2091 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lachrymosa. Andante ben misurato', part.name_en = 'Sinfonia da Requiem, op. 20: I. Lachrymosa. Andante ben misurato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2091 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ede56e56-891c-39a9-9709-390565c8f491' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ede56e56-891c-39a9-9709-390565c8f491', 1, 'I', 'Lachrymosa. Andante ben misurato', 'Sinfonia da Requiem, op. 20: I. Lachrymosa. Andante ben misurato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2091 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ede56e56-891c-39a9-9709-390565c8f491'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dies irae. Allegro con fuoco', part.name_en = 'Sinfonia da Requiem, op. 20: II. Dies irae. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2091 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3e9ae842-fdf7-35ea-a34c-412ce8ec2a3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e9ae842-fdf7-35ea-a34c-412ce8ec2a3c', 2, 'II', 'Dies irae. Allegro con fuoco', 'Sinfonia da Requiem, op. 20: II. Dies irae. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2091 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e9ae842-fdf7-35ea-a34c-412ce8ec2a3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Requiem aeternam. Andante molto tranquillo', part.name_en = 'Sinfonia da Requiem, op. 20: III. Requiem aeternam. Andante molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2091 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2f794812-077d-3fe0-b85a-e2be25a8d2f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f794812-077d-3fe0-b85a-e2be25a8d2f0', 3, 'III', 'Requiem aeternam. Andante molto tranquillo', 'Sinfonia da Requiem, op. 20: III. Requiem aeternam. Andante molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2091 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f794812-077d-3fe0-b85a-e2be25a8d2f0'
);


-- Op. 1 신포니에타

UPDATE pieces piece
SET piece.title = '신포니에타', piece.title_en = 'Sinfonietta, op. 1',
    piece.type = 'album', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1475 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poco presto ed agitato', part.name_en = 'Sinfonietta, op. 1: I. Poco presto ed agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1475 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d11b5d3f-05f9-4ec3-b7f5-4f89d2af2227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d11b5d3f-05f9-4ec3-b7f5-4f89d2af2227', 1, 'I', 'Poco presto ed agitato', 'Sinfonietta, op. 1: I. Poco presto ed agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1475 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d11b5d3f-05f9-4ec3-b7f5-4f89d2af2227'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Variations', part.name_en = 'Sinfonietta, op. 1: II. Variations',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1475 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:aab7b59f-b629-4610-8008-00330daaea6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aab7b59f-b629-4610-8008-00330daaea6d', 2, 'II', 'Variations', 'Sinfonietta, op. 1: II. Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1475 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aab7b59f-b629-4610-8008-00330daaea6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tarantella', part.name_en = 'Sinfonietta, op. 1: III. Tarantella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1475 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:02273be2-a477-456f-9ebd-3550aa56c882' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02273be2-a477-456f-9ebd-3550aa56c882', 3, 'III', 'Tarantella', 'Sinfonietta, op. 1: III. Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1475 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02273be2-a477-456f-9ebd-3550aa56c882'
);


-- Op. 49 Six Metamorphoses after Ovid for Oboe Solo

UPDATE pieces piece
SET piece.title = 'Six Metamorphoses after Ovid for Oboe Solo', piece.title_en = 'Six Metamorphoses after Ovid for Oboe Solo, op. 49',
    piece.type = 'album', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1448 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pan - Senza misura', part.name_en = 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: I. Pan - Senza misura',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1448 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:10ffc316-b0d4-4230-ae93-442eb065d9fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10ffc316-b0d4-4230-ae93-442eb065d9fc', 1, 'I', 'Pan - Senza misura', 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: I. Pan - Senza misura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1448 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10ffc316-b0d4-4230-ae93-442eb065d9fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Phaeton - Vivace ritmico', part.name_en = 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: II. Phaeton - Vivace ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1448 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8b67d2f1-dfd2-46b4-8c6d-f4bd31036e71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b67d2f1-dfd2-46b4-8c6d-f4bd31036e71', 2, 'II', 'Phaeton - Vivace ritmico', 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: II. Phaeton - Vivace ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1448 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b67d2f1-dfd2-46b4-8c6d-f4bd31036e71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Niobe - Andante', part.name_en = 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: III. Niobe - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1448 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:500c44d4-3df1-400b-81f7-eaad3ce5653d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:500c44d4-3df1-400b-81f7-eaad3ce5653d', 3, 'III', 'Niobe - Andante', 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: III. Niobe - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1448 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:500c44d4-3df1-400b-81f7-eaad3ce5653d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Bacchus - Allegro paesante', part.name_en = 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: IV. Bacchus - Allegro paesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1448 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2606fdfb-50ef-4968-8a54-4ee0fa88e311' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2606fdfb-50ef-4968-8a54-4ee0fa88e311', 4, 'IV', 'Bacchus - Allegro paesante', 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: IV. Bacchus - Allegro paesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1448 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2606fdfb-50ef-4968-8a54-4ee0fa88e311'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Narcissus - Lento piacevole', part.name_en = 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: V. Narcissus - Lento piacevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1448 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:58167496-ad5e-470a-8e35-0e5aaca02ca6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58167496-ad5e-470a-8e35-0e5aaca02ca6', 5, 'V', 'Narcissus - Lento piacevole', 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: V. Narcissus - Lento piacevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1448 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58167496-ad5e-470a-8e35-0e5aaca02ca6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Arethusa - Largamente', part.name_en = 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: VI. Arethusa - Largamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1448 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1d8d1dff-c3be-42c9-b9b5-533c4f94b3de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d8d1dff-c3be-42c9-b9b5-533c4f94b3de', 6, 'VI', 'Arethusa - Largamente', 'Six Metamorphoses after Ovid for Oboe Solo, op. 49: VI. Arethusa - Largamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1448 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d8d1dff-c3be-42c9-b9b5-533c4f94b3de'
);


-- Op. 9 Soirées musicales

UPDATE pieces piece
SET piece.title = 'Soirées musicales', piece.title_en = 'Soirées musicales, op. 9',
    piece.type = 'album', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2061 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'March', part.name_en = 'Soirées musicales, op. 9: I. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2061 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:90d77180-a824-47b9-bfdd-d11b618c6515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90d77180-a824-47b9-bfdd-d11b618c6515', 1, 'I', 'March', 'Soirées musicales, op. 9: I. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2061 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90d77180-a824-47b9-bfdd-d11b618c6515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Canzonetta', part.name_en = 'Soirées musicales, op. 9: II. Canzonetta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2061 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:de98d7b6-9ce8-4076-8134-bd077ad2bc00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de98d7b6-9ce8-4076-8134-bd077ad2bc00', 2, 'II', 'Canzonetta', 'Soirées musicales, op. 9: II. Canzonetta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2061 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de98d7b6-9ce8-4076-8134-bd077ad2bc00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tirolese', part.name_en = 'Soirées musicales, op. 9: III. Tirolese',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2061 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e34cb9f0-5bb3-47a4-bd23-b6d958562f77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e34cb9f0-5bb3-47a4-bd23-b6d958562f77', 3, 'III', 'Tirolese', 'Soirées musicales, op. 9: III. Tirolese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2061 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e34cb9f0-5bb3-47a4-bd23-b6d958562f77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Bolero', part.name_en = 'Soirées musicales, op. 9: IV. Bolero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2061 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:32b81b17-4b63-4f82-920c-d08978f56923' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32b81b17-4b63-4f82-920c-d08978f56923', 4, 'IV', 'Bolero', 'Soirées musicales, op. 9: IV. Bolero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2061 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b81b17-4b63-4f82-920c-d08978f56923'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tarantella', part.name_en = 'Soirées musicales, op. 9: V. Tarantella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2061 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c127f2bb-aa26-4153-97ac-3dfa992c1a6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c127f2bb-aa26-4153-97ac-3dfa992c1a6d', 5, 'V', 'Tarantella', 'Soirées musicales, op. 9: V. Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2061 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c127f2bb-aa26-4153-97ac-3dfa992c1a6d'
);


-- None 가곡 <Somnus>

UPDATE pieces piece
SET piece.title = '가곡 <Somnus>', piece.title_en = 'Somnus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1205 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Sonatina romantica

UPDATE pieces piece
SET piece.title = 'Sonatina romantica', piece.title_en = 'Sonatina romantica',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1485 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Sonatina romantica: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1485 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:08071fc7-5133-4035-8cf2-6f47586ef36d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08071fc7-5133-4035-8cf2-6f47586ef36d', 1, 'I', 'Moderato', 'Sonatina romantica: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1485 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08071fc7-5133-4035-8cf2-6f47586ef36d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne', part.name_en = 'Sonatina romantica: II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1485 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3b5550af-f9a0-4031-ad18-fc10531c9a5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b5550af-f9a0-4031-ad18-fc10531c9a5e', 2, 'II', 'Nocturne', 'Sonatina romantica: II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1485 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b5550af-f9a0-4031-ad18-fc10531c9a5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Burlesque', part.name_en = 'Sonatina romantica: III. Burlesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1485 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6fe581a8-55ca-463d-9923-a9b04ce0eab2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fe581a8-55ca-463d-9923-a9b04ce0eab2', 3, 'III', 'Burlesque', 'Sonatina romantica: III. Burlesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1485 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fe581a8-55ca-463d-9923-a9b04ce0eab2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Toccata', part.name_en = 'Sonatina romantica: IV. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1485 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:82eca6d3-89b7-4a60-95c8-76b7d2b3ea6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82eca6d3-89b7-4a60-95c8-76b7d2b3ea6a', 4, 'IV', 'Toccata', 'Sonatina romantica: IV. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1485 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82eca6d3-89b7-4a60-95c8-76b7d2b3ea6a'
);


-- Op. 74 연가곡집 <Songs and Proverbs of William Blake> Op. 74

UPDATE pieces piece
SET piece.title = '연가곡집 <Songs and Proverbs of William Blake> Op. 74', piece.title_en = 'Songs and Proverbs of William Blake, op. 74',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '74',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1227 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The pride of the peacock...London', part.name_en = 'Songs and Proverbs of William Blake, op. 74: The pride of the peacock...London',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1227 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:465c505f-1816-3a90-8769-1bb46afdca7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:465c505f-1816-3a90-8769-1bb46afdca7a', 1, NULL, 'The pride of the peacock...London', 'Songs and Proverbs of William Blake, op. 74: The pride of the peacock...London', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1227 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:465c505f-1816-3a90-8769-1bb46afdca7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prisons are built... The Chimney sweeper', part.name_en = 'Songs and Proverbs of William Blake, op. 74: Prisons are built... The Chimney sweeper',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1227 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7e03ac59-aa6b-359d-844a-2af451ef018d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e03ac59-aa6b-359d-844a-2af451ef018d', 2, NULL, 'Prisons are built... The Chimney sweeper', 'Songs and Proverbs of William Blake, op. 74: Prisons are built... The Chimney sweeper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1227 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e03ac59-aa6b-359d-844a-2af451ef018d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The bird a nest... A poison tree', part.name_en = 'Songs and Proverbs of William Blake, op. 74: The bird a nest... A poison tree',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1227 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:efcb600d-2b51-36b6-a900-3a85844ccc33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efcb600d-2b51-36b6-a900-3a85844ccc33', 3, NULL, 'The bird a nest... A poison tree', 'Songs and Proverbs of William Blake, op. 74: The bird a nest... A poison tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1227 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efcb600d-2b51-36b6-a900-3a85844ccc33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Think in the morning... The Tyger', part.name_en = 'Songs and Proverbs of William Blake, op. 74: Think in the morning... The Tyger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1227 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:74619753-0c5c-365e-895a-82a804d0a5a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74619753-0c5c-365e-895a-82a804d0a5a7', 4, NULL, 'Think in the morning... The Tyger', 'Songs and Proverbs of William Blake, op. 74: Think in the morning... The Tyger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1227 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74619753-0c5c-365e-895a-82a804d0a5a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The tygers of wrath... The Fly', part.name_en = 'Songs and Proverbs of William Blake, op. 74: The tygers of wrath... The Fly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1227 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8f8eac41-a06b-379c-8dd9-834bc92f8c09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f8eac41-a06b-379c-8dd9-834bc92f8c09', 5, NULL, 'The tygers of wrath... The Fly', 'Songs and Proverbs of William Blake, op. 74: The tygers of wrath... The Fly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1227 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f8eac41-a06b-379c-8dd9-834bc92f8c09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The hours of folly... Ah, Sun-flower', part.name_en = 'Songs and Proverbs of William Blake, op. 74: The hours of folly... Ah, Sun-flower',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1227 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:477fd3b9-43f6-33e4-8bf9-4e313de6945b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:477fd3b9-43f6-33e4-8bf9-4e313de6945b', 6, NULL, 'The hours of folly... Ah, Sun-flower', 'Songs and Proverbs of William Blake, op. 74: The hours of folly... Ah, Sun-flower', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1227 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:477fd3b9-43f6-33e4-8bf9-4e313de6945b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'To see a World... Every night & every morn', part.name_en = 'Songs and Proverbs of William Blake, op. 74: To see a World... Every night & every morn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1227 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c1a7eeea-d2f1-3042-a2cb-1fddaedd0880' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1a7eeea-d2f1-3042-a2cb-1fddaedd0880', 7, NULL, 'To see a World... Every night & every morn', 'Songs and Proverbs of William Blake, op. 74: To see a World... Every night & every morn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1227 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1a7eeea-d2f1-3042-a2cb-1fddaedd0880'
);


-- Op. 58 Songs from the Chinese Op. 58

UPDATE pieces piece
SET piece.title = 'Songs from the Chinese Op. 58', piece.title_en = 'Songs from the Chinese, op. 58',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '58',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2097 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I: The Big Chariot', part.name_en = 'Songs from the Chinese, op. 58: I: The Big Chariot',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2097 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6bef65d9-94ee-4fff-b8b5-80ec4cef2ba1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bef65d9-94ee-4fff-b8b5-80ec4cef2ba1', 1, NULL, 'I: The Big Chariot', 'Songs from the Chinese, op. 58: I: The Big Chariot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2097 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bef65d9-94ee-4fff-b8b5-80ec4cef2ba1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Old Lute', part.name_en = 'Songs from the Chinese, op. 58: II. The Old Lute',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2097 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:dc9318f8-d6eb-4af3-a5e8-e5f00d6509e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc9318f8-d6eb-4af3-a5e8-e5f00d6509e7', 2, NULL, 'The Old Lute', 'Songs from the Chinese, op. 58: II. The Old Lute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2097 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc9318f8-d6eb-4af3-a5e8-e5f00d6509e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Autumn Wind', part.name_en = 'Songs from the Chinese, op. 58: III. The Autumn Wind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2097 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:60874e48-e23b-42e2-bf0c-541625eeaac5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60874e48-e23b-42e2-bf0c-541625eeaac5', 3, NULL, 'The Autumn Wind', 'Songs from the Chinese, op. 58: III. The Autumn Wind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2097 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60874e48-e23b-42e2-bf0c-541625eeaac5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Herd-Boy', part.name_en = 'Songs from the Chinese, op. 58: IV. The Herd-Boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2097 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:1e3706f9-d89c-4a79-b09c-c40c3e094777' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e3706f9-d89c-4a79-b09c-c40c3e094777', 4, NULL, 'The Herd-Boy', 'Songs from the Chinese, op. 58: IV. The Herd-Boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2097 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e3706f9-d89c-4a79-b09c-c40c3e094777'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Depression', part.name_en = 'Songs from the Chinese, op. 58: V. Depression',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2097 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b37c2633-3a70-4c79-9694-e12d52f5c718' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b37c2633-3a70-4c79-9694-e12d52f5c718', 5, NULL, 'Depression', 'Songs from the Chinese, op. 58: V. Depression', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2097 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b37c2633-3a70-4c79-9694-e12d52f5c718'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dance Song', part.name_en = 'Songs from the Chinese, op. 58: VI. Dance Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2097 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:61629806-2011-45f1-b126-cc32ee6d2220' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61629806-2011-45f1-b126-cc32ee6d2220', 6, NULL, 'Dance Song', 'Songs from the Chinese, op. 58: VI. Dance Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2097 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61629806-2011-45f1-b126-cc32ee6d2220'
);


-- Op. 44 Spring Symphony Op. 44

UPDATE pieces piece
SET piece.title = 'Spring Symphony Op. 44', piece.title_en = 'Spring Symphony, op. 44',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '44',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2653 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part 1', part.name_en = 'Spring Symphony, op. 44: Part 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9', 1, NULL, 'Part 1', 'Spring Symphony, op. 44: Part 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction: Shine Out', part.name_en = 'Spring Symphony, op. 44: Part 1: 1. Introduction: Shine Out',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a134c509-f698-4770-9862-48f2a57ec076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a134c509-f698-4770-9862-48f2a57ec076', 1, NULL, 'Introduction: Shine Out', 'Spring Symphony, op. 44: Part 1: 1. Introduction: Shine Out', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a134c509-f698-4770-9862-48f2a57ec076'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Merry Cuckoo', part.name_en = 'Spring Symphony, op. 44: Part 1: 2. The Merry Cuckoo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e6f9e696-b833-4155-b91c-64ee3961fe77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6f9e696-b833-4155-b91c-64ee3961fe77', 2, NULL, 'The Merry Cuckoo', 'Spring Symphony, op. 44: Part 1: 2. The Merry Cuckoo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6f9e696-b833-4155-b91c-64ee3961fe77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Driving Boy', part.name_en = 'Spring Symphony, op. 44: Part 1: 4. The Driving Boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:073e8775-039a-49c5-88b4-a7d74f3b0c98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:073e8775-039a-49c5-88b4-a7d74f3b0c98', 3, NULL, 'The Driving Boy', 'Spring Symphony, op. 44: Part 1: 4. The Driving Boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:073e8775-039a-49c5-88b4-a7d74f3b0c98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'The Morning Star', part.name_en = 'Spring Symphony, op. 44: Part 1: 5. The Morning Star',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6ce5bef4-7edf-44d1-ba13-6f01c1591b0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ce5bef4-7edf-44d1-ba13-6f01c1591b0b', 4, NULL, 'The Morning Star', 'Spring Symphony, op. 44: Part 1: 5. The Morning Star', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f1b42b10-7654-4ec1-aae5-037219a1ecf9'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ce5bef4-7edf-44d1-ba13-6f01c1591b0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Part 2', part.name_en = 'Spring Symphony, op. 44: Part 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735', 2, NULL, 'Part 2', 'Spring Symphony, op. 44: Part 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Waters Above!', part.name_en = 'Spring Symphony, op. 44: Part 2: 7. Waters Above!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:18e164a8-5f55-4601-89c0-d6892e88bfbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18e164a8-5f55-4601-89c0-d6892e88bfbf', 1, NULL, 'Waters Above!', 'Spring Symphony, op. 44: Part 2: 7. Waters Above!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18e164a8-5f55-4601-89c0-d6892e88bfbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Out on the lawn I Lie in bed', part.name_en = 'Spring Symphony, op. 44: Part 2: 8. Out on the lawn I Lie in bed',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9c15162b-a5fc-4f69-b459-7960737ca8eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c15162b-a5fc-4f69-b459-7960737ca8eb', 2, NULL, 'Out on the lawn I Lie in bed', 'Spring Symphony, op. 44: Part 2: 8. Out on the lawn I Lie in bed', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c15162b-a5fc-4f69-b459-7960737ca8eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Welcome, Maids of Honour', part.name_en = 'Spring Symphony, op. 44: Part 2: 6. Welcome, Maids of Honour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c9122f50-769a-43aa-b79d-d037409d4993' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9122f50-769a-43aa-b79d-d037409d4993', 3, NULL, 'Welcome, Maids of Honour', 'Spring Symphony, op. 44: Part 2: 6. Welcome, Maids of Honour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d0886e9a-ad1a-479d-891e-7c6188a48735'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9122f50-769a-43aa-b79d-d037409d4993'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Part 3', part.name_en = 'Spring Symphony, op. 44: Part 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398', 3, NULL, 'Part 3', 'Spring Symphony, op. 44: Part 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'When will my May Come?', part.name_en = 'Spring Symphony, op. 44: Part 3: 9. When will my May Come?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:50911c11-e247-4167-a15b-edcabe9730e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50911c11-e247-4167-a15b-edcabe9730e3', 1, NULL, 'When will my May Come?', 'Spring Symphony, op. 44: Part 3: 9. When will my May Come?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50911c11-e247-4167-a15b-edcabe9730e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fair and Fair', part.name_en = 'Spring Symphony, op. 44: Part 3: 10. Fair and Fair',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:250325f7-cf95-4bde-b310-dc13617241b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:250325f7-cf95-4bde-b310-dc13617241b2', 2, NULL, 'Fair and Fair', 'Spring Symphony, op. 44: Part 3: 10. Fair and Fair', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:250325f7-cf95-4bde-b310-dc13617241b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sound the Flute!', part.name_en = 'Spring Symphony, op. 44: Part 3: 11. Sound the Flute!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:135770af-a887-4271-b629-e58d8952019d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:135770af-a887-4271-b629-e58d8952019d', 3, NULL, 'Sound the Flute!', 'Spring Symphony, op. 44: Part 3: 11. Sound the Flute!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7928db4a-ff87-4d46-9804-f74f6a046398'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:135770af-a887-4271-b629-e58d8952019d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Part 4', part.name_en = 'Spring Symphony, op. 44: Part 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:78e9a3b5-c68b-49ab-958b-1f37e7e65670' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e9a3b5-c68b-49ab-958b-1f37e7e65670', 4, NULL, 'Part 4', 'Spring Symphony, op. 44: Part 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e9a3b5-c68b-49ab-958b-1f37e7e65670'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78e9a3b5-c68b-49ab-958b-1f37e7e65670'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Finale: London, to Thee I do Present', part.name_en = 'Spring Symphony, op. 44: Part 4: 12. Finale: London, to Thee I do Present',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2653 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:426be19a-b143-4b3d-859c-918f14015ab6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:426be19a-b143-4b3d-859c-918f14015ab6', 1, NULL, 'Finale: London, to Thee I do Present', 'Spring Symphony, op. 44: Part 4: 12. Finale: London, to Thee I do Present', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78e9a3b5-c68b-49ab-958b-1f37e7e65670'
WHERE p.id = 2653 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:426be19a-b143-4b3d-859c-918f14015ab6'
);


-- Op. 42 칸타타 <St. Nicolas>

UPDATE pieces piece
SET piece.title = '칸타타 <St. Nicolas>', piece.title_en = 'St. Nicolas, op. 42',
    piece.type = 'album', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2638 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction', part.name_en = 'St. Nicolas, op. 42: I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9f8296a6-2051-4cb2-b6f6-698d0bd01afd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f8296a6-2051-4cb2-b6f6-698d0bd01afd', 1, 'I', 'Introduction', 'St. Nicolas, op. 42: I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f8296a6-2051-4cb2-b6f6-698d0bd01afd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Birth of Nicolas', part.name_en = 'St. Nicolas, op. 42: II. The Birth of Nicolas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9c034d7e-7dba-417d-873f-6d08e814973a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c034d7e-7dba-417d-873f-6d08e814973a', 2, 'II', 'The Birth of Nicolas', 'St. Nicolas, op. 42: II. The Birth of Nicolas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c034d7e-7dba-417d-873f-6d08e814973a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nicolas devotes himself to God', part.name_en = 'St. Nicolas, op. 42: III. Nicolas devotes himself to God',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d93e4481-b635-45e0-9783-75fc7318530c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d93e4481-b635-45e0-9783-75fc7318530c', 3, 'III', 'Nicolas devotes himself to God', 'St. Nicolas, op. 42: III. Nicolas devotes himself to God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d93e4481-b635-45e0-9783-75fc7318530c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'He journeys to Palestine', part.name_en = 'St. Nicolas, op. 42: IV. He journeys to Palestine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:847df3f8-db70-4fde-a228-b9f4c630cb41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:847df3f8-db70-4fde-a228-b9f4c630cb41', 4, 'IV', 'He journeys to Palestine', 'St. Nicolas, op. 42: IV. He journeys to Palestine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:847df3f8-db70-4fde-a228-b9f4c630cb41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'He comes to Myra and is chosen Bishop', part.name_en = 'St. Nicolas, op. 42: V. He comes to Myra and is chosen Bishop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ccc46425-4198-499b-8ae1-08ed98e42bba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccc46425-4198-499b-8ae1-08ed98e42bba', 5, 'V', 'He comes to Myra and is chosen Bishop', 'St. Nicolas, op. 42: V. He comes to Myra and is chosen Bishop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccc46425-4198-499b-8ae1-08ed98e42bba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Nicolas from prison', part.name_en = 'St. Nicolas, op. 42: VI. Nicolas from prison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6d9b8b53-7e37-4127-9b23-3dc92aa50232' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d9b8b53-7e37-4127-9b23-3dc92aa50232', 6, 'VI', 'Nicolas from prison', 'St. Nicolas, op. 42: VI. Nicolas from prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d9b8b53-7e37-4127-9b23-3dc92aa50232'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Nicolas and the pickled boys', part.name_en = 'St. Nicolas, op. 42: VII. Nicolas and the pickled boys',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:72bb6f04-2179-4799-81a3-149a6daceb72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72bb6f04-2179-4799-81a3-149a6daceb72', 7, 'VII', 'Nicolas and the pickled boys', 'St. Nicolas, op. 42: VII. Nicolas and the pickled boys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72bb6f04-2179-4799-81a3-149a6daceb72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'His piety and marvellous works', part.name_en = 'St. Nicolas, op. 42: VIII. His piety and marvellous works',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d32978f2-9bd9-44d8-958d-f2ef3f9f1335' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d32978f2-9bd9-44d8-958d-f2ef3f9f1335', 8, 'VIII', 'His piety and marvellous works', 'St. Nicolas, op. 42: VIII. His piety and marvellous works', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d32978f2-9bd9-44d8-958d-f2ef3f9f1335'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'The death of Nicolas', part.name_en = 'St. Nicolas, op. 42: IX. The death of Nicolas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2638 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:289ae390-237b-4cc9-bbc3-8c5e417bb7b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:289ae390-237b-4cc9-bbc3-8c5e417bb7b2', 9, 'IX', 'The death of Nicolas', 'St. Nicolas, op. 42: IX. The death of Nicolas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2638 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:289ae390-237b-4cc9-bbc3-8c5e417bb7b2'
);


-- None 현악 4중주 D장조

UPDATE pieces piece
SET piece.title = '현악 4중주 D장조', piece.title_en = 'String Quartet in D major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2403 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso', part.name_en = 'String Quartet in D major: I. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2403 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:30b41e37-4ba9-4236-b056-1111bf22059c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30b41e37-4ba9-4236-b056-1111bf22059c', 1, 'I', 'Allegro maestoso', 'String Quartet in D major: I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2403 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b41e37-4ba9-4236-b056-1111bf22059c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento ed espressivo', part.name_en = 'String Quartet in D major: II. Lento ed espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2403 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:58d90f14-3a7f-4479-8776-b752de96ca63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58d90f14-3a7f-4479-8776-b752de96ca63', 2, 'II', 'Lento ed espressivo', 'String Quartet in D major: II. Lento ed espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2403 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58d90f14-3a7f-4479-8776-b752de96ca63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro giocoso', part.name_en = 'String Quartet in D major: III. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2403 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9c869784-1ce6-4d84-b3a5-67e1c4fd558a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c869784-1ce6-4d84-b3a5-67e1c4fd558a', 3, 'III', 'Allegro giocoso', 'String Quartet in D major: III. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2403 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c869784-1ce6-4d84-b3a5-67e1c4fd558a'
);


-- None 현악 4중주 F F장조

UPDATE pieces piece
SET piece.title = '현악 4중주 F F장조', piece.title_en = 'String Quartet in F',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2210 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace e con brio', part.name_en = 'String Quartet in F: I. Allegro vivace e con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2210 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5669b401-35e7-41fb-b289-02975acd249d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5669b401-35e7-41fb-b289-02975acd249d', 1, 'I', 'Allegro vivace e con brio', 'String Quartet in F: I. Allegro vivace e con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2210 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5669b401-35e7-41fb-b289-02975acd249d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'String Quartet in F: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2210 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3def44b9-8d8d-495b-8227-d881a4817959' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3def44b9-8d8d-495b-8227-d881a4817959', 2, 'II', 'Andante', 'String Quartet in F: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2210 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3def44b9-8d8d-495b-8227-d881a4817959'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivace', part.name_en = 'String Quartet in F: III. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2210 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fa61cfdb-16a3-4193-adb4-51b5790aa191' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa61cfdb-16a3-4193-adb4-51b5790aa191', 3, 'III', 'Allegro vivace', 'String Quartet in F: III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2210 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa61cfdb-16a3-4193-adb4-51b5790aa191'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto', part.name_en = 'String Quartet in F: IV. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2210 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:81ef5d65-1030-4f73-b0bb-a6237094b670' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81ef5d65-1030-4f73-b0bb-a6237094b670', 4, 'IV', 'Allegro molto', 'String Quartet in F: IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2210 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ef5d65-1030-4f73-b0bb-a6237094b670'
);


-- Op. 25 현악 4중주 1번 D장조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 D장조', piece.title_en = 'String Quartet no. 1 in D major, op. 25',
    piece.type = 'album', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2884 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante sostenuto', part.name_en = 'String Quartet no. 1 in D major, op. 25: I. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2884 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:767ea529-56b7-4904-884d-d660e12f24f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:767ea529-56b7-4904-884d-d660e12f24f1', 1, 'I', 'Andante sostenuto', 'String Quartet no. 1 in D major, op. 25: I. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2884 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:767ea529-56b7-4904-884d-d660e12f24f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto con slancio', part.name_en = 'String Quartet no. 1 in D major, op. 25: II. Allegretto con slancio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2884 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4647baa0-84a8-424f-9ea7-d1031b0dd5d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4647baa0-84a8-424f-9ea7-d1031b0dd5d6', 2, 'II', 'Allegretto con slancio', 'String Quartet no. 1 in D major, op. 25: II. Allegretto con slancio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2884 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4647baa0-84a8-424f-9ea7-d1031b0dd5d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante calmo', part.name_en = 'String Quartet no. 1 in D major, op. 25: III. Andante calmo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2884 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:aef4c9f7-6df0-4d5e-a875-2f622bc6b476' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aef4c9f7-6df0-4d5e-a875-2f622bc6b476', 3, 'III', 'Andante calmo', 'String Quartet no. 1 in D major, op. 25: III. Andante calmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2884 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aef4c9f7-6df0-4d5e-a875-2f622bc6b476'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Molto vivace', part.name_en = 'String Quartet no. 1 in D major, op. 25: IV. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2884 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cbbbd059-3430-4cb1-a6c9-76441fe568bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbbbd059-3430-4cb1-a6c9-76441fe568bc', 4, 'IV', 'Molto vivace', 'String Quartet no. 1 in D major, op. 25: IV. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2884 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbbbd059-3430-4cb1-a6c9-76441fe568bc'
);


-- Op. 36 현악 4중주 2번 C장조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 C장조', piece.title_en = 'String Quartet no. 2 in C major, op. 36',
    piece.type = 'album', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1310 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro calmo senza rigore', part.name_en = 'String Quartet no. 2 in C major, op. 36: I. Allegro calmo senza rigore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1310 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:872a5df1-d349-38d6-911b-f6f39d6fd7eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:872a5df1-d349-38d6-911b-f6f39d6fd7eb', 1, 'I', 'Allegro calmo senza rigore', 'String Quartet no. 2 in C major, op. 36: I. Allegro calmo senza rigore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1310 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:872a5df1-d349-38d6-911b-f6f39d6fd7eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace', part.name_en = 'String Quartet no. 2 in C major, op. 36: II. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1310 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:faffe76f-0838-3cd4-b8ac-b5a92252f838' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faffe76f-0838-3cd4-b8ac-b5a92252f838', 2, 'II', 'Vivace', 'String Quartet no. 2 in C major, op. 36: II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1310 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faffe76f-0838-3cd4-b8ac-b5a92252f838'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chacony', part.name_en = 'String Quartet no. 2 in C major, op. 36: III. Chacony',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1310 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ec6a3ace-a938-3925-b114-1253c947c9d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec6a3ace-a938-3925-b114-1253c947c9d5', 3, 'III', 'Chacony', 'String Quartet no. 2 in C major, op. 36: III. Chacony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1310 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec6a3ace-a938-3925-b114-1253c947c9d5'
);


-- Op. 94 현악 4중주 3번

UPDATE pieces piece
SET piece.title = '현악 4중주 3번', piece.title_en = 'String Quartet no. 3, op. 94',
    piece.type = 'album', piece.opus_number = 'Op. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1216 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Duets: With Moderate Movement', part.name_en = 'String Quartet no. 3, op. 94: I. Duets: With Moderate Movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1216 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9763fe2d-7d1d-305c-814c-401ad2a9a398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9763fe2d-7d1d-305c-814c-401ad2a9a398', 1, 'I', 'Duets: With Moderate Movement', 'String Quartet no. 3, op. 94: I. Duets: With Moderate Movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1216 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9763fe2d-7d1d-305c-814c-401ad2a9a398'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ostinato: Very Fast', part.name_en = 'String Quartet no. 3, op. 94: II. Ostinato: Very Fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1216 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ffe1bf5a-85be-3423-843f-cde9b369e63d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffe1bf5a-85be-3423-843f-cde9b369e63d', 2, 'II', 'Ostinato: Very Fast', 'String Quartet no. 3, op. 94: II. Ostinato: Very Fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1216 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffe1bf5a-85be-3423-843f-cde9b369e63d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Solo: Very Calm', part.name_en = 'String Quartet no. 3, op. 94: III. Solo: Very Calm',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1216 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:97391803-0c3a-3880-ad41-b6a219dbe7ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97391803-0c3a-3880-ad41-b6a219dbe7ac', 3, 'III', 'Solo: Very Calm', 'String Quartet no. 3, op. 94: III. Solo: Very Calm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1216 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97391803-0c3a-3880-ad41-b6a219dbe7ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Burlesque: Fast – con fuoco', part.name_en = 'String Quartet no. 3, op. 94: IV. Burlesque: Fast – con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1216 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:00680193-608c-3a25-aed9-ce48202ccf9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00680193-608c-3a25-aed9-ce48202ccf9c', 4, 'IV', 'Burlesque: Fast – con fuoco', 'String Quartet no. 3, op. 94: IV. Burlesque: Fast – con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1216 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00680193-608c-3a25-aed9-ce48202ccf9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Recitative and Passacaglia (La serenissima)', part.name_en = 'String Quartet no. 3, op. 94: V. Recitative and Passacaglia (La serenissima)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1216 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:31c547bc-af71-36f5-9229-afb50e4c057c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31c547bc-af71-36f5-9229-afb50e4c057c', 5, 'V', 'Recitative and Passacaglia (La serenissima)', 'String Quartet no. 3, op. 94: V. Recitative and Passacaglia (La serenissima)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1216 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31c547bc-af71-36f5-9229-afb50e4c057c'
);


-- Op. 83 Suite for Harp Solo

UPDATE pieces piece
SET piece.title = 'Suite for Harp Solo', piece.title_en = 'Suite for Harp Solo, op. 83',
    piece.type = 'album', piece.opus_number = 'Op. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2272 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Overture - Majestic', part.name_en = 'Suite for Harp Solo, op. 83: I. Overture - Majestic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2272 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:445b5aec-5e59-45f4-94f9-fbb1f296c9f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:445b5aec-5e59-45f4-94f9-fbb1f296c9f3', 1, 'I', 'Overture - Majestic', 'Suite for Harp Solo, op. 83: I. Overture - Majestic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2272 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:445b5aec-5e59-45f4-94f9-fbb1f296c9f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Toccata - Fast and gay', part.name_en = 'Suite for Harp Solo, op. 83: II. Toccata - Fast and gay',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2272 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9e43f421-691e-4dd4-9bc5-c8ad413a5a32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e43f421-691e-4dd4-9bc5-c8ad413a5a32', 2, 'II', 'Toccata - Fast and gay', 'Suite for Harp Solo, op. 83: II. Toccata - Fast and gay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2272 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e43f421-691e-4dd4-9bc5-c8ad413a5a32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Nocturne - Slow and quiet', part.name_en = 'Suite for Harp Solo, op. 83: III. Nocturne - Slow and quiet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2272 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:df5a97c9-a6ed-4c07-bbe6-a0da6af3cce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df5a97c9-a6ed-4c07-bbe6-a0da6af3cce9', 3, 'III', 'Nocturne - Slow and quiet', 'Suite for Harp Solo, op. 83: III. Nocturne - Slow and quiet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2272 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df5a97c9-a6ed-4c07-bbe6-a0da6af3cce9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fugue - Lively', part.name_en = 'Suite for Harp Solo, op. 83: IV. Fugue - Lively',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2272 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0efe20ba-1f38-4a5c-a642-7a320b064028' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0efe20ba-1f38-4a5c-a642-7a320b064028', 4, 'IV', 'Fugue - Lively', 'Suite for Harp Solo, op. 83: IV. Fugue - Lively', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2272 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0efe20ba-1f38-4a5c-a642-7a320b064028'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Hymn (St. Denio) - Slow and solemn', part.name_en = 'Suite for Harp Solo, op. 83: V. Hymn (St. Denio) - Slow and solemn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2272 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9084e000-2063-4c1e-bcb6-ef7360e9fa10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9084e000-2063-4c1e-bcb6-ef7360e9fa10', 5, 'V', 'Hymn (St. Denio) - Slow and solemn', 'Suite for Harp Solo, op. 83: V. Hymn (St. Denio) - Slow and solemn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2272 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9084e000-2063-4c1e-bcb6-ef7360e9fa10'
);


-- Op. 6 바이올린과 피아노를 위한 모음곡 Op. 6

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 모음곡 Op. 6', piece.title_en = 'Suite for Violin and Piano, op. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '6',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1163 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Introduction -', part.name_en = 'Suite for Violin and Piano, op. 6: Introduction -',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1163 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5f59c4fc-1b5b-4288-b6c8-9e345a2e93dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f59c4fc-1b5b-4288-b6c8-9e345a2e93dc', 1, NULL, 'Introduction -', 'Suite for Violin and Piano, op. 6: Introduction -', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1163 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f59c4fc-1b5b-4288-b6c8-9e345a2e93dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'March', part.name_en = 'Suite for Violin and Piano, op. 6: I. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1163 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:439932e2-c285-4379-9507-50e8f97af3f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:439932e2-c285-4379-9507-50e8f97af3f1', 2, NULL, 'March', 'Suite for Violin and Piano, op. 6: I. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1163 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:439932e2-c285-4379-9507-50e8f97af3f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Moto perpetuo', part.name_en = 'Suite for Violin and Piano, op. 6: II. Moto perpetuo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1163 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:09cc04e2-6688-40e7-9e1a-5915fd023981' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09cc04e2-6688-40e7-9e1a-5915fd023981', 3, NULL, 'Moto perpetuo', 'Suite for Violin and Piano, op. 6: II. Moto perpetuo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1163 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09cc04e2-6688-40e7-9e1a-5915fd023981'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lullaby', part.name_en = 'Suite for Violin and Piano, op. 6: III. Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1163 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:181cb011-b71e-41ae-99fc-3bd39009c529' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:181cb011-b71e-41ae-99fc-3bd39009c529', 4, NULL, 'Lullaby', 'Suite for Violin and Piano, op. 6: III. Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1163 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:181cb011-b71e-41ae-99fc-3bd39009c529'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Waltz', part.name_en = 'Suite for Violin and Piano, op. 6: IV. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1163 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f2d5181b-a9b5-4a5f-9ead-ec8b1b39f880' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2d5181b-a9b5-4a5f-9ead-ec8b1b39f880', 5, NULL, 'Waltz', 'Suite for Violin and Piano, op. 6: IV. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1163 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2d5181b-a9b5-4a5f-9ead-ec8b1b39f880'
);


-- Op. 68 Symphony for Cello and Orchestra

UPDATE pieces piece
SET piece.title = 'Symphony for Cello and Orchestra', piece.title_en = 'Symphony for Cello and Orchestra, op. 68',
    piece.type = 'album', piece.opus_number = 'Op. 68',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1197 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso', part.name_en = 'Symphony for Cello and Orchestra, op. 68: I. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1197 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cfc3f9d0-b575-4697-b15e-bc6cbc91d93d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfc3f9d0-b575-4697-b15e-bc6cbc91d93d', 1, 'I', 'Allegro maestoso', 'Symphony for Cello and Orchestra, op. 68: I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1197 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfc3f9d0-b575-4697-b15e-bc6cbc91d93d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto inquieto', part.name_en = 'Symphony for Cello and Orchestra, op. 68: II. Presto inquieto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1197 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:53917593-182a-4120-a256-13e269177fa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53917593-182a-4120-a256-13e269177fa8', 2, 'II', 'Presto inquieto', 'Symphony for Cello and Orchestra, op. 68: II. Presto inquieto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1197 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53917593-182a-4120-a256-13e269177fa8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio – Cadenza ad lib', part.name_en = 'Symphony for Cello and Orchestra, op. 68: III. Adagio – Cadenza ad lib',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1197 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6011cbb1-ee28-4a55-9f02-8cc61d4f5610' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6011cbb1-ee28-4a55-9f02-8cc61d4f5610', 3, 'III', 'Adagio – Cadenza ad lib', 'Symphony for Cello and Orchestra, op. 68: III. Adagio – Cadenza ad lib', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1197 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6011cbb1-ee28-4a55-9f02-8cc61d4f5610'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Passacaglia. Andante allegro', part.name_en = 'Symphony for Cello and Orchestra, op. 68: IV. Passacaglia. Andante allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1197 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:76e48d82-d2c5-445e-a3a3-0b060a728571' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76e48d82-d2c5-445e-a3a3-0b060a728571', 4, 'IV', 'Passacaglia. Andante allegro', 'Symphony for Cello and Orchestra, op. 68: IV. Passacaglia. Andante allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1197 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76e48d82-d2c5-445e-a3a3-0b060a728571'
);


-- None 테 데움 C장조

UPDATE pieces piece
SET piece.title = '테 데움 C장조', piece.title_en = 'Te Deum in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1863 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tema "Sacher"

UPDATE pieces piece
SET piece.title = 'Tema "Sacher"', piece.title_en = 'Tema "Sacher"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1782 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Temporal Variations for Oboe and Piano, op. posth.

UPDATE pieces piece
SET piece.title = 'Temporal Variations for Oboe and Piano, op. posth.', piece.title_en = 'Temporal Variations for Oboe and Piano, op. posth.',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1731 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Theme: Andante rubato', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: I. Theme: Andante rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e8f0a7ec-dba3-4645-bb76-8f2d95a15ca5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8f0a7ec-dba3-4645-bb76-8f2d95a15ca5', 1, 'I', 'Theme: Andante rubato', 'Temporal Variations for Oboe and Piano, op. posth.: I. Theme: Andante rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8f0a7ec-dba3-4645-bb76-8f2d95a15ca5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Oration: Lento quasi recitativo', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: II. Oration: Lento quasi recitativo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:84493a26-7f38-4bab-ba26-d945a0b2afba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84493a26-7f38-4bab-ba26-d945a0b2afba', 2, 'II', 'Oration: Lento quasi recitativo', 'Temporal Variations for Oboe and Piano, op. posth.: II. Oration: Lento quasi recitativo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84493a26-7f38-4bab-ba26-d945a0b2afba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'March: Alla marcia', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: III. March: Alla marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fb2a4566-20cb-4362-a314-e75bec6afa6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb2a4566-20cb-4362-a314-e75bec6afa6e', 3, 'III', 'March: Alla marcia', 'Temporal Variations for Oboe and Piano, op. posth.: III. March: Alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb2a4566-20cb-4362-a314-e75bec6afa6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Exercises: Allegro molto e con fuoco', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: IV. Exercises: Allegro molto e con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:06ff2d2e-b796-4a70-b5ff-b3481ae9ba18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06ff2d2e-b796-4a70-b5ff-b3481ae9ba18', 4, 'IV', 'Exercises: Allegro molto e con fuoco', 'Temporal Variations for Oboe and Piano, op. posth.: IV. Exercises: Allegro molto e con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06ff2d2e-b796-4a70-b5ff-b3481ae9ba18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Commination: Adagio con fuoco', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: V. Commination: Adagio con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cc06b682-b9a3-4718-8142-06c09dffc3bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc06b682-b9a3-4718-8142-06c09dffc3bb', 5, 'V', 'Commination: Adagio con fuoco', 'Temporal Variations for Oboe and Piano, op. posth.: V. Commination: Adagio con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc06b682-b9a3-4718-8142-06c09dffc3bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Chorale: Molto lento', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: VI. Chorale: Molto lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:17c8f6f0-38d9-4281-8eef-a0272f330f3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17c8f6f0-38d9-4281-8eef-a0272f330f3c', 6, 'VI', 'Chorale: Molto lento', 'Temporal Variations for Oboe and Piano, op. posth.: VI. Chorale: Molto lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17c8f6f0-38d9-4281-8eef-a0272f330f3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Waltz: Allegretto rubato', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: VII. Waltz: Allegretto rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:37d98452-78cc-440a-ab2c-91e6702c5923' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37d98452-78cc-440a-ab2c-91e6702c5923', 7, 'VII', 'Waltz: Allegretto rubato', 'Temporal Variations for Oboe and Piano, op. posth.: VII. Waltz: Allegretto rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37d98452-78cc-440a-ab2c-91e6702c5923'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Polka: Tempo di polka - Allegro', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: VIII. Polka: Tempo di polka - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:29281d20-242b-4554-8a16-2a902d425259' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29281d20-242b-4554-8a16-2a902d425259', 8, 'VIII', 'Polka: Tempo di polka - Allegro', 'Temporal Variations for Oboe and Piano, op. posth.: VIII. Polka: Tempo di polka - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29281d20-242b-4554-8a16-2a902d425259'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Resolution: Maestoso (non troppo lento)', part.name_en = 'Temporal Variations for Oboe and Piano, op. posth.: IX. Resolution: Maestoso (non troppo lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1731 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ab9b6e2d-7ab8-445a-8bdc-1c5969070ac4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab9b6e2d-7ab8-445a-8bdc-1c5969070ac4', 9, 'IX', 'Resolution: Maestoso (non troppo lento)', 'Temporal Variations for Oboe and Piano, op. posth.: IX. Resolution: Maestoso (non troppo lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1731 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab9b6e2d-7ab8-445a-8bdc-1c5969070ac4'
);


-- None 부수음악 <The Ascent of F6>

UPDATE pieces piece
SET piece.title = '부수음악 <The Ascent of F6>', piece.title_en = 'The Ascent of F6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 887 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Entr''acte & Gunn''s Song. The Chimney Sweepers', part.name_en = 'The Ascent of F6: Entr''acte & Gunn''s Song. The Chimney Sweepers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0c156ca7-5263-412a-ae0c-aea9f82bf75c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c156ca7-5263-412a-ae0c-aea9f82bf75c', 1, NULL, 'Entr''acte & Gunn''s Song. The Chimney Sweepers', 'The Ascent of F6: Entr''acte & Gunn''s Song. The Chimney Sweepers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c156ca7-5263-412a-ae0c-aea9f82bf75c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Climbing Music', part.name_en = 'The Ascent of F6: Climbing Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0ed66db9-2493-4c0a-ba51-f849c251b606' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ed66db9-2493-4c0a-ba51-f849c251b606', 2, NULL, 'Climbing Music', 'The Ascent of F6: Climbing Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ed66db9-2493-4c0a-ba51-f849c251b606'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chorale. Free Now from Indignation', part.name_en = 'The Ascent of F6: Chorale. Free Now from Indignation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:216e79c7-7a69-47e9-972d-c9f04fe748b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:216e79c7-7a69-47e9-972d-c9f04fe748b9', 3, NULL, 'Chorale. Free Now from Indignation', 'The Ascent of F6: Chorale. Free Now from Indignation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:216e79c7-7a69-47e9-972d-c9f04fe748b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ransom. O Brothers', part.name_en = 'The Ascent of F6: Ransom. O Brothers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2914c35e-b3ac-44d3-9d7c-1c1d9ce38c2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2914c35e-b3ac-44d3-9d7c-1c1d9ce38c2d', 4, NULL, 'Ransom. O Brothers', 'The Ascent of F6: Ransom. O Brothers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2914c35e-b3ac-44d3-9d7c-1c1d9ce38c2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Prelude to Act II', part.name_en = 'The Ascent of F6: Prelude to Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:35cb042f-bf4c-4e2f-afbd-5e8dd3e67499' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35cb042f-bf4c-4e2f-afbd-5e8dd3e67499', 5, NULL, 'Prelude to Act II', 'The Ascent of F6: Prelude to Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35cb042f-bf4c-4e2f-afbd-5e8dd3e67499'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Chant', part.name_en = 'The Ascent of F6: Chant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3724d213-3e7d-4d84-9a27-9504d600691f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3724d213-3e7d-4d84-9a27-9504d600691f', 6, NULL, 'Chant', 'The Ascent of F6: Chant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3724d213-3e7d-4d84-9a27-9504d600691f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Mother''s Song. Michael, You shall be Renowned', part.name_en = 'The Ascent of F6: Mother''s Song. Michael, You shall be Renowned',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3a2d2b1b-5b79-4fcc-817f-54d37026b5af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a2d2b1b-5b79-4fcc-817f-54d37026b5af', 7, NULL, 'Mother''s Song. Michael, You shall be Renowned', 'The Ascent of F6: Mother''s Song. Michael, You shall be Renowned', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a2d2b1b-5b79-4fcc-817f-54d37026b5af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Funeral March & Chorus. No News', part.name_en = 'The Ascent of F6: Funeral March & Chorus. No News',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4f0fee92-901a-4cef-9180-c1556db539e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f0fee92-901a-4cef-9180-c1556db539e3', 8, NULL, 'Funeral March & Chorus. No News', 'The Ascent of F6: Funeral March & Chorus. No News', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f0fee92-901a-4cef-9180-c1556db539e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Overture', part.name_en = 'The Ascent of F6: Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:57ae775e-ba12-4113-b588-4fa86c02605e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57ae775e-ba12-4113-b588-4fa86c02605e', 9, NULL, 'Overture', 'The Ascent of F6: Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57ae775e-ba12-4113-b588-4fa86c02605e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Entr''actes For Mr. And Mrs. A', part.name_en = 'The Ascent of F6: Entr''actes For Mr. And Mrs. A.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5b08c3c8-f836-4de4-973e-5090df662150' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b08c3c8-f836-4de4-973e-5090df662150', 10, NULL, 'Entr''actes For Mr. And Mrs. A', 'The Ascent of F6: Entr''actes For Mr. And Mrs. A.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b08c3c8-f836-4de4-973e-5090df662150'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Mother''s Song with Chorus. Acts of Injustice Done', part.name_en = 'The Ascent of F6: Mother''s Song with Chorus. Acts of Injustice Done',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:67e412e9-1545-42d9-a67b-d58cca2dfaa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67e412e9-1545-42d9-a67b-d58cca2dfaa6', 11, NULL, 'Mother''s Song with Chorus. Acts of Injustice Done', 'The Ascent of F6: Mother''s Song with Chorus. Acts of Injustice Done', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67e412e9-1545-42d9-a67b-d58cca2dfaa6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Gunn''s Song. Some have Tennis-Elbow', part.name_en = 'The Ascent of F6: Gunn''s Song. Some have Tennis-Elbow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6d28d81e-9df3-449a-ac96-3cf1819b0c95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d28d81e-9df3-449a-ac96-3cf1819b0c95', 12, NULL, 'Gunn''s Song. Some have Tennis-Elbow', 'The Ascent of F6: Gunn''s Song. Some have Tennis-Elbow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d28d81e-9df3-449a-ac96-3cf1819b0c95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Blues. Stop all the Clocks', part.name_en = 'The Ascent of F6: Blues. Stop all the Clocks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:866b53e9-9024-443e-9ed3-124d6a21ffb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:866b53e9-9024-443e-9ed3-124d6a21ffb5', 13, NULL, 'Blues. Stop all the Clocks', 'The Ascent of F6: Blues. Stop all the Clocks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:866b53e9-9024-443e-9ed3-124d6a21ffb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Ransom. O Senseless Hurricanes', part.name_en = 'The Ascent of F6: Ransom. O Senseless Hurricanes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:88b547ae-d227-45c2-adf4-37e2d5cf23db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88b547ae-d227-45c2-adf4-37e2d5cf23db', 14, NULL, 'Ransom. O Senseless Hurricanes', 'The Ascent of F6: Ransom. O Senseless Hurricanes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88b547ae-d227-45c2-adf4-37e2d5cf23db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Cabaret Jazz Song. Forget the Dead', part.name_en = 'The Ascent of F6: Cabaret Jazz Song. Forget the Dead',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:aaa64684-0e90-4f97-97d7-c5a05b7b5521' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaa64684-0e90-4f97-97d7-c5a05b7b5521', 15, NULL, 'Cabaret Jazz Song. Forget the Dead', 'The Ascent of F6: Cabaret Jazz Song. Forget the Dead', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa64684-0e90-4f97-97d7-c5a05b7b5521'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Pantomime', part.name_en = 'The Ascent of F6: Pantomime',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:de62cc5c-5625-481a-b45f-234d8794e4bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de62cc5c-5625-481a-b45f-234d8794e4bc', 16, NULL, 'Pantomime', 'The Ascent of F6: Pantomime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de62cc5c-5625-481a-b45f-234d8794e4bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Climbing Music', part.name_en = 'The Ascent of F6: Climbing Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 887 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e9b95992-3fc3-4807-ad88-c4a8cf441246' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9b95992-3fc3-4807-ad88-c4a8cf441246', 17, NULL, 'Climbing Music', 'The Ascent of F6: Climbing Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 887 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9b95992-3fc3-4807-ad88-c4a8cf441246'
);


-- None The Ballad of Little Musgrave and Lady Barnard

UPDATE pieces piece
SET piece.title = 'The Ballad of Little Musgrave and Lady Barnard', piece.title_en = 'The Ballad of Little Musgrave and Lady Barnard',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1933 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Birds>

UPDATE pieces piece
SET piece.title = '가곡 <The Birds>', piece.title_en = 'The Birds',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 787 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 79 The Building of the House

UPDATE pieces piece
SET piece.title = 'The Building of the House', piece.title_en = 'The Building of the House, op. 79',
    piece.type = 'song', piece.opus_number = 'Op. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1276 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 77 The Burning Fiery Furnace

UPDATE pieces piece
SET piece.title = 'The Burning Fiery Furnace', piece.title_en = 'The Burning Fiery Furnace, op. 77',
    piece.type = 'song', piece.opus_number = 'Op. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1913 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Children and Sir Nameless>

UPDATE pieces piece
SET piece.title = '가곡 <The Children and Sir Nameless>', piece.title_en = 'The Children and Sir Nameless',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1653 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Company of Heaven

UPDATE pieces piece
SET piece.title = 'The Company of Heaven', piece.title_en = 'The Company of Heaven',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1998 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Part 3 "Angels in Common Life, and at our Death": Whoso dwelleth under the defence of the most High', part.name_en = 'The Company of Heaven: Part 3 "Angels in Common Life, and at our Death": Whoso dwelleth under the defence of the most High',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1998 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:91e362e0-cc6c-407d-8117-045df3f610b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91e362e0-cc6c-407d-8117-045df3f610b0', 1, NULL, 'Part 3 "Angels in Common Life, and at our Death": Whoso dwelleth under the defence of the most High', 'The Company of Heaven: Part 3 "Angels in Common Life, and at our Death": Whoso dwelleth under the defence of the most High', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1998 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91e362e0-cc6c-407d-8117-045df3f610b0'
);


-- Op. 78 The Golden Vanity

UPDATE pieces piece
SET piece.title = 'The Golden Vanity', piece.title_en = 'The Golden Vanity, op. 78',
    piece.type = 'album', piece.opus_number = 'Op. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1647 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'There was a ship came from the North Country', part.name_en = 'The Golden Vanity, op. 78: I. There was a ship came from the North Country',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1647 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0949576d-394f-3add-bc8e-0e90dd85a3e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0949576d-394f-3add-bc8e-0e90dd85a3e8', 1, 'I', 'There was a ship came from the North Country', 'The Golden Vanity, op. 78: I. There was a ship came from the North Country', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1647 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0949576d-394f-3add-bc8e-0e90dd85a3e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Then up spake the cabin-boy', part.name_en = 'The Golden Vanity, op. 78: II. Then up spake the cabin-boy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1647 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:671a08ae-bd64-341f-8380-17339bd83a07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:671a08ae-bd64-341f-8380-17339bd83a07', 2, 'II', 'Then up spake the cabin-boy', 'The Golden Vanity, op. 78: II. Then up spake the cabin-boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1647 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:671a08ae-bd64-341f-8380-17339bd83a07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Casting his clothes off, he dived into the sea', part.name_en = 'The Golden Vanity, op. 78: III. Casting his clothes off, he dived into the sea',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1647 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:eca03656-ef2e-30e4-9925-4827ac4ea9e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eca03656-ef2e-30e4-9925-4827ac4ea9e5', 3, 'III', 'Casting his clothes off, he dived into the sea', 'The Golden Vanity, op. 78: III. Casting his clothes off, he dived into the sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1647 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eca03656-ef2e-30e4-9925-4827ac4ea9e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'They laid him on the deck', part.name_en = 'The Golden Vanity, op. 78: IV. They laid him on the deck',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1647 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6d8cb31f-f296-3f59-8a9c-bd2cc9951251' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d8cb31f-f296-3f59-8a9c-bd2cc9951251', 4, 'IV', 'They laid him on the deck', 'The Golden Vanity, op. 78: IV. They laid him on the deck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1647 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d8cb31f-f296-3f59-8a9c-bd2cc9951251'
);


-- None 가곡 <The Gully>

UPDATE pieces piece
SET piece.title = '가곡 <The Gully>', piece.title_en = 'The Gully',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2947 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Heart of the Matter

UPDATE pieces piece
SET piece.title = 'The Heart of the Matter', piece.title_en = 'The Heart of the Matter',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2552 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prologue: Fanfare: Song: "Where Are the Seeds of Universal Fire"', part.name_en = 'The Heart of the Matter: I. Prologue: Fanfare: Song: "Where Are the Seeds of Universal Fire"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2552 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f42224cd-2ad2-40f6-b0a3-74491a5c0f6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f42224cd-2ad2-40f6-b0a3-74491a5c0f6a', 1, 'I', 'Prologue: Fanfare: Song: "Where Are the Seeds of Universal Fire"', 'The Heart of the Matter: I. Prologue: Fanfare: Song: "Where Are the Seeds of Universal Fire"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2552 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f42224cd-2ad2-40f6-b0a3-74491a5c0f6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Reading: "The Earth of My Heart Was Broken", Fanfare', part.name_en = 'The Heart of the Matter: II. Reading: "The Earth of My Heart Was Broken", Fanfare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2552 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cb5a52b9-f4ed-4fb0-847f-e829a9dcd59f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb5a52b9-f4ed-4fb0-847f-e829a9dcd59f', 2, 'II', 'Reading: "The Earth of My Heart Was Broken", Fanfare', 'The Heart of the Matter: II. Reading: "The Earth of My Heart Was Broken", Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2552 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb5a52b9-f4ed-4fb0-847f-e829a9dcd59f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Reading: "In the Hour When the Sapphire of the Bone"', part.name_en = 'The Heart of the Matter: III. Reading: "In the Hour When the Sapphire of the Bone"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2552 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:356d0408-3590-4b86-b5b8-cb19633e56ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:356d0408-3590-4b86-b5b8-cb19633e56ac', 3, 'III', 'Reading: "In the Hour When the Sapphire of the Bone"', 'The Heart of the Matter: III. Reading: "In the Hour When the Sapphire of the Bone"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2552 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:356d0408-3590-4b86-b5b8-cb19633e56ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Song: "We Are the Darkness"', part.name_en = 'The Heart of the Matter: IV. Song: "We Are the Darkness"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2552 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ccacb78c-78ff-4999-922c-d83d1f32dacf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccacb78c-78ff-4999-922c-d83d1f32dacf', 4, 'IV', 'Song: "We Are the Darkness"', 'The Heart of the Matter: IV. Song: "We Are the Darkness"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2552 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccacb78c-78ff-4999-922c-d83d1f32dacf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Reading: "In Such a Heat of the Earth"', part.name_en = 'The Heart of the Matter: V. Reading: "In Such a Heat of the Earth"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2552 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8b5e208c-b237-4f9c-961a-eb78b6a24e67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b5e208c-b237-4f9c-961a-eb78b6a24e67', 5, 'V', 'Reading: "In Such a Heat of the Earth"', 'The Heart of the Matter: V. Reading: "In Such a Heat of the Earth"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2552 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b5e208c-b237-4f9c-961a-eb78b6a24e67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Canticle III: "Still Falls the Rain"', part.name_en = 'The Heart of the Matter: VI. Canticle III: "Still Falls the Rain"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2552 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a56b183b-6025-428a-a5ab-644a5aaf2267' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a56b183b-6025-428a-a5ab-644a5aaf2267', 6, 'VI', 'Canticle III: "Still Falls the Rain"', 'The Heart of the Matter: VI. Canticle III: "Still Falls the Rain"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2552 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a56b183b-6025-428a-a5ab-644a5aaf2267'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Reading: "I See Christ''s Wounds Weep in the Rose on the Wall"', part.name_en = 'The Heart of the Matter: VII. Reading: "I See Christ''s Wounds Weep in the Rose on the Wall"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2552 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:48a3d1fb-8d1c-4966-9f2b-9670a922a66d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48a3d1fb-8d1c-4966-9f2b-9670a922a66d', 7, 'VII', 'Reading: "I See Christ''s Wounds Weep in the Rose on the Wall"', 'The Heart of the Matter: VII. Reading: "I See Christ''s Wounds Weep in the Rose on the Wall"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2552 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48a3d1fb-8d1c-4966-9f2b-9670a922a66d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Epilogue: Fanfare: Song: "So, Out of the Dark"', part.name_en = 'The Heart of the Matter: VIII. Epilogue: Fanfare: Song: "So, Out of the Dark"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2552 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c3beaca9-76ed-4400-b4c2-a4508b5dedd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3beaca9-76ed-4400-b4c2-a4508b5dedd7', 8, 'VIII', 'Epilogue: Fanfare: Song: "So, Out of the Dark"', 'The Heart of the Matter: VIII. Epilogue: Fanfare: Song: "So, Out of the Dark"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2552 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3beaca9-76ed-4400-b4c2-a4508b5dedd7'
);


-- Op. 35 연가곡집 <The Holy Sonnets of John Donne> Op. 35

UPDATE pieces piece
SET piece.title = '연가곡집 <The Holy Sonnets of John Donne> Op. 35', piece.title_en = 'The Holy Sonnets of John Donne, op. 35',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '35',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1268 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Oh my blacke Soule!', part.name_en = 'The Holy Sonnets of John Donne, op. 35: Oh my blacke Soule!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:be76e461-22e9-3982-b6f6-77bfe4e50a18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be76e461-22e9-3982-b6f6-77bfe4e50a18', 1, NULL, 'Oh my blacke Soule!', 'The Holy Sonnets of John Donne, op. 35: Oh my blacke Soule!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be76e461-22e9-3982-b6f6-77bfe4e50a18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Batter my heart', part.name_en = 'The Holy Sonnets of John Donne, op. 35: Batter my heart',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ba869d78-7961-385e-9956-66ac2cbeac68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba869d78-7961-385e-9956-66ac2cbeac68', 2, NULL, 'Batter my heart', 'The Holy Sonnets of John Donne, op. 35: Batter my heart', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba869d78-7961-385e-9956-66ac2cbeac68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Oh might those sighes and teares', part.name_en = 'The Holy Sonnets of John Donne, op. 35: Oh might those sighes and teares',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f7e159e4-d741-30b2-a481-6483d17664e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7e159e4-d741-30b2-a481-6483d17664e5', 3, NULL, 'Oh might those sighes and teares', 'The Holy Sonnets of John Donne, op. 35: Oh might those sighes and teares', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7e159e4-d741-30b2-a481-6483d17664e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Oh, to vex me', part.name_en = 'The Holy Sonnets of John Donne, op. 35: Oh, to vex me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6d672f9d-2a72-3d8e-a5bf-8e48161f0282' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d672f9d-2a72-3d8e-a5bf-8e48161f0282', 4, NULL, 'Oh, to vex me', 'The Holy Sonnets of John Donne, op. 35: Oh, to vex me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d672f9d-2a72-3d8e-a5bf-8e48161f0282'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'What if this present', part.name_en = 'The Holy Sonnets of John Donne, op. 35: What if this present',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b8bc6ba9-feee-3c5a-81e4-c718216fdf75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8bc6ba9-feee-3c5a-81e4-c718216fdf75', 5, NULL, 'What if this present', 'The Holy Sonnets of John Donne, op. 35: What if this present', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8bc6ba9-feee-3c5a-81e4-c718216fdf75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Since she whom I loved', part.name_en = 'The Holy Sonnets of John Donne, op. 35: Since she whom I loved',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3fefc068-86ee-34a1-b04b-bd88c4a59cf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fefc068-86ee-34a1-b04b-bd88c4a59cf0', 6, NULL, 'Since she whom I loved', 'The Holy Sonnets of John Donne, op. 35: Since she whom I loved', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fefc068-86ee-34a1-b04b-bd88c4a59cf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'At the round earth''s imagin''d corners', part.name_en = 'The Holy Sonnets of John Donne, op. 35: At the round earth''s imagin''d corners',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ece86bf1-2ff9-3073-9488-d369d3e0d9f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ece86bf1-2ff9-3073-9488-d369d3e0d9f8', 7, NULL, 'At the round earth''s imagin''d corners', 'The Holy Sonnets of John Donne, op. 35: At the round earth''s imagin''d corners', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece86bf1-2ff9-3073-9488-d369d3e0d9f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Thou hast made me', part.name_en = 'The Holy Sonnets of John Donne, op. 35: Thou hast made me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3516e57f-3ef8-3a51-a2ba-fb16a05c665e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3516e57f-3ef8-3a51-a2ba-fb16a05c665e', 8, NULL, 'Thou hast made me', 'The Holy Sonnets of John Donne, op. 35: Thou hast made me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3516e57f-3ef8-3a51-a2ba-fb16a05c665e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Death be not proud', part.name_en = 'The Holy Sonnets of John Donne, op. 35: Death be not proud',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1268 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b1423be9-db16-3ce4-bd6a-d25eae03bb8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1423be9-db16-3ce4-bd6a-d25eae03bb8e', 9, NULL, 'Death be not proud', 'The Holy Sonnets of John Donne, op. 35: Death be not proud', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1268 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1423be9-db16-3ce4-bd6a-d25eae03bb8e'
);


-- Op. 45 오페라 <The Little Sweep>

UPDATE pieces piece
SET piece.title = '오페라 <The Little Sweep>', piece.title_en = 'The Little Sweep, op. 45',
    piece.type = 'song', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1484 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Oxen

UPDATE pieces piece
SET piece.title = 'The Oxen', piece.title_en = 'The Oxen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2762 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 연가곡집 <The Poet’s Echo>

UPDATE pieces piece
SET piece.title = '연가곡집 <The Poet’s Echo>', piece.title_en = 'The Poet’s Echo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 852 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'op. 76: I. Echo', part.name_en = 'The Poet’s Echo, op. 76: I. Echo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 852 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:30b5e1eb-0120-4f6e-993a-e953f45cee5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30b5e1eb-0120-4f6e-993a-e953f45cee5f', 1, NULL, 'op. 76: I. Echo', 'The Poet’s Echo, op. 76: I. Echo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 852 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b5e1eb-0120-4f6e-993a-e953f45cee5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'op. 76: II. I Thought That the Heart Had Forgotten', part.name_en = 'The Poet’s Echo, op. 76: II. I Thought That the Heart Had Forgotten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 852 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8125c3d6-48a1-45a6-9e05-3a66569fc353' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8125c3d6-48a1-45a6-9e05-3a66569fc353', 2, NULL, 'op. 76: II. I Thought That the Heart Had Forgotten', 'The Poet’s Echo, op. 76: II. I Thought That the Heart Had Forgotten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 852 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8125c3d6-48a1-45a6-9e05-3a66569fc353'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'op. 76: III. Angel', part.name_en = 'The Poet’s Echo, op. 76: III. Angel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 852 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ae5343c0-9470-4cfb-b4e5-2dffd8fad98e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae5343c0-9470-4cfb-b4e5-2dffd8fad98e', 3, NULL, 'op. 76: III. Angel', 'The Poet’s Echo, op. 76: III. Angel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 852 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae5343c0-9470-4cfb-b4e5-2dffd8fad98e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'op. 76: IV. The Nightingale and the Rose', part.name_en = 'The Poet’s Echo, op. 76: IV. The Nightingale and the Rose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 852 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:649b63a1-94b6-4d30-b355-1b6dcc7a9063' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:649b63a1-94b6-4d30-b355-1b6dcc7a9063', 4, NULL, 'op. 76: IV. The Nightingale and the Rose', 'The Poet’s Echo, op. 76: IV. The Nightingale and the Rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 852 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:649b63a1-94b6-4d30-b355-1b6dcc7a9063'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'op. 76: V. Epigram', part.name_en = 'The Poet’s Echo, op. 76: V. Epigram',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 852 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:75608d6b-8f1d-4f2b-a82d-f527341c6f7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75608d6b-8f1d-4f2b-a82d-f527341c6f7e', 5, NULL, 'op. 76: V. Epigram', 'The Poet’s Echo, op. 76: V. Epigram', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 852 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75608d6b-8f1d-4f2b-a82d-f527341c6f7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'op. 76: VI. Lines Written During a Sleepless Night', part.name_en = 'The Poet’s Echo, op. 76: VI. Lines Written During a Sleepless Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 852 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:03a5b3b2-4ee3-4406-bb84-93817927a003' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03a5b3b2-4ee3-4406-bb84-93817927a003', 6, NULL, 'op. 76: VI. Lines Written During a Sleepless Night', 'The Poet’s Echo, op. 76: VI. Lines Written During a Sleepless Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 852 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a5b3b2-4ee3-4406-bb84-93817927a003'
);


-- Op. 57 발레 <The Prince of the Pagodas> Op. 57

UPDATE pieces piece
SET piece.title = '발레 <The Prince of the Pagodas> Op. 57', piece.title_en = 'The Prince of the Pagodas, op. 57',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '57',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1387 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'The Prince of the Pagodas, op. 57: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1387 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bb8bf4f5-b613-499a-9be8-1eff5c2a1107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb8bf4f5-b613-499a-9be8-1eff5c2a1107', 1, NULL, 'Act I', 'The Prince of the Pagodas, op. 57: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1387 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb8bf4f5-b613-499a-9be8-1eff5c2a1107'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'The Prince of the Pagodas, op. 57: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1387 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4b76e4c2-f053-4bb1-b4ec-d688aae81286' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b76e4c2-f053-4bb1-b4ec-d688aae81286', 2, NULL, 'Act II', 'The Prince of the Pagodas, op. 57: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1387 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b76e4c2-f053-4bb1-b4ec-d688aae81286'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act III', part.name_en = 'The Prince of the Pagodas, op. 57: Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1387 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:21cc8383-bc1f-4578-8d80-2e5975773d90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21cc8383-bc1f-4578-8d80-2e5975773d90', 3, NULL, 'Act III', 'The Prince of the Pagodas, op. 57: Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1387 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21cc8383-bc1f-4578-8d80-2e5975773d90'
);


-- Op. 81 The Prodigal Son Op. 81

UPDATE pieces piece
SET piece.title = 'The Prodigal Son Op. 81', piece.title_en = 'The Prodigal Son, op. 81',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '81',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2868 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jam lucis orto sidere', part.name_en = 'The Prodigal Son: Jam lucis orto sidere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:74158cf5-cca8-4b74-a403-7a5727e4ac30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74158cf5-cca8-4b74-a403-7a5727e4ac30', 1, NULL, 'Jam lucis orto sidere', 'The Prodigal Son: Jam lucis orto sidere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74158cf5-cca8-4b74-a403-7a5727e4ac30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ah - you people (Tempter)', part.name_en = 'The Prodigal Son: Ah - you people (Tempter)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:5956f2d0-6407-4194-9e36-f946eefd1892' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5956f2d0-6407-4194-9e36-f946eefd1892', 2, NULL, 'Ah - you people (Tempter)', 'The Prodigal Son: Ah - you people (Tempter)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5956f2d0-6407-4194-9e36-f946eefd1892'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Ceremony', part.name_en = 'The Prodigal Son: The Ceremony',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2c5e194d-cf1e-4d37-aebf-9850a19cf35f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c5e194d-cf1e-4d37-aebf-9850a19cf35f', 3, NULL, 'The Ceremony', 'The Prodigal Son: The Ceremony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c5e194d-cf1e-4d37-aebf-9850a19cf35f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'I am father to you all (Father)', part.name_en = 'The Prodigal Son: I am father to you all (Father)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8709c825-e1e5-49be-9772-1b64c4ce595f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8709c825-e1e5-49be-9772-1b64c4ce595f', 4, NULL, 'I am father to you all (Father)', 'The Prodigal Son: I am father to you all (Father)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8709c825-e1e5-49be-9772-1b64c4ce595f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Forgive my asking you (Tempter)', part.name_en = 'The Prodigal Son: Forgive my asking you (Tempter)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:af136403-333d-4f1b-aae8-55552d18993e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af136403-333d-4f1b-aae8-55552d18993e', 5, NULL, 'Forgive my asking you (Tempter)', 'The Prodigal Son: Forgive my asking you (Tempter)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af136403-333d-4f1b-aae8-55552d18993e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Father, may I speak to you? (Younger Son)', part.name_en = 'The Prodigal Son: Father, may I speak to you? (Younger Son)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b473e3ba-a4df-4e06-a076-b74e03400674' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b473e3ba-a4df-4e06-a076-b74e03400674', 6, NULL, 'Father, may I speak to you? (Younger Son)', 'The Prodigal Son: Father, may I speak to you? (Younger Son)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b473e3ba-a4df-4e06-a076-b74e03400674'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Take your due portion (Father)', part.name_en = 'The Prodigal Son: Take your due portion (Father)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fb04bd35-26e9-4bc4-bc87-072ca8d70a29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb04bd35-26e9-4bc4-bc87-072ca8d70a29', 7, NULL, 'Take your due portion (Father)', 'The Prodigal Son: Take your due portion (Father)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb04bd35-26e9-4bc4-bc87-072ca8d70a29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Go, if you must go (Servants)', part.name_en = 'The Prodigal Son: Go, if you must go (Servants)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8a3b4877-c20c-4113-bd4f-27a0766750cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a3b4877-c20c-4113-bd4f-27a0766750cf', 8, NULL, 'Go, if you must go (Servants)', 'The Prodigal Son: Go, if you must go (Servants)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a3b4877-c20c-4113-bd4f-27a0766750cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Welcome, welcome, stranger! (Parasites)', part.name_en = 'The Prodigal Son: Welcome, welcome, stranger! (Parasites)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7627d0b0-e6b1-42c2-836f-35b949646ace' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7627d0b0-e6b1-42c2-836f-35b949646ace', 9, NULL, 'Welcome, welcome, stranger! (Parasites)', 'The Prodigal Son: Welcome, welcome, stranger! (Parasites)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7627d0b0-e6b1-42c2-836f-35b949646ace'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'You are tired from a long journey (Tempter)', part.name_en = 'The Prodigal Son: You are tired from a long journey (Tempter)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:95cc52b4-bcd6-4255-939f-367d9e3a37c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95cc52b4-bcd6-4255-939f-367d9e3a37c3', 10, NULL, 'You are tired from a long journey (Tempter)', 'The Prodigal Son: You are tired from a long journey (Tempter)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95cc52b4-bcd6-4255-939f-367d9e3a37c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Nights are days (Parasites)', part.name_en = 'The Prodigal Son: Nights are days (Parasites)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:eaa2e0bf-6c08-4109-9a63-0e381827814b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaa2e0bf-6c08-4109-9a63-0e381827814b', 11, NULL, 'Nights are days (Parasites)', 'The Prodigal Son: Nights are days (Parasites)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaa2e0bf-6c08-4109-9a63-0e381827814b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'You have gambled and lost (Tempter)', part.name_en = 'The Prodigal Son: You have gambled and lost (Tempter)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f88a2203-0f5a-4c17-8b63-262f6af2cd07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f88a2203-0f5a-4c17-8b63-262f6af2cd07', 12, NULL, 'You have gambled and lost (Tempter)', 'The Prodigal Son: You have gambled and lost (Tempter)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f88a2203-0f5a-4c17-8b63-262f6af2cd07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'You it was taught me (Son)', part.name_en = 'The Prodigal Son: You it was taught me (Son)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3d3d51a2-dd07-4920-bb3d-28d3731b7023' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d3d51a2-dd07-4920-bb3d-28d3731b7023', 13, NULL, 'You it was taught me (Son)', 'The Prodigal Son: You it was taught me (Son)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d3d51a2-dd07-4920-bb3d-28d3731b7023'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Now - I have done what I said (Tempter)', part.name_en = 'The Prodigal Son: Now - I have done what I said (Tempter)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b53bd38a-477f-4b1b-9687-063294d77923' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b53bd38a-477f-4b1b-9687-063294d77923', 14, NULL, 'Now - I have done what I said (Tempter)', 'The Prodigal Son: Now - I have done what I said (Tempter)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b53bd38a-477f-4b1b-9687-063294d77923'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'With joy I sowed (Younger Son)', part.name_en = 'The Prodigal Son: With joy I sowed (Younger Son)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:8e7eed15-06e3-481c-a53e-72e5e05faef7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e7eed15-06e3-481c-a53e-72e5e05faef7', 15, NULL, 'With joy I sowed (Younger Son)', 'The Prodigal Son: With joy I sowed (Younger Son)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e7eed15-06e3-481c-a53e-72e5e05faef7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'My son (Father)', part.name_en = 'The Prodigal Son: My son (Father)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3123f12e-e6b2-4b64-97f0-1c8db81270a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3123f12e-e6b2-4b64-97f0-1c8db81270a0', 16, NULL, 'My son (Father)', 'The Prodigal Son: My son (Father)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3123f12e-e6b2-4b64-97f0-1c8db81270a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'O sing unto the Lord (Servants)', part.name_en = 'The Prodigal Son: O sing unto the Lord (Servants)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f9e63061-1cb0-45b2-8393-c39cacf7ce69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9e63061-1cb0-45b2-8393-c39cacf7ce69', 17, NULL, 'O sing unto the Lord (Servants)', 'The Prodigal Son: O sing unto the Lord (Servants)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9e63061-1cb0-45b2-8393-c39cacf7ce69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'My children, you have seen (Abbot)', part.name_en = 'The Prodigal Son: My children, you have seen (Abbot)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2868 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e24f8d1b-a5a4-4169-abd3-a2bbd603f3e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e24f8d1b-a5a4-4169-abd3-a2bbd603f3e6', 18, NULL, 'My children, you have seen (Abbot)', 'The Prodigal Son: My children, you have seen (Abbot)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2868 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e24f8d1b-a5a4-4169-abd3-a2bbd603f3e6'
);


-- None 가곡 <The Red Cockatoo>

UPDATE pieces piece
SET piece.title = '가곡 <The Red Cockatoo>', piece.title_en = 'The Red Cockatoo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2233 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Shooting Of His Dear>

UPDATE pieces piece
SET piece.title = '가곡 <The Shooting Of His Dear>', piece.title_en = 'The Shooting Of His Dear',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1828 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Spirit of the Lord (The World of the Spirit)>

UPDATE pieces piece
SET piece.title = '가곡 <The Spirit of the Lord (The World of the Spirit)>', piece.title_en = 'The Spirit of the Lord (The World of the Spirit)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 910 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Sun Shines Down>

UPDATE pieces piece
SET piece.title = '가곡 <The Sun Shines Down>', piece.title_en = 'The Sun Shines Down',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1076 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Sword in the Stone

UPDATE pieces piece
SET piece.title = 'The Sword in the Stone', piece.title_en = 'The Sword in the Stone',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2090 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction & Boys'' Tunes', part.name_en = 'The Sword in the Stone: I. Introduction & Boys'' Tunes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2090 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2eb1faf0-0ff7-4394-b59e-ad1055245235' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2eb1faf0-0ff7-4394-b59e-ad1055245235', 1, 'I', 'Introduction & Boys'' Tunes', 'The Sword in the Stone: I. Introduction & Boys'' Tunes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2090 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2eb1faf0-0ff7-4394-b59e-ad1055245235'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Merlyn''s Tune & Tree Music', part.name_en = 'The Sword in the Stone: II. Merlyn''s Tune & Tree Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2090 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c97635cf-c058-433a-8abc-ef1e041e5290' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c97635cf-c058-433a-8abc-ef1e041e5290', 2, 'II', 'Merlyn''s Tune & Tree Music', 'The Sword in the Stone: II. Merlyn''s Tune & Tree Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2090 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c97635cf-c058-433a-8abc-ef1e041e5290'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Merlyn''s Spell & Witch Tune', part.name_en = 'The Sword in the Stone: III. Merlyn''s Spell & Witch Tune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2090 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3b034d62-929b-47de-bd95-b11e570062f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b034d62-929b-47de-bd95-b11e570062f0', 3, 'III', 'Merlyn''s Spell & Witch Tune', 'The Sword in the Stone: III. Merlyn''s Spell & Witch Tune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2090 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b034d62-929b-47de-bd95-b11e570062f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Bird Music', part.name_en = 'The Sword in the Stone: IV. Bird Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2090 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:502a6135-4f74-4414-a0f0-79ae559bfa4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:502a6135-4f74-4414-a0f0-79ae559bfa4d', 4, 'IV', 'Bird Music', 'The Sword in the Stone: IV. Bird Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2090 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:502a6135-4f74-4414-a0f0-79ae559bfa4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Lullaby', part.name_en = 'The Sword in the Stone: V. Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2090 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:514ee370-71a5-494f-966c-c1f23c980405' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:514ee370-71a5-494f-966c-c1f23c980405', 5, 'V', 'Lullaby', 'The Sword in the Stone: V. Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2090 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:514ee370-71a5-494f-966c-c1f23c980405'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Water Theme & End Music', part.name_en = 'The Sword in the Stone: VI. Water Theme & End Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2090 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:86e5f704-1ed7-4e71-b1a6-984026159cf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86e5f704-1ed7-4e71-b1a6-984026159cf2', 6, 'VI', 'Water Theme & End Music', 'The Sword in the Stone: VI. Water Theme & End Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2090 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86e5f704-1ed7-4e71-b1a6-984026159cf2'
);


-- None The Sycamore Tree

UPDATE pieces piece
SET piece.title = 'The Sycamore Tree', piece.title_en = 'The Sycamore Tree',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2434 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <The Turn of the Screw>

UPDATE pieces piece
SET piece.title = '오페라 <The Turn of the Screw>', piece.title_en = 'The Turn of the Screw',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 794 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prologue (The Prologue)', part.name_en = 'The Turn of the Screw: Prologue (The Prologue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6aadbdba-fdeb-3692-b131-c84f74674f6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6aadbdba-fdeb-3692-b131-c84f74674f6b', 1, NULL, 'Prologue (The Prologue)', 'The Turn of the Screw: Prologue (The Prologue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6aadbdba-fdeb-3692-b131-c84f74674f6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Act I', part.name_en = 'The Turn of the Screw: Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88', 2, NULL, 'Act I', 'The Turn of the Screw: Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Theme / Act I, Scene 1. Recitative "The Journey" (Governess)', part.name_en = 'The Turn of the Screw: Act I, Theme / Act I, Scene 1. Recitative "The Journey" (Governess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:acacaba2-4eb1-32c5-af13-8affbbb63b4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:acacaba2-4eb1-32c5-af13-8affbbb63b4e', 1, NULL, 'Theme / Act I, Scene 1. Recitative "The Journey" (Governess)', 'The Turn of the Screw: Act I, Theme / Act I, Scene 1. Recitative "The Journey" (Governess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acacaba2-4eb1-32c5-af13-8affbbb63b4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation I / Act I, Scene 2. "The Welcome" (Miles, Flora, Mrs. Grose, Governess)', part.name_en = 'The Turn of the Screw: Act I, Variation I / Act I, Scene 2. "The Welcome" (Miles, Flora, Mrs. Grose, Governess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0035ecb1-caf3-3988-a9fb-c49de96ed863' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0035ecb1-caf3-3988-a9fb-c49de96ed863', 2, NULL, 'Variation I / Act I, Scene 2. "The Welcome" (Miles, Flora, Mrs. Grose, Governess)', 'The Turn of the Screw: Act I, Variation I / Act I, Scene 2. "The Welcome" (Miles, Flora, Mrs. Grose, Governess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0035ecb1-caf3-3988-a9fb-c49de96ed863'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation II / Act I, Scene 3. "The Letter" (Miles, Flora, Mrs. Grose, Governess)', part.name_en = 'The Turn of the Screw: Act I, Variation II / Act I, Scene 3. "The Letter" (Miles, Flora, Mrs. Grose, Governess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0a4f950f-a758-3b56-8235-22611c0f57b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a4f950f-a758-3b56-8235-22611c0f57b8', 3, NULL, 'Variation II / Act I, Scene 3. "The Letter" (Miles, Flora, Mrs. Grose, Governess)', 'The Turn of the Screw: Act I, Variation II / Act I, Scene 3. "The Letter" (Miles, Flora, Mrs. Grose, Governess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a4f950f-a758-3b56-8235-22611c0f57b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation III / Act I, Scene 4. Air "The Tower" (Governess)', part.name_en = 'The Turn of the Screw: Act I, Variation III / Act I, Scene 4. Air "The Tower" (Governess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c2785826-0c63-3a77-8d00-0b10d1f88adb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c2785826-0c63-3a77-8d00-0b10d1f88adb', 4, NULL, 'Variation III / Act I, Scene 4. Air "The Tower" (Governess)', 'The Turn of the Screw: Act I, Variation III / Act I, Scene 4. Air "The Tower" (Governess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2785826-0c63-3a77-8d00-0b10d1f88adb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation IV / Act I, Scene 5. "The Window" (Miles, Flora, Governess, Mrs. Grose)', part.name_en = 'The Turn of the Screw: Act I, Variation IV / Act I, Scene 5. "The Window" (Miles, Flora, Governess, Mrs. Grose)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d46dccce-b210-35d8-9847-d48cf3ae6f7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d46dccce-b210-35d8-9847-d48cf3ae6f7e', 5, NULL, 'Variation IV / Act I, Scene 5. "The Window" (Miles, Flora, Governess, Mrs. Grose)', 'The Turn of the Screw: Act I, Variation IV / Act I, Scene 5. "The Window" (Miles, Flora, Governess, Mrs. Grose)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d46dccce-b210-35d8-9847-d48cf3ae6f7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation V / Act I, Scene 6. "The Lesson" ( (Miles, Flora, Governess)', part.name_en = 'The Turn of the Screw: Act I, Variation V / Act I, Scene 6. "The Lesson" ( (Miles, Flora, Governess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:dc0a6607-b424-324c-b720-721763bc75a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc0a6607-b424-324c-b720-721763bc75a8', 6, NULL, 'Variation V / Act I, Scene 6. "The Lesson" ( (Miles, Flora, Governess)', 'The Turn of the Screw: Act I, Variation V / Act I, Scene 6. "The Lesson" ( (Miles, Flora, Governess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc0a6607-b424-324c-b720-721763bc75a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation VI / Act I, Scene 7. Air "The Lake" (Flora, Governess, Miles)', part.name_en = 'The Turn of the Screw: Act I, Variation VI / Act I, Scene 7. Air "The Lake" (Flora, Governess, Miles)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3ca895e4-d2fe-3b0c-9546-cd37c99c5fee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ca895e4-d2fe-3b0c-9546-cd37c99c5fee', 7, NULL, 'Variation VI / Act I, Scene 7. Air "The Lake" (Flora, Governess, Miles)', 'The Turn of the Screw: Act I, Variation VI / Act I, Scene 7. Air "The Lake" (Flora, Governess, Miles)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ca895e4-d2fe-3b0c-9546-cd37c99c5fee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation VII / Act I, Scene 8. Duet "At Night" (Quint, Miles, Miss Jessel, Flora, Governess, Mrs. Grose)', part.name_en = 'The Turn of the Screw: Act I, Variation VII / Act I, Scene 8. Duet "At Night" (Quint, Miles, Miss Jessel, Flora, Governess, Mrs. Grose)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e27ce23f-feb3-36f3-86c5-c97a0a7e3767' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e27ce23f-feb3-36f3-86c5-c97a0a7e3767', 8, NULL, 'Variation VII / Act I, Scene 8. Duet "At Night" (Quint, Miles, Miss Jessel, Flora, Governess, Mrs. Grose)', 'The Turn of the Screw: Act I, Variation VII / Act I, Scene 8. Duet "At Night" (Quint, Miles, Miss Jessel, Flora, Governess, Mrs. Grose)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5a3d93b-e73e-4436-83ba-860b6f9cba88'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e27ce23f-feb3-36f3-86c5-c97a0a7e3767'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Act II', part.name_en = 'The Turn of the Screw: Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522', 3, NULL, 'Act II', 'The Turn of the Screw: Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Variation VIII / Act II, Scene 1. Duet "Colloquy and Soliloquy" (Miss Jessel, Quint, Governess)', part.name_en = 'The Turn of the Screw: Act II, Variation VIII / Act II, Scene 1. Duet "Colloquy and Soliloquy" (Miss Jessel, Quint, Governess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3fd28ee8-3adf-39d9-9ddb-5bf3c2ac9dae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3fd28ee8-3adf-39d9-9ddb-5bf3c2ac9dae', 1, NULL, 'Variation VIII / Act II, Scene 1. Duet "Colloquy and Soliloquy" (Miss Jessel, Quint, Governess)', 'The Turn of the Screw: Act II, Variation VIII / Act II, Scene 1. Duet "Colloquy and Soliloquy" (Miss Jessel, Quint, Governess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fd28ee8-3adf-39d9-9ddb-5bf3c2ac9dae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Variation IX / Act II, Scene 2. Quartet "The Bells" (Miles, Flora, Mrs. Grose, Governess', part.name_en = 'The Turn of the Screw: Act II, Variation IX / Act II, Scene 2. Quartet "The Bells" (Miles, Flora, Mrs. Grose, Governess',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:070bd2dc-6703-33d5-a349-e6bc6b01a96b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:070bd2dc-6703-33d5-a349-e6bc6b01a96b', 2, NULL, 'Variation IX / Act II, Scene 2. Quartet "The Bells" (Miles, Flora, Mrs. Grose, Governess', 'The Turn of the Screw: Act II, Variation IX / Act II, Scene 2. Quartet "The Bells" (Miles, Flora, Mrs. Grose, Governess', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:070bd2dc-6703-33d5-a349-e6bc6b01a96b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Variation X / Act II, Scene 3. Duet "Miss Jessel" (Governess, Miss Jessel)', part.name_en = 'The Turn of the Screw: Act II, Variation X / Act II, Scene 3. Duet "Miss Jessel" (Governess, Miss Jessel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b017d5a4-6857-3ec9-8694-e011e0f2d350' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b017d5a4-6857-3ec9-8694-e011e0f2d350', 3, NULL, 'Variation X / Act II, Scene 3. Duet "Miss Jessel" (Governess, Miss Jessel)', 'The Turn of the Screw: Act II, Variation X / Act II, Scene 3. Duet "Miss Jessel" (Governess, Miss Jessel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b017d5a4-6857-3ec9-8694-e011e0f2d350'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Variation XI / Act II, Scene 4. "The Bedroom" (Miles, Governess, Quint)', part.name_en = 'The Turn of the Screw: Act II, Variation XI / Act II, Scene 4. "The Bedroom" (Miles, Governess, Quint)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:240db12b-3c12-3c75-b481-2421ca31e9a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:240db12b-3c12-3c75-b481-2421ca31e9a6', 4, NULL, 'Variation XI / Act II, Scene 4. "The Bedroom" (Miles, Governess, Quint)', 'The Turn of the Screw: Act II, Variation XI / Act II, Scene 4. "The Bedroom" (Miles, Governess, Quint)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240db12b-3c12-3c75-b481-2421ca31e9a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Variation XII / Act II, Scene 5. "Quint" (Quint)', part.name_en = 'The Turn of the Screw: Act II, Variation XII / Act II, Scene 5. "Quint" (Quint)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9cb6b660-5e4d-383f-8cda-81d4a57a088d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9cb6b660-5e4d-383f-8cda-81d4a57a088d', 5, NULL, 'Variation XII / Act II, Scene 5. "Quint" (Quint)', 'The Turn of the Screw: Act II, Variation XII / Act II, Scene 5. "Quint" (Quint)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cb6b660-5e4d-383f-8cda-81d4a57a088d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Variation XIII / Act II, Scene 6. "The Piano" (Governess, Mrs. Grose, Flora)', part.name_en = 'The Turn of the Screw: Act II, Variation XIII / Act II, Scene 6. "The Piano" (Governess, Mrs. Grose, Flora)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:00b47dbd-c409-310a-a393-d372bdb91089' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00b47dbd-c409-310a-a393-d372bdb91089', 6, NULL, 'Variation XIII / Act II, Scene 6. "The Piano" (Governess, Mrs. Grose, Flora)', 'The Turn of the Screw: Act II, Variation XIII / Act II, Scene 6. "The Piano" (Governess, Mrs. Grose, Flora)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b47dbd-c409-310a-a393-d372bdb91089'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Variation XIV / Act II, Scene 7. "Flora" (Mrs. Grose, Governess, Miss Jessel, Flora)', part.name_en = 'The Turn of the Screw: Act II, Variation XIV / Act II, Scene 7. "Flora" (Mrs. Grose, Governess, Miss Jessel, Flora)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fa8319bc-120d-3e32-85f6-d21523801af8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa8319bc-120d-3e32-85f6-d21523801af8', 7, NULL, 'Variation XIV / Act II, Scene 7. "Flora" (Mrs. Grose, Governess, Miss Jessel, Flora)', 'The Turn of the Screw: Act II, Variation XIV / Act II, Scene 7. "Flora" (Mrs. Grose, Governess, Miss Jessel, Flora)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8319bc-120d-3e32-85f6-d21523801af8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Variation XV / Act II, Scene 8. "Miles" (Governess, Mrs. Grose, Miles, Quint)', part.name_en = 'The Turn of the Screw: Act II, Variation XV / Act II, Scene 8. "Miles" (Governess, Mrs. Grose, Miles, Quint)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 794 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:14f43aca-d843-3c68-b972-a3a3b4ff6d5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:14f43aca-d843-3c68-b972-a3a3b4ff6d5c', 8, NULL, 'Variation XV / Act II, Scene 8. "Miles" (Governess, Mrs. Grose, Miles, Quint)', 'The Turn of the Screw: Act II, Variation XV / Act II, Scene 8. "Miles" (Governess, Mrs. Grose, Miles, Quint)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8d62572-9ebe-43ef-8717-d2dd4fcd8522'
WHERE p.id = 794 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14f43aca-d843-3c68-b972-a3a3b4ff6d5c'
);


-- None 영화음악 <The Way to the Sea>

UPDATE pieces piece
SET piece.title = '영화음악 <The Way to the Sea>', piece.title_en = 'The Way to the Sea',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2748 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None This Way to the Tomb

UPDATE pieces piece
SET piece.title = 'This Way to the Tomb', piece.title_en = 'This Way to the Tomb',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1127 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Evening', part.name_en = 'This Way to the Tomb: I. Evening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1127 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ec44c08c-bcff-4d35-b56b-2933d4d4591e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec44c08c-bcff-4d35-b56b-2933d4d4591e', 1, 'I', 'Evening', 'This Way to the Tomb: I. Evening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1127 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec44c08c-bcff-4d35-b56b-2933d4d4591e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Morning', part.name_en = 'This Way to the Tomb: II. Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1127 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a22e38ca-0582-48ad-81fc-51f111a2595f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a22e38ca-0582-48ad-81fc-51f111a2595f', 2, 'II', 'Morning', 'This Way to the Tomb: II. Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1127 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a22e38ca-0582-48ad-81fc-51f111a2595f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Night', part.name_en = 'This Way to the Tomb: III. Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1127 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:0d9db1c8-08cd-47ea-b80a-bd8c94250128' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d9db1c8-08cd-47ea-b80a-bd8c94250128', 3, 'III', 'Night', 'This Way to the Tomb: III. Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1127 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d9db1c8-08cd-47ea-b80a-bd8c94250128'
);


-- None Three Character Pieces

UPDATE pieces piece
SET piece.title = 'Three Character Pieces', piece.title_en = 'Three Character Pieces',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1547 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'John', part.name_en = 'Three Character Pieces: No. 1. John',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1547 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e37f4f7a-bed2-4b66-b0a2-ccb8e229e683' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e37f4f7a-bed2-4b66-b0a2-ccb8e229e683', 1, NULL, 'John', 'Three Character Pieces: No. 1. John', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1547 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e37f4f7a-bed2-4b66-b0a2-ccb8e229e683'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Daphne', part.name_en = 'Three Character Pieces: No. 2. Daphne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1547 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2ef40364-390e-4ca3-b385-c4b1a3f700f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ef40364-390e-4ca3-b385-c4b1a3f700f0', 2, NULL, 'Daphne', 'Three Character Pieces: No. 2. Daphne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1547 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ef40364-390e-4ca3-b385-c4b1a3f700f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Michael', part.name_en = 'Three Character Pieces: No. 3. Michael',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1547 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:39df18c4-9d49-4d2f-a830-0ad7e17940f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39df18c4-9d49-4d2f-a830-0ad7e17940f0', 3, NULL, 'Michael', 'Three Character Pieces: No. 3. Michael', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1547 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39df18c4-9d49-4d2f-a830-0ad7e17940f0'
);


-- None Three Divertimenti for String Quartet

UPDATE pieces piece
SET piece.title = 'Three Divertimenti for String Quartet', piece.title_en = 'Three Divertimenti for String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1048 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'March', part.name_en = 'Three Divertimenti for String Quartet: I. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1048 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:625e87ff-96bd-40c9-b1b1-2a93cb67f36a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:625e87ff-96bd-40c9-b1b1-2a93cb67f36a', 1, 'I', 'March', 'Three Divertimenti for String Quartet: I. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1048 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:625e87ff-96bd-40c9-b1b1-2a93cb67f36a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Waltz', part.name_en = 'Three Divertimenti for String Quartet: II. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1048 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:04cf63a3-fc13-4b24-aa5b-db05b9ed6c1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04cf63a3-fc13-4b24-aa5b-db05b9ed6c1e', 2, 'II', 'Waltz', 'Three Divertimenti for String Quartet: II. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1048 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04cf63a3-fc13-4b24-aa5b-db05b9ed6c1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Burlesque', part.name_en = 'Three Divertimenti for String Quartet: III. Burlesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1048 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2215fb26-5332-4c9c-9038-569c5adddda0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2215fb26-5332-4c9c-9038-569c5adddda0', 3, 'III', 'Burlesque', 'Three Divertimenti for String Quartet: III. Burlesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1048 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2215fb26-5332-4c9c-9038-569c5adddda0'
);


-- None Three Two-Part Songs

UPDATE pieces piece
SET piece.title = 'Three Two-Part Songs', piece.title_en = 'Three Two-Part Songs',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1962 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Ride-by-nights', part.name_en = 'Three Two-Part Songs: No. 1. The Ride-by-nights',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1962 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:ee576db6-fc85-4e51-96f7-626e4129b07d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee576db6-fc85-4e51-96f7-626e4129b07d', 1, NULL, 'The Ride-by-nights', 'Three Two-Part Songs: No. 1. The Ride-by-nights', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1962 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee576db6-fc85-4e51-96f7-626e4129b07d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The Rainbow', part.name_en = 'Three Two-Part Songs: No. 2. The Rainbow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1962 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9f9eb441-0d5d-4f8b-be81-72f5f4ce132b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f9eb441-0d5d-4f8b-be81-72f5f4ce132b', 2, NULL, 'The Rainbow', 'Three Two-Part Songs: No. 2. The Rainbow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1962 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f9eb441-0d5d-4f8b-be81-72f5f4ce132b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Ship of Rio', part.name_en = 'Three Two-Part Songs: No. 3. The Ship of Rio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1962 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fd01360d-fa3c-457d-a87f-50b41f1700a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd01360d-fa3c-457d-a87f-50b41f1700a3', 3, NULL, 'The Ship of Rio', 'Three Two-Part Songs: No. 3. The Ship of Rio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1962 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd01360d-fa3c-457d-a87f-50b41f1700a3'
);


-- None Timpani Piece for Jimmy

UPDATE pieces piece
SET piece.title = 'Timpani Piece for Jimmy', piece.title_en = 'Timpani Piece for Jimmy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2168 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tit for Tat

UPDATE pieces piece
SET piece.title = 'Tit for Tat', piece.title_en = 'Tit for Tat',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1405 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'A song of enchantment', part.name_en = 'Tit for Tat: I. A song of enchantment',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1405 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:cf20d7e7-397b-4d40-a2c1-f13439b35d4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf20d7e7-397b-4d40-a2c1-f13439b35d4f', 1, 'I', 'A song of enchantment', 'Tit for Tat: I. A song of enchantment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1405 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf20d7e7-397b-4d40-a2c1-f13439b35d4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Autumn', part.name_en = 'Tit for Tat: II. Autumn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1405 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e6860741-420d-499e-9063-9da35f74a2c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6860741-420d-499e-9063-9da35f74a2c2', 2, 'II', 'Autumn', 'Tit for Tat: II. Autumn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1405 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6860741-420d-499e-9063-9da35f74a2c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Silver', part.name_en = 'Tit for Tat: III. Silver',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1405 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9c00326e-eb98-41be-9fce-14efbec2df98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c00326e-eb98-41be-9fce-14efbec2df98', 3, 'III', 'Silver', 'Tit for Tat: III. Silver', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1405 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c00326e-eb98-41be-9fce-14efbec2df98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vigil', part.name_en = 'Tit for Tat: IV. Vigil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1405 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:43c77f17-4a77-4344-a24e-c1ddaf04b3d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43c77f17-4a77-4344-a24e-c1ddaf04b3d4', 4, 'IV', 'Vigil', 'Tit for Tat: IV. Vigil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1405 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43c77f17-4a77-4344-a24e-c1ddaf04b3d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tit for tat', part.name_en = 'Tit for Tat: V. Tit for tat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1405 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d37c8628-ea95-420e-bdf4-564d6b15f5ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d37c8628-ea95-420e-bdf4-564d6b15f5ef', 5, 'V', 'Tit for tat', 'Tit for Tat: V. Tit for tat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1405 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d37c8628-ea95-420e-bdf4-564d6b15f5ef'
);


-- None 가곡 <To Lie Flat on the Back With the Knees Flexed>

UPDATE pieces piece
SET piece.title = '가곡 <To Lie Flat on the Back With the Knees Flexed>', piece.title_en = 'To Lie Flat on the Back With the Knees Flexed',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1823 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tom Bowling and Other Song Arrangements

UPDATE pieces piece
SET piece.title = 'Tom Bowling and Other Song Arrangements', piece.title_en = 'Tom Bowling and Other Song Arrangements',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2246 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'The Deaf Woman''s Courtship', part.name_en = 'The Deaf Woman''s Courtship',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2246 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:00604359-038a-486f-8828-37599fc9efe7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00604359-038a-486f-8828-37599fc9efe7', 1, NULL, 'The Deaf Woman''s Courtship', 'The Deaf Woman''s Courtship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2246 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00604359-038a-486f-8828-37599fc9efe7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pray Goody', part.name_en = 'Pray Goody',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2246 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4d0ca664-966b-427a-9fdd-fe5b2405242d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d0ca664-966b-427a-9fdd-fe5b2405242d', 2, NULL, 'Pray Goody', 'Pray Goody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2246 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d0ca664-966b-427a-9fdd-fe5b2405242d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'The Crocodile', part.name_en = 'The Crocodile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2246 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:739166f4-001e-4eab-adf0-58e0d41fa836' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:739166f4-001e-4eab-adf0-58e0d41fa836', 3, NULL, 'The Crocodile', 'The Crocodile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2246 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:739166f4-001e-4eab-adf0-58e0d41fa836'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tom Bowling', part.name_en = 'Tom Bowling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2246 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:78a7f370-4498-4c96-8bc9-9b4950aeeeb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78a7f370-4498-4c96-8bc9-9b4950aeeeb5', 4, NULL, 'Tom Bowling', 'Tom Bowling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2246 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78a7f370-4498-4c96-8bc9-9b4950aeeeb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'The Holly and the Ivy', part.name_en = 'The Holly and the Ivy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2246 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:af8bff67-c44d-43dc-bb9c-3ef07bb257ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af8bff67-c44d-43dc-bb9c-3ef07bb257ca', 5, NULL, 'The Holly and the Ivy', 'The Holly and the Ivy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2246 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af8bff67-c44d-43dc-bb9c-3ef07bb257ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'I Wonder as I Wander', part.name_en = 'I Wonder as I Wander',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2246 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:bb55614d-16e4-482e-b84d-d7c3fbbe4295' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb55614d-16e4-482e-b84d-d7c3fbbe4295', 6, NULL, 'I Wonder as I Wander', 'I Wonder as I Wander', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2246 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb55614d-16e4-482e-b84d-d7c3fbbe4295'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Greensleeves', part.name_en = 'Greensleeves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2246 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d3d15577-ee51-4d93-a88a-7d6ca64c6efe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3d15577-ee51-4d93-a88a-7d6ca64c6efe', 7, NULL, 'Greensleeves', 'Greensleeves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2246 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3d15577-ee51-4d93-a88a-7d6ca64c6efe'
);


-- None 가곡 <Tradition>

UPDATE pieces piece
SET piece.title = '가곡 <Tradition>', piece.title_en = 'Tradition',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2032 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Twelve Variations on a Theme

UPDATE pieces piece
SET piece.title = 'Twelve Variations on a Theme', piece.title_en = 'Twelve Variations on a Theme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2481 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Insect Pieces for oboe and piano

UPDATE pieces piece
SET piece.title = 'Two Insect Pieces for oboe and piano', piece.title_en = 'Two Insect Pieces for oboe and piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2139 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Two Lullabies for Piano Duo

UPDATE pieces piece
SET piece.title = 'Two Lullabies for Piano Duo', piece.title_en = 'Two Lullabies for Piano Duo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1975 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lullaby', part.name_en = 'Two Lullabies for Piano Duo: I. Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1975 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d652562b-c53c-49dd-a450-be71fe4176c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d652562b-c53c-49dd-a450-be71fe4176c7', 1, 'I', 'Lullaby', 'Two Lullabies for Piano Duo: I. Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1975 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d652562b-c53c-49dd-a450-be71fe4176c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lullaby for a Retired Colonel', part.name_en = 'Two Lullabies for Piano Duo: II. Lullaby for a Retired Colonel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1975 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:a138ebc8-5a92-40aa-9351-56fb97d05fa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a138ebc8-5a92-40aa-9351-56fb97d05fa6', 2, 'II', 'Lullaby for a Retired Colonel', 'Two Lullabies for Piano Duo: II. Lullaby for a Retired Colonel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1975 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a138ebc8-5a92-40aa-9351-56fb97d05fa6'
);


-- None 2개의 바이올린 소품

UPDATE pieces piece
SET piece.title = '2개의 바이올린 소품', piece.title_en = 'Two Pieces for Violin, Viola and Piano',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1660 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Un poco andante', part.name_en = 'Two Pieces for Violin, Viola and Piano: I. Un poco andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1660 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:62e2f947-189f-455f-824e-5689470f7e44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62e2f947-189f-455f-824e-5689470f7e44', 1, 'I', 'Un poco andante', 'Two Pieces for Violin, Viola and Piano: I. Un poco andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1660 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e2f947-189f-455f-824e-5689470f7e44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro con molto moto', part.name_en = 'Two Pieces for Violin, Viola and Piano: II. Allegro con molto moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1660 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:74275fa2-cd71-48b9-93d3-c8cb7a4f46ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74275fa2-cd71-48b9-93d3-c8cb7a4f46ef', 2, 'II', 'Allegro con molto moto', 'Two Pieces for Violin, Viola and Piano: II. Allegro con molto moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1660 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74275fa2-cd71-48b9-93d3-c8cb7a4f46ef'
);


-- None Two Portraits

UPDATE pieces piece
SET piece.title = 'Two Portraits', piece.title_en = 'Two Portraits',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1594 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '"David Layton". Poco presto', part.name_en = 'Two Portraits: No. 1. "David Layton". Poco presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1594 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:39bdf764-686c-4125-b710-9a038a40202b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39bdf764-686c-4125-b710-9a038a40202b', 1, NULL, '"David Layton". Poco presto', 'Two Portraits: No. 1. "David Layton". Poco presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1594 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39bdf764-686c-4125-b710-9a038a40202b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '"E.B.B.". Poco lento', part.name_en = 'Two Portraits: No. 2. "E.B.B.". Poco lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1594 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:7c2ade86-bdec-4a26-a413-5c9bba378d5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c2ade86-bdec-4a26-a413-5c9bba378d5a', 2, NULL, '"E.B.B.". Poco lento', 'Two Portraits: No. 2. "E.B.B.". Poco lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1594 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c2ade86-bdec-4a26-a413-5c9bba378d5a'
);


-- None 가곡 <Um Mitternacht>

UPDATE pieces piece
SET piece.title = '가곡 <Um Mitternacht>', piece.title_en = 'Um Mitternacht',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2866 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Underneath the Abject Willow>

UPDATE pieces piece
SET piece.title = '가곡 <Underneath the Abject Willow>', piece.title_en = 'Underneath the Abject Willow',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1435 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Untitled Fragment for Strings

UPDATE pieces piece
SET piece.title = 'Untitled Fragment for Strings', piece.title_en = 'Untitled Fragment for Strings',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 970 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 변주곡

UPDATE pieces piece
SET piece.title = '변주곡', piece.title_en = 'Variations',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2751 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Like an improvisation', part.name_en = 'Variations: I. Like an improvisation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2751 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c6486342-9b9a-4a7a-8ac5-f27b548d3495' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6486342-9b9a-4a7a-8ac5-f27b548d3495', 1, NULL, 'Like an improvisation', 'Variations: I. Like an improvisation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2751 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6486342-9b9a-4a7a-8ac5-f27b548d3495'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Variations: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2751 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:79061196-c5c8-403c-873f-22b85dad30a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79061196-c5c8-403c-873f-22b85dad30a7', 2, NULL, 'II', 'Variations: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2751 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79061196-c5c8-403c-873f-22b85dad30a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Variations: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2751 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d2c2bed6-02b9-41e0-b93d-7b6e066e92a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2c2bed6-02b9-41e0-b93d-7b6e066e92a9', 3, NULL, 'III', 'Variations: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2751 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2c2bed6-02b9-41e0-b93d-7b6e066e92a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Variations: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2751 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9defa4f0-5989-425d-bc22-5bd1c57d98b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9defa4f0-5989-425d-bc22-5bd1c57d98b9', 4, NULL, 'IV', 'Variations: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2751 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9defa4f0-5989-425d-bc22-5bd1c57d98b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'V', part.name_en = 'Variations: V.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2751 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d6502930-fac7-4971-885a-d8b6fb46c9fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6502930-fac7-4971-885a-d8b6fb46c9fe', 5, NULL, 'V', 'Variations: V.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2751 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6502930-fac7-4971-885a-d8b6fb46c9fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'VI', part.name_en = 'Variations: VI.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2751 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d7a164f3-a685-4f72-8ab4-60060c730c4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7a164f3-a685-4f72-8ab4-60060c730c4a', 6, NULL, 'VI', 'Variations: VI.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2751 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a164f3-a685-4f72-8ab4-60060c730c4a'
);


-- Op. 10 Variations on a Theme by Frank Bridge

UPDATE pieces piece
SET piece.title = 'Variations on a Theme by Frank Bridge', piece.title_en = 'Variations on a Theme by Frank Bridge, op. 10',
    piece.type = 'album', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2686 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Introduction and Theme. Lento maestoso', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: I. Introduction and Theme. Lento maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:acee5e71-1725-314d-b7ba-edba72bae60c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acee5e71-1725-314d-b7ba-edba72bae60c', 1, 'I', 'Introduction and Theme. Lento maestoso', 'Variations on a Theme by Frank Bridge, op. 10: I. Introduction and Theme. Lento maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acee5e71-1725-314d-b7ba-edba72bae60c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b1ded99b-9c0f-3d10-bc0e-e322c6a61f54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1ded99b-9c0f-3d10-bc0e-e322c6a61f54', 2, 'II', 'Adagio', 'Variations on a Theme by Frank Bridge, op. 10: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1ded99b-9c0f-3d10-bc0e-e322c6a61f54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'March. Presto alla marcia', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: III. March. Presto alla marcia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c136a2b4-7ddf-357e-9644-6d7e980c15bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c136a2b4-7ddf-357e-9644-6d7e980c15bd', 3, 'III', 'March. Presto alla marcia', 'Variations on a Theme by Frank Bridge, op. 10: III. March. Presto alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c136a2b4-7ddf-357e-9644-6d7e980c15bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Romance. Allegretto grazioso', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: IV. Romance. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:89a373ef-089d-312d-b561-a4cebf5dad25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89a373ef-089d-312d-b561-a4cebf5dad25', 4, 'IV', 'Romance. Allegretto grazioso', 'Variations on a Theme by Frank Bridge, op. 10: IV. Romance. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89a373ef-089d-312d-b561-a4cebf5dad25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Aria italiana. Allegro brillante', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: V. Aria italiana. Allegro brillante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:083f9a96-de7a-39c0-9b37-2221a2e97196' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:083f9a96-de7a-39c0-9b37-2221a2e97196', 5, 'V', 'Aria italiana. Allegro brillante', 'Variations on a Theme by Frank Bridge, op. 10: V. Aria italiana. Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:083f9a96-de7a-39c0-9b37-2221a2e97196'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Bourrée classique. Allegro e pesante', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: VI. Bourrée classique. Allegro e pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d4174464-ec99-3174-a6e8-188a418ce242' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4174464-ec99-3174-a6e8-188a418ce242', 6, 'VI', 'Bourrée classique. Allegro e pesante', 'Variations on a Theme by Frank Bridge, op. 10: VI. Bourrée classique. Allegro e pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4174464-ec99-3174-a6e8-188a418ce242'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Wiener Walzer. Lento - Vivace', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: VII. Wiener Walzer. Lento - Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:297b7b7d-5209-320f-b683-1ff9a5267c98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:297b7b7d-5209-320f-b683-1ff9a5267c98', 7, 'VII', 'Wiener Walzer. Lento - Vivace', 'Variations on a Theme by Frank Bridge, op. 10: VII. Wiener Walzer. Lento - Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:297b7b7d-5209-320f-b683-1ff9a5267c98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Moto perpetuo. Allegro molto', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: VIII. Moto perpetuo. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c561046b-b04f-3694-961e-5e8e98f30512' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c561046b-b04f-3694-961e-5e8e98f30512', 8, 'VIII', 'Moto perpetuo. Allegro molto', 'Variations on a Theme by Frank Bridge, op. 10: VIII. Moto perpetuo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c561046b-b04f-3694-961e-5e8e98f30512'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Funeral march. Andante ritmico', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: IX. Funeral march. Andante ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b08a2377-70f9-361c-b2d4-319648b6c5af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b08a2377-70f9-361c-b2d4-319648b6c5af', 9, 'IX', 'Funeral march. Andante ritmico', 'Variations on a Theme by Frank Bridge, op. 10: IX. Funeral march. Andante ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b08a2377-70f9-361c-b2d4-319648b6c5af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Chant. Lento', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: X. Chant. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3ab9151c-a891-307d-9bb1-e0db895d2ddb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ab9151c-a891-307d-9bb1-e0db895d2ddb', 10, 'X', 'Chant. Lento', 'Variations on a Theme by Frank Bridge, op. 10: X. Chant. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ab9151c-a891-307d-9bb1-e0db895d2ddb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Fugue and Finale. Allegro molto vivace - Lento e solenne', part.name_en = 'Variations on a Theme by Frank Bridge, op. 10: XI. Fugue and Finale. Allegro molto vivace - Lento e solenne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2686 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e27b892a-cf9a-3aba-8baa-ca53f0342e07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e27b892a-cf9a-3aba-8baa-ca53f0342e07', 11, 'XI', 'Fugue and Finale. Allegro molto vivace - Lento e solenne', 'Variations on a Theme by Frank Bridge, op. 10: XI. Fugue and Finale. Allegro molto vivace - Lento e solenne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2686 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e27b892a-cf9a-3aba-8baa-ca53f0342e07'
);


-- None 가곡 <Venite exultemus domino>

UPDATE pieces piece
SET piece.title = '가곡 <Venite exultemus domino>', piece.title_en = 'Venite exultemus domino',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 795 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Village Organist's Piece

UPDATE pieces piece
SET piece.title = 'Village Organist''s Piece', piece.title_en = 'Village Organist''s Piece',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 982 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 바이올린 협주곡

UPDATE pieces piece
SET piece.title = '바이올린 협주곡', piece.title_en = 'Violin Concerto, op. 15',
    piece.type = 'album', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1820 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato con moto', part.name_en = 'Violin Concerto, op. 15: I. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1820 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:78bf3fac-07c6-389d-a8b2-b8dfa6b0df1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78bf3fac-07c6-389d-a8b2-b8dfa6b0df1b', 1, 'I', 'Moderato con moto', 'Violin Concerto, op. 15: I. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1820 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78bf3fac-07c6-389d-a8b2-b8dfa6b0df1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vivace - Cadenza', part.name_en = 'Violin Concerto, op. 15: II. Vivace - Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1820 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:f10fddb3-63fb-3e3a-be2f-77327e4beb9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f10fddb3-63fb-3e3a-be2f-77327e4beb9e', 2, 'II', 'Vivace - Cadenza', 'Violin Concerto, op. 15: II. Vivace - Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1820 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f10fddb3-63fb-3e3a-be2f-77327e4beb9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Passacaglia - Andante lento', part.name_en = 'Violin Concerto, op. 15: III. Passacaglia - Andante lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1820 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fb5fc664-6b66-3003-898b-b742510d9757' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb5fc664-6b66-3003-898b-b742510d9757', 3, 'III', 'Passacaglia - Andante lento', 'Violin Concerto, op. 15: III. Passacaglia - Andante lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1820 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb5fc664-6b66-3003-898b-b742510d9757'
);


-- Op. 75 Voices for Today

UPDATE pieces piece
SET piece.title = 'Voices for Today', piece.title_en = 'Voices for Today, op. 75',
    piece.type = 'song', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1235 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Voluntary on Tallis' Lamentation

UPDATE pieces piece
SET piece.title = 'Voluntary on Tallis'' Lamentation', piece.title_en = 'Voluntary on Tallis'' Lamentation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1491 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Voluntary on Tallis' Lamentations

UPDATE pieces piece
SET piece.title = 'Voluntary on Tallis'' Lamentations', piece.title_en = 'Voluntary on Tallis'' Lamentations',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1004 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 66 War Requiem

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Requiem aeternam', part.name_en = 'War Requiem, op. 66: I. Requiem aeternam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 358 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:46df5b6d-15b8-3608-a7cd-a091c16a77cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46df5b6d-15b8-3608-a7cd-a091c16a77cf', 1, 'I', 'Requiem aeternam', 'War Requiem, op. 66: I. Requiem aeternam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 358 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46df5b6d-15b8-3608-a7cd-a091c16a77cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dies irae', part.name_en = 'War Requiem, op. 66: II. Dies irae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 358 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:300480aa-905e-365c-8a33-53bea289a749' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:300480aa-905e-365c-8a33-53bea289a749', 2, 'II', 'Dies irae', 'War Requiem, op. 66: II. Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 358 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:300480aa-905e-365c-8a33-53bea289a749'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Offertorium', part.name_en = 'War Requiem, op. 66: III. Offertorium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 358 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:3acac55d-b574-3166-be6e-258da87ec89c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3acac55d-b574-3166-be6e-258da87ec89c', 3, 'III', 'Offertorium', 'War Requiem, op. 66: III. Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 358 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3acac55d-b574-3166-be6e-258da87ec89c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Sanctus', part.name_en = 'War Requiem, op. 66: IV. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 358 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:b7ac2d5c-c37f-3ab9-a3eb-42421df66bba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7ac2d5c-c37f-3ab9-a3eb-42421df66bba', 4, 'IV', 'Sanctus', 'War Requiem, op. 66: IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 358 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7ac2d5c-c37f-3ab9-a3eb-42421df66bba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Agnus Dei', part.name_en = 'War Requiem, op. 66: V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 358 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:d9eb4f7e-5af7-334f-9f3f-bd17efec2d28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9eb4f7e-5af7-334f-9f3f-bd17efec2d28', 5, 'V', 'Agnus Dei', 'War Requiem, op. 66: V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 358 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9eb4f7e-5af7-334f-9f3f-bd17efec2d28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Libera me', part.name_en = 'War Requiem, op. 66: VI. Libera me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 358 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c9268981-15ff-30be-a660-484384bcf898' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9268981-15ff-30be-a660-484384bcf898', 6, 'VI', 'Libera me', 'War Requiem, op. 66: VI. Libera me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 358 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9268981-15ff-30be-a660-484384bcf898'
);


-- Op. 95 가곡 <Welcome Ode>

UPDATE pieces piece
SET piece.title = '가곡 <Welcome Ode>', piece.title_en = 'Welcome Ode, op. 95',
    piece.type = 'song', piece.opus_number = 'Op. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2990 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <What's in Your Mind?>

UPDATE pieces piece
SET piece.title = '가곡 <What''s in Your Mind?>', piece.title_en = 'What''s in Your Mind?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2409 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <When You’re Feeling Like Expressing Your Affection>

UPDATE pieces piece
SET piece.title = '가곡 <When You’re Feeling Like Expressing Your Affection>', piece.title_en = 'When You’re Feeling Like Expressing Your Affection',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1232 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 84 연가곡집 <Who Are These Children?> Op. 84

UPDATE pieces piece
SET piece.title = '연가곡집 <Who Are These Children?> Op. 84', piece.title_en = 'Who Are These Children?, op. 84',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '84',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 936 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A Riddle (The Earth)', part.name_en = 'Who Are These Children?, op. 84: A Riddle (The Earth)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:9f14521b-1f3c-42bd-9fd1-4078de9d79d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f14521b-1f3c-42bd-9fd1-4078de9d79d9', 1, NULL, 'A Riddle (The Earth)', 'Who Are These Children?, op. 84: A Riddle (The Earth)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f14521b-1f3c-42bd-9fd1-4078de9d79d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A Laddie’s Sang', part.name_en = 'Who Are These Children?, op. 84: A Laddie’s Sang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:fe088c25-15f2-4277-9455-0182caf7cccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe088c25-15f2-4277-9455-0182caf7cccf', 2, NULL, 'A Laddie’s Sang', 'Who Are These Children?, op. 84: A Laddie’s Sang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe088c25-15f2-4277-9455-0182caf7cccf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nightmare', part.name_en = 'Who Are These Children?, op. 84: Nightmare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:294e39fb-09cc-490c-9602-7d971f3fcee3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:294e39fb-09cc-490c-9602-7d971f3fcee3', 3, NULL, 'Nightmare', 'Who Are These Children?, op. 84: Nightmare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:294e39fb-09cc-490c-9602-7d971f3fcee3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Black Day', part.name_en = 'Who Are These Children?, op. 84: Black Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:c514e048-d819-4947-b78c-4a1b5da428e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c514e048-d819-4947-b78c-4a1b5da428e7', 4, NULL, 'Black Day', 'Who Are These Children?, op. 84: Black Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c514e048-d819-4947-b78c-4a1b5da428e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Bed-Time', part.name_en = 'Who Are These Children?, op. 84: Bed-Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:e82c0844-7e92-4b86-accd-150bea24de99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e82c0844-7e92-4b86-accd-150bea24de99', 5, NULL, 'Bed-Time', 'Who Are These Children?, op. 84: Bed-Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e82c0844-7e92-4b86-accd-150bea24de99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Slaughter', part.name_en = 'Who Are These Children?, op. 84: Slaughter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:4f03e251-149a-4590-8793-34a4fb858b0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f03e251-149a-4590-8793-34a4fb858b0f', 6, NULL, 'Slaughter', 'Who Are These Children?, op. 84: Slaughter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f03e251-149a-4590-8793-34a4fb858b0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'A Riddle (The Child You Were)', part.name_en = 'Who Are These Children?, op. 84: A Riddle (The Child You Were)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:45cb7e72-1a3c-4b46-9a17-19c5f92e1d15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45cb7e72-1a3c-4b46-9a17-19c5f92e1d15', 7, NULL, 'A Riddle (The Child You Were)', 'Who Are These Children?, op. 84: A Riddle (The Child You Were)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45cb7e72-1a3c-4b46-9a17-19c5f92e1d15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'The Larky Lad', part.name_en = 'Who Are These Children?, op. 84: The Larky Lad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:2b56c4c1-4c1c-4a17-8e23-1fe6f1d35628' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b56c4c1-4c1c-4a17-8e23-1fe6f1d35628', 8, NULL, 'The Larky Lad', 'Who Are These Children?, op. 84: The Larky Lad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b56c4c1-4c1c-4a17-8e23-1fe6f1d35628'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Who Are These Children?', part.name_en = 'Who Are These Children?, op. 84: Who Are These Children?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:af5da364-82bd-43e9-964e-f2889fc517fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af5da364-82bd-43e9-964e-f2889fc517fe', 9, NULL, 'Who Are These Children?', 'Who Are These Children?, op. 84: Who Are These Children?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af5da364-82bd-43e9-964e-f2889fc517fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Supper', part.name_en = 'Who Are These Children?, op. 84: Supper',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:eae3796f-964e-4405-b575-328c46cbae43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eae3796f-964e-4405-b575-328c46cbae43', 10, NULL, 'Supper', 'Who Are These Children?, op. 84: Supper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae3796f-964e-4405-b575-328c46cbae43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'The Children', part.name_en = 'Who Are These Children?, op. 84: The Children',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:6d59dd76-20b7-4ffe-b481-098d8cdfcb29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d59dd76-20b7-4ffe-b481-098d8cdfcb29', 11, NULL, 'The Children', 'Who Are These Children?, op. 84: The Children', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d59dd76-20b7-4ffe-b481-098d8cdfcb29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'The Auld Aik', part.name_en = 'Who Are These Children?, op. 84: The Auld Aik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 936 AND p.composer_id = 94 AND part.part_key = 'musicbrainz:84299939-c8eb-46e7-90f3-721e8f5ec83b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84299939-c8eb-46e7-90f3-721e8f5ec83b', 12, NULL, 'The Auld Aik', 'Who Are These Children?, op. 84: The Auld Aik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 936 AND p.composer_id = 94
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84299939-c8eb-46e7-90f3-721e8f5ec83b'
);


-- None 가곡 <Wild With Passion>

UPDATE pieces piece
SET piece.title = '가곡 <Wild With Passion>', piece.title_en = 'Wild With Passion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1753 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 16 Young Apollo

UPDATE pieces piece
SET piece.title = 'Young Apollo', piece.title_en = 'Young Apollo, op. 16',
    piece.type = 'song', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1369 AND piece.composer_id = 94
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 28 연가곡집 <A Ceremony of Carols>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <A Ceremony of Carols>', 'A Ceremony of Carols, op. 28', 'album', 'Op. 28', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <A Ceremony of Carols>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9ae3de3-dc15-4d19-b8db-13d155d71eda'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9ae3de3-dc15-4d19-b8db-13d155d71eda'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9ae3de3-dc15-4d19-b8db-13d155d71eda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47ce8dad-da79-34cc-a0c1-1ce3b3b0452e', 1, 'I', 'Procession', 'A Ceremony of Carols, op. 28: I. Procession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47ce8dad-da79-34cc-a0c1-1ce3b3b0452e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c664c6a-23e9-315e-a8e1-6dc1b8d9ecd9', 2, 'II', 'Wolcum Yole!', 'A Ceremony of Carols, op. 28: II. Wolcum Yole!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c664c6a-23e9-315e-a8e1-6dc1b8d9ecd9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e74b9af6-3733-30b5-8bd0-9550a6c95527', 3, 'III', 'There is no Rose', 'A Ceremony of Carols, op. 28: III. There is no Rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e74b9af6-3733-30b5-8bd0-9550a6c95527'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfcb109a-b26b-340e-8006-1c51b6c4576b', 4, 'IV', '(a) That yongë child', 'A Ceremony of Carols, op. 28: IV. (a) That yongë child', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfcb109a-b26b-340e-8006-1c51b6c4576b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1cd17e9-498a-35a0-9ae9-ec99c51e00ed', 5, 'IV', '(b) Balulalow', 'A Ceremony of Carols, op. 28: IV. (b) Balulalow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1cd17e9-498a-35a0-9ae9-ec99c51e00ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2168f7d-77c2-39b8-85f5-e135b0d319ef', 6, 'V', 'As dew in Aprille', 'A Ceremony of Carols, op. 28: V. As dew in Aprille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2168f7d-77c2-39b8-85f5-e135b0d319ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1afa5510-35f0-30b2-8ae1-cd78621edef2', 7, 'VI', 'This little babe', 'A Ceremony of Carols, op. 28: VI. This little babe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1afa5510-35f0-30b2-8ae1-cd78621edef2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aba3abc9-78ec-3b04-85d9-b78e87342ede', 8, 'VIII', 'In Freezing Winter Night', 'A Ceremony of Carols, op. 28: VIII. In Freezing Winter Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aba3abc9-78ec-3b04-85d9-b78e87342ede'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f4cf644-1fd4-3781-a903-4cfa2426bd07', 9, 'IX', 'Spring Carol', 'A Ceremony of Carols, op. 28: IX. Spring Carol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f4cf644-1fd4-3781-a903-4cfa2426bd07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1ba4596-c258-38c0-9c1c-29308eb979e7', 10, 'X', 'Deo gracias!', 'A Ceremony of Carols, op. 28: X. Deo gracias!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1ba4596-c258-38c0-9c1c-29308eb979e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5ac5a18-3dad-3194-9813-367cad98d6bf', 11, 'XI', 'Recession', 'A Ceremony of Carols, op. 28: XI. Recession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Ceremony of Carols>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5ac5a18-3dad-3194-9813-367cad98d6bf'
);


-- Op. 41 연가곡집 <A Charm of Lullabies> Op. 41

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <A Charm of Lullabies> Op. 41', 'A Charm of Lullabies, op. 41', 'album', NULL, 'Op.', '41', NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <A Charm of Lullabies> Op. 41'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c7b2583-ada9-45e0-b4b5-0b6ddff47290'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c7b2583-ada9-45e0-b4b5-0b6ddff47290'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Charm of Lullabies> Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c7b2583-ada9-45e0-b4b5-0b6ddff47290'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e75fd21-555b-336a-afc0-3edf7c7fed2e', 1, NULL, 'A Cradle Song', 'A Charm of Lullabies, op. 41: No. 1. A Cradle Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Charm of Lullabies> Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e75fd21-555b-336a-afc0-3edf7c7fed2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee0482b-4480-3beb-9d60-43714a8c406f', 2, NULL, 'The Highland Balou', 'A Charm of Lullabies, op. 41: No. 2. The Highland Balou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Charm of Lullabies> Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee0482b-4480-3beb-9d60-43714a8c406f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3467949-ce5b-3023-b4a0-77edeac0ad6e', 3, NULL, 'Sephestia’s Lullaby', 'A Charm of Lullabies, op. 41: No. 3. Sephestia’s Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Charm of Lullabies> Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3467949-ce5b-3023-b4a0-77edeac0ad6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53b16634-6f60-376c-8559-db9896cbf49d', 4, NULL, 'A Charm', 'A Charm of Lullabies, op. 41: No. 4. A Charm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Charm of Lullabies> Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53b16634-6f60-376c-8559-db9896cbf49d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf4e069c-481e-34c2-801d-6ec09dc31b2a', 5, NULL, 'The Nurse’s Song', 'A Charm of Lullabies, op. 41: No. 5. The Nurse’s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <A Charm of Lullabies> Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf4e069c-481e-34c2-801d-6ec09dc31b2a'
);


-- None 가곡 <A Hymn To The Virgin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <A Hymn To The Virgin>', 'A Hymn To The Virgin', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <A Hymn To The Virgin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9aaaf5aa-7e26-4875-aaf8-684ebe1a2e1d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9aaaf5aa-7e26-4875-aaf8-684ebe1a2e1d'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '가곡 <A Hymn To The Virgin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9aaaf5aa-7e26-4875-aaf8-684ebe1a2e1d'
);


-- None 오페라 <Billy Budd>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Billy Budd>', 'Billy Budd', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Billy Budd>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef2a7ebb-20d0-46a0-aa25-e750cbb5cd9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef2a7ebb-20d0-46a0-aa25-e750cbb5cd9c'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '오페라 <Billy Budd>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef2a7ebb-20d0-46a0-aa25-e750cbb5cd9c'
);


-- None Folksong Arrangements, Volume IV: Moore's Irish Melodies, for voice & piano

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano', 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d72173d-216c-45d6-a212-54cf7df142d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0d72173d-216c-45d6-a212-54cf7df142d9'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d72173d-216c-45d6-a212-54cf7df142d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2596c0e0-2966-4972-a65d-ec0094cf124a', 1, NULL, 'Sail on, sail on', 'Folk Song Arrangements, Vol. 4, "Moore''s Irish Melodies": No. 2. Sail on, sail on', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2596c0e0-2966-4972-a65d-ec0094cf124a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26611159-27a3-4682-b6d2-0d9b66b14881', 2, NULL, 'Rich and Rare', 'Folk Song Arrangements, Vol. 4, "Moore''s Irish Melodies": No. 6. Rich and Rare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26611159-27a3-4682-b6d2-0d9b66b14881'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ea5e16-e760-492e-aed6-5781b120aa09', 3, NULL, 'Avenging and Bright', 'Folk Song Arrangements, Vol. 4, "Moore''s Irish Melodies": No. 1. Avenging and Bright', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ea5e16-e760-492e-aed6-5781b120aa09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42e08d83-3aa5-401d-b7b8-c7ae74839f35', 4, NULL, 'The Minstrel Boy', 'Folk Song Arrangements, Vol. 4, "Moore''s Irish Melodies": No. 4. The Minstrel Boy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42e08d83-3aa5-401d-b7b8-c7ae74839f35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6eb9ee44-281f-40a8-a8cf-6120dfd8c06e', 5, NULL, 'Oft in the Stilly Night', 'Oft in the Stilly Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eb9ee44-281f-40a8-a8cf-6120dfd8c06e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9109325b-f85b-4994-acbb-c01a78d0a9cb', 6, NULL, 'At the Mid Hour of Night', 'Folk Song Arrangements, Vol. 4, "Moore''s Irish Melodies": No. 5. At the Mid Hour of Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9109325b-f85b-4994-acbb-c01a78d0a9cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aac355eb-d30e-490d-883d-748fb8d84026', 7, NULL, 'The Last Rose of Summer', 'Folk Song Arrangements, Vol. 4, "Moore''s Irish Melodies": No. 9. The Last Rose of Summer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aac355eb-d30e-490d-883d-748fb8d84026'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaa93f27-7cec-493a-a3d7-175420b1825a', 8, NULL, 'How Sweet the Answer', 'Folk Song Arrangements, Vol. 4, "Moore''s Irish Melodies": No. 3. How Sweet the Answer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Folksong Arrangements, Volume IV: Moore''s Irish Melodies, for voice & piano' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaa93f27-7cec-493a-a3d7-175420b1825a'
);


-- None 녹턴

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴', 'Nocturne', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4d02993-bb36-3fd5-ab98-1a7aca491a17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4d02993-bb36-3fd5-ab98-1a7aca491a17'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '녹턴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4d02993-bb36-3fd5-ab98-1a7aca491a17'
);


-- Op. 38 Occasional Overture

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Occasional Overture', 'Occasional Overture, op. 38', 'song', 'Op. 38', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Occasional Overture'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f37caa88-9a10-4f69-b22e-a17b18440ba4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f37caa88-9a10-4f69-b22e-a17b18440ba4'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Occasional Overture' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f37caa88-9a10-4f69-b22e-a17b18440ba4'
);


-- Op. 30 칸타타 <Rejoice in the Lamb>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Rejoice in the Lamb>', 'Rejoice in the Lamb, op. 30', 'album', 'Op. 30', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Rejoice in the Lamb>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60e6ff5e-41e4-4795-a981-7e3e49c7fae9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '60e6ff5e-41e4-4795-a981-7e3e49c7fae9'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60e6ff5e-41e4-4795-a981-7e3e49c7fae9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:373ab24e-3251-44ec-bfd6-7cb7a72db24e', 1, 'I', '“Rejoice in God, O ye Tongues”', 'Rejoice in the Lamb, op. 30: I. “Rejoice in God, O ye Tongues”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:373ab24e-3251-44ec-bfd6-7cb7a72db24e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c1c031b-8708-41e9-8484-9c10ecf55916', 2, 'II', '“For I will consider my Cat Jeoffrey”', 'Rejoice in the Lamb, op. 30: II. “For I will consider my Cat Jeoffrey”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c1c031b-8708-41e9-8484-9c10ecf55916'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d22aa947-c274-4a6e-a9d9-00eb5fe6d08b', 3, 'III', '“For the Mouse is a creature of great personal valour”', 'Rejoice in the Lamb, op. 30: III. “For the Mouse is a creature of great personal valour”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d22aa947-c274-4a6e-a9d9-00eb5fe6d08b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a279525-9d9d-4248-8556-d8260c22c159', 4, 'IV', '“For the flowers are great blessings”', 'Rejoice in the Lamb, op. 30: IV. “For the flowers are great blessings”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a279525-9d9d-4248-8556-d8260c22c159'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bef10d0-6e22-449f-ad7b-3e2cab593c3d', 5, 'V', '“For I am under the same accusation with my Saviour”', 'Rejoice in the Lamb, op. 30: V. “For I am under the same accusation with my Saviour”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bef10d0-6e22-449f-ad7b-3e2cab593c3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dd23d9f-b58c-4b47-9948-2720942dab05', 6, 'VI', '“For H is a spirit and therefore he is God”', 'Rejoice in the Lamb, op. 30: VI. “For H is a spirit and therefore he is God”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dd23d9f-b58c-4b47-9948-2720942dab05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41820979-8b5f-4115-bb9c-5d0f4ca51f27', 7, 'VII', '“For the instruments are by their rhimes”', 'Rejoice in the Lamb, op. 30: VII. “For the instruments are by their rhimes”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41820979-8b5f-4115-bb9c-5d0f4ca51f27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15029e70-c64e-4d9b-a236-af768857dcd5', 8, 'VIII', '“For at that time malignity ceases”', 'Rejoice in the Lamb, op. 30: VIII. “For at that time malignity ceases”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15029e70-c64e-4d9b-a236-af768857dcd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5465667a-8747-405a-b586-742f798847bc', 9, 'IX', '“Hallelujah from the heart of God”', 'Rejoice in the Lamb, op. 30: IX. “Hallelujah from the heart of God”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '칸타타 <Rejoice in the Lamb>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5465667a-8747-405a-b586-742f798847bc'
);


-- None Two Insect Pieces for Oboe and Piano, op. posth.

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Two Insect Pieces for Oboe and Piano, op. posth.', 'Two Insect Pieces for Oboe and Piano, op. posth.', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Two Insect Pieces for Oboe and Piano, op. posth.'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6adef734-08f6-42da-904a-ee09b6e6720b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6adef734-08f6-42da-904a-ee09b6e6720b'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Two Insect Pieces for Oboe and Piano, op. posth.' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6adef734-08f6-42da-904a-ee09b6e6720b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:339e0e09-c23c-48dc-9550-b5b529d0cb42', 1, 'I', 'The Grasshopper', 'Two Insect Pieces for Oboe and Piano, Op. posth.: I. The Grasshopper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Two Insect Pieces for Oboe and Piano, op. posth.' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:339e0e09-c23c-48dc-9550-b5b529d0cb42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4235824d-8701-4122-b546-0bdc1005cd44', 2, 'II', 'The Wasp', 'Two Insect Pieces for Oboe and Piano, Op. posth.: II. The Wasp', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = 'Two Insect Pieces for Oboe and Piano, op. posth.' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4235824d-8701-4122-b546-0bdc1005cd44'
);


-- Op. 52 연가곡집 <Winter Words> Op. 52

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <Winter Words> Op. 52', 'Winter Words, op. 52', 'album', NULL, 'Op.', '52', NULL, 'manual', 1
FROM composers c
WHERE c.id = 94
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <Winter Words> Op. 52'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8b9694b-10c1-48d6-aac4-a39ddbd6f353'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8b9694b-10c1-48d6-aac4-a39ddbd6f353'
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8b9694b-10c1-48d6-aac4-a39ddbd6f353'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f848ff7f-3a33-4f1c-b430-848da1c95a63', 1, NULL, 'At Day-close in November', 'Winter Words, op. 52: 1. At Day-close in November', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f848ff7f-3a33-4f1c-b430-848da1c95a63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de4cb610-e7b0-4b6c-9d14-40fde7fe4d0c', 2, NULL, 'Midnight on the Great Western', 'Winter Words, op. 52: 2. Midnight on the Great Western', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de4cb610-e7b0-4b6c-9d14-40fde7fe4d0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4010b392-a4a7-407d-ab58-bf29b4108d32', 3, NULL, 'Wagtail and Baby', 'Winter Words, op. 52: 3. Wagtail and Baby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4010b392-a4a7-407d-ab58-bf29b4108d32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cf7d883-390c-4c48-8926-61dee760f5af', 4, NULL, 'The Little Old Table', 'Winter Words, op. 52: 4. The Little Old Table', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cf7d883-390c-4c48-8926-61dee760f5af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53220b91-ccea-43a8-96eb-7795d2de7ebe', 5, NULL, 'The Choirmaster''s Burial', 'Winter Words, op. 52: 5. The Choirmaster''s Burial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53220b91-ccea-43a8-96eb-7795d2de7ebe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e37a6b9-e2c7-4aef-b814-1b60f2515f81', 6, NULL, 'Proud Songsters', 'Winter Words, op. 52: 6. Proud Songsters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e37a6b9-e2c7-4aef-b814-1b60f2515f81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:137b32b8-d351-4abf-91c7-2b9790b1a851', 7, NULL, 'At the Railway Station, Upway', 'Winter Words, op. 52: 7. At the Railway Station, Upway', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:137b32b8-d351-4abf-91c7-2b9790b1a851'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dd8c906-411d-463a-b953-9ee16e9aef22', 8, NULL, 'Before Life and After', 'Winter Words, op. 52: 8. Before Life and After', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 94 AND p.title = '연가곡집 <Winter Words> Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dd8c906-411d-463a-b953-9ee16e9aef22'
);


-- 카탈로그에 대응이 없는 seed 작품 29개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 94 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    602, 790, 843, 1312, 1326, 1354, 1551, 1697, 1730, 1739, 1764, 1874, 1887, 1896, 1903, 1976, 1979, 2014, 2152, 2183,
    2357, 2453, 2454, 2483, 2554, 2592, 2719, 2976, 3009
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
