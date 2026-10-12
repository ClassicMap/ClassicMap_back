-- 아이브스 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 227개(묶음 9, 다악장 23, 낱곡 195),
-- 새 작품 3개, part 113개, 그 아래 0개.
-- seed 288개 중 221개를 작품·part 에 잇고, 46개를 숨기고, 21개는 그대로 둔다.
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

-- S. 321 가곡 <"1, 2, 3">

UPDATE pieces piece
SET piece.title = '가곡 <"1, 2, 3">', piece.title_en = '"1, 2, 3", S. 321',
    piece.type = 'song', piece.opus_number = 'S. 321',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10984 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 248 가곡 <A Farewell to Land>

UPDATE pieces piece
SET piece.title = '가곡 <A Farewell to Land>', piece.title_en = 'A Farewell to Land, S. 248',
    piece.type = 'song', piece.opus_number = 'S. 248',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9339 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 310 가곡 <A Night Song>

UPDATE pieces piece
SET piece.title = '가곡 <A Night Song>', piece.title_en = 'A Night Song, S. 310',
    piece.type = 'song', piece.opus_number = 'S. 310',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9315 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 311 가곡 <A Night Thought>

UPDATE pieces piece
SET piece.title = '가곡 <A Night Thought>', piece.title_en = 'A Night Thought, S. 311',
    piece.type = 'song', piece.opus_number = 'S. 311',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8142 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 326 가곡 <A Perfect Day>

UPDATE pieces piece
SET piece.title = '가곡 <A Perfect Day>', piece.title_en = 'A Perfect Day, S. 326',
    piece.type = 'song', piece.opus_number = 'S. 326',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8286 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 341 가곡 <A Scotch Lullaby>

UPDATE pieces piece
SET piece.title = '가곡 <A Scotch Lullaby>', piece.title_en = 'A Scotch Lullaby, S. 341',
    piece.type = 'song', piece.opus_number = 'S. 341',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8285 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 342 가곡 <A Sea Dirge>

UPDATE pieces piece
SET piece.title = '가곡 <A Sea Dirge>', piece.title_en = 'A Sea Dirge, S. 342',
    piece.type = 'song', piece.opus_number = 'S. 342',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9907 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 84 A Set of Three Short Pieces

UPDATE pieces piece
SET piece.title = 'A Set of Three Short Pieces', piece.title_en = 'A Set of Three Short Pieces, S. 84',
    piece.type = 'album', piece.opus_number = 'S. 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8280 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo cantabile: Hymn', part.name_en = 'A Set of Three Short Pieces, S. 84: I. Largo cantabile: Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8280 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:895c5ac9-01e4-4bce-a95b-498fcec4538a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:895c5ac9-01e4-4bce-a95b-498fcec4538a', 1, 'I', 'Largo cantabile: Hymn', 'A Set of Three Short Pieces, S. 84: I. Largo cantabile: Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8280 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:895c5ac9-01e4-4bce-a95b-498fcec4538a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo: Holding Your Own!', part.name_en = 'A Set of Three Short Pieces, S. 84: II. Scherzo: Holding Your Own!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8280 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:0c027909-8489-4385-944c-f0443b2bf58f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c027909-8489-4385-944c-f0443b2bf58f', 2, 'II', 'Scherzo: Holding Your Own!', 'A Set of Three Short Pieces, S. 84: II. Scherzo: Holding Your Own!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8280 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c027909-8489-4385-944c-f0443b2bf58f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio cantabile: The Innate', part.name_en = 'A Set of Three Short Pieces, S. 84: III. Adagio cantabile: The Innate',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8280 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:f979b03a-1dc5-49c4-8c19-a7a902784b39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f979b03a-1dc5-49c4-8c19-a7a902784b39', 3, 'III', 'Adagio cantabile: The Innate', 'A Set of Three Short Pieces, S. 84: III. Adagio cantabile: The Innate', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8280 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f979b03a-1dc5-49c4-8c19-a7a902784b39'
);


-- S. 355 가곡 <A Song--For Anything>

UPDATE pieces piece
SET piece.title = '가곡 <A Song--For Anything>', piece.title_en = 'A Song--For Anything, S. 355',
    piece.type = 'song', piece.opus_number = 'S. 355',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10597 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 5 A Symphony: New England Holidays S. 5

UPDATE pieces piece
SET piece.title = 'A Symphony: New England Holidays S. 5', piece.title_en = 'A Symphony: New England Holidays, S. 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'S.', piece.catalogue_number = '5',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9927 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Winter: Washington''s Birthday', part.name_en = 'A Symphony: New England Holidays, S. 5: I. Winter: Washington''s Birthday',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9927 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:f73075c6-fa48-4254-a177-ea3cfa4ff776' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f73075c6-fa48-4254-a177-ea3cfa4ff776', 1, NULL, 'Winter: Washington''s Birthday', 'A Symphony: New England Holidays, S. 5: I. Winter: Washington''s Birthday', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9927 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f73075c6-fa48-4254-a177-ea3cfa4ff776'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Spring: Decoration Day', part.name_en = 'A Symphony: New England Holidays, S. 5: II. Spring: Decoration Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9927 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:41ca205c-ac6a-4b54-9779-b08572007809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ca205c-ac6a-4b54-9779-b08572007809', 2, NULL, 'Spring: Decoration Day', 'A Symphony: New England Holidays, S. 5: II. Spring: Decoration Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9927 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ca205c-ac6a-4b54-9779-b08572007809'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Summer: The Fourth of July', part.name_en = 'A Symphony: New England Holidays, S. 5: III. Summer: The Fourth of July',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9927 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:42f7f5ad-fafa-4d88-8aa3-69660c9d778c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42f7f5ad-fafa-4d88-8aa3-69660c9d778c', 3, NULL, 'Summer: The Fourth of July', 'A Symphony: New England Holidays, S. 5: III. Summer: The Fourth of July', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9927 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42f7f5ad-fafa-4d88-8aa3-69660c9d778c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Autumn: Thanksgiving and Forefathers'' Day', part.name_en = 'A Symphony: New England Holidays, S. 5: IV. Autumn: Thanksgiving and Forefathers'' Day',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9927 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:f88a4b29-68ea-4669-9d4d-50fe5fdc0f42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f88a4b29-68ea-4669-9d4d-50fe5fdc0f42', 4, NULL, 'Autumn: Thanksgiving and Forefathers'' Day', 'A Symphony: New England Holidays, S. 5: IV. Autumn: Thanksgiving and Forefathers'' Day', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9927 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f88a4b29-68ea-4669-9d4d-50fe5fdc0f42'
);


-- S. 205 가곡 <Abide With Me>

UPDATE pieces piece
SET piece.title = '가곡 <Abide With Me>', piece.title_en = 'Abide With Me, S. 205',
    piece.type = 'song', piece.opus_number = 'S. 205',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11068 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Adeste fidelis

UPDATE pieces piece
SET piece.title = 'Adeste fidelis', piece.title_en = 'Adeste fidelis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9182 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 206 가곡 <Aeschylus and Sophocles>

UPDATE pieces piece
SET piece.title = '가곡 <Aeschylus and Sophocles>', piece.title_en = 'Aeschylus and Sophocles, S. 206',
    piece.type = 'song', piece.opus_number = 'S. 206',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10610 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 207 가곡 <Afterglow>

UPDATE pieces piece
SET piece.title = '가곡 <Afterglow>', piece.title_en = 'Afterglow, S. 207',
    piece.type = 'song', piece.opus_number = 'S. 207',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7902 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None All-Forgiving, Look On Me

UPDATE pieces piece
SET piece.title = 'All-Forgiving, Look On Me', piece.title_en = 'All-Forgiving, Look On Me',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10233 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 208 가곡 <Allegro>

UPDATE pieces piece
SET piece.title = '가곡 <Allegro>', piece.title_en = 'Allegro, S. 208',
    piece.type = 'song', piece.opus_number = 'S. 208',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11118 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 210 가곡 <Amphion>

UPDATE pieces piece
SET piece.title = '가곡 <Amphion>', piece.title_en = 'Amphion, S. 210',
    piece.type = 'song', piece.opus_number = 'S. 210',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9106 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 180 가곡 <An Election>

UPDATE pieces piece
SET piece.title = '가곡 <An Election>', piece.title_en = 'An Election, S. 180',
    piece.type = 'song', piece.opus_number = 'S. 180',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9696 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 314 가곡 <An Old Flame>

UPDATE pieces piece
SET piece.title = '가곡 <An Old Flame>', piece.title_en = 'An Old Flame, S. 314 (K. 6B23c)',
    piece.type = 'song', piece.opus_number = 'S. 314',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8422 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 211 가곡 <Ann Street>

UPDATE pieces piece
SET piece.title = '가곡 <Ann Street>', piece.title_en = 'Ann Street, S. 211',
    piece.type = 'song', piece.opus_number = 'S. 211',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10104 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 212 가곡 <At Parting>

UPDATE pieces piece
SET piece.title = '가곡 <At Parting>', piece.title_en = 'At Parting, S. 212',
    piece.type = 'song', piece.opus_number = 'S. 212',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9832 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 214 가곡 <At the River>

UPDATE pieces piece
SET piece.title = '가곡 <At the River>', piece.title_en = 'At the River, S. 214',
    piece.type = 'song', piece.opus_number = 'S. 214',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8840 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 216 가곡 <August>

UPDATE pieces piece
SET piece.title = '가곡 <August>', piece.title_en = 'August, S. 216',
    piece.type = 'song', piece.opus_number = 'S. 216',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11197 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 217 가곡 <Autumn>

UPDATE pieces piece
SET piece.title = '가곡 <Autumn>', piece.title_en = 'Autumn, S. 217',
    piece.type = 'song', piece.opus_number = 'S. 217',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10950 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 219 가곡 <Because Thou Art>

UPDATE pieces piece
SET piece.title = '가곡 <Because Thou Art>', piece.title_en = 'Because Thou Art, S. 219',
    piece.type = 'song', piece.opus_number = 'S. 219',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10235 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 218 가곡 <Because of You>

UPDATE pieces piece
SET piece.title = '가곡 <Because of You>', piece.title_en = 'Because of You, S. 218',
    piece.type = 'song', piece.opus_number = 'S. 218',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10311 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Benedictus in E

UPDATE pieces piece
SET piece.title = 'Benedictus in E', piece.title_en = 'Benedictus in E',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9308 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Canon [I], S. 223 "Not only in my lady's eyes">

UPDATE pieces piece
SET piece.title = '가곡 <Canon [I], S. 223 "Not only in my lady''s eyes">', piece.title_en = 'Canon [I], S. 223 "Not only in my lady''s eyes"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10479 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 34 Central Park in the Dark

UPDATE pieces piece
SET piece.title = 'Central Park in the Dark', piece.title_en = 'Central Park in the Dark, S. 34',
    piece.type = 'song', piece.opus_number = 'S. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1825 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 225 가곡 <Chanson de Florian>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson de Florian>', piece.title_en = 'Chanson de Florian, S. 225',
    piece.type = 'song', piece.opus_number = 'S. 225',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10404 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 226 가곡 <Charlie Rutlage>

UPDATE pieces piece
SET piece.title = '가곡 <Charlie Rutlage>', piece.title_en = 'Charlie Rutlage, S. 226',
    piece.type = 'song', piece.opus_number = 'S. 226',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9140 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 35 Chromâtimelôdtune

UPDATE pieces piece
SET piece.title = 'Chromâtimelôdtune', piece.title_en = 'Chromâtimelôdtune, S. 35',
    piece.type = 'song', piece.opus_number = 'S. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7985 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 233 가곡 <Cradle Song>

UPDATE pieces piece
SET piece.title = '가곡 <Cradle Song>', piece.title_en = 'Cradle Song, S. 233',
    piece.type = 'song', piece.opus_number = 'S. 233',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9011 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Crossing the Bar

UPDATE pieces piece
SET piece.title = 'Crossing the Bar', piece.title_en = 'Crossing the Bar',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9238 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 234 가곡 <December>

UPDATE pieces piece
SET piece.title = '가곡 <December>', piece.title_en = 'December, S. 234',
    piece.type = 'song', piece.opus_number = 'S. 234',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9614 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 235 가곡 <Disclosure>

UPDATE pieces piece
SET piece.title = '가곡 <Disclosure>', piece.title_en = 'Disclosure, S. 235',
    piece.type = 'song', piece.opus_number = 'S. 235',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8333 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 236 가곡 <Down East>

UPDATE pieces piece
SET piece.title = '가곡 <Down East>', piece.title_en = 'Down East, S. 236',
    piece.type = 'song', piece.opus_number = 'S. 236',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10029 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 238 가곡 <Dreams>

UPDATE pieces piece
SET piece.title = '가곡 <Dreams>', piece.title_en = 'Dreams, S. 238',
    piece.type = 'song', piece.opus_number = 'S. 238',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9586 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 239 가곡 <Du alte Mutter / My dear old mother>

UPDATE pieces piece
SET piece.title = '가곡 <Du alte Mutter / My dear old mother>', piece.title_en = 'Du alte Mutter / My dear old mother, S. 239',
    piece.type = 'song', piece.opus_number = 'S. 239',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10952 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 240 가곡 <Du bist wie eine Blume>

UPDATE pieces piece
SET piece.title = '가곡 <Du bist wie eine Blume>', piece.title_en = 'Du bist wie eine Blume, S. 240',
    piece.type = 'song', piece.opus_number = 'S. 240',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7958 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Easter Carol

UPDATE pieces piece
SET piece.title = 'Easter Carol', piece.title_en = 'Easter Carol',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11205 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 241 가곡 <Ein Ton / I hear a tone>

UPDATE pieces piece
SET piece.title = '가곡 <Ein Ton / I hear a tone>', piece.title_en = 'Ein Ton / I hear a tone, S. 241',
    piece.type = 'song', piece.opus_number = 'S. 241',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10319 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 22 Emerson Concerto S. 22

UPDATE pieces piece
SET piece.title = 'Emerson Concerto S. 22', piece.title_en = 'Emerson Concerto, S. 22',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'S.', piece.catalogue_number = '22',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7560 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'I', part.name_en = 'Emerson Concerto, S. 22: I.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7560 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:b5d9efdc-ecfc-4001-b7d6-1ac07ff0410f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5d9efdc-ecfc-4001-b7d6-1ac07ff0410f', 1, NULL, 'I', 'Emerson Concerto, S. 22: I.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7560 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5d9efdc-ecfc-4001-b7d6-1ac07ff0410f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'II', part.name_en = 'Emerson Concerto, S. 22: II.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7560 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:d2b41efc-ee3c-4780-82e8-5c413ae18ace' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2b41efc-ee3c-4780-82e8-5c413ae18ace', 2, NULL, 'II', 'Emerson Concerto, S. 22: II.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7560 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2b41efc-ee3c-4780-82e8-5c413ae18ace'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'III', part.name_en = 'Emerson Concerto, S. 22: III.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7560 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:2dd33a55-48ba-437d-a559-cb7df9f33982' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dd33a55-48ba-437d-a559-cb7df9f33982', 3, NULL, 'III', 'Emerson Concerto, S. 22: III.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7560 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dd33a55-48ba-437d-a559-cb7df9f33982'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'IV', part.name_en = 'Emerson Concerto, S. 22: IV.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7560 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:d19764a8-ccd2-4fca-a793-ccd95c89a496' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d19764a8-ccd2-4fca-a793-ccd95c89a496', 4, NULL, 'IV', 'Emerson Concerto, S. 22: IV.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7560 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d19764a8-ccd2-4fca-a793-ccd95c89a496'
);


-- S. 244 가곡 <Evening>

UPDATE pieces piece
SET piece.title = '가곡 <Evening>', piece.title_en = 'Evening, S. 244',
    piece.type = 'song', piece.opus_number = 'S. 244',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10240 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 245 가곡 <Evidence>

UPDATE pieces piece
SET piece.title = '가곡 <Evidence>', piece.title_en = 'Evidence, S. 245',
    piece.type = 'song', piece.opus_number = 'S. 245',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10823 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 246 가곡 <Far from my Heavenly Home>

UPDATE pieces piece
SET piece.title = '가곡 <Far from my Heavenly Home>', piece.title_en = 'Far from my Heavenly Home, S. 246',
    piece.type = 'song', piece.opus_number = 'S. 246',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8515 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 250 가곡 <Feldeinsamkeit / In Summer Fields>

UPDATE pieces piece
SET piece.title = '가곡 <Feldeinsamkeit / In Summer Fields>', piece.title_en = 'Feldeinsamkeit / In Summer Fields, S. 250',
    piece.type = 'song', piece.opus_number = 'S. 250',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10973 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 251 가곡 <Flag Song>

UPDATE pieces piece
SET piece.title = '가곡 <Flag Song>', piece.title_en = 'Flag Song, S. 251',
    piece.type = 'song', piece.opus_number = 'S. 251',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10851 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 43 Four Ragtime Dances S. 43

UPDATE pieces piece
SET piece.title = 'Four Ragtime Dances S. 43', piece.title_en = 'Four Ragtime Dances, S. 43',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'S.', piece.catalogue_number = '43',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8713 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Four Ragtime Dances, S. 43: No. 1. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8713 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:1149d126-9e4c-4a8a-a59c-a500096b7f4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1149d126-9e4c-4a8a-a59c-a500096b7f4e', 1, NULL, 'Allegro moderato', 'Four Ragtime Dances, S. 43: No. 1. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8713 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1149d126-9e4c-4a8a-a59c-a500096b7f4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Four Ragtime Dances, S. 43: No. 2. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8713 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:f16d6a55-b073-407b-96af-e4bae2f93ae8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f16d6a55-b073-407b-96af-e4bae2f93ae8', 2, NULL, 'Allegro moderato', 'Four Ragtime Dances, S. 43: No. 2. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8713 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f16d6a55-b073-407b-96af-e4bae2f93ae8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Four Ragtime Dances, S. 43: No. 3. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8713 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:5399fc0f-dee6-4934-bc01-d7dd6a8ade0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5399fc0f-dee6-4934-bc01-d7dd6a8ade0e', 3, NULL, 'Allegro', 'Four Ragtime Dances, S. 43: No. 3. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8713 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5399fc0f-dee6-4934-bc01-d7dd6a8ade0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Four Ragtime Dances, S. 43: No. 4. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8713 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:3bd32227-9b79-4d89-af55-aafbce712576' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bd32227-9b79-4d89-af55-aafbce712576', 4, NULL, 'Allegro', 'Four Ragtime Dances, S. 43: No. 4. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8713 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bd32227-9b79-4d89-af55-aafbce712576'
);


-- S. 123 Four Transcriptions from "Emerson"

UPDATE pieces piece
SET piece.title = 'Four Transcriptions from "Emerson"', piece.title_en = 'Four Transcriptions from "Emerson", S. 123',
    piece.type = 'album', piece.opus_number = 'S. 123',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10990 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Slowly', part.name_en = 'Four Transcriptions from "Emerson", S. 123: I. Slowly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10990 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:060ec650-3e0e-4d49-b337-f1d2e556fb43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:060ec650-3e0e-4d49-b337-f1d2e556fb43', 1, 'I', 'Slowly', 'Four Transcriptions from "Emerson", S. 123: I. Slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10990 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:060ec650-3e0e-4d49-b337-f1d2e556fb43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'Four Transcriptions from "Emerson", S. 123: II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10990 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:2af75d30-dcaa-41b3-b1fa-d9d15d39def1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2af75d30-dcaa-41b3-b1fa-d9d15d39def1', 2, 'II', 'Moderato', 'Four Transcriptions from "Emerson", S. 123: II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10990 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2af75d30-dcaa-41b3-b1fa-d9d15d39def1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'Four Transcriptions from "Emerson", S. 123: III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10990 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:3219fec1-ffd4-46a4-8078-8f58da1293e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3219fec1-ffd4-46a4-8078-8f58da1293e9', 3, 'III', 'Largo', 'Four Transcriptions from "Emerson", S. 123: III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10990 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3219fec1-ffd4-46a4-8078-8f58da1293e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro agitato - Broadly', part.name_en = 'Four Transcriptions from "Emerson", S. 123: IV. Allegro agitato - Broadly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10990 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:48621f15-ecc1-470f-bde4-48edc4f6567a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48621f15-ecc1-470f-bde4-48edc4f6567a', 4, 'IV', 'Allegro agitato - Broadly', 'Four Transcriptions from "Emerson", S. 123: IV. Allegro agitato - Broadly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10990 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48621f15-ecc1-470f-bde4-48edc4f6567a'
);


-- S. 253 가곡 <Friendship>

UPDATE pieces piece
SET piece.title = '가곡 <Friendship>', piece.title_en = 'Friendship, S. 253',
    piece.type = 'song', piece.opus_number = 'S. 253',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10374 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 65 From the Steeples and the Mountains

UPDATE pieces piece
SET piece.title = 'From the Steeples and the Mountains', piece.title_en = 'From the Steeples and the Mountains, S. 65',
    piece.type = 'song', piece.opus_number = 'S. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10126 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 254 가곡 <Frühlingslied>

UPDATE pieces piece
SET piece.title = '가곡 <Frühlingslied>', piece.title_en = 'Frühlingslied, S. 254',
    piece.type = 'song', piece.opus_number = 'S. 254',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10151 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 69 푸가 "The Shining Shore"

UPDATE pieces piece
SET piece.title = '푸가 "The Shining Shore"', piece.title_en = 'Fugue in Four Keys on "The Shining Shore", S. 69',
    piece.type = 'song', piece.opus_number = 'S. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7795 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 255 가곡 <General William Booth Enters into Heaven>

UPDATE pieces piece
SET piece.title = '가곡 <General William Booth Enters into Heaven>', piece.title_en = 'General William Booth Enters into Heaven, S. 255',
    piece.type = 'song', piece.opus_number = 'S. 255',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8602 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 256 가곡 <God Bless and Keep Thee>

UPDATE pieces piece
SET piece.title = '가곡 <God Bless and Keep Thee>', piece.title_en = 'God Bless and Keep Thee, S. 256',
    piece.type = 'song', piece.opus_number = 'S. 256',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9439 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 258 가곡 <Grantchester>

UPDATE pieces piece
SET piece.title = '가곡 <Grantchester>', piece.title_en = 'Grantchester, S. 258',
    piece.type = 'song', piece.opus_number = 'S. 258',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8735 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 261 가곡 <Harpalus>

UPDATE pieces piece
SET piece.title = '가곡 <Harpalus>', piece.title_en = 'Harpalus, S. 261',
    piece.type = 'song', piece.opus_number = 'S. 261',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11281 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 262 가곡 <He Is There!>

UPDATE pieces piece
SET piece.title = '가곡 <He Is There!>', piece.title_en = 'He Is There!, S. 262',
    piece.type = 'song', piece.opus_number = 'S. 262',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10028 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 263 가곡 <Her Eyes>

UPDATE pieces piece
SET piece.title = '가곡 <Her Eyes>', piece.title_en = 'Her Eyes, S. 263',
    piece.type = 'song', piece.opus_number = 'S. 263',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10903 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 264 가곡 <Her Gown Was Vermilion Silk>

UPDATE pieces piece
SET piece.title = '가곡 <Her Gown Was Vermilion Silk>', piece.title_en = 'Her Gown Was Vermilion Silk, S. 264',
    piece.type = 'song', piece.opus_number = 'S. 264',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8631 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 265 가곡 <His Exaltation>

UPDATE pieces piece
SET piece.title = '가곡 <His Exaltation>', piece.title_en = 'His Exaltation, S. 265',
    piece.type = 'song', piece.opus_number = 'S. 265',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8943 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Holiday Quickstep

UPDATE pieces piece
SET piece.title = 'Holiday Quickstep', piece.title_en = 'Holiday Quickstep',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8505 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 267 찬가

UPDATE pieces piece
SET piece.title = '찬가', piece.title_en = 'Hymn, S. 267',
    piece.type = 'song', piece.opus_number = 'S. 267',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8184 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None I Come To Thee

UPDATE pieces piece
SET piece.title = 'I Come To Thee', piece.title_en = 'I Come To Thee',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8450 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 269 가곡 <I Knew and Loved a Maid>

UPDATE pieces piece
SET piece.title = '가곡 <I Knew and Loved a Maid>', piece.title_en = 'I Knew and Loved a Maid, S. 269',
    piece.type = 'song', piece.opus_number = 'S. 269',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11142 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 271 가곡 <Ich Grolle Nicht / I'll Not Complain>

UPDATE pieces piece
SET piece.title = '가곡 <Ich Grolle Nicht / I''ll Not Complain>', piece.title_en = 'Ich Grolle Nicht / I''ll Not Complain, S. 271',
    piece.type = 'song', piece.opus_number = 'S. 271',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10505 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 272 가곡 <Ilmenau / Over all the treetops>

UPDATE pieces piece
SET piece.title = '가곡 <Ilmenau / Over all the treetops>', piece.title_en = 'Ilmenau / Over all the treetops, S. 272',
    piece.type = 'song', piece.opus_number = 'S. 272',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8462 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 273 가곡 <Immortality>

UPDATE pieces piece
SET piece.title = '가곡 <Immortality>', piece.title_en = 'Immortality, S. 273',
    piece.type = 'song', piece.opus_number = 'S. 273',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9440 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 276 가곡 <In Autumn>

UPDATE pieces piece
SET piece.title = '가곡 <In Autumn>', piece.title_en = 'In Autumn, S. 276',
    piece.type = 'song', piece.opus_number = 'S. 276',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8835 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 72 In Re Con Moto et al.

UPDATE pieces piece
SET piece.title = 'In Re Con Moto et al.', piece.title_en = 'In Re Con Moto et al., S. 72',
    piece.type = 'song', piece.opus_number = 'S. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8944 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 279 가곡 <In the Alley>

UPDATE pieces piece
SET piece.title = '가곡 <In the Alley>', piece.title_en = 'In the Alley, S. 279',
    piece.type = 'song', piece.opus_number = 'S. 279',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10927 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 118 인벤션 D

UPDATE pieces piece
SET piece.title = '인벤션 D', piece.title_en = 'Invention in D, S. 118',
    piece.type = 'song', piece.opus_number = 'S. 118',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9906 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 285 가곡 <Kären>

UPDATE pieces piece
SET piece.title = '가곡 <Kären>', piece.title_en = 'Kären, S. 285',
    piece.type = 'song', piece.opus_number = 'S. 285',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9969 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 249 가곡 <La fede>

UPDATE pieces piece
SET piece.title = '가곡 <La fede>', piece.title_en = 'La fede, S. 249',
    piece.type = 'song', piece.opus_number = 'S. 249',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10862 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 74 Largo Risoluto No. 1

UPDATE pieces piece
SET piece.title = 'Largo Risoluto No. 1', piece.title_en = 'Largo Risoluto No. 1, S. 74',
    piece.type = 'song', piece.opus_number = 'S. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10932 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 75 Largo Risoluto No. 2

UPDATE pieces piece
SET piece.title = 'Largo Risoluto No. 2', piece.title_en = 'Largo Risoluto No. 2, S. 75',
    piece.type = 'song', piece.opus_number = 'S. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10113 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 73 Largo for Violin, Clarinet and Piano

UPDATE pieces piece
SET piece.title = 'Largo for Violin, Clarinet and Piano', piece.title_en = 'Largo for Violin, Clarinet and Piano, S. 73',
    piece.type = 'song', piece.opus_number = 'S. 73',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8153 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 184 가곡 <Lincoln, the Great Commoner>

UPDATE pieces piece
SET piece.title = '가곡 <Lincoln, the Great Commoner>', piece.title_en = 'Lincoln, the Great Commoner, S. 184',
    piece.type = 'song', piece.opus_number = 'S. 184',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10146 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 289 가곡 <Lincoln, the Great Commoner> S. 289

UPDATE pieces piece
SET piece.title = '가곡 <Lincoln, the Great Commoner> S. 289', piece.title_en = 'Lincoln, the Great Commoner, S. 289',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'S.', piece.catalogue_number = '289',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7791 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lord God, The Sea Is Mighty

UPDATE pieces piece
SET piece.title = 'Lord God, The Sea Is Mighty', piece.title_en = 'Lord God, The Sea Is Mighty',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9806 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 294 가곡 <Majority>

UPDATE pieces piece
SET piece.title = '가곡 <Majority>', piece.title_en = 'Majority, S. 294',
    piece.type = 'song', piece.opus_number = 'S. 294',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10843 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 295 가곡 <Maple Leaves>

UPDATE pieces piece
SET piece.title = '가곡 <Maple Leaves>', piece.title_en = 'Maple Leaves, S. 295',
    piece.type = 'song', piece.opus_number = 'S. 295',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8919 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 111 행진곡 3번 "Omega Lambda Chi"

UPDATE pieces piece
SET piece.title = '행진곡 3번 "Omega Lambda Chi"', piece.title_en = 'March No. 3 for Piano, with "Omega Lambda Chi", S. 111',
    piece.type = 'song', piece.opus_number = 'S. 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8458 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 112 행진곡 5번 "Annie Lisle"

UPDATE pieces piece
SET piece.title = '행진곡 5번 "Annie Lisle"', piece.title_en = 'March No. 5 for Piano, with "Annie Lisle", S. 112',
    piece.type = 'song', piece.opus_number = 'S. 112',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8204 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 113 행진곡 6번 "Here"

UPDATE pieces piece
SET piece.title = '행진곡 6번 "Here"', piece.title_en = 'March No. 6 for Piano, with "Here''s to Good Old Yale", S. 113',
    piece.type = 'song', piece.opus_number = 'S. 113',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9676 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 109 행진곡 1번 "Year of Jubilee"

UPDATE pieces piece
SET piece.title = '행진곡 1번 "Year of Jubilee"', piece.title_en = 'March no. 1 for Piano, with "Year of Jubilee", S. 109',
    piece.type = 'song', piece.opus_number = 'S. 109',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8664 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 110 행진곡 2번 "Son of a Gambolier"

UPDATE pieces piece
SET piece.title = '행진곡 2번 "Son of a Gambolier"', piece.title_en = 'March no. 2 for Piano, with "Son of a Gambolier", S. 110',
    piece.type = 'song', piece.opus_number = 'S. 110',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11160 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 31 행진곡 3번 "My Old Kentucky Home"

UPDATE pieces piece
SET piece.title = '행진곡 3번 "My Old Kentucky Home"', piece.title_en = 'March no. 3, with "My Old Kentucky Home", S. 31',
    piece.type = 'song', piece.opus_number = 'S. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10983 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 296 No. 1 가곡 <Marie>

UPDATE pieces piece
SET piece.title = '가곡 <Marie>', piece.title_en = 'Marie, S. 296 No. 1',
    piece.type = 'song', piece.opus_number = 'S. 296 No. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11123 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 297 가곡 <Memories>

UPDATE pieces piece
SET piece.title = '가곡 <Memories>', piece.title_en = 'Memories, S. 297',
    piece.type = 'song', piece.opus_number = 'S. 297',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7878 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 298 가곡 <Minnelied>

UPDATE pieces piece
SET piece.title = '가곡 <Minnelied>', piece.title_en = 'Minnelied, S. 298',
    piece.type = 'song', piece.opus_number = 'S. 298',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10812 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 4 Minuetto

UPDATE pieces piece
SET piece.title = 'Minuetto', piece.title_en = 'Minuetto, Op. 4, S. 119',
    piece.type = 'song', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8608 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 301 가곡 <Mists>

UPDATE pieces piece
SET piece.title = '가곡 <Mists>', piece.title_en = 'Mists, S. 301',
    piece.type = 'song', piece.opus_number = 'S. 301',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7972 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 302 가곡 <My Lou Jennine>

UPDATE pieces piece
SET piece.title = '가곡 <My Lou Jennine>', piece.title_en = 'My Lou Jennine, S. 302',
    piece.type = 'song', piece.opus_number = 'S. 302',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10043 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 304 가곡 <My Native Land [II]>

UPDATE pieces piece
SET piece.title = '가곡 <My Native Land [II]>', piece.title_en = 'My Native Land [II], S. 304',
    piece.type = 'song', piece.opus_number = 'S. 304',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10701 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 303 가곡 <My Native Land [I]>

UPDATE pieces piece
SET piece.title = '가곡 <My Native Land [I]>', piece.title_en = 'My Native Land [I], S. 303',
    piece.type = 'song', piece.opus_number = 'S. 303',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9211 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 306 가곡 <Nature's Way>

UPDATE pieces piece
SET piece.title = '가곡 <Nature''s Way>', piece.title_en = 'Nature''s Way, S. 306',
    piece.type = 'song', piece.opus_number = 'S. 306',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8646 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 312 가곡 <No More>

UPDATE pieces piece
SET piece.title = '가곡 <No More>', piece.title_en = 'No More, S. 312',
    piece.type = 'song', piece.opus_number = 'S. 312',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8691 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 315 가곡 <Old Home Day>

UPDATE pieces piece
SET piece.title = '가곡 <Old Home Day>', piece.title_en = 'Old Home Day, S. 315',
    piece.type = 'song', piece.opus_number = 'S. 315',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8183 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 317 가곡 <Omens and Oracles>

UPDATE pieces piece
SET piece.title = '가곡 <Omens and Oracles>', piece.title_en = 'Omens and Oracles, S. 317',
    piece.type = 'song', piece.opus_number = 'S. 317',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7994 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 318 가곡 <On Judges' Walk>

UPDATE pieces piece
SET piece.title = '가곡 <On Judges'' Walk>', piece.title_en = 'On Judges'' Walk, S. 318',
    piece.type = 'song', piece.opus_number = 'S. 318',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11229 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 319 가곡 <On the Antipodes>

UPDATE pieces piece
SET piece.title = '가곡 <On the Antipodes>', piece.title_en = 'On the Antipodes, S. 319',
    piece.type = 'song', piece.opus_number = 'S. 319',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10190 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 320 가곡 <On the Counter>

UPDATE pieces piece
SET piece.title = '가곡 <On the Counter>', piece.title_en = 'On the Counter, S. 320',
    piece.type = 'song', piece.opus_number = 'S. 320',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8113 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 9 Orchestral Set No. 3

UPDATE pieces piece
SET piece.title = 'Orchestral Set No. 3', piece.title_en = 'Orchestral Set No. 3, S. 9',
    piece.type = 'album', piece.opus_number = 'S. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10226 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '[Andante moderato]', part.name_en = 'Orchestral Set No. 3, S. 9: I. [Andante moderato]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10226 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:cfe4de78-d989-46f6-b55d-e70f34e59217' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfe4de78-d989-46f6-b55d-e70f34e59217', 1, 'I', '[Andante moderato]', 'Orchestral Set No. 3, S. 9: I. [Andante moderato]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10226 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfe4de78-d989-46f6-b55d-e70f34e59217'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'During Camp Meetin'' Week - One Secular Afternoon (In Bethel)', part.name_en = 'Orchestral Set No. 3, S. 9: II. During Camp Meetin'' Week - One Secular Afternoon (In Bethel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10226 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:3191611e-8339-4e04-88ac-7c4864202ea9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3191611e-8339-4e04-88ac-7c4864202ea9', 2, 'II', 'During Camp Meetin'' Week - One Secular Afternoon (In Bethel)', 'Orchestral Set No. 3, S. 9: II. During Camp Meetin'' Week - One Secular Afternoon (In Bethel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10226 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3191611e-8339-4e04-88ac-7c4864202ea9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '[Andante]', part.name_en = 'Orchestral Set No. 3, S. 9: III. [Andante]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10226 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:f4f49229-4038-44fd-86a2-25fc572dc455' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4f49229-4038-44fd-86a2-25fc572dc455', 3, 'III', '[Andante]', 'Orchestral Set No. 3, S. 9: III. [Andante]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10226 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4f49229-4038-44fd-86a2-25fc572dc455'
);


-- S. 8 Orchestral Set no. 2

UPDATE pieces piece
SET piece.title = 'Orchestral Set no. 2', piece.title_en = 'Orchestral Set no. 2, S. 8',
    piece.type = 'album', piece.opus_number = 'S. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8777 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'An Elegy to Our Forefathers. Very slowly', part.name_en = 'Orchestral Set no. 2, S. 8: I. An Elegy to Our Forefathers. Very slowly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8777 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:84f21d3a-53c3-40e7-90bc-abbb83768695' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84f21d3a-53c3-40e7-90bc-abbb83768695', 1, 'I', 'An Elegy to Our Forefathers. Very slowly', 'Orchestral Set no. 2, S. 8: I. An Elegy to Our Forefathers. Very slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8777 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84f21d3a-53c3-40e7-90bc-abbb83768695'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'The Rockstrewn Hills Join in the People''s Outdoor Meeting. Allegro', part.name_en = 'Orchestral Set no. 2, S. 8: II. The Rockstrewn Hills Join in the People''s Outdoor Meeting. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8777 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:074de794-7c8d-48b6-949d-53b1f20b33da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074de794-7c8d-48b6-949d-53b1f20b33da', 2, 'II', 'The Rockstrewn Hills Join in the People''s Outdoor Meeting. Allegro', 'Orchestral Set no. 2, S. 8: II. The Rockstrewn Hills Join in the People''s Outdoor Meeting. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8777 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074de794-7c8d-48b6-949d-53b1f20b33da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'From Hanover Square North, at the End of a Tragic Day, the Voice of the People Again Arose. Very slowly', part.name_en = 'Orchestral Set no. 2, S. 8: III. From Hanover Square North, at the End of a Tragic Day, the Voice of the People Again Arose. Very slowly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8777 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:2f5a7ea5-d6de-429e-a268-4e03bb10ca2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f5a7ea5-d6de-429e-a268-4e03bb10ca2d', 3, 'III', 'From Hanover Square North, at the End of a Tragic Day, the Voice of the People Again Arose. Very slowly', 'Orchestral Set no. 2, S. 8: III. From Hanover Square North, at the End of a Tragic Day, the Voice of the People Again Arose. Very slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8777 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f5a7ea5-d6de-429e-a268-4e03bb10ca2d'
);


-- S. 324 가곡 <Paracelsus>

UPDATE pieces piece
SET piece.title = '가곡 <Paracelsus>', piece.title_en = 'Paracelsus, S. 324',
    piece.type = 'song', piece.opus_number = 'S. 324',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7486 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 325 가곡 <Peaks>

UPDATE pieces piece
SET piece.title = '가곡 <Peaks>', piece.title_en = 'Peaks, S. 325',
    piece.type = 'song', piece.opus_number = 'S. 325',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10025 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 87 피아노 소나타 1번 S. 87

UPDATE pieces piece
SET piece.title = '피아노 소나타 1번 S. 87', piece.title_en = 'Piano Sonata no. 1, S. 87',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'S.', piece.catalogue_number = '87',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10572 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Adagio con moto - Andante con moto - Allegro risoluto - Adagio cantabile', part.name_en = 'Piano Sonata no. 1, S. 87: I. Adagio con moto - Andante con moto - Allegro risoluto - Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10572 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:9a991411-b5b8-4960-b471-085e474ebc22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a991411-b5b8-4960-b471-085e474ebc22', 1, NULL, 'Adagio con moto - Andante con moto - Allegro risoluto - Adagio cantabile', 'Piano Sonata no. 1, S. 87: I. Adagio con moto - Andante con moto - Allegro risoluto - Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10572 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a991411-b5b8-4960-b471-085e474ebc22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'IIa. Allegro moderato - Andante', part.name_en = 'Piano Sonata no. 1, S. 87: IIa. Allegro moderato - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10572 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:828715d0-24ff-45fe-bb74-1c9fe703497a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:828715d0-24ff-45fe-bb74-1c9fe703497a', 2, NULL, 'IIa. Allegro moderato - Andante', 'Piano Sonata no. 1, S. 87: IIa. Allegro moderato - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10572 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:828715d0-24ff-45fe-bb74-1c9fe703497a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'IIb. In the Inn. Allegro', part.name_en = 'Piano Sonata no. 1, S. 87: IIb. In the Inn. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10572 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:7c321dbf-7b61-4d96-ba15-df1732a20f31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c321dbf-7b61-4d96-ba15-df1732a20f31', 3, NULL, 'IIb. In the Inn. Allegro', 'Piano Sonata no. 1, S. 87: IIb. In the Inn. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10572 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c321dbf-7b61-4d96-ba15-df1732a20f31'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Largo - Allegro - Largo', part.name_en = 'Piano Sonata no. 1, S. 87: III. Largo - Allegro - Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10572 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:378970cc-5dd8-4d82-8660-5cabf22e72d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:378970cc-5dd8-4d82-8660-5cabf22e72d3', 4, NULL, 'Largo - Allegro - Largo', 'Piano Sonata no. 1, S. 87: III. Largo - Allegro - Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10572 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:378970cc-5dd8-4d82-8660-5cabf22e72d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'IVa. [no tempo heading]', part.name_en = 'Piano Sonata no. 1, S. 87: IVa. [no tempo heading]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10572 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:17b44c7d-c8ae-4002-8f20-8878849ed72e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17b44c7d-c8ae-4002-8f20-8878849ed72e', 5, NULL, 'IVa. [no tempo heading]', 'Piano Sonata no. 1, S. 87: IVa. [no tempo heading]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10572 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17b44c7d-c8ae-4002-8f20-8878849ed72e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'IVb. Allegro - Presto - Slow', part.name_en = 'Piano Sonata no. 1, S. 87: IVb. Allegro - Presto - Slow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10572 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:05e41bd1-d592-4e2c-9a38-ba4b5069bf82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05e41bd1-d592-4e2c-9a38-ba4b5069bf82', 6, NULL, 'IVb. Allegro - Presto - Slow', 'Piano Sonata no. 1, S. 87: IVb. Allegro - Presto - Slow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10572 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05e41bd1-d592-4e2c-9a38-ba4b5069bf82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Andante maestoso - Adagio cantabile - Allegro - Andante', part.name_en = 'Piano Sonata no. 1, S. 87: V. Andante maestoso - Adagio cantabile - Allegro - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10572 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:723f73cc-e6cd-43fe-b2a5-37ca32c0d0e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:723f73cc-e6cd-43fe-b2a5-37ca32c0d0e2', 7, NULL, 'Andante maestoso - Adagio cantabile - Allegro - Andante', 'Piano Sonata no. 1, S. 87: V. Andante maestoso - Adagio cantabile - Allegro - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10572 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:723f73cc-e6cd-43fe-b2a5-37ca32c0d0e2'
);


-- None 피아노 소나타 2번 "Concord, Mass., 1840–60"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Emerson. Slowly', part.name_en = 'Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”: I. Emerson. Slowly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 372 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:1b42305d-c9a0-3088-9493-0f4be3b7e601' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b42305d-c9a0-3088-9493-0f4be3b7e601', 1, 'I', 'Emerson. Slowly', 'Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”: I. Emerson. Slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 372 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b42305d-c9a0-3088-9493-0f4be3b7e601'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Hawthorne. Very fast', part.name_en = 'Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”: II. Hawthorne. Very fast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 372 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:54738f3f-a84c-3649-9113-ea8ff3159b0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54738f3f-a84c-3649-9113-ea8ff3159b0c', 2, 'II', 'Hawthorne. Very fast', 'Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”: II. Hawthorne. Very fast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 372 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54738f3f-a84c-3649-9113-ea8ff3159b0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Alcotts. Moderately', part.name_en = 'Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”: III. The Alcotts. Moderately',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 372 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:ece9633e-3f84-354b-a12a-4e80b9e9180c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ece9633e-3f84-354b-a12a-4e80b9e9180c', 3, 'III', 'The Alcotts. Moderately', 'Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”: III. The Alcotts. Moderately', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 372 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece9633e-3f84-354b-a12a-4e80b9e9180c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Thoreau. Starting slowly and quietly', part.name_en = 'Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”: IV. Thoreau. Starting slowly and quietly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 372 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:36b09a06-99c9-36e8-bc2a-819978565f1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36b09a06-99c9-36e8-bc2a-819978565f1f', 4, 'IV', 'Thoreau. Starting slowly and quietly', 'Piano Sonata no. 2, S. 88 “Concord, Mass., 1840–60”: IV. Thoreau. Starting slowly and quietly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 372 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36b09a06-99c9-36e8-bc2a-819978565f1f'
);


-- S. 327 가곡 <Pictures>

UPDATE pieces piece
SET piece.title = '가곡 <Pictures>', piece.title_en = 'Pictures, S. 327',
    piece.type = 'song', piece.opus_number = 'S. 327',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10726 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 41 Postlude in F

UPDATE pieces piece
SET piece.title = 'Postlude in F', piece.title_en = 'Postlude in F, S. 41',
    piece.type = 'song', piece.opus_number = 'S. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8158 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 328 가곡 <Premonitions>

UPDATE pieces piece
SET piece.title = '가곡 <Premonitions>', piece.title_en = 'Premonitions, S. 328',
    piece.type = 'song', piece.opus_number = 'S. 328',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9346 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 176 Processional "Let There Be Light"

UPDATE pieces piece
SET piece.title = 'Processional "Let There Be Light"', piece.title_en = 'Processional "Let There Be Light", S. 176',
    piece.type = 'song', piece.opus_number = 'S. 176',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8740 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 153 Psalm 100

UPDATE pieces piece
SET piece.title = 'Psalm 100', piece.title_en = 'Psalm 100, S. 153',
    piece.type = 'song', piece.opus_number = 'S. 153',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10819 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 154 Psalm 135

UPDATE pieces piece
SET piece.title = 'Psalm 135', piece.title_en = 'Psalm 135, S. 154',
    piece.type = 'song', piece.opus_number = 'S. 154',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8016 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 146 Psalm 14

UPDATE pieces piece
SET piece.title = 'Psalm 14', piece.title_en = 'Psalm 14, S. 146',
    piece.type = 'song', piece.opus_number = 'S. 146',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9988 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 155 Psalm 150

UPDATE pieces piece
SET piece.title = 'Psalm 150', piece.title_en = 'Psalm 150, S. 155',
    piece.type = 'song', piece.opus_number = 'S. 155',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8387 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 147 Psalm 24

UPDATE pieces piece
SET piece.title = 'Psalm 24', piece.title_en = 'Psalm 24, S. 147',
    piece.type = 'song', piece.opus_number = 'S. 147',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10467 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 148 Psalm 25

UPDATE pieces piece
SET piece.title = 'Psalm 25', piece.title_en = 'Psalm 25, S. 148',
    piece.type = 'song', piece.opus_number = 'S. 148',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11247 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 149 Psalm 42

UPDATE pieces piece
SET piece.title = 'Psalm 42', piece.title_en = 'Psalm 42, S. 149',
    piece.type = 'song', piece.opus_number = 'S. 149',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8013 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 150 Psalm 54

UPDATE pieces piece
SET piece.title = 'Psalm 54', piece.title_en = 'Psalm 54, S. 150',
    piece.type = 'song', piece.opus_number = 'S. 150',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8625 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Psalm 67, S. 151 “God be merciful unto us”

UPDATE pieces piece
SET piece.title = 'Psalm 67, S. 151 “God be merciful unto us”', piece.title_en = 'Psalm 67, S. 151 “God be merciful unto us”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11242 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Psalm 90, S. 152 “Lord, thou hast been”

UPDATE pieces piece
SET piece.title = 'Psalm 90, S. 152 “Lord, thou hast been”', piece.title_en = 'Psalm 90, S. 152 “Lord, thou hast been”',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9199 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 329 가곡 <Qu'il m'irait bien>

UPDATE pieces piece
SET piece.title = '가곡 <Qu''il m''irait bien>', piece.title_en = 'Qu''il m''irait bien, S. 329',
    piece.type = 'song', piece.opus_number = 'S. 329',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8741 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 331 가곡 <Religion>

UPDATE pieces piece
SET piece.title = '가곡 <Religion>', piece.title_en = 'Religion, S. 331',
    piece.type = 'song', piece.opus_number = 'S. 331',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9782 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 333 레퀴엠

UPDATE pieces piece
SET piece.title = '레퀴엠', piece.title_en = 'Requiem, S. 333',
    piece.type = 'song', piece.opus_number = 'S. 333',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8058 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 334 가곡 <Resolution>

UPDATE pieces piece
SET piece.title = '가곡 <Resolution>', piece.title_en = 'Resolution, S. 334',
    piece.type = 'song', piece.opus_number = 'S. 334',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7737 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 27 Robert Browning Overture

UPDATE pieces piece
SET piece.title = 'Robert Browning Overture', piece.title_en = 'Robert Browning Overture, S. 27',
    piece.type = 'song', piece.opus_number = 'S. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9653 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 335 가곡 <Rock of Ages>

UPDATE pieces piece
SET piece.title = '가곡 <Rock of Ages>', piece.title_en = 'Rock of Ages, S. 335',
    piece.type = 'song', piece.opus_number = 'S. 335',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8138 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 336 가곡 <Romanzo (di Central Park)>

UPDATE pieces piece
SET piece.title = '가곡 <Romanzo (di Central Park)>', piece.title_en = 'Romanzo (di Central Park), S. 336',
    piece.type = 'song', piece.opus_number = 'S. 336',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9693 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 337 가곡 <Rosamunde>

UPDATE pieces piece
SET piece.title = '가곡 <Rosamunde>', piece.title_en = 'Rosamunde, S. 337',
    piece.type = 'song', piece.opus_number = 'S. 337',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9196 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 339 가곡 <Rough Wind>

UPDATE pieces piece
SET piece.title = '가곡 <Rough Wind>', piece.title_en = 'Rough Wind, S. 339',
    piece.type = 'song', piece.opus_number = 'S. 339',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8949 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 55 Runaway Horse on Main Street

UPDATE pieces piece
SET piece.title = 'Runaway Horse on Main Street', piece.title_en = 'Runaway Horse on Main Street, S. 55',
    piece.type = 'song', piece.opus_number = 'S. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9567 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 83 Scherzo for String Quartet

UPDATE pieces piece
SET piece.title = 'Scherzo for String Quartet', piece.title_en = 'Scherzo for String Quartet, S. 83',
    piece.type = 'song', piece.opus_number = 'S. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11117 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 346 가곡 <September>

UPDATE pieces piece
SET piece.title = '가곡 <September>', piece.title_en = 'September, S. 346',
    piece.type = 'song', piece.opus_number = 'S. 346',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9500 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 347 가곡 <Serenity>

UPDATE pieces piece
SET piece.title = '가곡 <Serenity>', piece.title_en = 'Serenity, S. 347',
    piece.type = 'song', piece.opus_number = 'S. 347',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8475 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 10 Set No. 1

UPDATE pieces piece
SET piece.title = 'Set No. 1', piece.title_en = 'Set No. 1, S. 10',
    piece.type = 'album', piece.opus_number = 'S. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11276 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The See''r', part.name_en = 'Set No. 1, S. 10: I. The See''r',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11276 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:1036a5fe-0751-4690-a8bb-914cc079dd61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1036a5fe-0751-4690-a8bb-914cc079dd61', 1, 'I', 'The See''r', 'Set No. 1, S. 10: I. The See''r', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11276 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1036a5fe-0751-4690-a8bb-914cc079dd61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'A Lecture', part.name_en = 'Set No. 1, S. 10: II. A Lecture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11276 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:c744ad8d-1263-44d6-8cd7-52be7ab7dbf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c744ad8d-1263-44d6-8cd7-52be7ab7dbf8', 2, 'II', 'A Lecture', 'Set No. 1, S. 10: II. A Lecture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11276 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c744ad8d-1263-44d6-8cd7-52be7ab7dbf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Ruined River', part.name_en = 'Set No. 1, S. 10: III. The Ruined River',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11276 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:fcda423b-ee9d-4fcd-8d9f-9ecc5fd59a3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcda423b-ee9d-4fcd-8d9f-9ecc5fd59a3a', 3, 'III', 'The Ruined River', 'Set No. 1, S. 10: III. The Ruined River', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11276 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcda423b-ee9d-4fcd-8d9f-9ecc5fd59a3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Like a Sick Eagle', part.name_en = 'Set No. 1, S. 10: IV. Like a Sick Eagle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11276 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:51aa75fb-b526-47dd-86c8-d545b77ac235' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51aa75fb-b526-47dd-86c8-d545b77ac235', 4, 'IV', 'Like a Sick Eagle', 'Set No. 1, S. 10: IV. Like a Sick Eagle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11276 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51aa75fb-b526-47dd-86c8-d545b77ac235'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Calcium Light Night', part.name_en = 'Set No. 1, S. 10: V. Calcium Light Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11276 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:153f961c-c861-48a3-ad8c-64841fd32a29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:153f961c-c861-48a3-ad8c-64841fd32a29', 5, 'V', 'Calcium Light Night', 'Set No. 1, S. 10: V. Calcium Light Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11276 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:153f961c-c861-48a3-ad8c-64841fd32a29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegretto sombreoso', part.name_en = 'Set No. 1, S. 10: VI. Allegretto sombreoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11276 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:38a07d1a-1059-470f-b4f5-5e2171dff391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38a07d1a-1059-470f-b4f5-5e2171dff391', 6, 'VI', 'Allegretto sombreoso', 'Set No. 1, S. 10: VI. Allegretto sombreoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11276 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38a07d1a-1059-470f-b4f5-5e2171dff391'
);


-- S. 11 Set No. 2

UPDATE pieces piece
SET piece.title = 'Set No. 2', piece.title_en = 'Set No. 2, S. 11',
    piece.type = 'album', piece.opus_number = 'S. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7759 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Indians', part.name_en = 'Set No. 2, S. 11: I. The Indians',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7759 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:fa9a4451-fdf5-396d-a400-42ef33557509' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa9a4451-fdf5-396d-a400-42ef33557509', 1, 'I', 'The Indians', 'Set No. 2, S. 11: I. The Indians', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7759 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa9a4451-fdf5-396d-a400-42ef33557509'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Gyp the Blood" or Hearst!? Which is Worst?!', part.name_en = 'Set No. 2, S. 11: II. "Gyp the Blood" or Hearst!? Which is Worst?!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7759 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:c423cfde-9612-460f-8235-9c86b626cbb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c423cfde-9612-460f-8235-9c86b626cbb4', 2, 'II', '"Gyp the Blood" or Hearst!? Which is Worst?!', 'Set No. 2, S. 11: II. "Gyp the Blood" or Hearst!? Which is Worst?!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7759 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c423cfde-9612-460f-8235-9c86b626cbb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Last Reader', part.name_en = 'Set No. 2, S. 11: III. The Last Reader',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7759 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:4adc13dc-93e7-4ca8-98af-8ca050d0d5c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4adc13dc-93e7-4ca8-98af-8ca050d0d5c6', 3, 'III', 'The Last Reader', 'Set No. 2, S. 11: III. The Last Reader', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7759 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4adc13dc-93e7-4ca8-98af-8ca050d0d5c6'
);


-- S. 12 Set No. 3

UPDATE pieces piece
SET piece.title = 'Set No. 3', piece.title_en = 'Set No. 3, S. 12',
    piece.type = 'album', piece.opus_number = 'S. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11135 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio sostenuto "At Sea"', part.name_en = 'Set No. 3, S. 12: I. Adagio sostenuto "At Sea"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11135 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:810affaf-b324-4914-b83c-5fe732d84e85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:810affaf-b324-4914-b83c-5fe732d84e85', 1, 'I', 'Adagio sostenuto "At Sea"', 'Set No. 3, S. 12: I. Adagio sostenuto "At Sea"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11135 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:810affaf-b324-4914-b83c-5fe732d84e85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Luck and Work', part.name_en = 'Set No. 3, S. 12: II. Luck and Work',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11135 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:d8bd3732-9076-43fa-bd4a-5565fc1ccc5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8bd3732-9076-43fa-bd4a-5565fc1ccc5e', 2, 'II', 'Luck and Work', 'Set No. 3, S. 12: II. Luck and Work', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11135 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8bd3732-9076-43fa-bd4a-5565fc1ccc5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Premonitions', part.name_en = 'Set No. 3, S. 12: III. Premonitions',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11135 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:1718f5bf-5f7c-4e50-a18d-0d8f87b2628c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1718f5bf-5f7c-4e50-a18d-0d8f87b2628c', 3, 'III', 'Premonitions', 'Set No. 3, S. 12: III. Premonitions', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11135 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1718f5bf-5f7c-4e50-a18d-0d8f87b2628c'
);


-- S. 20 Set for Theatre Orchestra

UPDATE pieces piece
SET piece.title = 'Set for Theatre Orchestra', piece.title_en = 'Set for Theatre Orchestra, S. 20',
    piece.type = 'album', piece.opus_number = 'S. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7971 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'In the Cage', part.name_en = 'Set for Theatre Orchestra, S. 20: I. In the Cage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7971 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:b8c3d6bd-e05d-4cbd-abad-9c5d9ad9c6b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8c3d6bd-e05d-4cbd-abad-9c5d9ad9c6b9', 1, 'I', 'In the Cage', 'Set for Theatre Orchestra, S. 20: I. In the Cage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7971 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8c3d6bd-e05d-4cbd-abad-9c5d9ad9c6b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'In the Inn (Potpourri)', part.name_en = 'Set for Theatre Orchestra, S. 20: II. In the Inn (Potpourri)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7971 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:9ba35f88-219d-4854-8384-98b30fd8ec67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ba35f88-219d-4854-8384-98b30fd8ec67', 2, 'II', 'In the Inn (Potpourri)', 'Set for Theatre Orchestra, S. 20: II. In the Inn (Potpourri)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7971 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ba35f88-219d-4854-8384-98b30fd8ec67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'In the Night', part.name_en = 'Set for Theatre Orchestra, S. 20: III. In the Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7971 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:c2235f1c-a933-4b51-becc-b37849d60e72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2235f1c-a933-4b51-becc-b37849d60e72', 3, 'III', 'In the Night', 'Set for Theatre Orchestra, S. 20: III. In the Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7971 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2235f1c-a933-4b51-becc-b37849d60e72'
);


-- None Set no. 5, S. 14 "The Other Side of Pioneering, or Side Lights on American Enterprise"

UPDATE pieces piece
SET piece.title = 'Set no. 5, S. 14 "The Other Side of Pioneering, or Side Lights on American Enterprise"', piece.title_en = 'Set no. 5, S. 14 "The Other Side of Pioneering, or Side Lights on American Enterprise"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8169 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ann Street, S. 14/iv', part.name_en = 'Ann Street, S. 14/iv',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8169 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:fd6a5bcb-36a0-4b1b-8a04-cfbb5a2cb19c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd6a5bcb-36a0-4b1b-8a04-cfbb5a2cb19c', 1, NULL, 'Ann Street, S. 14/iv', 'Ann Street, S. 14/iv', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8169 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd6a5bcb-36a0-4b1b-8a04-cfbb5a2cb19c'
);


-- None Set no. 6, S. 15 "From the Side Hill"

UPDATE pieces piece
SET piece.title = 'Set no. 6, S. 15 "From the Side Hill"', piece.title_en = 'Set no. 6, S. 15 "From the Side Hill"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8248 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 16 Set no. 7

UPDATE pieces piece
SET piece.title = 'Set no. 7', piece.title_en = 'Set no. 7, S. 16',
    piece.type = 'song', piece.opus_number = 'S. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9126 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 122 Set of Five Take-Offs

UPDATE pieces piece
SET piece.title = 'Set of Five Take-Offs', piece.title_en = 'Set of Five Take-Offs, S. 122',
    piece.type = 'album', piece.opus_number = 'S. 122',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10968 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'The Seen and Unseen?', part.name_en = 'Set of Five Take-Offs, S. 122: I. The Seen and Unseen?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10968 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:f45988cc-1105-4ac8-86ea-da9056342afe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f45988cc-1105-4ac8-86ea-da9056342afe', 1, 'I', 'The Seen and Unseen?', 'Set of Five Take-Offs, S. 122: I. The Seen and Unseen?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10968 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f45988cc-1105-4ac8-86ea-da9056342afe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Rough and Ready et al', part.name_en = 'Set of Five Take-Offs, S. 122: II. Rough and Ready et al.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10968 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:cea92504-090d-4693-a923-57f7b291f1f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea92504-090d-4693-a923-57f7b291f1f4', 2, 'II', 'Rough and Ready et al', 'Set of Five Take-Offs, S. 122: II. Rough and Ready et al.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10968 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea92504-090d-4693-a923-57f7b291f1f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Song without (good) Words or The Good & the Bad (new & old)', part.name_en = 'Set of Five Take-Offs, S. 122: III. Song without (good) Words or The Good & the Bad (new & old)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10968 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:0a000593-60b7-4f47-8f36-e563494e8913' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a000593-60b7-4f47-8f36-e563494e8913', 3, 'III', 'Song without (good) Words or The Good & the Bad (new & old)', 'Set of Five Take-Offs, S. 122: III. Song without (good) Words or The Good & the Bad (new & old)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10968 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a000593-60b7-4f47-8f36-e563494e8913'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Scene Episode', part.name_en = 'Set of Five Take-Offs, S. 122: IV. Scene Episode',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10968 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:09857364-3da0-4229-b9ee-1acdb76d3f7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09857364-3da0-4229-b9ee-1acdb76d3f7d', 4, 'IV', 'Scene Episode', 'Set of Five Take-Offs, S. 122: IV. Scene Episode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10968 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09857364-3da0-4229-b9ee-1acdb76d3f7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Bad Resolutions [and] Good WAN! (Jan 1, 190[7])', part.name_en = 'Set of Five Take-Offs, S. 122: V. Bad Resolutions [and] Good WAN! (Jan 1, 190[7])',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10968 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:bba3b33b-c3fd-4f8a-8ba5-373f2eed6851' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba3b33b-c3fd-4f8a-8ba5-373f2eed6851', 5, 'V', 'Bad Resolutions [and] Good WAN! (Jan 1, 190[7])', 'Set of Five Take-Offs, S. 122: V. Bad Resolutions [and] Good WAN! (Jan 1, 190[7])', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10968 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba3b33b-c3fd-4f8a-8ba5-373f2eed6851'
);


-- S. 349 가곡 <Slow March>

UPDATE pieces piece
SET piece.title = '가곡 <Slow March>', piece.title_en = 'Slow March, S. 349',
    piece.type = 'song', piece.opus_number = 'S. 349',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9079 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 352 가곡 <Soliloquy>

UPDATE pieces piece
SET piece.title = '가곡 <Soliloquy>', piece.title_en = 'Soliloquy, S. 352',
    piece.type = 'song', piece.opus_number = 'S. 352',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10978 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 353 가곡 <Son of a Gambolier>

UPDATE pieces piece
SET piece.title = '가곡 <Son of a Gambolier>', piece.title_en = 'Son of a Gambolier, S. 353',
    piece.type = 'song', piece.opus_number = 'S. 353',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8377 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 60 바이올린과 피아노를 위한 소나타 1번

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타 1번', piece.title_en = 'Sonata for Violin and Piano no. 1, S. 60',
    piece.type = 'album', piece.opus_number = 'S. 60',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11190 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante - Allegro vivace', part.name_en = 'Sonata for Violin and Piano no. 1, S. 60: I. Andante - Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11190 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:76341479-590d-49d3-9dd0-15899fd4ff18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76341479-590d-49d3-9dd0-15899fd4ff18', 1, 'I', 'Andante - Allegro vivace', 'Sonata for Violin and Piano no. 1, S. 60: I. Andante - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11190 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76341479-590d-49d3-9dd0-15899fd4ff18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo cantabile', part.name_en = 'Sonata for Violin and Piano no. 1, S. 60: II. Largo cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11190 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:e66f329c-8420-400f-9f57-2afb145a4482' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e66f329c-8420-400f-9f57-2afb145a4482', 2, 'II', 'Largo cantabile', 'Sonata for Violin and Piano no. 1, S. 60: II. Largo cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11190 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e66f329c-8420-400f-9f57-2afb145a4482'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Sonata for Violin and Piano no. 1, S. 60: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11190 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:4199c625-c111-4d69-be94-8db1f2736e94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4199c625-c111-4d69-be94-8db1f2736e94', 3, 'III', 'Allegro', 'Sonata for Violin and Piano no. 1, S. 60: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11190 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4199c625-c111-4d69-be94-8db1f2736e94'
);


-- S. 61 바이올린과 피아노를 위한 소나타 2번

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타 2번', piece.title_en = 'Sonata for Violin and Piano no. 2, S. 61',
    piece.type = 'album', piece.opus_number = 'S. 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7811 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Autumn (Adagio maestoso - Allegro moderato)', part.name_en = 'Sonata for Violin and Piano no. 2, S. 61: I. Autumn (Adagio maestoso - Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7811 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:c9d891fd-ac77-4c33-ae0c-6c5883afe2d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9d891fd-ac77-4c33-ae0c-6c5883afe2d7', 1, 'I', 'Autumn (Adagio maestoso - Allegro moderato)', 'Sonata for Violin and Piano no. 2, S. 61: I. Autumn (Adagio maestoso - Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7811 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9d891fd-ac77-4c33-ae0c-6c5883afe2d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'In the Barn (Presto - Allegro moderato)', part.name_en = 'Sonata for Violin and Piano no. 2, S. 61: II. In the Barn (Presto - Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7811 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:53e16b1e-f8ea-4b24-afa5-d765df0ef26a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53e16b1e-f8ea-4b24-afa5-d765df0ef26a', 2, 'II', 'In the Barn (Presto - Allegro moderato)', 'Sonata for Violin and Piano no. 2, S. 61: II. In the Barn (Presto - Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7811 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53e16b1e-f8ea-4b24-afa5-d765df0ef26a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Revival (Largo - Allegretto)', part.name_en = 'Sonata for Violin and Piano no. 2, S. 61: III. The Revival (Largo - Allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7811 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:75f9559d-5acd-484c-a7ad-833377e77b69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75f9559d-5acd-484c-a7ad-833377e77b69', 3, 'III', 'The Revival (Largo - Allegretto)', 'Sonata for Violin and Piano no. 2, S. 61: III. The Revival (Largo - Allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7811 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75f9559d-5acd-484c-a7ad-833377e77b69'
);


-- S. 62 바이올린과 피아노를 위한 소나타 3번

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타 3번', piece.title_en = 'Sonata for Violin and Piano no. 3, S. 62',
    piece.type = 'album', piece.opus_number = 'S. 62',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8452 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonata for Violin and Piano no. 3, S. 62: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8452 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:3af5a1a4-cc9e-44e5-a085-0405779b715b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3af5a1a4-cc9e-44e5-a085-0405779b715b', 1, 'I', 'Adagio', 'Sonata for Violin and Piano no. 3, S. 62: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8452 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af5a1a4-cc9e-44e5-a085-0405779b715b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Sonata for Violin and Piano no. 3, S. 62: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8452 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:66aa5ef1-caf9-4546-88f4-051c6d2d2fb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66aa5ef1-caf9-4546-88f4-051c6d2d2fb8', 2, 'II', 'Allegro', 'Sonata for Violin and Piano no. 3, S. 62: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8452 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66aa5ef1-caf9-4546-88f4-051c6d2d2fb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio cantabile', part.name_en = 'Sonata for Violin and Piano no. 3, S. 62: III. Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8452 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:ecac4c70-2c0d-4ca8-a169-d19947869565' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecac4c70-2c0d-4ca8-a169-d19947869565', 3, 'III', 'Adagio cantabile', 'Sonata for Violin and Piano no. 3, S. 62: III. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8452 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecac4c70-2c0d-4ca8-a169-d19947869565'
);


-- S. 63 바이올린과 피아노를 위한 소나타 4번 "Children"

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 소나타 4번 "Children"', piece.title_en = 'Sonata for Violin and Piano no. 4 "Children''s Day at the Camp Meeting", S. 63',
    piece.type = 'album', piece.opus_number = 'S. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9745 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonata for Violin and Piano no. 4 "Children''s Day at the Camp Meeting", S. 63: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9745 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:0688065b-92de-43c3-8d48-2ca030af9f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0688065b-92de-43c3-8d48-2ca030af9f19', 1, 'I', 'Allegro', 'Sonata for Violin and Piano no. 4 "Children''s Day at the Camp Meeting", S. 63: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9745 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0688065b-92de-43c3-8d48-2ca030af9f19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'Sonata for Violin and Piano no. 4 "Children''s Day at the Camp Meeting", S. 63: II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9745 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:4a6b5a17-b3cc-4c8b-84cd-7897e4595adc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a6b5a17-b3cc-4c8b-84cd-7897e4595adc', 2, 'II', 'Largo', 'Sonata for Violin and Piano no. 4 "Children''s Day at the Camp Meeting", S. 63: II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9745 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a6b5a17-b3cc-4c8b-84cd-7897e4595adc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Sonata for Violin and Piano no. 4 "Children''s Day at the Camp Meeting", S. 63: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9745 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:64ad105c-7f1d-4eb6-95b8-1fc2280a8151' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64ad105c-7f1d-4eb6-95b8-1fc2280a8151', 3, 'III', 'Allegro', 'Sonata for Violin and Piano no. 4 "Children''s Day at the Camp Meeting", S. 63: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9745 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64ad105c-7f1d-4eb6-95b8-1fc2280a8151'
);


-- S. 357 가곡 <Song of the Dead>

UPDATE pieces piece
SET piece.title = '가곡 <Song of the Dead>', piece.title_en = 'Song of the Dead, S. 357',
    piece.type = 'song', piece.opus_number = 'S. 357',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10208 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 "She Is Not Fair"

UPDATE pieces piece
SET piece.title = '가곡 "She Is Not Fair"', piece.title_en = 'Song, S. 354 "She Is Not Fair"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8697 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 361 가곡 <Songs My Mother Taught Me>

UPDATE pieces piece
SET piece.title = '가곡 <Songs My Mother Taught Me>', piece.title_en = 'Songs My Mother Taught Me, S. 361',
    piece.type = 'song', piece.opus_number = 'S. 361',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10238 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 362 가곡 <South Wind>

UPDATE pieces piece
SET piece.title = '가곡 <South Wind>', piece.title_en = 'South Wind, S. 362',
    piece.type = 'song', piece.opus_number = 'S. 362',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10468 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 363 가곡 <Spring Song>

UPDATE pieces piece
SET piece.title = '가곡 <Spring Song>', piece.title_en = 'Spring Song, S. 363',
    piece.type = 'song', piece.opus_number = 'S. 363',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10492 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 1번 "From the Salvation Army"

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 "From the Salvation Army"', piece.title_en = 'String Quartet no. 1, S. 57 "From the Salvation Army"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10083 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Chorale. Andante con moto', part.name_en = 'String Quartet no. 1, S. 57 "From the Salvation Army": I. Chorale. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10083 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:262336a6-713b-4c1c-ac62-2f55798ce567' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:262336a6-713b-4c1c-ac62-2f55798ce567', 1, 'I', 'Chorale. Andante con moto', 'String Quartet no. 1, S. 57 "From the Salvation Army": I. Chorale. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10083 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:262336a6-713b-4c1c-ac62-2f55798ce567'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Prelude. Allegro', part.name_en = 'String Quartet no. 1, S. 57 "From the Salvation Army": II. Prelude. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10083 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:6f8bb907-ee18-409b-8bfb-e6b89107a8c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f8bb907-ee18-409b-8bfb-e6b89107a8c3', 2, 'II', 'Prelude. Allegro', 'String Quartet no. 1, S. 57 "From the Salvation Army": II. Prelude. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10083 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f8bb907-ee18-409b-8bfb-e6b89107a8c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Offertory. Adagio cantabile', part.name_en = 'String Quartet no. 1, S. 57 "From the Salvation Army": III. Offertory. Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10083 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:4185c89c-eea0-4ef1-aea6-0f2f2f2f84fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4185c89c-eea0-4ef1-aea6-0f2f2f2f84fe', 3, 'III', 'Offertory. Adagio cantabile', 'String Quartet no. 1, S. 57 "From the Salvation Army": III. Offertory. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10083 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4185c89c-eea0-4ef1-aea6-0f2f2f2f84fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Postlude. Adagio marziale', part.name_en = 'String Quartet no. 1, S. 57 "From the Salvation Army": IV. Postlude. Adagio marziale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10083 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:5287d981-ca06-4310-a0e6-2487774d5120' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5287d981-ca06-4310-a0e6-2487774d5120', 4, 'IV', 'Postlude. Adagio marziale', 'String Quartet no. 1, S. 57 "From the Salvation Army": IV. Postlude. Adagio marziale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10083 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5287d981-ca06-4310-a0e6-2487774d5120'
);


-- S. 58 현악 4중주 2번

UPDATE pieces piece
SET piece.title = '현악 4중주 2번', piece.title_en = 'String Quartet no. 2, S. 58',
    piece.type = 'album', piece.opus_number = 'S. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8630 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Discussions. Andante moderato - Andante con spirito - Adagio molto', part.name_en = 'String Quartet no. 2, S. 58: I. Discussions. Andante moderato - Andante con spirito - Adagio molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8630 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:1aba2355-336c-43b0-ae18-64048ff8d8d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aba2355-336c-43b0-ae18-64048ff8d8d3', 1, 'I', 'Discussions. Andante moderato - Andante con spirito - Adagio molto', 'String Quartet no. 2, S. 58: I. Discussions. Andante moderato - Andante con spirito - Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8630 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aba2355-336c-43b0-ae18-64048ff8d8d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Arguments. Allegro con spirito', part.name_en = 'String Quartet no. 2, S. 58: II. Arguments. Allegro con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8630 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:610334d6-e1d2-4c6f-bdfa-c3882a7254bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:610334d6-e1d2-4c6f-bdfa-c3882a7254bd', 2, 'II', 'Arguments. Allegro con spirito', 'String Quartet no. 2, S. 58: II. Arguments. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8630 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:610334d6-e1d2-4c6f-bdfa-c3882a7254bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'The Call of the Mountains. Adagio - Andante - Adagio', part.name_en = 'String Quartet no. 2, S. 58: III. The Call of the Mountains. Adagio - Andante - Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8630 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:a3246925-66f1-44bc-83ca-52aa275a3939' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3246925-66f1-44bc-83ca-52aa275a3939', 3, 'III', 'The Call of the Mountains. Adagio - Andante - Adagio', 'String Quartet no. 2, S. 58: III. The Call of the Mountains. Adagio - Andante - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8630 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3246925-66f1-44bc-83ca-52aa275a3939'
);


-- S. 365 가곡 <Sunrise>

UPDATE pieces piece
SET piece.title = '가곡 <Sunrise>', piece.title_en = 'Sunrise, S. 365',
    piece.type = 'song', piece.opus_number = 'S. 365',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8334 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 366 가곡 <Swimmers>

UPDATE pieces piece
SET piece.title = '가곡 <Swimmers>', piece.title_en = 'Swimmers, S. 366',
    piece.type = 'song', piece.opus_number = 'S. 366',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9430 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 1 교향곡 1번

UPDATE pieces piece
SET piece.title = '교향곡 1번', piece.title_en = 'Symphony no. 1, S. 1',
    piece.type = 'album', piece.opus_number = 'S. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7944 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 1, S. 1: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7944 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:b51b3af1-1338-4c2b-b8d2-3614c91c6160' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b51b3af1-1338-4c2b-b8d2-3614c91c6160', 1, 'I', 'Allegro', 'Symphony no. 1, S. 1: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7944 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b51b3af1-1338-4c2b-b8d2-3614c91c6160'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio molto (sostenuto)', part.name_en = 'Symphony no. 1, S. 1: II. Adagio molto (sostenuto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7944 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:14d0dc0e-8301-400a-9387-0097727796d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14d0dc0e-8301-400a-9387-0097727796d0', 2, 'II', 'Adagio molto (sostenuto)', 'Symphony no. 1, S. 1: II. Adagio molto (sostenuto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7944 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14d0dc0e-8301-400a-9387-0097727796d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzo. Vivace', part.name_en = 'Symphony no. 1, S. 1: III. Scherzo. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7944 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:4348d11c-1630-4dc2-a33a-a9c9ba5482a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4348d11c-1630-4dc2-a33a-a9c9ba5482a5', 3, 'III', 'Scherzo. Vivace', 'Symphony no. 1, S. 1: III. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7944 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4348d11c-1630-4dc2-a33a-a9c9ba5482a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto', part.name_en = 'Symphony no. 1, S. 1: IV. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7944 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:46b2629a-c9fe-4577-93b6-9fc240c00bef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46b2629a-c9fe-4577-93b6-9fc240c00bef', 4, 'IV', 'Allegro molto', 'Symphony no. 1, S. 1: IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7944 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b2629a-c9fe-4577-93b6-9fc240c00bef'
);


-- S. 2 교향곡 2번

UPDATE pieces piece
SET piece.title = '교향곡 2번', piece.title_en = 'Symphony no. 2, S. 2',
    piece.type = 'album', piece.opus_number = 'S. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10256 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante moderato', part.name_en = 'Symphony no. 2, S. 2: I. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10256 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:f89f73fc-0482-43c3-ab7b-2fb209c01a69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f89f73fc-0482-43c3-ab7b-2fb209c01a69', 1, 'I', 'Andante moderato', 'Symphony no. 2, S. 2: I. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10256 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f89f73fc-0482-43c3-ab7b-2fb209c01a69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Symphony no. 2, S. 2: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10256 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:b2cc19bf-3419-4cbd-ae4f-d873f43deddc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2cc19bf-3419-4cbd-ae4f-d873f43deddc', 2, 'II', 'Allegro', 'Symphony no. 2, S. 2: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10256 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2cc19bf-3419-4cbd-ae4f-d873f43deddc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio cantabile', part.name_en = 'Symphony no. 2, S. 2: III. Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10256 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:8bcb7bf8-3927-463c-9ae0-0f53ae6e935c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bcb7bf8-3927-463c-9ae0-0f53ae6e935c', 3, 'III', 'Adagio cantabile', 'Symphony no. 2, S. 2: III. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10256 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bcb7bf8-3927-463c-9ae0-0f53ae6e935c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento maestoso', part.name_en = 'Symphony no. 2, S. 2: IV. Lento maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10256 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:fb5d27d2-17b2-46a2-a046-6883f436a483' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb5d27d2-17b2-46a2-a046-6883f436a483', 4, 'IV', 'Lento maestoso', 'Symphony no. 2, S. 2: IV. Lento maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10256 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb5d27d2-17b2-46a2-a046-6883f436a483'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro molto vivace', part.name_en = 'Symphony no. 2, S. 2: V. Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10256 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:d70797f0-32a4-4122-aa55-931925e384a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d70797f0-32a4-4122-aa55-931925e384a0', 5, 'V', 'Allegro molto vivace', 'Symphony no. 2, S. 2: V. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10256 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d70797f0-32a4-4122-aa55-931925e384a0'
);


-- None 교향곡 3번 "The Camp Meeting"

UPDATE pieces piece
SET piece.title = '교향곡 3번 "The Camp Meeting"', piece.title_en = 'Symphony no. 3, S. 3 "The Camp Meeting"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10619 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Old Folks Gatherin''. Andante maestoso', part.name_en = 'Symphony no. 3, S. 3 "The Camp Meeting": I. Old Folks Gatherin''. Andante maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10619 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:997124f2-5ed4-3db1-a9e4-11e50058aadf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:997124f2-5ed4-3db1-a9e4-11e50058aadf', 1, 'I', 'Old Folks Gatherin''. Andante maestoso', 'Symphony no. 3, S. 3 "The Camp Meeting": I. Old Folks Gatherin''. Andante maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10619 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:997124f2-5ed4-3db1-a9e4-11e50058aadf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Children''s Day. Allegro', part.name_en = 'Symphony no. 3, S. 3 "The Camp Meeting": II. Children''s Day. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10619 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:e86509f3-3fcb-35cf-9a5a-636306185559' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e86509f3-3fcb-35cf-9a5a-636306185559', 2, 'II', 'Children''s Day. Allegro', 'Symphony no. 3, S. 3 "The Camp Meeting": II. Children''s Day. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10619 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e86509f3-3fcb-35cf-9a5a-636306185559'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Communion. Largo', part.name_en = 'Symphony no. 3, S. 3 "The Camp Meeting": III. Communion. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10619 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:b6dec8e2-50e0-39d1-961c-67d747d87159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6dec8e2-50e0-39d1-961c-67d747d87159', 3, 'III', 'Communion. Largo', 'Symphony no. 3, S. 3 "The Camp Meeting": III. Communion. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10619 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6dec8e2-50e0-39d1-961c-67d747d87159'
);


-- S. 4 교향곡 4번

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude. Maestoso', part.name_en = 'Symphony no. 4, S. 4: I. Prelude. Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 371 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:47d96225-d1e5-4da3-871d-626839b9f180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47d96225-d1e5-4da3-871d-626839b9f180', 1, 'I', 'Prelude. Maestoso', 'Symphony no. 4, S. 4: I. Prelude. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 371 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47d96225-d1e5-4da3-871d-626839b9f180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Comedy. Allegretto', part.name_en = 'Symphony no. 4, S. 4: II. Comedy. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 371 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:38d3a4d2-2769-4ef1-aecb-ce8b857fcde8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38d3a4d2-2769-4ef1-aecb-ce8b857fcde8', 2, 'II', 'Comedy. Allegretto', 'Symphony no. 4, S. 4: II. Comedy. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 371 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38d3a4d2-2769-4ef1-aecb-ce8b857fcde8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fugue. Andante moderato (con moto)', part.name_en = 'Symphony no. 4, S. 4: III. Fugue. Andante moderato (con moto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 371 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:44444202-14d7-41b5-924d-62d375b8b7ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44444202-14d7-41b5-924d-62d375b8b7ad', 3, 'III', 'Fugue. Andante moderato (con moto)', 'Symphony no. 4, S. 4: III. Fugue. Andante moderato (con moto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 371 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44444202-14d7-41b5-924d-62d375b8b7ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale. Very slowly – Largo maestoso', part.name_en = 'Symphony no. 4, S. 4: IV. Finale. Very slowly – Largo maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 371 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:9f7542c2-534a-43e8-9af6-6bef40dafb78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f7542c2-534a-43e8-9af6-6bef40dafb78', 4, 'IV', 'Finale. Very slowly – Largo maestoso', 'Symphony no. 4, S. 4: IV. Finale. Very slowly – Largo maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 371 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f7542c2-534a-43e8-9af6-6bef40dafb78'
);


-- S. 367 가곡 <Tarrant Moss>

UPDATE pieces piece
SET piece.title = '가곡 <Tarrant Moss>', piece.title_en = 'Tarrant Moss, S. 367',
    piece.type = 'song', piece.opus_number = 'S. 367',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11105 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 280 가곡 <The "Incantation">

UPDATE pieces piece
SET piece.title = '가곡 <The "Incantation">', piece.title_en = 'The "Incantation", S. 280',
    piece.type = 'song', piece.opus_number = 'S. 280',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7536 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 209 가곡 <The All-Enduring>

UPDATE pieces piece
SET piece.title = '가곡 <The All-Enduring>', piece.title_en = 'The All-Enduring, S. 209',
    piece.type = 'song', piece.opus_number = 'S. 209',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7778 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 192 가곡 <The Bells of Yale>

UPDATE pieces piece
SET piece.title = '가곡 <The Bells of Yale>', piece.title_en = 'The Bells of Yale, S. 192',
    piece.type = 'song', piece.opus_number = 'S. 192',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8934 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 221 가곡 <The Cage>

UPDATE pieces piece
SET piece.title = '가곡 <The Cage>', piece.title_en = 'The Cage, S. 221',
    piece.type = 'song', piece.opus_number = 'S. 221',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10696 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 222 가곡 <The Camp Meeting>

UPDATE pieces piece
SET piece.title = '가곡 <The Camp Meeting>', piece.title_en = 'The Camp Meeting, S. 222',
    piece.type = 'song', piece.opus_number = 'S. 222',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9913 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 143 칸타타 <The Celestial Country>

UPDATE pieces piece
SET piece.title = '칸타타 <The Celestial Country>', piece.title_en = 'The Celestial Country, S. 143',
    piece.type = 'album', piece.opus_number = 'S. 143',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10207 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prelude, Trio, and Chorus', part.name_en = 'The Celestial Country, S. 143: I. Prelude, Trio, and Chorus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10207 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:6629cb82-6c49-4a5b-81a5-ae587c924159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6629cb82-6c49-4a5b-81a5-ae587c924159', 1, 'I', 'Prelude, Trio, and Chorus', 'The Celestial Country, S. 143: I. Prelude, Trio, and Chorus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10207 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6629cb82-6c49-4a5b-81a5-ae587c924159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Aria for Baritone', part.name_en = 'The Celestial Country, S. 143: II. Aria for Baritone',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10207 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:34981586-aa23-4ea8-b191-1e2d6a5cda04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34981586-aa23-4ea8-b191-1e2d6a5cda04', 2, 'II', 'Aria for Baritone', 'The Celestial Country, S. 143: II. Aria for Baritone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10207 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34981586-aa23-4ea8-b191-1e2d6a5cda04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quartet, unaccompanied', part.name_en = 'The Celestial Country, S. 143: III. Quartet, unaccompanied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10207 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:c002ab12-847d-4e84-ade8-ea64ddfa7be8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c002ab12-847d-4e84-ade8-ea64ddfa7be8', 3, 'III', 'Quartet, unaccompanied', 'The Celestial Country, S. 143: III. Quartet, unaccompanied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10207 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c002ab12-847d-4e84-ade8-ea64ddfa7be8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Intermezzo for String Quartet', part.name_en = 'The Celestial Country, S. 143: IV. Intermezzo for String Quartet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10207 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:51fa0003-d237-47d5-b00c-ec9c9fee3549' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51fa0003-d237-47d5-b00c-ec9c9fee3549', 4, 'IV', 'Intermezzo for String Quartet', 'The Celestial Country, S. 143: IV. Intermezzo for String Quartet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10207 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51fa0003-d237-47d5-b00c-ec9c9fee3549'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Double Quartet, a cappella', part.name_en = 'The Celestial Country, S. 143: V. Double Quartet, a cappella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10207 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:9b868f7e-bdd3-4037-a782-04e3f0986c20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b868f7e-bdd3-4037-a782-04e3f0986c20', 5, 'V', 'Double Quartet, a cappella', 'The Celestial Country, S. 143: V. Double Quartet, a cappella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10207 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b868f7e-bdd3-4037-a782-04e3f0986c20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Aria for Tenor', part.name_en = 'The Celestial Country, S. 143: VI. Aria for Tenor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10207 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:178ef217-7b87-4e99-aff0-9c3b4e39db3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:178ef217-7b87-4e99-aff0-9c3b4e39db3f', 6, 'VI', 'Aria for Tenor', 'The Celestial Country, S. 143: VI. Aria for Tenor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10207 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:178ef217-7b87-4e99-aff0-9c3b4e39db3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Chorale and Finale', part.name_en = 'The Celestial Country, S. 143: VII. Chorale and Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10207 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:0aeca745-6a57-4322-bdc1-7078a0bcdddd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aeca745-6a57-4322-bdc1-7078a0bcdddd', 7, 'VII', 'Chorale and Finale', 'The Celestial Country, S. 143: VII. Chorale and Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10207 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aeca745-6a57-4322-bdc1-7078a0bcdddd'
);


-- S. 227 가곡 <The Children's Hour>

UPDATE pieces piece
SET piece.title = '가곡 <The Children''s Hour>', piece.title_en = 'The Children''s Hour, S. 227',
    piece.type = 'song', piece.opus_number = 'S. 227',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8168 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 230 가곡 <The Collection>

UPDATE pieces piece
SET piece.title = '가곡 <The Collection>', piece.title_en = 'The Collection, S. 230',
    piece.type = 'song', piece.opus_number = 'S. 230',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11235 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 38 The Gong on the Hook and Ladder or Firemen's Parade on Main Street

UPDATE pieces piece
SET piece.title = 'The Gong on the Hook and Ladder or Firemen''s Parade on Main Street', piece.title_en = 'The Gong on the Hook and Ladder or Firemen''s Parade on Main Street, S. 38',
    piece.type = 'song', piece.opus_number = 'S. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1678 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 259 가곡 <The Greatest Man>

UPDATE pieces piece
SET piece.title = '가곡 <The Greatest Man>', piece.title_en = 'The Greatest Man, S. 259',
    piece.type = 'song', piece.opus_number = 'S. 259',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8942 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 287 가곡 <The Light That Is Felt>

UPDATE pieces piece
SET piece.title = '가곡 <The Light That Is Felt>', piece.title_en = 'The Light That Is Felt, S. 287',
    piece.type = 'song', piece.opus_number = 'S. 287',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8858 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 292 가곡 <The Love Song of Har Dyal>

UPDATE pieces piece
SET piece.title = '가곡 <The Love Song of Har Dyal>', piece.title_en = 'The Love Song of Har Dyal, S. 292',
    piece.type = 'song', piece.opus_number = 'S. 292',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9130 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 308 가곡 <The New River>

UPDATE pieces piece
SET piece.title = '가곡 <The New River>', piece.title_en = 'The New River, S. 308',
    piece.type = 'song', piece.opus_number = 'S. 308',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8307 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 322 가곡 <The One Way>

UPDATE pieces piece
SET piece.title = '가곡 <The One Way>', piece.title_en = 'The One Way, S. 322',
    piece.type = 'song', piece.opus_number = 'S. 322',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7736 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 40 The Pond

UPDATE pieces piece
SET piece.title = 'The Pond', piece.title_en = 'The Pond, S. 40',
    piece.type = 'song', piece.opus_number = 'S. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9877 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 45 The Rainbow

UPDATE pieces piece
SET piece.title = 'The Rainbow', piece.title_en = 'The Rainbow, S. 45',
    piece.type = 'song', piece.opus_number = 'S. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10847 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 343 가곡 <The Sea of Sleep>

UPDATE pieces piece
SET piece.title = '가곡 <The Sea of Sleep>', piece.title_en = 'The Sea of Sleep, S. 343',
    piece.type = 'song', piece.opus_number = 'S. 343',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9804 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 348 가곡 <The Side Show>

UPDATE pieces piece
SET piece.title = '가곡 <The Side Show>', piece.title_en = 'The Side Show, S. 348',
    piece.type = 'song', piece.opus_number = 'S. 348',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9570 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 372 가곡 <The Things Our Fathers Loved>

UPDATE pieces piece
SET piece.title = '가곡 <The Things Our Fathers Loved>', piece.title_en = 'The Things Our Fathers Loved, S. 372',
    piece.type = 'song', piece.opus_number = 'S. 372',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10099 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 391 가곡 <The White Gulls>

UPDATE pieces piece
SET piece.title = '가곡 <The White Gulls>', piece.title_en = 'The White Gulls, S. 391',
    piece.type = 'song', piece.opus_number = 'S. 391',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10609 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 397 가곡 <The World's Highway>

UPDATE pieces piece
SET piece.title = '가곡 <The World''s Highway>', piece.title_en = 'The World''s Highway, S. 397',
    piece.type = 'song', piece.opus_number = 'S. 397',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10081 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 370 가곡 <There Is a Lane>

UPDATE pieces piece
SET piece.title = '가곡 <There Is a Lane>', piece.title_en = 'There Is a Lane, S. 370',
    piece.type = 'song', piece.opus_number = 'S. 370',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7565 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 369 가곡 <There is a Certain Garden>

UPDATE pieces piece
SET piece.title = '가곡 <There is a Certain Garden>', piece.title_en = 'There is a Certain Garden, S. 369',
    piece.type = 'song', piece.opus_number = 'S. 369',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11278 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 373 가곡 <Thoreau>

UPDATE pieces piece
SET piece.title = '가곡 <Thoreau>', piece.title_en = 'Thoreau, S. 373',
    piece.type = 'song', piece.opus_number = 'S. 373',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10193 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 145 Three Harvest Home Chorales

UPDATE pieces piece
SET piece.title = 'Three Harvest Home Chorales', piece.title_en = 'Three Harvest Home Chorales, S. 145',
    piece.type = 'song', piece.opus_number = 'S. 145',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8059 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 117 Three Improvisations S. 117

UPDATE pieces piece
SET piece.title = 'Three Improvisations S. 117', piece.title_en = 'Three Improvisations, S. 117',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'S.', piece.catalogue_number = '117',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9491 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Improvisation I', part.name_en = 'Three Improvisations, S. 117: Improvisation I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9491 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:31354ec7-0007-415c-a0ee-293e77519828' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31354ec7-0007-415c-a0ee-293e77519828', 1, NULL, 'Improvisation I', 'Three Improvisations, S. 117: Improvisation I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9491 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31354ec7-0007-415c-a0ee-293e77519828'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Improvisation II', part.name_en = 'Three Improvisations, S. 117: Improvisation II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9491 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:c0d23481-1c3d-4d3c-9085-59f5be0c4736' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0d23481-1c3d-4d3c-9085-59f5be0c4736', 2, NULL, 'Improvisation II', 'Three Improvisations, S. 117: Improvisation II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9491 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0d23481-1c3d-4d3c-9085-59f5be0c4736'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Improvisation III', part.name_en = 'Three Improvisations, S. 117: Improvisation III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9491 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:df4301ba-2359-4d77-856e-6a6f4980ad20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df4301ba-2359-4d77-856e-6a6f4980ad20', 3, NULL, 'Improvisation III', 'Three Improvisations, S. 117: Improvisation III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9491 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df4301ba-2359-4d77-856e-6a6f4980ad20'
);


-- None Three Outdoor Scenes

UPDATE pieces piece
SET piece.title = 'Three Outdoor Scenes', piece.title_en = 'Three Outdoor Scenes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9801 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hallowe''en, S. 71', part.name_en = 'Hallowe''en, S. 71',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9801 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:c3b6ecc4-7254-48c7-81be-818742130fd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3b6ecc4-7254-48c7-81be-818742130fd8', 1, NULL, 'Hallowe''en, S. 71', 'Hallowe''en, S. 71', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9801 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3b6ecc4-7254-48c7-81be-818742130fd8'
);


-- S. 128 Three Quarter-Tone Pieces

UPDATE pieces piece
SET piece.title = 'Three Quarter-Tone Pieces', piece.title_en = 'Three Quarter-Tone Pieces, S. 128',
    piece.type = 'album', piece.opus_number = 'S. 128',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7849 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'Three Quarter-Tone Pieces, S. 128: I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7849 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:b8437ccd-9667-4e59-b3de-e15e973fd272' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8437ccd-9667-4e59-b3de-e15e973fd272', 1, 'I', 'Largo', 'Three Quarter-Tone Pieces, S. 128: I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7849 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8437ccd-9667-4e59-b3de-e15e973fd272'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Three Quarter-Tone Pieces, S. 128: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7849 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:5315e330-c5bb-45c2-9d57-522a0c34b415' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5315e330-c5bb-45c2-9d57-522a0c34b415', 2, 'II', 'Allegro', 'Three Quarter-Tone Pieces, S. 128: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7849 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5315e330-c5bb-45c2-9d57-522a0c34b415'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Chorale. Adagio, very slowly', part.name_en = 'Three Quarter-Tone Pieces, S. 128: III. Chorale. Adagio, very slowly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7849 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:d8116a76-d905-45a8-93c9-222531152ac2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8116a76-d905-45a8-93c9-222531152ac2', 3, 'III', 'Chorale. Adagio, very slowly', 'Three Quarter-Tone Pieces, S. 128: III. Chorale. Adagio, very slowly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7849 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8116a76-d905-45a8-93c9-222531152ac2'
);


-- S. 89 Three-Page Sonata

UPDATE pieces piece
SET piece.title = 'Three-Page Sonata', piece.title_en = 'Three-Page Sonata, S. 89',
    piece.type = 'song', piece.opus_number = 'S. 89',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9772 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 375 가곡 <Through Night and Day>

UPDATE pieces piece
SET piece.title = '가곡 <Through Night and Day>', piece.title_en = 'Through Night and Day, S. 375',
    piece.type = 'song', piece.opus_number = 'S. 375',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10247 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 376 가곡 <To Edith>

UPDATE pieces piece
SET piece.title = '가곡 <To Edith>', piece.title_en = 'To Edith, S. 376',
    piece.type = 'song', piece.opus_number = 'S. 376',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9970 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 378 가곡 <Tom Sails Away>

UPDATE pieces piece
SET piece.title = '가곡 <Tom Sails Away>', piece.title_en = 'Tom Sails Away, S. 378',
    piece.type = 'song', piece.opus_number = 'S. 378',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10260 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 49 Tone Roads S. 49

UPDATE pieces piece
SET piece.title = 'Tone Roads S. 49', piece.title_en = 'Tone Roads, S. 49',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'S.', piece.catalogue_number = '49',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10560 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tone Roads No. 1, S. 49/i', part.name_en = 'Tone Roads No. 1, S. 49/i',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10560 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:97f75354-0bfa-497d-be67-4b839b8877f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97f75354-0bfa-497d-be67-4b839b8877f8', 1, NULL, 'Tone Roads No. 1, S. 49/i', 'Tone Roads No. 1, S. 49/i', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10560 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97f75354-0bfa-497d-be67-4b839b8877f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tone Roads No. 3, S. 49/iii', part.name_en = 'Tone Roads No. 3, S. 49/iii',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10560 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:1ea751d7-69e4-4d46-b279-ffc9b1ef2244' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea751d7-69e4-4d46-b279-ffc9b1ef2244', 2, NULL, 'Tone Roads No. 3, S. 49/iii', 'Tone Roads No. 3, S. 49/iii', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10560 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea751d7-69e4-4d46-b279-ffc9b1ef2244'
);


-- S. 86 Trio for Violin, Cello and Piano

UPDATE pieces piece
SET piece.title = 'Trio for Violin, Cello and Piano', piece.title_en = 'Trio for Violin, Cello and Piano, S. 86',
    piece.type = 'album', piece.opus_number = 'S. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9192 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'Trio for Violin, Cello and Piano, S. 86: I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9192 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:257e555d-a285-3126-a6a5-5e196139f44c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:257e555d-a285-3126-a6a5-5e196139f44c', 1, 'I', 'Moderato', 'Trio for Violin, Cello and Piano, S. 86: I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9192 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:257e555d-a285-3126-a6a5-5e196139f44c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"TSIAJ". Presto', part.name_en = 'Trio for Violin, Cello and Piano, S. 86: II. "TSIAJ". Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9192 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:41bc6e5e-f033-3231-92e1-976794e485bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41bc6e5e-f033-3231-92e1-976794e485bb', 2, 'II', '"TSIAJ". Presto', 'Trio for Violin, Cello and Piano, S. 86: II. "TSIAJ". Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9192 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41bc6e5e-f033-3231-92e1-976794e485bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato con moto', part.name_en = 'Trio for Violin, Cello and Piano, S. 86: III. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9192 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:247fa843-ffab-3e63-827a-8c768cbc949d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:247fa843-ffab-3e63-827a-8c768cbc949d', 3, 'III', 'Moderato con moto', 'Trio for Violin, Cello and Piano, S. 86: III. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9192 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:247fa843-ffab-3e63-827a-8c768cbc949d'
);


-- None Turn Ye, Turn Ye

UPDATE pieces piece
SET piece.title = 'Turn Ye, Turn Ye', piece.title_en = 'Turn Ye, Turn Ye',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7976 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 379 가곡 <Two Little Flowers>

UPDATE pieces piece
SET piece.title = '가곡 <Two Little Flowers>', piece.title_en = 'Two Little Flowers, S. 379',
    piece.type = 'song', piece.opus_number = 'S. 379',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10027 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 380 Two Slants (Christian and Pagan) S. 380

UPDATE pieces piece
SET piece.title = 'Two Slants (Christian and Pagan) S. 380', piece.title_en = 'Two Slants (Christian and Pagan), S. 380',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'S.', piece.catalogue_number = '380',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8205 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Duty', part.name_en = 'Two Slants (Christian and Pagan), S. 380 No. 1: Duty',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8205 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:09808682-b804-4115-9722-e9c760c912d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09808682-b804-4115-9722-e9c760c912d4', 1, NULL, 'Duty', 'Two Slants (Christian and Pagan), S. 380 No. 1: Duty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8205 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09808682-b804-4115-9722-e9c760c912d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vita', part.name_en = 'Two Slants (Christian and Pagan), S. 380 No. 2: Vita',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8205 AND p.composer_id = 98 AND part.part_key = 'musicbrainz:5eb1018f-c0ec-41a0-8c3c-c5fab6d2bf15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eb1018f-c0ec-41a0-8c3c-c5fab6d2bf15', 2, NULL, 'Vita', 'Two Slants (Christian and Pagan), S. 380 No. 2: Vita', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8205 AND p.composer_id = 98
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eb1018f-c0ec-41a0-8c3c-c5fab6d2bf15'
);


-- S. 6 Universe Symphony

UPDATE pieces piece
SET piece.title = 'Universe Symphony', piece.title_en = 'Universe Symphony, S. 6',
    piece.type = 'song', piece.opus_number = 'S. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10095 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 52 Variations on “Jerusalem the Golden”

UPDATE pieces piece
SET piece.title = 'Variations on “Jerusalem the Golden”', piece.title_en = 'Variations on “Jerusalem the Golden”, S. 52',
    piece.type = 'song', piece.opus_number = 'S. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9498 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 124 Varied Air and Variations

UPDATE pieces piece
SET piece.title = 'Varied Air and Variations', piece.title_en = 'Varied Air and Variations, S. 124',
    piece.type = 'song', piece.opus_number = 'S. 124',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8036 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 381 가곡 <Vote for Names! Names! Names!>

UPDATE pieces piece
SET piece.title = '가곡 <Vote for Names! Names! Names!>', piece.title_en = 'Vote for Names! Names! Names!, S. 381',
    piece.type = 'song', piece.opus_number = 'S. 381',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10693 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 383 가곡 <Walking>

UPDATE pieces piece
SET piece.title = '가곡 <Walking>', piece.title_en = 'Walking, S. 383',
    piece.type = 'song', piece.opus_number = 'S. 383',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10148 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 384 가곡 <Walt Whitman>

UPDATE pieces piece
SET piece.title = '가곡 <Walt Whitman>', piece.title_en = 'Walt Whitman, S. 384',
    piece.type = 'song', piece.opus_number = 'S. 384',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8388 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 125 Waltz-Rondo

UPDATE pieces piece
SET piece.title = 'Waltz-Rondo', piece.title_en = 'Waltz-Rondo, S. 125',
    piece.type = 'song', piece.opus_number = 'S. 125',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9305 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 386 가곡 <Watchman!>

UPDATE pieces piece
SET piece.title = '가곡 <Watchman!>', piece.title_en = 'Watchman!, S. 386',
    piece.type = 'song', piece.opus_number = 'S. 386',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9555 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 394 가곡 <We Melodien zieht es mir>

UPDATE pieces piece
SET piece.title = '가곡 <We Melodien zieht es mir>', piece.title_en = 'We Melodien zieht es mir, S. 394',
    piece.type = 'song', piece.opus_number = 'S. 394',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8057 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 387 가곡 <Weil' auf mir / Eyes so Dark>

UPDATE pieces piece
SET piece.title = '가곡 <Weil'' auf mir / Eyes so Dark>', piece.title_en = 'Weil'' auf mir / Eyes so Dark, S. 387',
    piece.type = 'song', piece.opus_number = 'S. 387',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8421 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 388 가곡 <West London>

UPDATE pieces piece
SET piece.title = '가곡 <West London>', piece.title_en = 'West London, S. 388',
    piece.type = 'song', piece.opus_number = 'S. 388',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10904 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 389 가곡 <When Stars are in the Quiet Skies>

UPDATE pieces piece
SET piece.title = '가곡 <When Stars are in the Quiet Skies>', piece.title_en = 'When Stars are in the Quiet Skies, S. 389',
    piece.type = 'song', piece.opus_number = 'S. 389',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10682 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 390 가곡 <Where the Eagle Cannot See>

UPDATE pieces piece
SET piece.title = '가곡 <Where the Eagle Cannot See>', piece.title_en = 'Where the Eagle Cannot See, S. 390',
    piece.type = 'song', piece.opus_number = 'S. 390',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11094 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 393 가곡 <Widmung>

UPDATE pieces piece
SET piece.title = '가곡 <Widmung>', piece.title_en = 'Widmung, S. 393',
    piece.type = 'song', piece.opus_number = 'S. 393',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8238 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 395 가곡 <Wiegenlied>

UPDATE pieces piece
SET piece.title = '가곡 <Wiegenlied>', piece.title_en = 'Wiegenlied, S. 395',
    piece.type = 'song', piece.opus_number = 'S. 395',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10883 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 396 가곡 <William Will>

UPDATE pieces piece
SET piece.title = '가곡 <William Will>', piece.title_en = 'William Will, S. 396',
    piece.type = 'song', piece.opus_number = 'S. 396',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10264 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 398 가곡 <World's Wanderers>

UPDATE pieces piece
SET piece.title = '가곡 <World''s Wanderers>', piece.title_en = 'World''s Wanderers, S. 398',
    piece.type = 'song', piece.opus_number = 'S. 398',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10482 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 51 Yale-Princeton Football Game

UPDATE pieces piece
SET piece.title = 'Yale-Princeton Football Game', piece.title_en = 'Yale-Princeton Football Game, S. 51',
    piece.type = 'song', piece.opus_number = 'S. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10744 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 399 가곡 <Yellow Leaves>

UPDATE pieces piece
SET piece.title = '가곡 <Yellow Leaves>', piece.title_en = 'Yellow Leaves, S. 399',
    piece.type = 'song', piece.opus_number = 'S. 399',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10502 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 242 엘레지

UPDATE pieces piece
SET piece.title = '엘레지', piece.title_en = 'Élégie, S. 242',
    piece.type = 'song', piece.opus_number = 'S. 242',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8456 AND piece.composer_id = 98
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- S. 228 가곡 <A Christmas Carol>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <A Christmas Carol>', 'A Christmas Carol, S. 228', 'song', 'S. 228', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 98
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <A Christmas Carol>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e648a72-4c3c-4b7b-b9dc-31d51b6da3db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e648a72-4c3c-4b7b-b9dc-31d51b6da3db'
FROM pieces p
WHERE p.composer_id = 98 AND p.title = '가곡 <A Christmas Carol>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e648a72-4c3c-4b7b-b9dc-31d51b6da3db'
);


-- None Bread of the World

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Bread of the World', 'Bread of the World', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 98
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Bread of the World'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b823143-2e1f-429b-baab-e2b6fc1cb0cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b823143-2e1f-429b-baab-e2b6fc1cb0cd'
FROM pieces p
WHERE p.composer_id = 98 AND p.title = 'Bread of the World' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b823143-2e1f-429b-baab-e2b6fc1cb0cd'
);


-- S. 385 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠', 'Waltz, S. 385', 'song', 'S. 385', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 98
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a5f86f5-137d-42db-98ef-32c756e25114'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a5f86f5-137d-42db-98ef-32c756e25114'
FROM pieces p
WHERE p.composer_id = 98 AND p.title = '왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a5f86f5-137d-42db-98ef-32c756e25114'
);


-- 카탈로그에 대응이 없는 seed 작품 46개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 98 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    7731, 7829, 8224, 8562, 8579, 8596, 8704, 8708, 8717, 8789, 8892, 8894, 8953, 8958, 9076, 9168, 9252, 9360, 9587, 9725,
    9776, 9814, 9959, 9978, 10155, 10215, 10244, 10442, 10444, 10512, 10532, 10538, 10574, 10625, 10631, 10638, 10647, 10653, 10692, 10739,
    10746, 10783, 11008, 11049, 11083, 11250
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
