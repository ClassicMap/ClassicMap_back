-- 밀턴 배빗 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 46개(묶음 1, 다악장 1, 낱곡 44),
-- 새 작품 4개, part 9개, 그 아래 0개.
-- seed 42개 중 42개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None About Time

UPDATE pieces piece
SET piece.title = 'About Time', piece.title_en = 'About Time',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19999 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None All Set

UPDATE pieces piece
SET piece.title = 'All Set', piece.title_en = 'All Set',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16017 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None An Elizabethan Sextette

UPDATE pieces piece
SET piece.title = 'An Elizabethan Sextette', piece.title_en = 'An Elizabethan Sextette',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19442 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '"When I Was Fair and Young"', part.name_en = 'An Elizabethan Sextette: I. "When I Was Fair and Young"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19442 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:c899d37f-e3b6-4fe7-b35a-99225aab5932' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c899d37f-e3b6-4fe7-b35a-99225aab5932', 1, 'I', '"When I Was Fair and Young"', 'An Elizabethan Sextette: I. "When I Was Fair and Young"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19442 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c899d37f-e3b6-4fe7-b35a-99225aab5932'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '"Out of Sight, Out of Mind"', part.name_en = 'An Elizabethan Sextette: II. "Out of Sight, Out of Mind"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19442 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:f298119f-060b-45d4-bbdb-b579821976c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f298119f-060b-45d4-bbdb-b579821976c9', 2, 'II', '"Out of Sight, Out of Mind"', 'An Elizabethan Sextette: II. "Out of Sight, Out of Mind"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19442 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f298119f-060b-45d4-bbdb-b579821976c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '"Your Face, Your Tongue"', part.name_en = 'An Elizabethan Sextette: III. "Your Face, Your Tongue"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19442 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:6d45db84-fc5b-44bb-83a4-ea902352beec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d45db84-fc5b-44bb-83a4-ea902352beec', 3, 'III', '"Your Face, Your Tongue"', 'An Elizabethan Sextette: III. "Your Face, Your Tongue"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19442 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d45db84-fc5b-44bb-83a4-ea902352beec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '"Can Doleful Notes to Measured Accents Set"', part.name_en = 'An Elizabethan Sextette: IV. "Can Doleful Notes to Measured Accents Set"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19442 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:074451ab-13ad-49e5-ba0a-a1ec000e8c3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074451ab-13ad-49e5-ba0a-a1ec000e8c3d', 4, 'IV', '"Can Doleful Notes to Measured Accents Set"', 'An Elizabethan Sextette: IV. "Can Doleful Notes to Measured Accents Set"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19442 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074451ab-13ad-49e5-ba0a-a1ec000e8c3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '"First Love"', part.name_en = 'An Elizabethan Sextette: V. "First Love"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19442 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:03fd5c00-f068-4376-9910-fba330212e55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03fd5c00-f068-4376-9910-fba330212e55', 5, 'V', '"First Love"', 'An Elizabethan Sextette: V. "First Love"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19442 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03fd5c00-f068-4376-9910-fba330212e55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '"Neopolitan"', part.name_en = 'An Elizabethan Sextette: VI. "Neopolitan"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19442 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:189fb0aa-e6ae-4f2c-a387-81b54754806e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:189fb0aa-e6ae-4f2c-a387-81b54754806e', 6, 'VI', '"Neopolitan"', 'An Elizabethan Sextette: VI. "Neopolitan"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19442 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:189fb0aa-e6ae-4f2c-a387-81b54754806e'
);


-- None Arie da Capo

UPDATE pieces piece
SET piece.title = 'Arie da Capo', piece.title_en = 'Arie da Capo',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16006 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Around the Horn

UPDATE pieces piece
SET piece.title = 'Around the Horn', piece.title_en = 'Around the Horn',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18446 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Beaten Paths

UPDATE pieces piece
SET piece.title = 'Beaten Paths', piece.title_en = 'Beaten Paths',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18934 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Canonical Form

UPDATE pieces piece
SET piece.title = 'Canonical Form', piece.title_en = 'Canonical Form',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16750 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Composition for Guitar "Sheer Pluck"

UPDATE pieces piece
SET piece.title = 'Composition for Guitar "Sheer Pluck"', piece.title_en = 'Composition for Guitar "Sheer Pluck"',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18467 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Composition for Synthesizer

UPDATE pieces piece
SET piece.title = 'Composition for Synthesizer', piece.title_en = 'Composition for Synthesizer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19478 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Correspondences

UPDATE pieces piece
SET piece.title = 'Correspondences', piece.title_en = 'Correspondences',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17334 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Danci

UPDATE pieces piece
SET piece.title = 'Danci', piece.title_en = 'Danci',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17775 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Duet for piano

UPDATE pieces piece
SET piece.title = 'Duet for piano', piece.title_en = 'Duet for piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18189 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Ensembles for Synthesizer

UPDATE pieces piece
SET piece.title = 'Ensembles for Synthesizer', piece.title_en = 'Ensembles for Synthesizer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19842 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Groupwise

UPDATE pieces piece
SET piece.title = 'Groupwise', piece.title_en = 'Groupwise',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16792 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Homily

UPDATE pieces piece
SET piece.title = 'Homily', piece.title_en = 'Homily',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18917 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None It Takes Twelve to Tango

UPDATE pieces piece
SET piece.title = 'It Takes Twelve to Tango', piece.title_en = 'It Takes Twelve to Tango',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17761 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lagniappe

UPDATE pieces piece
SET piece.title = 'Lagniappe', piece.title_en = 'Lagniappe',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18285 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Manifold Music

UPDATE pieces piece
SET piece.title = 'Manifold Music', piece.title_en = 'Manifold Music',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19391 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Melismata

UPDATE pieces piece
SET piece.title = 'Melismata', piece.title_en = 'Melismata',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18898 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Minute Waltz (or) ¾ ± ⅛

UPDATE pieces piece
SET piece.title = 'Minute Waltz (or) ¾ ± ⅛', piece.title_en = 'Minute Waltz (or) ¾ ± ⅛',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19885 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None My Ends Are My Beginnings

UPDATE pieces piece
SET piece.title = 'My Ends Are My Beginnings', piece.title_en = 'My Ends Are My Beginnings',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19893 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Section I', part.name_en = 'My Ends Are My Beginnings: Section I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19893 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:db8dff0d-b1f7-4c5d-b4e0-0743d6d4bc45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db8dff0d-b1f7-4c5d-b4e0-0743d6d4bc45', 1, NULL, 'Section I', 'My Ends Are My Beginnings: Section I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19893 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db8dff0d-b1f7-4c5d-b4e0-0743d6d4bc45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Section II', part.name_en = 'My Ends Are My Beginnings: Section II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19893 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:0458f15b-d72d-4f93-b863-8c637025a081' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0458f15b-d72d-4f93-b863-8c637025a081', 2, NULL, 'Section II', 'My Ends Are My Beginnings: Section II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19893 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0458f15b-d72d-4f93-b863-8c637025a081'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Section III', part.name_en = 'My Ends Are My Beginnings: Section III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 19893 AND p.composer_id = 252 AND part.part_key = 'musicbrainz:79559f18-3471-43b1-aa3e-ade80ac90c5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79559f18-3471-43b1-aa3e-ade80ac90c5f', 3, NULL, 'Section III', 'My Ends Are My Beginnings: Section III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 19893 AND p.composer_id = 252
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79559f18-3471-43b1-aa3e-ade80ac90c5f'
);


-- None None but the Lonely Flute

UPDATE pieces piece
SET piece.title = 'None but the Lonely Flute', piece.title_en = 'None but the Lonely Flute',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17636 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Overtime

UPDATE pieces piece
SET piece.title = 'Overtime', piece.title_en = 'Overtime',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17891 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Paraphrases

UPDATE pieces piece
SET piece.title = 'Paraphrases', piece.title_en = 'Paraphrases',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18676 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Partitions

UPDATE pieces piece
SET piece.title = 'Partitions', piece.title_en = 'Partitions',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17968 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Philomel

UPDATE pieces piece
SET piece.title = 'Philomel', piece.title_en = 'Philomel',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19206 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Play it Again, Sam

UPDATE pieces piece
SET piece.title = 'Play it Again, Sam', piece.title_en = 'Play it Again, Sam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19121 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Playing for Time

UPDATE pieces piece
SET piece.title = 'Playing for Time', piece.title_en = 'Playing for Time',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16605 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Post-Partitions

UPDATE pieces piece
SET piece.title = 'Post-Partitions', piece.title_en = 'Post-Partitions',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18033 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quatrains

UPDATE pieces piece
SET piece.title = 'Quatrains', piece.title_en = 'Quatrains',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16692 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Quintet for Clarinet and String Quartet

UPDATE pieces piece
SET piece.title = 'Quintet for Clarinet and String Quartet', piece.title_en = 'Quintet for Clarinet and String Quartet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19751 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Reflections

UPDATE pieces piece
SET piece.title = 'Reflections', piece.title_en = 'Reflections',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19608 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Relata I

UPDATE pieces piece
SET piece.title = 'Relata I', piece.title_en = 'Relata I',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18725 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Semi-Simple Variations

UPDATE pieces piece
SET piece.title = 'Semi-Simple Variations', piece.title_en = 'Semi-Simple Variations',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16984 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Soli e duettini

UPDATE pieces piece
SET piece.title = 'Soli e duettini', piece.title_en = 'Soli e duettini',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16292 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 현악 4중주 2번

UPDATE pieces piece
SET piece.title = '현악 4중주 2번', piece.title_en = 'String Quartet No.2',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18650 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Swan Song no. 1

UPDATE pieces piece
SET piece.title = 'Swan Song no. 1', piece.title_en = 'Swan Song no. 1',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 17606 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tableaux

UPDATE pieces piece
SET piece.title = 'Tableaux', piece.title_en = 'Tableaux',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16757 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <The Widow's Lament in Springtime>

UPDATE pieces piece
SET piece.title = '가곡 <The Widow''s Lament in Springtime>', piece.title_en = 'The Widow''s Lament in Springtime',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 16306 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Three Compositions for Piano

UPDATE pieces piece
SET piece.title = 'Three Compositions for Piano', piece.title_en = 'Three Compositions for Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 19183 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Vision and Prayer

UPDATE pieces piece
SET piece.title = 'Vision and Prayer', piece.title_en = 'Vision and Prayer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18101 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Whirled Series

UPDATE pieces piece
SET piece.title = 'Whirled Series', piece.title_en = 'Whirled Series',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 18083 AND piece.composer_id = 252
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Phonemena

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Phonemena', 'Phonemena', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 252
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Phonemena'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '366f0cf2-1255-4a2a-bfc1-f663ea98d1c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '366f0cf2-1255-4a2a-bfc1-f663ea98d1c7'
FROM pieces p
WHERE p.composer_id = 252 AND p.title = 'Phonemena' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '366f0cf2-1255-4a2a-bfc1-f663ea98d1c7'
);


-- None 피아노 협주곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 1번', 'Piano Concerto no. 1', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 252
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f5e870a-704e-4a82-9bec-1c20a4d0e3fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f5e870a-704e-4a82-9bec-1c20a4d0e3fd'
FROM pieces p
WHERE p.composer_id = 252 AND p.title = '피아노 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f5e870a-704e-4a82-9bec-1c20a4d0e3fd'
);


-- None 현악 4중주 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번', 'String Quartet no. 3', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 252
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '889a4048-6770-4b36-8a7e-f6a02e5af85a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '889a4048-6770-4b36-8a7e-f6a02e5af85a'
FROM pieces p
WHERE p.composer_id = 252 AND p.title = '현악 4중주 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '889a4048-6770-4b36-8a7e-f6a02e5af85a'
);


-- None 현악 4중주 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 4번', 'String Quartet no. 4', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 252
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdc3edbd-d098-41c8-8f08-916c9fc2f795'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdc3edbd-d098-41c8-8f08-916c9fc2f795'
FROM pieces p
WHERE p.composer_id = 252 AND p.title = '현악 4중주 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdc3edbd-d098-41c8-8f08-916c9fc2f795'
);


-- 숨길 seed 작품 없음
