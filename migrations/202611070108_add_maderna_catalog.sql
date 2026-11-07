-- 브루노 마데르나 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 50개(묶음 3, 다악장 4, 낱곡 43),
-- 새 작품 5개, part 45개, 그 아래 0개.
-- seed 45개 중 45개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None Ages

UPDATE pieces piece
SET piece.title = 'Ages', piece.title_en = 'Ages',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16464 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Amanda

UPDATE pieces piece
SET piece.title = 'Amanda', piece.title_en = 'Amanda',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17653 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aulodia per Lothar

UPDATE pieces piece
SET piece.title = 'Aulodia per Lothar', piece.title_en = 'Aulodia per Lothar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16889 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aura

UPDATE pieces piece
SET piece.title = 'Aura', piece.title_en = 'Aura',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16362 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ausstrahlung

UPDATE pieces piece
SET piece.title = 'Ausstrahlung', piece.title_en = 'Ausstrahlung',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17457 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Biogramma

UPDATE pieces piece
SET piece.title = 'Biogramma', piece.title_en = 'Biogramma',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18849 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Section A', part.name_en = 'Biogramma: Section A',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18849 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:fb46c12b-d57c-4e71-9b8e-95c25e86fac0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb46c12b-d57c-4e71-9b8e-95c25e86fac0', 1, NULL, 'Section A', 'Biogramma: Section A', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18849 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb46c12b-d57c-4e71-9b8e-95c25e86fac0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Section B', part.name_en = 'Biogramma: Section B',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18849 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:7e60b411-688e-4b94-b93d-1f3f71ecf719' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e60b411-688e-4b94-b93d-1f3f71ecf719', 2, NULL, 'Section B', 'Biogramma: Section B', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18849 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e60b411-688e-4b94-b93d-1f3f71ecf719'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Section C', part.name_en = 'Biogramma: Section C',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18849 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:371293ba-244e-4091-86d3-755bf904bc68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:371293ba-244e-4091-86d3-755bf904bc68', 3, NULL, 'Section C', 'Biogramma: Section C', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18849 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:371293ba-244e-4091-86d3-755bf904bc68'
);


-- None Composizione in tre tempi

UPDATE pieces piece
SET piece.title = 'Composizione in tre tempi', piece.title_en = 'Composizione in tre tempi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17632 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro scorrevole', part.name_en = 'Composizione in tre tempi: I. Allegro scorrevole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17632 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:8c4b7a08-f219-4430-976b-78457cd97e7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c4b7a08-f219-4430-976b-78457cd97e7e', 1, 'I', 'Allegro scorrevole', 'Composizione in tre tempi: I. Allegro scorrevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17632 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c4b7a08-f219-4430-976b-78457cd97e7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Composizione in tre tempi: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17632 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:8c585a97-6003-4848-8ed7-9b1247372024' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c585a97-6003-4848-8ed7-9b1247372024', 2, 'II', 'Adagio', 'Composizione in tre tempi: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17632 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c585a97-6003-4848-8ed7-9b1247372024'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante – Allegro – Allegro molto', part.name_en = 'Composizione in tre tempi: III. Andante – Allegro – Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17632 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:11291d38-0ec0-46b1-a0d6-7d53e62003c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11291d38-0ec0-46b1-a0d6-7d53e62003c9', 3, 'III', 'Andante – Allegro – Allegro molto', 'Composizione in tre tempi: III. Andante – Allegro – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17632 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11291d38-0ec0-46b1-a0d6-7d53e62003c9'
);


-- None Composizione no. 1

UPDATE pieces piece
SET piece.title = 'Composizione no. 1', piece.title_en = 'Composizione no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17600 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Composizione no. 2

UPDATE pieces piece
SET piece.title = 'Composizione no. 2', piece.title_en = 'Composizione no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 20093 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto per due pianoforti, percussioni e due arpe

UPDATE pieces piece
SET piece.title = 'Concerto per due pianoforti, percussioni e due arpe', piece.title_en = 'Concerto per due pianoforti, percussioni e due arpe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19408 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Concerto per flauto e orchestra

UPDATE pieces piece
SET piece.title = 'Concerto per flauto e orchestra', piece.title_en = 'Concerto per flauto e orchestra',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18499 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 협주곡 1번

UPDATE pieces piece
SET piece.title = '협주곡 1번', piece.title_en = 'Concerto per oboe e orchestra no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19741 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 협주곡 2번

UPDATE pieces piece
SET piece.title = '협주곡 2번', piece.title_en = 'Concerto per oboe e orchestra no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18483 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 협주곡 3번

UPDATE pieces piece
SET piece.title = '협주곡 3번', piece.title_en = 'Concerto per oboe e orchestra no. 3',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17540 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Continuo

UPDATE pieces piece
SET piece.title = 'Continuo', piece.title_en = 'Continuo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16591 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dialodia

UPDATE pieces piece
SET piece.title = 'Dialodia', piece.title_en = 'Dialodia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18667 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dimensioni II - Invenzione su una voce

UPDATE pieces piece
SET piece.title = 'Dimensioni II - Invenzione su una voce', piece.title_en = 'Dimensioni II - Invenzione su una voce',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19402 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dimensioni III

UPDATE pieces piece
SET piece.title = 'Dimensioni III', piece.title_en = 'Dimensioni III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18692 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dimensioni IV

UPDATE pieces piece
SET piece.title = 'Dimensioni IV', piece.title_en = 'Dimensioni IV',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17779 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Divertimento in due tempi

UPDATE pieces piece
SET piece.title = 'Divertimento in due tempi', piece.title_en = 'Divertimento in due tempi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16109 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I andante', part.name_en = 'Divertimento in due tempi: I andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16109 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:74d0a741-4361-45fc-bed0-600f990f5e68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74d0a741-4361-45fc-bed0-600f990f5e68', 1, NULL, 'I andante', 'Divertimento in due tempi: I andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16109 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74d0a741-4361-45fc-bed0-600f990f5e68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II allegro', part.name_en = 'Divertimento in due tempi: II allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16109 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:ab048ac4-d571-42ac-9756-e4be3e608027' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab048ac4-d571-42ac-9756-e4be3e608027', 2, NULL, 'II allegro', 'Divertimento in due tempi: II allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16109 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab048ac4-d571-42ac-9756-e4be3e608027'
);


-- None 오페라 <Don Perlimplin>

UPDATE pieces piece
SET piece.title = '오페라 <Don Perlimplin>', piece.title_en = 'Don Perlimplin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19210 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Giardino religioso

UPDATE pieces piece
SET piece.title = 'Giardino religioso', piece.title_en = 'Giardino religioso',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18435 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Grande aulodia

UPDATE pieces piece
SET piece.title = 'Grande aulodia', piece.title_en = 'Grande aulodia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18911 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Honeyrêves

UPDATE pieces piece
SET piece.title = 'Honeyrêves', piece.title_en = 'Honeyrêves',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18963 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Improvvisazione no. 1

UPDATE pieces piece
SET piece.title = 'Improvvisazione no. 1', piece.title_en = 'Improvvisazione no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19427 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Improvvisazione no. 2

UPDATE pieces piece
SET piece.title = 'Improvvisazione no. 2', piece.title_en = 'Improvvisazione no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16971 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 영화음악 <La morte ha fatto l'uovo>

UPDATE pieces piece
SET piece.title = '영화음악 <La morte ha fatto l''uovo>', piece.title_en = 'La morte ha fatto l''uovo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19394 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Guaiaba', part.name_en = 'Guaiaba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:5d8800f2-7b0b-471e-8673-a64efcd4e6d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d8800f2-7b0b-471e-8673-a64efcd4e6d1', 1, NULL, 'Guaiaba', 'Guaiaba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d8800f2-7b0b-471e-8673-a64efcd4e6d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Reflection in the Night', part.name_en = 'Reflection in the Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:c0e676dd-a123-4a11-af6c-6d054d455444' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0e676dd-a123-4a11-af6c-6d054d455444', 2, NULL, 'Reflection in the Night', 'Reflection in the Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0e676dd-a123-4a11-af6c-6d054d455444'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Moment', part.name_en = 'Moment',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:8358f8e7-431c-4f09-b610-635e63c190fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8358f8e7-431c-4f09-b610-635e63c190fb', 3, NULL, 'Moment', 'Moment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8358f8e7-431c-4f09-b610-635e63c190fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sigma Alpha', part.name_en = 'Sigma Alpha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:ba011de2-a99e-4bf2-ba34-269cb2e8ff92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba011de2-a99e-4bf2-ba34-269cb2e8ff92', 4, NULL, 'Sigma Alpha', 'Sigma Alpha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba011de2-a99e-4bf2-ba34-269cb2e8ff92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Down Down Down', part.name_en = 'Down Down Down',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:e63e4f8f-0e17-4eca-9e8a-b3bbb87130e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e63e4f8f-0e17-4eca-9e8a-b3bbb87130e2', 5, NULL, 'Down Down Down', 'Down Down Down', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e63e4f8f-0e17-4eca-9e8a-b3bbb87130e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Musical Line', part.name_en = 'Musical Line',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:afdd7e9a-c11f-4303-bbae-38d1698523b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afdd7e9a-c11f-4303-bbae-38d1698523b8', 6, NULL, 'Musical Line', 'Musical Line', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afdd7e9a-c11f-4303-bbae-38d1698523b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Testament of Revolt', part.name_en = 'Testament of Revolt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:6c8f2c53-9030-4ee6-85f8-241259ebf521' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c8f2c53-9030-4ee6-85f8-241259ebf521', 7, NULL, 'Testament of Revolt', 'Testament of Revolt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c8f2c53-9030-4ee6-85f8-241259ebf521'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Conversation', part.name_en = 'Conversation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:8b766221-43cd-411f-bd43-9e93534ae6c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b766221-43cd-411f-bd43-9e93534ae6c0', 8, NULL, 'Conversation', 'Conversation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b766221-43cd-411f-bd43-9e93534ae6c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Sex Revolution on Campus', part.name_en = 'Sex Revolution on Campus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:8429d5dd-3699-4b68-8a60-1dda8b9e5650' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8429d5dd-3699-4b68-8a60-1dda8b9e5650', 9, NULL, 'Sex Revolution on Campus', 'Sex Revolution on Campus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8429d5dd-3699-4b68-8a60-1dda8b9e5650'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Speaking of Silence', part.name_en = 'Speaking of Silence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:196e628d-f33c-4ec6-81cf-3781424f188e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:196e628d-f33c-4ec6-81cf-3781424f188e', 10, NULL, 'Speaking of Silence', 'Speaking of Silence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:196e628d-f33c-4ec6-81cf-3781424f188e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Comedy in Music', part.name_en = 'Comedy in Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:5a4dd7b7-703c-4420-957d-94bfb13fd5ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a4dd7b7-703c-4420-957d-94bfb13fd5ea', 11, NULL, 'Comedy in Music', 'Comedy in Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a4dd7b7-703c-4420-957d-94bfb13fd5ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Catching', part.name_en = 'Catching',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:235051ed-1a13-4176-99f3-30daa30612c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:235051ed-1a13-4176-99f3-30daa30612c2', 12, NULL, 'Catching', 'Catching', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:235051ed-1a13-4176-99f3-30daa30612c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Guaiaba', part.name_en = 'Guaiaba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19394 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:3f2726ea-27d3-428a-8ad7-5e22998bb30a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f2726ea-27d3-428a-8ad7-5e22998bb30a', 13, NULL, 'Guaiaba', 'Guaiaba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19394 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f2726ea-27d3-428a-8ad7-5e22998bb30a'
);


-- None Le Rire

UPDATE pieces piece
SET piece.title = 'Le Rire', piece.title_en = 'Le Rire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19089 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Musica su due dimensioni

UPDATE pieces piece
SET piece.title = 'Musica su due dimensioni', piece.title_en = 'Musica su due dimensioni',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19045 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pièce pour Ivry

UPDATE pieces piece
SET piece.title = 'Pièce pour Ivry', piece.title_en = 'Pièce pour Ivry',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16867 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quadrivium

UPDATE pieces piece
SET piece.title = 'Quadrivium', piece.title_en = 'Quadrivium',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16852 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quartetto per archi in due tempi

UPDATE pieces piece
SET piece.title = 'Quartetto per archi in due tempi', piece.title_en = 'Quartetto per archi in due tempi',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17309 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Quartetto per archi in due tempi: I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17309 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:52d415ce-6463-47ae-b599-1e945675563d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52d415ce-6463-47ae-b599-1e945675563d', 1, NULL, 'I', 'Quartetto per archi in due tempi: I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17309 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52d415ce-6463-47ae-b599-1e945675563d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Quartetto per archi in due tempi: II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17309 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:dc51810b-8b91-40c8-a7d0-141a642a23bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc51810b-8b91-40c8-a7d0-141a642a23bb', 2, NULL, 'II', 'Quartetto per archi in due tempi: II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17309 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc51810b-8b91-40c8-a7d0-141a642a23bb'
);


-- None 오페라 <Ritratto di Erasmo>

UPDATE pieces piece
SET piece.title = '오페라 <Ritratto di Erasmo>', piece.title_en = 'Ritratto di Erasmo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19833 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오페라 <Satyricon>

UPDATE pieces piece
SET piece.title = '오페라 <Satyricon>', piece.title_en = 'Satyricon',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19548 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Trimalchio ed il monumento', part.name_en = 'Satyricon: Trimalchio ed il monumento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:181c6c02-9e5c-46f9-8249-4c4f97b085f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:181c6c02-9e5c-46f9-8249-4c4f97b085f4', 1, NULL, 'Trimalchio ed il monumento', 'Satyricon: Trimalchio ed il monumento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:181c6c02-9e5c-46f9-8249-4c4f97b085f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Eumolpus Fuga', part.name_en = 'Satyricon: Eumolpus Fuga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:2d594994-d466-4970-a950-66bc64a6f512' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d594994-d466-4970-a950-66bc64a6f512', 2, NULL, 'Eumolpus Fuga', 'Satyricon: Eumolpus Fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d594994-d466-4970-a950-66bc64a6f512'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Scintilla 1 + bande 5', part.name_en = 'Satyricon: Scintilla 1 + bande 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:397e6264-be2a-4a72-a7a9-da2132ce098d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:397e6264-be2a-4a72-a7a9-da2132ce098d', 3, NULL, 'Scintilla 1 + bande 5', 'Satyricon: Scintilla 1 + bande 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:397e6264-be2a-4a72-a7a9-da2132ce098d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La Matrona di Efeso', part.name_en = 'Satyricon: La Matrona di Efeso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:4252af69-5331-49dd-8f15-f144d682140d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4252af69-5331-49dd-8f15-f144d682140d', 4, NULL, 'La Matrona di Efeso', 'Satyricon: La Matrona di Efeso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4252af69-5331-49dd-8f15-f144d682140d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Cariera di Trimalchio', part.name_en = 'Satyricon: Cariera di Trimalchio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:5994e158-b293-4f5e-ad28-353d549e75d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5994e158-b293-4f5e-ad28-353d549e75d0', 5, NULL, 'Cariera di Trimalchio', 'Satyricon: Cariera di Trimalchio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5994e158-b293-4f5e-ad28-353d549e75d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Criside 1', part.name_en = 'Satyricon: Criside 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:5e32277a-8b2d-4963-a5ca-17ce65571a0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e32277a-8b2d-4963-a5ca-17ce65571a0f', 6, NULL, 'Criside 1', 'Satyricon: Criside 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e32277a-8b2d-4963-a5ca-17ce65571a0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Trimalchio e le flatulenze (reprise) + bande 3', part.name_en = 'Satyricon: Trimalchio e le flatulenze (reprise) + bande 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:5e5eecbe-e1a1-4a3c-bb46-87cb0f80ba9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e5eecbe-e1a1-4a3c-bb46-87cb0f80ba9f', 7, NULL, 'Trimalchio e le flatulenze (reprise) + bande 3', 'Satyricon: Trimalchio e le flatulenze (reprise) + bande 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e5eecbe-e1a1-4a3c-bb46-87cb0f80ba9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Trimalchio and animals (bande 4)', part.name_en = 'Satyricon: Trimalchio and animals (bande 4)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:609410e8-8891-41b4-a5f3-cb71adf4b3f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:609410e8-8891-41b4-a5f3-cb71adf4b3f2', 8, NULL, 'Trimalchio and animals (bande 4)', 'Satyricon: Trimalchio and animals (bande 4)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:609410e8-8891-41b4-a5f3-cb71adf4b3f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Criside 2', part.name_en = 'Satyricon: Criside 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:64549450-75c6-4f45-983d-6a2f7b3d4884' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64549450-75c6-4f45-983d-6a2f7b3d4884', 9, NULL, 'Criside 2', 'Satyricon: Criside 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64549450-75c6-4f45-983d-6a2f7b3d4884'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Orchestral improvisation: "Food machine"', part.name_en = 'Satyricon: Orchestral improvisation: "Food machine"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:77af447e-5d2b-4d9a-9af4-014c75a3d317' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77af447e-5d2b-4d9a-9af4-014c75a3d317', 10, NULL, 'Orchestral improvisation: "Food machine"', 'Satyricon: Orchestral improvisation: "Food machine"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77af447e-5d2b-4d9a-9af4-014c75a3d317'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Trimalchio contra Fortunata', part.name_en = 'Satyricon: Trimalchio contra Fortunata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:80c5f6b4-a801-42cc-b291-87aa9346335c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80c5f6b4-a801-42cc-b291-87aa9346335c', 11, NULL, 'Trimalchio contra Fortunata', 'Satyricon: Trimalchio contra Fortunata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80c5f6b4-a801-42cc-b291-87aa9346335c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Trimalchio e le flatulenze', part.name_en = 'Satyricon: Trimalchio e le flatulenze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:81ef2990-7642-4e8a-86b7-c2172d39dc28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81ef2990-7642-4e8a-86b7-c2172d39dc28', 12, NULL, 'Trimalchio e le flatulenze', 'Satyricon: Trimalchio e le flatulenze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ef2990-7642-4e8a-86b7-c2172d39dc28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Erotica (bande 2)', part.name_en = 'Satyricon: Erotica (bande 2)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:896f1eec-924f-4252-afd9-9ec6b920c02f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:896f1eec-924f-4252-afd9-9ec6b920c02f', 13, NULL, 'Erotica (bande 2)', 'Satyricon: Erotica (bande 2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:896f1eec-924f-4252-afd9-9ec6b920c02f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Love''s Ecstasy, Quatuor', part.name_en = 'Satyricon: Love''s Ecstasy, Quatuor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:90e0151a-195e-4072-868d-f4a88cd5e26e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90e0151a-195e-4072-868d-f4a88cd5e26e', 14, NULL, 'Love''s Ecstasy, Quatuor', 'Satyricon: Love''s Ecstasy, Quatuor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90e0151a-195e-4072-868d-f4a88cd5e26e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Fortunata aria', part.name_en = 'Satyricon: Fortunata aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:9a134cb9-8518-47e6-830a-d0e4cc3e2f0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a134cb9-8518-47e6-830a-d0e4cc3e2f0c', 15, NULL, 'Fortunata aria', 'Satyricon: Fortunata aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a134cb9-8518-47e6-830a-d0e4cc3e2f0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'The Money', part.name_en = 'Satyricon: The Money',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:ac52c656-2318-4f4c-85cf-fefb281393e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac52c656-2318-4f4c-85cf-fefb281393e1', 16, NULL, 'The Money', 'Satyricon: The Money', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac52c656-2318-4f4c-85cf-fefb281393e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Fortunata e Eumolpus', part.name_en = 'Satyricon: Fortunata e Eumolpus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:e791251c-b098-46fc-a9a0-4b2a512054e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e791251c-b098-46fc-a9a0-4b2a512054e5', 17, NULL, 'Fortunata e Eumolpus', 'Satyricon: Fortunata e Eumolpus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e791251c-b098-46fc-a9a0-4b2a512054e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Lady Luck', part.name_en = 'Satyricon: Lady Luck',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:ee55cdde-19c7-4503-8e0b-c34d3b703e5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee55cdde-19c7-4503-8e0b-c34d3b703e5c', 18, NULL, 'Lady Luck', 'Satyricon: Lady Luck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee55cdde-19c7-4503-8e0b-c34d3b703e5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Introduction (bande 1)', part.name_en = 'Satyricon: Introduction (bande 1)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19548 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:fbc92861-3c3a-4820-a7fb-82165982ce2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbc92861-3c3a-4820-a7fb-82165982ce2a', 19, NULL, 'Introduction (bande 1)', 'Satyricon: Introduction (bande 1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19548 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbc92861-3c3a-4820-a7fb-82165982ce2a'
);


-- None Serenata III

UPDATE pieces piece
SET piece.title = 'Serenata III', piece.title_en = 'Serenata III',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19412 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 세레나데 2번

UPDATE pieces piece
SET piece.title = '세레나데 2번', piece.title_en = 'Serenata no. 2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17855 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Stele per Diotima

UPDATE pieces piece
SET piece.title = 'Stele per Diotima', piece.title_en = 'Stele per Diotima',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16495 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Studi per "Il processo" di Franz Kafka

UPDATE pieces piece
SET piece.title = 'Studi per "Il processo" di Franz Kafka', piece.title_en = 'Studi per "Il processo" di Franz Kafka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16989 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ständchen für Tini

UPDATE pieces piece
SET piece.title = 'Ständchen für Tini', piece.title_en = 'Ständchen für Tini',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18613 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Syntaxis

UPDATE pieces piece
SET piece.title = 'Syntaxis', piece.title_en = 'Syntaxis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16351 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tre liriche greche

UPDATE pieces piece
SET piece.title = 'Tre liriche greche', piece.title_en = 'Tre liriche greche',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19484 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Canto mattutino', part.name_en = 'Tre liriche greche: I. Canto mattutino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19484 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:81699853-4677-4d59-b05f-2843ebf9add0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81699853-4677-4d59-b05f-2843ebf9add0', 1, 'I', 'Canto mattutino', 'Tre liriche greche: I. Canto mattutino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19484 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81699853-4677-4d59-b05f-2843ebf9add0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le Danaidi', part.name_en = 'Tre liriche greche: II. Le Danaidi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19484 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:33d4d866-c795-4186-b7ec-b2147be7ad4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33d4d866-c795-4186-b7ec-b2147be7ad4c', 2, 'II', 'Le Danaidi', 'Tre liriche greche: II. Le Danaidi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19484 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33d4d866-c795-4186-b7ec-b2147be7ad4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Stellato', part.name_en = 'Tre liriche greche: III. Stellato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19484 AND p.composer_id = 186 AND part.part_key = 'musicbrainz:58510c33-fcb1-46e3-9631-8f80fb137567' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58510c33-fcb1-46e3-9631-8f80fb137567', 3, 'III', 'Stellato', 'Tre liriche greche: III. Stellato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19484 AND p.composer_id = 186
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58510c33-fcb1-46e3-9631-8f80fb137567'
);


-- None Venetian Journal

UPDATE pieces piece
SET piece.title = 'Venetian Journal', piece.title_en = 'Venetian Journal',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19674 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Viola

UPDATE pieces piece
SET piece.title = 'Viola', piece.title_en = 'Viola',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18992 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Widmung

UPDATE pieces piece
SET piece.title = 'Widmung', piece.title_en = 'Widmung',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17777 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Y después

UPDATE pieces piece
SET piece.title = 'Y después', piece.title_en = 'Y después',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18632 AND piece.composer_id = 186
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aria

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Aria', 'Aria', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 186
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Aria'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c0e9985-cc02-4a9f-bfb4-9d14b6e46a94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c0e9985-cc02-4a9f-bfb4-9d14b6e46a94'
FROM pieces p
WHERE p.composer_id = 186 AND p.title = 'Aria' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c0e9985-cc02-4a9f-bfb4-9d14b6e46a94'
);


-- None Concerto per pianoforte e orchestra

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Concerto per pianoforte e orchestra', 'Concerto per pianoforte e orchestra', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 186
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Concerto per pianoforte e orchestra'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5046ffce-3455-4659-aeec-0da2c32f0f61'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5046ffce-3455-4659-aeec-0da2c32f0f61'
FROM pieces p
WHERE p.composer_id = 186 AND p.title = 'Concerto per pianoforte e orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5046ffce-3455-4659-aeec-0da2c32f0f61'
);


-- None Concerto per violino e orchestra

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Concerto per violino e orchestra', 'Concerto per violino e orchestra', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 186
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Concerto per violino e orchestra'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b4b3097-bcbd-41e9-97c3-74b5237b9908'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b4b3097-bcbd-41e9-97c3-74b5237b9908'
FROM pieces p
WHERE p.composer_id = 186 AND p.title = 'Concerto per violino e orchestra' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b4b3097-bcbd-41e9-97c3-74b5237b9908'
);


-- None Notturno

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Notturno', 'Notturno', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 186
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Notturno'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afa4a1ae-0c0d-4504-babd-53bf3b500249'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'afa4a1ae-0c0d-4504-babd-53bf3b500249'
FROM pieces p
WHERE p.composer_id = 186 AND p.title = 'Notturno' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afa4a1ae-0c0d-4504-babd-53bf3b500249'
);


-- None Serenata per un satellite

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Serenata per un satellite', 'Serenata per un satellite', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 186
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Serenata per un satellite'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af1855f4-5e60-4f22-96bc-5642cf644d9a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af1855f4-5e60-4f22-96bc-5642cf644d9a'
FROM pieces p
WHERE p.composer_id = 186 AND p.title = 'Serenata per un satellite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af1855f4-5e60-4f22-96bc-5642cf644d9a'
);


-- 숨길 seed 작품 없음
