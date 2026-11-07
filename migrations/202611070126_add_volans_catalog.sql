-- Kevin Volans 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 26개(묶음 0, 다악장 5, 낱곡 21),
-- 새 작품 1개, part 16개, 그 아래 0개.
-- seed 27개 중 25개를 작품·part 에 잇고, 1개를 숨기고, 1개는 그대로 둔다.
--
-- 5차는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/catalog-wave5-2026-11-07/<작곡가>/(catalog.json·seed_map.json).
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

-- None Canciones del alma

UPDATE pieces piece
SET piece.title = 'Canciones del alma', piece.title_en = 'Canciones del alma',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18706 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cicada

UPDATE pieces piece
SET piece.title = 'Cicada', piece.title_en = 'Cicada',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18007 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto for Piano and Wind Instruments

UPDATE pieces piece
SET piece.title = 'Concerto for Piano and Wind Instruments', piece.title_en = 'Concerto for Piano and Wind Instruments',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19678 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None First Dance from "White Man Sleeps"

UPDATE pieces piece
SET piece.title = 'First Dance from "White Man Sleeps"', piece.title_en = 'First Dance from "White Man Sleeps"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16514 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four Guitars

UPDATE pieces piece
SET piece.title = 'Four Guitars', piece.title_en = 'Four Guitars',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18936 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kneeling Dance

UPDATE pieces piece
SET piece.title = 'Kneeling Dance', piece.title_en = 'Kneeling Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16035 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Leaping Dance

UPDATE pieces piece
SET piece.title = 'Leaping Dance', piece.title_en = 'Leaping Dance',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18149 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lenguas de fuego

UPDATE pieces piece
SET piece.title = 'Lenguas de fuego', piece.title_en = 'Lenguas de fuego',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17854 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Mbira

UPDATE pieces piece
SET piece.title = 'Mbira', piece.title_en = 'Mbira',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20051 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Movement for String Quartet "Notes d’un peintre"

UPDATE pieces piece
SET piece.title = 'Movement for String Quartet "Notes d’un peintre"', piece.title_en = 'Movement for String Quartet "Notes d’un peintre"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16773 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None One Day Fine

UPDATE pieces piece
SET piece.title = 'One Day Fine', piece.title_en = 'One Day Fine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16945 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None She Who Sleeps With a Small Blanket

UPDATE pieces piece
SET piece.title = 'She Who Sleeps With a Small Blanket', piece.title_en = 'She Who Sleeps With a Small Blanket',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17595 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 2번 "Hunting: Gathering"

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 "Hunting: Gathering"', piece.title_en = 'String Quartet no. 2 "Hunting: Gathering"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17091 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'String Quartet no. 2 "Hunting: Gathering": I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17091 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:67ce4dec-e326-457f-93ef-fdce57b42fd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67ce4dec-e326-457f-93ef-fdce57b42fd0', 1, NULL, 'I', 'String Quartet no. 2 "Hunting: Gathering": I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17091 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67ce4dec-e326-457f-93ef-fdce57b42fd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'String Quartet no. 2 "Hunting: Gathering": II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17091 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:d4d09966-9bd3-4a6f-8e53-0c889764055d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4d09966-9bd3-4a6f-8e53-0c889764055d', 2, NULL, 'II', 'String Quartet no. 2 "Hunting: Gathering": II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17091 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4d09966-9bd3-4a6f-8e53-0c889764055d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'String Quartet no. 2 "Hunting: Gathering": III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17091 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:54f0ec59-ee3f-41e6-9685-734805798a5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54f0ec59-ee3f-41e6-9685-734805798a5c', 3, NULL, 'III', 'String Quartet no. 2 "Hunting: Gathering": III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17091 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54f0ec59-ee3f-41e6-9685-734805798a5c'
);


-- None 현악 4중주 3번 "The Songlines"

UPDATE pieces piece
SET piece.title = '현악 4중주 3번 "The Songlines"', piece.title_en = 'String Quartet no. 3 "The Songlines"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17622 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Striding Dance', part.name_en = 'String Quartet no. 3 "The Songlines": I. Striding Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17622 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:0075d56d-1f43-4317-afd4-f68770ea84cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0075d56d-1f43-4317-afd4-f68770ea84cd', 1, 'I', 'Striding Dance', 'String Quartet no. 3 "The Songlines": I. Striding Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17622 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0075d56d-1f43-4317-afd4-f68770ea84cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Songline', part.name_en = 'String Quartet no. 3 "The Songlines": II. Songline',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17622 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:11214ac9-5dd9-47a2-8d5b-d936aafa4e44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11214ac9-5dd9-47a2-8d5b-d936aafa4e44', 2, 'II', 'Songline', 'String Quartet no. 3 "The Songlines": II. Songline', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17622 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11214ac9-5dd9-47a2-8d5b-d936aafa4e44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Standing Dance', part.name_en = 'String Quartet no. 3 "The Songlines": III. Standing Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17622 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:61ccdc84-7f20-4e6a-88a5-0b50f24206fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61ccdc84-7f20-4e6a-88a5-0b50f24206fe', 3, 'III', 'Standing Dance', 'String Quartet no. 3 "The Songlines": III. Standing Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17622 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61ccdc84-7f20-4e6a-88a5-0b50f24206fe'
);


-- None 현악 4중주 4번 "The Ramanujan Notebooks"

UPDATE pieces piece
SET piece.title = '현악 4중주 4번 "The Ramanujan Notebooks"', piece.title_en = 'String Quartet no. 4 "The Ramanujan Notebooks"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17082 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'String Quartet no. 4 "The Ramanujan Notebooks": I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17082 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:b60c091e-33f7-4572-94c6-4d8adfd54649' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b60c091e-33f7-4572-94c6-4d8adfd54649', 1, NULL, 'I', 'String Quartet no. 4 "The Ramanujan Notebooks": I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17082 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60c091e-33f7-4572-94c6-4d8adfd54649'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'String Quartet no. 4 "The Ramanujan Notebooks": II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17082 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:6729a020-a807-4599-9cac-70182f255326' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6729a020-a807-4599-9cac-70182f255326', 2, NULL, 'II', 'String Quartet no. 4 "The Ramanujan Notebooks": II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17082 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6729a020-a807-4599-9cac-70182f255326'
);


-- None 현악 4중주 5번 "Dancers on a Plane"

UPDATE pieces piece
SET piece.title = '현악 4중주 5번 "Dancers on a Plane"', piece.title_en = 'String Quartet no. 5 "Dancers on a Plane"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18031 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 6번

UPDATE pieces piece
SET piece.title = '현악 4중주 6번', piece.title_en = 'String Quartet no. 6',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18988 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Strip-Weave

UPDATE pieces piece
SET piece.title = 'Strip-Weave', piece.title_en = 'Strip-Weave',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19925 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Mountain That Left

UPDATE pieces piece
SET piece.title = 'The Mountain That Left', piece.title_en = 'The Mountain That Left',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16744 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None This Is How It Is

UPDATE pieces piece
SET piece.title = 'This Is How It Is', piece.title_en = 'This Is How It Is',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18544 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Trio Concerto

UPDATE pieces piece
SET piece.title = 'Trio Concerto', piece.title_en = 'Trio Concerto',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16608 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Trio Concerto: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16608 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:0f6c1a05-94c4-4605-a175-4d98ff9ebf94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f6c1a05-94c4-4605-a175-4d98ff9ebf94', 1, NULL, 'I', 'Trio Concerto: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16608 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f6c1a05-94c4-4605-a175-4d98ff9ebf94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Trio Concerto: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16608 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:b72b3e63-38d6-4866-99ea-036a9e5b620b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b72b3e63-38d6-4866-99ea-036a9e5b620b', 2, NULL, 'II', 'Trio Concerto: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16608 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b72b3e63-38d6-4866-99ea-036a9e5b620b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Trio Concerto: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16608 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:5fa44a43-1fdc-4799-af78-67a8e0e99848' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fa44a43-1fdc-4799-af78-67a8e0e99848', 3, NULL, 'III', 'Trio Concerto: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16608 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa44a43-1fdc-4799-af78-67a8e0e99848'
);


-- None Umzi Watsha

UPDATE pieces piece
SET piece.title = 'Umzi Watsha', piece.title_en = 'Umzi Watsha',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19248 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Untitled (In memoriam G.H.V.)

UPDATE pieces piece
SET piece.title = 'Untitled (In memoriam G.H.V.)', piece.title_en = 'Untitled (In memoriam G.H.V.)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17875 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Walking Song

UPDATE pieces piece
SET piece.title = 'Walking Song', piece.title_en = 'Walking Song',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17071 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None White Man Sleeps

UPDATE pieces piece
SET piece.title = 'White Man Sleeps', piece.title_en = 'White Man Sleeps',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16877 AND piece.composer_id = 241
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Fifth Dance', part.name_en = 'White Man Sleeps: Fifth Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16877 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:62c71c2f-a574-4ae4-a7b6-5f82dd787728' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62c71c2f-a574-4ae4-a7b6-5f82dd787728', 1, NULL, 'Fifth Dance', 'White Man Sleeps: Fifth Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16877 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62c71c2f-a574-4ae4-a7b6-5f82dd787728'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'First Dance', part.name_en = 'White Man Sleeps: First Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16877 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:b7e5def3-58fe-49ed-8072-4792f2b44c9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7e5def3-58fe-49ed-8072-4792f2b44c9b', 2, NULL, 'First Dance', 'White Man Sleeps: First Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16877 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7e5def3-58fe-49ed-8072-4792f2b44c9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Fourth Dance', part.name_en = 'White Man Sleeps: Fourth Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16877 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:385a077e-f0c7-4dad-bc5d-efd1a2224396' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:385a077e-f0c7-4dad-bc5d-efd1a2224396', 3, NULL, 'Fourth Dance', 'White Man Sleeps: Fourth Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16877 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:385a077e-f0c7-4dad-bc5d-efd1a2224396'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Second Dance', part.name_en = 'White Man Sleeps: Second Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16877 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:b8c8e5bd-d57d-42ff-8ceb-9b5b6c9a450c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8c8e5bd-d57d-42ff-8ceb-9b5b6c9a450c', 4, NULL, 'Second Dance', 'White Man Sleeps: Second Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16877 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8c8e5bd-d57d-42ff-8ceb-9b5b6c9a450c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Third Dance', part.name_en = 'White Man Sleeps: Third Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16877 AND p.composer_id = 241 AND part.part_key = 'musicbrainz:46195bfd-6d0a-4c16-92e9-6518bef1dada' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46195bfd-6d0a-4c16-92e9-6518bef1dada', 5, NULL, 'Third Dance', 'White Man Sleeps: Third Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16877 AND p.composer_id = 241
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46195bfd-6d0a-4c16-92e9-6518bef1dada'
);


-- None 피아노 협주곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 3번', 'Piano Concerto no. 3', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 241
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15296f78-07c0-47c8-b90f-b0d467fa2adb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15296f78-07c0-47c8-b90f-b0d467fa2adb'
FROM pieces p
WHERE p.composer_id = 241 AND p.title = '피아노 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15296f78-07c0-47c8-b90f-b0d467fa2adb'
);


-- 카탈로그에 대응이 없는 seed 작품 1개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 241 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16407
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
