-- Julia Wolfe 작품을 MusicBrainz 작품 구조로 다시 짠다(5차 자동). 작품 28개(묶음 1, 다악장 2, 낱곡 25),
-- 새 작품 1개, part 17개, 그 아래 0개.
-- seed 27개 중 27개를 작품·part 에 잇고, 0개를 숨기고, 0개는 그대로 둔다.
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

-- None Arsenal of Democracy

UPDATE pieces piece
SET piece.title = 'Arsenal of Democracy', piece.title_en = 'Arsenal of Democracy',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24263 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Believing

UPDATE pieces piece
SET piece.title = 'Believing', piece.title_en = 'Believing',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25365 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Big Beautiful Dark and Scary

UPDATE pieces piece
SET piece.title = 'Big Beautiful Dark and Scary', piece.title_en = 'Big Beautiful Dark and Scary',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25039 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Compassion

UPDATE pieces piece
SET piece.title = 'Compassion', piece.title_en = 'Compassion',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23707 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dark Full Ride

UPDATE pieces piece
SET piece.title = 'Dark Full Ride', piece.title_en = 'Dark Full Ride',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25124 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Dig Deep

UPDATE pieces piece
SET piece.title = 'Dig Deep', piece.title_en = 'Dig Deep',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24376 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Early that Summer

UPDATE pieces piece
SET piece.title = 'Early that Summer', piece.title_en = 'Early that Summer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25450 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Earring

UPDATE pieces piece
SET piece.title = 'Earring', piece.title_en = 'Earring',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25330 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None East Broadway

UPDATE pieces piece
SET piece.title = 'East Broadway', piece.title_en = 'East Broadway',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23864 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <Emunah>

UPDATE pieces piece
SET piece.title = '가곡 <Emunah>', piece.title_en = 'Emunah',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24344 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 오라토리오 <Fire in my mouth>

UPDATE pieces piece
SET piece.title = '오라토리오 <Fire in my mouth>', piece.title_en = 'Fire in my mouth',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23850 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Immigration', part.name_en = 'Fire in my mouth: I. Immigration',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23850 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:6c1341c9-7973-4227-9fe4-7ce832c1a76e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c1341c9-7973-4227-9fe4-7ce832c1a76e', 1, 'I', 'Immigration', 'Fire in my mouth: I. Immigration', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23850 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c1341c9-7973-4227-9fe4-7ce832c1a76e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Factory', part.name_en = 'Fire in my mouth: II. Factory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23850 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:8d610cb6-e302-4830-bcbf-2c7648fa2b8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d610cb6-e302-4830-bcbf-2c7648fa2b8d', 2, 'II', 'Factory', 'Fire in my mouth: II. Factory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23850 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d610cb6-e302-4830-bcbf-2c7648fa2b8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Protest', part.name_en = 'Fire in my mouth: III. Protest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23850 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:33c2c43b-6a27-4dbb-a2fd-ae828af729d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33c2c43b-6a27-4dbb-a2fd-ae828af729d2', 3, 'III', 'Protest', 'Fire in my mouth: III. Protest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23850 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33c2c43b-6a27-4dbb-a2fd-ae828af729d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fire', part.name_en = 'Fire in my mouth: IV. Fire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23850 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:6c70bec1-3e38-4a07-b135-a0986184f7db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c70bec1-3e38-4a07-b135-a0986184f7db', 4, 'IV', 'Fire', 'Fire in my mouth: IV. Fire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23850 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c70bec1-3e38-4a07-b135-a0986184f7db'
);


-- None Forbidden Love

UPDATE pieces piece
SET piece.title = 'Forbidden Love', piece.title_en = 'Forbidden Love',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23350 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Four Marys

UPDATE pieces piece
SET piece.title = 'Four Marys', piece.title_en = 'Four Marys',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25453 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Guard my tongue

UPDATE pieces piece
SET piece.title = 'Guard my tongue', piece.title_en = 'Guard my tongue',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25659 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lad

UPDATE pieces piece
SET piece.title = 'Lad', piece.title_en = 'Lad',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23839 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Lick

UPDATE pieces piece
SET piece.title = 'Lick', piece.title_en = 'Lick',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25437 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Oxygen

UPDATE pieces piece
SET piece.title = 'Oxygen', piece.title_en = 'Oxygen',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25070 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pretty

UPDATE pieces piece
SET piece.title = 'Pretty', piece.title_en = 'Pretty',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23627 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Reeling

UPDATE pieces piece
SET piece.title = 'Reeling', piece.title_en = 'Reeling',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23434 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Singing in the Dead of Night

UPDATE pieces piece
SET piece.title = 'Singing in the Dead of Night', piece.title_en = 'Singing in the Dead of Night',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25415 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Steam

UPDATE pieces piece
SET piece.title = 'Steam', piece.title_en = 'Steam',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24930 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Steel Hammer

UPDATE pieces piece
SET piece.title = 'Steel Hammer', piece.title_en = 'Steel Hammer',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24112 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Some Say', part.name_en = 'Steel Hammer: Some Say',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24112 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:99b1e7d3-235f-44bf-a608-8feaf16dcba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99b1e7d3-235f-44bf-a608-8feaf16dcba5', 1, NULL, 'Some Say', 'Steel Hammer: Some Say', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24112 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99b1e7d3-235f-44bf-a608-8feaf16dcba5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'The States', part.name_en = 'Steel Hammer: The States',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24112 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:6bbd8936-c3e6-4317-a1cc-7cb3e0c78705' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bbd8936-c3e6-4317-a1cc-7cb3e0c78705', 2, NULL, 'The States', 'Steel Hammer: The States', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24112 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bbd8936-c3e6-4317-a1cc-7cb3e0c78705'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Destiny', part.name_en = 'Steel Hammer: Destiny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24112 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:86d7b789-b75a-446c-8612-bfa1beeba406' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86d7b789-b75a-446c-8612-bfa1beeba406', 3, NULL, 'Destiny', 'Steel Hammer: Destiny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24112 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86d7b789-b75a-446c-8612-bfa1beeba406'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Mountain', part.name_en = 'Steel Hammer: Mountain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24112 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:a0a71a90-e07b-461e-b40f-b1cc2564c568' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0a71a90-e07b-461e-b40f-b1cc2564c568', 4, NULL, 'Mountain', 'Steel Hammer: Mountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24112 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0a71a90-e07b-461e-b40f-b1cc2564c568'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Characteristics', part.name_en = 'Steel Hammer: Characteristics',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24112 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:9f4616f2-a9d2-4117-a9b7-e1534a226688' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f4616f2-a9d2-4117-a9b7-e1534a226688', 5, NULL, 'Characteristics', 'Steel Hammer: Characteristics', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24112 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f4616f2-a9d2-4117-a9b7-e1534a226688'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Polly Ann and The Race', part.name_en = 'Steel Hammer: Polly Ann and The Race',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24112 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:85c215b9-04c2-4bc8-a9e5-024d229812e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85c215b9-04c2-4bc8-a9e5-024d229812e2', 6, NULL, 'Polly Ann and The Race', 'Steel Hammer: Polly Ann and The Race', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24112 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c215b9-04c2-4bc8-a9e5-024d229812e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Winner', part.name_en = 'Steel Hammer: Winner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24112 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:40991b39-eb20-4df4-ab46-437ca8526f51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40991b39-eb20-4df4-ab46-437ca8526f51', 7, NULL, 'Winner', 'Steel Hammer: Winner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24112 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40991b39-eb20-4df4-ab46-437ca8526f51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Lord, Lord', part.name_en = 'Steel Hammer: Lord, Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24112 AND p.composer_id = 445 AND part.part_key = 'musicbrainz:0f862fb6-4c68-4d1c-b2e3-08a2c06b16b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f862fb6-4c68-4d1c-b2e3-08a2c06b16b2', 8, NULL, 'Lord, Lord', 'Steel Hammer: Lord, Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24112 AND p.composer_id = 445
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f862fb6-4c68-4d1c-b2e3-08a2c06b16b2'
);


-- None Stronghold

UPDATE pieces piece
SET piece.title = 'Stronghold', piece.title_en = 'Stronghold',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24287 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Tell Me Everything

UPDATE pieces piece
SET piece.title = 'Tell Me Everything', piece.title_en = 'Tell Me Everything',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24997 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None The Vermeer Room

UPDATE pieces piece
SET piece.title = 'The Vermeer Room', piece.title_en = 'The Vermeer Room',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23602 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Thirst

UPDATE pieces piece
SET piece.title = 'Thirst', piece.title_en = 'Thirst',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25745 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None my lips from speaking

UPDATE pieces piece
SET piece.title = 'my lips from speaking', piece.title_en = 'my lips from speaking',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23366 AND piece.composer_id = 445
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Anthracite Fields

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Anthracite Fields', 'Anthracite Fields', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 445
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Anthracite Fields'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97f56719-b436-4c68-9f82-30d2c74fdfa5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97f56719-b436-4c68-9f82-30d2c74fdfa5'
FROM pieces p
WHERE p.composer_id = 445 AND p.title = 'Anthracite Fields' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97f56719-b436-4c68-9f82-30d2c74fdfa5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52d55d5b-e343-4e10-80f7-49e9197f1ee3', 1, 'I', 'Foundation', 'Anthracite Fields: I. Foundation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 445 AND p.title = 'Anthracite Fields' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52d55d5b-e343-4e10-80f7-49e9197f1ee3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60bd3e7d-9595-4b7d-ac35-4507deb0ed6e', 2, 'II', 'Breaker Boys', 'Anthracite Fields: II. Breaker Boys', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 445 AND p.title = 'Anthracite Fields' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60bd3e7d-9595-4b7d-ac35-4507deb0ed6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d2ffd60-03f0-4c34-8d40-14b02c2b8c6a', 3, 'III', 'Speech', 'Anthracite Fields: III. Speech', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 445 AND p.title = 'Anthracite Fields' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d2ffd60-03f0-4c34-8d40-14b02c2b8c6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3684145a-6bd6-4b47-b121-4cc9e70c0892', 4, 'IV', 'Flowers', 'Anthracite Fields: IV. Flowers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 445 AND p.title = 'Anthracite Fields' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3684145a-6bd6-4b47-b121-4cc9e70c0892'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4137d1c0-3a0e-4190-8595-b3010db80458', 5, 'V', 'Appliances', 'Anthracite Fields: V. Appliances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 445 AND p.title = 'Anthracite Fields' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4137d1c0-3a0e-4190-8595-b3010db80458'
);


-- 숨길 seed 작품 없음
