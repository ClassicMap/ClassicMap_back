-- 나지 하킴 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 56개(묶음 7, 다악장 23, 낱곡 26),
-- 새 작품 9개, part 131개, 그 아래 0개.
-- seed 69개 중 47개를 작품·part 에 잇고, 3개를 숨기고, 19개는 그대로 둔다.
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

-- None Abana

UPDATE pieces piece
SET piece.title = 'Abana', piece.title_en = 'Abana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19073 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adoration

UPDATE pieces piece
SET piece.title = 'Adoration', piece.title_en = 'Adoration',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19783 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'In excelso throno', part.name_en = 'Adoration: In excelso throno',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19783 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:e691ed3c-e123-4994-a213-fe4feb5341d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e691ed3c-e123-4994-a213-fe4feb5341d6', 1, NULL, 'In excelso throno', 'Adoration: In excelso throno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19783 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e691ed3c-e123-4994-a213-fe4feb5341d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Omnis terra adoret te, Deus', part.name_en = 'Adoration: Omnis terra adoret te, Deus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19783 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:47cc3262-e314-4255-8eb0-7ea8ee7cba7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47cc3262-e314-4255-8eb0-7ea8ee7cba7f', 2, NULL, 'Omnis terra adoret te, Deus', 'Adoration: Omnis terra adoret te, Deus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19783 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47cc3262-e314-4255-8eb0-7ea8ee7cba7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Adorate Deum omnes angeli', part.name_en = 'Adoration: Adorate Deum omnes angeli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19783 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:b307b148-fda9-4ab5-a332-5715d224a577' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b307b148-fda9-4ab5-a332-5715d224a577', 3, NULL, 'Adorate Deum omnes angeli', 'Adoration: Adorate Deum omnes angeli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19783 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b307b148-fda9-4ab5-a332-5715d224a577'
);


-- None All My Founts Shall Be With You

UPDATE pieces piece
SET piece.title = 'All My Founts Shall Be With You', piece.title_en = 'All My Founts Shall Be With You',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18809 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Assalamu

UPDATE pieces piece
SET piece.title = 'Assalamu', piece.title_en = 'Assalamu',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19723 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aš-šawqu ila˘ s-samāʾ

UPDATE pieces piece
SET piece.title = 'Aš-šawqu ila˘ s-samāʾ', piece.title_en = 'Aš-šawqu ila˘ s-samāʾ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18291 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Bach'orama

UPDATE pieces piece
SET piece.title = 'Bach''orama', piece.title_en = 'Bach''orama',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16265 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바가텔

UPDATE pieces piece
SET piece.title = '바가텔', piece.title_en = 'Bagatelle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17798 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Cantilena

UPDATE pieces piece
SET piece.title = 'Cantilena', piece.title_en = 'Cantilena',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19020 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 협주곡 4번

UPDATE pieces piece
SET piece.title = '협주곡 4번', piece.title_en = 'Concerto No. 4 for Organ and Chamber Ensemble',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17373 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Strømmende: Ritmico', part.name_en = 'Concerto No. 4 for Organ and Chamber Ensemble: I. Strømmende: Ritmico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17373 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:a3cf410b-e0cc-4a41-ae73-6d04f484bf30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3cf410b-e0cc-4a41-ae73-6d04f484bf30', 1, 'I', 'Strømmende: Ritmico', 'Concerto No. 4 for Organ and Chamber Ensemble: I. Strømmende: Ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17373 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3cf410b-e0cc-4a41-ae73-6d04f484bf30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Sorrig og glæde: Andante', part.name_en = 'Concerto No. 4 for Organ and Chamber Ensemble: II. Sorrig og glæde: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17373 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:9be320db-330d-4fd7-813b-98453884f0c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9be320db-330d-4fd7-813b-98453884f0c1', 2, 'II', 'Sorrig og glæde: Andante', 'Concerto No. 4 for Organ and Chamber Ensemble: II. Sorrig og glæde: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17373 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9be320db-330d-4fd7-813b-98453884f0c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Uudslukkelig: Allegro con fuoco', part.name_en = 'Concerto No. 4 for Organ and Chamber Ensemble: III. Uudslukkelig: Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17373 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:3b047200-4668-457d-a9bf-4ced2fbcdfe3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b047200-4668-457d-a9bf-4ced2fbcdfe3', 3, 'III', 'Uudslukkelig: Allegro con fuoco', 'Concerto No. 4 for Organ and Chamber Ensemble: III. Uudslukkelig: Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17373 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b047200-4668-457d-a9bf-4ced2fbcdfe3'
);


-- None 협주곡 2번 "Seattle Concerto"

UPDATE pieces piece
SET piece.title = '협주곡 2번 "Seattle Concerto"', piece.title_en = 'Concerto pour orgue et orchestre n° 2 "Seattle Concerto"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19297 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro risoluto', part.name_en = 'Concerto pour orgue et orchestre n° 2 "Seattle Concerto": I. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19297 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:0d7b57b6-d36e-4892-ad51-040e3efd2729' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d7b57b6-d36e-4892-ad51-040e3efd2729', 1, 'I', 'Allegro risoluto', 'Concerto pour orgue et orchestre n° 2 "Seattle Concerto": I. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19297 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d7b57b6-d36e-4892-ad51-040e3efd2729'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Concerto pour orgue et orchestre n° 2 "Seattle Concerto": II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19297 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:9f24ab4c-5edf-4c1d-a1fa-f1eb84ff39cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f24ab4c-5edf-4c1d-a1fa-f1eb84ff39cc', 2, 'II', 'Adagio', 'Concerto pour orgue et orchestre n° 2 "Seattle Concerto": II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19297 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f24ab4c-5edf-4c1d-a1fa-f1eb84ff39cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con spirito', part.name_en = 'Concerto pour orgue et orchestre n° 2 "Seattle Concerto": III. Allegro con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19297 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:42266b6d-e5bc-4c5c-acde-a8ffd0b0be17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42266b6d-e5bc-4c5c-acde-a8ffd0b0be17', 3, 'III', 'Allegro con spirito', 'Concerto pour orgue et orchestre n° 2 "Seattle Concerto": III. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19297 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42266b6d-e5bc-4c5c-acde-a8ffd0b0be17'
);


-- None Concerto pour violon et orchestre à cordes

UPDATE pieces piece
SET piece.title = 'Concerto pour violon et orchestre à cordes', piece.title_en = 'Concerto pour violon et orchestre à cordes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16646 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'Concerto pour violon et orchestre à cordes: I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16646 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:4b2648c9-59a0-4234-b271-1fe4cca671c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b2648c9-59a0-4234-b271-1fe4cca671c0', 1, 'I', 'Allegro vivace', 'Concerto pour violon et orchestre à cordes: I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16646 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b2648c9-59a0-4234-b271-1fe4cca671c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Concerto pour violon et orchestre à cordes: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16646 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:a8b56834-dd20-40f0-8b7d-f1aa814424e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8b56834-dd20-40f0-8b7d-f1aa814424e4', 2, 'II', 'Moderato', 'Concerto pour violon et orchestre à cordes: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16646 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8b56834-dd20-40f0-8b7d-f1aa814424e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con moto', part.name_en = 'Concerto pour violon et orchestre à cordes: III. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16646 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:097e9c07-bb21-485a-9fcd-35c4e968a616' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:097e9c07-bb21-485a-9fcd-35c4e968a616', 3, 'III', 'Allegro con moto', 'Concerto pour violon et orchestre à cordes: III. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16646 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:097e9c07-bb21-485a-9fcd-35c4e968a616'
);


-- None Dumia

UPDATE pieces piece
SET piece.title = 'Dumia', piece.title_en = 'Dumia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16225 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Esquisses Grégoriennes

UPDATE pieces piece
SET piece.title = 'Esquisses Grégoriennes', piece.title_en = 'Esquisses Grégoriennes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19040 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nos autem', part.name_en = 'Esquisses Grégoriennes: No. 1. Nos autem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19040 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:101fe283-108e-45f6-b70e-29fb74ab0bbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:101fe283-108e-45f6-b70e-29fb74ab0bbc', 1, NULL, 'Nos autem', 'Esquisses Grégoriennes: No. 1. Nos autem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19040 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:101fe283-108e-45f6-b70e-29fb74ab0bbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ave maris stella', part.name_en = 'Esquisses Grégoriennes: No. 2. Ave maris stella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19040 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:1f1b4d31-277d-44b6-a5af-05a7a2c7ae0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f1b4d31-277d-44b6-a5af-05a7a2c7ae0b', 2, NULL, 'Ave maris stella', 'Esquisses Grégoriennes: No. 2. Ave maris stella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19040 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1b4d31-277d-44b6-a5af-05a7a2c7ae0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pater noster', part.name_en = 'Esquisses Grégoriennes: No. 3. Pater noster',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19040 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:bfbaf2f8-083d-4d31-a3cb-1d285209d154' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfbaf2f8-083d-4d31-a3cb-1d285209d154', 3, NULL, 'Pater noster', 'Esquisses Grégoriennes: No. 3. Pater noster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19040 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfbaf2f8-083d-4d31-a3cb-1d285209d154'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ave verum', part.name_en = 'Esquisses Grégoriennes: No. 4. Ave verum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19040 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:f46bcacf-fe7f-43f0-9791-6d754fddb8e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f46bcacf-fe7f-43f0-9791-6d754fddb8e5', 4, NULL, 'Ave verum', 'Esquisses Grégoriennes: No. 4. Ave verum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19040 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f46bcacf-fe7f-43f0-9791-6d754fddb8e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'O filii et filiae', part.name_en = 'Esquisses Grégoriennes: No. 5. O filii et filiae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19040 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:04f35ee4-20e2-4afa-a10b-9374ebaba6ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04f35ee4-20e2-4afa-a10b-9374ebaba6ac', 5, NULL, 'O filii et filiae', 'Esquisses Grégoriennes: No. 5. O filii et filiae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19040 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04f35ee4-20e2-4afa-a10b-9374ebaba6ac'
);


-- None Expressions for Organ

UPDATE pieces piece
SET piece.title = 'Expressions for Organ', piece.title_en = 'Expressions for Organ',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16254 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Calm and Deeply Expressive', part.name_en = 'Expressions for Organ: No. 17. Calm and Deeply Expressive',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16254 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:240be0af-3a02-40df-9ce9-fce75953b273' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:240be0af-3a02-40df-9ce9-fce75953b273', 1, NULL, 'Calm and Deeply Expressive', 'Expressions for Organ: No. 17. Calm and Deeply Expressive', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16254 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240be0af-3a02-40df-9ce9-fce75953b273'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rather Slow', part.name_en = 'Expressions for Organ: No. 27. Rather Slow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16254 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:3f910a87-98d2-4ecd-8be7-d313d47437de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f910a87-98d2-4ecd-8be7-d313d47437de', 2, NULL, 'Rather Slow', 'Expressions for Organ: No. 27. Rather Slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16254 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f910a87-98d2-4ecd-8be7-d313d47437de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lively', part.name_en = 'Expressions for Organ: No. 30. Lively',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16254 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:60e09075-b1f2-48b3-a694-c1fea25c6282' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60e09075-b1f2-48b3-a694-c1fea25c6282', 3, NULL, 'Lively', 'Expressions for Organ: No. 30. Lively', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16254 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60e09075-b1f2-48b3-a694-c1fea25c6282'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Very Lively', part.name_en = 'Expressions for Organ: No. 25. Very Lively',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16254 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:d2f00309-d5ce-4cd8-acaa-648062d6bc9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2f00309-d5ce-4cd8-acaa-648062d6bc9f', 4, NULL, 'Very Lively', 'Expressions for Organ: No. 25. Very Lively', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16254 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2f00309-d5ce-4cd8-acaa-648062d6bc9f'
);


-- None Fantaisie sur Adeste fideles

UPDATE pieces piece
SET piece.title = 'Fantaisie sur Adeste fideles', piece.title_en = 'Fantaisie sur Adeste fideles',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19103 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gershwinesca

UPDATE pieces piece
SET piece.title = 'Gershwinesca', piece.title_en = 'Gershwinesca',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18301 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Gregoriana

UPDATE pieces piece
SET piece.title = 'Gregoriana', piece.title_en = 'Gregoriana',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18820 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Hommage à Igor Stravinsky

UPDATE pieces piece
SET piece.title = 'Hommage à Igor Stravinsky', piece.title_en = 'Hommage à Igor Stravinsky',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19841 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = 'Hommage à Igor Stravinsky: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19841 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:6306a382-cf40-41c6-a5b7-df9702c56c6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6306a382-cf40-41c6-a5b7-df9702c56c6b', 1, 'I', 'Prélude', 'Hommage à Igor Stravinsky: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19841 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6306a382-cf40-41c6-a5b7-df9702c56c6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danse', part.name_en = 'Hommage à Igor Stravinsky: II. Danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19841 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:8df2f243-8ffc-4b63-926d-a2c20a1674da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8df2f243-8ffc-4b63-926d-a2c20a1674da', 2, 'II', 'Danse', 'Hommage à Igor Stravinsky: II. Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19841 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8df2f243-8ffc-4b63-926d-a2c20a1674da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final', part.name_en = 'Hommage à Igor Stravinsky: III. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19841 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:a15790c2-91c6-42c0-92aa-1f1642e402aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a15790c2-91c6-42c0-92aa-1f1642e402aa', 3, 'III', 'Final', 'Hommage à Igor Stravinsky: III. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19841 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a15790c2-91c6-42c0-92aa-1f1642e402aa'
);


-- None Ich liebe die farbenreiche Welt

UPDATE pieces piece
SET piece.title = 'Ich liebe die farbenreiche Welt', piece.title_en = 'Ich liebe die farbenreiche Welt',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15837 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Präludium', part.name_en = 'Ich liebe die farbenreiche Welt: I. Präludium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15837 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:4be91244-4b3a-444e-86e7-7db8a1a9c482' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4be91244-4b3a-444e-86e7-7db8a1a9c482', 1, 'I', 'Präludium', 'Ich liebe die farbenreiche Welt: I. Präludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15837 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4be91244-4b3a-444e-86e7-7db8a1a9c482'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Tanz-Toccata', part.name_en = 'Ich liebe die farbenreiche Welt: II. Tanz-Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15837 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:b24507ba-780d-4668-a316-72bd0528d656' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b24507ba-780d-4668-a316-72bd0528d656', 2, 'II', 'Tanz-Toccata', 'Ich liebe die farbenreiche Welt: II. Tanz-Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15837 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b24507ba-780d-4668-a316-72bd0528d656'
);


-- None In organo, chordis et choro

UPDATE pieces piece
SET piece.title = 'In organo, chordis et choro', piece.title_en = 'In organo, chordis et choro',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17941 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Kammerkoncert No. 2

UPDATE pieces piece
SET piece.title = 'Kammerkoncert No. 2', piece.title_en = 'Kammerkoncert No. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16500 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Velkommen igen, Guds engle små: Allegro', part.name_en = 'Kammerkoncert No. 2: I. Velkommen igen, Guds engle små: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16500 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:d34cf327-374f-44df-8803-36bf1079b7d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d34cf327-374f-44df-8803-36bf1079b7d0', 1, 'I', 'Velkommen igen, Guds engle små: Allegro', 'Kammerkoncert No. 2: I. Velkommen igen, Guds engle små: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16500 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d34cf327-374f-44df-8803-36bf1079b7d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dejlig er den himmel blå: Andante', part.name_en = 'Kammerkoncert No. 2: II. Dejlig er den himmel blå: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16500 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:aa9787f0-1dbe-4d61-9420-0f8b31cf3bd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa9787f0-1dbe-4d61-9420-0f8b31cf3bd3', 2, 'II', 'Dejlig er den himmel blå: Andante', 'Kammerkoncert No. 2: II. Dejlig er den himmel blå: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16500 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa9787f0-1dbe-4d61-9420-0f8b31cf3bd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Et barn er født i Betlehem: Allegro', part.name_en = 'Kammerkoncert No. 2: III. Et barn er født i Betlehem: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16500 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:597d8675-638a-401d-98b1-b53fff01f842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:597d8675-638a-401d-98b1-b53fff01f842', 3, 'III', 'Et barn er født i Betlehem: Allegro', 'Kammerkoncert No. 2: III. Et barn er født i Betlehem: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16500 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:597d8675-638a-401d-98b1-b53fff01f842'
);


-- None Korean Prelude

UPDATE pieces piece
SET piece.title = 'Korean Prelude', piece.title_en = 'Korean Prelude',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18966 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Le Tombeau d’Olivier Messiaen

UPDATE pieces piece
SET piece.title = 'Le Tombeau d’Olivier Messiaen', piece.title_en = 'Le Tombeau d’Olivier Messiaen',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18982 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I give thanks to my God', part.name_en = 'Le Tombeau d''Olivier Messiaen: I give thanks to my God',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18982 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:474864b5-3f2d-4cda-aa4b-2c0f60b849f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:474864b5-3f2d-4cda-aa4b-2c0f60b849f5', 1, NULL, 'I give thanks to my God', 'Le Tombeau d''Olivier Messiaen: I give thanks to my God', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18982 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:474864b5-3f2d-4cda-aa4b-2c0f60b849f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'By my life, by my death', part.name_en = 'Le Tombeau d''Olivier Messiaen: By my life, by my death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18982 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:703e4274-df96-46f0-8aaa-d9bce233d28b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:703e4274-df96-46f0-8aaa-d9bce233d28b', 2, NULL, 'By my life, by my death', 'Le Tombeau d''Olivier Messiaen: By my life, by my death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18982 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:703e4274-df96-46f0-8aaa-d9bce233d28b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Christ with the Holy Spirit in the Glory of the Father', part.name_en = 'Le Tombeau d''Olivier Messiaen: Christ with the Holy Spirit in the Glory of the Father',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18982 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:e89da470-56e4-4ac5-b6f1-8b8df3d9cf24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e89da470-56e4-4ac5-b6f1-8b8df3d9cf24', 3, NULL, 'Christ with the Holy Spirit in the Glory of the Father', 'Le Tombeau d''Olivier Messiaen: Christ with the Holy Spirit in the Glory of the Father', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18982 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e89da470-56e4-4ac5-b6f1-8b8df3d9cf24'
);


-- None Messe solennelle

UPDATE pieces piece
SET piece.title = 'Messe solennelle', piece.title_en = 'Messe solennelle',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19930 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Kyrie', part.name_en = 'Messe solennelle: I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19930 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:f58ef320-f86f-494a-93cd-8a7544749766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f58ef320-f86f-494a-93cd-8a7544749766', 1, 'I', 'Kyrie', 'Messe solennelle: I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19930 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f58ef320-f86f-494a-93cd-8a7544749766'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Gloria', part.name_en = 'Messe solennelle: II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19930 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:3bbbb049-8dbc-480c-898e-d634cf03957b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bbbb049-8dbc-480c-898e-d634cf03957b', 2, 'II', 'Gloria', 'Messe solennelle: II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19930 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bbbb049-8dbc-480c-898e-d634cf03957b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Sanctus and Benedictus', part.name_en = 'Messe solennelle: III. Sanctus and Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19930 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:aad1b9f9-708f-4461-8e56-3b6c5e9c1ab9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aad1b9f9-708f-4461-8e56-3b6c5e9c1ab9', 3, 'III', 'Sanctus and Benedictus', 'Messe solennelle: III. Sanctus and Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19930 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aad1b9f9-708f-4461-8e56-3b6c5e9c1ab9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Agnus Dei', part.name_en = 'Messe solennelle: IV. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19930 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:4b0fa1bb-23e7-444c-839e-b91a4bc2f858' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b0fa1bb-23e7-444c-839e-b91a4bc2f858', 4, 'IV', 'Agnus Dei', 'Messe solennelle: IV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19930 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b0fa1bb-23e7-444c-839e-b91a4bc2f858'
);


-- None O sacrum convivium

UPDATE pieces piece
SET piece.title = 'O sacrum convivium', piece.title_en = 'O sacrum convivium',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17693 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오르간 협주곡 1번

UPDATE pieces piece
SET piece.title = '오르간 협주곡 1번', piece.title_en = 'Organ Concerto no. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19863 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vivace', part.name_en = 'Organ Concerto no. 1: I. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19863 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:9f485439-875a-4399-a44c-6d56aace4de3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f485439-875a-4399-a44c-6d56aace4de3', 1, 'I', 'Vivace', 'Organ Concerto no. 1: I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19863 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f485439-875a-4399-a44c-6d56aace4de3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'Organ Concerto no. 1: II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19863 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:30804db7-5b36-489d-b361-c1b6dae7f01a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30804db7-5b36-489d-b361-c1b6dae7f01a', 2, 'II', 'Andante', 'Organ Concerto no. 1: II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19863 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30804db7-5b36-489d-b361-c1b6dae7f01a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Organ Concerto no. 1: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19863 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:1488815f-4ac1-49bd-bf89-04897f9f98ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1488815f-4ac1-49bd-bf89-04897f9f98ce', 3, 'III', 'Allegro', 'Organ Concerto no. 1: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19863 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1488815f-4ac1-49bd-bf89-04897f9f98ce'
);


-- None 오르간 협주곡 3번

UPDATE pieces piece
SET piece.title = '오르간 협주곡 3번', piece.title_en = 'Organ Concerto no. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17323 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Organ Concerto no. 3: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17323 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:0158ac6d-c4b0-49de-ad77-88aa1075afcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0158ac6d-c4b0-49de-ad77-88aa1075afcb', 1, 'I', 'Allegro', 'Organ Concerto no. 3: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17323 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0158ac6d-c4b0-49de-ad77-88aa1075afcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Organ Concerto no. 3: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17323 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:b2a07abe-95ed-4245-9dae-bc24dc8ffe16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2a07abe-95ed-4245-9dae-bc24dc8ffe16', 2, 'II', 'Moderato', 'Organ Concerto no. 3: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17323 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a07abe-95ed-4245-9dae-bc24dc8ffe16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Organ Concerto no. 3: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17323 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:984a7659-c887-4763-a2fc-10ef3c7ced46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:984a7659-c887-4763-a2fc-10ef3c7ced46', 3, 'III', 'Allegro', 'Organ Concerto no. 3: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17323 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:984a7659-c887-4763-a2fc-10ef3c7ced46'
);


-- None Our Lady's Minstrel

UPDATE pieces piece
SET piece.title = 'Our Lady''s Minstrel', piece.title_en = 'Our Lady''s Minstrel',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17494 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prelude', part.name_en = 'Our Lady''s Minstrel: Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17494 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:fc05810c-0b89-4263-90e7-68dce3f34900' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc05810c-0b89-4263-90e7-68dce3f34900', 1, NULL, 'Prelude', 'Our Lady''s Minstrel: Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17494 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc05810c-0b89-4263-90e7-68dce3f34900'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Most Sweet Queen', part.name_en = 'Our Lady''s Minstrel: Most Sweet Queen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17494 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:f22ba2b9-fc5a-4c7c-bffc-8d9304637342' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f22ba2b9-fc5a-4c7c-bffc-8d9304637342', 2, NULL, 'Most Sweet Queen', 'Our Lady''s Minstrel: Most Sweet Queen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17494 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f22ba2b9-fc5a-4c7c-bffc-8d9304637342'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Most Sweet Friend', part.name_en = 'Our Lady''s Minstrel: Most Sweet Friend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17494 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:430c0ff2-48ce-4df6-8374-18c6a14bb0df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:430c0ff2-48ce-4df6-8374-18c6a14bb0df', 3, NULL, 'Most Sweet Friend', 'Our Lady''s Minstrel: Most Sweet Friend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17494 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:430c0ff2-48ce-4df6-8374-18c6a14bb0df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Holy Mary', part.name_en = 'Our Lady''s Minstrel: Holy Mary',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17494 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:074ef58e-1211-47e7-b014-10c4b50682d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074ef58e-1211-47e7-b014-10c4b50682d5', 4, NULL, 'Holy Mary', 'Our Lady''s Minstrel: Holy Mary', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17494 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074ef58e-1211-47e7-b014-10c4b50682d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dance', part.name_en = 'Our Lady''s Minstrel: Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17494 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:9e57c1cc-985e-4bbd-a317-cf87700cf127' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e57c1cc-985e-4bbd-a317-cf87700cf127', 5, NULL, 'Dance', 'Our Lady''s Minstrel: Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17494 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e57c1cc-985e-4bbd-a317-cf87700cf127'
);


-- None Pange lingua

UPDATE pieces piece
SET piece.title = 'Pange lingua', piece.title_en = 'Pange lingua',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16420 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Pange lingua', part.name_en = 'Pange lingua: I. Pange lingua',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16420 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:a4bc73bd-e708-40bb-93d3-29965b71284a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4bc73bd-e708-40bb-93d3-29965b71284a', 1, 'I', 'Pange lingua', 'Pange lingua: I. Pange lingua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16420 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4bc73bd-e708-40bb-93d3-29965b71284a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nobis datus', part.name_en = 'Pange lingua: II. Nobis datus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16420 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:ec5c41ea-4c11-4e01-9d84-79e5b3c65416' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec5c41ea-4c11-4e01-9d84-79e5b3c65416', 2, 'II', 'Nobis datus', 'Pange lingua: II. Nobis datus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16420 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec5c41ea-4c11-4e01-9d84-79e5b3c65416'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'In supremæ nocte cœnœ', part.name_en = 'Pange lingua: III. In supremæ nocte cœnœ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16420 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:219561e0-8e0c-498c-96d4-8d1f4aac2641' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:219561e0-8e0c-498c-96d4-8d1f4aac2641', 3, 'III', 'In supremæ nocte cœnœ', 'Pange lingua: III. In supremæ nocte cœnœ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16420 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:219561e0-8e0c-498c-96d4-8d1f4aac2641'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Verbum caro', part.name_en = 'Pange lingua: IV. Verbum caro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16420 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:1a070255-43d7-40ef-976d-cdd902ca38fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a070255-43d7-40ef-976d-cdd902ca38fe', 4, 'IV', 'Verbum caro', 'Pange lingua: IV. Verbum caro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16420 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a070255-43d7-40ef-976d-cdd902ca38fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Tantum ergo', part.name_en = 'Pange lingua: V. Tantum ergo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16420 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:5985aee0-a11e-4af3-908d-7acb4aff05c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5985aee0-a11e-4af3-908d-7acb4aff05c0', 5, 'V', 'Tantum ergo', 'Pange lingua: V. Tantum ergo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16420 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5985aee0-a11e-4af3-908d-7acb4aff05c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Genitori, genitoque', part.name_en = 'Pange lingua: VI. Genitori, genitoque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16420 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:ece90d61-0e1c-4a7d-9d82-b7fca191600b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ece90d61-0e1c-4a7d-9d82-b7fca191600b', 6, 'VI', 'Genitori, genitoque', 'Pange lingua: VI. Genitori, genitoque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16420 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece90d61-0e1c-4a7d-9d82-b7fca191600b'
);


-- None Prière

UPDATE pieces piece
SET piece.title = 'Prière', piece.title_en = 'Prière',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19508 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatre Études-Caprices

UPDATE pieces piece
SET piece.title = 'Quatre Études-Caprices', piece.title_en = 'Quatre Études-Caprices',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17025 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'No. 1', part.name_en = 'Quatre Études-Caprices: No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17025 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:9708eb8a-24e2-410b-9bd5-a64c9333e6b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9708eb8a-24e2-410b-9bd5-a64c9333e6b4', 1, NULL, 'No. 1', 'Quatre Études-Caprices: No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17025 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9708eb8a-24e2-410b-9bd5-a64c9333e6b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'No. 2', part.name_en = 'Quatre Études-Caprices: No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17025 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:ff4ab2c4-8cbb-4307-96da-25dcf303ab5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff4ab2c4-8cbb-4307-96da-25dcf303ab5a', 2, NULL, 'No. 2', 'Quatre Études-Caprices: No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17025 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff4ab2c4-8cbb-4307-96da-25dcf303ab5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'No. 3', part.name_en = 'Quatre Études-Caprices: No. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17025 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:96e1f9ed-a207-4734-9c83-2a185e2976bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96e1f9ed-a207-4734-9c83-2a185e2976bd', 3, NULL, 'No. 3', 'Quatre Études-Caprices: No. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17025 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96e1f9ed-a207-4734-9c83-2a185e2976bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'No. 4', part.name_en = 'Quatre Études-Caprices: No. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17025 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:8b94fc24-030e-4556-adb3-ff2c824b243f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b94fc24-030e-4556-adb3-ff2c824b243f', 4, NULL, 'No. 4', 'Quatre Études-Caprices: No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17025 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b94fc24-030e-4556-adb3-ff2c824b243f'
);


-- None 랩소디

UPDATE pieces piece
SET piece.title = '랩소디', piece.title_en = 'Rhapsody',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19096 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto', part.name_en = 'Rhapsody: I. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19096 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:cd9bc627-e76f-4b9b-abb3-e73d63868fa4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd9bc627-e76f-4b9b-abb3-e73d63868fa4', 1, 'I', 'Allegro molto', 'Rhapsody: I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19096 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd9bc627-e76f-4b9b-abb3-e73d63868fa4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'Rhapsody: II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19096 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:bd001a7a-cd1c-4e35-a70d-475d1e7f6ed7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd001a7a-cd1c-4e35-a70d-475d1e7f6ed7', 2, 'II', 'Andante sostenuto', 'Rhapsody: II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19096 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd001a7a-cd1c-4e35-a70d-475d1e7f6ed7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'Rhapsody: III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19096 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:186ee1ff-acdb-4406-9c4e-93be9d2074b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:186ee1ff-acdb-4406-9c4e-93be9d2074b1', 3, 'III', 'Vivace', 'Rhapsody: III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19096 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:186ee1ff-acdb-4406-9c4e-93be9d2074b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante tranquillo - Allegro giocoso - Andante tranquillo', part.name_en = 'Rhapsody: IV. Andante tranquillo - Allegro giocoso - Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19096 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:fcb8c89b-0d85-4452-b160-07c27417ee6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcb8c89b-0d85-4452-b160-07c27417ee6d', 4, 'IV', 'Andante tranquillo - Allegro giocoso - Andante tranquillo', 'Rhapsody: IV. Andante tranquillo - Allegro giocoso - Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19096 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcb8c89b-0d85-4452-b160-07c27417ee6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Quodlibet - Maestoso: Coda - Allegro molto', part.name_en = 'Rhapsody: V. Quodlibet - Maestoso: Coda - Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19096 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:dce6ad4d-22d4-4351-ac94-00ece986901d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dce6ad4d-22d4-4351-ac94-00ece986901d', 5, 'V', 'Quodlibet - Maestoso: Coda - Allegro molto', 'Rhapsody: V. Quodlibet - Maestoso: Coda - Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19096 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dce6ad4d-22d4-4351-ac94-00ece986901d'
);


-- None Rubaiyat

UPDATE pieces piece
SET piece.title = 'Rubaiyat', piece.title_en = 'Rubaiyat',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17987 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Deciso', part.name_en = 'Rubaiyat: I. Deciso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17987 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:2e0a02b2-ec16-496a-9af8-c03ada846b5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e0a02b2-ec16-496a-9af8-c03ada846b5e', 1, 'I', 'Deciso', 'Rubaiyat: I. Deciso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17987 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e0a02b2-ec16-496a-9af8-c03ada846b5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ostinato', part.name_en = 'Rubaiyat: II. Ostinato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17987 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:41e6ea02-7b2b-46d4-ba44-29fb5e63925f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41e6ea02-7b2b-46d4-ba44-29fb5e63925f', 2, 'II', 'Ostinato', 'Rubaiyat: II. Ostinato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17987 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41e6ea02-7b2b-46d4-ba44-29fb5e63925f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto vivace', part.name_en = 'Rubaiyat: III. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17987 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:4926f423-dc2a-4ce2-b3d4-8828bb74949c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4926f423-dc2a-4ce2-b3d4-8828bb74949c', 3, 'III', 'Molto vivace', 'Rubaiyat: III. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17987 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4926f423-dc2a-4ce2-b3d4-8828bb74949c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro agitato', part.name_en = 'Rubaiyat: IV. Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17987 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:0a1d378b-604c-4486-a86b-4bcc560fe1cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a1d378b-604c-4486-a86b-4bcc560fe1cf', 4, 'IV', 'Allegro agitato', 'Rubaiyat: IV. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17987 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a1d378b-604c-4486-a86b-4bcc560fe1cf'
);


-- None Römisches Triptychon

UPDATE pieces piece
SET piece.title = 'Römisches Triptychon', piece.title_en = 'Römisches Triptychon',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19055 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Staunen', part.name_en = 'Römisches Triptychon: I. Staunen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19055 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:7f245176-3bae-45e4-b6c1-5ae5b1d800a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f245176-3bae-45e4-b6c1-5ae5b1d800a7', 1, 'I', 'Staunen', 'Römisches Triptychon: I. Staunen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19055 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f245176-3bae-45e4-b6c1-5ae5b1d800a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Die Quelle', part.name_en = 'Römisches Triptychon: II. Die Quelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19055 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:9cff62e7-081f-4ee1-866e-3bc439e96a1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cff62e7-081f-4ee1-866e-3bc439e96a1b', 2, 'II', 'Die Quelle', 'Römisches Triptychon: II. Die Quelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19055 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cff62e7-081f-4ee1-866e-3bc439e96a1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Der erste schauende', part.name_en = 'Römisches Triptychon: III. Der erste schauende',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19055 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:a0411334-b12a-49ab-8994-eba75744df02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0411334-b12a-49ab-8994-eba75744df02', 3, 'III', 'Der erste schauende', 'Römisches Triptychon: III. Der erste schauende', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19055 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0411334-b12a-49ab-8994-eba75744df02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Bild und Ebenbild', part.name_en = 'Römisches Triptychon: IV. Bild und Ebenbild',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19055 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:d7ef0b8c-1278-447e-bd20-12ac5377be18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7ef0b8c-1278-447e-bd20-12ac5377be18', 4, 'IV', 'Bild und Ebenbild', 'Römisches Triptychon: IV. Bild und Ebenbild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19055 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7ef0b8c-1278-447e-bd20-12ac5377be18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ur im Chaldäa', part.name_en = 'Römisches Triptychon: V. Ur im Chaldäa',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19055 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:2a8896e3-0546-4aeb-baf9-3bb269ee84cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a8896e3-0546-4aeb-baf9-3bb269ee84cf', 5, 'V', 'Ur im Chaldäa', 'Römisches Triptychon: V. Ur im Chaldäa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19055 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a8896e3-0546-4aeb-baf9-3bb269ee84cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Der Gott des Bundes', part.name_en = 'Römisches Triptychon: VI. Der Gott des Bundes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19055 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:41cf19a8-6965-4f7e-80d3-96acf2896216' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41cf19a8-6965-4f7e-80d3-96acf2896216', 6, 'VI', 'Der Gott des Bundes', 'Römisches Triptychon: VI. Der Gott des Bundes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19055 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41cf19a8-6965-4f7e-80d3-96acf2896216'
);


-- None Shasta

UPDATE pieces piece
SET piece.title = 'Shasta', piece.title_en = 'Shasta',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17769 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Rondo', part.name_en = 'Shasta: I. Rondo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17769 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:6a76be14-58ca-36e8-b0bd-1433f16470a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a76be14-58ca-36e8-b0bd-1433f16470a1', 1, 'I', 'Rondo', 'Shasta: I. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17769 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a76be14-58ca-36e8-b0bd-1433f16470a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Aria', part.name_en = 'Shasta: II. Aria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17769 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:812bdb36-9fb3-411f-a5ca-14cf19821cd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:812bdb36-9fb3-411f-a5ca-14cf19821cd0', 2, 'II', 'Aria', 'Shasta: II. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17769 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:812bdb36-9fb3-411f-a5ca-14cf19821cd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Capriccio', part.name_en = 'Shasta: III. Capriccio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17769 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:1e3ac3ce-c82a-4cec-90ed-f91670dca9ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e3ac3ce-c82a-4cec-90ed-f91670dca9ee', 3, 'III', 'Capriccio', 'Shasta: III. Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17769 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e3ac3ce-c82a-4cec-90ed-f91670dca9ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Recitativo', part.name_en = 'Shasta: IV. Recitativo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17769 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:c686af08-90cb-47c3-b4d8-90689554115f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c686af08-90cb-47c3-b4d8-90689554115f', 4, 'IV', 'Recitativo', 'Shasta: IV. Recitativo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17769 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c686af08-90cb-47c3-b4d8-90689554115f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Toccata', part.name_en = 'Shasta: V. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 17769 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:d1c3d210-ec01-47c8-bb03-360ec7925810' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c3d210-ec01-47c8-bb03-360ec7925810', 5, 'V', 'Toccata', 'Shasta: V. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 17769 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c3d210-ec01-47c8-bb03-360ec7925810'
);


-- None Sindbad

UPDATE pieces piece
SET piece.title = 'Sindbad', piece.title_en = 'Sindbad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18835 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 트럼펫과 오르간을 위한 소나타

UPDATE pieces piece
SET piece.title = '트럼펫과 오르간을 위한 소나타', piece.title_en = 'Sonata for Trumpet and Organ',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19468 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con spirito', part.name_en = 'Sonata for Trumpet and Organ: I. Allegro con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19468 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:adb4d4d3-3603-40c0-b67c-1ea37d8aebe6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adb4d4d3-3603-40c0-b67c-1ea37d8aebe6', 1, 'I', 'Allegro con spirito', 'Sonata for Trumpet and Organ: I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19468 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adb4d4d3-3603-40c0-b67c-1ea37d8aebe6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Sonata for Trumpet and Organ: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19468 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:d156327a-c8ed-4d9b-bd26-6132775ce349' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d156327a-c8ed-4d9b-bd26-6132775ce349', 2, 'II', 'Moderato', 'Sonata for Trumpet and Organ: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19468 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d156327a-c8ed-4d9b-bd26-6132775ce349'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'Sonata for Trumpet and Organ: III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19468 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:9ceef5e9-4413-4d62-8d08-8ceeb8c7d255' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ceef5e9-4413-4d62-8d08-8ceeb8c7d255', 3, 'III', 'Presto', 'Sonata for Trumpet and Organ: III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19468 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ceef5e9-4413-4d62-8d08-8ceeb8c7d255'
);


-- None Suite Française

UPDATE pieces piece
SET piece.title = 'Suite Française', piece.title_en = 'Suite Française',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18443 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Entrée sur les Grands Jeux', part.name_en = 'Suite Française: I. Entrée sur les Grands Jeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:1ee06705-5386-4876-90db-22734a23871c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ee06705-5386-4876-90db-22734a23871c', 1, 'I', 'Entrée sur les Grands Jeux', 'Suite Française: I. Entrée sur les Grands Jeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ee06705-5386-4876-90db-22734a23871c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Flûtes', part.name_en = 'Suite Française: II. Flûtes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:70731c0f-4608-4244-86cc-b628f725ed46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70731c0f-4608-4244-86cc-b628f725ed46', 2, 'II', 'Flûtes', 'Suite Française: II. Flûtes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70731c0f-4608-4244-86cc-b628f725ed46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Dialogue de Cromorne et de Cornet', part.name_en = 'Suite Française: III. Dialogue de Cromorne et de Cornet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:3548a74f-ea33-48da-a059-87f8a14efd84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3548a74f-ea33-48da-a059-87f8a14efd84', 3, 'III', 'Dialogue de Cromorne et de Cornet', 'Suite Française: III. Dialogue de Cromorne et de Cornet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3548a74f-ea33-48da-a059-87f8a14efd84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Premier Plein Jeu', part.name_en = 'Suite Française: IV. Premier Plein Jeu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:66f482ed-b65e-4d7b-b490-64c577915e2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66f482ed-b65e-4d7b-b490-64c577915e2f', 4, 'IV', 'Premier Plein Jeu', 'Suite Française: IV. Premier Plein Jeu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66f482ed-b65e-4d7b-b490-64c577915e2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Fonds et Voix Humaine', part.name_en = 'Suite Française: V. Fonds et Voix Humaine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:90756f12-da13-4275-8433-9a44b686596c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90756f12-da13-4275-8433-9a44b686596c', 5, 'V', 'Fonds et Voix Humaine', 'Suite Française: V. Fonds et Voix Humaine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90756f12-da13-4275-8433-9a44b686596c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Duo', part.name_en = 'Suite Française: VI. Duo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:5ea750dd-cfce-4f46-a9cb-7dc4a22869a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ea750dd-cfce-4f46-a9cb-7dc4a22869a0', 6, 'VI', 'Duo', 'Suite Française: VI. Duo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ea750dd-cfce-4f46-a9cb-7dc4a22869a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Nasard', part.name_en = 'Suite Française: VII. Nasard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:9b3eb3f7-e3aa-4a91-8244-25fef59e4c16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b3eb3f7-e3aa-4a91-8244-25fef59e4c16', 7, 'VII', 'Nasard', 'Suite Française: VII. Nasard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b3eb3f7-e3aa-4a91-8244-25fef59e4c16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Basse de Gambe', part.name_en = 'Suite Française: VIII. Basse de Gambe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:1e415f2f-7df7-4f32-a98b-c358e2f0d813' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e415f2f-7df7-4f32-a98b-c358e2f0d813', 8, 'VIII', 'Basse de Gambe', 'Suite Française: VIII. Basse de Gambe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e415f2f-7df7-4f32-a98b-c358e2f0d813'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Dialogue de Tierce et de Prestant', part.name_en = 'Suite Française: IX. Dialogue de Tierce et de Prestant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:22d8f512-2a0e-4f9c-9ac9-c240d791f801' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22d8f512-2a0e-4f9c-9ac9-c240d791f801', 9, 'IX', 'Dialogue de Tierce et de Prestant', 'Suite Française: IX. Dialogue de Tierce et de Prestant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d8f512-2a0e-4f9c-9ac9-c240d791f801'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Dessus de Trompette', part.name_en = 'Suite Française: X. Dessus de Trompette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:59344053-0a4a-4234-93fe-b94799df5e56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59344053-0a4a-4234-93fe-b94799df5e56', 10, 'X', 'Dessus de Trompette', 'Suite Française: X. Dessus de Trompette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59344053-0a4a-4234-93fe-b94799df5e56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Clairon en Taille', part.name_en = 'Suite Française: XI. Clairon en Taille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:b26c784e-8226-4a71-9124-1fa613227d2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b26c784e-8226-4a71-9124-1fa613227d2c', 11, 'XI', 'Clairon en Taille', 'Suite Française: XI. Clairon en Taille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b26c784e-8226-4a71-9124-1fa613227d2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Deuxième Plein Jeu', part.name_en = 'Suite Française: XII. Deuxième Plein Jeu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18443 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:afe36c7c-4e37-4c68-832f-a44184e05df8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afe36c7c-4e37-4c68-832f-a44184e05df8', 12, 'XII', 'Deuxième Plein Jeu', 'Suite Française: XII. Deuxième Plein Jeu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18443 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afe36c7c-4e37-4c68-832f-a44184e05df8'
);


-- None Suite Norvégienne

UPDATE pieces piece
SET piece.title = 'Suite Norvégienne', piece.title_en = 'Suite Norvégienne',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16891 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Langeleik', part.name_en = 'Suite Norvégienne: I. Langeleik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:8cd22f73-2d61-427b-b30e-452780e0d914' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cd22f73-2d61-427b-b30e-452780e0d914', 1, 'I', 'Langeleik', 'Suite Norvégienne: I. Langeleik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cd22f73-2d61-427b-b30e-452780e0d914'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dype, Stille, Sterke, Milde', part.name_en = 'Suite Norvégienne: II. Dype, Stille, Sterke, Milde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:61aca7da-eab2-4532-ac05-8e1cf1c8f7a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61aca7da-eab2-4532-ac05-8e1cf1c8f7a3', 2, 'II', 'Dype, Stille, Sterke, Milde', 'Suite Norvégienne: II. Dype, Stille, Sterke, Milde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61aca7da-eab2-4532-ac05-8e1cf1c8f7a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Kråkevise', part.name_en = 'Suite Norvégienne: III. Kråkevise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:acbd2652-bbfc-4faa-ae9b-092be35b4e8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acbd2652-bbfc-4faa-ae9b-092be35b4e8b', 3, 'III', 'Kråkevise', 'Suite Norvégienne: III. Kråkevise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acbd2652-bbfc-4faa-ae9b-092be35b4e8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Mitt hjerte alltid vanker', part.name_en = 'Suite Norvégienne: IV. Mitt hjerte alltid vanker',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:c870a7b6-9bff-4e48-a054-bb643a627ac9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c870a7b6-9bff-4e48-a054-bb643a627ac9', 4, 'IV', 'Mitt hjerte alltid vanker', 'Suite Norvégienne: IV. Mitt hjerte alltid vanker', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c870a7b6-9bff-4e48-a054-bb643a627ac9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Bånsull i vals', part.name_en = 'Suite Norvégienne: V. Bånsull i vals',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:47982b75-7dc4-42e8-9fd7-7bbed7d313ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47982b75-7dc4-42e8-9fd7-7bbed7d313ec', 5, 'V', 'Bånsull i vals', 'Suite Norvégienne: V. Bånsull i vals', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47982b75-7dc4-42e8-9fd7-7bbed7d313ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Håvard Hedde', part.name_en = 'Suite Norvégienne: VI. Håvard Hedde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:83974d24-f952-4082-902b-b0d31bc698da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83974d24-f952-4082-902b-b0d31bc698da', 6, 'VI', 'Håvard Hedde', 'Suite Norvégienne: VI. Håvard Hedde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83974d24-f952-4082-902b-b0d31bc698da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Byssan lull', part.name_en = 'Suite Norvégienne: VII. Byssan lull',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:afe943cc-631b-4575-af40-6a0980e35d93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afe943cc-631b-4575-af40-6a0980e35d93', 7, 'VII', 'Byssan lull', 'Suite Norvégienne: VII. Byssan lull', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afe943cc-631b-4575-af40-6a0980e35d93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Litle fuglen', part.name_en = 'Suite Norvégienne: VIII. Litle fuglen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:a1dca710-4dff-4c52-bede-637d29b9edaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1dca710-4dff-4c52-bede-637d29b9edaa', 8, 'VIII', 'Litle fuglen', 'Suite Norvégienne: VIII. Litle fuglen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1dca710-4dff-4c52-bede-637d29b9edaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Kjerringa med staven', part.name_en = 'Suite Norvégienne: IX. Kjerringa med staven',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16891 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:d2e55318-a036-40e5-9092-25322af5f1ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2e55318-a036-40e5-9092-25322af5f1ba', 9, 'IX', 'Kjerringa med staven', 'Suite Norvégienne: IX. Kjerringa med staven', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16891 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2e55318-a036-40e5-9092-25322af5f1ba'
);


-- None Symphonie in honore Sancti Ioannis Babtistae

UPDATE pieces piece
SET piece.title = 'Symphonie in honore Sancti Ioannis Babtistae', piece.title_en = 'Symphonie in honore Sancti Ioannis Babtistae',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16623 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Ut queant laxis', part.name_en = 'Symphonie in honore Sancti Ioannis Babtistae: I. Ut queant laxis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16623 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:d287b321-de5f-442f-ad7d-f2c4d687147c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d287b321-de5f-442f-ad7d-f2c4d687147c', 1, 'I', 'Ut queant laxis', 'Symphonie in honore Sancti Ioannis Babtistae: I. Ut queant laxis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16623 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d287b321-de5f-442f-ad7d-f2c4d687147c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ecce agnus Dei', part.name_en = 'Symphonie in honore Sancti Ioannis Babtistae: II. Ecce agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16623 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:c32f3944-455c-4b9b-a020-8337a927a87e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c32f3944-455c-4b9b-a020-8337a927a87e', 2, 'II', 'Ecce agnus Dei', 'Symphonie in honore Sancti Ioannis Babtistae: II. Ecce agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16623 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c32f3944-455c-4b9b-a020-8337a927a87e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'In spiritu et igni', part.name_en = 'Symphonie in honore Sancti Ioannis Babtistae: III. In spiritu et igni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16623 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:18b8211e-4155-43fe-8bef-7dedbb92a39a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18b8211e-4155-43fe-8bef-7dedbb92a39a', 3, 'III', 'In spiritu et igni', 'Symphonie in honore Sancti Ioannis Babtistae: III. In spiritu et igni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16623 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18b8211e-4155-43fe-8bef-7dedbb92a39a'
);


-- None Tanets

UPDATE pieces piece
SET piece.title = 'Tanets', piece.title_en = 'Tanets',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17882 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Basque Dances

UPDATE pieces piece
SET piece.title = 'Three Basque Dances', piece.title_en = 'Three Basque Dances',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18920 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Zortziko', part.name_en = 'Three Basque Dances: I. Zortziko',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18920 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:710ca83c-224e-4af1-8a78-38234db77924' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:710ca83c-224e-4af1-8a78-38234db77924', 1, 'I', 'Zortziko', 'Three Basque Dances: I. Zortziko', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18920 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:710ca83c-224e-4af1-8a78-38234db77924'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ezpata dantza', part.name_en = 'Three Basque Dances: II. Ezpata dantza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18920 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:3d7b020a-3450-45b8-8130-61580f7b6fcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d7b020a-3450-45b8-8130-61580f7b6fcc', 2, 'II', 'Ezpata dantza', 'Three Basque Dances: II. Ezpata dantza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18920 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d7b020a-3450-45b8-8130-61580f7b6fcc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fandango', part.name_en = 'Three Basque Dances: III. Fandango',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 18920 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:94926a15-32fb-403e-bf00-d834ad7dbae2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94926a15-32fb-403e-bf00-d834ad7dbae2', 3, 'III', 'Fandango', 'Three Basque Dances: III. Fandango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 18920 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94926a15-32fb-403e-bf00-d834ad7dbae2'
);


-- None Trois Paraphrases sur Ave maris stella

UPDATE pieces piece
SET piece.title = 'Trois Paraphrases sur Ave maris stella', piece.title_en = 'Trois Paraphrases sur Ave maris stella',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16542 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sumens illud Ave', part.name_en = 'Trois Paraphrases sur Ave maris stella: I. Sumens illud Ave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16542 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:af7a449e-95da-40a0-bc24-cdc8529647c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af7a449e-95da-40a0-bc24-cdc8529647c6', 1, 'I', 'Sumens illud Ave', 'Trois Paraphrases sur Ave maris stella: I. Sumens illud Ave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16542 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af7a449e-95da-40a0-bc24-cdc8529647c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Monstra te esse matrem', part.name_en = 'Trois Paraphrases sur Ave maris stella: II. Monstra te esse matrem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16542 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:79fb363e-f470-4eef-a6a7-e655bff9af38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79fb363e-f470-4eef-a6a7-e655bff9af38', 2, 'II', 'Monstra te esse matrem', 'Trois Paraphrases sur Ave maris stella: II. Monstra te esse matrem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16542 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79fb363e-f470-4eef-a6a7-e655bff9af38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vitam praesta puram', part.name_en = 'Trois Paraphrases sur Ave maris stella: III. Vitam praesta puram',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 16542 AND p.composer_id = 296 AND part.part_key = 'musicbrainz:631f1f0f-b521-4406-ad4f-57bcadb70935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:631f1f0f-b521-4406-ad4f-57bcadb70935', 3, 'III', 'Vitam praesta puram', 'Trois Paraphrases sur Ave maris stella: III. Vitam praesta puram', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 16542 AND p.composer_id = 296
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:631f1f0f-b521-4406-ad4f-57bcadb70935'
);


-- None 왈츠

UPDATE pieces piece
SET piece.title = '왈츠', piece.title_en = 'Valse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18577 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Variations on Two Themes

UPDATE pieces piece
SET piece.title = 'Variations on Two Themes', piece.title_en = 'Variations on Two Themes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16023 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vexilla regis prodeunt

UPDATE pieces piece
SET piece.title = 'Vexilla regis prodeunt', piece.title_en = 'Vexilla regis prodeunt',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19862 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Villancico aragonés

UPDATE pieces piece
SET piece.title = 'Villancico aragonés', piece.title_en = 'Villancico aragonés',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18770 AND piece.composer_id = 296
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Aalaiki'ssalaam

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Aalaiki''ssalaam', 'Aalaiki''ssalaam', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Aalaiki''ssalaam'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4fc4808-027a-448e-b841-1aa34b27aa14'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4fc4808-027a-448e-b841-1aa34b27aa14'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Aalaiki''ssalaam' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4fc4808-027a-448e-b841-1aa34b27aa14'
);


-- None Bogurodzica

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Bogurodzica', 'Bogurodzica', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Bogurodzica'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1da4959-51d8-42f5-916e-978c94bffe48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e1da4959-51d8-42f5-916e-978c94bffe48'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Bogurodzica' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1da4959-51d8-42f5-916e-978c94bffe48'
);


-- None Canticum

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Canticum', 'Canticum', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Canticum'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec6f9a17-f81b-4a9e-a4f8-9d6dd2a96f84'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec6f9a17-f81b-4a9e-a4f8-9d6dd2a96f84'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Canticum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec6f9a17-f81b-4a9e-a4f8-9d6dd2a96f84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79349d12-e2eb-4065-b31d-cfe240ae41e8', 1, 'I', 'Conditor alme siderum', 'Canticum: I. Conditor alme siderum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Canticum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79349d12-e2eb-4065-b31d-cfe240ae41e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b127c6e-076b-40f0-9a26-51d51b7badba', 2, 'II', 'Rorate coeli desuper', 'Canticum: II. Rorate coeli desuper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Canticum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b127c6e-076b-40f0-9a26-51d51b7badba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5018acbb-5024-4a34-b5d2-954c64463313', 3, 'III', 'O Emmanuel', 'Canticum: III. O Emmanuel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Canticum' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5018acbb-5024-4a34-b5d2-954c64463313'
);


-- None Carnaval

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Carnaval', 'Carnaval', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Carnaval'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f0165d1-514a-4d29-b239-d958c2bb2072'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f0165d1-514a-4d29-b239-d958c2bb2072'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Carnaval' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f0165d1-514a-4d29-b239-d958c2bb2072'
);


-- None Esquisses persanes

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Esquisses persanes', 'Esquisses persanes', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Esquisses persanes'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57fe80bd-2538-4bca-b911-dc07ff19f61d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '57fe80bd-2538-4bca-b911-dc07ff19f61d'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Esquisses persanes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57fe80bd-2538-4bca-b911-dc07ff19f61d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3fa87b2-9d47-4e3c-81b5-ce57e699efaf', 1, 'I', 'Niya Yesh', 'Esquisses persanes: I. Niya Yesh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Esquisses persanes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3fa87b2-9d47-4e3c-81b5-ce57e699efaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca7e7644-194a-425e-b8ae-76e789e41747', 2, 'II', 'Raqs', 'Esquisses persanes: II. Raqs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Esquisses persanes' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca7e7644-194a-425e-b8ae-76e789e41747'
);


-- None Glenalmond Suite

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Glenalmond Suite', 'Glenalmond Suite', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Glenalmond Suite'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '991879ee-6af9-41ec-9785-6a1371f18276'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '991879ee-6af9-41ec-9785-6a1371f18276'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Glenalmond Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '991879ee-6af9-41ec-9785-6a1371f18276'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ecbfac0-04bc-450b-9341-e28954dbf2ca', 1, 'I', 'Ruisselant', 'Glenalmond Suite: I. Ruisselant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Glenalmond Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ecbfac0-04bc-450b-9341-e28954dbf2ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7f36200-11ab-4b04-bebc-d42e22b31578', 2, 'II', 'Embrassant', 'Glenalmond Suite: II. Embrassant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Glenalmond Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7f36200-11ab-4b04-bebc-d42e22b31578'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73fb49b5-fd93-4846-8c4b-10956001d57c', 3, 'III', 'Souriant', 'Glenalmond Suite: III. Souriant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Glenalmond Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73fb49b5-fd93-4846-8c4b-10956001d57c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:242334fa-90aa-4245-a69f-80b634b40c9f', 4, 'IV', 'Jubilant', 'Glenalmond Suite: IV. Jubilant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Glenalmond Suite' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:242334fa-90aa-4245-a69f-80b634b40c9f'
);


-- None Ouverture libanaise

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Ouverture libanaise', 'Ouverture libanaise', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Ouverture libanaise'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6238d18-287c-44d3-af45-50b8fabc3dcf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6238d18-287c-44d3-af45-50b8fabc3dcf'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Ouverture libanaise' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6238d18-287c-44d3-af45-50b8fabc3dcf'
);


-- None Sakskøbing Præludier

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Sakskøbing Præludier', 'Sakskøbing Præludier', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Sakskøbing Præludier'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11f53989-8b23-4f5e-a33d-751db7806f6c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11f53989-8b23-4f5e-a33d-751db7806f6c'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11f53989-8b23-4f5e-a33d-751db7806f6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:143e42bf-bd11-4da0-baaa-82e6563af05f', 1, NULL, 'Så vældigt det mødte os først i vor dåb', 'Sakskøbing Præludier: Så vældigt det mødte os først i vor dåb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:143e42bf-bd11-4da0-baaa-82e6563af05f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:255da4c5-4ac0-424e-8604-016a42d5b57d', 2, NULL, 'Nu blomstertiden kommer', 'Sakskøbing Præludier: Nu blomstertiden kommer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:255da4c5-4ac0-424e-8604-016a42d5b57d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ca2a16c-1ae1-4ce6-8d81-8f45c79c1d87', 3, NULL, 'Befal du dine veje', 'Sakskøbing Præludier: Befal du dine veje', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ca2a16c-1ae1-4ce6-8d81-8f45c79c1d87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b0670a2-28a7-44c1-9f08-61f6d31f681f', 4, NULL, 'Den mørke nat forgangen er', 'Sakskøbing Præludier: Den mørke nat forgangen er', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b0670a2-28a7-44c1-9f08-61f6d31f681f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44978b5a-5f69-4e48-bd0e-ce82b84c6e04', 5, NULL, 'Op, al den ting, som Gud har gjort', 'Sakskøbing Præludier: Op, al den ting, som Gud har gjort', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44978b5a-5f69-4e48-bd0e-ce82b84c6e04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60c01df7-1de7-485e-85c4-2e2776f3d425', 6, NULL, 'O kristelighed!', 'Sakskøbing Præludier: O kristelighed!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60c01df7-1de7-485e-85c4-2e2776f3d425'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ebebf0a-c2a9-428e-96ef-c05fa2023a7f', 7, NULL, 'O Gud, du ved og kender', 'Sakskøbing Præludier: O Gud, du ved og kender', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ebebf0a-c2a9-428e-96ef-c05fa2023a7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78267621-1dc2-4bc4-97a3-d4839ac870d6', 8, NULL, 'Nærmere, Gud, til dig', 'Sakskøbing Præludier: Nærmere, Gud, til dig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78267621-1dc2-4bc4-97a3-d4839ac870d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8502a0eb-0777-41e5-9fbd-8764db61f455', 9, NULL, 'Hil dig, Frelser og Forsoner!', 'Sakskøbing Præludier: Hil dig, Frelser og Forsoner!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8502a0eb-0777-41e5-9fbd-8764db61f455'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:862b21fa-4fef-467b-8f51-7e464602f76c', 10, NULL, 'At sige verden ret farvel', 'Sakskøbing Præludier: At sige verden ret farvel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:862b21fa-4fef-467b-8f51-7e464602f76c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2e3d887-b2ad-4721-b846-f697981d1730', 11, NULL, 'Påskeblomst! hvad vil du her?', 'Sakskøbing Præludier: Påskeblomst! hvad vil du her?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2e3d887-b2ad-4721-b846-f697981d1730'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7312491-fbc0-4e79-b50a-1774d2097487', 12, NULL, 'Mit hjerte altid vanker', 'Sakskøbing Præludier: Mit hjerte altid vanker', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Sakskøbing Præludier' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7312491-fbc0-4e79-b50a-1774d2097487'
);


-- None Salve Regina

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Salve Regina', 'Salve Regina', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 296
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Salve Regina'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '045a5816-2eec-4c71-b305-04a4a497c1f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '045a5816-2eec-4c71-b305-04a4a497c1f7'
FROM pieces p
WHERE p.composer_id = 296 AND p.title = 'Salve Regina' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '045a5816-2eec-4c71-b305-04a4a497c1f7'
);


-- 카탈로그에 대응이 없는 seed 작품 3개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 296 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    16502, 17209, 17420
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
