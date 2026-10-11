-- 프로코피예프 작품을 출판 단위로 다시 짠다(카탈로그: Op.). 작품 164개(묶음 38, 다악장 61, 낱곡 65),
-- 새 작품 35개, 기존 작품 129개(seed 제목 고침 131개), part 472개, 그 아래 19개,
-- 기존 part 고쳐 씀 0개, 기존 작품 연결 5개. 카탈로그에 대응이 없는 seed 94개는 목록에서 숨긴다.
--
-- 정한 것
--   Op. 1 이전 어린 시절 작품은 뺀다. 발레·오페라는 part 없이 두고 <신데렐라> 가보트는 대목으로 남긴다.
--   325 피아노 협주곡 3번의 2악장 변주는 그 아래 part 로 다시 짠다.
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

-- Op. 1 피아노 소나타 1번 F단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 1번 F단조', piece.title_en = 'Piano Sonata No. 1 in F minor',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1909, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11868 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1909
WHERE piece.id = 11868 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 2 4개의 연습곡 Op. 2

UPDATE pieces piece
SET piece.title = '4개의 연습곡 Op. 2', piece.title_en = '4 Études, Op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(1909, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11340 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1909
WHERE piece.id = 11340 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 1 in D minor. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11340 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7e3823dd-8928-416c-9e50-db247e8f83d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e3823dd-8928-416c-9e50-db247e8f83d2', 1, NULL, 'D단조', 'No. 1 in D minor. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11340 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e3823dd-8928-416c-9e50-db247e8f83d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'No. 2 in E minor. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11340 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f88f2852-8838-4873-8c46-fe9d233e6a84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f88f2852-8838-4873-8c46-fe9d233e6a84', 2, NULL, 'E단조', 'No. 2 in E minor. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11340 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f88f2852-8838-4873-8c46-fe9d233e6a84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 3 in C minor. Andante semplice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11340 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3d926b1b-0bf5-45e4-80a3-4187cf0005a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d926b1b-0bf5-45e4-80a3-4187cf0005a2', 3, NULL, 'C단조', 'No. 3 in C minor. Andante semplice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11340 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d926b1b-0bf5-45e4-80a3-4187cf0005a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 4 in C minor. Presto energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11340 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f781fd00-d1d4-45a6-b929-92e61ddec4c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f781fd00-d1d4-45a6-b929-92e61ddec4c6', 4, NULL, 'C단조', 'No. 4 in C minor. Presto energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11340 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f781fd00-d1d4-45a6-b929-92e61ddec4c6'
);


-- Op. 3 4개의 소품 Op. 3

UPDATE pieces piece
SET piece.title = '4개의 소품 Op. 3', piece.title_en = '4 Pieces, Op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(1911, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11590 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1911
WHERE piece.id = 11590 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '옛이야기', part.name_en = 'Conte (Story)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11590 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:28ecb84d-fd39-40f3-bce1-17dc83db8e7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28ecb84d-fd39-40f3-bce1-17dc83db8e7d', 1, NULL, '옛이야기', 'Conte (Story)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11590 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28ecb84d-fd39-40f3-bce1-17dc83db8e7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '농담', part.name_en = 'Badinage (Jest)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11590 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:692d970d-0106-4f5e-b32c-60fb90744c8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:692d970d-0106-4f5e-b32c-60fb90744c8f', 2, NULL, '농담', 'Badinage (Jest)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11590 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:692d970d-0106-4f5e-b32c-60fb90744c8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '행진곡', part.name_en = 'Marche (March)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11590 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a83855de-b35a-4889-ae23-dc188e0fad28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a83855de-b35a-4889-ae23-dc188e0fad28', 3, NULL, '행진곡', 'Marche (March)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11590 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a83855de-b35a-4889-ae23-dc188e0fad28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '유령', part.name_en = 'Fantôme (Phantom)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11590 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ac3ebe17-43a2-4629-9b28-201199ba6f07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac3ebe17-43a2-4629-9b28-201199ba6f07', 4, NULL, '유령', 'Fantôme (Phantom)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11590 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac3ebe17-43a2-4629-9b28-201199ba6f07'
);


-- Op. 4 4개의 소품 Op. 4

UPDATE pieces piece
SET piece.title = '4개의 소품 Op. 4', piece.title_en = '4 Pieces, Op. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '4',
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11353 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 11353 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '회상', part.name_en = 'Réminiscence (Reminiscences)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11353 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:baeecfb2-5a6a-44ee-99be-62c2b5390908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baeecfb2-5a6a-44ee-99be-62c2b5390908', 1, NULL, '회상', 'Réminiscence (Reminiscences)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11353 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baeecfb2-5a6a-44ee-99be-62c2b5390908'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '충동', part.name_en = 'Élan (Ardour)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11353 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2b19f4ce-b80a-4566-8c3c-9e4d511db494' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b19f4ce-b80a-4566-8c3c-9e4d511db494', 2, NULL, '충동', 'Élan (Ardour)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11353 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b19f4ce-b80a-4566-8c3c-9e4d511db494'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '절망', part.name_en = 'Désespoir (Despair)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11353 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0aba9a65-6b85-429a-a144-b4e4f758bb64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aba9a65-6b85-429a-a144-b4e4f758bb64', 3, NULL, '절망', 'Désespoir (Despair)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11353 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aba9a65-6b85-429a-a144-b4e4f758bb64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '악마적 암시', part.name_en = 'Suggestion diabolique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11353 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a49bb637-39e1-4b2f-a5aa-8ea352c7c29c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a49bb637-39e1-4b2f-a5aa-8ea352c7c29c', 4, NULL, '악마적 암시', 'Suggestion diabolique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11353 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a49bb637-39e1-4b2f-a5aa-8ea352c7c29c'
);


-- Op. 5 신포니에타 A장조 (원판)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니에타 A장조 (원판)', 'Sinfonietta in A major (original version)', 'album', 'Op. 5', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니에타 A장조 (원판)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op005:1', 1, 'I', 'Allegro giocoso', 'I. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '신포니에타 A장조 (원판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op005:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op005:2', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '신포니에타 A장조 (원판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op005:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op005:3', 3, 'III', '인테르메초. Vivace', 'III. Intermezzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '신포니에타 A장조 (원판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op005:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op005:4', 4, 'IV', '스케르초. Allegro risoluto', 'IV. Scherzo. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '신포니에타 A장조 (원판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op005:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op005:5', 5, 'V', 'Allegro giocoso', 'V. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '신포니에타 A장조 (원판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op005:5'
);


-- Op. 6 교향적 그림 <꿈>

UPDATE pieces piece
SET piece.title = '교향적 그림 <꿈>', piece.title_en = 'Dreams (Rêves), Symphonic Picture',
    piece.type = 'song', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11595 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 11595 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 7 여성 합창과 관현악을 위한 2개의 시

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 합창과 관현악을 위한 2개의 시', '2 Poems for Female Chorus and Orchestra, Op. 7', 'album', 'Op. 7', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 합창과 관현악을 위한 2개의 시'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11950 AND linked.composer_id = 84), 'musicbrainz:e38fea6b-51c3-4a52-84c6-491e973ba751', 1, NULL, 'Belyy lebed''', 'Belyy lebed'' (The White Swan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '여성 합창과 관현악을 위한 2개의 시' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e38fea6b-51c3-4a52-84c6-491e973ba751'
);

UPDATE pieces piece
SET piece.title = '여성 합창과 관현악을 위한 2개의 시 중 "Belyy lebed''"', piece.title_en = '2 Poems for Female Chorus and Orchestra, Op. 7: Belyy lebed'' (The White Swan)', piece.editor_locked = 1
WHERE piece.id = 11950 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op007:2', 2, NULL, 'Volna', 'Volna (The Wave)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '여성 합창과 관현악을 위한 2개의 시' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op007:2'
);


-- Op. 8 교향적 스케치 <가을>

UPDATE pieces piece
SET piece.title = '교향적 스케치 <가을>', piece.title_en = 'Autumnal (Esquisse automnale), Symphonic Sketch',
    piece.type = 'song', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11303 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 11303 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 9 2개의 시 Op. 9

UPDATE pieces piece
SET piece.title = '2개의 시 Op. 9', piece.title_en = '2 Poems, Op. 9',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '9',
    piece.composition_year = COALESCE(1911, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11883 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1911
WHERE piece.id = 11883 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Est'' drugie planety', part.name_en = 'Est'' drugie planety (There Are Other Planets)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11883 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f8e3983a-016e-401a-9a5a-ec2a003d4a54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8e3983a-016e-401a-9a5a-ec2a003d4a54', 1, NULL, 'Est'' drugie planety', 'Est'' drugie planety (There Are Other Planets)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11883 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8e3983a-016e-401a-9a5a-ec2a003d4a54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Otchalila lodka', part.name_en = 'Otchalila lodka (The Drifting Boat)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11883 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5128d8a6-41fd-4c04-88ff-a9e632d24c43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5128d8a6-41fd-4c04-88ff-a9e632d24c43', 2, NULL, 'Otchalila lodka', 'Otchalila lodka (The Drifting Boat)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11883 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5128d8a6-41fd-4c04-88ff-a9e632d24c43'
);


-- Op. 10 피아노 협주곡 1번 D♭장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 1번 D♭장조', piece.title_en = 'Piano Concerto No. 1 in D♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11346 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 11346 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro brioso', part.name_en = 'I. Allegro brioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11346 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c36cdcff-9dd8-4a50-a3f6-70ca165e599f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c36cdcff-9dd8-4a50-a3f6-70ca165e599f', 1, 'I', 'Allegro brioso', 'I. Allegro brioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11346 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c36cdcff-9dd8-4a50-a3f6-70ca165e599f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante assai', part.name_en = 'II. Andante assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11346 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:092000a2-5325-4204-a7b8-75aed92c7410' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:092000a2-5325-4204-a7b8-75aed92c7410', 2, 'II', 'Andante assai', 'II. Andante assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11346 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:092000a2-5325-4204-a7b8-75aed92c7410'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro scherzando', part.name_en = 'III. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11346 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1e4dce78-c0a8-4599-bd29-36fddecbf75e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e4dce78-c0a8-4599-bd29-36fddecbf75e', 3, 'III', 'Allegro scherzando', 'III. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11346 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e4dce78-c0a8-4599-bd29-36fddecbf75e'
);


-- Op. 11 토카타 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타 D단조', 'Toccata in D minor', 'song', 'Op. 11', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2bbcf966-9e50-3528-8752-e3ef41ddc9fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2bbcf966-9e50-3528-8752-e3ef41ddc9fe'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '토카타 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2bbcf966-9e50-3528-8752-e3ef41ddc9fe'
);


-- Op. 12 10개의 소품 Op. 12

UPDATE pieces piece
SET piece.title = '10개의 소품 Op. 12', piece.title_en = '10 Pieces, Op. 12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '12',
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11775 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 11775 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '행진곡', part.name_en = 'Marche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1f7f0032-6b84-43ca-bd7d-5e01b70e7801' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f7f0032-6b84-43ca-bd7d-5e01b70e7801', 1, NULL, '행진곡', 'Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f7f0032-6b84-43ca-bd7d-5e01b70e7801'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '가보트', part.name_en = 'Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3aab8628-9b41-4ad2-b33f-5b5d19f035c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aab8628-9b41-4ad2-b33f-5b5d19f035c8', 2, NULL, '가보트', 'Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aab8628-9b41-4ad2-b33f-5b5d19f035c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '리고동', part.name_en = 'Rigaudon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:fa6e3ad3-72de-4b9e-986a-82fecb53e22f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa6e3ad3-72de-4b9e-986a-82fecb53e22f', 3, NULL, '리고동', 'Rigaudon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa6e3ad3-72de-4b9e-986a-82fecb53e22f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '마주르카', part.name_en = 'Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a8f603d8-fce9-4738-a67d-44a10a21c6c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8f603d8-fce9-4738-a67d-44a10a21c6c4', 4, NULL, '마주르카', 'Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8f603d8-fce9-4738-a67d-44a10a21c6c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '카프리치오', part.name_en = 'Capriccio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:fe51390a-f898-44be-b9bd-0e7b7626c6a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe51390a-f898-44be-b9bd-0e7b7626c6a2', 5, NULL, '카프리치오', 'Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe51390a-f898-44be-b9bd-0e7b7626c6a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '전설', part.name_en = 'Légende',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ffaed9af-669e-4af5-9374-63e82e9aa3be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffaed9af-669e-4af5-9374-63e82e9aa3be', 6, NULL, '전설', 'Légende', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffaed9af-669e-4af5-9374-63e82e9aa3be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:95944e82-9a45-4d4b-b128-045d04bec539' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95944e82-9a45-4d4b-b128-045d04bec539', 7, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95944e82-9a45-4d4b-b128-045d04bec539'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '알망드', part.name_en = 'Allemande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3b7acf5b-f004-4c30-95a3-c79b372011e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b7acf5b-f004-4c30-95a3-c79b372011e6', 8, NULL, '알망드', 'Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7acf5b-f004-4c30-95a3-c79b372011e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '유머러스한 스케르초', part.name_en = 'Scherzo humoristique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:cb8ac92e-3677-4f23-9d9a-145af500b4ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb8ac92e-3677-4f23-9d9a-145af500b4ec', 9, NULL, '유머러스한 스케르초', 'Scherzo humoristique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb8ac92e-3677-4f23-9d9a-145af500b4ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '스케르초', part.name_en = 'Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11775 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f374ffb3-4fdf-4f90-9fa4-364951b56694' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f374ffb3-4fdf-4f90-9fa4-364951b56694', 10, NULL, '스케르초', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11775 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f374ffb3-4fdf-4f90-9fa4-364951b56694'
);


-- Op. 12bis 4대의 바순을 위한 유머러스한 스케르초

UPDATE pieces piece
SET piece.title = '4대의 바순을 위한 유머러스한 스케르초', piece.title_en = 'Humoresque Scherzo for 4 Bassoons',
    piece.type = 'song', piece.opus_number = 'Op. 12bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11784 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 11784 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 14 피아노 소나타 2번 D단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 2번 D단조', piece.title_en = 'Piano Sonata No. 2 in D minor',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11674 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 11674 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro, ma non troppo', part.name_en = 'I. Allegro, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11674 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:30484fba-386f-4897-b937-4a63de09ee36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30484fba-386f-4897-b937-4a63de09ee36', 1, 'I', 'Allegro, ma non troppo', 'I. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11674 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30484fba-386f-4897-b937-4a63de09ee36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Allegro marcato', part.name_en = 'II. Scherzo. Allegro marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11674 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d2490015-9fb6-4abe-9e5b-0c65a93eeae6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2490015-9fb6-4abe-9e5b-0c65a93eeae6', 2, 'II', '스케르초. Allegro marcato', 'II. Scherzo. Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11674 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2490015-9fb6-4abe-9e5b-0c65a93eeae6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11674 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:868dd1ae-1343-327a-8a15-e655c8ebd9bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:868dd1ae-1343-327a-8a15-e655c8ebd9bb', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11674 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:868dd1ae-1343-327a-8a15-e655c8ebd9bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11674 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d7b82ce5-4b31-4dd8-8eb9-0776deac093c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7b82ce5-4b31-4dd8-8eb9-0776deac093c', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11674 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7b82ce5-4b31-4dd8-8eb9-0776deac093c'
);


-- Op. 15 첼로와 피아노를 위한 발라드 C단조

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 발라드 C단조', piece.title_en = 'Ballade in C minor for Cello and Piano',
    piece.type = 'song', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11496 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 11496 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 16 피아노 협주곡 2번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번 G단조', 'Piano Concerto No. 2 in G minor', 'album', 'Op. 16', NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8b0aedf-a0b7-4e9c-90db-284ba7795e8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c8b0aedf-a0b7-4e9c-90db-284ba7795e8a'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 협주곡 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8b0aedf-a0b7-4e9c-90db-284ba7795e8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cc30da4-c023-4cb4-96f5-8a9687e929de', 1, 'I', 'Andantino – Allegretto', 'I. Andantino – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 협주곡 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cc30da4-c023-4cb4-96f5-8a9687e929de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:121086e0-971a-4076-93d3-eef59ac307a4', 2, 'II', '스케르초. Vivace', 'II. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 협주곡 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:121086e0-971a-4076-93d3-eef59ac307a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc2e7ea7-3473-410d-b57f-992c17e3c184', 3, 'III', '인테르메초. Allegro moderato', 'III. Intermezzo. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 협주곡 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc2e7ea7-3473-410d-b57f-992c17e3c184'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f64a2a91-2347-47ca-b4d6-4c5145d0045b', 4, 'IV', '피날레. Allegro tempestoso', 'IV. Finale. Allegro tempestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 협주곡 2번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f64a2a91-2347-47ca-b4d6-4c5145d0045b'
);


-- Op. 17 피아노 소품집 <풍자>

UPDATE pieces piece
SET piece.title = '피아노 소품집 <풍자>', piece.title_en = 'Sarcasms, Op. 17',
    piece.type = 'album', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1914, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11593 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1914
WHERE piece.id = 11593 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tempestoso', part.name_en = 'Tempestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11593 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:23a1145e-87f8-4f80-a789-24ce86048cfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23a1145e-87f8-4f80-a789-24ce86048cfd', 1, NULL, 'Tempestoso', 'Tempestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11593 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23a1145e-87f8-4f80-a789-24ce86048cfd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro rubato', part.name_en = 'Allegro rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11593 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ba38a3f7-f312-44c0-ae03-8712c1d3c006' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba38a3f7-f312-44c0-ae03-8712c1d3c006', 2, NULL, 'Allegro rubato', 'Allegro rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11593 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba38a3f7-f312-44c0-ae03-8712c1d3c006'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro precipitato', part.name_en = 'Allegro precipitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11593 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:00bef7e8-e41f-4427-be7c-860741e5eced' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00bef7e8-e41f-4427-be7c-860741e5eced', 3, NULL, 'Allegro precipitato', 'Allegro precipitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11593 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00bef7e8-e41f-4427-be7c-860741e5eced'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Smanioso', part.name_en = 'Smanioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11593 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8e89d80e-de88-4115-9ced-355b9e36ddec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e89d80e-de88-4115-9ced-355b9e36ddec', 4, NULL, 'Smanioso', 'Smanioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11593 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e89d80e-de88-4115-9ced-355b9e36ddec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Precipitosissimo', part.name_en = 'Precipitosissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11593 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b9dbc553-5233-4ea2-b524-5d9126b43b26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9dbc553-5233-4ea2-b524-5d9126b43b26', 5, NULL, 'Precipitosissimo', 'Precipitosissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11593 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9dbc553-5233-4ea2-b524-5d9126b43b26'
);


-- Op. 18 가곡 <미운 오리 새끼>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <미운 오리 새끼>', 'The Ugly Duckling', 'song', 'Op. 18', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <미운 오리 새끼>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9217bb6-2277-4b96-a1c7-12cd32582034'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b9217bb6-2277-4b96-a1c7-12cd32582034'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '가곡 <미운 오리 새끼>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9217bb6-2277-4b96-a1c7-12cd32582034'
);


-- Op. 19 바이올린 협주곡 1번 D장조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 1번 D장조', piece.title_en = 'Violin Concerto No. 1 in D major',
    piece.type = 'album', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11337 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 11337 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = 'I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11337 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f314a234-dfc1-3ed3-bd7f-6edad7cb4121' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f314a234-dfc1-3ed3-bd7f-6edad7cb4121', 1, 'I', 'Andantino', 'I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11337 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f314a234-dfc1-3ed3-bd7f-6edad7cb4121'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Vivacissimo', part.name_en = 'II. Scherzo. Vivacissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11337 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c569ce6a-a2f3-39cb-ac9c-263ea206aac0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c569ce6a-a2f3-39cb-ac9c-263ea206aac0', 2, 'II', '스케르초. Vivacissimo', 'II. Scherzo. Vivacissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11337 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c569ce6a-a2f3-39cb-ac9c-263ea206aac0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11337 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0b1e0045-be14-3325-a88f-0fa36b8f8a67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b1e0045-be14-3325-a88f-0fa36b8f8a67', 3, 'III', 'Moderato', 'III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11337 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b1e0045-be14-3325-a88f-0fa36b8f8a67'
);


-- Op. 20 스키타이 모음곡 <알라와 롤리>

UPDATE pieces piece
SET piece.title = '스키타이 모음곡 <알라와 롤리>', piece.title_en = 'Scythian Suite (Ala and Lolli)',
    piece.type = 'album', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11316 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 11316 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '벨레스와 알라 숭배', part.name_en = 'I. The Adoration of Veles and Ala',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11316 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e54e6a64-96bc-3d8c-940a-eda496092cff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e54e6a64-96bc-3d8c-940a-eda496092cff', 1, 'I', '벨레스와 알라 숭배', 'I. The Adoration of Veles and Ala', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11316 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e54e6a64-96bc-3d8c-940a-eda496092cff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '적의 신과 악령의 춤', part.name_en = 'II. The Enemy God and the Dance of the Dark Spirits',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11316 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:655a5427-2158-3de2-893b-40d4330eb6a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:655a5427-2158-3de2-893b-40d4330eb6a3', 2, 'II', '적의 신과 악령의 춤', 'II. The Enemy God and the Dance of the Dark Spirits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11316 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:655a5427-2158-3de2-893b-40d4330eb6a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '밤', part.name_en = 'III. Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11316 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5d99294b-2e5b-31a7-96a6-2ed5325a342c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d99294b-2e5b-31a7-96a6-2ed5325a342c', 3, 'III', '밤', 'III. Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11316 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d99294b-2e5b-31a7-96a6-2ed5325a342c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '롤리의 출정과 태양의 행렬', part.name_en = 'IV. Lolli''s Pursuit and the Procession of the Sun',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11316 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:23714727-1205-3504-93e5-9638e9e01269' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23714727-1205-3504-93e5-9638e9e01269', 4, 'IV', '롤리의 출정과 태양의 행렬', 'IV. Lolli''s Pursuit and the Procession of the Sun', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11316 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23714727-1205-3504-93e5-9638e9e01269'
);


-- Op. 21 발레 <어릿광대>

UPDATE pieces piece
SET piece.title = '발레 <어릿광대>', piece.title_en = 'Chout (The Tale of the Buffoon)',
    piece.type = 'song', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1920, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11347 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1920
WHERE piece.id = 11347 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 21bis 발레 모음곡 <어릿광대>

UPDATE pieces piece
SET piece.title = '발레 모음곡 <어릿광대>', piece.title_en = 'Suite from Chout',
    piece.type = 'album', piece.opus_number = 'Op. 21bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1920, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11660 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1920
WHERE piece.id = 11660 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '어릿광대와 아내', part.name_en = 'I. The Buffoon and His Wife',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b8367351-7d71-4eb3-8969-783c80ecda97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8367351-7d71-4eb3-8969-783c80ecda97', 1, 'I', '어릿광대와 아내', 'I. The Buffoon and His Wife', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8367351-7d71-4eb3-8969-783c80ecda97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '어릿광대 아내들의 춤', part.name_en = 'II. Dance of the Buffoons'' Wives',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3f83f94a-f7a1-438b-9c03-d251ffb5f57a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f83f94a-f7a1-438b-9c03-d251ffb5f57a', 2, 'II', '어릿광대 아내들의 춤', 'II. Dance of the Buffoons'' Wives', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f83f94a-f7a1-438b-9c03-d251ffb5f57a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '아내를 죽이는 어릿광대들 (푸가)', part.name_en = 'III. The Buffoons Kill Their Wives (Fugue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3b3a8fa6-3e33-4278-b2aa-6a913509edeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b3a8fa6-3e33-4278-b2aa-6a913509edeb', 3, 'III', '아내를 죽이는 어릿광대들 (푸가)', 'III. The Buffoons Kill Their Wives (Fugue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b3a8fa6-3e33-4278-b2aa-6a913509edeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '젊은 여인으로 꾸민 어릿광대', part.name_en = 'IV. The Buffoon Disguised as a Young Woman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3e4c1b7d-560a-482d-9d2c-8b0f23d3e43f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e4c1b7d-560a-482d-9d2c-8b0f23d3e43f', 4, 'IV', '젊은 여인으로 꾸민 어릿광대', 'IV. The Buffoon Disguised as a Young Woman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e4c1b7d-560a-482d-9d2c-8b0f23d3e43f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '세 번째 막간', part.name_en = 'V. Third Entr''acte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b262fe86-6f40-4a6f-aaf2-3e439c53b1e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b262fe86-6f40-4a6f-aaf2-3e439c53b1e3', 5, 'V', '세 번째 막간', 'V. Third Entr''acte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b262fe86-6f40-4a6f-aaf2-3e439c53b1e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '어릿광대 딸들의 춤', part.name_en = 'VI. Dance of the Buffoons'' Daughters',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:fbe7db13-3d17-4f9a-a2bc-873bc01a017d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbe7db13-3d17-4f9a-a2bc-873bc01a017d', 6, 'VI', '어릿광대 딸들의 춤', 'VI. Dance of the Buffoons'' Daughters', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbe7db13-3d17-4f9a-a2bc-873bc01a017d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '상인의 도착과 환영', part.name_en = 'VII. Arrival of the Merchant and His Welcome',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0287c27d-68d8-4561-916a-dab33ee4ac0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0287c27d-68d8-4561-916a-dab33ee4ac0c', 7, 'VII', '상인의 도착과 환영', 'VII. Arrival of the Merchant and His Welcome', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0287c27d-68d8-4561-916a-dab33ee4ac0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '상인의 침실에서', part.name_en = 'VIII. In the Merchant''s Bedroom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:bce1c1d0-6a09-4601-baef-43e6fdbfab1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bce1c1d0-6a09-4601-baef-43e6fdbfab1a', 8, 'VIII', '상인의 침실에서', 'VIII. In the Merchant''s Bedroom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bce1c1d0-6a09-4601-baef-43e6fdbfab1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = '염소로 변한 젊은 여인', part.name_en = 'IX. The Young Woman Becomes a Goat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b1b78001-e917-4997-ae73-6501c1641de4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1b78001-e917-4997-ae73-6501c1641de4', 9, 'IX', '염소로 변한 젊은 여인', 'IX. The Young Woman Becomes a Goat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1b78001-e917-4997-ae73-6501c1641de4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = '다섯 번째 막간과 염소의 장례', part.name_en = 'X. Fifth Entr''acte and the Goat''s Burial',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:db40cb06-b11d-4f98-9180-7b139e8cfde2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db40cb06-b11d-4f98-9180-7b139e8cfde2', 10, 'X', '다섯 번째 막간과 염소의 장례', 'X. Fifth Entr''acte and the Goat''s Burial', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db40cb06-b11d-4f98-9180-7b139e8cfde2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = '어릿광대와 상인의 다툼', part.name_en = 'XI. The Buffoon Quarrels with the Merchant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:921b7a50-b253-48b8-8957-00d0bfed92bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:921b7a50-b253-48b8-8957-00d0bfed92bc', 11, 'XI', '어릿광대와 상인의 다툼', 'XI. The Buffoon Quarrels with the Merchant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:921b7a50-b253-48b8-8957-00d0bfed92bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = '마지막 춤', part.name_en = 'XII. Final Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11660 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f2bd1a47-ef9d-4e06-9c10-ae61a2b2d480' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2bd1a47-ef9d-4e06-9c10-ae61a2b2d480', 12, 'XII', '마지막 춤', 'XII. Final Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11660 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2bd1a47-ef9d-4e06-9c10-ae61a2b2d480'
);


-- Op. 22 피아노 소품집 <덧없는 환영>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소품집 <덧없는 환영>', 'Visions fugitives, Op. 22', 'album', 'Op. 22', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소품집 <덧없는 환영>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b551b81f-b71b-4143-95f0-f7316cf8b3f4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b551b81f-b71b-4143-95f0-f7316cf8b3f4'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b551b81f-b71b-4143-95f0-f7316cf8b3f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0af31e86-2def-41fe-8305-b785c7aae1b1', 1, NULL, 'Lentamente', 'Lentamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0af31e86-2def-41fe-8305-b785c7aae1b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80881c6f-f740-4d10-a5f7-0638383d55ae', 2, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80881c6f-f740-4d10-a5f7-0638383d55ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84f1cca0-600e-34af-a0b8-05a92090e1e0', 3, NULL, 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84f1cca0-600e-34af-a0b8-05a92090e1e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b20de84-958e-4a41-aca3-549ff7727d6d', 4, NULL, 'Animato', 'Animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b20de84-958e-4a41-aca3-549ff7727d6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4b8ec94-f2dc-344d-adb8-ed26f29eac22', 5, NULL, 'Molto giocoso', 'Molto giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b8ec94-f2dc-344d-adb8-ed26f29eac22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71a1050d-91b9-3935-854e-2cea60056bb2', 6, NULL, 'Con eleganza', 'Con eleganza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71a1050d-91b9-3935-854e-2cea60056bb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6065b1a9-885d-4245-bb41-a1c94eec2820', 7, NULL, 'Pittoresco (Arpa)', 'Pittoresco (Arpa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6065b1a9-885d-4245-bb41-a1c94eec2820'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5dd14ad-300c-4c57-a5ac-76f797c5fc7b', 8, NULL, 'Commodo', 'Commodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5dd14ad-300c-4c57-a5ac-76f797c5fc7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54e03e90-e038-3700-a366-cab2cb407e4f', 9, NULL, 'Allegretto tranquillo', 'Allegretto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54e03e90-e038-3700-a366-cab2cb407e4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6831826e-dc60-3abc-99e4-44f104222760', 10, NULL, 'Ridicolosamente', 'Ridicolosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6831826e-dc60-3abc-99e4-44f104222760'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d614637c-1bf9-3378-a4d3-c2fba6554660', 11, NULL, 'Con vivacità', 'Con vivacità', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d614637c-1bf9-3378-a4d3-c2fba6554660'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e313061d-1948-455c-ba78-53b617f19d72', 12, NULL, 'Assai moderato', 'Assai moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e313061d-1948-455c-ba78-53b617f19d72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b271605f-26f0-429c-a4ca-644f59459460', 13, NULL, 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b271605f-26f0-429c-a4ca-644f59459460'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ce5fb62-3da8-468c-b0e2-77b7228b86d3', 14, NULL, 'Feroce', 'Feroce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ce5fb62-3da8-468c-b0e2-77b7228b86d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5828236-843a-4708-833a-7d59fae0f741', 15, NULL, 'Inquieto', 'Inquieto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5828236-843a-4708-833a-7d59fae0f741'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98379836-87aa-3349-9433-8cba28e6700e', 16, NULL, 'Dolente', 'Dolente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98379836-87aa-3349-9433-8cba28e6700e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8db952c6-2c1e-3555-a90b-18577b42b739', 17, NULL, 'Poetico', 'Poetico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8db952c6-2c1e-3555-a90b-18577b42b739'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b739283a-b244-371a-92cc-9923bdc60b46', 18, NULL, 'Con una dolce lentezza', 'Con una dolce lentezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b739283a-b244-371a-92cc-9923bdc60b46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c6ace9b-812a-401d-9328-68ce0d025256', 19, NULL, 'Presto agitatissimo e molto accentuato', 'Presto agitatissimo e molto accentuato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c6ace9b-812a-401d-9328-68ce0d025256'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd6f85f2-b72c-49ff-b605-5f9e61244e80', 20, NULL, 'Lento irrealmente', 'Lento irrealmente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소품집 <덧없는 환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd6f85f2-b72c-49ff-b605-5f9e61244e80'
);


-- Op. 23 5개의 시 Op. 23

UPDATE pieces piece
SET piece.title = '5개의 시 Op. 23', piece.title_en = '5 Poems, Op. 23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '23',
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11711 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 11711 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pod kryshey', part.name_en = 'Pod kryshey (Under the Roof)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11711 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4fe80e17-36c4-4abc-9883-f9369cd43300' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fe80e17-36c4-4abc-9883-f9369cd43300', 1, NULL, 'Pod kryshey', 'Pod kryshey (Under the Roof)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11711 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fe80e17-36c4-4abc-9883-f9369cd43300'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Seroe plat''itse', part.name_en = 'Seroe plat''itse (The Little Grey Dress)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11711 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7db14103-a9b0-464c-9f4f-13973d840b60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7db14103-a9b0-464c-9f4f-13973d840b60', 2, NULL, 'Seroe plat''itse', 'Seroe plat''itse (The Little Grey Dress)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11711 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7db14103-a9b0-464c-9f4f-13973d840b60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dover''sya mne', part.name_en = 'Dover''sya mne (Trust Me)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11711 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3493b132-ea52-4efb-bb15-3a46055d465e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3493b132-ea52-4efb-bb15-3a46055d465e', 3, NULL, 'Dover''sya mne', 'Dover''sya mne (Trust Me)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11711 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3493b132-ea52-4efb-bb15-3a46055d465e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'V moyom sadu', part.name_en = 'V moyom sadu (In My Garden)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11711 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:295c22e2-229a-4930-8293-3ed26ae30101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:295c22e2-229a-4930-8293-3ed26ae30101', 4, NULL, 'V moyom sadu', 'V moyom sadu (In My Garden)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11711 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:295c22e2-229a-4930-8293-3ed26ae30101'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Kudesnik', part.name_en = 'Kudesnik (The Wizard)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11711 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0453bf5c-894a-46d4-bdf8-da214681d043' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0453bf5c-894a-46d4-bdf8-da214681d043', 5, NULL, 'Kudesnik', 'Kudesnik (The Wizard)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11711 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0453bf5c-894a-46d4-bdf8-da214681d043'
);


-- Op. 24 오페라 <도박사>

UPDATE pieces piece
SET piece.title = '오페라 <도박사>', piece.title_en = 'The Gambler (Igrok)',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1928, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11569 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1928
WHERE piece.id = 11569 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 25 교향곡 1번 D장조 "고전 교향곡"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 323 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:67f1261a-1c5c-3706-a514-176cb58e8577' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f1261a-1c5c-3706-a514-176cb58e8577', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 323 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f1261a-1c5c-3706-a514-176cb58e8577'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Larghetto', part.name_en = 'II. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 323 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ff1c5f07-b52a-39cb-9935-1c778aa4bcfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff1c5f07-b52a-39cb-9935-1c778aa4bcfb', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 323 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff1c5f07-b52a-39cb-9935-1c778aa4bcfb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '가보트. Non troppo allegro', part.name_en = 'III. Gavotta. Non troppo allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 323 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:93d9ec4c-407e-32ea-bf0d-6f0a1539f940' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93d9ec4c-407e-32ea-bf0d-6f0a1539f940', 3, 'III', '가보트. Non troppo allegro', 'III. Gavotta. Non troppo allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 323 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93d9ec4c-407e-32ea-bf0d-6f0a1539f940'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Molto vivace', part.name_en = 'IV. Finale. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 323 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7d6d83f3-1fb8-3fa2-aa54-03e77382ceb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d6d83f3-1fb8-3fa2-aa54-03e77382ceb3', 4, 'IV', '피날레. Molto vivace', 'IV. Finale. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 323 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d6d83f3-1fb8-3fa2-aa54-03e77382ceb3'
);


-- Op. 26 피아노 협주곡 3번 C장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante – Allegro', part.name_en = 'I. Andante – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:582f07ea-9dd9-3e74-8dc0-b45c55994b6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:582f07ea-9dd9-3e74-8dc0-b45c55994b6e', 1, 'I', 'Andante – Allegro', 'I. Andante – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:582f07ea-9dd9-3e74-8dc0-b45c55994b6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '주제와 변주. Andantino', part.name_en = 'II. Tema con variazioni. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6', 2, 'II', '주제와 변주. Andantino', 'II. Tema con variazioni. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '주제. Andantino', part.name_en = 'Tema. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:305723d7-0d1e-425a-a426-3303dc63600a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:305723d7-0d1e-425a-a426-3303dc63600a', 1, NULL, '주제. Andantino', 'Tema. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:305723d7-0d1e-425a-a426-3303dc63600a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '변주 1. L''istesso tempo', part.name_en = 'Var. I. L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1b62d5d2-b390-4707-b616-229eec4a585b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1b62d5d2-b390-4707-b616-229eec4a585b', 2, NULL, '변주 1. L''istesso tempo', 'Var. I. L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b62d5d2-b390-4707-b616-229eec4a585b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '변주 2. Allegro', part.name_en = 'Var. II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f9f18ebf-92e5-4968-bbe0-e52a0eea389e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9f18ebf-92e5-4968-bbe0-e52a0eea389e', 3, NULL, '변주 2. Allegro', 'Var. II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f18ebf-92e5-4968-bbe0-e52a0eea389e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '변주 3. Allegro moderato', part.name_en = 'Var. III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8d2b4b83-2eab-4c47-82d6-9be704b146cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d2b4b83-2eab-4c47-82d6-9be704b146cb', 4, NULL, '변주 3. Allegro moderato', 'Var. III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d2b4b83-2eab-4c47-82d6-9be704b146cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '변주 4. Andante meditativo', part.name_en = 'Var. IV. Andante meditativo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a9959429-563b-4cd0-a412-bf93b7db3350' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9959429-563b-4cd0-a412-bf93b7db3350', 5, NULL, '변주 4. Andante meditativo', 'Var. IV. Andante meditativo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9959429-563b-4cd0-a412-bf93b7db3350'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '변주 5. Allegro giusto', part.name_en = 'Var. V. Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5508e94d-2ba9-45cc-94c3-80c68295bae1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5508e94d-2ba9-45cc-94c3-80c68295bae1', 6, NULL, '변주 5. Allegro giusto', 'Var. V. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5508e94d-2ba9-45cc-94c3-80c68295bae1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '주제. L''istesso tempo', part.name_en = 'Tema. L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:03e23eb6-9c3b-4beb-aab1-6872189fc283' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03e23eb6-9c3b-4beb-aab1-6872189fc283', 7, NULL, '주제. L''istesso tempo', 'Tema. L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cdfbf7ed-2387-3d5f-809c-13bf42287af6'
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03e23eb6-9c3b-4beb-aab1-6872189fc283'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro, ma non troppo', part.name_en = 'III. Allegro, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 325 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f1f9dd88-facb-3a82-b119-a86b05621efd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1f9dd88-facb-3a82-b119-a86b05621efd', 3, 'III', 'Allegro, ma non troppo', 'III. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 325 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1f9dd88-facb-3a82-b119-a86b05621efd'
);


-- Op. 27 아흐마토바의 시에 의한 5개의 가곡

UPDATE pieces piece
SET piece.title = '아흐마토바의 시에 의한 5개의 가곡', piece.title_en = '5 Poems of Anna Akhmatova, Op. 27',
    piece.type = 'album', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1916, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11333 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1916
WHERE piece.id = 11333 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Solntse komnatu napolnilo', part.name_en = 'Solntse komnatu napolnilo (The Sun Has Filled the Room)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11333 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ae3b25b2-d8a0-4551-a182-5476a14f4770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae3b25b2-d8a0-4551-a182-5476a14f4770', 1, NULL, 'Solntse komnatu napolnilo', 'Solntse komnatu napolnilo (The Sun Has Filled the Room)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11333 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae3b25b2-d8a0-4551-a182-5476a14f4770'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nastoyashchuyu nezhnost''', part.name_en = 'Nastoyashchuyu nezhnost'' (True Tenderness)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11333 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6cb9716d-f3d5-440d-b560-4423fc507ea7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cb9716d-f3d5-440d-b560-4423fc507ea7', 2, NULL, 'Nastoyashchuyu nezhnost''', 'Nastoyashchuyu nezhnost'' (True Tenderness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11333 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb9716d-f3d5-440d-b560-4423fc507ea7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pamyat'' o solntse', part.name_en = 'Pamyat'' o solntse (Memory of the Sun)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11333 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6d95548c-a4b0-424d-a78d-61f58d6122dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d95548c-a4b0-424d-a78d-61f58d6122dc', 3, NULL, 'Pamyat'' o solntse', 'Pamyat'' o solntse (Memory of the Sun)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11333 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d95548c-a4b0-424d-a78d-61f58d6122dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Zdravstvuy!', part.name_en = 'Zdravstvuy! (Greeting)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11333 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8bc5d72d-92cc-4dfa-bc8b-25e129f06c54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bc5d72d-92cc-4dfa-bc8b-25e129f06c54', 4, NULL, 'Zdravstvuy!', 'Zdravstvuy! (Greeting)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11333 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bc5d72d-92cc-4dfa-bc8b-25e129f06c54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Seroglazyy korol''', part.name_en = 'Seroglazyy korol'' (The Grey-Eyed King)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11333 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ab0ba8b5-25c6-496b-bd03-0c6a7d99467a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab0ba8b5-25c6-496b-bd03-0c6a7d99467a', 5, NULL, 'Seroglazyy korol''', 'Seroglazyy korol'' (The Grey-Eyed King)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11333 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab0ba8b5-25c6-496b-bd03-0c6a7d99467a'
);


-- Op. 28 피아노 소나타 3번 A단조 "옛 노트에서"

UPDATE pieces piece
SET piece.title = '피아노 소나타 3번 A단조 "옛 노트에서"', piece.title_en = 'Piano Sonata No. 3 in A minor "From Old Notebooks"',
    piece.type = 'song', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11852 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 11852 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 29 피아노 소나타 4번 C단조 "옛 노트에서"

UPDATE pieces piece
SET piece.title = '피아노 소나타 4번 C단조 "옛 노트에서"', piece.title_en = 'Piano Sonata No. 4 in C minor "From Old Notebooks"',
    piece.type = 'album', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11323 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 11323 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto sostenuto', part.name_en = 'I. Allegro molto sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11323 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d654e109-4a1e-39ba-8d43-e4a4911ea06c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d654e109-4a1e-39ba-8d43-e4a4911ea06c', 1, 'I', 'Allegro molto sostenuto', 'I. Allegro molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11323 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d654e109-4a1e-39ba-8d43-e4a4911ea06c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante assai', part.name_en = 'II. Andante assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11323 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:55d281c0-bc58-3fe6-ba65-e12c973a315b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55d281c0-bc58-3fe6-ba65-e12c973a315b', 2, 'II', 'Andante assai', 'II. Andante assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11323 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55d281c0-bc58-3fe6-ba65-e12c973a315b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con brio, ma non leggiero', part.name_en = 'III. Allegro con brio, ma non leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11323 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:14962d80-9ff9-3a88-a576-3c6fd3c53d44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14962d80-9ff9-3a88-a576-3c6fd3c53d44', 3, 'III', 'Allegro con brio, ma non leggiero', 'III. Allegro con brio, ma non leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11323 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14962d80-9ff9-3a88-a576-3c6fd3c53d44'
);


-- Op. 29bis 관현악을 위한 안단테 (피아노 소나타 4번에서)

UPDATE pieces piece
SET piece.title = '관현악을 위한 안단테 (피아노 소나타 4번에서)', piece.title_en = 'Andante from Piano Sonata No. 4, for orchestra',
    piece.type = 'song', piece.opus_number = 'Op. 29bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11648 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 11648 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 30 칸타타 <그들은 일곱>

UPDATE pieces piece
SET piece.title = '칸타타 <그들은 일곱>', piece.title_en = 'Seven, They Are Seven',
    piece.type = 'song', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1933, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11482 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1933
WHERE piece.id = 11482 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 31 피아노 소품집 <할머니의 옛이야기>

UPDATE pieces piece
SET piece.title = '피아노 소품집 <할머니의 옛이야기>', piece.title_en = 'Tales of an Old Grandmother, Op. 31',
    piece.type = 'album', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11328 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 11328 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11328 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f5d93936-2878-47de-b928-420d9bca2450' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5d93936-2878-47de-b928-420d9bca2450', 1, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11328 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5d93936-2878-47de-b928-420d9bca2450'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11328 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8ee9baf1-f724-4985-9262-92cc94151a9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ee9baf1-f724-4985-9262-92cc94151a9c', 2, NULL, 'Andantino', 'Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11328 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee9baf1-f724-4985-9262-92cc94151a9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante assai', part.name_en = 'Andante assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11328 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a9cd09e3-dfdc-4ddf-a5fe-1590d7a9ab19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9cd09e3-dfdc-4ddf-a5fe-1590d7a9ab19', 3, NULL, 'Andante assai', 'Andante assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11328 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9cd09e3-dfdc-4ddf-a5fe-1590d7a9ab19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sostenuto', part.name_en = 'Sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11328 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a20a3eff-96b7-4c50-bc01-3c6fa1feeb45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a20a3eff-96b7-4c50-bc01-3c6fa1feeb45', 4, NULL, 'Sostenuto', 'Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11328 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a20a3eff-96b7-4c50-bc01-3c6fa1feeb45'
);


-- Op. 32 4개의 소품 Op. 32

UPDATE pieces piece
SET piece.title = '4개의 소품 Op. 32', piece.title_en = '4 Pieces, Op. 32',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '32',
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11331 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 11331 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '춤', part.name_en = 'Danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11331 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:97aeb792-a3a6-45dd-96c1-55aeac3adf09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97aeb792-a3a6-45dd-96c1-55aeac3adf09', 1, NULL, '춤', 'Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11331 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97aeb792-a3a6-45dd-96c1-55aeac3adf09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '미뉴에트', part.name_en = 'Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11331 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8cae9f61-f9aa-4e87-87eb-30a8f93cd366' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cae9f61-f9aa-4e87-87eb-30a8f93cd366', 2, NULL, '미뉴에트', 'Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11331 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cae9f61-f9aa-4e87-87eb-30a8f93cd366'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '가보트', part.name_en = 'Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11331 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6fb5c539-bb9a-3a94-834f-888b2379893a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fb5c539-bb9a-3a94-834f-888b2379893a', 3, NULL, '가보트', 'Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11331 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fb5c539-bb9a-3a94-834f-888b2379893a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '왈츠', part.name_en = 'Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11331 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3e898339-10c0-4298-8a2e-7410c65c9f2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e898339-10c0-4298-8a2e-7410c65c9f2a', 4, NULL, '왈츠', 'Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11331 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e898339-10c0-4298-8a2e-7410c65c9f2a'
);


-- Op. 33 오페라 <세 개의 오렌지에 대한 사랑>

UPDATE pieces piece
SET piece.title = '오페라 <세 개의 오렌지에 대한 사랑>', piece.title_en = 'The Love for Three Oranges',
    piece.type = 'song', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11672 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 11672 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 33bis 교향 모음곡 <세 개의 오렌지에 대한 사랑>

UPDATE pieces piece
SET piece.title = '교향 모음곡 <세 개의 오렌지에 대한 사랑>', piece.title_en = 'Suite from The Love for Three Oranges',
    piece.type = 'album', piece.opus_number = 'Op. 33bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1924, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11894 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1924
WHERE piece.id = 11894 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '괴짜들', part.name_en = 'I. Les Ridicules',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11894 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8ca0294a-a0d7-3233-865a-04bd0eb7942b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ca0294a-a0d7-3233-865a-04bd0eb7942b', 1, 'I', '괴짜들', 'I. Les Ridicules', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11894 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ca0294a-a0d7-3233-865a-04bd0eb7942b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '지옥 장면', part.name_en = 'II. Scène infernale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11894 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b9405aca-3386-3e8e-9a47-7ecb5a1eca25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9405aca-3386-3e8e-9a47-7ecb5a1eca25', 2, 'II', '지옥 장면', 'II. Scène infernale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11894 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9405aca-3386-3e8e-9a47-7ecb5a1eca25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '행진곡', part.name_en = 'III. Marche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11894 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0caf9512-7f6a-3edd-abb1-7386b3f186ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0caf9512-7f6a-3edd-abb1-7386b3f186ee', 3, 'III', '행진곡', 'III. Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11894 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0caf9512-7f6a-3edd-abb1-7386b3f186ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '스케르초', part.name_en = 'IV. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11894 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6b96907a-12c9-33e6-b6b7-5cfec26c28c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b96907a-12c9-33e6-b6b7-5cfec26c28c4', 4, 'IV', '스케르초', 'IV. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11894 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b96907a-12c9-33e6-b6b7-5cfec26c28c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '왕자와 공주', part.name_en = 'V. Le Prince et la Princesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11894 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:70de87d8-85df-3a11-a441-fca61496dbe8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70de87d8-85df-3a11-a441-fca61496dbe8', 5, 'V', '왕자와 공주', 'V. Le Prince et la Princesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11894 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70de87d8-85df-3a11-a441-fca61496dbe8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '도주', part.name_en = 'VI. La Fuite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11894 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:df82a227-0da5-3012-b1cc-442cc589d1fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df82a227-0da5-3012-b1cc-442cc589d1fe', 6, 'VI', '도주', 'VI. La Fuite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11894 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df82a227-0da5-3012-b1cc-442cc589d1fe'
);


-- Op. 33ter <세 개의 오렌지에 대한 사랑>에서 행진곡과 스케르초

UPDATE pieces piece
SET piece.title = '<세 개의 오렌지에 대한 사랑>에서 행진곡과 스케르초', piece.title_en = 'March and Scherzo from The Love for Three Oranges, for piano',
    piece.type = 'album', piece.opus_number = 'Op. 33ter',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1922, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11654 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1922
WHERE piece.id = 11654 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '행진곡', part.name_en = 'March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11654 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0534c41a-8bc4-4141-a876-679c8ae4a8f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0534c41a-8bc4-4141-a876-679c8ae4a8f6', 1, NULL, '행진곡', 'March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11654 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0534c41a-8bc4-4141-a876-679c8ae4a8f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '스케르초', part.name_en = 'Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11654 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:81367c47-d7e4-4f99-8f5f-616f715553b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81367c47-d7e4-4f99-8f5f-616f715553b3', 2, NULL, '스케르초', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11654 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81367c47-d7e4-4f99-8f5f-616f715553b3'
);


-- Op. 34 유대 주제에 의한 서곡

UPDATE pieces piece
SET piece.title = '유대 주제에 의한 서곡', piece.title_en = 'Overture on Hebrew Themes, for clarinet, string quartet and piano',
    piece.type = 'song', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11437 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 11437 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 34bis 유대 주제에 의한 서곡 (관현악판)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '유대 주제에 의한 서곡 (관현악판)', 'Overture on Hebrew Themes, for orchestra', 'song', 'Op. 34bis', NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '유대 주제에 의한 서곡 (관현악판)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '472b47c9-bb15-4383-af0d-1e61e519c47f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '472b47c9-bb15-4383-af0d-1e61e519c47f'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '유대 주제에 의한 서곡 (관현악판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '472b47c9-bb15-4383-af0d-1e61e519c47f'
);


-- Op. 35 5개의 무언가 Op. 35

UPDATE pieces piece
SET piece.title = '5개의 무언가 Op. 35', piece.title_en = '5 Songs Without Words, Op. 35',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '35',
    piece.composition_year = COALESCE(1920, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11338 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1920
WHERE piece.id = 11338 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11338 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ebf58ebe-6179-491f-b587-29279d9a4064' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebf58ebe-6179-491f-b587-29279d9a4064', 1, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11338 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebf58ebe-6179-491f-b587-29279d9a4064'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lento, ma non troppo', part.name_en = 'Lento, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11338 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:50b9b048-d3d3-453b-b7b5-7bb20303d059' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50b9b048-d3d3-453b-b7b5-7bb20303d059', 2, NULL, 'Lento, ma non troppo', 'Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11338 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b9b048-d3d3-453b-b7b5-7bb20303d059'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Animato, ma non allegro', part.name_en = 'Animato, ma non allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11338 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4354cde1-344f-4b4c-a722-fc9638dd93aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4354cde1-344f-4b4c-a722-fc9638dd93aa', 3, NULL, 'Animato, ma non allegro', 'Animato, ma non allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11338 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4354cde1-344f-4b4c-a722-fc9638dd93aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andantino, un poco scherzando', part.name_en = 'Andantino, un poco scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11338 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:af628cbe-c417-4fb0-aab5-df4275c85b41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af628cbe-c417-4fb0-aab5-df4275c85b41', 4, NULL, 'Andantino, un poco scherzando', 'Andantino, un poco scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11338 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af628cbe-c417-4fb0-aab5-df4275c85b41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante non troppo', part.name_en = 'Andante non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11338 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9e2e119d-d154-40b6-8952-471762430793' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e2e119d-d154-40b6-8952-471762430793', 5, NULL, 'Andante non troppo', 'Andante non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11338 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e2e119d-d154-40b6-8952-471762430793'
);


-- Op. 35bis 바이올린과 피아노를 위한 5개의 멜로디

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 5개의 멜로디', piece.title_en = '5 Melodies for Violin and Piano, Op. 35bis',
    piece.type = 'album', piece.opus_number = 'Op. 35bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1925, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11918 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1925
WHERE piece.id = 11918 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11918 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0044b29e-087c-3911-9715-0c4d4901193c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0044b29e-087c-3911-9715-0c4d4901193c', 1, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11918 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0044b29e-087c-3911-9715-0c4d4901193c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lento, ma non troppo', part.name_en = 'Lento, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11918 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:728cec30-e9ac-3fab-ae3c-448c56ed63a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:728cec30-e9ac-3fab-ae3c-448c56ed63a4', 2, NULL, 'Lento, ma non troppo', 'Lento, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11918 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:728cec30-e9ac-3fab-ae3c-448c56ed63a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Animato, ma non allegro', part.name_en = 'Animato, ma non allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11918 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e0785ef0-3577-3470-9988-15faa99f9f3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0785ef0-3577-3470-9988-15faa99f9f3c', 3, NULL, 'Animato, ma non allegro', 'Animato, ma non allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11918 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0785ef0-3577-3470-9988-15faa99f9f3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegretto leggero e scherzando', part.name_en = 'Allegretto leggero e scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11918 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:21f6c9d8-bbb1-3a5f-b77d-7ec54c044e2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21f6c9d8-bbb1-3a5f-b77d-7ec54c044e2e', 4, NULL, 'Allegretto leggero e scherzando', 'Allegretto leggero e scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11918 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f6c9d8-bbb1-3a5f-b77d-7ec54c044e2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante non troppo', part.name_en = 'Andante non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11918 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:aa5d8036-9d5e-302d-bce4-20aa5caa7daf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa5d8036-9d5e-302d-bce4-20aa5caa7daf', 5, NULL, 'Andante non troppo', 'Andante non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11918 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa5d8036-9d5e-302d-bce4-20aa5caa7daf'
);


-- Op. 36 발몬트의 시에 의한 5개의 가곡

UPDATE pieces piece
SET piece.title = '발몬트의 시에 의한 5개의 가곡', piece.title_en = '5 Poems of Konstantin Balmont, Op. 36',
    piece.type = 'album', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11304 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 11304 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Zaklinanie vody i ognya', part.name_en = 'Zaklinanie vody i ognya (Incantation of Water and Fire)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11304 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7fd76afc-aec4-4e4c-b3e2-a1d81e59367c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd76afc-aec4-4e4c-b3e2-a1d81e59367c', 1, NULL, 'Zaklinanie vody i ognya', 'Zaklinanie vody i ognya (Incantation of Water and Fire)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11304 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd76afc-aec4-4e4c-b3e2-a1d81e59367c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Golos ptits', part.name_en = 'Golos ptits (Birdsong)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11304 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9a1e834d-1c32-406d-aa7a-cc3d1f82d298' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a1e834d-1c32-406d-aa7a-cc3d1f82d298', 2, NULL, 'Golos ptits', 'Golos ptits (Birdsong)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11304 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a1e834d-1c32-406d-aa7a-cc3d1f82d298'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Babochka', part.name_en = 'Babochka (The Butterfly)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11304 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:93ada549-e200-45af-a15d-4760fb3bb0a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93ada549-e200-45af-a15d-4760fb3bb0a7', 3, NULL, 'Babochka', 'Babochka (The Butterfly)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11304 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93ada549-e200-45af-a15d-4760fb3bb0a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Pomni menya', part.name_en = 'Pomni menya (Remember Me)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11304 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6c092082-fef2-4b2b-9985-a170107b4437' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c092082-fef2-4b2b-9985-a170107b4437', 4, NULL, 'Pomni menya', 'Pomni menya (Remember Me)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11304 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c092082-fef2-4b2b-9985-a170107b4437'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Stolby', part.name_en = 'Stolby (The Pillars)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11304 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:40b7f687-f259-45f1-a34c-d87cd6d06b23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40b7f687-f259-45f1-a34c-d87cd6d06b23', 5, NULL, 'Stolby', 'Stolby (The Pillars)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11304 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40b7f687-f259-45f1-a34c-d87cd6d06b23'
);


-- Op. 37 오페라 <불의 천사>

UPDATE pieces piece
SET piece.title = '오페라 <불의 천사>', piece.title_en = 'The Fiery Angel',
    piece.type = 'song', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1927, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11422 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1927
WHERE piece.id = 11422 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 38 피아노 소나타 5번 C장조 (원판)

UPDATE pieces piece
SET piece.title = '피아노 소나타 5번 C장조 (원판)', piece.title_en = 'Piano Sonata No. 5 in C major (original version)',
    piece.type = 'album', piece.opus_number = 'Op. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1923, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11495 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1923
WHERE piece.id = 11495 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro tranquillo', part.name_en = 'I. Allegro tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11495 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:13329716-32b8-466e-a047-2338883b9725' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13329716-32b8-466e-a047-2338883b9725', 1, 'I', 'Allegro tranquillo', 'I. Allegro tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11495 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13329716-32b8-466e-a047-2338883b9725'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11495 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:135d6235-55b6-4449-ad83-ed12b8bf0c61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:135d6235-55b6-4449-ad83-ed12b8bf0c61', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11495 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:135d6235-55b6-4449-ad83-ed12b8bf0c61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Un poco allegretto', part.name_en = 'III. Un poco allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11495 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6d930d2b-5e1b-4d9c-b037-1d910c43f7d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d930d2b-5e1b-4d9c-b037-1d910c43f7d5', 3, 'III', 'Un poco allegretto', 'III. Un poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11495 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d930d2b-5e1b-4d9c-b037-1d910c43f7d5'
);


-- Op. 39 5중주 G단조

UPDATE pieces piece
SET piece.title = '5중주 G단조', piece.title_en = 'Quintet in G minor for oboe, clarinet, violin, viola and double bass',
    piece.type = 'album', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1924, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11448 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1924
WHERE piece.id = 11448 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '주제와 변주', part.name_en = 'I. Tema con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11448 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f28ae4dd-d58a-4fb5-8cb5-d5ed8b17fc3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f28ae4dd-d58a-4fb5-8cb5-d5ed8b17fc3a', 1, 'I', '주제와 변주', 'I. Tema con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11448 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f28ae4dd-d58a-4fb5-8cb5-d5ed8b17fc3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante energico', part.name_en = 'II. Andante energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11448 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5dc425e9-5f64-4f5e-86e9-a88ef0d5a581' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dc425e9-5f64-4f5e-86e9-a88ef0d5a581', 2, 'II', 'Andante energico', 'II. Andante energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11448 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dc425e9-5f64-4f5e-86e9-a88ef0d5a581'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro sostenuto, ma con brio', part.name_en = 'III. Allegro sostenuto, ma con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11448 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9e756b9b-1a0e-4b1c-b31e-f06ec0825ee9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e756b9b-1a0e-4b1c-b31e-f06ec0825ee9', 3, 'III', 'Allegro sostenuto, ma con brio', 'III. Allegro sostenuto, ma con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11448 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e756b9b-1a0e-4b1c-b31e-f06ec0825ee9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio pesante', part.name_en = 'IV. Adagio pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11448 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5f72e846-3cb9-44d7-a54f-e6a4d3414667' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f72e846-3cb9-44d7-a54f-e6a4d3414667', 4, 'IV', 'Adagio pesante', 'IV. Adagio pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11448 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f72e846-3cb9-44d7-a54f-e6a4d3414667'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro precipitato, ma non troppo presto', part.name_en = 'V. Allegro precipitato, ma non troppo presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11448 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:662159c0-56c7-438d-8e2b-0e77ab69f69e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:662159c0-56c7-438d-8e2b-0e77ab69f69e', 5, 'V', 'Allegro precipitato, ma non troppo presto', 'V. Allegro precipitato, ma non troppo presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11448 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:662159c0-56c7-438d-8e2b-0e77ab69f69e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Andantino', part.name_en = 'VI. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11448 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:68d9d669-58bc-4bfe-bae4-3b49862761bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68d9d669-58bc-4bfe-bae4-3b49862761bd', 6, 'VI', 'Andantino', 'VI. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11448 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68d9d669-58bc-4bfe-bae4-3b49862761bd'
);


-- Op. 40 교향곡 2번 D단조

UPDATE pieces piece
SET piece.title = '교향곡 2번 D단조', piece.title_en = 'Symphony No. 2 in D minor',
    piece.type = 'album', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1925, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11566 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1925
WHERE piece.id = 11566 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ben articolato', part.name_en = 'I. Allegro ben articolato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11566 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:38174f21-68af-3cb8-a9d8-abb097f9bff9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38174f21-68af-3cb8-a9d8-abb097f9bff9', 1, 'I', 'Allegro ben articolato', 'I. Allegro ben articolato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11566 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38174f21-68af-3cb8-a9d8-abb097f9bff9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '주제와 변주', part.name_en = 'II. Tema con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11566 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7cb9d42b-86ae-3d4d-9663-446409ed37bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cb9d42b-86ae-3d4d-9663-446409ed37bb', 2, 'II', '주제와 변주', 'II. Tema con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11566 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cb9d42b-86ae-3d4d-9663-446409ed37bb'
);


-- Op. 41 발레 <강철의 걸음>

UPDATE pieces piece
SET piece.title = '발레 <강철의 걸음>', piece.title_en = 'Le pas d''acier (The Steel Step)',
    piece.type = 'song', piece.opus_number = 'Op. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1926, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11475 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1926
WHERE piece.id = 11475 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 41bis 발레 모음곡 <강철의 걸음>

UPDATE pieces piece
SET piece.title = '발레 모음곡 <강철의 걸음>', piece.title_en = 'Suite from Le pas d''acier',
    piece.type = 'album', piece.opus_number = 'Op. 41bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1926, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11826 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1926
WHERE piece.id = 11826 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '등장인물의 입장', part.name_en = 'I. Entry of the Participants',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11826 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:67c7fa2b-9ce1-42c0-8ba5-f9416a04cac3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67c7fa2b-9ce1-42c0-8ba5-f9416a04cac3', 1, 'I', '등장인물의 입장', 'I. Entry of the Participants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11826 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67c7fa2b-9ce1-42c0-8ba5-f9416a04cac3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '인민위원, 연설가와 시민', part.name_en = 'II. Commissars, Orators and Citizens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11826 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1d7a249b-521b-48ab-b458-8c7e5a304112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d7a249b-521b-48ab-b458-8c7e5a304112', 2, 'II', '인민위원, 연설가와 시민', 'II. Commissars, Orators and Citizens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11826 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d7a249b-521b-48ab-b458-8c7e5a304112'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '수병과 여공', part.name_en = 'III. The Sailor and the Factory Worker',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11826 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:11e62f74-d8d1-4e4b-afc4-14ad6ebdfb05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11e62f74-d8d1-4e4b-afc4-14ad6ebdfb05', 3, 'III', '수병과 여공', 'III. The Sailor and the Factory Worker', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11826 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11e62f74-d8d1-4e4b-afc4-14ad6ebdfb05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '공장', part.name_en = 'IV. The Factory',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11826 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:816425d4-e108-4620-a17e-a6b53511eb4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:816425d4-e108-4620-a17e-a6b53511eb4e', 4, 'IV', '공장', 'IV. The Factory', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11826 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:816425d4-e108-4620-a17e-a6b53511eb4e'
);


-- Op. 42 미국 서곡 B♭장조

UPDATE pieces piece
SET piece.title = '미국 서곡 B♭장조', piece.title_en = 'Overture in B♭ major "American", for 17 instruments',
    piece.type = 'song', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1926, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11506 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1926
WHERE piece.id = 11506 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 42bis 미국 서곡 B♭장조 (관현악판)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미국 서곡 B♭장조 (관현악판)', 'Overture in B♭ major "American", for orchestra', 'song', 'Op. 42bis', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미국 서곡 B♭장조 (관현악판)'
);


-- Op. 43 관현악을 위한 디베르티스망

UPDATE pieces piece
SET piece.title = '관현악을 위한 디베르티스망', piece.title_en = 'Divertissement for orchestra',
    piece.type = 'album', piece.opus_number = 'Op. 43',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11862 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 11862 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato, molto ritmato', part.name_en = 'I. Moderato, molto ritmato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11862 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:487d4080-eec7-42ee-93d3-e884631e6770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:487d4080-eec7-42ee-93d3-e884631e6770', 1, 'I', 'Moderato, molto ritmato', 'I. Moderato, molto ritmato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11862 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:487d4080-eec7-42ee-93d3-e884631e6770'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Larghetto (non troppo lento)', part.name_en = 'II. Larghetto (non troppo lento)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11862 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a97afe36-3ec7-4586-8c6f-4c5cf21fc8e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a97afe36-3ec7-4586-8c6f-4c5cf21fc8e6', 2, 'II', 'Larghetto (non troppo lento)', 'II. Larghetto (non troppo lento)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11862 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a97afe36-3ec7-4586-8c6f-4c5cf21fc8e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro energico', part.name_en = 'III. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11862 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b19e228e-d2ab-493a-8e4b-00dfd2048134' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b19e228e-d2ab-493a-8e4b-00dfd2048134', 3, 'III', 'Allegro energico', 'III. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11862 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b19e228e-d2ab-493a-8e4b-00dfd2048134'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo e pesante', part.name_en = 'IV. Allegro non troppo e pesante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11862 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:20244f6d-c12c-465d-b1f3-1c9a21b8cb2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20244f6d-c12c-465d-b1f3-1c9a21b8cb2c', 4, 'IV', 'Allegro non troppo e pesante', 'IV. Allegro non troppo e pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11862 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20244f6d-c12c-465d-b1f3-1c9a21b8cb2c'
);


-- Op. 43bis 피아노를 위한 디베르티스망

UPDATE pieces piece
SET piece.title = '피아노를 위한 디베르티스망', piece.title_en = 'Divertissement for piano',
    piece.type = 'album', piece.opus_number = 'Op. 43bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1938, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11977 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1938
WHERE piece.id = 11977 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '디베르티스망', part.name_en = 'I. Divertissement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11977 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f84a8f8c-64ec-4c6c-9c8d-d895e6deff7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f84a8f8c-64ec-4c6c-9c8d-d895e6deff7e', 1, 'I', '디베르티스망', 'I. Divertissement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11977 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f84a8f8c-64ec-4c6c-9c8d-d895e6deff7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '녹턴', part.name_en = 'II. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11977 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:569d15d1-dc4e-462c-b001-027c490b66ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:569d15d1-dc4e-462c-b001-027c490b66ad', 2, 'II', '녹턴', 'II. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11977 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:569d15d1-dc4e-462c-b001-027c490b66ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '춤', part.name_en = 'III. Danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11977 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:bda21bc8-0e23-4733-be09-411921347733' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bda21bc8-0e23-4733-be09-411921347733', 3, 'III', '춤', 'III. Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11977 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bda21bc8-0e23-4733-be09-411921347733'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '에필로그', part.name_en = 'IV. Épilogue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11977 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b3a65173-8478-4579-836c-af513a7b3e44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3a65173-8478-4579-836c-af513a7b3e44', 4, 'IV', '에필로그', 'IV. Épilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11977 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3a65173-8478-4579-836c-af513a7b3e44'
);


-- Op. 44 교향곡 3번 C단조

UPDATE pieces piece
SET piece.title = '교향곡 3번 C단조', piece.title_en = 'Symphony No. 3 in C minor',
    piece.type = 'album', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1928, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11898 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1928
WHERE piece.id = 11898 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11898 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c54d060b-ed4a-37b2-a8f2-985b21e6e570' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c54d060b-ed4a-37b2-a8f2-985b21e6e570', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11898 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c54d060b-ed4a-37b2-a8f2-985b21e6e570'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11898 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c9f12f87-f339-3de1-9cd3-a5748928eea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9f12f87-f339-3de1-9cd3-a5748928eea1', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11898 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f12f87-f339-3de1-9cd3-a5748928eea1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro agitato', part.name_en = 'III. Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11898 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c97efdae-c0d6-3a38-974a-2f8fc97d8016' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c97efdae-c0d6-3a38-974a-2f8fc97d8016', 3, 'III', 'Allegro agitato', 'III. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11898 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c97efdae-c0d6-3a38-974a-2f8fc97d8016'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante mosso – Allegro moderato', part.name_en = 'IV. Andante mosso – Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11898 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6ebdbd54-78a2-3f30-b55a-c1b7fb8a1bb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ebdbd54-78a2-3f30-b55a-c1b7fb8a1bb3', 4, 'IV', 'Andante mosso – Allegro moderato', 'IV. Andante mosso – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11898 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ebdbd54-78a2-3f30-b55a-c1b7fb8a1bb3'
);


-- Op. 45 피아노 소품집 <물자체>

UPDATE pieces piece
SET piece.title = '피아노 소품집 <물자체>', piece.title_en = 'Things in Themselves, Op. 45',
    piece.type = 'album', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1928, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11640 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1928
WHERE piece.id = 11640 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11640 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e75a3104-8b5b-4573-ac40-6c126fb6a5a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e75a3104-8b5b-4573-ac40-6c126fb6a5a8', 1, NULL, 'Allegro moderato', 'Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11640 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e75a3104-8b5b-4573-ac40-6c126fb6a5a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Moderato scherzando', part.name_en = 'Moderato scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11640 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7c5d2ba2-0bff-4c5f-b307-51f9b993d812' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c5d2ba2-0bff-4c5f-b307-51f9b993d812', 2, NULL, 'Moderato scherzando', 'Moderato scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11640 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c5d2ba2-0bff-4c5f-b307-51f9b993d812'
);


-- Op. 46 발레 <탕아>

UPDATE pieces piece
SET piece.title = '발레 <탕아>', piece.title_en = 'The Prodigal Son (Le fils prodigue)',
    piece.type = 'song', piece.opus_number = 'Op. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11667 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 11667 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 46bis 발레 모음곡 <탕아>

UPDATE pieces piece
SET piece.title = '발레 모음곡 <탕아>', piece.title_en = 'Suite from The Prodigal Son',
    piece.type = 'album', piece.opus_number = 'Op. 46bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11291 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 11291 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11291 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:37b6a959-923b-43a7-bba3-0a1c94b30894' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37b6a959-923b-43a7-bba3-0a1c94b30894', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11291 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37b6a959-923b-43a7-bba3-0a1c94b30894'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro fastoso', part.name_en = 'II. Allegro fastoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11291 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b57f72c0-1877-498b-9304-fad59e178a19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b57f72c0-1877-498b-9304-fad59e178a19', 2, 'II', 'Allegro fastoso', 'II. Allegro fastoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11291 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b57f72c0-1877-498b-9304-fad59e178a19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11291 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:47cee8d5-9655-4b86-b93b-d3e74a664e0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47cee8d5-9655-4b86-b93b-d3e74a664e0f', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11291 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47cee8d5-9655-4b86-b93b-d3e74a664e0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante assai', part.name_en = 'IV. Andante assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11291 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:034b6c9c-b284-42c1-ba1d-17145a7209c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:034b6c9c-b284-42c1-ba1d-17145a7209c9', 4, 'IV', 'Andante assai', 'IV. Andante assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11291 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:034b6c9c-b284-42c1-ba1d-17145a7209c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Andante pomposo', part.name_en = 'V. Andante pomposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11291 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:61f65aa4-3fb3-4161-8412-93899eee5da4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61f65aa4-3fb3-4161-8412-93899eee5da4', 5, 'V', 'Andante pomposo', 'V. Andante pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11291 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61f65aa4-3fb3-4161-8412-93899eee5da4'
);


-- Op. 47 교향곡 4번 C장조 (원판)

UPDATE pieces piece
SET piece.title = '교향곡 4번 C장조 (원판)', piece.title_en = 'Symphony No. 4 in C major (original version)',
    piece.type = 'album', piece.opus_number = 'Op. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1930, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11565 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1930
WHERE piece.id = 11565 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante – Allegro eroico', part.name_en = 'I. Andante – Allegro eroico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11565 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7c182c1d-f21a-43ca-9001-dcd6451ef770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c182c1d-f21a-43ca-9001-dcd6451ef770', 1, 'I', 'Andante – Allegro eroico', 'I. Andante – Allegro eroico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11565 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c182c1d-f21a-43ca-9001-dcd6451ef770'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante tranquillo', part.name_en = 'II. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11565 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4e9d3160-1c1d-4170-8312-ed8754460886' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e9d3160-1c1d-4170-8312-ed8754460886', 2, 'II', 'Andante tranquillo', 'II. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11565 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e9d3160-1c1d-4170-8312-ed8754460886'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato, quasi allegretto', part.name_en = 'III. Moderato, quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11565 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:bf54404c-fa2f-47f3-bb04-0b5332fc82f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf54404c-fa2f-47f3-bb04-0b5332fc82f6', 3, 'III', 'Moderato, quasi allegretto', 'III. Moderato, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11565 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf54404c-fa2f-47f3-bb04-0b5332fc82f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro risoluto', part.name_en = 'IV. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11565 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6c4f3957-e272-42ca-abab-7fa1d1c48405' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c4f3957-e272-42ca-abab-7fa1d1c48405', 4, 'IV', 'Allegro risoluto', 'IV. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11565 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c4f3957-e272-42ca-abab-7fa1d1c48405'
);


-- Op. 48 신포니에타 A장조 (개정판)

UPDATE pieces piece
SET piece.title = '신포니에타 A장조 (개정판)', piece.title_en = 'Sinfonietta in A major (revised version)',
    piece.type = 'album', piece.opus_number = 'Op. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11836 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 11836 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro giocoso', part.name_en = 'I. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11836 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:665e751d-ec51-4b91-87fa-1be1a7caf49c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:665e751d-ec51-4b91-87fa-1be1a7caf49c', 1, 'I', 'Allegro giocoso', 'I. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11836 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:665e751d-ec51-4b91-87fa-1be1a7caf49c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11836 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:275c658d-f894-4fe7-9919-6a6d26a81f18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:275c658d-f894-4fe7-9919-6a6d26a81f18', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11836 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:275c658d-f894-4fe7-9919-6a6d26a81f18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '인테르메초. Vivace', part.name_en = 'III. Intermezzo. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11836 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5196fee7-9d95-4be9-ba28-088f64bc27e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5196fee7-9d95-4be9-ba28-088f64bc27e7', 3, 'III', '인테르메초. Vivace', 'III. Intermezzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11836 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5196fee7-9d95-4be9-ba28-088f64bc27e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '스케르초. Allegro risoluto', part.name_en = 'IV. Scherzo. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11836 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0aeff0de-656b-4fd3-925d-7bbaca2bca26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aeff0de-656b-4fd3-925d-7bbaca2bca26', 4, 'IV', '스케르초. Allegro risoluto', 'IV. Scherzo. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11836 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aeff0de-656b-4fd3-925d-7bbaca2bca26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro giocoso', part.name_en = 'V. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11836 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:aa2b7005-c708-4375-ba39-bc3a51f859f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa2b7005-c708-4375-ba39-bc3a51f859f0', 5, 'V', 'Allegro giocoso', 'V. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11836 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa2b7005-c708-4375-ba39-bc3a51f859f0'
);


-- Op. 49 <도박사>의 4개의 초상과 대단원

UPDATE pieces piece
SET piece.title = '<도박사>의 4개의 초상과 대단원', piece.title_en = 'Four Portraits and Denouement from The Gambler',
    piece.type = 'album', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11863 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 11863 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '알렉세이', part.name_en = 'I. Alexis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11863 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:346f04e4-83cc-43c2-a39e-15f669b8917d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:346f04e4-83cc-43c2-a39e-15f669b8917d', 1, 'I', '알렉세이', 'I. Alexis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11863 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:346f04e4-83cc-43c2-a39e-15f669b8917d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '할머니', part.name_en = 'II. La grand-mère',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11863 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e69355ad-e7e4-4a58-a374-ffb987392820' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e69355ad-e7e4-4a58-a374-ffb987392820', 2, 'II', '할머니', 'II. La grand-mère', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11863 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e69355ad-e7e4-4a58-a374-ffb987392820'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '장군', part.name_en = 'III. Le Général',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11863 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1bac4b12-7f09-466d-a9ce-1da0e566ec35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bac4b12-7f09-466d-a9ce-1da0e566ec35', 3, 'III', '장군', 'III. Le Général', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11863 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bac4b12-7f09-466d-a9ce-1da0e566ec35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '폴리나', part.name_en = 'IV. Pauline',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11863 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ab11fa51-27eb-46c0-a84c-a0edcc7c82bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab11fa51-27eb-46c0-a84c-a0edcc7c82bf', 4, 'IV', '폴리나', 'IV. Pauline', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11863 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab11fa51-27eb-46c0-a84c-a0edcc7c82bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '대단원', part.name_en = 'V. Dénouement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11863 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0bc7c2c9-5f9b-4dd6-be7f-085f4eddb96e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bc7c2c9-5f9b-4dd6-be7f-085f4eddb96e', 5, 'V', '대단원', 'V. Dénouement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11863 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bc7c2c9-5f9b-4dd6-be7f-085f4eddb96e'
);


-- Op. 50 현악 4중주 1번 B단조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 B단조', piece.title_en = 'String Quartet No. 1 in B minor',
    piece.type = 'album', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1930, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11767 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1930
WHERE piece.id = 11767 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11767 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e06886aa-f87d-3765-a021-84c1994e2f56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e06886aa-f87d-3765-a021-84c1994e2f56', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11767 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e06886aa-f87d-3765-a021-84c1994e2f56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante molto – Vivace', part.name_en = 'II. Andante molto – Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11767 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ad011bbc-eb86-3f54-ab4d-8b1359e7aa39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad011bbc-eb86-3f54-ab4d-8b1359e7aa39', 2, 'II', 'Andante molto – Vivace', 'II. Andante molto – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11767 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad011bbc-eb86-3f54-ab4d-8b1359e7aa39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11767 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3b7ac8ab-9f4e-3db5-9950-022b6ff6031e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b7ac8ab-9f4e-3db5-9950-022b6ff6031e', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11767 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7ac8ab-9f4e-3db5-9950-022b6ff6031e'
);


-- Op. 50bis 현악 합주를 위한 안단테 (현악 4중주 1번에서)

UPDATE pieces piece
SET piece.title = '현악 합주를 위한 안단테 (현악 4중주 1번에서)', piece.title_en = 'Andante from String Quartet No. 1, for string orchestra',
    piece.type = 'song', piece.opus_number = 'Op. 50bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1930, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11752 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1930
WHERE piece.id = 11752 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 51 발레 <드네프르 강가에서>

UPDATE pieces piece
SET piece.title = '발레 <드네프르 강가에서>', piece.title_en = 'On the Dnieper',
    piece.type = 'song', piece.opus_number = 'Op. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11882 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 11882 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 51bis 발레 모음곡 <드네프르 강가에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <드네프르 강가에서>', 'Suite from On the Dnieper', 'album', 'Op. 51bis', NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <드네프르 강가에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd764bde-bd92-4860-b5fb-4d9f2662d5f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd764bde-bd92-4860-b5fb-4d9f2662d5f5'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <드네프르 강가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd764bde-bd92-4860-b5fb-4d9f2662d5f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3abe3b4-fdd9-4192-b761-258ee90737b4', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <드네프르 강가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3abe3b4-fdd9-4192-b761-258ee90737b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cbe3e8a-18ec-4f56-9256-67ffac4570b6', 2, 'II', '첫 남성 무용수의 변주', 'II. Variation of the First Dancer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <드네프르 강가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cbe3e8a-18ec-4f56-9256-67ffac4570b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6b66e3d-9bfc-495d-8f16-4976f37fa60b', 3, 'III', '약혼', 'III. The Betrothal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <드네프르 강가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6b66e3d-9bfc-495d-8f16-4976f37fa60b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbb38710-4f8a-47db-bc9a-28ee0814b8f2', 4, 'IV', '다툼', 'IV. The Quarrel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <드네프르 강가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbb38710-4f8a-47db-bc9a-28ee0814b8f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:662e6fce-142f-42c0-b0dd-46da14e5eec8', 5, 'V', '장면', 'V. Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <드네프르 강가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:662e6fce-142f-42c0-b0dd-46da14e5eec8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2893722a-3ebc-4c96-8d19-5a12d76e29e5', 6, 'VI', '에필로그', 'VI. Epilogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <드네프르 강가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2893722a-3ebc-4c96-8d19-5a12d76e29e5'
);


-- Op. 52 6개의 소품 Op. 52

UPDATE pieces piece
SET piece.title = '6개의 소품 Op. 52', piece.title_en = '6 Pieces, Op. 52',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '52',
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11879 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 11879 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '인테르메초', part.name_en = 'Intermezzo (from The Prodigal Son)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11879 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d8cdf833-100c-4ad5-91df-2899787ad075' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8cdf833-100c-4ad5-91df-2899787ad075', 1, NULL, '인테르메초', 'Intermezzo (from The Prodigal Son)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11879 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8cdf833-100c-4ad5-91df-2899787ad075'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '론도', part.name_en = 'Rondo (from The Prodigal Son)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11879 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:171c1d74-9875-4fe4-961f-66c8fe310e38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:171c1d74-9875-4fe4-961f-66c8fe310e38', 2, NULL, '론도', 'Rondo (from The Prodigal Son)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11879 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:171c1d74-9875-4fe4-961f-66c8fe310e38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '연습곡', part.name_en = 'Étude (from The Prodigal Son)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11879 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2d4412c9-6349-49b6-b3fa-fd5feb9274d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d4412c9-6349-49b6-b3fa-fd5feb9274d4', 3, NULL, '연습곡', 'Étude (from The Prodigal Son)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11879 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d4412c9-6349-49b6-b3fa-fd5feb9274d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '스케르치노', part.name_en = 'Scherzino (from Op. 35)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11879 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7532cd64-404b-47da-af93-18bd021f292f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7532cd64-404b-47da-af93-18bd021f292f', 4, NULL, '스케르치노', 'Scherzino (from Op. 35)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11879 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7532cd64-404b-47da-af93-18bd021f292f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '안단테', part.name_en = 'Andante (from String Quartet No. 1)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11879 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f7505cd4-f25f-47d2-baf5-6803febde5c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7505cd4-f25f-47d2-baf5-6803febde5c0', 5, NULL, '안단테', 'Andante (from String Quartet No. 1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11879 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7505cd4-f25f-47d2-baf5-6803febde5c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '스케르초', part.name_en = 'Scherzo (from Sinfonietta, Op. 48)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11879 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:58097faf-091a-48bb-a1e6-53e2631b4cff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58097faf-091a-48bb-a1e6-53e2631b4cff', 6, NULL, '스케르초', 'Scherzo (from Sinfonietta, Op. 48)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11879 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58097faf-091a-48bb-a1e6-53e2631b4cff'
);


-- Op. 53 피아노 협주곡 4번 B♭장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 4번 B♭장조', piece.title_en = 'Piano Concerto No. 4 in B♭ major, for the left hand',
    piece.type = 'album', piece.opus_number = 'Op. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11555 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 11555 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vivace', part.name_en = 'I. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11555 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:43d1092b-a5fb-4628-83d9-11295e28ef78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43d1092b-a5fb-4628-83d9-11295e28ef78', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11555 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43d1092b-a5fb-4628-83d9-11295e28ef78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11555 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7b02a5d3-85b2-4633-a260-e74b3c6ea59a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b02a5d3-85b2-4633-a260-e74b3c6ea59a', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11555 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b02a5d3-85b2-4633-a260-e74b3c6ea59a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11555 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:cdb654b5-57ea-4c85-bab6-f8d70d9bd01b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdb654b5-57ea-4c85-bab6-f8d70d9bd01b', 3, 'III', 'Moderato', 'III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11555 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdb654b5-57ea-4c85-bab6-f8d70d9bd01b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11555 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:41167343-7f01-40dc-9da2-885a632a5b58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41167343-7f01-40dc-9da2-885a632a5b58', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11555 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41167343-7f01-40dc-9da2-885a632a5b58'
);


-- Op. 54 2개의 소나티나 Op. 54

UPDATE pieces piece
SET piece.title = '2개의 소나티나 Op. 54', piece.title_en = '2 Sonatinas, Op. 54',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '54',
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11844 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 11844 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '소나티나 1번 E단조', part.name_en = 'No. 1 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11844 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9', 1, NULL, '소나티나 1번 E단조', 'No. 1 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11844 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11844 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:041c9d9c-590f-45ce-a672-19170291dd40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:041c9d9c-590f-45ce-a672-19170291dd40', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9'
WHERE p.id = 11844 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:041c9d9c-590f-45ce-a672-19170291dd40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagietto', part.name_en = 'II. Adagietto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11844 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:69d18dfb-a9ed-4c8b-b535-6605c712bd98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69d18dfb-a9ed-4c8b-b535-6605c712bd98', 2, 'II', 'Adagietto', 'II. Adagietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9'
WHERE p.id = 11844 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69d18dfb-a9ed-4c8b-b535-6605c712bd98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11844 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7dbba3c1-6cea-4073-9c27-e8cf29595a96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7dbba3c1-6cea-4073-9c27-e8cf29595a96', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6503d6ad-c8c8-4063-a572-c9f015c71eb9'
WHERE p.id = 11844 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dbba3c1-6cea-4073-9c27-e8cf29595a96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '소나티나 2번 G장조', part.name_en = 'No. 2 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11844 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6', 2, NULL, '소나티나 2번 G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11844 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro sostenuto', part.name_en = 'I. Allegro sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11844 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2c47dd3a-31ae-4d04-b493-e2c8b354e967' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c47dd3a-31ae-4d04-b493-e2c8b354e967', 1, 'I', 'Allegro sostenuto', 'I. Allegro sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6'
WHERE p.id = 11844 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c47dd3a-31ae-4d04-b493-e2c8b354e967'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante amabile', part.name_en = 'II. Andante amabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11844 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b5910f6a-690f-415d-befa-aac873b80b28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5910f6a-690f-415d-befa-aac873b80b28', 2, 'II', 'Andante amabile', 'II. Andante amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6'
WHERE p.id = 11844 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5910f6a-690f-415d-befa-aac873b80b28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro, ma non troppo', part.name_en = 'III. Allegro, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11844 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e2cbd70c-11dc-472e-9f46-5cb43112c604' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e2cbd70c-11dc-472e-9f46-5cb43112c604', 3, 'III', 'Allegro, ma non troppo', 'III. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bafa3390-cb30-4ea9-88e9-d9afeb6810b6'
WHERE p.id = 11844 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2cbd70c-11dc-472e-9f46-5cb43112c604'
);


-- Op. 55 피아노 협주곡 5번 G장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 5번 G장조', piece.title_en = 'Piano Concerto No. 5 in G major',
    piece.type = 'album', piece.opus_number = 'Op. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11619 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 11619 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11619 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:795630bc-5896-3bb1-a27a-88a23c6784fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:795630bc-5896-3bb1-a27a-88a23c6784fe', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11619 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:795630bc-5896-3bb1-a27a-88a23c6784fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato ben accentuato', part.name_en = 'II. Moderato ben accentuato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11619 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9e7851e2-f398-3cd3-94a7-208466eb4a7a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e7851e2-f398-3cd3-94a7-208466eb4a7a', 2, 'II', 'Moderato ben accentuato', 'II. Moderato ben accentuato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11619 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e7851e2-f398-3cd3-94a7-208466eb4a7a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '토카타. Allegro con fuoco', part.name_en = 'III. Toccata. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11619 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:67e89b9d-b53a-39df-bf73-be3a08437a01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67e89b9d-b53a-39df-bf73-be3a08437a01', 3, 'III', '토카타. Allegro con fuoco', 'III. Toccata. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11619 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67e89b9d-b53a-39df-bf73-be3a08437a01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Larghetto', part.name_en = 'IV. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11619 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9dfd8650-f7ad-3c40-881b-e58beb6f2c63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dfd8650-f7ad-3c40-881b-e58beb6f2c63', 4, 'IV', 'Larghetto', 'IV. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11619 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dfd8650-f7ad-3c40-881b-e58beb6f2c63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Vivo', part.name_en = 'V. Vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11619 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:18abb6c8-84c6-3ecf-8e47-0cf0209c27fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18abb6c8-84c6-3ecf-8e47-0cf0209c27fb', 5, 'V', 'Vivo', 'V. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11619 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18abb6c8-84c6-3ecf-8e47-0cf0209c27fb'
);


-- Op. 56 두 대의 바이올린을 위한 소나타 C장조

UPDATE pieces piece
SET piece.title = '두 대의 바이올린을 위한 소나타 C장조', piece.title_en = 'Sonata for Two Violins in C major',
    piece.type = 'album', piece.opus_number = 'Op. 56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11351 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 11351 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante cantabile', part.name_en = 'I. Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11351 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b79ec90b-f21a-33af-9b64-4f6c49842ed5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b79ec90b-f21a-33af-9b64-4f6c49842ed5', 1, 'I', 'Andante cantabile', 'I. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11351 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b79ec90b-f21a-33af-9b64-4f6c49842ed5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11351 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:279442dd-b3cc-3e40-a901-6309df3cd3f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:279442dd-b3cc-3e40-a901-6309df3cd3f2', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11351 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:279442dd-b3cc-3e40-a901-6309df3cd3f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Commodo (quasi allegretto)', part.name_en = 'III. Commodo (quasi allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11351 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3d8b27b3-dbe4-3df2-a4e1-908cf18c30cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d8b27b3-dbe4-3df2-a4e1-908cf18c30cb', 3, 'III', 'Commodo (quasi allegretto)', 'III. Commodo (quasi allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11351 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d8b27b3-dbe4-3df2-a4e1-908cf18c30cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio', part.name_en = 'IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11351 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b5d783ff-1555-32ae-a6f4-e48535a2aba0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5d783ff-1555-32ae-a6f4-e48535a2aba0', 4, 'IV', 'Allegro con brio', 'IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11351 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5d783ff-1555-32ae-a6f4-e48535a2aba0'
);


-- Op. 57 교향적 노래

UPDATE pieces piece
SET piece.title = '교향적 노래', piece.title_en = 'Symphonic Song',
    piece.type = 'song', piece.opus_number = 'Op. 57',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1933, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11810 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1933
WHERE piece.id = 11810 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 58 첼로 협주곡 E단조

UPDATE pieces piece
SET piece.title = '첼로 협주곡 E단조', piece.title_en = 'Cello Concerto in E minor',
    piece.type = 'album', piece.opus_number = 'Op. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1938, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11499 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1938
WHERE piece.id = 11499 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11499 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c9980c62-29e2-48a8-bb74-4909d3df175d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9980c62-29e2-48a8-bb74-4909d3df175d', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11499 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9980c62-29e2-48a8-bb74-4909d3df175d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro giusto', part.name_en = 'II. Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11499 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:beeb76f4-a006-4daa-82ae-7c853acb3d48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beeb76f4-a006-4daa-82ae-7c853acb3d48', 2, 'II', 'Allegro giusto', 'II. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11499 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beeb76f4-a006-4daa-82ae-7c853acb3d48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '주제와 변주', part.name_en = 'III. Tema con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11499 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a2a298b8-dc57-4d1e-81ae-1f451898b50d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2a298b8-dc57-4d1e-81ae-1f451898b50d', 3, 'III', '주제와 변주', 'III. Tema con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11499 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2a298b8-dc57-4d1e-81ae-1f451898b50d'
);


-- Op. 59 3개의 소품 Op. 59

UPDATE pieces piece
SET piece.title = '3개의 소품 Op. 59', piece.title_en = '3 Pieces, Op. 59',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '59',
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11742 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 11742 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '산책', part.name_en = 'Promenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11742 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b79a3604-edb5-4645-a99d-d06222771620' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b79a3604-edb5-4645-a99d-d06222771620', 1, NULL, '산책', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11742 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b79a3604-edb5-4645-a99d-d06222771620'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '풍경', part.name_en = 'Paysage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11742 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f572f0ec-e860-4f94-9199-19fd1577d1a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f572f0ec-e860-4f94-9199-19fd1577d1a5', 2, NULL, '풍경', 'Paysage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11742 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f572f0ec-e860-4f94-9199-19fd1577d1a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '전원 소나티나 C장조', part.name_en = 'Sonatine pastorale in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11742 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4e5fd400-fd9a-4894-bea3-f5ed2141c135' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e5fd400-fd9a-4894-bea3-f5ed2141c135', 3, NULL, '전원 소나티나 C장조', 'Sonatine pastorale in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11742 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e5fd400-fd9a-4894-bea3-f5ed2141c135'
);


-- None 영화 음악 <키제 중위>

UPDATE pieces piece
SET piece.title = '영화 음악 <키제 중위>', piece.title_en = 'Lieutenant Kijé, film score',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11367 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 11367 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 60 교향 모음곡 <키제 중위>

UPDATE pieces piece
SET piece.title = '교향 모음곡 <키제 중위>', piece.title_en = 'Lieutenant Kijé, Symphonic Suite',
    piece.type = 'album', piece.opus_number = 'Op. 60',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11982 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 11982 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '키제의 탄생', part.name_en = 'I. The Birth of Kijé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11982 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e4e6beb2-fa0e-3888-8c49-3360f1ff110e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4e6beb2-fa0e-3888-8c49-3360f1ff110e', 1, 'I', '키제의 탄생', 'I. The Birth of Kijé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11982 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e6beb2-fa0e-3888-8c49-3360f1ff110e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '로망스', part.name_en = 'II. Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11982 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0a1f10bb-b9bf-38af-8ca8-e14de07997bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a1f10bb-b9bf-38af-8ca8-e14de07997bf', 2, 'II', '로망스', 'II. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11982 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a1f10bb-b9bf-38af-8ca8-e14de07997bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '키제의 결혼', part.name_en = 'III. Kijé''s Wedding',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11982 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e047759f-c8ed-3e6e-87d9-9e03299b262f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e047759f-c8ed-3e6e-87d9-9e03299b262f', 3, 'III', '키제의 결혼', 'III. Kijé''s Wedding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11982 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e047759f-c8ed-3e6e-87d9-9e03299b262f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '트로이카', part.name_en = 'IV. Troika',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11982 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:859030aa-68c2-3646-988e-d58caf53e844' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:859030aa-68c2-3646-988e-d58caf53e844', 4, 'IV', '트로이카', 'IV. Troika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11982 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:859030aa-68c2-3646-988e-d58caf53e844'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '키제의 장례', part.name_en = 'V. The Burial of Kijé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11982 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3c8a5d92-6af3-3887-91f6-f3f8f7fd3b27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c8a5d92-6af3-3887-91f6-f3f8f7fd3b27', 5, 'V', '키제의 장례', 'V. The Burial of Kijé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11982 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c8a5d92-6af3-3887-91f6-f3f8f7fd3b27'
);


-- Op. 60bis <키제 중위>에서 2개의 노래

UPDATE pieces piece
SET piece.title = '<키제 중위>에서 2개의 노래', piece.title_en = '2 Songs from Lieutenant Kijé, Op. 60bis',
    piece.type = 'album', piece.opus_number = 'Op. 60bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11510 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 11510 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Stonet sizyy golubochek', part.name_en = 'Stonet sizyy golubochek (The Little Grey Dove Is Cooing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11510 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:dcfcd274-920f-4ffe-9489-e3b0582357b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcfcd274-920f-4ffe-9489-e3b0582357b2', 1, NULL, 'Stonet sizyy golubochek', 'Stonet sizyy golubochek (The Little Grey Dove Is Cooing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11510 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcfcd274-920f-4ffe-9489-e3b0582357b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Troyka', part.name_en = 'Troyka (Troika)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11510 AND p.composer_id = 84 AND part.part_key = 'classicmap:prokofiev:prokofiev-op060bis:2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op060bis:2', 2, NULL, 'Troyka', 'Troyka (Troika)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11510 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op060bis:2'
);


-- None 부수음악 <이집트의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <이집트의 밤>', 'Egyptian Nights, incidental music', 'song', NULL, NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <이집트의 밤>'
);


-- Op. 61 교향 모음곡 <이집트의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향 모음곡 <이집트의 밤>', 'Egyptian Nights, Symphonic Suite', 'album', 'Op. 61', NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향 모음곡 <이집트의 밤>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op061:1', 1, 'I', '이집트의 밤', 'I. Night in Egypt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '교향 모음곡 <이집트의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op061:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op061:2', 2, 'II', '카이사르, 스핑크스와 클레오파트라', 'II. Caesar, the Sphinx and Cleopatra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '교향 모음곡 <이집트의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op061:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op061:3', 3, 'III', '경보', 'III. Alarm', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '교향 모음곡 <이집트의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op061:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op061:4', 4, 'IV', '춤', 'IV. Dances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '교향 모음곡 <이집트의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op061:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op061:5', 5, 'V', '안토니우스', 'V. Antony', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '교향 모음곡 <이집트의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op061:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op061:6', 6, 'VI', '클레오파트라의 최후', 'VI. The Decline of Cleopatra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '교향 모음곡 <이집트의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op061:6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op061:7', 7, 'VII', 'Roma militaris', 'VII. Roma militaris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '교향 모음곡 <이집트의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op061:7'
);


-- Op. 62 피아노 소품집 <사색>

UPDATE pieces piece
SET piece.title = '피아노 소품집 <사색>', piece.title_en = 'Pensées, Op. 62',
    piece.type = 'album', piece.opus_number = 'Op. 62',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11402 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 11402 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Adagio penseroso – Moderato', part.name_en = 'Adagio penseroso – Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11402 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ad86d759-0877-41ec-9447-dc9b2cfd0c73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad86d759-0877-41ec-9447-dc9b2cfd0c73', 1, NULL, 'Adagio penseroso – Moderato', 'Adagio penseroso – Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11402 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad86d759-0877-41ec-9447-dc9b2cfd0c73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lento', part.name_en = 'Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11402 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7d443be0-57e6-4154-be8a-492f204dd113' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d443be0-57e6-4154-be8a-492f204dd113', 2, NULL, 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11402 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d443be0-57e6-4154-be8a-492f204dd113'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11402 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:16d60135-11c7-49d0-9944-da49505a2421' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16d60135-11c7-49d0-9944-da49505a2421', 3, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11402 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16d60135-11c7-49d0-9944-da49505a2421'
);


-- Op. 63 바이올린 협주곡 2번 G단조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 2번 G단조', piece.title_en = 'Violin Concerto No. 2 in G minor',
    piece.type = 'album', piece.opus_number = 'Op. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1935, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11432 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1935
WHERE piece.id = 11432 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11432 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0399193d-0dee-3895-b1d7-b86b227d6dbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0399193d-0dee-3895-b1d7-b86b227d6dbb', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11432 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0399193d-0dee-3895-b1d7-b86b227d6dbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante assai', part.name_en = 'II. Andante assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11432 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5482b360-bb1a-3441-84b3-c2b6b167d7e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5482b360-bb1a-3441-84b3-c2b6b167d7e0', 2, 'II', 'Andante assai', 'II. Andante assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11432 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5482b360-bb1a-3441-84b3-c2b6b167d7e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro, ben marcato', part.name_en = 'III. Allegro, ben marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11432 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:06ffa246-8b22-308c-bee5-ce9b58939676' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06ffa246-8b22-308c-bee5-ce9b58939676', 3, 'III', 'Allegro, ben marcato', 'III. Allegro, ben marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11432 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06ffa246-8b22-308c-bee5-ce9b58939676'
);


-- Op. 64bis 발레 모음곡 <로미오와 줄리엣> 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <로미오와 줄리엣> 1번', 'Romeo and Juliet, Suite No. 1', 'album', 'Op. 64bis', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <로미오와 줄리엣> 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2041f663-764c-4a66-8bf0-d70cf643dac0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2041f663-764c-4a66-8bf0-d70cf643dac0'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2041f663-764c-4a66-8bf0-d70cf643dac0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c490d17-004c-33da-bef1-e09aa8610497', 1, 'I', '민속 춤', 'I. Folk Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c490d17-004c-33da-bef1-e09aa8610497'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11973 AND linked.composer_id = 84), 'musicbrainz:1d103e6b-406e-391e-a65c-225c96f83ac2', 2, 'II', '장면 (거리가 깨어나다)', 'II. Scene (The Street Awakens)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d103e6b-406e-391e-a65c-225c96f83ac2'
);

UPDATE pieces piece
SET piece.title = '발레 모음곡 <로미오와 줄리엣> 1번 중 "장면 (거리가 깨어나다)"', piece.title_en = 'Romeo and Juliet, Suite No. 1: II. Scene (The Street Awakens)', piece.editor_locked = 1
WHERE piece.id = 11973 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:620499c0-d504-381e-88ff-c32e42291635', 3, 'III', '마드리갈', 'III. Madrigal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:620499c0-d504-381e-88ff-c32e42291635'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f072a1c-da46-31e2-b09e-ff81a499f7a1', 4, 'IV', '미뉴에트 (손님들의 도착)', 'IV. Minuet (The Arrival of the Guests)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f072a1c-da46-31e2-b09e-ff81a499f7a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eb96a68-a298-3c01-b637-810099b74168', 5, 'V', '가면', 'V. Masks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eb96a68-a298-3c01-b637-810099b74168'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8ebcc76-fd13-3646-9970-891854131622', 6, 'VI', '로미오와 줄리엣', 'VI. Romeo and Juliet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8ebcc76-fd13-3646-9970-891854131622'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35845d08-77f7-3c24-83d4-e895a013db3a', 7, 'VII', '티볼트의 죽음', 'VII. The Death of Tybalt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35845d08-77f7-3c24-83d4-e895a013db3a'
);


-- Op. 64ter 발레 모음곡 <로미오와 줄리엣> 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <로미오와 줄리엣> 2번', 'Romeo and Juliet, Suite No. 2', 'album', 'Op. 64ter', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <로미오와 줄리엣> 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0294f5e0-5024-482f-9f23-28ba1f40e1e6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0294f5e0-5024-482f-9f23-28ba1f40e1e6'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0294f5e0-5024-482f-9f23-28ba1f40e1e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62d7ad23-3444-364a-85c2-1ae5e44b648b', 1, 'I', '몬터규가와 캐퓰릿가', 'I. Montagues and Capulets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62d7ad23-3444-364a-85c2-1ae5e44b648b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11952 AND linked.composer_id = 84), 'musicbrainz:06f599be-fc20-4316-bda2-3f6ccd72a146', 2, 'II', '소녀 줄리엣', 'II. Juliet the Young Girl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06f599be-fc20-4316-bda2-3f6ccd72a146'
);

UPDATE pieces piece
SET piece.title = '발레 모음곡 <로미오와 줄리엣> 2번 중 "소녀 줄리엣"', piece.title_en = 'Romeo and Juliet, Suite No. 2: II. Juliet the Young Girl', piece.editor_locked = 1
WHERE piece.id = 11952 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65b2e0ff-39ba-3ad8-8680-56b17540cf34', 3, 'III', '로런스 신부', 'III. Friar Laurence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65b2e0ff-39ba-3ad8-8680-56b17540cf34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:856b9a0f-df07-4c32-8133-5d455f4f5274', 4, 'IV', '춤', 'IV. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:856b9a0f-df07-4c32-8133-5d455f4f5274'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b3f71cb-a6e1-3b3a-9870-1b6e83a4ef8a', 5, 'V', '이별 앞의 로미오와 줄리엣', 'V. Romeo and Juliet Before Parting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b3f71cb-a6e1-3b3a-9870-1b6e83a4ef8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cefa049-31fb-4a04-9ce4-eadb6bb356d9', 6, 'VI', '백합을 든 소녀들의 춤', 'VI. Dance of the Girls with Lilies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cefa049-31fb-4a04-9ce4-eadb6bb356d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2be401cc-a898-3f03-a5a1-5454467d1270', 7, 'VII', '줄리엣의 무덤 앞의 로미오', 'VII. Romeo at Juliet''s Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2be401cc-a898-3f03-a5a1-5454467d1270'
);


-- Op. 65 피아노 소품집 <어린이를 위한 음악>

UPDATE pieces piece
SET piece.title = '피아노 소품집 <어린이를 위한 음악>', piece.title_en = 'Music for Children, Op. 65',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1935, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11575 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1935
WHERE piece.id = 11575 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '아침', part.name_en = 'Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:15942e48-a0b9-4f19-9f20-6275995939ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15942e48-a0b9-4f19-9f20-6275995939ee', 1, NULL, '아침', 'Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15942e48-a0b9-4f19-9f20-6275995939ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '산책', part.name_en = 'Promenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2908ecab-c991-4349-9ca9-6faba09a711b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2908ecab-c991-4349-9ca9-6faba09a711b', 2, NULL, '산책', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2908ecab-c991-4349-9ca9-6faba09a711b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '옛이야기', part.name_en = 'A Little Story',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:cf9609f0-0d1d-4d24-968c-3a53f45d2d3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf9609f0-0d1d-4d24-968c-3a53f45d2d3a', 3, NULL, '옛이야기', 'A Little Story', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf9609f0-0d1d-4d24-968c-3a53f45d2d3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '타란텔라', part.name_en = 'Tarantella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:03ded6f2-cbd7-4f65-bc55-df32166438fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03ded6f2-cbd7-4f65-bc55-df32166438fb', 4, NULL, '타란텔라', 'Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03ded6f2-cbd7-4f65-bc55-df32166438fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '후회', part.name_en = 'Regrets',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9687bec9-f28d-4ea7-a8fd-77fcc02927d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9687bec9-f28d-4ea7-a8fd-77fcc02927d1', 5, NULL, '후회', 'Regrets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9687bec9-f28d-4ea7-a8fd-77fcc02927d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '왈츠', part.name_en = 'Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:36c35324-5de6-4412-8067-87e0b810a3dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36c35324-5de6-4412-8067-87e0b810a3dd', 6, NULL, '왈츠', 'Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36c35324-5de6-4412-8067-87e0b810a3dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '메뚜기의 행진', part.name_en = 'Parade of the Grasshoppers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:42650d21-a3ad-40d3-8d07-2512cce85fb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42650d21-a3ad-40d3-8d07-2512cce85fb2', 7, NULL, '메뚜기의 행진', 'Parade of the Grasshoppers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42650d21-a3ad-40d3-8d07-2512cce85fb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '비와 무지개', part.name_en = 'The Rain and the Rainbow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:32c06097-a567-4607-be86-7f99b71ca49e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32c06097-a567-4607-be86-7f99b71ca49e', 8, NULL, '비와 무지개', 'The Rain and the Rainbow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c06097-a567-4607-be86-7f99b71ca49e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '술래잡기', part.name_en = 'Playing Tag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:51383153-8c4a-4871-8ec2-2bf24f55772b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51383153-8c4a-4871-8ec2-2bf24f55772b', 9, NULL, '술래잡기', 'Playing Tag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51383153-8c4a-4871-8ec2-2bf24f55772b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '행진곡', part.name_en = 'March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:720e8c5f-208a-4f4a-9df9-b0804d21af35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:720e8c5f-208a-4f4a-9df9-b0804d21af35', 10, NULL, '행진곡', 'March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:720e8c5f-208a-4f4a-9df9-b0804d21af35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '저녁', part.name_en = 'Evening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e9285e52-afcc-450e-979f-f7708fc11bb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9285e52-afcc-450e-979f-f7708fc11bb5', 11, NULL, '저녁', 'Evening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9285e52-afcc-450e-979f-f7708fc11bb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '달이 초원 위를 거닐다', part.name_en = 'The Moon Strolls in the Meadow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11575 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5eb49993-7333-42b7-9c8c-186f4d2d765b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eb49993-7333-42b7-9c8c-186f4d2d765b', 12, NULL, '달이 초원 위를 거닐다', 'The Moon Strolls in the Meadow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11575 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eb49993-7333-42b7-9c8c-186f4d2d765b'
);


-- Op. 65bis 어린이 모음곡 <여름날>

UPDATE pieces piece
SET piece.title = '어린이 모음곡 <여름날>', piece.title_en = 'A Summer Day, Children''s Suite',
    piece.type = 'album', piece.opus_number = 'Op. 65bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1941, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11720 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1941
WHERE piece.id = 11720 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '아침', part.name_en = 'I. Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11720 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:86aa56e8-2292-4e2f-93e4-289c73b3c50c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86aa56e8-2292-4e2f-93e4-289c73b3c50c', 1, 'I', '아침', 'I. Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11720 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86aa56e8-2292-4e2f-93e4-289c73b3c50c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '술래잡기', part.name_en = 'II. Tag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11720 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f7752eae-d946-4717-ad7b-00fe65895172' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7752eae-d946-4717-ad7b-00fe65895172', 2, 'II', '술래잡기', 'II. Tag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11720 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7752eae-d946-4717-ad7b-00fe65895172'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '왈츠', part.name_en = 'III. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11720 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7787c375-ae41-43eb-a95e-0c0d0c8f8630' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7787c375-ae41-43eb-a95e-0c0d0c8f8630', 3, 'III', '왈츠', 'III. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11720 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7787c375-ae41-43eb-a95e-0c0d0c8f8630'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '후회', part.name_en = 'IV. Regrets',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11720 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:47340abb-660e-4df2-b1f2-f87f3ca1065a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47340abb-660e-4df2-b1f2-f87f3ca1065a', 4, 'IV', '후회', 'IV. Regrets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11720 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47340abb-660e-4df2-b1f2-f87f3ca1065a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '행진곡', part.name_en = 'V. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11720 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6bc45772-64a8-497d-9e66-473bcf735849' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bc45772-64a8-497d-9e66-473bcf735849', 5, 'V', '행진곡', 'V. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11720 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bc45772-64a8-497d-9e66-473bcf735849'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '저녁', part.name_en = 'VI. Evening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11720 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:46cbcee6-6f08-4c3e-936f-672cb77a6009' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46cbcee6-6f08-4c3e-936f-672cb77a6009', 6, 'VI', '저녁', 'VI. Evening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11720 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46cbcee6-6f08-4c3e-936f-672cb77a6009'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '달이 초원 위를 거닐다', part.name_en = 'VII. The Moon Strolls in the Meadow',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11720 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:58da8df9-757d-4ce3-a37c-1bd57803b4f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58da8df9-757d-4ce3-a37c-1bd57803b4f9', 7, 'VII', '달이 초원 위를 거닐다', 'VII. The Moon Strolls in the Meadow', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11720 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58da8df9-757d-4ce3-a37c-1bd57803b4f9'
);


-- Op. 66 6개의 노래 Op. 66

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 노래 Op. 66', '6 Songs, Op. 66', 'album', NULL, 'Op.', '66', 1935, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 노래 Op. 66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11500 AND linked.composer_id = 84), 'musicbrainz:2d448635-8285-4be2-bfe6-a0de2c4bacec', 1, NULL, '2개의 대중가요', '2 Mass Songs, Op. 66a', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '6개의 노래 Op. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d448635-8285-4be2-bfe6-a0de2c4bacec'
);

UPDATE pieces piece
SET piece.title = '6개의 노래 Op. 66 중 "2개의 대중가요"', piece.title_en = '6 Songs, Op. 66: 2 Mass Songs, Op. 66a', piece.editor_locked = 1
WHERE piece.id = 11500 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcfbaff3-bfdf-49fc-aa41-b16563c7c912', 1, NULL, 'Partizan Zheleznyak', 'Partizan Zheleznyak (Zheleznyak the Partisan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d448635-8285-4be2-bfe6-a0de2c4bacec'
WHERE p.composer_id = 84 AND p.title = '6개의 노래 Op. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcfbaff3-bfdf-49fc-aa41-b16563c7c912'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3a209422-71da-4fd9-906f-9953cb16f6fa', 2, NULL, 'Anyutka', 'Anyutka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d448635-8285-4be2-bfe6-a0de2c4bacec'
WHERE p.composer_id = 84 AND p.title = '6개의 노래 Op. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a209422-71da-4fd9-906f-9953cb16f6fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2717e7a0-ada7-4ce6-b953-971cc20d39f3', 2, NULL, '4개의 노래', '4 Songs, Op. 66b', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '6개의 노래 Op. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2717e7a0-ada7-4ce6-b953-971cc20d39f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b4df343-93c1-4a62-add2-23c3ae07f136', 1, NULL, 'Rastyot strana', 'Rastyot strana (The Country Is Growing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2717e7a0-ada7-4ce6-b953-971cc20d39f3'
WHERE p.composer_id = 84 AND p.title = '6개의 노래 Op. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b4df343-93c1-4a62-add2-23c3ae07f136'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03d7c18d-e1a5-4759-9913-4e7579e56c49', 2, NULL, 'Skvoz'' snega i tumany', 'Skvoz'' snega i tumany (Through Snow and Fog)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2717e7a0-ada7-4ce6-b953-971cc20d39f3'
WHERE p.composer_id = 84 AND p.title = '6개의 노래 Op. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d7c18d-e1a5-4759-9913-4e7579e56c49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef9d3805-cdc1-49d6-bb84-f7f776a26cd7', 3, NULL, 'Za goroyu', 'Za goroyu (Beyond the Hill)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2717e7a0-ada7-4ce6-b953-971cc20d39f3'
WHERE p.composer_id = 84 AND p.title = '6개의 노래 Op. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef9d3805-cdc1-49d6-bb84-f7f776a26cd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d20e2048-02a2-4011-8190-44afaf2dcb9f', 4, NULL, 'Pesnya o Voroshilove', 'Pesnya o Voroshilove (Song about Voroshilov)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2717e7a0-ada7-4ce6-b953-971cc20d39f3'
WHERE p.composer_id = 84 AND p.title = '6개의 노래 Op. 66' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d20e2048-02a2-4011-8190-44afaf2dcb9f'
);


-- Op. 68 3개의 어린이 노래

UPDATE pieces piece
SET piece.title = '3개의 어린이 노래', piece.title_en = '3 Children''s Songs, Op. 68',
    piece.type = 'album', piece.opus_number = 'Op. 68',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1936, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11805 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1936
WHERE piece.id = 11805 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Boltun''ya', part.name_en = 'Boltun''ya (The Chatterbox)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11805 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a21b6367-5c31-4536-b075-dc8a73000f11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a21b6367-5c31-4536-b075-dc8a73000f11', 1, NULL, 'Boltun''ya', 'Boltun''ya (The Chatterbox)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11805 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a21b6367-5c31-4536-b075-dc8a73000f11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sladkaya pesenka', part.name_en = 'Sladkaya pesenka (Sweet Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11805 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1d8042ac-8847-4dca-9271-f50f04b403da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d8042ac-8847-4dca-9271-f50f04b403da', 2, NULL, 'Sladkaya pesenka', 'Sladkaya pesenka (Sweet Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11805 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d8042ac-8847-4dca-9271-f50f04b403da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Porosyata', part.name_en = 'Porosyata (The Little Pigs)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11805 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:de9bbc03-dfbb-452d-b887-bc5a8c25bce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de9bbc03-dfbb-452d-b887-bc5a8c25bce9', 3, NULL, 'Porosyata', 'Porosyata (The Little Pigs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11805 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de9bbc03-dfbb-452d-b887-bc5a8c25bce9'
);


-- Op. 69 취주악을 위한 4개의 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '취주악을 위한 4개의 행진곡', '4 Marches for Military Band, Op. 69', 'album', 'Op. 69', NULL, NULL, 1937, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '취주악을 위한 4개의 행진곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 12007 AND linked.composer_id = 84), 'musicbrainz:fe89110a-c718-4a8c-825b-28c05d97b7c3', 1, NULL, '스파르타키아드 행진곡', 'March for the Spartakiad (Athletic Festival March)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '취주악을 위한 4개의 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe89110a-c718-4a8c-825b-28c05d97b7c3'
);

UPDATE pieces piece
SET piece.title = '취주악을 위한 4개의 행진곡 중 "스파르타키아드 행진곡"', piece.title_en = '4 Marches for Military Band, Op. 69: March for the Spartakiad (Athletic Festival March)', piece.editor_locked = 1
WHERE piece.id = 12007 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op069:2', 2, NULL, '서정적 행진곡', 'Lyric March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '취주악을 위한 4개의 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op069:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op069:3', 3, NULL, '행군 행진곡', 'Marching March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '취주악을 위한 4개의 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op069:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op069:4', 4, NULL, '기병 행진곡', 'Cavalry March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '취주악을 위한 4개의 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op069:4'
);


-- Op. 70 영화 음악 <스페이드의 여왕>

UPDATE pieces piece
SET piece.title = '영화 음악 <스페이드의 여왕>', piece.title_en = 'The Queen of Spades, film score',
    piece.type = 'song', piece.opus_number = 'Op. 70',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1936, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11312 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1936
WHERE piece.id = 11312 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 70bis 부수음악 <보리스 고두노프>

UPDATE pieces piece
SET piece.title = '부수음악 <보리스 고두노프>', piece.title_en = 'Boris Godunov, incidental music',
    piece.type = 'song', piece.opus_number = 'Op. 70bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1936, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11325 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1936
WHERE piece.id = 11325 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 71 부수음악 <예브게니 오네긴>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <예브게니 오네긴>', 'Eugene Onegin, incidental music', 'song', 'Op. 71', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <예브게니 오네긴>'
);


-- Op. 72 러시아 서곡

UPDATE pieces piece
SET piece.title = '러시아 서곡', piece.title_en = 'Russian Overture',
    piece.type = 'song', piece.opus_number = 'Op. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1937, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11772 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1937
WHERE piece.id = 11772 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 73 푸시킨의 시에 의한 3개의 로망스

UPDATE pieces piece
SET piece.title = '푸시킨의 시에 의한 3개의 로망스', piece.title_en = '3 Romances on Poems by Pushkin, Op. 73',
    piece.type = 'album', piece.opus_number = 'Op. 73',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1936, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11349 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1936
WHERE piece.id = 11349 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sosny', part.name_en = 'Sosny (Pine Trees)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11349 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6bee94db-b0f1-40e3-9036-bfc13285b409' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bee94db-b0f1-40e3-9036-bfc13285b409', 1, NULL, 'Sosny', 'Sosny (Pine Trees)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11349 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bee94db-b0f1-40e3-9036-bfc13285b409'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Rumyanoy zaryoyu', part.name_en = 'Rumyanoy zaryoyu (Crimson Dawn)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11349 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d359872c-91bb-41fc-81d3-73f70e4064ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d359872c-91bb-41fc-81d3-73f70e4064ca', 2, NULL, 'Rumyanoy zaryoyu', 'Rumyanoy zaryoyu (Crimson Dawn)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11349 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d359872c-91bb-41fc-81d3-73f70e4064ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'V tvoyu svetlitsu', part.name_en = 'V tvoyu svetlitsu (In Your Chamber)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11349 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:02c190c6-31b2-419a-acb3-8a275c044fcd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02c190c6-31b2-419a-acb3-8a275c044fcd', 3, NULL, 'V tvoyu svetlitsu', 'V tvoyu svetlitsu (In Your Chamber)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11349 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02c190c6-31b2-419a-acb3-8a275c044fcd'
);


-- Op. 74 10월 혁명 20주년 칸타타

UPDATE pieces piece
SET piece.title = '10월 혁명 20주년 칸타타', piece.title_en = 'Cantata for the 20th Anniversary of the October Revolution',
    piece.type = 'song', piece.opus_number = 'Op. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1937, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11343 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1937
WHERE piece.id = 11343 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 75 <로미오와 줄리엣>에서 10개의 소품

UPDATE pieces piece
SET piece.title = '<로미오와 줄리엣>에서 10개의 소품', piece.title_en = '10 Pieces from Romeo and Juliet, Op. 75',
    piece.type = 'album', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1937, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11429 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1937
WHERE piece.id = 11429 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '민속 춤', part.name_en = 'Folk Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:056cc8c9-830e-41a0-a860-55ec57674e14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:056cc8c9-830e-41a0-a860-55ec57674e14', 1, NULL, '민속 춤', 'Folk Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:056cc8c9-830e-41a0-a860-55ec57674e14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '장면 (거리가 깨어나다)', part.name_en = 'Scene (The Street Awakens)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:65b357e6-2ba8-4e2e-82ed-fbbd316fc048' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65b357e6-2ba8-4e2e-82ed-fbbd316fc048', 2, NULL, '장면 (거리가 깨어나다)', 'Scene (The Street Awakens)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65b357e6-2ba8-4e2e-82ed-fbbd316fc048'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '미뉴에트 (손님들의 도착)', part.name_en = 'Minuet (The Arrival of the Guests)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:02e75e70-9079-4dbc-8733-8b129c6006b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02e75e70-9079-4dbc-8733-8b129c6006b6', 3, NULL, '미뉴에트 (손님들의 도착)', 'Minuet (The Arrival of the Guests)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02e75e70-9079-4dbc-8733-8b129c6006b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '소녀 줄리엣', part.name_en = 'Juliet as a Young Girl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8b3f6e73-1db5-32d2-9c99-80832b39d27e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b3f6e73-1db5-32d2-9c99-80832b39d27e', 4, NULL, '소녀 줄리엣', 'Juliet as a Young Girl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b3f6e73-1db5-32d2-9c99-80832b39d27e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '가면', part.name_en = 'Masks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a5081b8c-1572-4007-83cd-e8cad2dee8ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5081b8c-1572-4007-83cd-e8cad2dee8ed', 5, NULL, '가면', 'Masks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5081b8c-1572-4007-83cd-e8cad2dee8ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '몬터규가와 캐퓰릿가', part.name_en = 'Montagues and Capulets',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2c032749-5c5b-410d-a167-4b88f855dafc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c032749-5c5b-410d-a167-4b88f855dafc', 6, NULL, '몬터규가와 캐퓰릿가', 'Montagues and Capulets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c032749-5c5b-410d-a167-4b88f855dafc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '로런스 신부', part.name_en = 'Friar Laurence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:427ff027-7d1f-469b-a0ec-28e2a8040105' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:427ff027-7d1f-469b-a0ec-28e2a8040105', 7, NULL, '로런스 신부', 'Friar Laurence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:427ff027-7d1f-469b-a0ec-28e2a8040105'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '머큐쇼', part.name_en = 'Mercutio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2deecbb3-50bd-4a89-af6f-eb0bf04b7491' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2deecbb3-50bd-4a89-af6f-eb0bf04b7491', 8, NULL, '머큐쇼', 'Mercutio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2deecbb3-50bd-4a89-af6f-eb0bf04b7491'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '백합을 든 소녀들의 춤', part.name_en = 'Dance of the Girls with Lilies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:dbf871eb-b012-4164-81d0-8da582edf956' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbf871eb-b012-4164-81d0-8da582edf956', 9, NULL, '백합을 든 소녀들의 춤', 'Dance of the Girls with Lilies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbf871eb-b012-4164-81d0-8da582edf956'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '이별 앞의 로미오와 줄리엣', part.name_en = 'Romeo and Juliet Before Parting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11429 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:531d20eb-64ba-4afb-8a01-1274d6eca07a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:531d20eb-64ba-4afb-8a01-1274d6eca07a', 10, NULL, '이별 앞의 로미오와 줄리엣', 'Romeo and Juliet Before Parting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11429 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:531d20eb-64ba-4afb-8a01-1274d6eca07a'
);


-- Op. 76 칸타타 <우리 시대의 노래>

UPDATE pieces piece
SET piece.title = '칸타타 <우리 시대의 노래>', piece.title_en = 'Songs of Our Days',
    piece.type = 'song', piece.opus_number = 'Op. 76',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1937, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11919 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1937
WHERE piece.id = 11919 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 77 부수음악 <햄릿>

UPDATE pieces piece
SET piece.title = '부수음악 <햄릿>', piece.title_en = 'Hamlet, incidental music',
    piece.type = 'song', piece.opus_number = 'Op. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1938, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11330 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1938
WHERE piece.id = 11330 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 77bis <햄릿>에서 가보트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<햄릿>에서 가보트', 'Gavotte from Hamlet, for piano', 'song', 'Op. 77bis', NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<햄릿>에서 가보트'
);


-- None 영화 음악 <알렉산드르 넵스키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 음악 <알렉산드르 넵스키>', 'Alexander Nevsky, film score', 'song', NULL, NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 음악 <알렉산드르 넵스키>'
);


-- Op. 78 칸타타 <알렉산드르 넵스키>

UPDATE pieces piece
SET piece.title = '칸타타 <알렉산드르 넵스키>', piece.title_en = 'Alexander Nevsky, Cantata',
    piece.type = 'song', piece.opus_number = 'Op. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1939, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11869 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1939
WHERE piece.id = 11869 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 78bis <알렉산드르 넵스키>에서 3개의 노래

UPDATE pieces piece
SET piece.title = '<알렉산드르 넵스키>에서 3개의 노래', piece.title_en = '3 Songs from Alexander Nevsky, Op. 78bis',
    piece.type = 'album', piece.opus_number = 'Op. 78bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1939, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11819 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1939
WHERE piece.id = 11819 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vstavayte, lyudi russkie', part.name_en = 'Vstavayte, lyudi russkie (Arise, Ye Russian People)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11819 AND p.composer_id = 84 AND part.part_key = 'classicmap:prokofiev:prokofiev-op078bis:1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op078bis:1', 1, NULL, 'Vstavayte, lyudi russkie', 'Vstavayte, lyudi russkie (Arise, Ye Russian People)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11819 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op078bis:1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Otzovitesya, yasny sokoly', part.name_en = 'Otzovitesya, yasny sokoly (Answer, Bright Falcons)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11819 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:72f330dd-3d5d-44c7-9dc2-f2f5e1a04582' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72f330dd-3d5d-44c7-9dc2-f2f5e1a04582', 2, NULL, 'Otzovitesya, yasny sokoly', 'Otzovitesya, yasny sokoly (Answer, Bright Falcons)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11819 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72f330dd-3d5d-44c7-9dc2-f2f5e1a04582'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A i bylo delo na Neve-reke', part.name_en = 'A i bylo delo na Neve-reke (It Happened on the Neva River)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11819 AND p.composer_id = 84 AND part.part_key = 'classicmap:prokofiev:prokofiev-op078bis:3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op078bis:3', 3, NULL, 'A i bylo delo na Neve-reke', 'A i bylo delo na Neve-reke (It Happened on the Neva River)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11819 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op078bis:3'
);


-- Op. 79 7개의 노래 Op. 79

UPDATE pieces piece
SET piece.title = '7개의 노래 Op. 79', piece.title_en = '7 Songs, Op. 79',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '79',
    piece.composition_year = COALESCE(1939, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11886 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1939
WHERE piece.id = 11886 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pesnya o Rodine', part.name_en = 'Pesnya o Rodine (Song about the Motherland)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11886 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b69f3994-3f37-461f-b9ea-5c93c5a436f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b69f3994-3f37-461f-b9ea-5c93c5a436f1', 1, NULL, 'Pesnya o Rodine', 'Pesnya o Rodine (Song about the Motherland)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11886 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b69f3994-3f37-461f-b9ea-5c93c5a436f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Stakhanovka', part.name_en = 'Stakhanovka (The Stakhanovite)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11886 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:24b7a1d1-eb73-4346-a204-d4e8d9aeb7d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24b7a1d1-eb73-4346-a204-d4e8d9aeb7d9', 2, NULL, 'Stakhanovka', 'Stakhanovka (The Stakhanovite)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11886 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24b7a1d1-eb73-4346-a204-d4e8d9aeb7d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nad polyarnym morem', part.name_en = 'Nad polyarnym morem (Over the Polar Sea)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11886 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:31adce73-a6f5-4d32-afb3-490873b4682c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31adce73-a6f5-4d32-afb3-490873b4682c', 3, NULL, 'Nad polyarnym morem', 'Nad polyarnym morem (Over the Polar Sea)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11886 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31adce73-a6f5-4d32-afb3-490873b4682c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Provody', part.name_en = 'Provody (Send-off)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11886 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:89b35175-bbc0-4875-899e-a0f010248b80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89b35175-bbc0-4875-899e-a0f010248b80', 4, NULL, 'Provody', 'Provody (Send-off)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11886 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89b35175-bbc0-4875-899e-a0f010248b80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Smelo vperyod', part.name_en = 'Smelo vperyod (Bravely Forward)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11886 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:338a9123-4384-419f-9a9d-b90e9f910b37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:338a9123-4384-419f-9a9d-b90e9f910b37', 5, NULL, 'Smelo vperyod', 'Smelo vperyod (Bravely Forward)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11886 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:338a9123-4384-419f-9a9d-b90e9f910b37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Shyol stanitseyu kazak', part.name_en = 'Shyol stanitseyu kazak (A Cossack Rode Through the Village)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11886 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:58e251dd-6973-4097-a86c-d8abeed3e544' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58e251dd-6973-4097-a86c-d8abeed3e544', 6, NULL, 'Shyol stanitseyu kazak', 'Shyol stanitseyu kazak (A Cossack Rode Through the Village)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11886 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e251dd-6973-4097-a86c-d8abeed3e544'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Gey, po doroge', part.name_en = 'Gey, po doroge (Hey, to the Road)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11886 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2ae199aa-3686-445c-bab3-afa7af1fc56b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ae199aa-3686-445c-bab3-afa7af1fc56b', 7, NULL, 'Gey, po doroge', 'Gey, po doroge (Hey, to the Road)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11886 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ae199aa-3686-445c-bab3-afa7af1fc56b'
);


-- Op. 80 바이올린 소나타 1번 F단조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 1번 F단조', piece.title_en = 'Violin Sonata No. 1 in F minor',
    piece.type = 'album', piece.opus_number = 'Op. 80',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1946, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11335 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1946
WHERE piece.id = 11335 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante assai', part.name_en = 'I. Andante assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11335 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4483b9be-d14f-3c13-ba91-e468c3eae8a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4483b9be-d14f-3c13-ba91-e468c3eae8a3', 1, 'I', 'Andante assai', 'I. Andante assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11335 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4483b9be-d14f-3c13-ba91-e468c3eae8a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro brusco', part.name_en = 'II. Allegro brusco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11335 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:318da2a5-b76f-3bd0-a046-fb4c846e173b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:318da2a5-b76f-3bd0-a046-fb4c846e173b', 2, 'II', 'Allegro brusco', 'II. Allegro brusco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11335 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:318da2a5-b76f-3bd0-a046-fb4c846e173b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11335 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4a118853-fe01-3302-9b87-85b90106ab6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a118853-fe01-3302-9b87-85b90106ab6f', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11335 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a118853-fe01-3302-9b87-85b90106ab6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegrissimo', part.name_en = 'IV. Allegrissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11335 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:81128a48-82ac-36d7-9c5a-951ddcdeafa5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81128a48-82ac-36d7-9c5a-951ddcdeafa5', 4, 'IV', 'Allegrissimo', 'IV. Allegrissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11335 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81128a48-82ac-36d7-9c5a-951ddcdeafa5'
);


-- Op. 81 오페라 <세묜 코트코>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <세묜 코트코>', 'Semyon Kotko', 'song', 'Op. 81', NULL, NULL, 1939, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <세묜 코트코>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f802c28-cf77-4ec8-a4bd-5b8d20fa8798'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f802c28-cf77-4ec8-a4bd-5b8d20fa8798'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '오페라 <세묜 코트코>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f802c28-cf77-4ec8-a4bd-5b8d20fa8798'
);


-- Op. 81bis 교향 모음곡 <세묜 코트코>

UPDATE pieces piece
SET piece.title = '교향 모음곡 <세묜 코트코>', piece.title_en = 'Semyon Kotko, Symphonic Suite',
    piece.type = 'album', piece.opus_number = 'Op. 81bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1941, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11763 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1941
WHERE piece.id = 11763 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11763 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:3916730a-73c7-44bf-8fe4-d391ec91d506' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3916730a-73c7-44bf-8fe4-d391ec91d506', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11763 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3916730a-73c7-44bf-8fe4-d391ec91d506'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '세묜과 어머니', part.name_en = 'II. Semyon and His Mother',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11763 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4a623eac-58b5-4056-8f22-8f43645a2cd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a623eac-58b5-4056-8f22-8f43645a2cd3', 2, 'II', '세묜과 어머니', 'II. Semyon and His Mother', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11763 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a623eac-58b5-4056-8f22-8f43645a2cd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '약혼', part.name_en = 'III. The Betrothal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11763 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:99ef5345-af48-4971-ae5b-39f082bfd052' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99ef5345-af48-4971-ae5b-39f082bfd052', 3, 'III', '약혼', 'III. The Betrothal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11763 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99ef5345-af48-4971-ae5b-39f082bfd052'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '남쪽의 밤', part.name_en = 'IV. The Southern Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11763 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:faa64211-e452-4c3a-b35d-a5ebbcf0b23b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faa64211-e452-4c3a-b35d-a5ebbcf0b23b', 4, 'IV', '남쪽의 밤', 'IV. The Southern Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11763 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faa64211-e452-4c3a-b35d-a5ebbcf0b23b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '처형', part.name_en = 'V. Execution',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11763 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:568b3ff7-c290-438e-8f60-a8fc9e476930' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:568b3ff7-c290-438e-8f60-a8fc9e476930', 5, 'V', '처형', 'V. Execution', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11763 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:568b3ff7-c290-438e-8f60-a8fc9e476930'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '불타는 마을', part.name_en = 'VI. The Village Is Burning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11763 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e96ad984-2c54-4d42-92cc-f90ec24f6d94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e96ad984-2c54-4d42-92cc-f90ec24f6d94', 6, 'VI', '불타는 마을', 'VI. The Village Is Burning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11763 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e96ad984-2c54-4d42-92cc-f90ec24f6d94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '장례', part.name_en = 'VII. Funeral',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11763 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c9fe898d-7757-43fa-92b1-bfe78d97fc75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9fe898d-7757-43fa-92b1-bfe78d97fc75', 7, 'VII', '장례', 'VII. Funeral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11763 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9fe898d-7757-43fa-92b1-bfe78d97fc75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '우리 편이 왔다', part.name_en = 'VIII. Ours Have Come',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11763 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1055238e-42f9-4a3f-af0f-57623d38240c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1055238e-42f9-4a3f-af0f-57623d38240c', 8, 'VIII', '우리 편이 왔다', 'VIII. Ours Have Come', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11763 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1055238e-42f9-4a3f-af0f-57623d38240c'
);


-- Op. 82 피아노 소나타 6번 A장조

UPDATE pieces piece
SET piece.title = '피아노 소나타 6번 A장조', piece.title_en = 'Piano Sonata No. 6 in A major',
    piece.type = 'album', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1940, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11363 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1940
WHERE piece.id = 11363 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11363 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0bf6524e-be31-44dc-a8ab-a16357860321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bf6524e-be31-44dc-a8ab-a16357860321', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11363 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bf6524e-be31-44dc-a8ab-a16357860321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11363 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:689d5fbc-b366-4c65-b52e-de22c76d3b06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:689d5fbc-b366-4c65-b52e-de22c76d3b06', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11363 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:689d5fbc-b366-4c65-b52e-de22c76d3b06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo di valzer lentissimo', part.name_en = 'III. Tempo di valzer lentissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11363 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ae0d4b51-7387-422d-8eb8-b47d32b5906b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae0d4b51-7387-422d-8eb8-b47d32b5906b', 3, 'III', 'Tempo di valzer lentissimo', 'III. Tempo di valzer lentissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11363 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae0d4b51-7387-422d-8eb8-b47d32b5906b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11363 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e51a5b37-83e6-4dfa-97ac-053e91a4ec19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e51a5b37-83e6-4dfa-97ac-053e91a4ec19', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11363 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e51a5b37-83e6-4dfa-97ac-053e91a4ec19'
);


-- Op. 83 피아노 소나타 7번 B♭장조 "전쟁 소나타"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro inquieto', part.name_en = 'I. Allegro inquieto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 326 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1f2e7664-2ff3-36b1-a799-bdbc9cce8f39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f2e7664-2ff3-36b1-a799-bdbc9cce8f39', 1, 'I', 'Allegro inquieto', 'I. Allegro inquieto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 326 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f2e7664-2ff3-36b1-a799-bdbc9cce8f39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante caloroso', part.name_en = 'II. Andante caloroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 326 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e4dc664d-4767-3ac9-9b43-2a69adcc16fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4dc664d-4767-3ac9-9b43-2a69adcc16fd', 2, 'II', 'Andante caloroso', 'II. Andante caloroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 326 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4dc664d-4767-3ac9-9b43-2a69adcc16fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Precipitato', part.name_en = 'III. Precipitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 326 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f0c557ad-95ab-38cd-8c4e-238a9caccbd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0c557ad-95ab-38cd-8c4e-238a9caccbd8', 3, 'III', 'Precipitato', 'III. Precipitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 326 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0c557ad-95ab-38cd-8c4e-238a9caccbd8'
);


-- Op. 84 피아노 소나타 8번 B♭장조

UPDATE pieces piece
SET piece.title = '피아노 소나타 8번 B♭장조', piece.title_en = 'Piano Sonata No. 8 in B♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11579 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 11579 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante dolce', part.name_en = 'I. Andante dolce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11579 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:18001f0d-b07c-393d-9849-69db4e5cf22e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18001f0d-b07c-393d-9849-69db4e5cf22e', 1, 'I', 'Andante dolce', 'I. Andante dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11579 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18001f0d-b07c-393d-9849-69db4e5cf22e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sognando', part.name_en = 'II. Andante sognando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11579 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f399b9c6-0866-32f8-b0ae-d895793e6c30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f399b9c6-0866-32f8-b0ae-d895793e6c30', 2, 'II', 'Andante sognando', 'II. Andante sognando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11579 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f399b9c6-0866-32f8-b0ae-d895793e6c30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11579 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4676d615-5433-334d-a68c-a365509c7ffd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4676d615-5433-334d-a68c-a365509c7ffd', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11579 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4676d615-5433-334d-a68c-a365509c7ffd'
);


-- Op. 85 칸타타 <축배>

UPDATE pieces piece
SET piece.title = '칸타타 <축배>', piece.title_en = 'Zdravitsa (Hail to Stalin)',
    piece.type = 'song', piece.opus_number = 'Op. 85',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1939, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11329 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1939
WHERE piece.id = 11329 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 86 오페라 <수도원에서의 약혼>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <수도원에서의 약혼>', 'Betrothal in a Monastery (The Duenna)', 'song', 'Op. 86', NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <수도원에서의 약혼>'
);


-- Op. 87 발레 <신데렐라>

UPDATE pieces piece
SET piece.title = '발레 <신데렐라>', piece.title_en = 'Cinderella',
    piece.type = 'song', piece.opus_number = 'Op. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11294 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 11294 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 88 교향적 행진곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 행진곡 B♭장조', 'Symphonic March in B♭ major', 'song', 'Op. 88', NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 행진곡 B♭장조'
);


-- Op. 89 7개의 노래와 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7개의 노래와 행진곡', '7 Songs and a March, Op. 89', 'album', 'Op. 89', NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7개의 노래와 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77e2a237-6e37-41de-8c62-1668edb5bc98'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '77e2a237-6e37-41de-8c62-1668edb5bc98'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77e2a237-6e37-41de-8c62-1668edb5bc98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op089:1', 1, NULL, 'Pesnya (Dryan'' admiral''skaya)', 'Pesnya (Dryan'' admiral''skaya) (Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op089:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1352467e-33ed-4b47-8ba9-3890ec3e245b', 2, NULL, 'Pesnya smelykh', 'Pesnya smelykh (Song of the Brave)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1352467e-33ed-4b47-8ba9-3890ec3e245b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3f76fe7-f21a-444f-8767-0df8aa6fb845', 3, NULL, 'Klyatva tankista', 'Klyatva tankista (The Tankman''s Vow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3f76fe7-f21a-444f-8767-0df8aa6fb845'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58e337f0-f7e8-4ae0-9761-67dbbb1c136f', 4, NULL, 'Syn Kabardy', 'Syn Kabardy (Son of Kabarda)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e337f0-f7e8-4ae0-9761-67dbbb1c136f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62b00f5e-213c-491d-a7e2-dcdbaaead5ce', 5, NULL, 'Podruga boytsa', 'Podruga boytsa (The Soldier''s Sweetheart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62b00f5e-213c-491d-a7e2-dcdbaaead5ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:241f053a-2112-48b8-a219-9fcbcce70f94', 6, NULL, 'Frits', 'Frits (Fritz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:241f053a-2112-48b8-a219-9fcbcce70f94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op089:7', 7, NULL, 'Lyubov'' voina', 'Lyubov'' voina (The Warrior''s Love)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op089:7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:prokofiev:prokofiev-op089:8', 8, NULL, '행진곡', 'March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '7개의 노래와 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:prokofiev:prokofiev-op089:8'
);


-- Op. 89bis 취주악을 위한 행진곡 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '취주악을 위한 행진곡 A♭장조', 'March in A♭ major for Military Band', 'song', 'Op. 89bis', NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '취주악을 위한 행진곡 A♭장조'
);


-- Op. 90 교향 모음곡 <1941년>

UPDATE pieces piece
SET piece.title = '교향 모음곡 <1941년>', piece.title_en = 'The Year 1941, Symphonic Suite',
    piece.type = 'album', piece.opus_number = 'Op. 90',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1941, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11517 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1941
WHERE piece.id = 11517 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전투에서', part.name_en = 'I. In the Struggle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11517 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:208c1fcf-64c7-46fe-abc1-62ea70a5c274' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:208c1fcf-64c7-46fe-abc1-62ea70a5c274', 1, 'I', '전투에서', 'I. In the Struggle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11517 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:208c1fcf-64c7-46fe-abc1-62ea70a5c274'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '밤에', part.name_en = 'II. In the Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11517 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5411d171-bfec-4322-8848-958a094b8d2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5411d171-bfec-4322-8848-958a094b8d2f', 2, 'II', '밤에', 'II. In the Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11517 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5411d171-bfec-4322-8848-958a094b8d2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '인류의 형제애를 위하여', part.name_en = 'III. For the Brotherhood of Man',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11517 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:86be33f5-1987-461d-9167-fa4ea04e6574' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86be33f5-1987-461d-9167-fa4ea04e6574', 3, 'III', '인류의 형제애를 위하여', 'III. For the Brotherhood of Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11517 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86be33f5-1987-461d-9167-fa4ea04e6574'
);


-- Op. 91 오페라 <전쟁과 평화>

UPDATE pieces piece
SET piece.title = '오페라 <전쟁과 평화>', piece.title_en = 'War and Peace',
    piece.type = 'song', piece.opus_number = 'Op. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1952, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11396 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1952
WHERE piece.id = 11396 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 92 현악 4중주 2번 F장조 "카바르다 주제에 의한"

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 F장조 "카바르다 주제에 의한"', piece.title_en = 'String Quartet No. 2 in F major "On Kabardinian Themes"',
    piece.type = 'album', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1941, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11302 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1941
WHERE piece.id = 11302 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro sostenuto', part.name_en = 'I. Allegro sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11302 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:da854393-8f46-3343-bb3a-f5a2a20d64aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da854393-8f46-3343-bb3a-f5a2a20d64aa', 1, 'I', 'Allegro sostenuto', 'I. Allegro sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11302 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da854393-8f46-3343-bb3a-f5a2a20d64aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11302 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:12cc3a5f-ec87-3b06-8289-ae7b20e673ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12cc3a5f-ec87-3b06-8289-ae7b20e673ef', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11302 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12cc3a5f-ec87-3b06-8289-ae7b20e673ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro – Andante molto', part.name_en = 'III. Allegro – Andante molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11302 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:af02739c-b32e-32af-ae4d-852ed187795b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af02739c-b32e-32af-ae4d-852ed187795b', 3, 'III', 'Allegro – Andante molto', 'III. Allegro – Andante molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11302 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af02739c-b32e-32af-ae4d-852ed187795b'
);


-- Op. 93 칸타타 <이름 없는 소년의 발라드>

UPDATE pieces piece
SET piece.title = '칸타타 <이름 없는 소년의 발라드>', piece.title_en = 'Ballad of an Unknown Boy',
    piece.type = 'song', piece.opus_number = 'Op. 93',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1943, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11508 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1943
WHERE piece.id = 11508 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 94 플루트 소나타 D장조

UPDATE pieces piece
SET piece.title = '플루트 소나타 D장조', piece.title_en = 'Flute Sonata in D major',
    piece.type = 'album', piece.opus_number = 'Op. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1943, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11818 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1943
WHERE piece.id = 11818 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11818 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d67612da-f20e-4808-aa5f-7f5b1a03cf22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d67612da-f20e-4808-aa5f-7f5b1a03cf22', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11818 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d67612da-f20e-4808-aa5f-7f5b1a03cf22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Presto', part.name_en = 'II. Scherzo. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11818 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5be492b6-ac6f-4470-b12c-7ffe6467c2a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5be492b6-ac6f-4470-b12c-7ffe6467c2a0', 2, 'II', '스케르초. Presto', 'II. Scherzo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11818 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5be492b6-ac6f-4470-b12c-7ffe6467c2a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11818 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d264c89f-885e-4aaf-8109-1f798bc412f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d264c89f-885e-4aaf-8109-1f798bc412f3', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11818 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d264c89f-885e-4aaf-8109-1f798bc412f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio', part.name_en = 'IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11818 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d2f6a4fc-2748-4458-a129-ea875727b1fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2f6a4fc-2748-4458-a129-ea875727b1fc', 4, 'IV', 'Allegro con brio', 'IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11818 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2f6a4fc-2748-4458-a129-ea875727b1fc'
);


-- Op. 94bis 바이올린 소나타 2번 D장조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 D장조', piece.title_en = 'Violin Sonata No. 2 in D major',
    piece.type = 'album', piece.opus_number = 'Op. 94bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11646 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 11646 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11646 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:96f1fe98-efce-3fe8-966b-3dd3c9c9bd2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96f1fe98-efce-3fe8-966b-3dd3c9c9bd2c', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11646 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96f1fe98-efce-3fe8-966b-3dd3c9c9bd2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Presto', part.name_en = 'II. Scherzo. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11646 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:733c46d5-1763-3915-bc65-7c9e86e7bcfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:733c46d5-1763-3915-bc65-7c9e86e7bcfe', 2, 'II', '스케르초. Presto', 'II. Scherzo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11646 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:733c46d5-1763-3915-bc65-7c9e86e7bcfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11646 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c3f55588-3ff3-304c-84e6-d055cf3b1dcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3f55588-3ff3-304c-84e6-d055cf3b1dcb', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11646 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3f55588-3ff3-304c-84e6-d055cf3b1dcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio', part.name_en = 'IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11646 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e795f077-fdc3-39e2-a197-64a4d5e2d04b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e795f077-fdc3-39e2-a197-64a4d5e2d04b', 4, 'IV', 'Allegro con brio', 'IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11646 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e795f077-fdc3-39e2-a197-64a4d5e2d04b'
);


-- Op. 95 <신데렐라>에서 3개의 소품

UPDATE pieces piece
SET piece.title = '<신데렐라>에서 3개의 소품', piece.title_en = '3 Pieces from Cinderella, Op. 95',
    piece.type = 'album', piece.opus_number = 'Op. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1942, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11461 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1942
WHERE piece.id = 11461 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '인테르메초', part.name_en = 'Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11461 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ad874c07-36b7-4ce0-ad98-f999e35d30db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad874c07-36b7-4ce0-ad98-f999e35d30db', 1, NULL, '인테르메초', 'Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11461 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad874c07-36b7-4ce0-ad98-f999e35d30db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '가보트', part.name_en = 'Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11461 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c790b25d-f8ad-4a4a-a441-ea10be987b77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c790b25d-f8ad-4a4a-a441-ea10be987b77', 2, NULL, '가보트', 'Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11461 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c790b25d-f8ad-4a4a-a441-ea10be987b77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '느린 왈츠', part.name_en = 'Valse lente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11461 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:05246277-a13b-4e2d-a4c5-ee94c86180ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05246277-a13b-4e2d-a4c5-ee94c86180ea', 3, NULL, '느린 왈츠', 'Valse lente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11461 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05246277-a13b-4e2d-a4c5-ee94c86180ea'
);


-- Op. 96 3개의 소품 Op. 96

UPDATE pieces piece
SET piece.title = '3개의 소품 Op. 96', piece.title_en = '3 Pieces, Op. 96',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '96',
    piece.composition_year = COALESCE(1942, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11776 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1942
WHERE piece.id = 11776 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '왈츠 (<전쟁과 평화>에서)', part.name_en = 'Waltz from War and Peace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11776 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ed5be9fc-34cb-4af4-a1ed-8bba842c1f5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed5be9fc-34cb-4af4-a1ed-8bba842c1f5c', 1, NULL, '왈츠 (<전쟁과 평화>에서)', 'Waltz from War and Peace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11776 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed5be9fc-34cb-4af4-a1ed-8bba842c1f5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '콩트르당스 (<레르몬토프>에서)', part.name_en = 'Contredanse from Lermontov',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11776 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a8b29c90-b066-43cb-b861-6e760b056b24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8b29c90-b066-43cb-b861-6e760b056b24', 2, NULL, '콩트르당스 (<레르몬토프>에서)', 'Contredanse from Lermontov', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11776 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8b29c90-b066-43cb-b861-6e760b056b24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '메피스토 왈츠 (<레르몬토프>에서)', part.name_en = 'Mephisto Waltz from Lermontov',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11776 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e48ff7c6-9e02-46c5-87e6-304988e64be6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e48ff7c6-9e02-46c5-87e6-304988e64be6', 3, NULL, '메피스토 왈츠 (<레르몬토프>에서)', 'Mephisto Waltz from Lermontov', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11776 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48ff7c6-9e02-46c5-87e6-304988e64be6'
);


-- Op. 97 <신데렐라>에서 10개의 소품

UPDATE pieces piece
SET piece.title = '<신데렐라>에서 10개의 소품', piece.title_en = '10 Pieces from Cinderella, Op. 97',
    piece.type = 'album', piece.opus_number = 'Op. 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1943, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11359 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1943
WHERE piece.id = 11359 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '봄의 요정', part.name_en = 'Spring Fairy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:84b1c9f5-2a89-472f-b0fd-ee5f667541c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84b1c9f5-2a89-472f-b0fd-ee5f667541c2', 1, NULL, '봄의 요정', 'Spring Fairy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84b1c9f5-2a89-472f-b0fd-ee5f667541c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '여름의 요정', part.name_en = 'Summer Fairy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e28b843a-76b6-4772-9d20-def6873ab5d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e28b843a-76b6-4772-9d20-def6873ab5d4', 2, NULL, '여름의 요정', 'Summer Fairy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e28b843a-76b6-4772-9d20-def6873ab5d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '가을의 요정', part.name_en = 'Autumn Fairy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:bd6927fc-8449-4565-bd39-30f72a876681' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd6927fc-8449-4565-bd39-30f72a876681', 3, NULL, '가을의 요정', 'Autumn Fairy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd6927fc-8449-4565-bd39-30f72a876681'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '겨울의 요정', part.name_en = 'Winter Fairy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a82d4d8f-b708-446b-8ad9-38dafb88aa1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a82d4d8f-b708-446b-8ad9-38dafb88aa1e', 4, NULL, '겨울의 요정', 'Winter Fairy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a82d4d8f-b708-446b-8ad9-38dafb88aa1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '메뚜기와 잠자리', part.name_en = 'Grasshoppers and Dragonflies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d5b6e5db-c460-4c40-9b2e-4044a8cdd8fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5b6e5db-c460-4c40-9b2e-4044a8cdd8fc', 5, NULL, '메뚜기와 잠자리', 'Grasshoppers and Dragonflies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5b6e5db-c460-4c40-9b2e-4044a8cdd8fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '오리엔탈리아', part.name_en = 'Orientalia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b267c453-9c9b-4b45-88d2-885b2f619293' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b267c453-9c9b-4b45-88d2-885b2f619293', 6, NULL, '오리엔탈리아', 'Orientalia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b267c453-9c9b-4b45-88d2-885b2f619293'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '파스피에', part.name_en = 'Passepied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f6ec1b17-877a-41d5-a9d4-2336f6cb2c2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6ec1b17-877a-41d5-a9d4-2336f6cb2c2e', 7, NULL, '파스피에', 'Passepied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6ec1b17-877a-41d5-a9d4-2336f6cb2c2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '카프리치오', part.name_en = 'Capriccio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ee6fbcd6-4364-4710-b2e8-a384c7fc36db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee6fbcd6-4364-4710-b2e8-a384c7fc36db', 8, NULL, '카프리치오', 'Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee6fbcd6-4364-4710-b2e8-a384c7fc36db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '부레', part.name_en = 'Bourrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7efcdd5a-d71d-47fe-9f08-8c95529f1f77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7efcdd5a-d71d-47fe-9f08-8c95529f1f77', 9, NULL, '부레', 'Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7efcdd5a-d71d-47fe-9f08-8c95529f1f77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '아다지오 (왕자와 신데렐라)', part.name_en = 'Adagio (The Prince and Cinderella)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11359 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c6baf6d5-8cde-4d81-a038-c492eaa0e859' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6baf6d5-8cde-4d81-a038-c492eaa0e859', 10, NULL, '아다지오 (왕자와 신데렐라)', 'Adagio (The Prince and Cinderella)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11359 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6baf6d5-8cde-4d81-a038-c492eaa0e859'
);


-- Op. 97bis 첼로와 피아노를 위한 아다지오 (<신데렐라>에서)

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 아다지오 (<신데렐라>에서)', piece.title_en = 'Adagio from Cinderella, for cello and piano',
    piece.type = 'song', piece.opus_number = 'Op. 97bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11470 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 11470 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 99 취주악을 위한 행진곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '취주악을 위한 행진곡 B♭장조', 'March in B♭ major for Military Band', 'song', 'Op. 99', NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '취주악을 위한 행진곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e2edca4-2121-4f90-848e-8267fd3543ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e2edca4-2121-4f90-848e-8267fd3543ae'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '취주악을 위한 행진곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e2edca4-2121-4f90-848e-8267fd3543ae'
);


-- Op. 100 교향곡 5번 B♭장조

UPDATE pieces piece
SET piece.title = '교향곡 5번 B♭장조', piece.title_en = 'Symphony No. 5 in B♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 100',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11320 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 11320 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11320 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:bcda84b2-30df-3342-a102-32498903f89a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcda84b2-30df-3342-a102-32498903f89a', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11320 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcda84b2-30df-3342-a102-32498903f89a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro marcato', part.name_en = 'II. Allegro marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11320 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7f1c1956-d039-3112-9663-a75195a64ffa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f1c1956-d039-3112-9663-a75195a64ffa', 2, 'II', 'Allegro marcato', 'II. Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11320 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f1c1956-d039-3112-9663-a75195a64ffa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11320 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:98b128b6-403e-3d12-831d-a65d4c1f3c88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b128b6-403e-3d12-831d-a65d4c1f3c88', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11320 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b128b6-403e-3d12-831d-a65d4c1f3c88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro giocoso', part.name_en = 'IV. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11320 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:aed8c2e2-3abb-3c91-bafd-6d88e4182a69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aed8c2e2-3abb-3c91-bafd-6d88e4182a69', 4, 'IV', 'Allegro giocoso', 'IV. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11320 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aed8c2e2-3abb-3c91-bafd-6d88e4182a69'
);


-- Op. 101 발레 모음곡 <로미오와 줄리엣> 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <로미오와 줄리엣> 3번', 'Romeo and Juliet, Suite No. 3', 'album', 'Op. 101', NULL, NULL, 1946, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <로미오와 줄리엣> 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7703eabf-7713-4c41-8a30-2e60403e186b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7703eabf-7713-4c41-8a30-2e60403e186b'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7703eabf-7713-4c41-8a30-2e60403e186b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f22fee9-e5f1-3c31-b211-2a244b32d4f6', 1, 'I', '분수 곁의 로미오', 'I. Romeo at the Fountain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f22fee9-e5f1-3c31-b211-2a244b32d4f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9ec476d-5233-30b4-83dc-1b5e1248b5a4', 2, 'II', '아침 춤', 'II. Morning Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9ec476d-5233-30b4-83dc-1b5e1248b5a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1960607b-f3e5-3e74-aa4b-ba866a220be2', 3, 'III', '줄리엣', 'III. Juliet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1960607b-f3e5-3e74-aa4b-ba866a220be2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c26bf5f-c9e5-3dba-a7eb-7c15415ecc5c', 4, 'IV', '유모', 'IV. The Nurse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c26bf5f-c9e5-3dba-a7eb-7c15415ecc5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4825415-50ee-4b81-8a43-3c228a22923e', 5, 'V', '아침 세레나데', 'V. Aubade (Morning Serenade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4825415-50ee-4b81-8a43-3c228a22923e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80c8810c-b031-3fe4-b023-78a114aac487', 6, 'VI', '줄리엣의 죽음', 'VI. The Death of Juliet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '발레 모음곡 <로미오와 줄리엣> 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80c8810c-b031-3fe4-b023-78a114aac487'
);


-- Op. 102 <신데렐라>에서 6개의 소품

UPDATE pieces piece
SET piece.title = '<신데렐라>에서 6개의 소품', piece.title_en = '6 Pieces from Cinderella, Op. 102',
    piece.type = 'album', piece.opus_number = 'Op. 102',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11297 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 11297 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '왈츠 (신데렐라와 왕자)', part.name_en = 'Waltz (Cinderella and the Prince)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11297 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:340cc51a-969b-45f5-9edd-ddf9561c4063' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:340cc51a-969b-45f5-9edd-ddf9561c4063', 1, NULL, '왈츠 (신데렐라와 왕자)', 'Waltz (Cinderella and the Prince)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11297 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:340cc51a-969b-45f5-9edd-ddf9561c4063'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '신데렐라의 변주', part.name_en = 'Cinderella''s Variation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11297 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:eae4a0bf-51ab-434b-b784-290f7829fc8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eae4a0bf-51ab-434b-b784-290f7829fc8d', 2, NULL, '신데렐라의 변주', 'Cinderella''s Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11297 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae4a0bf-51ab-434b-b784-290f7829fc8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '다툼', part.name_en = 'Quarrel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11297 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5817419a-953d-4112-a1b9-6e8890c22d02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5817419a-953d-4112-a1b9-6e8890c22d02', 3, NULL, '다툼', 'Quarrel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11297 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5817419a-953d-4112-a1b9-6e8890c22d02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '왈츠 (무도회로 떠나는 신데렐라)', part.name_en = 'Waltz (Cinderella Goes to the Ball)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11297 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f41f42f9-0a89-4596-a918-38b89d130d67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f41f42f9-0a89-4596-a918-38b89d130d67', 4, NULL, '왈츠 (무도회로 떠나는 신데렐라)', 'Waltz (Cinderella Goes to the Ball)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11297 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f41f42f9-0a89-4596-a918-38b89d130d67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '숄 춤', part.name_en = 'Pas de châle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11297 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9769468d-3b18-406e-99e4-5cd9fdf808fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9769468d-3b18-406e-99e4-5cd9fdf808fb', 5, NULL, '숄 춤', 'Pas de châle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11297 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9769468d-3b18-406e-99e4-5cd9fdf808fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '아모로소', part.name_en = 'Amoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11297 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b5a3b8e2-d6fc-4406-beb2-be4e47ad6769' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5a3b8e2-d6fc-4406-beb2-be4e47ad6769', 6, NULL, '아모로소', 'Amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11297 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5a3b8e2-d6fc-4406-beb2-be4e47ad6769'
);


-- Op. 103 피아노 소나타 9번 C장조

UPDATE pieces piece
SET piece.title = '피아노 소나타 9번 C장조', piece.title_en = 'Piano Sonata No. 9 in C major',
    piece.type = 'album', piece.opus_number = 'Op. 103',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1947, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11693 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1947
WHERE piece.id = 11693 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11693 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f6e5b65a-7a52-4e9c-b814-ff2d4cf49c75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6e5b65a-7a52-4e9c-b814-ff2d4cf49c75', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11693 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6e5b65a-7a52-4e9c-b814-ff2d4cf49c75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro strepitoso', part.name_en = 'II. Allegro strepitoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11693 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:957b7bfe-f905-47c7-b12f-ac8012d2534a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:957b7bfe-f905-47c7-b12f-ac8012d2534a', 2, 'II', 'Allegro strepitoso', 'II. Allegro strepitoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11693 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:957b7bfe-f905-47c7-b12f-ac8012d2534a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante tranquillo', part.name_en = 'III. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11693 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:fa680d57-8594-4446-a0db-98ec494ed011' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa680d57-8594-4446-a0db-98ec494ed011', 3, 'III', 'Andante tranquillo', 'III. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11693 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa680d57-8594-4446-a0db-98ec494ed011'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio, ma non troppo presto', part.name_en = 'IV. Allegro con brio, ma non troppo presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11693 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ffd5e7c8-d0cc-43e0-9672-deb22254a763' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffd5e7c8-d0cc-43e0-9672-deb22254a763', 4, 'IV', 'Allegro con brio, ma non troppo presto', 'IV. Allegro con brio, ma non troppo presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11693 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffd5e7c8-d0cc-43e0-9672-deb22254a763'
);


-- Op. 104 12개의 러시아 민요

UPDATE pieces piece
SET piece.title = '12개의 러시아 민요', piece.title_en = '12 Russian Folk Songs, Op. 104',
    piece.type = 'album', piece.opus_number = 'Op. 104',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11405 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 11405 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'V lete kalina', part.name_en = 'V lete kalina (Guelder Rose in Summer)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b58c3e01-2011-41b1-b328-b7522e44298a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b58c3e01-2011-41b1-b328-b7522e44298a', 1, NULL, 'V lete kalina', 'V lete kalina (Guelder Rose in Summer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b58c3e01-2011-41b1-b328-b7522e44298a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Zelyonaya roshchitsa', part.name_en = 'Zelyonaya roshchitsa (The Green Grove)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:443e61d6-f959-4988-beec-f33f84e0e369' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:443e61d6-f959-4988-beec-f33f84e0e369', 2, NULL, 'Zelyonaya roshchitsa', 'Zelyonaya roshchitsa (The Green Grove)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:443e61d6-f959-4988-beec-f33f84e0e369'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Na gore-to kalina', part.name_en = 'Na gore-to kalina (Guelder Rose on the Hill)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f1b1c941-b9a1-436f-9be4-83ee4e9eb13e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1b1c941-b9a1-436f-9be4-83ee4e9eb13e', 3, NULL, 'Na gore-to kalina', 'Na gore-to kalina (Guelder Rose on the Hill)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1b1c941-b9a1-436f-9be4-83ee4e9eb13e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Snezhki belye', part.name_en = 'Snezhki belye (White Snowflakes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d6d7ddae-b25c-4ef6-b02b-5f6788e58a5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6d7ddae-b25c-4ef6-b02b-5f6788e58a5c', 4, NULL, 'Snezhki belye', 'Snezhki belye (White Snowflakes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6d7ddae-b25c-4ef6-b02b-5f6788e58a5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Kari glazki', part.name_en = 'Kari glazki (Brown Eyes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b2e885eb-1f25-4865-b724-a22fe8e1edfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2e885eb-1f25-4865-b724-a22fe8e1edfc', 5, NULL, 'Kari glazki', 'Kari glazki (Brown Eyes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2e885eb-1f25-4865-b724-a22fe8e1edfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Katerina', part.name_en = 'Katerina',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f732a171-4679-48a2-8178-8e573c2ccafd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f732a171-4679-48a2-8178-8e573c2ccafd', 6, NULL, 'Katerina', 'Katerina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f732a171-4679-48a2-8178-8e573c2ccafd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Son', part.name_en = 'Son (The Dream)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:53aa756e-b09c-4872-b31e-13b51e0ca48d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53aa756e-b09c-4872-b31e-13b51e0ca48d', 7, NULL, 'Son', 'Son (The Dream)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53aa756e-b09c-4872-b31e-13b51e0ca48d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Za lesochkom', part.name_en = 'Za lesochkom (Beyond the Woods)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9bc78435-305a-4c23-9865-04b5dbdc8c83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bc78435-305a-4c23-9865-04b5dbdc8c83', 8, NULL, 'Za lesochkom', 'Za lesochkom (Beyond the Woods)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bc78435-305a-4c23-9865-04b5dbdc8c83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Dunyushka', part.name_en = 'Dunyushka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f45b04d9-9dc6-41e5-8b43-54264bfce258' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f45b04d9-9dc6-41e5-8b43-54264bfce258', 9, NULL, 'Dunyushka', 'Dunyushka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f45b04d9-9dc6-41e5-8b43-54264bfce258'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Ya nigde druzhka ne vizhu', part.name_en = 'Ya nigde druzhka ne vizhu (My Beloved Is Gone)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:94809d73-4eed-47f4-ae9d-cdf25cab859d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94809d73-4eed-47f4-ae9d-cdf25cab859d', 10, NULL, 'Ya nigde druzhka ne vizhu', 'Ya nigde druzhka ne vizhu (My Beloved Is Gone)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94809d73-4eed-47f4-ae9d-cdf25cab859d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Sashen''ka', part.name_en = 'Sashen''ka (Little Sasha)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:b008ef4e-15ca-4873-b838-d067e6e2302a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b008ef4e-15ca-4873-b838-d067e6e2302a', 11, NULL, 'Sashen''ka', 'Sashen''ka (Little Sasha)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b008ef4e-15ca-4873-b838-d067e6e2302a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Chernets', part.name_en = 'Chernets (The Monk)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11405 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:11127436-11e4-4b0d-a241-fdfffa69511e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11127436-11e4-4b0d-a241-fdfffa69511e', 12, NULL, 'Chernets', 'Chernets (The Monk)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11405 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11127436-11e4-4b0d-a241-fdfffa69511e'
);


-- Op. 105 전쟁 종결 송가

UPDATE pieces piece
SET piece.title = '전쟁 종결 송가', piece.title_en = 'Ode to the End of the War',
    piece.type = 'song', piece.opus_number = 'Op. 105',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1945, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11959 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1945
WHERE piece.id = 11959 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 106 2개의 2중창

UPDATE pieces piece
SET piece.title = '2개의 2중창', piece.title_en = '2 Duets, Op. 106',
    piece.type = 'album', piece.opus_number = 'Op. 106',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1945, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11825 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1945
WHERE piece.id = 11825 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Moskovskaya slavna put''-dorozhka', part.name_en = 'Moskovskaya slavna put''-dorozhka (The Road to Moscow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11825 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:09ef6057-b469-41b0-9848-91ada532385e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09ef6057-b469-41b0-9848-91ada532385e', 1, NULL, 'Moskovskaya slavna put''-dorozhka', 'Moskovskaya slavna put''-dorozhka (The Road to Moscow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11825 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09ef6057-b469-41b0-9848-91ada532385e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vsyakoy na svete-to nezhitsya', part.name_en = 'Vsyakoy na svete-to nezhitsya (Every Man Marries)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11825 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e397b9a9-334d-4f45-8166-2f74ad9894a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e397b9a9-334d-4f45-8166-2f74ad9894a7', 2, NULL, 'Vsyakoy na svete-to nezhitsya', 'Vsyakoy na svete-to nezhitsya (Every Man Marries)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11825 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e397b9a9-334d-4f45-8166-2f74ad9894a7'
);


-- Op. 107 발레 모음곡 <신데렐라> 1번

UPDATE pieces piece
SET piece.title = '발레 모음곡 <신데렐라> 1번', piece.title_en = 'Cinderella, Suite No. 1',
    piece.type = 'album', piece.opus_number = 'Op. 107',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1946, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11733 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1946
WHERE piece.id = 11733 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11733 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e2c5dd3a-cd55-37d8-bae2-42b04c488898' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2c5dd3a-cd55-37d8-bae2-42b04c488898', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11733 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2c5dd3a-cd55-37d8-bae2-42b04c488898'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '숄 춤', part.name_en = 'II. Pas de châle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11733 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a0f806cb-8ad4-3acb-b9c9-421f4816c104' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0f806cb-8ad4-3acb-b9c9-421f4816c104', 2, 'II', '숄 춤', 'II. Pas de châle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11733 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0f806cb-8ad4-3acb-b9c9-421f4816c104'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '다툼', part.name_en = 'III. Quarrel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11733 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a61131bf-17c2-32c7-8000-e77115d74c65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a61131bf-17c2-32c7-8000-e77115d74c65', 3, 'III', '다툼', 'III. Quarrel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11733 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a61131bf-17c2-32c7-8000-e77115d74c65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '요정 할머니와 겨울 요정', part.name_en = 'IV. The Fairy Godmother and the Winter Fairy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11733 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f9a1fe81-7c1f-3cc5-bf6e-4cfde925fb6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9a1fe81-7c1f-3cc5-bf6e-4cfde925fb6f', 4, 'IV', '요정 할머니와 겨울 요정', 'IV. The Fairy Godmother and the Winter Fairy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11733 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9a1fe81-7c1f-3cc5-bf6e-4cfde925fb6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '마주르카', part.name_en = 'V. Mazurka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11733 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:47de1e93-94d8-4a0b-9230-dbb7112faf7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47de1e93-94d8-4a0b-9230-dbb7112faf7f', 5, 'V', '마주르카', 'V. Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11733 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47de1e93-94d8-4a0b-9230-dbb7112faf7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '무도회로 떠나는 신데렐라', part.name_en = 'VI. Cinderella Goes to the Ball',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11733 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:61c2018d-4745-35ed-ab96-5a2f6a738ff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61c2018d-4745-35ed-ab96-5a2f6a738ff5', 6, 'VI', '무도회로 떠나는 신데렐라', 'VI. Cinderella Goes to the Ball', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11733 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61c2018d-4745-35ed-ab96-5a2f6a738ff5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '신데렐라의 왈츠', part.name_en = 'VII. Cinderella''s Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11733 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:59b84b24-f4eb-324a-b3ad-0ceeb98b69fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59b84b24-f4eb-324a-b3ad-0ceeb98b69fa', 7, 'VII', '신데렐라의 왈츠', 'VII. Cinderella''s Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11733 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59b84b24-f4eb-324a-b3ad-0ceeb98b69fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '자정', part.name_en = 'VIII. Midnight',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11733 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:0ad53986-4edf-3955-a9ac-a2a7db13d792' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad53986-4edf-3955-a9ac-a2a7db13d792', 8, 'VIII', '자정', 'VIII. Midnight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11733 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad53986-4edf-3955-a9ac-a2a7db13d792'
);


-- Op. 108 발레 모음곡 <신데렐라> 2번

UPDATE pieces piece
SET piece.title = '발레 모음곡 <신데렐라> 2번', piece.title_en = 'Cinderella, Suite No. 2',
    piece.type = 'album', piece.opus_number = 'Op. 108',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1946, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11653 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1946
WHERE piece.id = 11653 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '신데렐라의 꿈', part.name_en = 'I. Cinderella''s Dreams',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11653 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:10363dc3-4601-4f5b-a964-d6edb974a835' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10363dc3-4601-4f5b-a964-d6edb974a835', 1, 'I', '신데렐라의 꿈', 'I. Cinderella''s Dreams', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11653 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10363dc3-4601-4f5b-a964-d6edb974a835'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '춤 수업과 가보트', part.name_en = 'II. Dancing Lesson and Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11653 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8869124e-5793-4f60-a9d2-4e5ee59e0858' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8869124e-5793-4f60-a9d2-4e5ee59e0858', 2, 'II', '춤 수업과 가보트', 'II. Dancing Lesson and Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11653 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8869124e-5793-4f60-a9d2-4e5ee59e0858'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '봄의 요정과 여름의 요정', part.name_en = 'III. Spring Fairy and Summer Fairy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11653 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7d099593-f348-45bc-96b8-50b17b4f5ab0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d099593-f348-45bc-96b8-50b17b4f5ab0', 3, 'III', '봄의 요정과 여름의 요정', 'III. Spring Fairy and Summer Fairy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11653 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d099593-f348-45bc-96b8-50b17b4f5ab0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '부레', part.name_en = 'IV. Bourrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11653 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4b2d0a47-09d7-4c12-ac79-d7605f26a11f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b2d0a47-09d7-4c12-ac79-d7605f26a11f', 4, 'IV', '부레', 'IV. Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11653 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b2d0a47-09d7-4c12-ac79-d7605f26a11f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '무도회에 온 신데렐라', part.name_en = 'V. Cinderella Arrives at the Ball',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11653 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:a80a75d2-8c6f-49a6-a4fb-5335b3d2a92a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a80a75d2-8c6f-49a6-a4fb-5335b3d2a92a', 5, 'V', '무도회에 온 신데렐라', 'V. Cinderella Arrives at the Ball', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11653 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a80a75d2-8c6f-49a6-a4fb-5335b3d2a92a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '큰 왈츠', part.name_en = 'VI. Grand Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11653 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:33f52b4d-cc1f-4c81-a8ad-335dfca8d435' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33f52b4d-cc1f-4c81-a8ad-335dfca8d435', 6, 'VI', '큰 왈츠', 'VI. Grand Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11653 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33f52b4d-cc1f-4c81-a8ad-335dfca8d435'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '갤럽', part.name_en = 'VII. Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11653 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:07d009e1-9c09-4486-87ac-8eba9be08500' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07d009e1-9c09-4486-87ac-8eba9be08500', 7, 'VII', '갤럽', 'VII. Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11653 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07d009e1-9c09-4486-87ac-8eba9be08500'
);


-- Op. 109 발레 모음곡 <신데렐라> 3번

UPDATE pieces piece
SET piece.title = '발레 모음곡 <신데렐라> 3번', piece.title_en = 'Cinderella, Suite No. 3',
    piece.type = 'album', piece.opus_number = 'Op. 109',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1946, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12003 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1946
WHERE piece.id = 12003 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '파반', part.name_en = 'I. Pavane',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12003 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:041a8bbb-1ee0-4524-af88-c4a99c945a20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:041a8bbb-1ee0-4524-af88-c4a99c945a20', 1, 'I', '파반', 'I. Pavane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12003 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:041a8bbb-1ee0-4524-af88-c4a99c945a20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '신데렐라와 왕자', part.name_en = 'II. Cinderella and the Prince',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12003 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9b4d940d-dc83-4972-ba6f-1f71458454cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b4d940d-dc83-4972-ba6f-1f71458454cd', 2, 'II', '신데렐라와 왕자', 'II. Cinderella and the Prince', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12003 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b4d940d-dc83-4972-ba6f-1f71458454cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '세 개의 오렌지', part.name_en = 'III. Three Oranges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12003 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6d87cd04-2c3c-45f1-9f29-face72138d41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d87cd04-2c3c-45f1-9f29-face72138d41', 3, 'III', '세 개의 오렌지', 'III. Three Oranges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12003 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d87cd04-2c3c-45f1-9f29-face72138d41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '남쪽 나라', part.name_en = 'IV. Southern Countries',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12003 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9009777a-0794-4a1a-9ba8-1eabf80431b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9009777a-0794-4a1a-9ba8-1eabf80431b8', 4, 'IV', '남쪽 나라', 'IV. Southern Countries', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12003 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9009777a-0794-4a1a-9ba8-1eabf80431b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '오리엔탈리아', part.name_en = 'V. Orientalia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12003 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d8390268-e5c8-41c0-b85f-a51ac32cdd04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8390268-e5c8-41c0-b85f-a51ac32cdd04', 5, 'V', '오리엔탈리아', 'V. Orientalia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12003 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8390268-e5c8-41c0-b85f-a51ac32cdd04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '신데렐라를 찾은 왕자', part.name_en = 'VI. The Prince Finds Cinderella',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12003 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:aa74a236-e92d-4c89-9c09-0ab8dad1bc9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa74a236-e92d-4c89-9c09-0ab8dad1bc9b', 6, 'VI', '신데렐라를 찾은 왕자', 'VI. The Prince Finds Cinderella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12003 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa74a236-e92d-4c89-9c09-0ab8dad1bc9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '느린 왈츠', part.name_en = 'VII. Slow Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12003 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:31c2246b-20ad-4da5-ac14-1a000733bc94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31c2246b-20ad-4da5-ac14-1a000733bc94', 7, 'VII', '느린 왈츠', 'VII. Slow Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12003 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31c2246b-20ad-4da5-ac14-1a000733bc94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '아모로소', part.name_en = 'VIII. Amoroso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12003 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:f7b7e059-e270-4b20-9b76-56c250b318b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7b7e059-e270-4b20-9b76-56c250b318b7', 8, 'VIII', '아모로소', 'VIII. Amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12003 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7b7e059-e270-4b20-9b76-56c250b318b7'
);


-- Op. 110 왈츠 모음곡

UPDATE pieces piece
SET piece.title = '왈츠 모음곡', piece.title_en = 'Waltz Suite',
    piece.type = 'album', piece.opus_number = 'Op. 110',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1946, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11430 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1946
WHERE piece.id = 11430 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '처음 만난 그때부터 (<전쟁과 평화>에서)', part.name_en = 'I. Since We Met (War and Peace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11430 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4576090b-9105-4430-9484-dc7b3e110754' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4576090b-9105-4430-9484-dc7b3e110754', 1, 'I', '처음 만난 그때부터 (<전쟁과 평화>에서)', 'I. Since We Met (War and Peace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11430 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4576090b-9105-4430-9484-dc7b3e110754'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '궁전에서 (<신데렐라>에서)', part.name_en = 'II. In the Palace (Cinderella)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11430 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:88486deb-b19f-4ed3-807f-0bf1f7b86069' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88486deb-b19f-4ed3-807f-0bf1f7b86069', 2, 'II', '궁전에서 (<신데렐라>에서)', 'II. In the Palace (Cinderella)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11430 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88486deb-b19f-4ed3-807f-0bf1f7b86069'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '메피스토 왈츠 (<레르몬토프>에서)', part.name_en = 'III. Mephisto Waltz (Lermontov)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11430 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:46b8d7dd-8a64-394a-92ef-11d76ae0db56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46b8d7dd-8a64-394a-92ef-11d76ae0db56', 3, 'III', '메피스토 왈츠 (<레르몬토프>에서)', 'III. Mephisto Waltz (Lermontov)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11430 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b8d7dd-8a64-394a-92ef-11d76ae0db56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '동화의 끝 (<신데렐라>에서)', part.name_en = 'IV. End of the Fairy Tale (Cinderella)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11430 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:417fec39-3bed-4a10-b0a9-cb9e8d90e1b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:417fec39-3bed-4a10-b0a9-cb9e8d90e1b6', 4, 'IV', '동화의 끝 (<신데렐라>에서)', 'IV. End of the Fairy Tale (Cinderella)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11430 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:417fec39-3bed-4a10-b0a9-cb9e8d90e1b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '새해 무도회 (<전쟁과 평화>에서)', part.name_en = 'V. New Year''s Eve Ball (War and Peace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11430 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:baba4c20-371e-4b79-b951-e9d4c38bc9f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baba4c20-371e-4b79-b951-e9d4c38bc9f4', 5, 'V', '새해 무도회 (<전쟁과 평화>에서)', 'V. New Year''s Eve Ball (War and Peace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11430 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baba4c20-371e-4b79-b951-e9d4c38bc9f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '행복 (<신데렐라>에서)', part.name_en = 'VI. Happiness (Cinderella)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11430 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ef5a9c1b-1dad-3667-b8c6-d96ea6c6b431' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef5a9c1b-1dad-3667-b8c6-d96ea6c6b431', 6, 'VI', '행복 (<신데렐라>에서)', 'VI. Happiness (Cinderella)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11430 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef5a9c1b-1dad-3667-b8c6-d96ea6c6b431'
);


-- Op. 111 교향곡 6번 E♭단조

UPDATE pieces piece
SET piece.title = '교향곡 6번 E♭단조', piece.title_en = 'Symphony No. 6 in E♭ minor',
    piece.type = 'album', piece.opus_number = 'Op. 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1947, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11395 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1947
WHERE piece.id = 11395 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11395 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:e071b3d7-0f20-39b3-90fe-6f30abdaf4e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e071b3d7-0f20-39b3-90fe-6f30abdaf4e1', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11395 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e071b3d7-0f20-39b3-90fe-6f30abdaf4e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11395 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:fca08dcf-c766-300e-b358-b4453584ef27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fca08dcf-c766-300e-b358-b4453584ef27', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11395 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fca08dcf-c766-300e-b358-b4453584ef27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace', part.name_en = 'III. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11395 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8e5c681a-d264-35ec-8b45-913a1ec8d7ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e5c681a-d264-35ec-8b45-913a1ec8d7ef', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11395 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e5c681a-d264-35ec-8b45-913a1ec8d7ef'
);


-- Op. 112 교향곡 4번 C장조 (개정판)

UPDATE pieces piece
SET piece.title = '교향곡 4번 C장조 (개정판)', piece.title_en = 'Symphony No. 4 in C major (revised version)',
    piece.type = 'album', piece.opus_number = 'Op. 112',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1947, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11543 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1947
WHERE piece.id = 11543 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante – Allegro eroico', part.name_en = 'I. Andante – Allegro eroico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11543 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:68009ea2-58c9-4c37-a296-7a64fe68af78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68009ea2-58c9-4c37-a296-7a64fe68af78', 1, 'I', 'Andante – Allegro eroico', 'I. Andante – Allegro eroico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11543 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68009ea2-58c9-4c37-a296-7a64fe68af78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante tranquillo', part.name_en = 'II. Andante tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11543 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:646e35c7-0bfd-4c95-be89-661e8a44db6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:646e35c7-0bfd-4c95-be89-661e8a44db6c', 2, 'II', 'Andante tranquillo', 'II. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11543 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:646e35c7-0bfd-4c95-be89-661e8a44db6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato, quasi allegretto', part.name_en = 'III. Moderato, quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11543 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1c274047-6792-434b-9722-bbf5de8d66a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c274047-6792-434b-9722-bbf5de8d66a9', 3, 'III', 'Moderato, quasi allegretto', 'III. Moderato, quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11543 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c274047-6792-434b-9722-bbf5de8d66a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro risoluto', part.name_en = 'IV. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11543 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:25c31796-5233-4662-8089-9ce8961a7618' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25c31796-5233-4662-8089-9ce8961a7618', 4, 'IV', 'Allegro risoluto', 'IV. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11543 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c31796-5233-4662-8089-9ce8961a7618'
);


-- Op. 113 축전 시 <30년>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전 시 <30년>', 'Thirty Years, Festive Poem', 'song', 'Op. 113', NULL, NULL, 1947, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전 시 <30년>'
);


-- Op. 114 칸타타 <번영하라, 강대한 땅이여>

UPDATE pieces piece
SET piece.title = '칸타타 <번영하라, 강대한 땅이여>', piece.title_en = 'Flourish, Mighty Land',
    piece.type = 'song', piece.opus_number = 'Op. 114',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1947, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11308 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1947
WHERE piece.id = 11308 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 115 무반주 바이올린 소나타 D장조

UPDATE pieces piece
SET piece.title = '무반주 바이올린 소나타 D장조', piece.title_en = 'Sonata for Solo Violin in D major',
    piece.type = 'album', piece.opus_number = 'Op. 115',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1947, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11632 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1947
WHERE piece.id = 11632 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11632 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:4aef5f9a-2307-4750-9fd1-da02ae599fb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4aef5f9a-2307-4750-9fd1-da02ae599fb8', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11632 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aef5f9a-2307-4750-9fd1-da02ae599fb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante dolce. 주제와 변주', part.name_en = 'II. Andante dolce. Tema con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11632 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:afee3c38-3ad6-4941-b4c9-b9782cb34233' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afee3c38-3ad6-4941-b4c9-b9782cb34233', 2, 'II', 'Andante dolce. 주제와 변주', 'II. Andante dolce. Tema con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11632 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afee3c38-3ad6-4941-b4c9-b9782cb34233'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Con brio. Allegro precipitato', part.name_en = 'III. Con brio. Allegro precipitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11632 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ad7d4238-f0b6-47be-98f8-505da7219d3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad7d4238-f0b6-47be-98f8-505da7219d3c', 3, 'III', 'Con brio. Allegro precipitato', 'III. Con brio. Allegro precipitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11632 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad7d4238-f0b6-47be-98f8-505da7219d3c'
);


-- Op. 116 영화 음악 <이반 뇌제>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 음악 <이반 뇌제>', 'Ivan the Terrible, film score', 'song', 'Op. 116', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 음악 <이반 뇌제>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fbc98ca-2c7c-4557-bf8f-42ac76155a9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3fbc98ca-2c7c-4557-bf8f-42ac76155a9b'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '영화 음악 <이반 뇌제>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3fbc98ca-2c7c-4557-bf8f-42ac76155a9b'
);


-- Op. 117 오페라 <참된 인간의 이야기>

UPDATE pieces piece
SET piece.title = '오페라 <참된 인간의 이야기>', piece.title_en = 'The Story of a Real Man',
    piece.type = 'song', piece.opus_number = 'Op. 117',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1948, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11487 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1948
WHERE piece.id = 11487 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 118 발레 <석화>

UPDATE pieces piece
SET piece.title = '발레 <석화>', piece.title_en = 'The Tale of the Stone Flower',
    piece.type = 'song', piece.opus_number = 'Op. 118',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1953, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11474 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1953
WHERE piece.id = 11474 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 119 첼로 소나타 C장조

UPDATE pieces piece
SET piece.title = '첼로 소나타 C장조', piece.title_en = 'Cello Sonata in C major',
    piece.type = 'album', piece.opus_number = 'Op. 119',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1949, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11501 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1949
WHERE piece.id = 11501 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante grave', part.name_en = 'I. Andante grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11501 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:1e3a9cfd-dae6-3db5-ad71-5b2af3072d1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e3a9cfd-dae6-3db5-ad71-5b2af3072d1e', 1, 'I', 'Andante grave', 'I. Andante grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11501 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e3a9cfd-dae6-3db5-ad71-5b2af3072d1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11501 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d784b088-fdd2-346f-8719-49f5f912029c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d784b088-fdd2-346f-8719-49f5f912029c', 2, 'II', 'Moderato', 'II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11501 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d784b088-fdd2-346f-8719-49f5f912029c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro, ma non troppo', part.name_en = 'III. Allegro, ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11501 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:5d1c23b2-187a-3305-85ef-c1509c85b0f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d1c23b2-187a-3305-85ef-c1509c85b0f2', 3, 'III', 'Allegro, ma non troppo', 'III. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11501 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d1c23b2-187a-3305-85ef-c1509c85b0f2'
);


-- Op. 120 푸시킨 왈츠

UPDATE pieces piece
SET piece.title = '푸시킨 왈츠', piece.title_en = 'Pushkin Waltzes, Op. 120',
    piece.type = 'album', piece.opus_number = 'Op. 120',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1949, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11745 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1949
WHERE piece.id = 11745 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '왈츠 F장조', part.name_en = 'Waltz in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11745 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:155864cb-ec93-4b8e-9acd-8e56a4f81184' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:155864cb-ec93-4b8e-9acd-8e56a4f81184', 1, NULL, '왈츠 F장조', 'Waltz in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11745 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:155864cb-ec93-4b8e-9acd-8e56a4f81184'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '왈츠 C#단조', part.name_en = 'Waltz in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11745 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:961e6777-9d2d-459a-862a-9899eba38802' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:961e6777-9d2d-459a-862a-9899eba38802', 2, NULL, '왈츠 C#단조', 'Waltz in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11745 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:961e6777-9d2d-459a-862a-9899eba38802'
);


-- Op. 121 병사의 행진가

UPDATE pieces piece
SET piece.title = '병사의 행진가', piece.title_en = 'Soldiers'' Marching Song',
    piece.type = 'song', piece.opus_number = 'Op. 121',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1950, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11647 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1950
WHERE piece.id = 11647 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 122 모음곡 <겨울 모닥불>

UPDATE pieces piece
SET piece.title = '모음곡 <겨울 모닥불>', piece.title_en = 'Winter Bonfire',
    piece.type = 'song', piece.opus_number = 'Op. 122',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1950, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11391 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1950
WHERE piece.id = 11391 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 123 교향 모음곡 <여름밤>

UPDATE pieces piece
SET piece.title = '교향 모음곡 <여름밤>', piece.title_en = 'Summer Night, Suite from Betrothal in a Monastery',
    piece.type = 'album', piece.opus_number = 'Op. 123',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1950, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11539 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1950
WHERE piece.id = 11539 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11539 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:6e05127e-61eb-45ab-a0f6-935a32e5f096' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e05127e-61eb-45ab-a0f6-935a32e5f096', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11539 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e05127e-61eb-45ab-a0f6-935a32e5f096'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '세레나데', part.name_en = 'II. Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11539 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2dd4c39b-9ee4-4f87-82ea-166f7b15dab7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dd4c39b-9ee4-4f87-82ea-166f7b15dab7', 2, 'II', '세레나데', 'II. Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11539 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dd4c39b-9ee4-4f87-82ea-166f7b15dab7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '미뉴에트', part.name_en = 'III. Minuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11539 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d088730f-36cc-482b-b2d3-e09b7db8ad37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d088730f-36cc-482b-b2d3-e09b7db8ad37', 3, 'III', '미뉴에트', 'III. Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11539 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d088730f-36cc-482b-b2d3-e09b7db8ad37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '꿈 (녹턴)', part.name_en = 'IV. Dreams (Nocturne)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11539 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:18053850-e20b-4fc7-b4c4-1c6b41f05d0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18053850-e20b-4fc7-b4c4-1c6b41f05d0e', 4, 'IV', '꿈 (녹턴)', 'IV. Dreams (Nocturne)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11539 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18053850-e20b-4fc7-b4c4-1c6b41f05d0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '춤', part.name_en = 'V. Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11539 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9f426ed9-7e6b-4c46-99c1-13a133f6e343' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f426ed9-7e6b-4c46-99c1-13a133f6e343', 5, 'V', '춤', 'V. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11539 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f426ed9-7e6b-4c46-99c1-13a133f6e343'
);


-- Op. 124 오라토리오 <평화의 수호>

UPDATE pieces piece
SET piece.title = '오라토리오 <평화의 수호>', piece.title_en = 'On Guard for Peace',
    piece.type = 'song', piece.opus_number = 'Op. 124',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1950, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11984 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1950
WHERE piece.id = 11984 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 125 첼로와 관현악을 위한 교향적 협주곡 E단조

UPDATE pieces piece
SET piece.title = '첼로와 관현악을 위한 교향적 협주곡 E단조', piece.title_en = 'Symphony-Concerto for Cello and Orchestra in E minor',
    piece.type = 'album', piece.opus_number = 'Op. 125',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1952, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11361 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1952
WHERE piece.id = 11361 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11361 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9032278b-b777-3788-9bf5-edef8744e025' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9032278b-b777-3788-9bf5-edef8744e025', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11361 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9032278b-b777-3788-9bf5-edef8744e025'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro giusto', part.name_en = 'II. Allegro giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11361 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:df8170c4-4644-3d50-aca9-30eb8c39fe45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df8170c4-4644-3d50-aca9-30eb8c39fe45', 2, 'II', 'Allegro giusto', 'II. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11361 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df8170c4-4644-3d50-aca9-30eb8c39fe45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante con moto', part.name_en = 'III. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11361 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:7e88e3f2-f191-3dcb-bae0-8cc88f4a4414' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e88e3f2-f191-3dcb-bae0-8cc88f4a4414', 3, 'III', 'Andante con moto', 'III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11361 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e88e3f2-f191-3dcb-bae0-8cc88f4a4414'
);


-- Op. 126 <석화>에서 결혼 모음곡

UPDATE pieces piece
SET piece.title = '<석화>에서 결혼 모음곡', piece.title_en = 'Wedding Suite from The Tale of the Stone Flower',
    piece.type = 'album', piece.opus_number = 'Op. 126',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1951, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11949 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1951
WHERE piece.id = 11949 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '사랑의 춤', part.name_en = 'I. Amorous Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11949 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2f4a8311-96d6-4238-a021-e031d0607bb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f4a8311-96d6-4238-a021-e031d0607bb4', 1, 'I', '사랑의 춤', 'I. Amorous Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11949 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f4a8311-96d6-4238-a021-e031d0607bb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '신부 친구들의 춤', part.name_en = 'II. Dance of the Bride''s Friends',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11949 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:dc4daaf4-5a63-4314-8463-3f3172498727' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc4daaf4-5a63-4314-8463-3f3172498727', 2, 'II', '신부 친구들의 춤', 'II. Dance of the Bride''s Friends', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11949 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc4daaf4-5a63-4314-8463-3f3172498727'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '처녀들의 춤', part.name_en = 'III. Maidens'' Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11949 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:fea1d16f-4f40-4950-8617-3c81f3367ec5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fea1d16f-4f40-4950-8617-3c81f3367ec5', 3, 'III', '처녀들의 춤', 'III. Maidens'' Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11949 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fea1d16f-4f40-4950-8617-3c81f3367ec5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '의식의 춤', part.name_en = 'IV. Ceremonial Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11949 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:27335ced-693b-4360-9f5d-d91c29c77c38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27335ced-693b-4360-9f5d-d91c29c77c38', 4, 'IV', '의식의 춤', 'IV. Ceremonial Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11949 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27335ced-693b-4360-9f5d-d91c29c77c38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '결혼 원무', part.name_en = 'V. Wedding Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11949 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c396777a-4b3d-4164-a4d1-c2adad48eba0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c396777a-4b3d-4164-a4d1-c2adad48eba0', 5, 'V', '결혼 원무', 'V. Wedding Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11949 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c396777a-4b3d-4164-a4d1-c2adad48eba0'
);


-- Op. 127 <석화>에서 집시 환상곡

UPDATE pieces piece
SET piece.title = '<석화>에서 집시 환상곡', piece.title_en = 'Gypsy Fantasy from The Tale of the Stone Flower',
    piece.type = 'album', piece.opus_number = 'Op. 127',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1951, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11669 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1951
WHERE piece.id = 11669 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11669 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:2e647f51-b894-4f05-8510-5a2aac1dc6bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e647f51-b894-4f05-8510-5a2aac1dc6bc', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11669 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e647f51-b894-4f05-8510-5a2aac1dc6bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '집시 춤', part.name_en = 'II. Gypsy Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11669 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:8bdaf746-10e6-41d8-9d2a-0aea3f08e4b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bdaf746-10e6-41d8-9d2a-0aea3f08e4b1', 2, 'II', '집시 춤', 'II. Gypsy Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11669 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bdaf746-10e6-41d8-9d2a-0aea3f08e4b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '세베리얀의 춤', part.name_en = 'III. Severyan''s Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11669 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:87784cf8-bd5a-4253-8c6f-d9c13b9a3627' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87784cf8-bd5a-4253-8c6f-d9c13b9a3627', 3, 'III', '세베리얀의 춤', 'III. Severyan''s Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11669 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87784cf8-bd5a-4253-8c6f-d9c13b9a3627'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '집시 여인의 춤', part.name_en = 'IV. Dance of the Gypsy Girl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11669 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:d15c9cf4-f304-4009-bac2-3a840fe105f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d15c9cf4-f304-4009-bac2-3a840fe105f3', 4, 'IV', '집시 여인의 춤', 'IV. Dance of the Gypsy Girl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11669 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d15c9cf4-f304-4009-bac2-3a840fe105f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '군무', part.name_en = 'V. General Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11669 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c0546ed3-b995-4fac-87da-e6483f4a82b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0546ed3-b995-4fac-87da-e6483f4a82b3', 5, 'V', '군무', 'V. General Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11669 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0546ed3-b995-4fac-87da-e6483f4a82b3'
);


-- Op. 128 <석화>에서 우랄 랩소디

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<석화>에서 우랄 랩소디', 'Ural Rhapsody from The Tale of the Stone Flower', 'song', 'Op. 128', NULL, NULL, 1951, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<석화>에서 우랄 랩소디'
);


-- Op. 130 축전 시 <볼가 강과 돈 강의 만남>

UPDATE pieces piece
SET piece.title = '축전 시 <볼가 강과 돈 강의 만남>', piece.title_en = 'The Meeting of the Volga and the Don, Festive Poem',
    piece.type = 'song', piece.opus_number = 'Op. 130',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1951, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12004 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1951
WHERE piece.id = 12004 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- Op. 131 교향곡 7번 C#단조

UPDATE pieces piece
SET piece.title = '교향곡 7번 C#단조', piece.title_en = 'Symphony No. 7 in C# minor',
    piece.type = 'album', piece.opus_number = 'Op. 131',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1952, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11692 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1952
WHERE piece.id = 11692 AND piece.composer_id = 84 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11692 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:9cd6648b-32fb-30cb-904f-ed687b7f1f28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cd6648b-32fb-30cb-904f-ed687b7f1f28', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11692 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cd6648b-32fb-30cb-904f-ed687b7f1f28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11692 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:70904967-7912-33f6-8330-7c5f7a311535' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70904967-7912-33f6-8330-7c5f7a311535', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11692 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70904967-7912-33f6-8330-7c5f7a311535'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante espressivo', part.name_en = 'III. Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11692 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:c3e6ec9b-f710-318b-9483-071862b3c37b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3e6ec9b-f710-318b-9483-071862b3c37b', 3, 'III', 'Andante espressivo', 'III. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11692 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3e6ec9b-f710-318b-9483-071862b3c37b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11692 AND p.composer_id = 84 AND part.part_key = 'musicbrainz:ae1039af-7c69-32c0-a9ee-c7fcda6691a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae1039af-7c69-32c0-a9ee-c7fcda6691a1', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11692 AND p.composer_id = 84
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae1039af-7c69-32c0-a9ee-c7fcda6691a1'
);


-- Op. 132 첼로 소협주곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 소협주곡 G단조', 'Cello Concertino in G minor', 'album', 'Op. 132', NULL, NULL, 1952, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 소협주곡 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4479d871-0cc9-4077-b432-10b252afb643'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4479d871-0cc9-4077-b432-10b252afb643'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '첼로 소협주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4479d871-0cc9-4077-b432-10b252afb643'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48d5c118-7770-4030-be3d-1d9d1c85ccfa', 1, 'I', 'Andante mosso', 'I. Andante mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '첼로 소협주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48d5c118-7770-4030-be3d-1d9d1c85ccfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b8c1924-71d7-41a8-830e-3402e8024859', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '첼로 소협주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b8c1924-71d7-41a8-830e-3402e8024859'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a85df05-fb43-338a-b7e1-840ad10c7487', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '첼로 소협주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a85df05-fb43-338a-b7e1-840ad10c7487'
);


-- Op. 135 피아노 소나타 5번 C장조 (개정판)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 5번 C장조 (개정판)', 'Piano Sonata No. 5 in C major (revised version)', 'album', 'Op. 135', NULL, NULL, 1953, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 5번 C장조 (개정판)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98db12f4-9069-4341-bd2e-c1fe01e67438'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98db12f4-9069-4341-bd2e-c1fe01e67438'
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소나타 5번 C장조 (개정판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98db12f4-9069-4341-bd2e-c1fe01e67438'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47f5ba3c-395f-46de-bab1-47d0fed44e71', 1, 'I', 'Allegro tranquillo', 'I. Allegro tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소나타 5번 C장조 (개정판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f5ba3c-395f-46de-bab1-47d0fed44e71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4249b1aa-3ec1-4262-8a96-71db450ae60d', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소나타 5번 C장조 (개정판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4249b1aa-3ec1-4262-8a96-71db450ae60d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e39a24cf-1b2b-4a5b-a2d8-d0b8af1e5366', 3, 'III', 'Un poco allegretto', 'III. Un poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 84 AND p.title = '피아노 소나타 5번 C장조 (개정판)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e39a24cf-1b2b-4a5b-a2d8-d0b8af1e5366'
);


-- None 발레 <공중그네>

UPDATE pieces piece
SET piece.title = '발레 <공중그네>', piece.title_en = 'Trapeze',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1924, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11614 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1924
WHERE piece.id = 11614 AND piece.composer_id = 84 AND piece.composition_year IS NULL;


-- None 영화 음악 <레르몬토프>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 음악 <레르몬토프>', 'Lermontov, film score', 'song', NULL, NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 음악 <레르몬토프>'
);


-- None 영화 음악 <코토프스키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 음악 <코토프스키>', 'Kotovsky, film score', 'song', NULL, NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 음악 <코토프스키>'
);


-- None 영화 음악 <우크라이나 초원의 파르티잔>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 음악 <우크라이나 초원의 파르티잔>', 'Partisans in the Ukrainian Steppes, film score', 'song', NULL, NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 음악 <우크라이나 초원의 파르티잔>'
);


-- None 영화 음악 <토냐>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 음악 <토냐>', 'Tonya, film score', 'song', NULL, NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 음악 <토냐>'
);


-- None 둠카

UPDATE pieces piece
SET piece.title = '둠카', piece.title_en = 'Dumka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11822 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 가곡 <메기 이야기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <메기 이야기>', 'About the Catfish (Broad and Deep the River Flows)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 84
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <메기 이야기>'
);


-- 단독으로 연주되는 대목은 남기고 제목만 우리말로
UPDATE pieces piece
SET piece.title = '발레 <신데렐라> 중 "가보트"', piece.title_en = 'Cinderella: Gavotte', piece.editor_locked = 1
WHERE piece.id = 11398 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE pieces piece
SET piece.title = '영화 음악 <이반 뇌제> 중 "오프리치니키의 춤"', piece.title_en = 'Ivan the Terrible: Dance of the Oprichniki', piece.editor_locked = 1
WHERE piece.id = 11817 AND piece.composer_id = 84
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 94개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 84 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    576, 11317, 11327, 11336, 11362, 11365, 11387, 11401, 11406, 11407, 11409, 11410, 11421, 11434, 11445, 11453, 11456, 11457, 11460, 11476,
    11477, 11490, 11498, 11519, 11520, 11521, 11540, 11545, 11574, 11578, 11584, 11586, 11588, 11603, 11613, 11617, 11620, 11631, 11642, 11643,
    11644, 11655, 11657, 11663, 11665, 11668, 11675, 11676, 11681, 11685, 11695, 11696, 11698, 11709, 11717, 11724, 11740, 11743, 11751, 11753,
    11765, 11774, 11789, 11799, 11800, 11802, 11814, 11827, 11834, 11839, 11842, 11860, 11870, 11873, 11887, 11891, 11892, 11897, 11900, 11901,
    11903, 11907, 11912, 11923, 11932, 11937, 11943, 11960, 11966, 11985, 11987, 11999, 12005, 12008
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
