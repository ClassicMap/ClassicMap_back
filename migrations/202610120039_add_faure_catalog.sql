-- 포레 작품을 출판 단위로 다시 짠다(카탈로그: Op.·N.). 작품 136개(묶음 36, 다악장 18, 낱곡 82),
-- 새 작품 17개, 기존 작품 119개(seed 제목 고침 115개), part 200개, 그 아래 0개,
-- 기존 part 고쳐 씀 0개, 기존 작품 연결 3개. 카탈로그에 대응이 없는 seed 40개는 목록에서 숨긴다.
--
-- 정한 것
--   녹턴·뱃노래는 작품번호마다 낱곡, 한 번호에 여러 곡인 Op. 33·84·104 만 묶음. 레퀴엠은 1900년 판 7곡.
--   209 「가곡 <꿈을 꾼 후에>」는 Op. 7 의 1번 part 로 잇는다. 번호 없는 곡은 catalogue 를 비운다.
--
-- 공통: 자료는 seed_pipeline/curation/catalog-wave3-2026-10-12/<작곡가>/catalog.json·seed_map.json 이고,
-- 본문은 그 폴더의 gen_catalog.py 가 만든다. 위키백과 작품 목록을 기준으로 MusicBrainz work 와 맞췄다.
--   3차는 국제 시드가 원어 제목으로 넣어 둔 작품이 많은 작곡가다. seed_map.json 으로 seed 작품마다
--     work(카탈로그 작품 자리) / part(묶음·다악장 안 곡) / unmatched(남의 편곡·대중음악·번안·중복·범위 밖 등)를 정했다.
--   손대지 않은 seed(origin='seed', editor_locked=0)는 제목·갈래·번호를 카탈로그대로 고치고 잠근다.
--     part 로 이은 seed 는 「<작품> 중 "<곡>"」 꼴이 된다. 편집자가 잠근 seed 와 manual 은 제목을 바꾸지 않는다.
--   unmatched seed 는 hidden_reason='catalog_unmatched' 로 목록에서 숨긴다(지우지 않음, 상세는 열림).
--     비교 구간이 있거나 part 가 가리키는 작품, 단독으로 널리 연주되는 대목은 숨기지 않는다.
--   기존 seed part 중 카탈로그와 MBID 가 같은 것은 이름·순서·상위 part 를 고쳐 EDITOR_REVIEWED 로 올린다.
--     맞는 게 없는 seed part 는 확인 안 된 상태로 둔다(화면에 안 보임).
--   단위: 함께 출판된 곡은 묶음(작품 하나 + part), 악장은 part, 묶음 안 곡의 악장은 그 아래 part.
--     무대·대형 성악 작품은 seed 가 안의 대목을 가리킬 때만 part 를 둔다.
--   이름: 묶음 제목은 구별이 필요하면 끝에 카탈로그를 넣고 opus_number 를 비운 채 catalogue_system·number 를
--     채운다. 낱곡·다악장은 opus_number 에 카탈로그를 둔다. part 이름에는 "1번"·"1악장" 을 넣지 않는다.
--   빼는 것: 위작, 소실, 단편·스케치, 남의 작품 편곡, 민요 편곡(작곡가별 예외는 위에 적음), 같은 곡의 옛 판.
--   기존 작품: MBID 로 먼저, 없으면 카탈로그 번호로 맞춘다. manual 의 제목·설명·링크는 바꾸지 않고 비어 있는
--     작품번호·연도만 채운다. 기존 작품에 없는 원곡 MBID 는 식별자로 더한다.
--   두 번 돌려도 같다.

-- Op. 1 가곡집 Op. 1

UPDATE pieces piece
SET piece.title = '가곡집 Op. 1', piece.title_en = '2 Songs, Op. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '1',
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 981 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 981 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le papillon et la fleur', part.name_en = 'Le papillon et la fleur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 981 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:3870dfe2-a5a2-3bd1-8f5f-1ba7c236389c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3870dfe2-a5a2-3bd1-8f5f-1ba7c236389c', 1, NULL, 'Le papillon et la fleur', 'Le papillon et la fleur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 981 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3870dfe2-a5a2-3bd1-8f5f-1ba7c236389c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mai', part.name_en = 'Mai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 981 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:5b5d2077-5bbb-3cb8-8513-2dc47b16af01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b5d2077-5bbb-3cb8-8513-2dc47b16af01', 2, NULL, 'Mai', 'Mai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 981 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b5d2077-5bbb-3cb8-8513-2dc47b16af01'
);


-- Op. 2 가곡집 Op. 2

UPDATE pieces piece
SET piece.title = '가곡집 Op. 2', piece.title_en = '2 Songs, Op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(1870, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2140 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1870
WHERE piece.id = 2140 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dans les ruines d''une abbaye', part.name_en = 'Dans les ruines d''une abbaye',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2140 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:cde36720-3282-36c8-b9cb-c41c1cab3789' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cde36720-3282-36c8-b9cb-c41c1cab3789', 1, NULL, 'Dans les ruines d''une abbaye', 'Dans les ruines d''une abbaye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2140 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cde36720-3282-36c8-b9cb-c41c1cab3789'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Les matelots', part.name_en = 'Les matelots',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2140 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d6ff8445-618c-34ee-ac93-d8bce6390c77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6ff8445-618c-34ee-ac93-d8bce6390c77', 2, NULL, 'Les matelots', 'Les matelots', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2140 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6ff8445-618c-34ee-ac93-d8bce6390c77'
);


-- Op. 3 가곡집 Op. 3

UPDATE pieces piece
SET piece.title = '가곡집 Op. 3', piece.title_en = '2 Songs, Op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2455 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 2455 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Seule !', part.name_en = 'Seule !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2455 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:9907f339-a869-3774-9297-86f2c14915a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9907f339-a869-3774-9297-86f2c14915a1', 1, NULL, 'Seule !', 'Seule !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2455 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9907f339-a869-3774-9297-86f2c14915a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sérénade toscane', part.name_en = 'Sérénade toscane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2455 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:3c8ff5c6-8d7e-386f-8a0d-4cf227dfcefb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c8ff5c6-8d7e-386f-8a0d-4cf227dfcefb', 2, NULL, 'Sérénade toscane', 'Sérénade toscane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2455 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c8ff5c6-8d7e-386f-8a0d-4cf227dfcefb'
);


-- Op. 4 가곡집 Op. 4

UPDATE pieces piece
SET piece.title = '가곡집 Op. 4', piece.title_en = '2 Songs, Op. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '4',
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1601 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 1601 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson du pêcheur (Lamento)', part.name_en = 'Chanson du pêcheur (Lamento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1601 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:3a596927-fd73-3d4b-9d1e-2ae7dde37c04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a596927-fd73-3d4b-9d1e-2ae7dde37c04', 1, NULL, 'Chanson du pêcheur (Lamento)', 'Chanson du pêcheur (Lamento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1601 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a596927-fd73-3d4b-9d1e-2ae7dde37c04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lydia', part.name_en = 'Lydia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1601 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:e4e6d901-4f0e-31a6-bc9e-78dac1c06676' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4e6d901-4f0e-31a6-bc9e-78dac1c06676', 2, NULL, 'Lydia', 'Lydia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1601 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e6d901-4f0e-31a6-bc9e-78dac1c06676'
);


-- Op. 5 가곡집 Op. 5

UPDATE pieces piece
SET piece.title = '가곡집 Op. 5', piece.title_en = '3 Songs, Op. 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '5',
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1597 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 1597 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chant d''automne', part.name_en = 'Chant d''automne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1597 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:245c3f68-7ba7-34fe-a9e8-936a2e71b887' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:245c3f68-7ba7-34fe-a9e8-936a2e71b887', 1, NULL, 'Chant d''automne', 'Chant d''automne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1597 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:245c3f68-7ba7-34fe-a9e8-936a2e71b887'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rêve d''amour', part.name_en = 'Rêve d''amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1597 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:8f2df2c3-8db5-3455-b15e-4eb6b29436aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f2df2c3-8db5-3455-b15e-4eb6b29436aa', 2, NULL, 'Rêve d''amour', 'Rêve d''amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1597 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f2df2c3-8db5-3455-b15e-4eb6b29436aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'L''absent', part.name_en = 'L''absent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1597 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:b975497b-b385-311d-8b99-d2e7c747b19e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b975497b-b385-311d-8b99-d2e7c747b19e', 3, NULL, 'L''absent', 'L''absent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1597 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b975497b-b385-311d-8b99-d2e7c747b19e'
);


-- Op. 6 가곡집 Op. 6

UPDATE pieces piece
SET piece.title = '가곡집 Op. 6', piece.title_en = '3 Songs, Op. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '6',
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2461 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 2461 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Aubade', part.name_en = 'Aubade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2461 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:592da4c3-2579-3e01-8205-1724349a5789' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:592da4c3-2579-3e01-8205-1724349a5789', 1, NULL, 'Aubade', 'Aubade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2461 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:592da4c3-2579-3e01-8205-1724349a5789'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tristesse', part.name_en = 'Tristesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2461 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:6fc2d43a-a1d1-3606-bb80-543ed6c9d702' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fc2d43a-a1d1-3606-bb80-543ed6c9d702', 2, NULL, 'Tristesse', 'Tristesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2461 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fc2d43a-a1d1-3606-bb80-543ed6c9d702'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sylvie', part.name_en = 'Sylvie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2461 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:102c57f9-96dc-3a13-b1ca-c45166c56492' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:102c57f9-96dc-3a13-b1ca-c45166c56492', 3, NULL, 'Sylvie', 'Sylvie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2461 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:102c57f9-96dc-3a13-b1ca-c45166c56492'
);


-- Op. 7 가곡집 Op. 7

UPDATE pieces piece
SET piece.title = '가곡집 Op. 7', piece.title_en = '3 Songs, Op. 7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '7',
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1211 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 1211 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 209 AND linked.composer_id = 47),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '꿈을 꾼 후에 (Après un rêve)', part.name_en = 'Après un rêve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1211 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a57e0d98-ad45-3e10-a58b-6835a3e83884' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 209 AND linked.composer_id = 47), 'musicbrainz:a57e0d98-ad45-3e10-a58b-6835a3e83884', 1, NULL, '꿈을 꾼 후에 (Après un rêve)', 'Après un rêve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1211 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a57e0d98-ad45-3e10-a58b-6835a3e83884'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hymne', part.name_en = 'Hymne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1211 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:50957ce7-765d-36f5-ae08-401ea09c73ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50957ce7-765d-36f5-ae08-401ea09c73ca', 2, NULL, 'Hymne', 'Hymne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1211 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50957ce7-765d-36f5-ae08-401ea09c73ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Barcarolle', part.name_en = 'Barcarolle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1211 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d690e503-4fbe-3400-90db-fc0c3f086bdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d690e503-4fbe-3400-90db-fc0c3f086bdd', 3, NULL, 'Barcarolle', 'Barcarolle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1211 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d690e503-4fbe-3400-90db-fc0c3f086bdd'
);


-- Op. 8 가곡집 Op. 8

UPDATE pieces piece
SET piece.title = '가곡집 Op. 8', piece.title_en = '3 Songs, Op. 8',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '8',
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2480 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 2480 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Au bord de l''eau', part.name_en = 'Au bord de l''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2480 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a382ecf8-7d5b-3374-a234-00f3a670b20f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a382ecf8-7d5b-3374-a234-00f3a670b20f', 1, NULL, 'Au bord de l''eau', 'Au bord de l''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2480 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a382ecf8-7d5b-3374-a234-00f3a670b20f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La rançon', part.name_en = 'La rançon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2480 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:cc0b9853-114b-359f-9835-37ddfff64f7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc0b9853-114b-359f-9835-37ddfff64f7a', 2, NULL, 'La rançon', 'La rançon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2480 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc0b9853-114b-359f-9835-37ddfff64f7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ici-bas !', part.name_en = 'Ici-bas !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2480 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d00ab0ab-4c45-357e-ae0c-51b14cdc96b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d00ab0ab-4c45-357e-ae0c-51b14cdc96b5', 3, NULL, 'Ici-bas !', 'Ici-bas !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2480 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d00ab0ab-4c45-357e-ae0c-51b14cdc96b5'
);


-- Op. 10 2중창 Op. 10

UPDATE pieces piece
SET piece.title = '2중창 Op. 10', piece.title_en = '2 Duets, Op. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '10',
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 995 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 995 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Puisqu''ici-bas toute âme', part.name_en = 'Puisqu''ici-bas toute âme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 995 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:c7f84030-184f-4fdf-9c06-280df534708f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7f84030-184f-4fdf-9c06-280df534708f', 1, NULL, 'Puisqu''ici-bas toute âme', 'Puisqu''ici-bas toute âme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 995 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7f84030-184f-4fdf-9c06-280df534708f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tarentelle', part.name_en = 'Tarentelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 995 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:f20441fc-1c3d-437f-ac69-be4b8c7e9a17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f20441fc-1c3d-437f-ac69-be4b8c7e9a17', 2, NULL, 'Tarentelle', 'Tarentelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 995 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f20441fc-1c3d-437f-ac69-be4b8c7e9a17'
);


-- Op. 11 <장 라신의 찬가>

UPDATE pieces piece
SET piece.title = '<장 라신의 찬가>', piece.title_en = 'Cantique de Jean Racine, Op. 11',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11526 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 11526 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 12 합창곡 <정령들>

UPDATE pieces piece
SET piece.title = '합창곡 <정령들>', piece.title_en = 'Les djinns, Op. 12',
    piece.type = 'song', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1424 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 1424 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 13 바이올린 소나타 1번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 1번 A장조', 'Violin Sonata No. 1 in A major, Op. 13', 'album', 'Op. 13', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 1번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f4a4898-2c4f-408b-b014-07701fb16fff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f4a4898-2c4f-408b-b014-07701fb16fff'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '바이올린 소나타 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f4a4898-2c4f-408b-b014-07701fb16fff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd61ccbd-42ae-323d-b685-845bd2549153', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '바이올린 소나타 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd61ccbd-42ae-323d-b685-845bd2549153'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:472c8c91-7eda-31c3-9911-d6868429cabc', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '바이올린 소나타 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:472c8c91-7eda-31c3-9911-d6868429cabc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cf76fdb-1544-34bb-96f4-0ce075aec60c', 3, 'III', 'Allegro vivo', 'III. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '바이올린 소나타 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cf76fdb-1544-34bb-96f4-0ce075aec60c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b049b95-c1b3-3fad-9680-8b642cb2f36e', 4, 'IV', 'Allegro quasi presto', 'IV. Allegro quasi presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '바이올린 소나타 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b049b95-c1b3-3fad-9680-8b642cb2f36e'
);


-- Op. 14 바이올린 협주곡 D단조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 D단조', piece.title_en = 'Violin Concerto in D minor, Op. 14',
    piece.type = 'song', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1879, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1281 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1879
WHERE piece.id = 1281 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 15 피아노 4중주 1번 C단조

UPDATE pieces piece
SET piece.title = '피아노 4중주 1번 C단조', piece.title_en = 'Piano Quartet No. 1 in C minor, Op. 15',
    piece.type = 'album', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1879, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2705 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1879
WHERE piece.id = 2705 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto moderato', part.name_en = 'I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2705 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:61398312-c046-36a5-94a3-958337e88083' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61398312-c046-36a5-94a3-958337e88083', 1, 'I', 'Allegro molto moderato', 'I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2705 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61398312-c046-36a5-94a3-958337e88083'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Allegro vivo', part.name_en = 'II. Scherzo. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2705 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:682d3f90-c68b-3122-bbad-a3cf159993ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:682d3f90-c68b-3122-bbad-a3cf159993ea', 2, 'II', '스케르초. Allegro vivo', 'II. Scherzo. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2705 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:682d3f90-c68b-3122-bbad-a3cf159993ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2705 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:c4be18b8-8f0b-3bbf-80a4-82e8e628bbee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4be18b8-8f0b-3bbf-80a4-82e8e628bbee', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2705 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4be18b8-8f0b-3bbf-80a4-82e8e628bbee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto', part.name_en = 'IV. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2705 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:176d2dee-e5df-3b4f-9f01-b757f93e69d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:176d2dee-e5df-3b4f-9f01-b757f93e69d4', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2705 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:176d2dee-e5df-3b4f-9f01-b757f93e69d4'
);


-- Op. 16 자장가 D장조

UPDATE pieces piece
SET piece.title = '자장가 D장조', piece.title_en = 'Berceuse in D major, Op. 16',
    piece.type = 'song', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1879, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 549 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1879
WHERE piece.id = 549 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 17 무언가 Op. 17

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무언가 Op. 17', '3 Romances sans paroles, Op. 17', 'album', NULL, 'Op.', '17', 1863, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무언가 Op. 17'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8da1851e-4d0b-4032-9b81-3f6160a309e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8da1851e-4d0b-4032-9b81-3f6160a309e8'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '무언가 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8da1851e-4d0b-4032-9b81-3f6160a309e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5dc4fcf-3fc3-40f9-9798-a3ff22d76e65', 1, NULL, 'A♭장조. Andante quasi allegretto', 'No. 1 in A♭ major. Andante quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '무언가 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5dc4fcf-3fc3-40f9-9798-a3ff22d76e65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25117f63-e434-43d1-8780-b0c1fa1ff1ae', 2, NULL, 'A단조. Allegro molto', 'No. 2 in A minor. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '무언가 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25117f63-e434-43d1-8780-b0c1fa1ff1ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c40d5941-2df1-4e19-9c02-43f02b9e7a1c', 3, NULL, 'A♭장조. Andante moderato', 'No. 3 in A♭ major. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '무언가 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c40d5941-2df1-4e19-9c02-43f02b9e7a1c'
);


-- Op. 18 가곡집 Op. 18

UPDATE pieces piece
SET piece.title = '가곡집 Op. 18', piece.title_en = '3 Songs, Op. 18',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '18',
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 520 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 520 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nell', part.name_en = 'Nell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 520 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:f710bc03-b427-3f12-b960-f2e2fbae7d5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f710bc03-b427-3f12-b960-f2e2fbae7d5e', 1, NULL, 'Nell', 'Nell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 520 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f710bc03-b427-3f12-b960-f2e2fbae7d5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le voyageur', part.name_en = 'Le voyageur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 520 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:4da99dd7-e122-314c-8010-e5f71db4bdb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4da99dd7-e122-314c-8010-e5f71db4bdb4', 2, NULL, 'Le voyageur', 'Le voyageur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 520 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4da99dd7-e122-314c-8010-e5f71db4bdb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Automne', part.name_en = 'Automne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 520 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:94ee6f8c-408c-3eb0-b07b-5462c4bd48ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94ee6f8c-408c-3eb0-b07b-5462c4bd48ef', 3, NULL, 'Automne', 'Automne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 520 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94ee6f8c-408c-3eb0-b07b-5462c4bd48ef'
);


-- Op. 19 발라드 F#장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 F#장조', 'Ballade in F# major, Op. 19', 'song', 'Op. 19', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 F#장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a8cb6e7-0811-31ec-8816-9b7b2a05c915'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a8cb6e7-0811-31ec-8816-9b7b2a05c915'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '발라드 F#장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a8cb6e7-0811-31ec-8816-9b7b2a05c915'
);


-- Op. 20 관현악 모음곡 F장조

UPDATE pieces piece
SET piece.title = '관현악 모음곡 F장조', piece.title_en = 'Suite d''orchestre in F major, Op. 20',
    piece.type = 'song', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1775 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 1775 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 21 연가곡집 <어느 날의 시>

UPDATE pieces piece
SET piece.title = '연가곡집 <어느 날의 시>', piece.title_en = 'Poème d''un jour, Op. 21',
    piece.type = 'album', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1604 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 1604 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rencontre', part.name_en = 'Rencontre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1604 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:4a47adb9-18bd-362a-816d-edd13105b13f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a47adb9-18bd-362a-816d-edd13105b13f', 1, NULL, 'Rencontre', 'Rencontre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1604 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a47adb9-18bd-362a-816d-edd13105b13f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Toujours', part.name_en = 'Toujours',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1604 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:78e6833d-1fe2-3ce8-9fd7-b76a7979d45f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e6833d-1fe2-3ce8-9fd7-b76a7979d45f', 2, NULL, 'Toujours', 'Toujours', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1604 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e6833d-1fe2-3ce8-9fd7-b76a7979d45f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Adieu', part.name_en = 'Adieu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1604 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d9b46ba0-8b9a-37e4-938d-31b158fc3f4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9b46ba0-8b9a-37e4-938d-31b158fc3f4e', 3, NULL, 'Adieu', 'Adieu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1604 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9b46ba0-8b9a-37e4-938d-31b158fc3f4e'
);


-- Op. 22 합창곡 <시냇물>

UPDATE pieces piece
SET piece.title = '합창곡 <시냇물>', piece.title_en = 'Le ruisseau, Op. 22',
    piece.type = 'song', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1944 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 1944 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 23 가곡집 Op. 23

UPDATE pieces piece
SET piece.title = '가곡집 Op. 23', piece.title_en = '3 Songs, Op. 23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '23',
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1880 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 1880 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '요람 (Les berceaux)', part.name_en = 'Les berceaux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1880 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:560a731f-1acd-33f2-b07c-61a99ed79548' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:560a731f-1acd-33f2-b07c-61a99ed79548', 1, NULL, '요람 (Les berceaux)', 'Les berceaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1880 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:560a731f-1acd-33f2-b07c-61a99ed79548'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Notre amour', part.name_en = 'Notre amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1880 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:896bb09f-02c9-3f4e-9abb-75597088af37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:896bb09f-02c9-3f4e-9abb-75597088af37', 2, NULL, 'Notre amour', 'Notre amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1880 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:896bb09f-02c9-3f4e-9abb-75597088af37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le secret', part.name_en = 'Le secret',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1880 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:99ebee5a-d293-31d5-86a0-a517a110a06b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99ebee5a-d293-31d5-86a0-a517a110a06b', 3, NULL, 'Le secret', 'Le secret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1880 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99ebee5a-d293-31d5-86a0-a517a110a06b'
);


-- Op. 24 엘레지 C단조

UPDATE pieces piece
SET piece.title = '엘레지 C단조', piece.title_en = 'Élégie in C minor, Op. 24',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 518 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 518 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 25 즉흥곡 1번 E♭장조

UPDATE pieces piece
SET piece.title = '즉흥곡 1번 E♭장조', piece.title_en = 'Impromptu No. 1 in E♭ major, Op. 25',
    piece.type = 'song', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 911 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 911 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 26 뱃노래 1번 A단조

UPDATE pieces piece
SET piece.title = '뱃노래 1번 A단조', piece.title_en = 'Barcarolle No. 1 in A minor, Op. 26',
    piece.type = 'song', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 519 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 519 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 27 가곡집 Op. 27

UPDATE pieces piece
SET piece.title = '가곡집 Op. 27', piece.title_en = '2 Songs, Op. 27',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '27',
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2030 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 2030 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson d''amour', part.name_en = 'Chanson d''amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2030 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:56063a15-65f0-35d1-9383-a341ecbf577d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56063a15-65f0-35d1-9383-a341ecbf577d', 1, NULL, 'Chanson d''amour', 'Chanson d''amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2030 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56063a15-65f0-35d1-9383-a341ecbf577d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La fée aux chansons', part.name_en = 'La fée aux chansons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2030 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:01357a0d-0e7c-3540-9f26-4039832f7445' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01357a0d-0e7c-3540-9f26-4039832f7445', 2, NULL, 'La fée aux chansons', 'La fée aux chansons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2030 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01357a0d-0e7c-3540-9f26-4039832f7445'
);


-- Op. 28 로망스 B♭장조

UPDATE pieces piece
SET piece.title = '로망스 B♭장조', piece.title_en = 'Romance in B♭ major, Op. 28',
    piece.type = 'song', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 626 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 626 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 29 <비너스의 탄생>

UPDATE pieces piece
SET piece.title = '<비너스의 탄생>', piece.title_en = 'La naissance de Vénus, Op. 29',
    piece.type = 'song', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1157 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 1157 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 30 왈츠 카프리스 1번 A장조

UPDATE pieces piece
SET piece.title = '왈츠 카프리스 1번 A장조', piece.title_en = 'Valse-caprice No. 1 in A major, Op. 30',
    piece.type = 'song', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 570 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 570 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 31 즉흥곡 2번 F단조

UPDATE pieces piece
SET piece.title = '즉흥곡 2번 F단조', piece.title_en = 'Impromptu No. 2 in F minor, Op. 31',
    piece.type = 'song', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1566 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 1566 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 32 마주르카 B♭장조

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '32'
WHERE piece.id = 473 AND piece.composer_id = 47
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 473 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 33 녹턴 Op. 33

UPDATE pieces piece
SET piece.title = '녹턴 Op. 33', piece.title_en = '3 Nocturnes, Op. 33',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '33',
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2399 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 2399 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '녹턴 1번 E♭단조', part.name_en = 'Nocturne No. 1 in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2399 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:fab25ebc-c4b0-383b-833b-72bd7797edc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fab25ebc-c4b0-383b-833b-72bd7797edc1', 1, NULL, '녹턴 1번 E♭단조', 'Nocturne No. 1 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2399 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fab25ebc-c4b0-383b-833b-72bd7797edc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '녹턴 2번 B장조', part.name_en = 'Nocturne No. 2 in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2399 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:b7e79cf2-1445-346c-98a9-da143d0ef94a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7e79cf2-1445-346c-98a9-da143d0ef94a', 2, NULL, '녹턴 2번 B장조', 'Nocturne No. 2 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2399 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7e79cf2-1445-346c-98a9-da143d0ef94a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '녹턴 3번 A♭장조', part.name_en = 'Nocturne No. 3 in A♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2399 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:c82ea9e9-8802-3c87-a181-af6fbaca9638' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c82ea9e9-8802-3c87-a181-af6fbaca9638', 3, NULL, '녹턴 3번 A♭장조', 'Nocturne No. 3 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2399 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c82ea9e9-8802-3c87-a181-af6fbaca9638'
);


-- Op. 34 즉흥곡 3번 A♭장조

UPDATE pieces piece
SET piece.title = '즉흥곡 3번 A♭장조', piece.title_en = 'Impromptu No. 3 in A♭ major, Op. 34',
    piece.type = 'song', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1032 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 1032 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 35 <마드리갈>

UPDATE pieces piece
SET piece.title = '<마드리갈>', piece.title_en = 'Madrigal, Op. 35',
    piece.type = 'song', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1223 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 1223 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 36 녹턴 4번 E♭장조

UPDATE pieces piece
SET piece.title = '녹턴 4번 E♭장조', piece.title_en = 'Nocturne No. 4 in E♭ major, Op. 36',
    piece.type = 'song', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2279 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 2279 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 37 녹턴 5번 B♭장조

UPDATE pieces piece
SET piece.title = '녹턴 5번 B♭장조', piece.title_en = 'Nocturne No. 5 in B♭ major, Op. 37',
    piece.type = 'song', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1957 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 1957 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 38 왈츠 카프리스 2번 D♭장조

UPDATE pieces piece
SET piece.title = '왈츠 카프리스 2번 D♭장조', piece.title_en = 'Valse-caprice No. 2 in D♭ major, Op. 38',
    piece.type = 'song', piece.opus_number = 'Op. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 671 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 671 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 39 가곡집 Op. 39

UPDATE pieces piece
SET piece.title = '가곡집 Op. 39', piece.title_en = '4 Songs, Op. 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2754 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 2754 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Aurore', part.name_en = 'Aurore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2754 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:b77b40cc-dbd1-3ad4-8405-6eacef58e368' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b77b40cc-dbd1-3ad4-8405-6eacef58e368', 1, NULL, 'Aurore', 'Aurore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2754 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b77b40cc-dbd1-3ad4-8405-6eacef58e368'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fleur jetée', part.name_en = 'Fleur jetée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2754 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:f577c7cf-56da-3ca4-aec7-f13a03f07c1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f577c7cf-56da-3ca4-aec7-f13a03f07c1a', 2, NULL, 'Fleur jetée', 'Fleur jetée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2754 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f577c7cf-56da-3ca4-aec7-f13a03f07c1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le pays des rêves', part.name_en = 'Le pays des rêves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2754 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:dfd62f48-0708-35e5-b087-aaf3b70c62b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfd62f48-0708-35e5-b087-aaf3b70c62b8', 3, NULL, 'Le pays des rêves', 'Le pays des rêves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2754 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfd62f48-0708-35e5-b087-aaf3b70c62b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '이스파한의 장미 (Les roses d''Ispahan)', part.name_en = 'Les roses d''Ispahan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2754 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:245e704a-06fb-31fe-8f75-20ce4d0f388b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:245e704a-06fb-31fe-8f75-20ce4d0f388b', 4, NULL, '이스파한의 장미 (Les roses d''Ispahan)', 'Les roses d''Ispahan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2754 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:245e704a-06fb-31fe-8f75-20ce4d0f388b'
);


-- Op. 41 뱃노래 2번 G장조

UPDATE pieces piece
SET piece.title = '뱃노래 2번 G장조', piece.title_en = 'Barcarolle No. 2 in G major, Op. 41',
    piece.type = 'song', piece.opus_number = 'Op. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 595 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 595 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 42 뱃노래 3번 G♭장조

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '42'
WHERE piece.id = 469 AND piece.composer_id = 47
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 469 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 43 가곡집 Op. 43

UPDATE pieces piece
SET piece.title = '가곡집 Op. 43', piece.title_en = '2 Songs, Op. 43',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '43',
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2764 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 2764 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Noël', part.name_en = 'Noël',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2764 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:49c03bc6-dd21-4116-81f5-be54e9a660f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49c03bc6-dd21-4116-81f5-be54e9a660f8', 1, NULL, 'Noël', 'Noël', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2764 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49c03bc6-dd21-4116-81f5-be54e9a660f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nocturne', part.name_en = 'Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2764 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:18273ff4-2304-3e7d-9e37-4d49269e7d42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18273ff4-2304-3e7d-9e37-4d49269e7d42', 2, NULL, 'Nocturne', 'Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2764 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18273ff4-2304-3e7d-9e37-4d49269e7d42'
);


-- Op. 44 뱃노래 4번 A♭장조

UPDATE pieces piece
SET piece.title = '뱃노래 4번 A♭장조', piece.title_en = 'Barcarolle No. 4 in A♭ major, Op. 44',
    piece.type = 'song', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 502 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 502 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 45 피아노 4중주 2번 G단조

UPDATE pieces piece
SET piece.title = '피아노 4중주 2번 G단조', piece.title_en = 'Piano Quartet No. 2 in G minor, Op. 45',
    piece.type = 'album', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1504 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 1504 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto moderato', part.name_en = 'I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1504 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:14107641-bc3a-31d7-aae0-3704bb9c2f94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14107641-bc3a-31d7-aae0-3704bb9c2f94', 1, 'I', 'Allegro molto moderato', 'I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1504 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14107641-bc3a-31d7-aae0-3704bb9c2f94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro molto', part.name_en = 'II. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1504 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:963f1070-acdb-399b-bf4c-5f389d83dab4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:963f1070-acdb-399b-bf4c-5f389d83dab4', 2, 'II', 'Allegro molto', 'II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1504 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:963f1070-acdb-399b-bf4c-5f389d83dab4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio non troppo', part.name_en = 'III. Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1504 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:76c40660-0ed2-3aab-9c57-05bb9ef8d0d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76c40660-0ed2-3aab-9c57-05bb9ef8d0d6', 3, 'III', 'Adagio non troppo', 'III. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1504 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76c40660-0ed2-3aab-9c57-05bb9ef8d0d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto', part.name_en = 'IV. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1504 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:c8b8af12-79d1-3a3f-9f2a-bfe5aca73c8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8b8af12-79d1-3a3f-9f2a-bfe5aca73c8c', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1504 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8b8af12-79d1-3a3f-9f2a-bfe5aca73c8c'
);


-- Op. 46 가곡집 Op. 46

UPDATE pieces piece
SET piece.title = '가곡집 Op. 46', piece.title_en = '2 Songs, Op. 46',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '46',
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1106 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 1106 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Les présents', part.name_en = 'Les présents',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1106 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:33c0c72f-2e91-3177-a464-cfa813f2b40d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33c0c72f-2e91-3177-a464-cfa813f2b40d', 1, NULL, 'Les présents', 'Les présents', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1106 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33c0c72f-2e91-3177-a464-cfa813f2b40d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '달빛 (Clair de lune)', part.name_en = 'Clair de lune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1106 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:bc9b63b9-8922-334f-8243-fa0b2e8c299c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc9b63b9-8922-334f-8243-fa0b2e8c299c', 2, NULL, '달빛 (Clair de lune)', 'Clair de lune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1106 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc9b63b9-8922-334f-8243-fa0b2e8c299c'
);


-- Op. 47 모테트 Op. 47

UPDATE pieces piece
SET piece.title = '모테트 Op. 47', piece.title_en = '2 Motets, Op. 47',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '47',
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2736 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 2736 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O salutaris', part.name_en = 'O salutaris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2736 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:4707df1a-6bf1-4fb1-a527-de4204c311f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4707df1a-6bf1-4fb1-a527-de4204c311f3', 1, NULL, 'O salutaris', 'O salutaris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2736 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4707df1a-6bf1-4fb1-a527-de4204c311f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Maria, Mater gratiae', part.name_en = 'Maria, Mater gratiae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2736 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:8a4ab2c6-8a2d-4bc0-b079-57834a6a07ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a4ab2c6-8a2d-4bc0-b079-57834a6a07ff', 2, NULL, 'Maria, Mater gratiae', 'Maria, Mater gratiae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2736 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a4ab2c6-8a2d-4bc0-b079-57834a6a07ff'
);


-- Op. 48 레퀴엠

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '입당송과 키리에', part.name_en = 'I. Introït et Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 206 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:5dc84793-73a0-4a7e-aea5-1477e87a3a83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dc84793-73a0-4a7e-aea5-1477e87a3a83', 1, 'I', '입당송과 키리에', 'I. Introït et Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 206 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dc84793-73a0-4a7e-aea5-1477e87a3a83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '봉헌송', part.name_en = 'II. Offertoire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 206 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a4278a54-85e4-4e68-9602-922175c32b69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4278a54-85e4-4e68-9602-922175c32b69', 2, 'II', '봉헌송', 'II. Offertoire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 206 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4278a54-85e4-4e68-9602-922175c32b69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '상투스', part.name_en = 'III. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 206 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:11a0245a-8f8d-483a-9189-1e269912e2d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11a0245a-8f8d-483a-9189-1e269912e2d2', 3, 'III', '상투스', 'III. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 206 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11a0245a-8f8d-483a-9189-1e269912e2d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 984 AND linked.composer_id = 47),
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Pie Jesu', part.name_en = 'IV. Pie Jesu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 206 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a8823600-1f8e-4e30-abd3-8762c22c5c48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 984 AND linked.composer_id = 47), 'musicbrainz:a8823600-1f8e-4e30-abd3-8762c22c5c48', 4, 'IV', 'Pie Jesu', 'IV. Pie Jesu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 206 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8823600-1f8e-4e30-abd3-8762c22c5c48'
);

UPDATE pieces piece
SET piece.title = '레퀴엠 중 "Pie Jesu"', piece.title_en = 'Requiem in D minor, Op. 48: IV. Pie Jesu', piece.editor_locked = 1
WHERE piece.id = 984 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '아뉴스 데이', part.name_en = 'V. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 206 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:63022b11-d1cd-4f9f-b31f-9606b772fadb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63022b11-d1cd-4f9f-b31f-9606b772fadb', 5, 'V', '아뉴스 데이', 'V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 206 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63022b11-d1cd-4f9f-b31f-9606b772fadb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2134 AND linked.composer_id = 47),
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Libera me', part.name_en = 'VI. Libera me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 206 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:40140254-2604-4818-a312-769eb0a04153' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2134 AND linked.composer_id = 47), 'musicbrainz:40140254-2604-4818-a312-769eb0a04153', 6, 'VI', 'Libera me', 'VI. Libera me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 206 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40140254-2604-4818-a312-769eb0a04153'
);

UPDATE pieces piece
SET piece.title = '레퀴엠 중 "Libera me"', piece.title_en = 'Requiem in D minor, Op. 48: VI. Libera me', piece.editor_locked = 1
WHERE piece.id = 2134 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'In paradisum', part.name_en = 'VII. In paradisum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 206 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:10de0398-f05e-4f0c-aa16-8fcdbaa1d1eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10de0398-f05e-4f0c-aa16-8fcdbaa1d1eb', 7, 'VII', 'In paradisum', 'VII. In paradisum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 206 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10de0398-f05e-4f0c-aa16-8fcdbaa1d1eb'
);


-- Op. 51 가곡집 Op. 51

UPDATE pieces piece
SET piece.title = '가곡집 Op. 51', piece.title_en = '4 Songs, Op. 51',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '51',
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1765 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 1765 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Larmes', part.name_en = 'Larmes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1765 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:5819f7de-6219-370e-9958-6d59361bd5b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5819f7de-6219-370e-9958-6d59361bd5b1', 1, NULL, 'Larmes', 'Larmes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1765 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5819f7de-6219-370e-9958-6d59361bd5b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Au cimetière', part.name_en = 'Au cimetière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1765 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:8ce0f7a1-824f-3420-8bf1-f897c0661984' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ce0f7a1-824f-3420-8bf1-f897c0661984', 2, NULL, 'Au cimetière', 'Au cimetière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1765 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ce0f7a1-824f-3420-8bf1-f897c0661984'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Spleen', part.name_en = 'Spleen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1765 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d900c11a-a728-380e-921a-fa4deff63fa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d900c11a-a728-380e-921a-fa4deff63fa1', 3, NULL, 'Spleen', 'Spleen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1765 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d900c11a-a728-380e-921a-fa4deff63fa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La rose', part.name_en = 'La rose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1765 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:4d4e4202-78c7-37f2-91fc-fda8fe550891' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d4e4202-78c7-37f2-91fc-fda8fe550891', 4, NULL, 'La rose', 'La rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1765 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d4e4202-78c7-37f2-91fc-fda8fe550891'
);


-- Op. 52 부수음악 <칼리굴라>

UPDATE pieces piece
SET piece.title = '부수음악 <칼리굴라>', piece.title_en = 'Caligula, Op. 52',
    piece.type = 'album', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2839 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 2839 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '프롤로그. 팡파르 – 행진곡과 합창', part.name_en = 'I. Prologue. Fanfares – Marche et chœur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2839 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:6d73e2b3-9f84-409d-9109-12e415b05fc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d73e2b3-9f84-409d-9109-12e415b05fc0', 1, 'I', '프롤로그. 팡파르 – 행진곡과 합창', 'I. Prologue. Fanfares – Marche et chœur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2839 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d73e2b3-9f84-409d-9109-12e415b05fc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'L''hiver s''enfuit', part.name_en = 'II. L''hiver s''enfuit (chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2839 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:21f5712a-19c6-4a8b-a7c0-1b87479e0e82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21f5712a-19c6-4a8b-a7c0-1b87479e0e82', 2, 'II', 'L''hiver s''enfuit', 'II. L''hiver s''enfuit (chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2839 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f5712a-19c6-4a8b-a7c0-1b87479e0e82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '춤곡', part.name_en = 'III. Air de danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2839 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:68234905-dd62-4a0b-add7-6625709a9cc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68234905-dd62-4a0b-add7-6625709a9cc3', 3, 'III', '춤곡', 'III. Air de danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2839 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68234905-dd62-4a0b-add7-6625709a9cc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'De roses vermeilles', part.name_en = 'IV. De roses vermeilles (mélodrame et chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2839 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:f7b70b51-1f87-471a-a174-352e8b90c902' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7b70b51-1f87-471a-a174-352e8b90c902', 4, 'IV', 'De roses vermeilles', 'IV. De roses vermeilles (mélodrame et chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2839 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7b70b51-1f87-471a-a174-352e8b90c902'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'César a fermé la paupière', part.name_en = 'V. César a fermé la paupière (mélodrame et chœur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2839 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:ef6ad5fc-2eb1-4f8b-afd2-f6373899ce41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef6ad5fc-2eb1-4f8b-afd2-f6373899ce41', 5, 'V', 'César a fermé la paupière', 'V. César a fermé la paupière (mélodrame et chœur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2839 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef6ad5fc-2eb1-4f8b-afd2-f6373899ce41'
);


-- Op. 54 모테트 <Ecce fidelis servus>

UPDATE pieces piece
SET piece.title = '모테트 <Ecce fidelis servus>', piece.title_en = 'Ecce fidelis servus, Op. 54',
    piece.type = 'song', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1286 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 1286 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 55 모테트 <Tantum ergo> A장조

UPDATE pieces piece
SET piece.title = '모테트 <Tantum ergo> A장조', piece.title_en = 'Tantum ergo in A major, Op. 55',
    piece.type = 'song', piece.opus_number = 'Op. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1950 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 1950 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 56 피아노 연탄 모음곡 <돌리>

UPDATE pieces piece
SET piece.title = '피아노 연탄 모음곡 <돌리>', piece.title_en = 'Dolly, Op. 56',
    piece.type = 'album', piece.opus_number = 'Op. 56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1897, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 578 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1897
WHERE piece.id = 578 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '자장가', part.name_en = 'Berceuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 578 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:ccdfb106-b69a-4168-9b0a-b874f0a28cdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccdfb106-b69a-4168-9b0a-b874f0a28cdb', 1, NULL, '자장가', 'Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 578 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccdfb106-b69a-4168-9b0a-b874f0a28cdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mi-a-ou', part.name_en = 'Mi-a-ou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 578 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:098b350b-b4ac-4138-b71b-535269a747d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:098b350b-b4ac-4138-b71b-535269a747d0', 2, NULL, 'Mi-a-ou', 'Mi-a-ou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 578 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:098b350b-b4ac-4138-b71b-535269a747d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le jardin de Dolly', part.name_en = 'Le jardin de Dolly',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 578 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:8303e886-cabf-4019-937d-b29a75a71ca5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8303e886-cabf-4019-937d-b29a75a71ca5', 3, NULL, 'Le jardin de Dolly', 'Le jardin de Dolly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 578 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8303e886-cabf-4019-937d-b29a75a71ca5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Kitty-valse', part.name_en = 'Kitty-valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 578 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:3981d186-a188-4815-9a43-eddda33a5113' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3981d186-a188-4815-9a43-eddda33a5113', 4, NULL, 'Kitty-valse', 'Kitty-valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 578 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3981d186-a188-4815-9a43-eddda33a5113'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tendresse', part.name_en = 'Tendresse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 578 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:7a045bab-485b-4229-aa5c-b15899be8a22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a045bab-485b-4229-aa5c-b15899be8a22', 5, NULL, 'Tendresse', 'Tendresse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 578 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a045bab-485b-4229-aa5c-b15899be8a22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le pas espagnol', part.name_en = 'Le pas espagnol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 578 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:148282b7-26ee-4848-a4d1-b64cbf42d3d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:148282b7-26ee-4848-a4d1-b64cbf42d3d4', 6, NULL, 'Le pas espagnol', 'Le pas espagnol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 578 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:148282b7-26ee-4848-a4d1-b64cbf42d3d4'
);


-- Op. 57 모음곡 <샤일록>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 <샤일록>', 'Shylock, Op. 57', 'album', 'Op. 57', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 <샤일록>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '033e6a17-c8d4-45af-a721-8483e0cc4053'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '033e6a17-c8d4-45af-a721-8483e0cc4053'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <샤일록>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '033e6a17-c8d4-45af-a721-8483e0cc4053'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98d2f616-ff67-43be-a778-667d1077b0a3', 1, 'I', '샹송', 'I. Chanson', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <샤일록>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98d2f616-ff67-43be-a778-667d1077b0a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85bc5b11-07be-4019-8dec-1ed576835b95', 2, 'II', '간주곡', 'II. Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <샤일록>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85bc5b11-07be-4019-8dec-1ed576835b95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25fc6dd1-88ec-4e11-aa22-df16f46cfe7d', 3, 'III', '마드리갈', 'III. Madrigal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <샤일록>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25fc6dd1-88ec-4e11-aa22-df16f46cfe7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2fb00dc-7d9a-433d-86cf-cfcd44a78dcb', 4, 'IV', '축혼가', 'IV. Épithalame', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <샤일록>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2fb00dc-7d9a-433d-86cf-cfcd44a78dcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d76ba77-0cd0-4c32-a8f1-30251eb53d88', 5, 'V', '녹턴', 'V. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <샤일록>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d76ba77-0cd0-4c32-a8f1-30251eb53d88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d799b31c-ab6e-47dc-9c08-6e0c5ba89aee', 6, 'VI', '피날레', 'VI. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <샤일록>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d799b31c-ab6e-47dc-9c08-6e0c5ba89aee'
);


-- Op. 58 가곡집 <베네치아의 5개의 가곡>

UPDATE pieces piece
SET piece.title = '가곡집 <베네치아의 5개의 가곡>', piece.title_en = 'Cinq mélodies "de Venise", Op. 58',
    piece.type = 'album', piece.opus_number = 'Op. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1732 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 1732 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mandoline', part.name_en = 'Mandoline',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1732 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:9411de7b-8e49-37a4-853f-6a773f654930' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9411de7b-8e49-37a4-853f-6a773f654930', 1, NULL, 'Mandoline', 'Mandoline', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1732 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9411de7b-8e49-37a4-853f-6a773f654930'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'En sourdine', part.name_en = 'En sourdine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1732 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:9f02dd6a-2a83-34aa-91ee-9ad852359569' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f02dd6a-2a83-34aa-91ee-9ad852359569', 2, NULL, 'En sourdine', 'En sourdine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1732 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f02dd6a-2a83-34aa-91ee-9ad852359569'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Green', part.name_en = 'Green',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1732 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:112c8069-3a0a-3de0-aa5a-46c3aa415c41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:112c8069-3a0a-3de0-aa5a-46c3aa415c41', 3, NULL, 'Green', 'Green', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1732 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:112c8069-3a0a-3de0-aa5a-46c3aa415c41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'À Clymène', part.name_en = 'À Clymène',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1732 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:c97e8156-879c-3d67-a6e6-29ada013b235' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c97e8156-879c-3d67-a6e6-29ada013b235', 4, NULL, 'À Clymène', 'À Clymène', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1732 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c97e8156-879c-3d67-a6e6-29ada013b235'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'C''est l''extase', part.name_en = 'C''est l''extase',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1732 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:8d50e954-09ec-3ca8-94a5-41ba52bd0205' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d50e954-09ec-3ca8-94a5-41ba52bd0205', 5, NULL, 'C''est l''extase', 'C''est l''extase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1732 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d50e954-09ec-3ca8-94a5-41ba52bd0205'
);


-- Op. 59 왈츠 카프리스 3번 G♭장조

UPDATE pieces piece
SET piece.title = '왈츠 카프리스 3번 G♭장조', piece.title_en = 'Valse-caprice No. 3 in G♭ major, Op. 59',
    piece.type = 'song', piece.opus_number = 'Op. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 628 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 628 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 61 연가곡집 <좋은 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <좋은 노래>', 'La bonne chanson, Op. 61', 'album', 'Op. 61', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <좋은 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2ff2d16-5bbd-4ad1-8251-f8ab1376567f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2ff2d16-5bbd-4ad1-8251-f8ab1376567f'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2ff2d16-5bbd-4ad1-8251-f8ab1376567f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d1f1625-6c4d-332a-9ad0-373a96942a21', 1, NULL, 'Une sainte en son auréole', 'Une sainte en son auréole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d1f1625-6c4d-332a-9ad0-373a96942a21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68456a03-382b-352d-a8ef-8fccce21b633', 2, NULL, 'Puisque l''aube grandit', 'Puisque l''aube grandit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68456a03-382b-352d-a8ef-8fccce21b633'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd3eb38d-ca37-3171-b0a0-c4bbb6e91438', 3, NULL, 'La lune blanche luit dans les bois', 'La lune blanche luit dans les bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd3eb38d-ca37-3171-b0a0-c4bbb6e91438'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2adc047-5d15-32a3-8d74-9e22214cead1', 4, NULL, 'J''allais par des chemins perfides', 'J''allais par des chemins perfides', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2adc047-5d15-32a3-8d74-9e22214cead1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd79d8ff-d512-38dd-9c44-03bd73d713e5', 5, NULL, 'J''ai presque peur, en vérité', 'J''ai presque peur, en vérité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd79d8ff-d512-38dd-9c44-03bd73d713e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1faa12e6-6f20-35cb-9c1d-0e9bcaaeea48', 6, NULL, 'Avant que tu ne t''en ailles', 'Avant que tu ne t''en ailles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1faa12e6-6f20-35cb-9c1d-0e9bcaaeea48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee5c22a-2a61-397a-8926-2db9953de9c9', 7, NULL, 'Donc, ce sera par un clair jour d''été', 'Donc, ce sera par un clair jour d''été', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee5c22a-2a61-397a-8926-2db9953de9c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aaabf37a-8ca2-3dc8-8700-a38e6a075e8e', 8, NULL, 'N''est-ce pas ?', 'N''est-ce pas ?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaabf37a-8ca2-3dc8-8700-a38e6a075e8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4841e2f1-38e0-3e84-a800-e60dfaf837e2', 9, NULL, 'L''hiver a cessé', 'L''hiver a cessé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '연가곡집 <좋은 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4841e2f1-38e0-3e84-a800-e60dfaf837e2'
);


-- Op. 62 왈츠 카프리스 4번 A♭장조

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '62'
WHERE piece.id = 482 AND piece.composer_id = 47
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 482 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 63 녹턴 6번 D♭장조

UPDATE pieces piece
SET piece.title = '녹턴 6번 D♭장조', piece.title_en = 'Nocturne No. 6 in D♭ major, Op. 63',
    piece.type = 'song', piece.opus_number = 'Op. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1023 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 1023 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 65 모테트 Op. 65

UPDATE pieces piece
SET piece.title = '모테트 Op. 65', piece.title_en = '2 Motets, Op. 65',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '65',
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2607 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 2607 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ave verum corpus', part.name_en = 'Ave verum corpus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2607 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:46278e1f-f266-4373-9770-9ce70b8d9102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46278e1f-f266-4373-9770-9ce70b8d9102', 1, NULL, 'Ave verum corpus', 'Ave verum corpus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2607 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46278e1f-f266-4373-9770-9ce70b8d9102'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tantum ergo', part.name_en = 'Tantum ergo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2607 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a68a954c-7949-48a5-8362-249e7d542ef9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a68a954c-7949-48a5-8362-249e7d542ef9', 2, NULL, 'Tantum ergo', 'Tantum ergo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2607 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a68a954c-7949-48a5-8362-249e7d542ef9'
);


-- Op. 66 뱃노래 5번 F#단조

UPDATE pieces piece
SET piece.title = '뱃노래 5번 F#단조', piece.title_en = 'Barcarolle No. 5 in F# minor, Op. 66',
    piece.type = 'song', piece.opus_number = 'Op. 66',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 583 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 583 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 67 모테트 Op. 67

UPDATE pieces piece
SET piece.title = '모테트 Op. 67', piece.title_en = '2 Motets, Op. 67',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '67',
    piece.composition_year = COALESCE(1895, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 842 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1895
WHERE piece.id = 842 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Salve Regina', part.name_en = 'Salve Regina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 842 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d6fc71ea-48b3-4f98-b8b6-7a2feea8ce6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6fc71ea-48b3-4f98-b8b6-7a2feea8ce6f', 1, NULL, 'Salve Regina', 'Salve Regina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 842 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6fc71ea-48b3-4f98-b8b6-7a2feea8ce6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ave Maria', part.name_en = 'Ave Maria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 842 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:e5f66533-3396-4a83-bc73-c15432166144' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5f66533-3396-4a83-bc73-c15432166144', 2, NULL, 'Ave Maria', 'Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 842 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5f66533-3396-4a83-bc73-c15432166144'
);


-- Op. 69 로망스 A장조

UPDATE pieces piece
SET piece.title = '로망스 A장조', piece.title_en = 'Romance in A major, Op. 69',
    piece.type = 'song', piece.opus_number = 'Op. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2854 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 2854 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 70 뱃노래 6번 E♭장조

UPDATE pieces piece
SET piece.title = '뱃노래 6번 E♭장조', piece.title_en = 'Barcarolle No. 6 in E♭ major, Op. 70',
    piece.type = 'song', piece.opus_number = 'Op. 70',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1895, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 527 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1895
WHERE piece.id = 527 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 72 2중창 <황금의 눈물>

UPDATE pieces piece
SET piece.title = '2중창 <황금의 눈물>', piece.title_en = 'Pleurs d''or, Op. 72',
    piece.type = 'song', piece.opus_number = 'Op. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 541 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 541 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 73 주제와 변주 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '주제와 변주 C#단조', 'Thème et variations in C# minor, Op. 73', 'song', 'Op. 73', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '주제와 변주 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b5d75eb-1692-41e1-9c42-7ae6d08cf10d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b5d75eb-1692-41e1-9c42-7ae6d08cf10d'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '주제와 변주 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b5d75eb-1692-41e1-9c42-7ae6d08cf10d'
);


-- Op. 74 녹턴 7번 C#단조

UPDATE pieces piece
SET piece.title = '녹턴 7번 C#단조', piece.title_en = 'Nocturne No. 7 in C# minor, Op. 74',
    piece.type = 'song', piece.opus_number = 'Op. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1305 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 1305 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 75 안단테 B♭장조

UPDATE pieces piece
SET piece.title = '안단테 B♭장조', piece.title_en = 'Andante in B♭ major, Op. 75',
    piece.type = 'song', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1897, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 675 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1897
WHERE piece.id = 675 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 76 가곡집 Op. 76

UPDATE pieces piece
SET piece.title = '가곡집 Op. 76', piece.title_en = '2 Songs, Op. 76',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '76',
    piece.composition_year = COALESCE(1897, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 943 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1897
WHERE piece.id = 943 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le parfum impérissable', part.name_en = 'Le parfum impérissable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 943 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:694394ef-a44c-3497-84d4-42d9b650ed37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:694394ef-a44c-3497-84d4-42d9b650ed37', 1, NULL, 'Le parfum impérissable', 'Le parfum impérissable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 943 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:694394ef-a44c-3497-84d4-42d9b650ed37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Arpège', part.name_en = 'Arpège',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 943 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:35fd0490-1b69-3797-9c52-ad58b7c01495' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35fd0490-1b69-3797-9c52-ad58b7c01495', 2, NULL, 'Arpège', 'Arpège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 943 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35fd0490-1b69-3797-9c52-ad58b7c01495'
);


-- Op. 77 <나비>

UPDATE pieces piece
SET piece.title = '<나비>', piece.title_en = 'Papillon, Op. 77',
    piece.type = 'song', piece.opus_number = 'Op. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2443 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 2443 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 79 플루트와 피아노를 위한 환상곡

UPDATE pieces piece
SET piece.title = '플루트와 피아노를 위한 환상곡', piece.title_en = 'Fantaisie for flute and piano, Op. 79',
    piece.type = 'album', piece.opus_number = 'Op. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 591 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 591 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = 'I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 591 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:22293625-0cb1-48c5-9494-ccf67ccdb45a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22293625-0cb1-48c5-9494-ccf67ccdb45a', 1, 'I', 'Andantino', 'I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 591 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22293625-0cb1-48c5-9494-ccf67ccdb45a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 591 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:e64ee580-2f51-4799-ae8b-3d9534ea7dfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e64ee580-2f51-4799-ae8b-3d9534ea7dfe', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 591 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e64ee580-2f51-4799-ae8b-3d9534ea7dfe'
);


-- Op. 80 모음곡 <펠레아스와 멜리장드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 <펠레아스와 멜리장드>', 'Pelléas et Mélisande, Op. 80', 'album', 'Op. 80', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 <펠레아스와 멜리장드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74bcefb4-8140-458a-a46d-b14c3bdf435e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74bcefb4-8140-458a-a46d-b14c3bdf435e'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74bcefb4-8140-458a-a46d-b14c3bdf435e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d0cdc58-acf7-4ec0-8c60-e2bb0a257f4e', 1, 'I', '전주곡. Quasi adagio', 'I. Prélude. Quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d0cdc58-acf7-4ec0-8c60-e2bb0a257f4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7b5a1d5-2c9a-4088-b012-8f2884fc8aad', 2, 'II', '물레 잣는 여인. Andantino quasi allegretto', 'II. Fileuse. Andantino quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7b5a1d5-2c9a-4088-b012-8f2884fc8aad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95aa3938-16c6-4250-89ef-6728270c2db1', 3, 'III', '시칠리엔. Allegro molto moderato', 'III. Sicilienne. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95aa3938-16c6-4250-89ef-6728270c2db1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecbbc968-45e4-42cd-be7f-6b92a381c733', 4, 'IV', '멜리장드의 죽음. Molto adagio', 'IV. La mort de Mélisande. Molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecbbc968-45e4-42cd-be7f-6b92a381c733'
);


-- Op. 82 서정 비극 <프로메테>

UPDATE pieces piece
SET piece.title = '서정 비극 <프로메테>', piece.title_en = 'Prométhée, Op. 82',
    piece.type = 'song', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1185 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 1185 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 83 가곡집 Op. 83

UPDATE pieces piece
SET piece.title = '가곡집 Op. 83', piece.title_en = '2 Songs, Op. 83',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '83',
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2894 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 2894 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prison', part.name_en = 'Prison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2894 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:2217eaf1-6008-3559-bb02-0022c8da3e7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2217eaf1-6008-3559-bb02-0022c8da3e7f', 1, NULL, 'Prison', 'Prison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2894 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2217eaf1-6008-3559-bb02-0022c8da3e7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Soir', part.name_en = 'Soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2894 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d312652c-bfa1-30e5-8969-cf670e815557' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d312652c-bfa1-30e5-8969-cf670e815557', 2, NULL, 'Soir', 'Soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2894 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d312652c-bfa1-30e5-8969-cf670e815557'
);


-- Op. 84 <8개의 짧은 소품>

UPDATE pieces piece
SET piece.title = '<8개의 짧은 소품>', piece.title_en = '8 Pièces brèves, Op. 84',
    piece.type = 'album', piece.opus_number = 'Op. 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1574 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 1574 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '카프리치오 E♭장조', part.name_en = 'Capriccio in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1574 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:9713e7c4-a918-45fb-a445-3f959047c475' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9713e7c4-a918-45fb-a445-3f959047c475', 1, NULL, '카프리치오 E♭장조', 'Capriccio in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1574 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9713e7c4-a918-45fb-a445-3f959047c475'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '환상곡 A♭장조', part.name_en = 'Fantaisie in A♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1574 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:fd195be9-7352-4aab-846b-2ef5da22c673' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd195be9-7352-4aab-846b-2ef5da22c673', 2, NULL, '환상곡 A♭장조', 'Fantaisie in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1574 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd195be9-7352-4aab-846b-2ef5da22c673'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '푸가 A단조', part.name_en = 'Fugue in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1574 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:f7d3db99-cfc5-4fc6-8da4-8ab00dea1f54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7d3db99-cfc5-4fc6-8da4-8ab00dea1f54', 3, NULL, '푸가 A단조', 'Fugue in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1574 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7d3db99-cfc5-4fc6-8da4-8ab00dea1f54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Adagietto E단조', part.name_en = 'Adagietto in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1574 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:b23ea204-672d-42f7-bd5d-27562f39a674' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b23ea204-672d-42f7-bd5d-27562f39a674', 4, NULL, 'Adagietto E단조', 'Adagietto in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1574 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b23ea204-672d-42f7-bd5d-27562f39a674'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Improvisation C#단조', part.name_en = 'Improvisation in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1574 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:8663da88-5506-4f1e-9644-6c88b8b2d101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8663da88-5506-4f1e-9644-6c88b8b2d101', 5, NULL, 'Improvisation C#단조', 'Improvisation in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1574 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8663da88-5506-4f1e-9644-6c88b8b2d101'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '푸가 E단조', part.name_en = 'Fugue in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1574 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:585bc50f-6712-4337-97f3-09671f1ca5e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:585bc50f-6712-4337-97f3-09671f1ca5e2', 6, NULL, '푸가 E단조', 'Fugue in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1574 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:585bc50f-6712-4337-97f3-09671f1ca5e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Allégresse C장조', part.name_en = 'Allégresse in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1574 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:9faaf265-2eb6-466a-aa1a-0a2fd3d46ae8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9faaf265-2eb6-466a-aa1a-0a2fd3d46ae8', 7, NULL, 'Allégresse C장조', 'Allégresse in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1574 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9faaf265-2eb6-466a-aa1a-0a2fd3d46ae8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '녹턴 8번 D♭장조', part.name_en = 'Nocturne No. 8 in D♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1574 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:9e22fb44-bad2-386f-9f73-894d47d87dd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e22fb44-bad2-386f-9f73-894d47d87dd3', 8, NULL, '녹턴 8번 D♭장조', 'Nocturne No. 8 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1574 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e22fb44-bad2-386f-9f73-894d47d87dd3'
);


-- Op. 85 가곡집 Op. 85

UPDATE pieces piece
SET piece.title = '가곡집 Op. 85', piece.title_en = '3 Songs, Op. 85',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '85',
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2471 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 2471 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dans la forêt de septembre', part.name_en = 'Dans la forêt de septembre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2471 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:cdeb468f-18b4-3930-9500-143c2894c76d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdeb468f-18b4-3930-9500-143c2894c76d', 1, NULL, 'Dans la forêt de septembre', 'Dans la forêt de septembre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2471 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdeb468f-18b4-3930-9500-143c2894c76d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La fleur qui va sur l''eau', part.name_en = 'La fleur qui va sur l''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2471 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:f377bd11-f71d-3067-bb1f-323bd16055f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f377bd11-f71d-3067-bb1f-323bd16055f1', 2, NULL, 'La fleur qui va sur l''eau', 'La fleur qui va sur l''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2471 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f377bd11-f71d-3067-bb1f-323bd16055f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Accompagnement', part.name_en = 'Accompagnement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2471 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d7a435d7-aa7a-3c06-82a6-4f89e2048fe5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7a435d7-aa7a-3c06-82a6-4f89e2048fe5', 3, NULL, 'Accompagnement', 'Accompagnement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2471 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a435d7-aa7a-3c06-82a6-4f89e2048fe5'
);


-- Op. 86 하프를 위한 즉흥곡 D♭장조

UPDATE pieces piece
SET piece.title = '하프를 위한 즉흥곡 D♭장조', piece.title_en = 'Impromptu for harp in D♭ major, Op. 86',
    piece.type = 'song', piece.opus_number = 'Op. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2362 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 2362 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 87 가곡집 Op. 87

UPDATE pieces piece
SET piece.title = '가곡집 Op. 87', piece.title_en = '2 Songs, Op. 87',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '87',
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 948 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 948 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le plus doux chemin', part.name_en = 'Le plus doux chemin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 948 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:3ad9ff3e-c2ba-3207-b423-24bcedf13086' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ad9ff3e-c2ba-3207-b423-24bcedf13086', 1, NULL, 'Le plus doux chemin', 'Le plus doux chemin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 948 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad9ff3e-c2ba-3207-b423-24bcedf13086'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le ramier', part.name_en = 'Le ramier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 948 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:5bdd393a-e1b5-47fe-8fcb-b1e0f8410f2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bdd393a-e1b5-47fe-8fcb-b1e0f8410f2c', 2, NULL, 'Le ramier', 'Le ramier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 948 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bdd393a-e1b5-47fe-8fcb-b1e0f8410f2c'
);


-- Op. 88 부수음악 <행복의 베일>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <행복의 베일>', 'Le voile du bonheur, Op. 88', 'song', 'Op. 88', NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <행복의 베일>'
);


-- Op. 89 피아노 5중주 1번 D단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 1번 D단조', piece.title_en = 'Piano Quintet No. 1 in D minor, Op. 89',
    piece.type = 'album', piece.opus_number = 'Op. 89',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 539 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 539 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Molto moderato', part.name_en = 'I. Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 539 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:1bcd0a3a-43b2-4918-b394-dcd9183fb3e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bcd0a3a-43b2-4918-b394-dcd9183fb3e4', 1, 'I', 'Molto moderato', 'I. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 539 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bcd0a3a-43b2-4918-b394-dcd9183fb3e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 539 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:bcc00644-795b-4458-9327-34f4a374c336' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcc00644-795b-4458-9327-34f4a374c336', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 539 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcc00644-795b-4458-9327-34f4a374c336'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto moderato', part.name_en = 'III. Allegretto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 539 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:c18b543e-6f02-451e-a915-8cc79acadc10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c18b543e-6f02-451e-a915-8cc79acadc10', 3, 'III', 'Allegretto moderato', 'III. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 539 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c18b543e-6f02-451e-a915-8cc79acadc10'
);


-- Op. 90 뱃노래 7번 D단조

UPDATE pieces piece
SET piece.title = '뱃노래 7번 D단조', piece.title_en = 'Barcarolle No. 7 in D minor, Op. 90',
    piece.type = 'song', piece.opus_number = 'Op. 90',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 505 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 505 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 91 즉흥곡 4번 D♭장조

UPDATE pieces piece
SET piece.title = '즉흥곡 4번 D♭장조', piece.title_en = 'Impromptu No. 4 in D♭ major, Op. 91',
    piece.type = 'song', piece.opus_number = 'Op. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 881 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 881 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 92 가곡 <조용한 선물>

UPDATE pieces piece
SET piece.title = '가곡 <조용한 선물>', piece.title_en = 'Le don silencieux, Op. 92',
    piece.type = 'song', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2388 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 2388 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 93 <아베 마리아> B단조

UPDATE pieces piece
SET piece.title = '<아베 마리아> B단조', piece.title_en = 'Ave Maria in B minor, Op. 93',
    piece.type = 'song', piece.opus_number = 'Op. 93',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2241 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 2241 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 94 가곡 <샹송>

UPDATE pieces piece
SET piece.title = '가곡 <샹송>', piece.title_en = 'Chanson, Op. 94',
    piece.type = 'song', piece.opus_number = 'Op. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2093 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 2093 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 95 연가곡집 <이브의 노래>

UPDATE pieces piece
SET piece.title = '연가곡집 <이브의 노래>', piece.title_en = 'La chanson d''Ève, Op. 95',
    piece.type = 'album', piece.opus_number = 'Op. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1253 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 1253 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Paradis', part.name_en = 'Paradis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:ec7bea46-a3f1-32ae-8e09-ce73aea28cfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec7bea46-a3f1-32ae-8e09-ce73aea28cfe', 1, NULL, 'Paradis', 'Paradis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec7bea46-a3f1-32ae-8e09-ce73aea28cfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prima verba', part.name_en = 'Prima verba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:2bc809ad-3848-3ece-80ee-fdf35f02b3da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bc809ad-3848-3ece-80ee-fdf35f02b3da', 2, NULL, 'Prima verba', 'Prima verba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bc809ad-3848-3ece-80ee-fdf35f02b3da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Roses ardentes', part.name_en = 'Roses ardentes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:bcaa5ea6-54dd-35cc-8dd9-a61cb8627273' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcaa5ea6-54dd-35cc-8dd9-a61cb8627273', 3, NULL, 'Roses ardentes', 'Roses ardentes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcaa5ea6-54dd-35cc-8dd9-a61cb8627273'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Comme Dieu rayonne', part.name_en = 'Comme Dieu rayonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:872cddc4-ed5d-3c19-aaa9-f6986bae7ce6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:872cddc4-ed5d-3c19-aaa9-f6986bae7ce6', 4, NULL, 'Comme Dieu rayonne', 'Comme Dieu rayonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:872cddc4-ed5d-3c19-aaa9-f6986bae7ce6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'L''aube blanche', part.name_en = 'L''aube blanche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:e2a89578-fded-36a8-97cc-511b3adc5743' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2a89578-fded-36a8-97cc-511b3adc5743', 5, NULL, 'L''aube blanche', 'L''aube blanche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2a89578-fded-36a8-97cc-511b3adc5743'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Eau vivante', part.name_en = 'Eau vivante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:47ff3b60-3bd6-367f-96a6-ed13ad1eb4ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47ff3b60-3bd6-367f-96a6-ed13ad1eb4ed', 6, NULL, 'Eau vivante', 'Eau vivante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47ff3b60-3bd6-367f-96a6-ed13ad1eb4ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Veilles-tu, ma senteur de soleil ?', part.name_en = 'Veilles-tu, ma senteur de soleil ?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:5f6754a9-0a20-3d2a-849f-9c417931b0b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f6754a9-0a20-3d2a-849f-9c417931b0b7', 7, NULL, 'Veilles-tu, ma senteur de soleil ?', 'Veilles-tu, ma senteur de soleil ?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f6754a9-0a20-3d2a-849f-9c417931b0b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Dans un parfum de roses blanches', part.name_en = 'Dans un parfum de roses blanches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:ad403a6b-b5a3-3441-8aff-da9f1323f40e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad403a6b-b5a3-3441-8aff-da9f1323f40e', 8, NULL, 'Dans un parfum de roses blanches', 'Dans un parfum de roses blanches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad403a6b-b5a3-3441-8aff-da9f1323f40e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Crépuscule', part.name_en = 'Crépuscule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:f931e937-c825-305f-8f5c-37dc06b963bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f931e937-c825-305f-8f5c-37dc06b963bb', 9, NULL, 'Crépuscule', 'Crépuscule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f931e937-c825-305f-8f5c-37dc06b963bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Ô mort, poussière d''étoiles', part.name_en = 'Ô mort, poussière d''étoiles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1253 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:4ee2545d-2be5-3841-b568-0b4554eccc67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ee2545d-2be5-3841-b568-0b4554eccc67', 10, NULL, 'Ô mort, poussière d''étoiles', 'Ô mort, poussière d''étoiles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1253 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ee2545d-2be5-3841-b568-0b4554eccc67'
);


-- Op. 96 뱃노래 8번 D♭장조

UPDATE pieces piece
SET piece.title = '뱃노래 8번 D♭장조', piece.title_en = 'Barcarolle No. 8 in D♭ major, Op. 96',
    piece.type = 'song', piece.opus_number = 'Op. 96',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 660 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 660 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 97 녹턴 9번 B단조

UPDATE pieces piece
SET piece.title = '녹턴 9번 B단조', piece.title_en = 'Nocturne No. 9 in B minor, Op. 97',
    piece.type = 'song', piece.opus_number = 'Op. 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1039 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 1039 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 98 세레나데 B단조

UPDATE pieces piece
SET piece.title = '세레나데 B단조', piece.title_en = 'Sérénade in B minor, Op. 98',
    piece.type = 'song', piece.opus_number = 'Op. 98',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1099 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 1099 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 99 녹턴 10번 E단조

UPDATE pieces piece
SET piece.title = '녹턴 10번 E단조', piece.title_en = 'Nocturne No. 10 in E minor, Op. 99',
    piece.type = 'song', piece.opus_number = 'Op. 99',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2559 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 2559 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 101 뱃노래 9번 A단조

UPDATE pieces piece
SET piece.title = '뱃노래 9번 A단조', piece.title_en = 'Barcarolle No. 9 in A minor, Op. 101',
    piece.type = 'song', piece.opus_number = 'Op. 101',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1909, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 640 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1909
WHERE piece.id = 640 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 102 즉흥곡 5번 F#단조

UPDATE pieces piece
SET piece.title = '즉흥곡 5번 F#단조', piece.title_en = 'Impromptu No. 5 in F# minor, Op. 102',
    piece.type = 'song', piece.opus_number = 'Op. 102',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1909, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1537 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1909
WHERE piece.id = 1537 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 103 전주곡 Op. 103

UPDATE pieces piece
SET piece.title = '전주곡 Op. 103', piece.title_en = '9 Préludes, Op. 103',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '103',
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1915 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 1915 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D♭장조', part.name_en = 'No. 1 in D♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:eae1692b-28d7-3ba2-b281-762017db9800' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eae1692b-28d7-3ba2-b281-762017db9800', 1, NULL, 'D♭장조', 'No. 1 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae1692b-28d7-3ba2-b281-762017db9800'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'C#단조', part.name_en = 'No. 2 in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:fa9e9049-4c07-389c-a696-b97276b2262f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa9e9049-4c07-389c-a696-b97276b2262f', 2, NULL, 'C#단조', 'No. 2 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa9e9049-4c07-389c-a696-b97276b2262f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = 'No. 3 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d4610cdb-51fe-3ead-a2b6-e619f5e8b4d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4610cdb-51fe-3ead-a2b6-e619f5e8b4d9', 3, NULL, 'G단조', 'No. 3 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4610cdb-51fe-3ead-a2b6-e619f5e8b4d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = 'No. 4 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:1764d098-3830-3d2e-a4fd-0c664352e625' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1764d098-3830-3d2e-a4fd-0c664352e625', 4, NULL, 'F장조', 'No. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1764d098-3830-3d2e-a4fd-0c664352e625'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 5 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:0c2c11e8-8f6b-3fe0-9707-27b66d21ff67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c2c11e8-8f6b-3fe0-9707-27b66d21ff67', 5, NULL, 'D단조', 'No. 5 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c2c11e8-8f6b-3fe0-9707-27b66d21ff67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'E♭단조', part.name_en = 'No. 6 in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:64e7cda5-5ce7-3323-8d45-841fa15df282' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64e7cda5-5ce7-3323-8d45-841fa15df282', 6, NULL, 'E♭단조', 'No. 6 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64e7cda5-5ce7-3323-8d45-841fa15df282'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'No. 7 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:47c4732b-621d-34fc-b1a8-89a50e4224db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47c4732b-621d-34fc-b1a8-89a50e4224db', 7, NULL, 'A장조', 'No. 7 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c4732b-621d-34fc-b1a8-89a50e4224db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 8 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:da7a24d2-c4c5-3e3a-97f3-ace22f23e886' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da7a24d2-c4c5-3e3a-97f3-ace22f23e886', 8, NULL, 'C단조', 'No. 8 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da7a24d2-c4c5-3e3a-97f3-ace22f23e886'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'No. 9 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1915 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:9e15fd0e-44ee-36dd-845a-df61f3798210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e15fd0e-44ee-36dd-845a-df61f3798210', 9, NULL, 'E단조', 'No. 9 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1915 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e15fd0e-44ee-36dd-845a-df61f3798210'
);


-- Op. 104 피아노 소품 Op. 104

UPDATE pieces piece
SET piece.title = '피아노 소품 Op. 104', piece.title_en = '2 Pièces, Op. 104',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '104',
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1781 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 1781 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '녹턴 11번 F#단조', part.name_en = 'Nocturne No. 11 in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1781 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a997ed42-d985-384b-b70f-ca8d9d6b273c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a997ed42-d985-384b-b70f-ca8d9d6b273c', 1, NULL, '녹턴 11번 F#단조', 'Nocturne No. 11 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1781 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a997ed42-d985-384b-b70f-ca8d9d6b273c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '뱃노래 10번 A단조', part.name_en = 'Barcarolle No. 10 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1781 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a9ebc48d-fdce-4473-87f1-0a5ef8f240fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9ebc48d-fdce-4473-87f1-0a5ef8f240fa', 2, NULL, '뱃노래 10번 A단조', 'Barcarolle No. 10 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1781 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9ebc48d-fdce-4473-87f1-0a5ef8f240fa'
);


-- Op. 105 뱃노래 11번 G단조

UPDATE pieces piece
SET piece.title = '뱃노래 11번 G단조', piece.title_en = 'Barcarolle No. 11 in G minor, Op. 105',
    piece.type = 'song', piece.opus_number = 'Op. 105',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 582 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 582 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 106 연가곡집 <닫힌 정원>

UPDATE pieces piece
SET piece.title = '연가곡집 <닫힌 정원>', piece.title_en = 'Le jardin clos, Op. 106',
    piece.type = 'album', piece.opus_number = 'Op. 106',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1914, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2175 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1914
WHERE piece.id = 2175 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Exaucement', part.name_en = 'Exaucement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2175 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:66752fe8-449c-3bd4-b7c4-368836108a43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66752fe8-449c-3bd4-b7c4-368836108a43', 1, NULL, 'Exaucement', 'Exaucement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2175 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66752fe8-449c-3bd4-b7c4-368836108a43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Quand tu plonges tes yeux dans mes yeux', part.name_en = 'Quand tu plonges tes yeux dans mes yeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2175 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:3e52caae-df71-37af-a5aa-bff9681cb6c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e52caae-df71-37af-a5aa-bff9681cb6c1', 2, NULL, 'Quand tu plonges tes yeux dans mes yeux', 'Quand tu plonges tes yeux dans mes yeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2175 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e52caae-df71-37af-a5aa-bff9681cb6c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La messagère', part.name_en = 'La messagère',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2175 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:2a617cc6-e4c4-35a1-9202-665590146219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a617cc6-e4c4-35a1-9202-665590146219', 3, NULL, 'La messagère', 'La messagère', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2175 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a617cc6-e4c4-35a1-9202-665590146219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Je me poserai sur ton cœur', part.name_en = 'Je me poserai sur ton cœur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2175 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:aeffcddf-0f8b-3f1c-bc60-c80a7f32382b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aeffcddf-0f8b-3f1c-bc60-c80a7f32382b', 4, NULL, 'Je me poserai sur ton cœur', 'Je me poserai sur ton cœur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2175 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeffcddf-0f8b-3f1c-bc60-c80a7f32382b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dans la nymphée', part.name_en = 'Dans la nymphée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2175 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a626c715-49bb-39a8-ab51-bfac1a1ad4bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a626c715-49bb-39a8-ab51-bfac1a1ad4bd', 5, NULL, 'Dans la nymphée', 'Dans la nymphée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2175 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a626c715-49bb-39a8-ab51-bfac1a1ad4bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Dans la pénombre', part.name_en = 'Dans la pénombre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2175 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:1e776b2f-dfad-3b9d-9477-e81a1a147e8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e776b2f-dfad-3b9d-9477-e81a1a147e8b', 6, NULL, 'Dans la pénombre', 'Dans la pénombre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2175 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e776b2f-dfad-3b9d-9477-e81a1a147e8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Il m''est cher, amour, le bandeau', part.name_en = 'Il m''est cher, amour, le bandeau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2175 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:e17fd050-0e45-35a0-aca8-75116c14afc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e17fd050-0e45-35a0-aca8-75116c14afc3', 7, NULL, 'Il m''est cher, amour, le bandeau', 'Il m''est cher, amour, le bandeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2175 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e17fd050-0e45-35a0-aca8-75116c14afc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Inscription sur le sable', part.name_en = 'Inscription sur le sable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2175 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:dcdfce99-88fb-3ced-a182-0c01eed73d53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcdfce99-88fb-3ced-a182-0c01eed73d53', 8, NULL, 'Inscription sur le sable', 'Inscription sur le sable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2175 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcdfce99-88fb-3ced-a182-0c01eed73d53'
);


-- Op. 106 bis 뱃노래 12번 E♭장조

UPDATE pieces piece
SET piece.title = '뱃노래 12번 E♭장조', piece.title_en = 'Barcarolle No. 12 in E♭ major, Op. 106 bis',
    piece.type = 'song', piece.opus_number = 'Op. 106 bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 624 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 624 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 107 녹턴 12번 E단조

UPDATE pieces piece
SET piece.title = '녹턴 12번 E단조', piece.title_en = 'Nocturne No. 12 in E minor, Op. 107',
    piece.type = 'song', piece.opus_number = 'Op. 107',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 672 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 672 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 108 바이올린 소나타 2번 E단조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 E단조', piece.title_en = 'Violin Sonata No. 2 in E minor, Op. 108',
    piece.type = 'album', piece.opus_number = 'Op. 108',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2881 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 2881 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2881 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:635bfb31-4988-382b-89a9-ebdbff04b690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:635bfb31-4988-382b-89a9-ebdbff04b690', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2881 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:635bfb31-4988-382b-89a9-ebdbff04b690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2881 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:7a1ccba9-62ee-3d7a-8646-f9553e01eb06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a1ccba9-62ee-3d7a-8646-f9553e01eb06', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2881 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a1ccba9-62ee-3d7a-8646-f9553e01eb06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레. Allegro non troppo', part.name_en = 'III. Finale. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2881 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:92d62542-cd08-3336-bbaa-05119f8f5add' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92d62542-cd08-3336-bbaa-05119f8f5add', 3, 'III', '피날레. Allegro non troppo', 'III. Finale. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2881 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92d62542-cd08-3336-bbaa-05119f8f5add'
);


-- Op. 109 첼로 소나타 1번 D단조

UPDATE pieces piece
SET piece.title = '첼로 소나타 1번 D단조', piece.title_en = 'Cello Sonata No. 1 in D minor, Op. 109',
    piece.type = 'album', piece.opus_number = 'Op. 109',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1565 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 1565 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1565 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:727802a5-5097-47fb-bf40-7acdc01f351a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:727802a5-5097-47fb-bf40-7acdc01f351a', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1565 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:727802a5-5097-47fb-bf40-7acdc01f351a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1565 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:6664a7ad-c1f5-4982-a729-7c057766faf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6664a7ad-c1f5-4982-a729-7c057766faf0', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1565 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6664a7ad-c1f5-4982-a729-7c057766faf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레. Allegro commodo', part.name_en = 'III. Finale. Allegro commodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1565 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:e087f189-d5a1-4479-b35c-4d525c7067ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e087f189-d5a1-4479-b35c-4d525c7067ff', 3, 'III', '피날레. Allegro commodo', 'III. Finale. Allegro commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1565 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e087f189-d5a1-4479-b35c-4d525c7067ff'
);


-- Op. 110 하프 소품 <탑 속의 성주 부인>

UPDATE pieces piece
SET piece.title = '하프 소품 <탑 속의 성주 부인>', piece.title_en = 'Une châtelaine en sa tour, Op. 110',
    piece.type = 'song', piece.opus_number = 'Op. 110',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2425 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 2425 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 111 피아노와 관현악을 위한 환상곡

UPDATE pieces piece
SET piece.title = '피아노와 관현악을 위한 환상곡', piece.title_en = 'Fantaisie for piano and orchestra, Op. 111',
    piece.type = 'song', piece.opus_number = 'Op. 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2128 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 2128 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 112 모음곡 <마스크와 베르가마스크>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 <마스크와 베르가마스크>', 'Masques et bergamasques, Op. 112', 'album', 'Op. 112', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 <마스크와 베르가마스크>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2153931c-a42f-4475-ba4b-6aff5f4b23b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2153931c-a42f-4475-ba4b-6aff5f4b23b1'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <마스크와 베르가마스크>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2153931c-a42f-4475-ba4b-6aff5f4b23b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dda62c69-6323-4801-8d08-b3232522914a', 1, 'I', '서곡. Allegro molto vivo', 'I. Ouverture. Allegro molto vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <마스크와 베르가마스크>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dda62c69-6323-4801-8d08-b3232522914a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b6d0b84-5986-4095-aa60-14646485c173', 2, 'II', '미뉴에트. Allegretto moderato', 'II. Menuet. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <마스크와 베르가마스크>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b6d0b84-5986-4095-aa60-14646485c173'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1208cfc-af7e-4b7f-8b44-6829197a6b99', 3, 'III', '가보트. Allegro vivo', 'III. Gavotte. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <마스크와 베르가마스크>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1208cfc-af7e-4b7f-8b44-6829197a6b99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29b58aa9-20fa-4bcb-a049-2119ab987ee5', 4, 'IV', '전원곡. Andantino tranquillo', 'IV. Pastorale. Andantino tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '모음곡 <마스크와 베르가마스크>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29b58aa9-20fa-4bcb-a049-2119ab987ee5'
);


-- Op. 113 연가곡집 <신기루>

UPDATE pieces piece
SET piece.title = '연가곡집 <신기루>', piece.title_en = 'Mirages, Op. 113',
    piece.type = 'album', piece.opus_number = 'Op. 113',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1905 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 1905 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cygne sur l''eau', part.name_en = 'Cygne sur l''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1905 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:1df8aa33-2b57-3221-958c-13e3ff14cf5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1df8aa33-2b57-3221-958c-13e3ff14cf5a', 1, NULL, 'Cygne sur l''eau', 'Cygne sur l''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1905 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1df8aa33-2b57-3221-958c-13e3ff14cf5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Reflets dans l''eau', part.name_en = 'Reflets dans l''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1905 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:8b91e236-71b2-344a-904b-4b4d7ddc7249' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b91e236-71b2-344a-904b-4b4d7ddc7249', 2, NULL, 'Reflets dans l''eau', 'Reflets dans l''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1905 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b91e236-71b2-344a-904b-4b4d7ddc7249'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jardin nocturne', part.name_en = 'Jardin nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1905 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:84141012-7623-3382-a469-3e9ca6189b46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84141012-7623-3382-a469-3e9ca6189b46', 3, NULL, 'Jardin nocturne', 'Jardin nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1905 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84141012-7623-3382-a469-3e9ca6189b46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Danseuse', part.name_en = 'Danseuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1905 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:a4295553-023d-37ce-9142-6f72bdf25068' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4295553-023d-37ce-9142-6f72bdf25068', 4, NULL, 'Danseuse', 'Danseuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1905 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4295553-023d-37ce-9142-6f72bdf25068'
);


-- Op. 114 가곡 <평화가 왔다>

UPDATE pieces piece
SET piece.title = '가곡 <평화가 왔다>', piece.title_en = 'C''est la paix !, Op. 114',
    piece.type = 'song', piece.opus_number = 'Op. 114',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 596 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 596 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 115 피아노 5중주 2번 C단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 2번 C단조', piece.title_en = 'Piano Quintet No. 2 in C minor, Op. 115',
    piece.type = 'album', piece.opus_number = 'Op. 115',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 646 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 646 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 646 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:263d2f6a-2acc-4ea2-aa8c-007852002546' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:263d2f6a-2acc-4ea2-aa8c-007852002546', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 646 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:263d2f6a-2acc-4ea2-aa8c-007852002546'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro vivo', part.name_en = 'II. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 646 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:14893183-a83f-47d2-8143-e7f767c871c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14893183-a83f-47d2-8143-e7f767c871c0', 2, 'II', 'Allegro vivo', 'II. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 646 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14893183-a83f-47d2-8143-e7f767c871c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante moderato', part.name_en = 'III. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 646 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:72e24348-ee17-44b3-8659-53382495fa5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72e24348-ee17-44b3-8659-53382495fa5b', 3, 'III', 'Andante moderato', 'III. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 646 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72e24348-ee17-44b3-8659-53382495fa5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto', part.name_en = 'IV. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 646 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:7ad6e268-1e76-4719-bb48-3d65fa555d24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ad6e268-1e76-4719-bb48-3d65fa555d24', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 646 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ad6e268-1e76-4719-bb48-3d65fa555d24'
);


-- Op. 116 뱃노래 13번 C장조

UPDATE pieces piece
SET piece.title = '뱃노래 13번 C장조', piece.title_en = 'Barcarolle No. 13 in C major, Op. 116',
    piece.type = 'song', piece.opus_number = 'Op. 116',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 559 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 559 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 117 첼로 소나타 2번 G단조

UPDATE pieces piece
SET piece.title = '첼로 소나타 2번 G단조', piece.title_en = 'Cello Sonata No. 2 in G minor, Op. 117',
    piece.type = 'album', piece.opus_number = 'Op. 117',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1628 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 1628 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1628 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:e11479af-b338-4803-a681-3b9e3e7b3af9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e11479af-b338-4803-a681-3b9e3e7b3af9', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1628 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e11479af-b338-4803-a681-3b9e3e7b3af9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1628 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:f81e9af3-3ee7-4ab9-829e-d4ce821a1a1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f81e9af3-3ee7-4ab9-829e-d4ce821a1a1d', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1628 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f81e9af3-3ee7-4ab9-829e-d4ce821a1a1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivo', part.name_en = 'III. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1628 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:729ef63c-0f3e-4594-aea0-cbe4c4d6df09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:729ef63c-0f3e-4594-aea0-cbe4c4d6df09', 3, 'III', 'Allegro vivo', 'III. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1628 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:729ef63c-0f3e-4594-aea0-cbe4c4d6df09'
);


-- Op. 118 연가곡집 <환상의 지평선>

UPDATE pieces piece
SET piece.title = '연가곡집 <환상의 지평선>', piece.title_en = 'L''horizon chimérique, Op. 118',
    piece.type = 'album', piece.opus_number = 'Op. 118',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1164 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 1164 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La mer est infinie', part.name_en = 'La mer est infinie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1164 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:da1689f1-77da-3ba2-926b-43e4115f98d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da1689f1-77da-3ba2-926b-43e4115f98d2', 1, NULL, 'La mer est infinie', 'La mer est infinie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1164 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da1689f1-77da-3ba2-926b-43e4115f98d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Je me suis embarqué', part.name_en = 'Je me suis embarqué',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1164 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:0adb5165-fd9d-3712-a1e4-ca1a3ab344ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0adb5165-fd9d-3712-a1e4-ca1a3ab344ba', 2, NULL, 'Je me suis embarqué', 'Je me suis embarqué', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1164 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0adb5165-fd9d-3712-a1e4-ca1a3ab344ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Diane, Séléné', part.name_en = 'Diane, Séléné',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1164 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:5c2eae8a-4049-3ba6-9ddf-4c4bb9f5c6dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c2eae8a-4049-3ba6-9ddf-4c4bb9f5c6dc', 3, NULL, 'Diane, Séléné', 'Diane, Séléné', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1164 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c2eae8a-4049-3ba6-9ddf-4c4bb9f5c6dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Vaisseaux, nous vous aurons aimés', part.name_en = 'Vaisseaux, nous vous aurons aimés',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1164 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:78c30561-d61a-3708-a7f5-a20e88df73b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78c30561-d61a-3708-a7f5-a20e88df73b2', 4, NULL, 'Vaisseaux, nous vous aurons aimés', 'Vaisseaux, nous vous aurons aimés', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1164 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78c30561-d61a-3708-a7f5-a20e88df73b2'
);


-- Op. 119 녹턴 13번 B단조

UPDATE pieces piece
SET piece.title = '녹턴 13번 B단조', piece.title_en = 'Nocturne No. 13 in B minor, Op. 119',
    piece.type = 'song', piece.opus_number = 'Op. 119',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1505 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 1505 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- Op. 120 피아노 3중주 D단조

UPDATE pieces piece
SET piece.title = '피아노 3중주 D단조', piece.title_en = 'Piano Trio in D minor, Op. 120',
    piece.type = 'album', piece.opus_number = 'Op. 120',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1923, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1443 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1923
WHERE piece.id = 1443 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro, ma non troppo', part.name_en = 'I. Allegro, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1443 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:33f357d0-04c2-4922-bbe3-74513971292b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33f357d0-04c2-4922-bbe3-74513971292b', 1, 'I', 'Allegro, ma non troppo', 'I. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1443 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33f357d0-04c2-4922-bbe3-74513971292b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1443 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:41c03e90-2f24-499b-8662-e95520f8f970' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c03e90-2f24-499b-8662-e95520f8f970', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1443 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c03e90-2f24-499b-8662-e95520f8f970'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro vivo', part.name_en = 'III. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1443 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:738e0816-a907-44c2-b691-9fc8777503f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:738e0816-a907-44c2-b691-9fc8777503f1', 3, 'III', 'Allegro vivo', 'III. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1443 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:738e0816-a907-44c2-b691-9fc8777503f1'
);


-- Op. 121 현악 4중주 E단조

UPDATE pieces piece
SET piece.title = '현악 4중주 E단조', piece.title_en = 'String Quartet in E minor, Op. 121',
    piece.type = 'album', piece.opus_number = 'Op. 121',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1924, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2646 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1924
WHERE piece.id = 2646 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2646 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:2ccc340f-da22-4b8e-b555-f45d1edbf1ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ccc340f-da22-4b8e-b555-f45d1edbf1ac', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2646 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ccc340f-da22-4b8e-b555-f45d1edbf1ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2646 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d4ee3359-f32e-45fa-a732-9a31665c44a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4ee3359-f32e-45fa-a732-9a31665c44a5', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2646 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4ee3359-f32e-45fa-a732-9a31665c44a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2646 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:67d3b8c5-4225-40d2-a628-e2cf58ed43d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67d3b8c5-4225-40d2-a628-e2cf58ed43d5', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2646 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67d3b8c5-4225-40d2-a628-e2cf58ed43d5'
);


-- None 가곡 <Puisque j'ai mis ma lèvre>

UPDATE pieces piece
SET piece.title = '가곡 <Puisque j''ai mis ma lèvre>', piece.title_en = 'Puisque j''ai mis ma lèvre',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1590 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 1590 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 3성 푸가 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성 푸가 F장조', 'Fugue à trois parties in F major', 'song', NULL, NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성 푸가 F장조'
);


-- None 피아노 소나타 F장조

UPDATE pieces piece
SET piece.title = '피아노 소나타 F장조', piece.title_en = 'Piano Sonata in F major',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2143 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 2143 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'I. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2143 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:4013aa65-26fa-4e98-9c33-bdc597ff3551' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4013aa65-26fa-4e98-9c33-bdc597ff3551', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2143 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4013aa65-26fa-4e98-9c33-bdc597ff3551'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '미뉴에트. Tempo di menuetto', part.name_en = 'II. Menuet. Tempo di menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2143 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:696b3890-6c85-4865-a1b8-06a94a30ec44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:696b3890-6c85-4865-a1b8-06a94a30ec44', 2, 'II', '미뉴에트. Tempo di menuetto', 'II. Menuet. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2143 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:696b3890-6c85-4865-a1b8-06a94a30ec44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레. Allegro vivo', part.name_en = 'III. Finale. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2143 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:d9b8e388-bf90-4d3e-81fd-dd2bb959d97b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9b8e388-bf90-4d3e-81fd-dd2bb959d97b', 3, 'III', '피날레. Allegro vivo', 'III. Finale. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2143 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9b8e388-bf90-4d3e-81fd-dd2bb959d97b'
);


-- None <Super flumina Babylonis>

UPDATE pieces piece
SET piece.title = '<Super flumina Babylonis>', piece.title_en = 'Super flumina Babylonis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1837 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 1837 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 가곡 <Tristesse d'Olympio>

UPDATE pieces piece
SET piece.title = '가곡 <Tristesse d''Olympio>', piece.title_en = 'Tristesse d''Olympio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2081 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 2081 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 가곡 <L'aurore>

UPDATE pieces piece
SET piece.title = '가곡 <L''aurore>', piece.title_en = 'L''aurore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1870, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2122 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1870
WHERE piece.id = 2122 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None <아베 마리아> A장조

UPDATE pieces piece
SET piece.title = '<아베 마리아> A장조', piece.title_en = 'Ave Maria in A major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2194 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 2194 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 모테트 <Tu es Petrus>

UPDATE pieces piece
SET piece.title = '모테트 <Tu es Petrus>', piece.title_en = 'Tu es Petrus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2415 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 2415 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 모테트 <Benedictus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Benedictus>', 'Benedictus', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Benedictus>'
);


-- None 가곡 <En prière>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <En prière>', 'En prière', 'song', NULL, NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <En prière>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aaa89b03-615f-3d15-a4a4-5af2dd599bce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aaa89b03-615f-3d15-a4a4-5af2dd599bce'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '가곡 <En prière>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aaa89b03-615f-3d15-a4a4-5af2dd599bce'
);


-- N. 109 <수난> 전주곡

UPDATE pieces piece
SET piece.title = '<수난> 전주곡', piece.title_en = 'La Passion: Prélude',
    piece.type = 'song', piece.opus_number = 'N. 109',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2363 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 2363 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 가곡 <Sérénade du Bourgeois gentilhomme>

UPDATE pieces piece
SET piece.title = '가곡 <Sérénade du Bourgeois gentilhomme>', piece.title_en = 'Sérénade du Bourgeois gentilhomme',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 532 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 532 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 모테트 <Sancta mater>

UPDATE pieces piece
SET piece.title = '모테트 <Sancta mater>', piece.title_en = 'Sancta mater',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2805 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 2805 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None <아베 마리아> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아베 마리아> F장조', 'Ave Maria in F major', 'song', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아베 마리아> F장조'
);


-- None 전주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 C장조', 'Prélude in C major', 'song', NULL, NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 C장조'
);


-- None 두 대의 첼로를 위한 초견곡

UPDATE pieces piece
SET piece.title = '두 대의 첼로를 위한 초견곡', piece.title_en = 'Morceau de lecture for two cellos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1897, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 506 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1897
WHERE piece.id = 506 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 가곡 <멜리장드의 노래>

UPDATE pieces piece
SET piece.title = '가곡 <멜리장드의 노래>', piece.title_en = 'Chanson de Mélisande',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2944 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 2944 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 플루트와 피아노를 위한 콩쿠르 소품

UPDATE pieces piece
SET piece.title = '플루트와 피아노를 위한 콩쿠르 소품', piece.title_en = 'Morceau de concours for flute and piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2360 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 2360 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 바이올린과 피아노를 위한 초견곡

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 초견곡', piece.title_en = 'Morceau de lecture for violin and piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 546 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 546 AND piece.composer_id = 47 AND piece.composition_year IS NULL;


-- None 하프를 위한 초견곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프를 위한 초견곡', 'Morceau de lecture for harp', 'song', NULL, NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프를 위한 초견곡'
);


-- None 모테트 <Tantum ergo> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Tantum ergo> F장조', 'Tantum ergo in F major', 'song', NULL, NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Tantum ergo> F장조'
);


-- None 보칼리즈-에튀드

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '보칼리즈-에튀드', 'Vocalise-étude', 'song', NULL, NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 47
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '보칼리즈-에튀드'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42b957fa-046b-4b33-9e4e-e21b854961e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '42b957fa-046b-4b33-9e4e-e21b854961e8'
FROM pieces p
WHERE p.composer_id = 47 AND p.title = '보칼리즈-에튀드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42b957fa-046b-4b33-9e4e-e21b854961e8'
);


-- None 미사 <Messe basse>

UPDATE pieces piece
SET piece.title = '미사 <Messe basse>', piece.title_en = 'Messe basse',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2300 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 2300 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '키리에', part.name_en = 'I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2300 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:23c10a02-1590-4d1e-99f2-2e1741c4d840' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23c10a02-1590-4d1e-99f2-2e1741c4d840', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2300 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23c10a02-1590-4d1e-99f2-2e1741c4d840'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '상투스', part.name_en = 'II. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2300 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:24924014-21da-414f-bee4-0ba6d9834d66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24924014-21da-414f-bee4-0ba6d9834d66', 2, 'II', '상투스', 'II. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2300 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24924014-21da-414f-bee4-0ba6d9834d66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '베네딕투스', part.name_en = 'III. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2300 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:1a2088a2-3f76-421e-b52a-a098e30a0861' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a2088a2-3f76-421e-b52a-a098e30a0861', 3, 'III', '베네딕투스', 'III. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2300 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a2088a2-3f76-421e-b52a-a098e30a0861'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '아뉴스 데이', part.name_en = 'IV. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2300 AND p.composer_id = 47 AND part.part_key = 'musicbrainz:3f95ff9c-7760-4031-837c-44763ce21d47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f95ff9c-7760-4031-837c-44763ce21d47', 4, 'IV', '아뉴스 데이', 'IV. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2300 AND p.composer_id = 47
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f95ff9c-7760-4031-837c-44763ce21d47'
);


-- None 오페라 <페넬로프>

UPDATE pieces piece
SET piece.title = '오페라 <페넬로프>', piece.title_en = 'Pénélope',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2155 AND piece.composer_id = 47
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 2155 AND piece.composer_id = 47 AND piece.composition_year IS NULL;

-- 카탈로그에 대응이 없는 seed 작품 40개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 47 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    676, 680, 745, 777, 788, 825, 832, 859, 949, 1013, 1030, 1136, 1137, 1166, 1186, 1318, 1365, 1394, 1461, 1576,
    1718, 1826, 1929, 2008, 2023, 2110, 2244, 2305, 2338, 2496, 2677, 2717, 2729, 2734, 2772, 2857, 2893, 2926, 2980, 7631
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
