-- 브람스 작품을 출판 단위로 다시 짠다(카탈로그: Op.·WoO·Anh.). 작품 168개(묶음 79, 다악장 40, 낱곡 49),
-- 새 작품 27개, 기존 작품 141개(seed 제목 고침 151개), part 640개, 그 아래 15개,
-- 기존 part 고쳐 씀 0개, 기존 작품 연결 18개. 카탈로그에 대응이 없는 seed 114개는 목록에서 숨긴다.
--
-- 정한 것
--   민요 편곡(WoO 31–38)은 뺀다. 헝가리 무곡은 피아노 연탄 원판 21곡 묶음 하나, 브람스 자신의 관현악·독주판은 따로 두지 않는다.
--   155 「헝가리 무곡 5번」은 WoO 1 의 5번 part, 451 「자장가」는 Op. 49 의 4번 part 로 잇는다.
--   seed 제목은 원곡인데 MBID 가 남의 편곡판인 Op. 25·36·11 seed 는 숨기고 원곡을 새로 넣는다.
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

-- Op. 68 교향곡 1번 C단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Un poco sostenuto – Allegro', part.name_en = 'I. Un poco sostenuto – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 153 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:64f46c8f-49c0-3de1-a356-a0ac765e17ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64f46c8f-49c0-3de1-a356-a0ac765e17ae', 1, 'I', 'Un poco sostenuto – Allegro', 'I. Un poco sostenuto – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 153 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64f46c8f-49c0-3de1-a356-a0ac765e17ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 153 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d7ffdec4-5ac8-3ddc-8d17-372e2027edbe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7ffdec4-5ac8-3ddc-8d17-372e2027edbe', 2, 'II', 'Andante sostenuto', 'II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 153 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7ffdec4-5ac8-3ddc-8d17-372e2027edbe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Un poco allegretto e grazioso', part.name_en = 'III. Un poco allegretto e grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 153 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:acec8360-72d9-3458-a1cc-c55d1015741d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acec8360-72d9-3458-a1cc-c55d1015741d', 3, 'III', 'Un poco allegretto e grazioso', 'III. Un poco allegretto e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 153 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acec8360-72d9-3458-a1cc-c55d1015741d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio – Allegro non troppo, ma con brio', part.name_en = 'IV. Adagio – Allegro non troppo, ma con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 153 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1e790155-299c-3bd4-ae2e-8490f4845c13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e790155-299c-3bd4-ae2e-8490f4845c13', 4, 'IV', 'Adagio – Allegro non troppo, ma con brio', 'IV. Adagio – Allegro non troppo, ma con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 153 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e790155-299c-3bd4-ae2e-8490f4845c13'
);


-- Op. 73 교향곡 2번 D장조

UPDATE pieces piece
SET piece.title = '교향곡 2번 D장조', piece.title_en = 'Symphony No. 2 in D major',
    piece.type = 'album', piece.opus_number = 'Op. 73',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11356 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 11356 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11356 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9675b8d9-84cf-3db1-bbcd-3963ed685646' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9675b8d9-84cf-3db1-bbcd-3963ed685646', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11356 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9675b8d9-84cf-3db1-bbcd-3963ed685646'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio non troppo', part.name_en = 'II. Adagio non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11356 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:015fc341-524e-36ba-b740-b1a6ed7959fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:015fc341-524e-36ba-b740-b1a6ed7959fe', 2, 'II', 'Adagio non troppo', 'II. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11356 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:015fc341-524e-36ba-b740-b1a6ed7959fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto grazioso (quasi andantino)', part.name_en = 'III. Allegretto grazioso (quasi andantino)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11356 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:49abad3a-3c1a-3c14-af68-f6c770869359' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49abad3a-3c1a-3c14-af68-f6c770869359', 3, 'III', 'Allegretto grazioso (quasi andantino)', 'III. Allegretto grazioso (quasi andantino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11356 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49abad3a-3c1a-3c14-af68-f6c770869359'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con spirito', part.name_en = 'IV. Allegro con spirito',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11356 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7dd1b9bd-4ef5-3e62-8884-3f3dea4b7e87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dd1b9bd-4ef5-3e62-8884-3f3dea4b7e87', 4, 'IV', 'Allegro con spirito', 'IV. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11356 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dd1b9bd-4ef5-3e62-8884-3f3dea4b7e87'
);


-- Op. 90 교향곡 3번 F장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 154 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:529cf62c-d23b-3d3f-93dc-0cf64c4a16d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:529cf62c-d23b-3d3f-93dc-0cf64c4a16d4', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 154 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:529cf62c-d23b-3d3f-93dc-0cf64c4a16d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 154 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b4134883-3d4d-3fcb-9b19-c31ee2ec871a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4134883-3d4d-3fcb-9b19-c31ee2ec871a', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 154 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4134883-3d4d-3fcb-9b19-c31ee2ec871a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Poco allegretto', part.name_en = 'III. Poco allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 154 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6da4b2b3-c020-31a7-9b37-fa6a62168d5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6da4b2b3-c020-31a7-9b37-fa6a62168d5a', 3, 'III', 'Poco allegretto', 'III. Poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 154 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6da4b2b3-c020-31a7-9b37-fa6a62168d5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 154 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3208da9f-f65f-3793-adbf-5ad331acde67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3208da9f-f65f-3793-adbf-5ad331acde67', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 154 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3208da9f-f65f-3793-adbf-5ad331acde67'
);


-- Op. 98 교향곡 4번 E단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 452 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:77fdd88d-ceab-33e4-9001-8e292259195c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77fdd88d-ceab-33e4-9001-8e292259195c', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 452 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77fdd88d-ceab-33e4-9001-8e292259195c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante moderato', part.name_en = 'II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 452 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:628c551a-bfbb-3c88-9dd3-ef75d1f385e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:628c551a-bfbb-3c88-9dd3-ef75d1f385e1', 2, 'II', 'Andante moderato', 'II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 452 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:628c551a-bfbb-3c88-9dd3-ef75d1f385e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro giocoso', part.name_en = 'III. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 452 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6b6169ed-00de-3874-8c64-c507bdea2cac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b6169ed-00de-3874-8c64-c507bdea2cac', 3, 'III', 'Allegro giocoso', 'III. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 452 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b6169ed-00de-3874-8c64-c507bdea2cac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro energico e passionato', part.name_en = 'IV. Allegro energico e passionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 452 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:720f2397-27fe-3c3e-9b91-bca6c2693e8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:720f2397-27fe-3c3e-9b91-bca6c2693e8e', 4, 'IV', 'Allegro energico e passionato', 'IV. Allegro energico e passionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 452 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:720f2397-27fe-3c3e-9b91-bca6c2693e8e'
);


-- Op. 11 세레나데 1번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데 1번 D장조', 'Serenade No. 1 in D major', 'album', 'Op. 11', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데 1번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1799b74-831a-4668-94b5-73e31d36367c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1799b74-831a-4668-94b5-73e31d36367c'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1799b74-831a-4668-94b5-73e31d36367c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9c52726-9047-32f5-9396-2a74396d642d', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9c52726-9047-32f5-9396-2a74396d642d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:622cb7b1-a021-3e64-9fb5-1bb8887a47aa', 2, 'II', '스케르초. Allegro non troppo – 트리오. Poco più moto', 'II. Scherzo. Allegro non troppo – Trio. Poco più moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:622cb7b1-a021-3e64-9fb5-1bb8887a47aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70787cf4-0a7b-3ed8-ae6a-9c76e48501ad', 3, 'III', 'Adagio non troppo', 'III. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70787cf4-0a7b-3ed8-ae6a-9c76e48501ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b74826a5-fe51-3e6a-9d6e-a711f8c028d5', 4, 'IV', '미뉴에트 I – 미뉴에트 II', 'IV. Menuetto I – Menuetto II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b74826a5-fe51-3e6a-9d6e-a711f8c028d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c5c1109-80b1-3025-bc4e-7d08d2747ce8', 5, 'V', '스케르초. Allegro', 'V. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c5c1109-80b1-3025-bc4e-7d08d2747ce8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adfd0db1-8cd5-37aa-9f83-19f6140ed5b0', 6, 'VI', '론도. Allegro', 'VI. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adfd0db1-8cd5-37aa-9f83-19f6140ed5b0'
);


-- Op. 16 세레나데 2번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데 2번 A장조', 'Serenade No. 2 in A major', 'album', 'Op. 16', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데 2번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b454ad9-2304-499d-b725-0e48efbf46c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b454ad9-2304-499d-b725-0e48efbf46c9'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b454ad9-2304-499d-b725-0e48efbf46c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a621394e-422e-380e-b1d0-21fb23614861', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a621394e-422e-380e-b1d0-21fb23614861'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:787b0679-984e-3df5-bb49-5f992ef8e6d2', 2, 'II', '스케르초. Vivace – 트리오', 'II. Scherzo. Vivace – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:787b0679-984e-3df5-bb49-5f992ef8e6d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:943361ad-2940-36d0-825d-f8906e97256d', 3, 'III', 'Adagio non troppo', 'III. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:943361ad-2940-36d0-825d-f8906e97256d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e765757c-3bbf-3140-a28e-08b57a91a589', 4, 'IV', 'Quasi menuetto – 트리오', 'IV. Quasi Menuetto – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e765757c-3bbf-3140-a28e-08b57a91a589'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4108edb-4e1b-3c30-9259-efe070d6bf05', 5, 'V', '론도. Allegro', 'V. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '세레나데 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4108edb-4e1b-3c30-9259-efe070d6bf05'
);


-- Op. 80 대학 축전 서곡

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '80'
WHERE piece.id = 491 AND piece.composer_id = 33
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 491 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 81 비극적 서곡

UPDATE pieces piece
SET piece.title = '비극적 서곡', piece.title_en = 'Tragic Overture',
    piece.type = 'song', piece.opus_number = 'Op. 81',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 619 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 619 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 56a 하이든 주제에 의한 변주곡

UPDATE pieces piece
SET piece.title = '하이든 주제에 의한 변주곡', piece.title_en = 'Variations on a Theme by Haydn',
    piece.type = 'song', piece.opus_number = 'Op. 56a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 645 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 645 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 1 헝가리 무곡 WoO 1

UPDATE pieces piece
SET piece.title = '헝가리 무곡 WoO 1', piece.title_en = '21 Hungarian Dances, WoO 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'WoO', piece.catalogue_number = '1',
    piece.composition_year = COALESCE(1879, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11355 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1879
WHERE piece.id = 11355 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = 'No. 1 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3b9b3faf-536a-4145-affe-04ce4d30389f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b9b3faf-536a-4145-affe-04ce4d30389f', 1, NULL, 'G단조', 'No. 1 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b9b3faf-536a-4145-affe-04ce4d30389f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 2 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4a626731-12c0-4db3-b158-3e21bbdfd701' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a626731-12c0-4db3-b158-3e21bbdfd701', 2, NULL, 'D단조', 'No. 2 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a626731-12c0-4db3-b158-3e21bbdfd701'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = 'No. 3 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a5cde12c-b884-41fe-b95d-48feeb4f7499' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5cde12c-b884-41fe-b95d-48feeb4f7499', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5cde12c-b884-41fe-b95d-48feeb4f7499'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'F단조', part.name_en = 'No. 4 in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2c6ae213-b81e-4f96-9a47-d029b82f9f72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c6ae213-b81e-4f96-9a47-d029b82f9f72', 4, NULL, 'F단조', 'No. 4 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c6ae213-b81e-4f96-9a47-d029b82f9f72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 155 AND linked.composer_id = 33),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'F#단조', part.name_en = 'No. 5 in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b62d098c-7dca-4ca8-b919-34431df961e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 155 AND linked.composer_id = 33), 'musicbrainz:b62d098c-7dca-4ca8-b919-34431df961e7', 5, NULL, 'F#단조', 'No. 5 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b62d098c-7dca-4ca8-b919-34431df961e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'D♭장조', part.name_en = 'No. 6 in D♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:647fe212-1462-42b2-a2ff-557c1cdc93c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:647fe212-1462-42b2-a2ff-557c1cdc93c9', 6, NULL, 'D♭장조', 'No. 6 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:647fe212-1462-42b2-a2ff-557c1cdc93c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'No. 7 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:95484f31-3156-488a-b07a-4ffb545a39a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95484f31-3156-488a-b07a-4ffb545a39a0', 7, NULL, 'A장조', 'No. 7 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95484f31-3156-488a-b07a-4ffb545a39a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 8 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7bd0932a-7a83-4f8c-9918-279d70c49f89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bd0932a-7a83-4f8c-9918-279d70c49f89', 8, NULL, 'A단조', 'No. 8 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bd0932a-7a83-4f8c-9918-279d70c49f89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'No. 9 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1ffb3f10-d63c-4f41-a04a-92ce18c70686' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ffb3f10-d63c-4f41-a04a-92ce18c70686', 9, NULL, 'E단조', 'No. 9 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ffb3f10-d63c-4f41-a04a-92ce18c70686'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = 'No. 10 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4c595d57-e220-44e3-9177-b86d94a0c04e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c595d57-e220-44e3-9177-b86d94a0c04e', 10, NULL, 'E장조', 'No. 10 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c595d57-e220-44e3-9177-b86d94a0c04e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 11 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b61566bb-1c32-4bb2-98be-71f73dc3bd3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b61566bb-1c32-4bb2-98be-71f73dc3bd3c', 11, NULL, 'D단조', 'No. 11 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61566bb-1c32-4bb2-98be-71f73dc3bd3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 12 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6877e69c-05d5-4f8d-911c-6f2342f6084f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6877e69c-05d5-4f8d-911c-6f2342f6084f', 12, NULL, 'D단조', 'No. 12 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6877e69c-05d5-4f8d-911c-6f2342f6084f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = 'No. 13 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2ca512f7-c4bd-467b-a48b-60994df01bf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ca512f7-c4bd-467b-a48b-60994df01bf0', 13, NULL, 'D장조', 'No. 13 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ca512f7-c4bd-467b-a48b-60994df01bf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 14 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5891add2-152d-479e-9e46-52486b75b4d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5891add2-152d-479e-9e46-52486b75b4d4', 14, NULL, 'D단조', 'No. 14 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5891add2-152d-479e-9e46-52486b75b4d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'B♭장조', part.name_en = 'No. 15 in B♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a11763aa-af0c-4c72-8d68-c8ffae258515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a11763aa-af0c-4c72-8d68-c8ffae258515', 15, NULL, 'B♭장조', 'No. 15 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a11763aa-af0c-4c72-8d68-c8ffae258515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'F단조', part.name_en = 'No. 16 in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3a147f2a-2322-49ce-969a-4e72a2e55019' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a147f2a-2322-49ce-969a-4e72a2e55019', 16, NULL, 'F단조', 'No. 16 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a147f2a-2322-49ce-969a-4e72a2e55019'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'F#단조', part.name_en = 'No. 17 in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:88da63f6-7972-4c25-bf5a-f3bc6aeb9914' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88da63f6-7972-4c25-bf5a-f3bc6aeb9914', 17, NULL, 'F#단조', 'No. 17 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88da63f6-7972-4c25-bf5a-f3bc6aeb9914'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = 'No. 18 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c09e8de5-898a-4324-87a7-3f083c3038b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c09e8de5-898a-4324-87a7-3f083c3038b0', 18, NULL, 'D장조', 'No. 18 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c09e8de5-898a-4324-87a7-3f083c3038b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = 'No. 19 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:28b8a86c-0003-4f5d-b36d-fe8b716f76f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28b8a86c-0003-4f5d-b36d-fe8b716f76f2', 19, NULL, 'B단조', 'No. 19 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28b8a86c-0003-4f5d-b36d-fe8b716f76f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'No. 20 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:32371a4a-ac2d-411e-95d4-f252d433a52b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32371a4a-ac2d-411e-95d4-f252d433a52b', 20, NULL, 'E단조', 'No. 20 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32371a4a-ac2d-411e-95d4-f252d433a52b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'No. 21 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11355 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b9a79be7-c8e5-4730-889a-d80fcd45a69d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9a79be7-c8e5-4730-889a-d80fcd45a69d', 21, NULL, 'E단조', 'No. 21 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11355 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9a79be7-c8e5-4730-889a-d80fcd45a69d'
);


-- Op. 15 피아노 협주곡 1번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 1번 D단조', 'Piano Concerto No. 1 in D minor', 'album', 'Op. 15', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 1번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b078677e-f408-4c95-9d48-62cbb3f6f6e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b078677e-f408-4c95-9d48-62cbb3f6f6e1'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b078677e-f408-4c95-9d48-62cbb3f6f6e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc3f2e7d-e90e-3897-bc3f-43726b5fcf35', 1, 'I', 'Maestoso', 'I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc3f2e7d-e90e-3897-bc3f-43726b5fcf35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74be1e9c-d879-3cc3-8d3b-a8a0436ebbc8', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74be1e9c-d879-3cc3-8d3b-a8a0436ebbc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44e246ce-3b61-30db-982c-b4f16d749ed6', 3, 'III', '론도. Allegro non troppo', 'III. Rondo. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44e246ce-3b61-30db-982c-b4f16d749ed6'
);


-- Op. 83 피아노 협주곡 2번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번 B♭장조', 'Piano Concerto No. 2 in B♭ major', 'album', 'Op. 83', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11c6eebb-8ac5-4e59-af48-fb6207fff3ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11c6eebb-8ac5-4e59-af48-fb6207fff3ce'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11c6eebb-8ac5-4e59-af48-fb6207fff3ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13b79d82-74c4-3985-9327-3aad33ff4655', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13b79d82-74c4-3985-9327-3aad33ff4655'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11671 AND linked.composer_id = 33), 'musicbrainz:139d7fe3-8860-3038-ae02-495c9e89dd70', 2, 'II', 'Allegro appassionato', 'II. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139d7fe3-8860-3038-ae02-495c9e89dd70'
);

UPDATE pieces piece
SET piece.title = '피아노 협주곡 2번 B♭장조 중 "Allegro appassionato"', piece.title_en = 'Piano Concerto No. 2 in B♭ major: II. Allegro appassionato', piece.editor_locked = 1
WHERE piece.id = 11671 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4bcbb11-a9f1-35ca-9253-e31a2c52b549', 3, 'III', 'Andante – Più adagio', 'III. Andante – Più adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4bcbb11-a9f1-35ca-9253-e31a2c52b549'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:074c6665-5721-3084-b586-69f8bf854ee9', 4, 'IV', 'Allegretto grazioso', 'IV. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:074c6665-5721-3084-b586-69f8bf854ee9'
);


-- Op. 77 바이올린 협주곡 D장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 156 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:63348c90-54ee-328a-88f1-edc3b9d4bf55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63348c90-54ee-328a-88f1-edc3b9d4bf55', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 156 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63348c90-54ee-328a-88f1-edc3b9d4bf55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 156 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3534470d-cd9c-381d-b718-3be79b61e3b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3534470d-cd9c-381d-b718-3be79b61e3b7', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 156 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3534470d-cd9c-381d-b718-3be79b61e3b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro giocoso, ma non troppo vivace', part.name_en = 'III. Allegro giocoso, ma non troppo vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 156 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:75b253de-77d4-3f70-8a98-7cb4f78ca971' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75b253de-77d4-3f70-8a98-7cb4f78ca971', 3, 'III', 'Allegro giocoso, ma non troppo vivace', 'III. Allegro giocoso, ma non troppo vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 156 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75b253de-77d4-3f70-8a98-7cb4f78ca971'
);


-- Op. 102 바이올린과 첼로를 위한 2중 협주곡 A단조

UPDATE pieces piece
SET piece.title = '바이올린과 첼로를 위한 2중 협주곡 A단조', piece.title_en = 'Double Concerto in A minor',
    piece.type = 'album', piece.opus_number = 'Op. 102',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11509 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 11509 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11509 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9e0e56f8-0d69-33a3-88d7-1770d6a591d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e0e56f8-0d69-33a3-88d7-1770d6a591d2', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11509 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e0e56f8-0d69-33a3-88d7-1770d6a591d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11509 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:45c153b0-bfd8-36c2-bd98-df201f72cb1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45c153b0-bfd8-36c2-bd98-df201f72cb1c', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11509 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45c153b0-bfd8-36c2-bd98-df201f72cb1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Vivace non troppo', part.name_en = 'III. Vivace non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11509 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:469a07c9-81a1-3721-b97e-9de358786ef4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:469a07c9-81a1-3721-b97e-9de358786ef4', 3, 'III', 'Vivace non troppo', 'III. Vivace non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11509 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:469a07c9-81a1-3721-b97e-9de358786ef4'
);


-- WoO 2 바이올린과 피아노를 위한 스케르초 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 스케르초 C단조', 'Scherzo in C minor (F-A-E Sonata)', 'song', 'WoO 2', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 스케르초 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93dff993-e3fe-3d68-8418-3a4a706dd129'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93dff993-e3fe-3d68-8418-3a4a706dd129'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '바이올린과 피아노를 위한 스케르초 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93dff993-e3fe-3d68-8418-3a4a706dd129'
);


-- Op. 78 바이올린 소나타 1번 G장조 "비의 노래"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 1번 G장조 "비의 노래"', 'Violin Sonata No. 1 in G major "Rain Sonata"', 'album', 'Op. 78', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 1번 G장조 "비의 노래"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '792f5001-53a2-49e8-a685-3e0893e6b123'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '792f5001-53a2-49e8-a685-3e0893e6b123'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '바이올린 소나타 1번 G장조 "비의 노래"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '792f5001-53a2-49e8-a685-3e0893e6b123'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11426 AND linked.composer_id = 33), 'musicbrainz:05151678-96f0-3345-b736-394db9844d24', 1, 'I', 'Vivace ma non troppo', 'I. Vivace ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '바이올린 소나타 1번 G장조 "비의 노래"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05151678-96f0-3345-b736-394db9844d24'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 1번 G장조 "비의 노래" 중 "Vivace ma non troppo"', piece.title_en = 'Violin Sonata No. 1 in G major "Rain Sonata": I. Vivace ma non troppo', piece.editor_locked = 1
WHERE piece.id = 11426 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11864 AND linked.composer_id = 33), 'musicbrainz:ebd9862e-0de5-37f7-b108-68db97b45382', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '바이올린 소나타 1번 G장조 "비의 노래"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebd9862e-0de5-37f7-b108-68db97b45382'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 1번 G장조 "비의 노래" 중 "Adagio"', piece.title_en = 'Violin Sonata No. 1 in G major "Rain Sonata": II. Adagio', piece.editor_locked = 1
WHERE piece.id = 11864 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11708 AND linked.composer_id = 33), 'musicbrainz:32df9698-25a1-333f-b0b4-c0b028e64d66', 3, 'III', 'Allegro molto moderato', 'III. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '바이올린 소나타 1번 G장조 "비의 노래"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32df9698-25a1-333f-b0b4-c0b028e64d66'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 1번 G장조 "비의 노래" 중 "Allegro molto moderato"', piece.title_en = 'Violin Sonata No. 1 in G major "Rain Sonata": III. Allegro molto moderato', piece.editor_locked = 1
WHERE piece.id = 11708 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 100 바이올린 소나타 2번 A장조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 A장조', piece.title_en = 'Violin Sonata No. 2 in A major',
    piece.type = 'album', piece.opus_number = 'Op. 100',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11597 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 11597 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11993 AND linked.composer_id = 33),
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro amabile', part.name_en = 'I. Allegro amabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11597 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c8cb982f-71d2-39b5-b54a-92fea718bbf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11993 AND linked.composer_id = 33), 'musicbrainz:c8cb982f-71d2-39b5-b54a-92fea718bbf8', 1, 'I', 'Allegro amabile', 'I. Allegro amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11597 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8cb982f-71d2-39b5-b54a-92fea718bbf8'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 A장조 중 "Allegro amabile"', piece.title_en = 'Violin Sonata No. 2 in A major: I. Allegro amabile', piece.editor_locked = 1
WHERE piece.id = 11993 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11516 AND linked.composer_id = 33),
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante tranquillo – Vivace – Andante – Vivace di più – Andante – Vivace', part.name_en = 'II. Andante tranquillo – Vivace – Andante – Vivace di più – Andante – Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11597 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:08d3a2ce-c738-3744-968a-2d94c88c700f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11516 AND linked.composer_id = 33), 'musicbrainz:08d3a2ce-c738-3744-968a-2d94c88c700f', 2, 'II', 'Andante tranquillo – Vivace – Andante – Vivace di più – Andante – Vivace', 'II. Andante tranquillo – Vivace – Andante – Vivace di più – Andante – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11597 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08d3a2ce-c738-3744-968a-2d94c88c700f'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 A장조 중 "Andante tranquillo – Vivace – Andante – Vivace di più – Andante – Vivace"', piece.title_en = 'Violin Sonata No. 2 in A major: II. Andante tranquillo – Vivace – Andante – Vivace di più – Andante – Vivace', piece.editor_locked = 1
WHERE piece.id = 11516 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11623 AND linked.composer_id = 33),
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto grazioso (quasi andante)', part.name_en = 'III. Allegretto grazioso (quasi andante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11597 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2074b69b-e8fd-37b4-84f0-a226feb28892' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11623 AND linked.composer_id = 33), 'musicbrainz:2074b69b-e8fd-37b4-84f0-a226feb28892', 3, 'III', 'Allegretto grazioso (quasi andante)', 'III. Allegretto grazioso (quasi andante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11597 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2074b69b-e8fd-37b4-84f0-a226feb28892'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 A장조 중 "Allegretto grazioso (quasi andante)"', piece.title_en = 'Violin Sonata No. 2 in A major: III. Allegretto grazioso (quasi andante)', piece.editor_locked = 1
WHERE piece.id = 11623 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 108 바이올린 소나타 3번 D단조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 3번 D단조', piece.title_en = 'Violin Sonata No. 3 in D minor',
    piece.type = 'album', piece.opus_number = 'Op. 108',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11311 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 11311 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11403 AND linked.composer_id = 33),
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11311 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:94aa3e3b-59ec-3c65-b3ff-6bdc9a7e43c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11403 AND linked.composer_id = 33), 'musicbrainz:94aa3e3b-59ec-3c65-b3ff-6bdc9a7e43c2', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11311 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94aa3e3b-59ec-3c65-b3ff-6bdc9a7e43c2'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 3번 D단조 중 "Allegro"', piece.title_en = 'Violin Sonata No. 3 in D minor: I. Allegro', piece.editor_locked = 1
WHERE piece.id = 11403 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11716 AND linked.composer_id = 33),
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11311 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:904fb33c-68ee-35c8-9517-c4d5a9eaee5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11716 AND linked.composer_id = 33), 'musicbrainz:904fb33c-68ee-35c8-9517-c4d5a9eaee5a', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11311 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:904fb33c-68ee-35c8-9517-c4d5a9eaee5a'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 3번 D단조 중 "Adagio"', piece.title_en = 'Violin Sonata No. 3 in D minor: II. Adagio', piece.editor_locked = 1
WHERE piece.id = 11716 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11427 AND linked.composer_id = 33),
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Un poco presto e con sentimento', part.name_en = 'III. Un poco presto e con sentimento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11311 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2a7afb19-e393-30f6-bb4e-866eed087c1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11427 AND linked.composer_id = 33), 'musicbrainz:2a7afb19-e393-30f6-bb4e-866eed087c1c', 3, 'III', 'Un poco presto e con sentimento', 'III. Un poco presto e con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11311 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a7afb19-e393-30f6-bb4e-866eed087c1c'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 3번 D단조 중 "Un poco presto e con sentimento"', piece.title_en = 'Violin Sonata No. 3 in D minor: III. Un poco presto e con sentimento', piece.editor_locked = 1
WHERE piece.id = 11427 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11400 AND linked.composer_id = 33),
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Presto agitato', part.name_en = 'IV. Presto agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11311 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8eb0a370-59e1-3c43-bf86-3bdaaafc73ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11400 AND linked.composer_id = 33), 'musicbrainz:8eb0a370-59e1-3c43-bf86-3bdaaafc73ec', 4, 'IV', 'Presto agitato', 'IV. Presto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11311 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eb0a370-59e1-3c43-bf86-3bdaaafc73ec'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 3번 D단조 중 "Presto agitato"', piece.title_en = 'Violin Sonata No. 3 in D minor: IV. Presto agitato', piece.editor_locked = 1
WHERE piece.id = 11400 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 38 첼로 소나타 1번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 소나타 1번 E단조', 'Cello Sonata No. 1 in E minor', 'album', 'Op. 38', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 소나타 1번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f696a09-f813-4105-ada9-af2ae8818b43'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f696a09-f813-4105-ada9-af2ae8818b43'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '첼로 소나타 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f696a09-f813-4105-ada9-af2ae8818b43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd5a7ba4-f365-3ecc-9d0e-eb289cebc92f', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '첼로 소나타 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd5a7ba4-f365-3ecc-9d0e-eb289cebc92f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8920600b-65e6-3f92-8807-c04595276ee4', 2, 'II', 'Allegretto quasi menuetto', 'II. Allegretto quasi menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '첼로 소나타 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8920600b-65e6-3f92-8807-c04595276ee4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:849386f7-f806-3076-8ee8-5b4e8a796ace', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '첼로 소나타 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:849386f7-f806-3076-8ee8-5b4e8a796ace'
);


-- Op. 99 첼로 소나타 2번 F장조

UPDATE pieces piece
SET piece.title = '첼로 소나타 2번 F장조', piece.title_en = 'Cello Sonata No. 2 in F major',
    piece.type = 'album', piece.opus_number = 'Op. 99',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11350 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 11350 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11350 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f5b8d3b5-8c6b-3c87-b0c0-0d6efd78fcc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5b8d3b5-8c6b-3c87-b0c0-0d6efd78fcc3', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11350 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5b8d3b5-8c6b-3c87-b0c0-0d6efd78fcc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio affettuoso', part.name_en = 'II. Adagio affettuoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11350 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:75f319ca-6ec4-3742-8202-7f5583fe0eea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75f319ca-6ec4-3742-8202-7f5583fe0eea', 2, 'II', 'Adagio affettuoso', 'II. Adagio affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11350 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75f319ca-6ec4-3742-8202-7f5583fe0eea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11840 AND linked.composer_id = 33),
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro passionato', part.name_en = 'III. Allegro passionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11350 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:22a52b91-4e60-3886-9fac-1cd2607c6f38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11840 AND linked.composer_id = 33), 'musicbrainz:22a52b91-4e60-3886-9fac-1cd2607c6f38', 3, 'III', 'Allegro passionato', 'III. Allegro passionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11350 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22a52b91-4e60-3886-9fac-1cd2607c6f38'
);

UPDATE pieces piece
SET piece.title = '첼로 소나타 2번 F장조 중 "Allegro passionato"', piece.title_en = 'Cello Sonata No. 2 in F major: III. Allegro passionato', piece.editor_locked = 1
WHERE piece.id = 11840 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto', part.name_en = 'IV. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11350 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e6a77e3f-cf3f-3cd4-803c-3fb86bb03c37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6a77e3f-cf3f-3cd4-803c-3fb86bb03c37', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11350 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6a77e3f-cf3f-3cd4-803c-3fb86bb03c37'
);


-- Op. 120 클라리넷 소나타 Op. 120

UPDATE pieces piece
SET piece.title = '클라리넷 소나타 Op. 120', piece.title_en = '2 Clarinet Sonatas, Op. 120',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '120',
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11935 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 11935 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '클라리넷 소나타 1번 F단조', part.name_en = 'No. 1 in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1', 1, NULL, '클라리넷 소나타 1번 F단조', 'No. 1 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro appassionato', part.name_en = 'I. Allegro appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:939c45eb-b6ce-393f-b3fe-d44544991cf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:939c45eb-b6ce-393f-b3fe-d44544991cf1', 1, 'I', 'Allegro appassionato', 'I. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:939c45eb-b6ce-393f-b3fe-d44544991cf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante un poco adagio', part.name_en = 'II. Andante un poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:02c7f3ec-ba23-3634-8b76-424f4645c2f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02c7f3ec-ba23-3634-8b76-424f4645c2f0', 2, 'II', 'Andante un poco adagio', 'II. Andante un poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02c7f3ec-ba23-3634-8b76-424f4645c2f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto grazioso', part.name_en = 'III. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8b6f00d2-c19b-3249-aae0-d3233ef02df3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b6f00d2-c19b-3249-aae0-d3233ef02df3', 3, 'III', 'Allegretto grazioso', 'III. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b6f00d2-c19b-3249-aae0-d3233ef02df3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace', part.name_en = 'IV. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c4b60fb8-1449-3c96-9eff-c02498afebf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4b60fb8-1449-3c96-9eff-c02498afebf3', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:46eb5c48-8f71-4b6d-9bed-becf4699dea1'
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4b60fb8-1449-3c96-9eff-c02498afebf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '클라리넷 소나타 2번 E♭장조', part.name_en = 'No. 2 in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b', 2, NULL, '클라리넷 소나타 2번 E♭장조', 'No. 2 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro amabile', part.name_en = 'I. Allegro amabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c008a525-1a63-3a44-9f20-37bcf0deceb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c008a525-1a63-3a44-9f20-37bcf0deceb4', 1, 'I', 'Allegro amabile', 'I. Allegro amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b'
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c008a525-1a63-3a44-9f20-37bcf0deceb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro appassionato', part.name_en = 'II. Allegro appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:34cf386d-9ab0-3cfd-8974-74e769acc0db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:34cf386d-9ab0-3cfd-8974-74e769acc0db', 2, 'II', 'Allegro appassionato', 'II. Allegro appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b'
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34cf386d-9ab0-3cfd-8974-74e769acc0db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante con moto – Allegro', part.name_en = 'III. Andante con moto – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11935 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:00d67417-e9c4-34e0-9728-6f1a6ca59a44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00d67417-e9c4-34e0-9728-6f1a6ca59a44', 3, 'III', 'Andante con moto – Allegro', 'III. Andante con moto – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e198ff71-a517-43be-b79f-1f9370be296b'
WHERE p.id = 11935 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00d67417-e9c4-34e0-9728-6f1a6ca59a44'
);


-- Op. 8 피아노 3중주 1번 B장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 1번 B장조', 'Piano Trio No. 1 in B major', 'album', 'Op. 8', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 1번 B장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae490d6c-8db2-4045-b556-654af7198791'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae490d6c-8db2-4045-b556-654af7198791'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 3중주 1번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae490d6c-8db2-4045-b556-654af7198791'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2ed7d7a-9494-4363-b4ad-4f64f8e34323', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 3중주 1번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2ed7d7a-9494-4363-b4ad-4f64f8e34323'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a185bd2-5fd9-4d8a-9776-11abf1e588fc', 2, 'II', '스케르초. Allegro molto', 'II. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 3중주 1번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a185bd2-5fd9-4d8a-9776-11abf1e588fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e80840d-67d6-4ab2-b00d-e93b9e6ee94b', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 3중주 1번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e80840d-67d6-4ab2-b00d-e93b9e6ee94b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:469c583a-7617-4724-9189-197d09df30e7', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 3중주 1번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:469c583a-7617-4724-9189-197d09df30e7'
);


-- Op. 87 피아노 3중주 2번 C장조

UPDATE pieces piece
SET piece.title = '피아노 3중주 2번 C장조', piece.title_en = 'Piano Trio No. 2 in C major',
    piece.type = 'album', piece.opus_number = 'Op. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11424 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 11424 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro – Animato', part.name_en = 'I. Allegro – Animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11424 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:10d3e5fc-8fab-3442-b2f0-a3e87180c494' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10d3e5fc-8fab-3442-b2f0-a3e87180c494', 1, 'I', 'Allegro – Animato', 'I. Allegro – Animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11424 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10d3e5fc-8fab-3442-b2f0-a3e87180c494'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con moto', part.name_en = 'II. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11424 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b8e1421e-4847-3b99-80fa-58dfd8d2ad5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8e1421e-4847-3b99-80fa-58dfd8d2ad5e', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11424 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8e1421e-4847-3b99-80fa-58dfd8d2ad5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Presto – Poco meno presto', part.name_en = 'III. Scherzo. Presto – Poco meno presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11424 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a3f9490d-1c5d-3409-a8ee-69764563ae2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3f9490d-1c5d-3409-a8ee-69764563ae2b', 3, 'III', '스케르초. Presto – Poco meno presto', 'III. Scherzo. Presto – Poco meno presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11424 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3f9490d-1c5d-3409-a8ee-69764563ae2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Allegro giocoso', part.name_en = 'IV. Finale. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11424 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:af791642-1ff7-321a-9c30-7c27da67b831' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af791642-1ff7-321a-9c30-7c27da67b831', 4, 'IV', '피날레. Allegro giocoso', 'IV. Finale. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11424 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af791642-1ff7-321a-9c30-7c27da67b831'
);


-- Op. 101 피아노 3중주 3번 C단조

UPDATE pieces piece
SET piece.title = '피아노 3중주 3번 C단조', piece.title_en = 'Piano Trio No. 3 in C minor',
    piece.type = 'album', piece.opus_number = 'Op. 101',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11841 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 11841 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro energico', part.name_en = 'I. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11841 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6a4b428a-1bac-3055-908f-7537f959b13d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a4b428a-1bac-3055-908f-7537f959b13d', 1, 'I', 'Allegro energico', 'I. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11841 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a4b428a-1bac-3055-908f-7537f959b13d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Presto non assai', part.name_en = 'II. Presto non assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11841 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ec9b0870-97a2-3bd3-8ea0-d532dd75485f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec9b0870-97a2-3bd3-8ea0-d532dd75485f', 2, 'II', 'Presto non assai', 'II. Presto non assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11841 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec9b0870-97a2-3bd3-8ea0-d532dd75485f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante grazioso', part.name_en = 'III. Andante grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11841 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:47a9d443-e69f-3ded-8faf-2a356207059c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47a9d443-e69f-3ded-8faf-2a356207059c', 3, 'III', 'Andante grazioso', 'III. Andante grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11841 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47a9d443-e69f-3ded-8faf-2a356207059c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto', part.name_en = 'IV. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11841 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3e28aec8-bb4a-375b-a128-16b752e7bde0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e28aec8-bb4a-375b-a128-16b752e7bde0', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11841 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e28aec8-bb4a-375b-a128-16b752e7bde0'
);


-- Op. 25 피아노 4중주 1번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 1번 G단조', 'Piano Quartet No. 1 in G minor', 'album', 'Op. 25', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 1번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f006b80-fee6-44dc-8322-684d3bc04ea1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f006b80-fee6-44dc-8322-684d3bc04ea1'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f006b80-fee6-44dc-8322-684d3bc04ea1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34a8d2cb-3b95-3972-aed3-34e42edee395', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34a8d2cb-3b95-3972-aed3-34e42edee395'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ee5f432-18c5-36d1-aecd-d6327572ca5b', 2, 'II', '인테르메초. Allegro ma non troppo – 트리오. Animato', 'II. Intermezzo. Allegro ma non troppo – Trio. Animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ee5f432-18c5-36d1-aecd-d6327572ca5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:978cfd00-b0d3-3b2a-8e77-0474c765a3e7', 3, 'III', 'Andante con moto', 'III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:978cfd00-b0d3-3b2a-8e77-0474c765a3e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae3dbe8e-dc87-31a5-b030-f061718addc4', 4, 'IV', '집시풍 론도. Presto', 'IV. Rondo alla Zingarese. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '피아노 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae3dbe8e-dc87-31a5-b030-f061718addc4'
);


-- Op. 26 피아노 4중주 2번 A장조

UPDATE pieces piece
SET piece.title = '피아노 4중주 2번 A장조', piece.title_en = 'Piano Quartet No. 2 in A major',
    piece.type = 'album', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11493 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11493 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11493 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d2263c65-7140-336c-a6fb-aa0e79e48780' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2263c65-7140-336c-a6fb-aa0e79e48780', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11493 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2263c65-7140-336c-a6fb-aa0e79e48780'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Poco adagio', part.name_en = 'II. Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11493 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2b5d221b-cb1d-3bcc-b052-12b3297c9381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b5d221b-cb1d-3bcc-b052-12b3297c9381', 2, 'II', 'Poco adagio', 'II. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11493 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b5d221b-cb1d-3bcc-b052-12b3297c9381'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Poco Allegro', part.name_en = 'III. Scherzo. Poco Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11493 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3ce996dc-65c7-3b1d-b0c5-499b8cc89edf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ce996dc-65c7-3b1d-b0c5-499b8cc89edf', 3, 'III', '스케르초. Poco Allegro', 'III. Scherzo. Poco Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11493 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ce996dc-65c7-3b1d-b0c5-499b8cc89edf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Allegro', part.name_en = 'IV. Finale. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11493 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:88ee2198-b381-382d-9cad-698ffdefadf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88ee2198-b381-382d-9cad-698ffdefadf3', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11493 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88ee2198-b381-382d-9cad-698ffdefadf3'
);


-- Op. 60 피아노 4중주 3번 C단조

UPDATE pieces piece
SET piece.title = '피아노 4중주 3번 C단조', piece.title_en = 'Piano Quartet No. 3 in C minor',
    piece.type = 'album', piece.opus_number = 'Op. 60',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11682 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 11682 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11682 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ed428018-e010-3657-b807-c3f85e79d1ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed428018-e010-3657-b807-c3f85e79d1ea', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11682 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed428018-e010-3657-b807-c3f85e79d1ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Allegro', part.name_en = 'II. Scherzo. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11682 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:974965b7-9cbb-3ad4-88ad-4ef671c9057a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:974965b7-9cbb-3ad4-88ad-4ef671c9057a', 2, 'II', '스케르초. Allegro', 'II. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11682 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:974965b7-9cbb-3ad4-88ad-4ef671c9057a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11682 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f29b46a1-95ee-315e-b876-b76e00218690' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f29b46a1-95ee-315e-b876-b76e00218690', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11682 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f29b46a1-95ee-315e-b876-b76e00218690'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Allegro comodo', part.name_en = 'IV. Finale. Allegro comodo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11682 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c6f5b647-11dc-3a83-8ca4-2ef341163a56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6f5b647-11dc-3a83-8ca4-2ef341163a56', 4, 'IV', '피날레. Allegro comodo', 'IV. Finale. Allegro comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11682 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6f5b647-11dc-3a83-8ca4-2ef341163a56'
);


-- Op. 34 피아노 5중주 F단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 F단조', piece.title_en = 'Piano Quintet in F minor',
    piece.type = 'album', piece.opus_number = 'Op. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11504 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 11504 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11504 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:01ceed70-3c38-38df-bc0c-ccece59548dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01ceed70-3c38-38df-bc0c-ccece59548dc', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11504 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01ceed70-3c38-38df-bc0c-ccece59548dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante, un poco adagio', part.name_en = 'II. Andante, un poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11504 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4b0c4faa-94f8-3131-ac13-3f1886192282' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b0c4faa-94f8-3131-ac13-3f1886192282', 2, 'II', 'Andante, un poco adagio', 'II. Andante, un poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11504 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b0c4faa-94f8-3131-ac13-3f1886192282'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Allegro', part.name_en = 'III. Scherzo. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11504 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6e82c645-8f79-3105-81db-30b6c93fc12d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e82c645-8f79-3105-81db-30b6c93fc12d', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11504 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e82c645-8f79-3105-81db-30b6c93fc12d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Poco sostenuto – Allegro non troppo – Presto, non troppo', part.name_en = 'IV. Finale. Poco sostenuto – Allegro non troppo – Presto, non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11504 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9763e794-7b8d-3174-bcd3-f5f095da8ca3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9763e794-7b8d-3174-bcd3-f5f095da8ca3', 4, 'IV', '피날레. Poco sostenuto – Allegro non troppo – Presto, non troppo', 'IV. Finale. Poco sostenuto – Allegro non troppo – Presto, non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11504 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9763e794-7b8d-3174-bcd3-f5f095da8ca3'
);


-- Op. 114 클라리넷 3중주 A단조

UPDATE pieces piece
SET piece.title = '클라리넷 3중주 A단조', piece.title_en = 'Clarinet Trio in A minor',
    piece.type = 'album', piece.opus_number = 'Op. 114',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11465 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 11465 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11465 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:274e7093-9988-35bd-b8e3-022a0c2fcb09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:274e7093-9988-35bd-b8e3-022a0c2fcb09', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11465 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:274e7093-9988-35bd-b8e3-022a0c2fcb09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11465 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2a09a3ea-caf1-3959-8a44-f147a25eeca1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a09a3ea-caf1-3959-8a44-f147a25eeca1', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11465 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a09a3ea-caf1-3959-8a44-f147a25eeca1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante grazioso', part.name_en = 'III. Andante grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11465 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9d8e0ee9-7784-382d-a47a-c875415c3b49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d8e0ee9-7784-382d-a47a-c875415c3b49', 3, 'III', 'Andante grazioso', 'III. Andante grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11465 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d8e0ee9-7784-382d-a47a-c875415c3b49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11465 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:48271346-a07c-31ee-b8c6-7fd2eff59842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48271346-a07c-31ee-b8c6-7fd2eff59842', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11465 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48271346-a07c-31ee-b8c6-7fd2eff59842'
);


-- Op. 115 클라리넷 5중주 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 5중주 B단조', 'Clarinet Quintet in B minor', 'album', 'Op. 115', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 5중주 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71acad7c-5ed3-4bf1-bc6a-7687e7c8486e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '71acad7c-5ed3-4bf1-bc6a-7687e7c8486e'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '클라리넷 5중주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71acad7c-5ed3-4bf1-bc6a-7687e7c8486e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3e6fd22-b37c-30bd-80e2-a3d33ad4927e', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '클라리넷 5중주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3e6fd22-b37c-30bd-80e2-a3d33ad4927e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79c2679a-3477-30e9-b724-fd2212d774d9', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '클라리넷 5중주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79c2679a-3477-30e9-b724-fd2212d774d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bc062d2-03d6-32b2-b180-f3b2bbde4e40', 3, 'III', 'Andantino – Presto non assai, ma con sentimento', 'III. Andantino – Presto non assai, ma con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '클라리넷 5중주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bc062d2-03d6-32b2-b180-f3b2bbde4e40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:301c95bd-219f-3e56-83d8-2cdce757874a', 4, 'IV', 'Con moto', 'IV. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '클라리넷 5중주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:301c95bd-219f-3e56-83d8-2cdce757874a'
);


-- Op. 40 호른 3중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른 3중주 E♭장조', 'Horn Trio in E♭ major', 'album', 'Op. 40', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른 3중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5effd88b-5c94-4e17-984b-dffbdda4e274'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5effd88b-5c94-4e17-984b-dffbdda4e274'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '호른 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5effd88b-5c94-4e17-984b-dffbdda4e274'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db880173-b4a2-301f-bb84-27bae21ef45e', 1, 'I', 'Andante – Poco più animato', 'I. Andante – Poco più animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '호른 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db880173-b4a2-301f-bb84-27bae21ef45e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0deecb5-8aaa-3ab2-8275-187f21564548', 2, 'II', '스케르초. Allegro – Molto meno allegro', 'II. Scherzo. Allegro – Molto meno allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '호른 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0deecb5-8aaa-3ab2-8275-187f21564548'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:466e55a7-97fc-3838-95aa-5ddea8196f92', 3, 'III', 'Adagio mesto', 'III. Adagio mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '호른 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:466e55a7-97fc-3838-95aa-5ddea8196f92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bac1c82-bbfa-36d2-92f3-4f59010a1c2c', 4, 'IV', '피날레. Allegro con brio', 'IV. Finale. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '호른 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bac1c82-bbfa-36d2-92f3-4f59010a1c2c'
);


-- Anh. III/1 현악 3중주 <위대한 요아힘 찬가> A장조

UPDATE pieces piece
SET piece.title = '현악 3중주 <위대한 요아힘 찬가> A장조', piece.title_en = 'Hymne zur Verherrlichung des großen Joachim',
    piece.type = 'song', piece.opus_number = 'Anh. III/1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11440 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 11440 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 51 현악 4중주 Op. 51

UPDATE pieces piece
SET piece.title = '현악 4중주 Op. 51', piece.title_en = '2 String Quartets, Op. 51',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '51',
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11522 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 11522 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '현악 4중주 1번 C단조', part.name_en = 'No. 1 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491', 1, NULL, '현악 4중주 1번 C단조', 'No. 1 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0bfd5fa3-9dac-33f4-b8d6-cf0f1ec3c726' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0bfd5fa3-9dac-33f4-b8d6-cf0f1ec3c726', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bfd5fa3-9dac-33f4-b8d6-cf0f1ec3c726'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '로망스. Poco adagio', part.name_en = 'II. Romanze. Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3e47474e-c7c8-3afb-8de6-7c04c80b20f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e47474e-c7c8-3afb-8de6-7c04c80b20f7', 2, 'II', '로망스. Poco adagio', 'II. Romanze. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e47474e-c7c8-3afb-8de6-7c04c80b20f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto molto moderato e comodo – 트리오', part.name_en = 'III. Allegretto molto moderato e comodo – Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0488f1f0-5de9-3f71-b4d2-3845708045a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0488f1f0-5de9-3f71-b4d2-3845708045a6', 3, 'III', 'Allegretto molto moderato e comodo – 트리오', 'III. Allegretto molto moderato e comodo – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0488f1f0-5de9-3f71-b4d2-3845708045a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2f6d5d1f-166e-3be6-a66b-488e42b37919' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f6d5d1f-166e-3be6-a66b-488e42b37919', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e06c142-8e2a-4dd2-9499-61fe9cb73491'
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f6d5d1f-166e-3be6-a66b-488e42b37919'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '현악 4중주 2번 A단조', part.name_en = 'No. 2 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c', 2, NULL, '현악 4중주 2번 A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1f19e0c6-407e-3f06-939c-53e7b5897883' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1f19e0c6-407e-3f06-939c-53e7b5897883', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f19e0c6-407e-3f06-939c-53e7b5897883'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante moderato', part.name_en = 'II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7d92701c-b40b-3534-9e9e-c8cd0adf3d25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d92701c-b40b-3534-9e9e-c8cd0adf3d25', 2, 'II', 'Andante moderato', 'II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d92701c-b40b-3534-9e9e-c8cd0adf3d25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quasi minuetto, moderato – Allegretto vivace – Tempo di minuetto', part.name_en = 'III. Quasi minuetto, moderato – Allegretto vivace – Tempo di minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ed09da3d-bf75-3c08-9db9-c13a4f898515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed09da3d-bf75-3c08-9db9-c13a4f898515', 3, 'III', 'Quasi minuetto, moderato – Allegretto vivace – Tempo di minuetto', 'III. Quasi minuetto, moderato – Allegretto vivace – Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed09da3d-bf75-3c08-9db9-c13a4f898515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Allegro non assai', part.name_en = 'IV. Finale. Allegro non assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11522 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3d63e2b3-8682-3478-b147-d3cc635219bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d63e2b3-8682-3478-b147-d3cc635219bd', 4, 'IV', '피날레. Allegro non assai', 'IV. Finale. Allegro non assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c55a312-be04-488b-9d15-9ce22582bc8c'
WHERE p.id = 11522 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d63e2b3-8682-3478-b147-d3cc635219bd'
);


-- Op. 67 현악 4중주 3번 B♭장조

UPDATE pieces piece
SET piece.title = '현악 4중주 3번 B♭장조', piece.title_en = 'String Quartet No. 3 in B♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11910 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 11910 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Vivace', part.name_en = 'I. Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11910 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:754707ae-b3d6-30c0-8fbc-d4268a6dd951' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:754707ae-b3d6-30c0-8fbc-d4268a6dd951', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11910 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:754707ae-b3d6-30c0-8fbc-d4268a6dd951'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11910 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:972ee125-49e4-325c-b6e1-ae2c3149f05d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:972ee125-49e4-325c-b6e1-ae2c3149f05d', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11910 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:972ee125-49e4-325c-b6e1-ae2c3149f05d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Agitato', part.name_en = 'III. Agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11910 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:188b7472-05d9-3f8a-b0d3-31c406fcb9f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:188b7472-05d9-3f8a-b0d3-31c406fcb9f0', 3, 'III', 'Agitato', 'III. Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11910 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:188b7472-05d9-3f8a-b0d3-31c406fcb9f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Poco allegretto con variazioni – Doppio movimento', part.name_en = 'IV. Poco allegretto con variazioni – Doppio movimento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11910 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c5bd9a18-dfc4-3b9e-9073-ed3c485a3a70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5bd9a18-dfc4-3b9e-9073-ed3c485a3a70', 4, 'IV', 'Poco allegretto con variazioni – Doppio movimento', 'IV. Poco allegretto con variazioni – Doppio movimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11910 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5bd9a18-dfc4-3b9e-9073-ed3c485a3a70'
);


-- Op. 88 현악 5중주 1번 F장조

UPDATE pieces piece
SET piece.title = '현악 5중주 1번 F장조', piece.title_en = 'String Quintet No. 1 in F major',
    piece.type = 'album', piece.opus_number = 'Op. 88',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11920 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 11920 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo ma con brio', part.name_en = 'I. Allegro non troppo ma con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11920 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:67b8f2d0-98dd-3232-a1c4-f6935f96d377' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67b8f2d0-98dd-3232-a1c4-f6935f96d377', 1, 'I', 'Allegro non troppo ma con brio', 'I. Allegro non troppo ma con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11920 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67b8f2d0-98dd-3232-a1c4-f6935f96d377'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Grave ed appassionato – Allegretto vivace – Tempo I – Presto – Tempo I', part.name_en = 'II. Grave ed appassionato – Allegretto vivace – Tempo I – Presto – Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11920 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:30dd22e7-6eb4-31d0-baa8-159bb6fc621f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30dd22e7-6eb4-31d0-baa8-159bb6fc621f', 2, 'II', 'Grave ed appassionato – Allegretto vivace – Tempo I – Presto – Tempo I', 'II. Grave ed appassionato – Allegretto vivace – Tempo I – Presto – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11920 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30dd22e7-6eb4-31d0-baa8-159bb6fc621f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro energico', part.name_en = 'III. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11920 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ffe99314-341a-3f36-b351-ab70616bc4a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffe99314-341a-3f36-b351-ab70616bc4a0', 3, 'III', 'Allegro energico', 'III. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11920 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffe99314-341a-3f36-b351-ab70616bc4a0'
);


-- Op. 111 현악 5중주 2번 G장조

UPDATE pieces piece
SET piece.title = '현악 5중주 2번 G장조', piece.title_en = 'String Quintet No. 2 in G major',
    piece.type = 'album', piece.opus_number = 'Op. 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11865 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 11865 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo, ma con brio', part.name_en = 'I. Allegro non troppo, ma con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11865 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7dc45893-a7eb-37c8-942f-961ecffe43ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dc45893-a7eb-37c8-942f-961ecffe43ff', 1, 'I', 'Allegro non troppo, ma con brio', 'I. Allegro non troppo, ma con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11865 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dc45893-a7eb-37c8-942f-961ecffe43ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11865 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fce6a71e-6de1-35d7-a2fc-06ff4795ac48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fce6a71e-6de1-35d7-a2fc-06ff4795ac48', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11865 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fce6a71e-6de1-35d7-a2fc-06ff4795ac48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Un poco Allegretto', part.name_en = 'III. Un poco Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11865 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1d170dcc-af10-328e-85ec-1e5e0187064a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d170dcc-af10-328e-85ec-1e5e0187064a', 3, 'III', 'Un poco Allegretto', 'III. Un poco Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11865 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d170dcc-af10-328e-85ec-1e5e0187064a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vivace, ma non troppo presto', part.name_en = 'IV. Vivace, ma non troppo presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11865 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:80262e03-c8a7-3828-b681-01b3389b5f3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80262e03-c8a7-3828-b681-01b3389b5f3a', 4, 'IV', 'Vivace, ma non troppo presto', 'IV. Vivace, ma non troppo presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11865 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80262e03-c8a7-3828-b681-01b3389b5f3a'
);


-- Op. 18 현악 6중주 1번 B♭장조

UPDATE pieces piece
SET piece.title = '현악 6중주 1번 B♭장조', piece.title_en = 'String Sextet No. 1 in B♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11299 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 11299 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'I. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11299 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:35ac201b-3162-3dce-9313-e34c1983c1b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35ac201b-3162-3dce-9313-e34c1983c1b6', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11299 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35ac201b-3162-3dce-9313-e34c1983c1b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante ma moderato', part.name_en = 'II. Andante ma moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11299 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:33057f61-9072-34e3-baa8-b4362792e934' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33057f61-9072-34e3-baa8-b4362792e934', 2, 'II', 'Andante ma moderato', 'II. Andante ma moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11299 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33057f61-9072-34e3-baa8-b4362792e934'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Allegro molto – Animato – Più animato', part.name_en = 'III. Scherzo. Allegro molto – Animato – Più animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11299 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d6b922f7-b768-3888-957c-5699393866e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6b922f7-b768-3888-957c-5699393866e6', 3, 'III', '스케르초. Allegro molto – Animato – Più animato', 'III. Scherzo. Allegro molto – Animato – Più animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11299 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6b922f7-b768-3888-957c-5699393866e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '론도. Poco Allegretto e grazioso', part.name_en = 'IV. Rondo. Poco Allegretto e grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11299 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:674fd52c-02b9-3730-8f2d-651d6e01e985' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:674fd52c-02b9-3730-8f2d-651d6e01e985', 4, 'IV', '론도. Poco Allegretto e grazioso', 'IV. Rondo. Poco Allegretto e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11299 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:674fd52c-02b9-3730-8f2d-651d6e01e985'
);


-- Op. 36 현악 6중주 2번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 6중주 2번 G장조', 'String Sextet No. 2 in G major', 'album', 'Op. 36', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 6중주 2번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1577d77-ac82-4a1d-9ac1-eb8ddf609a8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1577d77-ac82-4a1d-9ac1-eb8ddf609a8b'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '현악 6중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1577d77-ac82-4a1d-9ac1-eb8ddf609a8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ebbc2f2-f8d9-36ca-a6ae-99ffa5cee043', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '현악 6중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ebbc2f2-f8d9-36ca-a6ae-99ffa5cee043'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92c997cf-6ec7-31cc-9db1-6a15642df64b', 2, 'II', '스케르초. Allegro non troppo', 'II. Scherzo. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '현악 6중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92c997cf-6ec7-31cc-9db1-6a15642df64b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe348187-ae8a-3c13-b2b2-2fb8c0dc4408', 3, 'III', 'Poco adagio', 'III. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '현악 6중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe348187-ae8a-3c13-b2b2-2fb8c0dc4408'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:180b5adb-b7c5-3572-a5df-44345a10b8e4', 4, 'IV', 'Poco allegro', 'IV. Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '현악 6중주 2번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180b5adb-b7c5-3572-a5df-44345a10b8e4'
);


-- Op. 1 피아노 소나타 1번 C장조

UPDATE pieces piece
SET piece.title = '피아노 소나타 1번 C장조', piece.title_en = 'Piano Sonata No. 1 in C major',
    piece.type = 'album', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11533 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 11533 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11533 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:291e9150-13ed-3dee-bb79-08c2687137e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:291e9150-13ed-3dee-bb79-08c2687137e2', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11533 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:291e9150-13ed-3dee-bb79-08c2687137e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante (nach einem altdeutschen Minneliede)', part.name_en = 'II. Andante (nach einem altdeutschen Minneliede)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11533 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:00be18be-6cd7-3bfd-ba6a-1bebaf52f27d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00be18be-6cd7-3bfd-ba6a-1bebaf52f27d', 2, 'II', 'Andante (nach einem altdeutschen Minneliede)', 'II. Andante (nach einem altdeutschen Minneliede)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11533 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00be18be-6cd7-3bfd-ba6a-1bebaf52f27d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Allegro molto e con fuoco – Più mosso', part.name_en = 'III. Scherzo. Allegro molto e con fuoco – Più mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11533 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:272c0036-1c69-3e77-a900-a75a1c13bc84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:272c0036-1c69-3e77-a900-a75a1c13bc84', 3, 'III', '스케르초. Allegro molto e con fuoco – Più mosso', 'III. Scherzo. Allegro molto e con fuoco – Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11533 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272c0036-1c69-3e77-a900-a75a1c13bc84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Allegro con fuoco', part.name_en = 'IV. Finale. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11533 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4af576b3-9acb-305d-a776-e21df2ae48b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4af576b3-9acb-305d-a776-e21df2ae48b1', 4, 'IV', '피날레. Allegro con fuoco', 'IV. Finale. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11533 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4af576b3-9acb-305d-a776-e21df2ae48b1'
);


-- Op. 2 피아노 소나타 2번 F#단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 2번 F#단조', piece.title_en = 'Piano Sonata No. 2 in F# minor',
    piece.type = 'album', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1852, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11871 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1852
WHERE piece.id = 11871 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo ma energico', part.name_en = 'I. Allegro non troppo ma energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11871 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:34155a5c-60a8-3e58-85d5-25dea307f3bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34155a5c-60a8-3e58-85d5-25dea307f3bc', 1, 'I', 'Allegro non troppo ma energico', 'I. Allegro non troppo ma energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11871 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34155a5c-60a8-3e58-85d5-25dea307f3bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con espressione', part.name_en = 'II. Andante con espressione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11871 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d6b2bf05-12bf-34a7-9e11-c084f3335169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6b2bf05-12bf-34a7-9e11-c084f3335169', 2, 'II', 'Andante con espressione', 'II. Andante con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11871 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6b2bf05-12bf-34a7-9e11-c084f3335169'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Allegro – Poco più moderato', part.name_en = 'III. Scherzo. Allegro – Poco più moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11871 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:951da055-7494-3787-8fae-a9a72ee20ad5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:951da055-7494-3787-8fae-a9a72ee20ad5', 3, 'III', '스케르초. Allegro – Poco più moderato', 'III. Scherzo. Allegro – Poco più moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11871 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:951da055-7494-3787-8fae-a9a72ee20ad5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. 서주. Sostenuto – Allegro non troppo e rubato – Molto sostenuto', part.name_en = 'IV. Finale. Introduzione. Sostenuto – Allegro non troppo e rubato – Molto sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11871 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3fc773ee-0380-3549-b4b9-d51f23dd43ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fc773ee-0380-3549-b4b9-d51f23dd43ab', 4, 'IV', '피날레. 서주. Sostenuto – Allegro non troppo e rubato – Molto sostenuto', 'IV. Finale. Introduzione. Sostenuto – Allegro non troppo e rubato – Molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11871 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fc773ee-0380-3549-b4b9-d51f23dd43ab'
);


-- Op. 5 피아노 소나타 3번 F단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 3번 F단조', piece.title_en = 'Piano Sonata No. 3 in F minor',
    piece.type = 'album', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11571 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 11571 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro maestoso', part.name_en = 'I. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11571 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:33576308-db28-3500-a1f3-6df13e5e0c52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33576308-db28-3500-a1f3-6df13e5e0c52', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11571 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33576308-db28-3500-a1f3-6df13e5e0c52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante espressivo – Andante molto', part.name_en = 'II. Andante espressivo – Andante molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11571 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fff1322b-4446-3144-8881-53f52bf794cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fff1322b-4446-3144-8881-53f52bf794cd', 2, 'II', 'Andante espressivo – Andante molto', 'II. Andante espressivo – Andante molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11571 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fff1322b-4446-3144-8881-53f52bf794cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Allegro energico', part.name_en = 'III. Scherzo. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11571 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:11c4c36e-d8a1-3f50-9892-94ced46de185' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11c4c36e-d8a1-3f50-9892-94ced46de185', 3, 'III', '스케르초. Allegro energico', 'III. Scherzo. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11571 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11c4c36e-d8a1-3f50-9892-94ced46de185'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '인테르메초 (Rückblick). Andante molto', part.name_en = 'IV. Intermezzo (Rückblick). Andante molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11571 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:09d12484-e06d-3e81-a1e0-8e4e956f5573' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09d12484-e06d-3e81-a1e0-8e4e956f5573', 4, 'IV', '인테르메초 (Rückblick). Andante molto', 'IV. Intermezzo (Rückblick). Andante molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11571 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09d12484-e06d-3e81-a1e0-8e4e956f5573'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레. Allegro moderato ma rubato', part.name_en = 'V. Finale. Allegro moderato ma rubato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11571 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5e745bfa-05a9-3956-add4-ce13c24b70c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e745bfa-05a9-3956-add4-ce13c24b70c9', 5, 'V', '피날레. Allegro moderato ma rubato', 'V. Finale. Allegro moderato ma rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11571 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e745bfa-05a9-3956-add4-ce13c24b70c9'
);


-- Op. 4 스케르초 E♭단조

UPDATE pieces piece
SET piece.title = '스케르초 E♭단조', piece.title_en = 'Scherzo in E♭ minor',
    piece.type = 'song', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1851, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11729 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1851
WHERE piece.id = 11729 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 9 슈만 주제에 의한 변주곡 F#단조

UPDATE pieces piece
SET piece.title = '슈만 주제에 의한 변주곡 F#단조', piece.title_en = 'Variations on a Theme by Robert Schumann in F# minor',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1854, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1560 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1854
WHERE piece.id = 1560 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 10 4개의 발라드 Op. 10

UPDATE pieces piece
SET piece.title = '4개의 발라드 Op. 10', piece.title_en = '4 Ballades, Op. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '10',
    piece.composition_year = COALESCE(1854, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11444 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1854
WHERE piece.id = 11444 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D단조 "에드워드"', part.name_en = 'No. 1 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11444 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:febc4ba0-4dd0-323d-bac5-961acb00462d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:febc4ba0-4dd0-323d-bac5-961acb00462d', 1, NULL, 'D단조 "에드워드"', 'No. 1 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11444 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:febc4ba0-4dd0-323d-bac5-961acb00462d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = 'No. 2 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11444 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6bb5f446-974b-368a-b69d-a8de10a0f26a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bb5f446-974b-368a-b69d-a8de10a0f26a', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11444 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bb5f446-974b-368a-b69d-a8de10a0f26a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = 'No. 3 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11444 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a09ba645-b470-3439-a0fd-3b9e72b834a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a09ba645-b470-3439-a0fd-3b9e72b834a9', 3, NULL, 'B단조', 'No. 3 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11444 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a09ba645-b470-3439-a0fd-3b9e72b834a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'B장조', part.name_en = 'No. 4 in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11444 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:49939c8b-edea-319a-8f68-0bd8e1689171' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49939c8b-edea-319a-8f68-0bd8e1689171', 4, NULL, 'B장조', 'No. 4 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11444 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49939c8b-edea-319a-8f68-0bd8e1689171'
);


-- Op. 18b 주제와 변주 D단조

UPDATE pieces piece
SET piece.title = '주제와 변주 D단조', piece.title_en = 'Theme and Variations in D minor',
    piece.type = 'song', piece.opus_number = 'Op. 18b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11301 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 11301 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 21 2개의 변주곡 Op. 21

UPDATE pieces piece
SET piece.title = '2개의 변주곡 Op. 21', piece.title_en = '2 Sets of Variations, Op. 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '21',
    piece.composition_year = COALESCE(1857, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11462 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1857
WHERE piece.id = 11462 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '자작 주제에 의한 변주곡 D장조', part.name_en = 'No. 1: Variations on an Original Theme in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11462 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7b06ff76-aa23-349f-93dc-47b4fadee418' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b06ff76-aa23-349f-93dc-47b4fadee418', 1, NULL, '자작 주제에 의한 변주곡 D장조', 'No. 1: Variations on an Original Theme in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11462 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b06ff76-aa23-349f-93dc-47b4fadee418'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '헝가리 노래에 의한 변주곡 D장조', part.name_en = 'No. 2: Variations on a Hungarian Song in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11462 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e335711f-2301-32e9-ab9e-f39021f98ee9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e335711f-2301-32e9-ab9e-f39021f98ee9', 2, NULL, '헝가리 노래에 의한 변주곡 D장조', 'No. 2: Variations on a Hungarian Song in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11462 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e335711f-2301-32e9-ab9e-f39021f98ee9'
);


-- Op. 24 헨델 주제에 의한 변주곡과 푸가 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헨델 주제에 의한 변주곡과 푸가 B♭장조', 'Variations and Fugue on a Theme by Handel in B♭ major', 'song', 'Op. 24', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헨델 주제에 의한 변주곡과 푸가 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fc5a01f-0c35-41d7-897d-1b48481fd529'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7fc5a01f-0c35-41d7-897d-1b48481fd529'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '헨델 주제에 의한 변주곡과 푸가 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fc5a01f-0c35-41d7-897d-1b48481fd529'
);


-- Op. 35 파가니니 주제에 의한 변주곡 A단조

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 변주곡 A단조', piece.title_en = 'Variations on a Theme by Paganini in A minor',
    piece.type = 'song', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11525 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 11525 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 76 8개의 피아노 소품 Op. 76

UPDATE pieces piece
SET piece.title = '8개의 피아노 소품 Op. 76', piece.title_en = '8 Piano Pieces, Op. 76',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '76',
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11315 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 11315 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '카프리치오 F#단조', part.name_en = 'No. 1: Capriccio in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11315 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7553bce7-2e67-341c-9533-59053fd7d935' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7553bce7-2e67-341c-9533-59053fd7d935', 1, NULL, '카프리치오 F#단조', 'No. 1: Capriccio in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11315 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7553bce7-2e67-341c-9533-59053fd7d935'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '카프리치오 B단조', part.name_en = 'No. 2: Capriccio in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11315 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:17124083-d61c-3bb4-ab8e-e810e170c5b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17124083-d61c-3bb4-ab8e-e810e170c5b3', 2, NULL, '카프리치오 B단조', 'No. 2: Capriccio in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11315 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17124083-d61c-3bb4-ab8e-e810e170c5b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '인테르메초 A♭장조', part.name_en = 'No. 3: Intermezzo in A♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11315 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:51931bcd-ee70-396e-9b1d-66613fa6c014' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51931bcd-ee70-396e-9b1d-66613fa6c014', 3, NULL, '인테르메초 A♭장조', 'No. 3: Intermezzo in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11315 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51931bcd-ee70-396e-9b1d-66613fa6c014'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '인테르메초 B♭장조', part.name_en = 'No. 4: Intermezzo in B♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11315 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:867f1334-a72d-387a-bafd-10a2e7c21609' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:867f1334-a72d-387a-bafd-10a2e7c21609', 4, NULL, '인테르메초 B♭장조', 'No. 4: Intermezzo in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11315 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:867f1334-a72d-387a-bafd-10a2e7c21609'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '카프리치오 C#단조', part.name_en = 'No. 5: Capriccio in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11315 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e979987e-4ff6-3acd-b324-fca2ba742dd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e979987e-4ff6-3acd-b324-fca2ba742dd3', 5, NULL, '카프리치오 C#단조', 'No. 5: Capriccio in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11315 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e979987e-4ff6-3acd-b324-fca2ba742dd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '인테르메초 A장조', part.name_en = 'No. 6: Intermezzo in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11315 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1b5551d4-98d9-3802-8a31-f801c6c9f953' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b5551d4-98d9-3802-8a31-f801c6c9f953', 6, NULL, '인테르메초 A장조', 'No. 6: Intermezzo in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11315 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b5551d4-98d9-3802-8a31-f801c6c9f953'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '인테르메초 A단조', part.name_en = 'No. 7: Intermezzo in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11315 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e267008e-a355-31dc-89e6-1a85bad4d45a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e267008e-a355-31dc-89e6-1a85bad4d45a', 7, NULL, '인테르메초 A단조', 'No. 7: Intermezzo in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11315 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e267008e-a355-31dc-89e6-1a85bad4d45a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '카프리치오 C장조', part.name_en = 'No. 8: Capriccio in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11315 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9771294d-d951-307d-bda4-8b1fc1689d9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9771294d-d951-307d-bda4-8b1fc1689d9d', 8, NULL, '카프리치오 C장조', 'No. 8: Capriccio in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11315 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9771294d-d951-307d-bda4-8b1fc1689d9d'
);


-- Op. 79 2개의 랩소디 Op. 79

UPDATE pieces piece
SET piece.title = '2개의 랩소디 Op. 79', piece.title_en = '2 Rhapsodies, Op. 79',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '79',
    piece.composition_year = COALESCE(1879, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11768 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1879
WHERE piece.id = 11768 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = 'No. 1 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11768 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2f92e12f-57aa-3b9d-8c40-4c3cee9920c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f92e12f-57aa-3b9d-8c40-4c3cee9920c4', 1, NULL, 'B단조', 'No. 1 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11768 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f92e12f-57aa-3b9d-8c40-4c3cee9920c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = 'No. 2 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11768 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:46065011-ef7e-3790-a470-c84807504178' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46065011-ef7e-3790-a470-c84807504178', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11768 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46065011-ef7e-3790-a470-c84807504178'
);


-- Op. 116 7개의 환상곡 Op. 116

UPDATE pieces piece
SET piece.title = '7개의 환상곡 Op. 116', piece.title_en = '7 Fantasias, Op. 116',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '116',
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11455 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 11455 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '카프리치오 D단조', part.name_en = 'No. 1: Capriccio in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11455 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f8bb7908-3089-3fc1-a11b-abd70097bce8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8bb7908-3089-3fc1-a11b-abd70097bce8', 1, NULL, '카프리치오 D단조', 'No. 1: Capriccio in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11455 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8bb7908-3089-3fc1-a11b-abd70097bce8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '인테르메초 A단조', part.name_en = 'No. 2: Intermezzo in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11455 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a58fdffe-bebc-3fc9-aead-1615716b9db6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a58fdffe-bebc-3fc9-aead-1615716b9db6', 2, NULL, '인테르메초 A단조', 'No. 2: Intermezzo in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11455 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a58fdffe-bebc-3fc9-aead-1615716b9db6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '카프리치오 G단조', part.name_en = 'No. 3: Capriccio in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11455 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d35a150d-1eb3-3ff8-aa31-04c3b85e11ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d35a150d-1eb3-3ff8-aa31-04c3b85e11ce', 3, NULL, '카프리치오 G단조', 'No. 3: Capriccio in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11455 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d35a150d-1eb3-3ff8-aa31-04c3b85e11ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '인테르메초 E장조', part.name_en = 'No. 4: Intermezzo in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11455 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:120bae06-6649-3985-8722-71d37613ffd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:120bae06-6649-3985-8722-71d37613ffd6', 4, NULL, '인테르메초 E장조', 'No. 4: Intermezzo in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11455 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:120bae06-6649-3985-8722-71d37613ffd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '인테르메초 E단조', part.name_en = 'No. 5: Intermezzo in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11455 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3990664f-64b8-3ff5-817b-3350470a7cfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3990664f-64b8-3ff5-817b-3350470a7cfe', 5, NULL, '인테르메초 E단조', 'No. 5: Intermezzo in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11455 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3990664f-64b8-3ff5-817b-3350470a7cfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '인테르메초 E장조', part.name_en = 'No. 6: Intermezzo in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11455 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:732fd2a0-9428-3f40-af74-8eaf5725fe03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:732fd2a0-9428-3f40-af74-8eaf5725fe03', 6, NULL, '인테르메초 E장조', 'No. 6: Intermezzo in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11455 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:732fd2a0-9428-3f40-af74-8eaf5725fe03'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '카프리치오 D단조', part.name_en = 'No. 7: Capriccio in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11455 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ae92ba1c-f4f9-39b7-88e9-654fd936836f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae92ba1c-f4f9-39b7-88e9-654fd936836f', 7, NULL, '카프리치오 D단조', 'No. 7: Capriccio in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11455 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae92ba1c-f4f9-39b7-88e9-654fd936836f'
);


-- Op. 117 3개의 인테르메초 Op. 117

UPDATE pieces piece
SET piece.title = '3개의 인테르메초 Op. 117', piece.title_en = '3 Intermezzi, Op. 117',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '117',
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11727 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 11727 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = 'No. 1 in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11727 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:391c0980-a704-30d0-81a3-24f4d9b6c655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:391c0980-a704-30d0-81a3-24f4d9b6c655', 1, NULL, 'E♭장조', 'No. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11727 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:391c0980-a704-30d0-81a3-24f4d9b6c655'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'B♭단조', part.name_en = 'No. 2 in B♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11727 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:22a3877a-4db2-360a-9ce5-2430b49a61c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22a3877a-4db2-360a-9ce5-2430b49a61c1', 2, NULL, 'B♭단조', 'No. 2 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11727 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22a3877a-4db2-360a-9ce5-2430b49a61c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C#단조', part.name_en = 'No. 3 in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11727 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fd07e878-2d9c-3d2d-9111-ca65c7c0de74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd07e878-2d9c-3d2d-9111-ca65c7c0de74', 3, NULL, 'C#단조', 'No. 3 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11727 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd07e878-2d9c-3d2d-9111-ca65c7c0de74'
);


-- Op. 118 6개의 피아노 소품 Op. 118

UPDATE pieces piece
SET piece.title = '6개의 피아노 소품 Op. 118', piece.title_en = '6 Piano Pieces, Op. 118',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '118',
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11306 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 11306 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '인테르메초 A단조', part.name_en = 'No. 1: Intermezzo in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11306 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:84f43409-966e-33ee-8acc-7779da5110e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84f43409-966e-33ee-8acc-7779da5110e9', 1, NULL, '인테르메초 A단조', 'No. 1: Intermezzo in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11306 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84f43409-966e-33ee-8acc-7779da5110e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '인테르메초 A장조', part.name_en = 'No. 2: Intermezzo in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11306 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ebb107a6-6e6f-3bbc-aad2-0f83173ec347' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebb107a6-6e6f-3bbc-aad2-0f83173ec347', 2, NULL, '인테르메초 A장조', 'No. 2: Intermezzo in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11306 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebb107a6-6e6f-3bbc-aad2-0f83173ec347'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '발라드 G단조', part.name_en = 'No. 3: Ballade in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11306 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7eec93ef-4c9b-3a11-95cd-94f0c2ab4235' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7eec93ef-4c9b-3a11-95cd-94f0c2ab4235', 3, NULL, '발라드 G단조', 'No. 3: Ballade in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11306 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eec93ef-4c9b-3a11-95cd-94f0c2ab4235'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '인테르메초 F단조', part.name_en = 'No. 4: Intermezzo in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11306 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:07b91e3a-3fd0-3012-90bd-0c0c378d2634' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07b91e3a-3fd0-3012-90bd-0c0c378d2634', 4, NULL, '인테르메초 F단조', 'No. 4: Intermezzo in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11306 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07b91e3a-3fd0-3012-90bd-0c0c378d2634'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '로망스 F장조', part.name_en = 'No. 5: Romance in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11306 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6329f108-3ff4-3abc-8040-c0dfddc8a68b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6329f108-3ff4-3abc-8040-c0dfddc8a68b', 5, NULL, '로망스 F장조', 'No. 5: Romance in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11306 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6329f108-3ff4-3abc-8040-c0dfddc8a68b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '인테르메초 E♭단조', part.name_en = 'No. 6: Intermezzo in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11306 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:cb881824-3f1b-3396-8a28-33ba996ff40c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb881824-3f1b-3396-8a28-33ba996ff40c', 6, NULL, '인테르메초 E♭단조', 'No. 6: Intermezzo in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11306 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb881824-3f1b-3396-8a28-33ba996ff40c'
);


-- Op. 119 4개의 피아노 소품 Op. 119

UPDATE pieces piece
SET piece.title = '4개의 피아노 소품 Op. 119', piece.title_en = '4 Piano Pieces, Op. 119',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '119',
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11364 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 11364 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '인테르메초 B단조', part.name_en = 'No. 1: Intermezzo in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11364 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0ca03913-b92f-398d-a08f-902bf3d4d51a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ca03913-b92f-398d-a08f-902bf3d4d51a', 1, NULL, '인테르메초 B단조', 'No. 1: Intermezzo in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11364 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ca03913-b92f-398d-a08f-902bf3d4d51a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '인테르메초 E단조', part.name_en = 'No. 2: Intermezzo in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11364 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7333dab6-ecb8-367a-99c1-9e3b675beb18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7333dab6-ecb8-367a-99c1-9e3b675beb18', 2, NULL, '인테르메초 E단조', 'No. 2: Intermezzo in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11364 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7333dab6-ecb8-367a-99c1-9e3b675beb18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '인테르메초 C장조', part.name_en = 'No. 3: Intermezzo in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11364 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d26f8212-366a-320e-a28b-8a983269ff6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26f8212-366a-320e-a28b-8a983269ff6a', 3, NULL, '인테르메초 C장조', 'No. 3: Intermezzo in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11364 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26f8212-366a-320e-a28b-8a983269ff6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '랩소디 E♭장조', part.name_en = 'No. 4: Rhapsody in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11364 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9eefd705-8ce4-3182-965f-51879ca55908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eefd705-8ce4-3182-965f-51879ca55908', 4, NULL, '랩소디 E♭장조', 'No. 4: Rhapsody in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11364 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eefd705-8ce4-3182-965f-51879ca55908'
);


-- WoO 3 2개의 가보트 WoO 3

UPDATE pieces piece
SET piece.title = '2개의 가보트 WoO 3', piece.title_en = '2 Gavottes, WoO 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'WoO', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11515 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 11515 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'No. 1 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11515 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0e4fd003-f2b8-4319-a8cf-07ca5f202c8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e4fd003-f2b8-4319-a8cf-07ca5f202c8f', 1, NULL, 'A장조', 'No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11515 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e4fd003-f2b8-4319-a8cf-07ca5f202c8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 2 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11515 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:01191e6c-b5b5-4939-a41f-b3fb8f2706a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01191e6c-b5b5-4939-a41f-b3fb8f2706a2', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11515 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01191e6c-b5b5-4939-a41f-b3fb8f2706a2'
);


-- WoO 4 2개의 지그 WoO 4

UPDATE pieces piece
SET piece.title = '2개의 지그 WoO 4', piece.title_en = '2 Gigues, WoO 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'WoO', piece.catalogue_number = '4',
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11914 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 11914 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 1 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11914 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:cbd49ace-1fe9-3c7d-a956-4bf8db857a71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbd49ace-1fe9-3c7d-a956-4bf8db857a71', 1, NULL, 'A단조', 'No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11914 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbd49ace-1fe9-3c7d-a956-4bf8db857a71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = 'No. 2 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11914 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2d977582-36ce-340b-88f3-75acaaa09756' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d977582-36ce-340b-88f3-75acaaa09756', 2, NULL, 'B단조', 'No. 2 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11914 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d977582-36ce-340b-88f3-75acaaa09756'
);


-- WoO 5 2개의 사라반드 WoO 5

UPDATE pieces piece
SET piece.title = '2개의 사라반드 WoO 5', piece.title_en = '2 Sarabandes, WoO 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'WoO', piece.catalogue_number = '5',
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11845 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 11845 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 1 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11845 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c720db11-bff3-3fd4-a2c1-52a6498d28e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c720db11-bff3-3fd4-a2c1-52a6498d28e5', 1, NULL, 'A단조', 'No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11845 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c720db11-bff3-3fd4-a2c1-52a6498d28e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = 'No. 2 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11845 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:93508806-d93a-3b0c-af71-9ed726413ca3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93508806-d93a-3b0c-af71-9ed726413ca3', 2, NULL, 'B단조', 'No. 2 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11845 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93508806-d93a-3b0c-af71-9ed726413ca3'
);


-- WoO 6 51개의 피아노 연습곡

UPDATE pieces piece
SET piece.title = '51개의 피아노 연습곡', piece.title_en = '51 Exercises for Piano',
    piece.type = 'song', piece.opus_number = 'WoO 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11793 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 11793 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Anh. III/2 피아노를 위한 카논 F단조

UPDATE pieces piece
SET piece.title = '피아노를 위한 카논 F단조', piece.title_en = 'Canon in F minor for piano',
    piece.type = 'song', piece.opus_number = 'Anh. III/2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11518 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 11518 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Anh. III/3 피아노를 위한 원형 카논

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노를 위한 원형 카논', 'Kreis-Kanon (Circle Canon) for piano', 'song', 'Anh. III/3', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노를 위한 원형 카논'
);


-- Anh. III/4 피아노 소품 B♭장조

UPDATE pieces piece
SET piece.title = '피아노 소품 B♭장조', piece.title_en = 'Piano Piece in B♭ major',
    piece.type = 'song', piece.opus_number = 'Anh. III/4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11686 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 11686 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Anh. III/5 슈만 주제에 의한 카논 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슈만 주제에 의한 카논 D단조', 'Canon in D minor on a theme by Robert Schumann', 'song', 'Anh. III/5', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슈만 주제에 의한 카논 D단조'
);


-- Anh. III/6 슈만 주제에 의한 변주 F#단조 (1868)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슈만 주제에 의한 변주 F#단조 (1868)', 'Variation on a Theme by Schumann in F# minor (1868)', 'song', 'Anh. III/6', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슈만 주제에 의한 변주 F#단조 (1868)'
);


-- None 앨범의 한 장 A단조

UPDATE pieces piece
SET piece.title = '앨범의 한 장 A단조', piece.title_en = 'Albumblatt in A minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11766 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 11766 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 11 바흐 건반 협주곡 D단조 BWV 1052를 위한 카덴차

UPDATE pieces piece
SET piece.title = '바흐 건반 협주곡 D단조 BWV 1052를 위한 카덴차', piece.title_en = 'Cadenza for J. S. Bach''s Keyboard Concerto in D minor, BWV 1052',
    piece.type = 'song', piece.opus_number = 'WoO 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11895 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11895 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 12 베토벤 피아노 협주곡 4번을 위한 카덴차

UPDATE pieces piece
SET piece.title = '베토벤 피아노 협주곡 4번을 위한 카덴차', piece.title_en = '2 Cadenzas for Beethoven''s Piano Concerto No. 4',
    piece.type = 'album', piece.opus_number = 'WoO 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11511 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11511 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '카덴차 (1악장)', part.name_en = 'Cadenza for the first movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11511 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8aaa5a92-5d2d-4beb-863c-87f738d59b62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aaa5a92-5d2d-4beb-863c-87f738d59b62', 1, NULL, '카덴차 (1악장)', 'Cadenza for the first movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11511 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aaa5a92-5d2d-4beb-863c-87f738d59b62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '카덴차 (3악장)', part.name_en = 'Cadenza for the third movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11511 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e69f59c9-817d-4a19-93a9-5ea7e2fb508b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e69f59c9-817d-4a19-93a9-5ea7e2fb508b', 2, NULL, '카덴차 (3악장)', 'Cadenza for the third movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11511 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e69f59c9-817d-4a19-93a9-5ea7e2fb508b'
);


-- WoO 13 모차르트 피아노 협주곡 17번을 위한 카덴차

UPDATE pieces piece
SET piece.title = '모차르트 피아노 협주곡 17번을 위한 카덴차', piece.title_en = '2 Cadenzas for Mozart''s Piano Concerto No. 17, K. 453',
    piece.type = 'album', piece.opus_number = 'WoO 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11546 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11546 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '카덴차 (1악장)', part.name_en = 'Cadenza for the first movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11546 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1c5025dd-7030-4d9e-a3cb-34d932fcfa88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c5025dd-7030-4d9e-a3cb-34d932fcfa88', 1, NULL, '카덴차 (1악장)', 'Cadenza for the first movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11546 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c5025dd-7030-4d9e-a3cb-34d932fcfa88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '카덴차 (2악장)', part.name_en = 'Cadenza for the second movement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11546 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d96a2e23-c0f2-44bd-83f9-7808e8204993' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d96a2e23-c0f2-44bd-83f9-7808e8204993', 2, NULL, '카덴차 (2악장)', 'Cadenza for the second movement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11546 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d96a2e23-c0f2-44bd-83f9-7808e8204993'
);


-- WoO 14 모차르트 피아노 협주곡 20번을 위한 카덴차

UPDATE pieces piece
SET piece.title = '모차르트 피아노 협주곡 20번을 위한 카덴차', piece.title_en = 'Cadenza for Mozart''s Piano Concerto No. 20, K. 466',
    piece.type = 'song', piece.opus_number = 'WoO 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11357 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11357 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 15 모차르트 피아노 협주곡 24번을 위한 카덴차

UPDATE pieces piece
SET piece.title = '모차르트 피아노 협주곡 24번을 위한 카덴차', piece.title_en = 'Cadenza for Mozart''s Piano Concerto No. 24, K. 491',
    piece.type = 'song', piece.opus_number = 'WoO 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11847 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11847 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 23 피아노 연탄을 위한 슈만 주제에 의한 변주곡 E♭장조

UPDATE pieces piece
SET piece.title = '피아노 연탄을 위한 슈만 주제에 의한 변주곡 E♭장조', piece.title_en = 'Variations on a Theme by Schumann in E♭ major, for piano four hands',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12011 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 12011 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 39 16개의 왈츠 Op. 39

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '16개의 왈츠 Op. 39', '16 Waltzes, Op. 39', 'album', NULL, 'Op.', '39', 1865, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '16개의 왈츠 Op. 39'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '392e79df-0931-383b-93df-965791053282'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '392e79df-0931-383b-93df-965791053282'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '392e79df-0931-383b-93df-965791053282'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d160ce46-5e66-334d-8bec-edb2bd317ceb', 1, NULL, 'B장조', 'No. 1 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d160ce46-5e66-334d-8bec-edb2bd317ceb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:267b75b0-dce8-3856-a395-edcfd4da2fbe', 2, NULL, 'E장조', 'No. 2 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:267b75b0-dce8-3856-a395-edcfd4da2fbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47bf5100-317e-3c05-8fec-cb552c7ed1f2', 3, NULL, 'G#단조', 'No. 3 in G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47bf5100-317e-3c05-8fec-cb552c7ed1f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1350eb2a-daf2-3ffa-b246-cc005d09d176', 4, NULL, 'E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1350eb2a-daf2-3ffa-b246-cc005d09d176'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6203a3c-5e86-3933-bc48-dadb0668fa80', 5, NULL, 'E장조', 'No. 5 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6203a3c-5e86-3933-bc48-dadb0668fa80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ef7639a-a215-323e-9f91-b68723639c73', 6, NULL, 'C#장조', 'No. 6 in C# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ef7639a-a215-323e-9f91-b68723639c73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ebc3466-dd72-3cc6-b800-29674ea56c74', 7, NULL, 'C#단조', 'No. 7 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ebc3466-dd72-3cc6-b800-29674ea56c74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1afa0fca-ffd6-3de7-9040-74c5ab9b4642', 8, NULL, 'B♭장조', 'No. 8 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1afa0fca-ffd6-3de7-9040-74c5ab9b4642'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:023e21b6-5b54-343b-b0eb-3e7e25c0c1aa', 9, NULL, 'D단조', 'No. 9 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:023e21b6-5b54-343b-b0eb-3e7e25c0c1aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05b6bb51-fa76-3cc1-ac2b-bc48127a8f59', 10, NULL, 'G장조', 'No. 10 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05b6bb51-fa76-3cc1-ac2b-bc48127a8f59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1c1292f-609d-3362-8e65-a3b36ebea423', 11, NULL, 'B단조', 'No. 11 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1c1292f-609d-3362-8e65-a3b36ebea423'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd05a8ef-a1a0-30fb-b5a9-abb04a24d9bd', 12, NULL, 'E장조', 'No. 12 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd05a8ef-a1a0-30fb-b5a9-abb04a24d9bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01a81d48-f142-3885-a975-568c77df7d24', 13, NULL, 'C장조', 'No. 13 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01a81d48-f142-3885-a975-568c77df7d24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11680 AND linked.composer_id = 33), 'musicbrainz:ff22e92c-012e-3c0a-a97d-958348641f65', 14, NULL, 'A단조', 'No. 14 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff22e92c-012e-3c0a-a97d-958348641f65'
);

UPDATE pieces piece
SET piece.title = '16개의 왈츠 Op. 39 중 "A단조"', piece.title_en = '16 Waltzes, Op. 39: No. 14 in A minor', piece.editor_locked = 1
WHERE piece.id = 11680 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11859 AND linked.composer_id = 33), 'musicbrainz:47bf3cdc-157b-37fb-bc80-291f9f5fd99b', 15, NULL, 'A장조', 'No. 15 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47bf3cdc-157b-37fb-bc80-291f9f5fd99b'
);

UPDATE pieces piece
SET piece.title = '16개의 왈츠 Op. 39 중 "A장조"', piece.title_en = '16 Waltzes, Op. 39: No. 15 in A major', piece.editor_locked = 1
WHERE piece.id = 11859 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04c86a60-966d-3849-a3c7-223811a13cc0', 16, NULL, 'D단조', 'No. 16 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '16개의 왈츠 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04c86a60-966d-3849-a3c7-223811a13cc0'
);


-- Op. 52a 피아노 연탄 왈츠 <사랑의 노래>

UPDATE pieces piece
SET piece.title = '피아노 연탄 왈츠 <사랑의 노래>', piece.title_en = 'Liebeslieder Waltzes for piano four hands, Op. 52a',
    piece.type = 'album', piece.opus_number = 'Op. 52a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11821 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 11821 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rede, Mädchen, allzu liebes', part.name_en = 'Rede, Mädchen, allzu liebes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:44c3be14-c304-4460-af1b-642ebef5fbe8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44c3be14-c304-4460-af1b-642ebef5fbe8', 1, NULL, 'Rede, Mädchen, allzu liebes', 'Rede, Mädchen, allzu liebes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44c3be14-c304-4460-af1b-642ebef5fbe8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Am Gesteine rauscht die Flut', part.name_en = 'Am Gesteine rauscht die Flut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:96e49fba-13bd-4bce-aee0-f02f267f0fa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96e49fba-13bd-4bce-aee0-f02f267f0fa9', 2, NULL, 'Am Gesteine rauscht die Flut', 'Am Gesteine rauscht die Flut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96e49fba-13bd-4bce-aee0-f02f267f0fa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O die Frauen', part.name_en = 'O die Frauen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bd4c4d27-7c57-48a6-aa6f-ba4acfce7124' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd4c4d27-7c57-48a6-aa6f-ba4acfce7124', 3, NULL, 'O die Frauen', 'O die Frauen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd4c4d27-7c57-48a6-aa6f-ba4acfce7124'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Wie des Abends schöne Röte', part.name_en = 'Wie des Abends schöne Röte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6a2740d5-0440-4e58-9410-9a8086cb32ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a2740d5-0440-4e58-9410-9a8086cb32ed', 4, NULL, 'Wie des Abends schöne Röte', 'Wie des Abends schöne Röte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a2740d5-0440-4e58-9410-9a8086cb32ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Die grüne Hopfenranke', part.name_en = 'Die grüne Hopfenranke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:078d18b6-dbb5-4409-b064-34c5cc17d6c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:078d18b6-dbb5-4409-b064-34c5cc17d6c0', 5, NULL, 'Die grüne Hopfenranke', 'Die grüne Hopfenranke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:078d18b6-dbb5-4409-b064-34c5cc17d6c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ein kleiner, hübscher Vogel', part.name_en = 'Ein kleiner, hübscher Vogel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:03e8a43c-27cb-49af-be10-194617c22610' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03e8a43c-27cb-49af-be10-194617c22610', 6, NULL, 'Ein kleiner, hübscher Vogel', 'Ein kleiner, hübscher Vogel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03e8a43c-27cb-49af-be10-194617c22610'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Wohl schön bewandt war es', part.name_en = 'Wohl schön bewandt war es',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:cb2dc422-bf2c-4323-abba-2fddd333e6bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb2dc422-bf2c-4323-abba-2fddd333e6bc', 7, NULL, 'Wohl schön bewandt war es', 'Wohl schön bewandt war es', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb2dc422-bf2c-4323-abba-2fddd333e6bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Wenn so lind dein Auge mir', part.name_en = 'Wenn so lind dein Auge mir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9b5b38b6-7cbd-44c9-ac05-8d6e420a28f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b5b38b6-7cbd-44c9-ac05-8d6e420a28f7', 8, NULL, 'Wenn so lind dein Auge mir', 'Wenn so lind dein Auge mir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b5b38b6-7cbd-44c9-ac05-8d6e420a28f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Am Donaustrande', part.name_en = 'Am Donaustrande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d2aaca1d-6f6d-4ac8-8477-a218f98a8d82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2aaca1d-6f6d-4ac8-8477-a218f98a8d82', 9, NULL, 'Am Donaustrande', 'Am Donaustrande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2aaca1d-6f6d-4ac8-8477-a218f98a8d82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'O, wie sanft die Quelle', part.name_en = 'O, wie sanft die Quelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9c007a1d-4060-4d70-8465-8f5e0a1adc17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c007a1d-4060-4d70-8465-8f5e0a1adc17', 10, NULL, 'O, wie sanft die Quelle', 'O, wie sanft die Quelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c007a1d-4060-4d70-8465-8f5e0a1adc17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Nein, es ist nicht auszukommen', part.name_en = 'Nein, es ist nicht auszukommen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f631e667-f5e7-48b6-b86b-33e03e07c452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f631e667-f5e7-48b6-b86b-33e03e07c452', 11, NULL, 'Nein, es ist nicht auszukommen', 'Nein, es ist nicht auszukommen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f631e667-f5e7-48b6-b86b-33e03e07c452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Schlosser auf, und mache Schlösser', part.name_en = 'Schlosser auf, und mache Schlösser',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:345c2b43-d755-44e6-be69-dc173eb0ba61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:345c2b43-d755-44e6-be69-dc173eb0ba61', 12, NULL, 'Schlosser auf, und mache Schlösser', 'Schlosser auf, und mache Schlösser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:345c2b43-d755-44e6-be69-dc173eb0ba61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Vöglein durchrauscht die Luft', part.name_en = 'Vöglein durchrauscht die Luft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6ca6a637-6d8e-4cb5-bd71-f5b9d823f0db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ca6a637-6d8e-4cb5-bd71-f5b9d823f0db', 13, NULL, 'Vöglein durchrauscht die Luft', 'Vöglein durchrauscht die Luft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ca6a637-6d8e-4cb5-bd71-f5b9d823f0db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Sieh'', wie ist die Welle klar', part.name_en = 'Sieh'', wie ist die Welle klar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bfe4889f-6788-490d-a7f1-adef99f320f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfe4889f-6788-490d-a7f1-adef99f320f7', 14, NULL, 'Sieh'', wie ist die Welle klar', 'Sieh'', wie ist die Welle klar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfe4889f-6788-490d-a7f1-adef99f320f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Nachtigall, sie singt so schön', part.name_en = 'Nachtigall, sie singt so schön',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5a35b668-1754-4e43-9b4a-e2f5a2ef7fb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a35b668-1754-4e43-9b4a-e2f5a2ef7fb4', 15, NULL, 'Nachtigall, sie singt so schön', 'Nachtigall, sie singt so schön', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a35b668-1754-4e43-9b4a-e2f5a2ef7fb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Ein dunkeler Schacht ist Liebe', part.name_en = 'Ein dunkeler Schacht ist Liebe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6c8ee25e-9108-4c65-95e5-3e9178714823' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c8ee25e-9108-4c65-95e5-3e9178714823', 16, NULL, 'Ein dunkeler Schacht ist Liebe', 'Ein dunkeler Schacht ist Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c8ee25e-9108-4c65-95e5-3e9178714823'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Nicht wandle, mein Licht', part.name_en = 'Nicht wandle, mein Licht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2bead77b-ff54-4091-965b-98ff06702b2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bead77b-ff54-4091-965b-98ff06702b2a', 17, NULL, 'Nicht wandle, mein Licht', 'Nicht wandle, mein Licht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bead77b-ff54-4091-965b-98ff06702b2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Es bebet das Gesträuche', part.name_en = 'Es bebet das Gesträuche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11821 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b6f171a4-5d21-4675-9da4-7cbcfed61b5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6f171a4-5d21-4675-9da4-7cbcfed61b5c', 18, NULL, 'Es bebet das Gesträuche', 'Es bebet das Gesträuche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11821 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6f171a4-5d21-4675-9da4-7cbcfed61b5c'
);


-- Op. 65a 피아노 연탄 왈츠 <새로운 사랑의 노래>

UPDATE pieces piece
SET piece.title = '피아노 연탄 왈츠 <새로운 사랑의 노래>', piece.title_en = 'Neue Liebeslieder Waltzes for piano four hands, Op. 65a',
    piece.type = 'album', piece.opus_number = 'Op. 65a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11691 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 11691 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Verzicht, o Herz, auf Rettung', part.name_en = 'Verzicht, o Herz, auf Rettung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d5a0f7bd-a280-47f7-af01-4c4090d3f0f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5a0f7bd-a280-47f7-af01-4c4090d3f0f8', 1, NULL, 'Verzicht, o Herz, auf Rettung', 'Verzicht, o Herz, auf Rettung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5a0f7bd-a280-47f7-af01-4c4090d3f0f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Finstere Schatten der Nacht', part.name_en = 'Finstere Schatten der Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b6ebd01e-b41b-48ad-b184-72ceeb135148' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6ebd01e-b41b-48ad-b184-72ceeb135148', 2, NULL, 'Finstere Schatten der Nacht', 'Finstere Schatten der Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6ebd01e-b41b-48ad-b184-72ceeb135148'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'An jeder Hand die Finger', part.name_en = 'An jeder Hand die Finger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d5af7910-4e79-4549-9def-ea6103e1fa16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5af7910-4e79-4549-9def-ea6103e1fa16', 3, NULL, 'An jeder Hand die Finger', 'An jeder Hand die Finger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5af7910-4e79-4549-9def-ea6103e1fa16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ihr schwarzen Augen', part.name_en = 'Ihr schwarzen Augen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f774e1d5-095e-4943-8aa9-fe39fd1445cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f774e1d5-095e-4943-8aa9-fe39fd1445cf', 4, NULL, 'Ihr schwarzen Augen', 'Ihr schwarzen Augen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f774e1d5-095e-4943-8aa9-fe39fd1445cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Wahre, wahre deinen Sohn', part.name_en = 'Wahre, wahre deinen Sohn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:97942ec1-a6e5-40cd-bb7f-0426c3b5674b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97942ec1-a6e5-40cd-bb7f-0426c3b5674b', 5, NULL, 'Wahre, wahre deinen Sohn', 'Wahre, wahre deinen Sohn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97942ec1-a6e5-40cd-bb7f-0426c3b5674b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Rosen steckt mir an die Mutter', part.name_en = 'Rosen steckt mir an die Mutter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:840f70ff-b253-4f85-8f73-06e72a582c50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:840f70ff-b253-4f85-8f73-06e72a582c50', 6, NULL, 'Rosen steckt mir an die Mutter', 'Rosen steckt mir an die Mutter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:840f70ff-b253-4f85-8f73-06e72a582c50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vom Gebirge Well'' auf Well''', part.name_en = 'Vom Gebirge Well'' auf Well''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ce344ad6-c422-47b9-9225-fa0255d36b58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce344ad6-c422-47b9-9225-fa0255d36b58', 7, NULL, 'Vom Gebirge Well'' auf Well''', 'Vom Gebirge Well'' auf Well''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce344ad6-c422-47b9-9225-fa0255d36b58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Weiche Gräser im Revier', part.name_en = 'Weiche Gräser im Revier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0cc2b843-353c-471a-8f62-36e2f86fc27b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cc2b843-353c-471a-8f62-36e2f86fc27b', 8, NULL, 'Weiche Gräser im Revier', 'Weiche Gräser im Revier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cc2b843-353c-471a-8f62-36e2f86fc27b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Nagen am Herzen fühl ich', part.name_en = 'Nagen am Herzen fühl ich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2faabc53-4cbe-4bfc-8863-7b75645fc04e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2faabc53-4cbe-4bfc-8863-7b75645fc04e', 9, NULL, 'Nagen am Herzen fühl ich', 'Nagen am Herzen fühl ich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2faabc53-4cbe-4bfc-8863-7b75645fc04e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Ich kose süss mit der und der', part.name_en = 'Ich kose süss mit der und der',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e0904f2e-9378-4fb6-a696-96758f027f85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0904f2e-9378-4fb6-a696-96758f027f85', 10, NULL, 'Ich kose süss mit der und der', 'Ich kose süss mit der und der', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0904f2e-9378-4fb6-a696-96758f027f85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Alles, alles in den Wind', part.name_en = 'Alles, alles in den Wind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b3acafe3-e4a1-48ec-aec9-fac867f6dbb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3acafe3-e4a1-48ec-aec9-fac867f6dbb0', 11, NULL, 'Alles, alles in den Wind', 'Alles, alles in den Wind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3acafe3-e4a1-48ec-aec9-fac867f6dbb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Schwarzer Wald', part.name_en = 'Schwarzer Wald',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ad3c8d5f-2620-4973-be66-6ab3cfa21a5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad3c8d5f-2620-4973-be66-6ab3cfa21a5b', 12, NULL, 'Schwarzer Wald', 'Schwarzer Wald', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad3c8d5f-2620-4973-be66-6ab3cfa21a5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Nein, Geliebter, setze dich', part.name_en = 'Nein, Geliebter, setze dich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f61fcb66-2530-4e3b-b83c-95ab97010d1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f61fcb66-2530-4e3b-b83c-95ab97010d1e', 13, NULL, 'Nein, Geliebter, setze dich', 'Nein, Geliebter, setze dich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f61fcb66-2530-4e3b-b83c-95ab97010d1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Flammenauge, dunkles Haar', part.name_en = 'Flammenauge, dunkles Haar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:55ba55c7-aafa-4d31-9b7a-9cf0609f57c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55ba55c7-aafa-4d31-9b7a-9cf0609f57c5', 14, NULL, 'Flammenauge, dunkles Haar', 'Flammenauge, dunkles Haar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ba55c7-aafa-4d31-9b7a-9cf0609f57c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Nun, ihr Musen, genug!', part.name_en = 'Nun, ihr Musen, genug!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11691 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a19f0d64-0140-4319-9796-ee216783fece' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a19f0d64-0140-4319-9796-ee216783fece', 15, NULL, 'Nun, ihr Musen, genug!', 'Nun, ihr Musen, genug!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11691 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a19f0d64-0140-4319-9796-ee216783fece'
);


-- Op. 34b 두 대의 피아노를 위한 소나타 F단조

UPDATE pieces piece
SET piece.title = '두 대의 피아노를 위한 소나타 F단조', piece.title_en = 'Sonata for Two Pianos in F minor',
    piece.type = 'album', piece.opus_number = 'Op. 34b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11726 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 11726 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11726 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:dcf312bc-7288-3d22-af15-e656ff7ee251' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcf312bc-7288-3d22-af15-e656ff7ee251', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11726 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf312bc-7288-3d22-af15-e656ff7ee251'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante, un poco adagio', part.name_en = 'II. Andante, un poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11726 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:293730b8-9301-3971-b9d3-795ca2095753' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:293730b8-9301-3971-b9d3-795ca2095753', 2, 'II', 'Andante, un poco adagio', 'II. Andante, un poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11726 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:293730b8-9301-3971-b9d3-795ca2095753'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Allegro', part.name_en = 'III. Scherzo. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11726 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:26eda0f2-3368-3cce-be5f-aaf47a8c711c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26eda0f2-3368-3cce-be5f-aaf47a8c711c', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11726 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26eda0f2-3368-3cce-be5f-aaf47a8c711c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Poco sostenuto – Allegro non troppo – Presto, non troppo', part.name_en = 'IV. Finale. Poco sostenuto – Allegro non troppo – Presto, non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11726 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3e3b4068-d728-3811-a493-4c5ca88c64bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e3b4068-d728-3811-a493-4c5ca88c64bb', 4, 'IV', '피날레. Poco sostenuto – Allegro non troppo – Presto, non troppo', 'IV. Finale. Poco sostenuto – Allegro non troppo – Presto, non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11726 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e3b4068-d728-3811-a493-4c5ca88c64bb'
);


-- Op. 56b 두 대의 피아노를 위한 하이든 주제에 의한 변주곡

UPDATE pieces piece
SET piece.title = '두 대의 피아노를 위한 하이든 주제에 의한 변주곡', piece.title_en = 'Variations on a Theme by Haydn, for two pianos',
    piece.type = 'song', piece.opus_number = 'Op. 56b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11677 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 11677 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 7 코랄 전주곡과 푸가 <O Traurigkeit, o Herzeleid> A♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코랄 전주곡과 푸가 <O Traurigkeit, o Herzeleid> A♭단조', 'Chorale Prelude and Fugue on "O Traurigkeit, o Herzeleid" in A♭ minor', 'album', 'WoO 7', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코랄 전주곡과 푸가 <O Traurigkeit, o Herzeleid> A♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b903135-4854-454e-b553-d5640a081567'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b903135-4854-454e-b553-d5640a081567'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '코랄 전주곡과 푸가 <O Traurigkeit, o Herzeleid> A♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b903135-4854-454e-b553-d5640a081567'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e58bdf6d-16e1-3c77-87f6-6e88f99a3028', 1, NULL, '코랄 전주곡. Poco adagio', 'I. Chorale Prelude. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '코랄 전주곡과 푸가 <O Traurigkeit, o Herzeleid> A♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e58bdf6d-16e1-3c77-87f6-6e88f99a3028'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f6b817f-8ca4-3c18-b334-ad5c1a24d7a0', 2, NULL, '푸가. Adagio', 'II. Fugue. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '코랄 전주곡과 푸가 <O Traurigkeit, o Herzeleid> A♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f6b817f-8ca4-3c18-b334-ad5c1a24d7a0'
);


-- WoO 8 오르간 푸가 A♭단조

UPDATE pieces piece
SET piece.title = '오르간 푸가 A♭단조', piece.title_en = 'Fugue in A♭ minor for organ',
    piece.type = 'song', piece.opus_number = 'WoO 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1856, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11341 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1856
WHERE piece.id = 11341 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 9 오르간 전주곡과 푸가 A단조

UPDATE pieces piece
SET piece.title = '오르간 전주곡과 푸가 A단조', piece.title_en = 'Prelude and Fugue in A minor for organ',
    piece.type = 'album', piece.opus_number = 'WoO 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1856, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11880 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1856
WHERE piece.id = 11880 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡. Allegro', part.name_en = 'I. Prelude. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11880 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:334dd365-93c4-3815-8f2c-0f7072551ea5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:334dd365-93c4-3815-8f2c-0f7072551ea5', 1, NULL, '전주곡. Allegro', 'I. Prelude. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11880 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:334dd365-93c4-3815-8f2c-0f7072551ea5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11880 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:becefb57-9beb-35ef-84bf-81c578210ea3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:becefb57-9beb-35ef-84bf-81c578210ea3', 2, NULL, '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11880 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:becefb57-9beb-35ef-84bf-81c578210ea3'
);


-- WoO 10 오르간 전주곡과 푸가 G단조

UPDATE pieces piece
SET piece.title = '오르간 전주곡과 푸가 G단조', piece.title_en = 'Prelude and Fugue in G minor for organ',
    piece.type = 'album', piece.opus_number = 'WoO 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1857, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11612 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1857
WHERE piece.id = 11612 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡. Allegro di molto', part.name_en = 'I. Prelude. Allegro di molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11612 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7698e5d3-fcc8-3de0-bcea-7a80c094fe96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7698e5d3-fcc8-3de0-bcea-7a80c094fe96', 1, NULL, '전주곡. Allegro di molto', 'I. Prelude. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11612 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7698e5d3-fcc8-3de0-bcea-7a80c094fe96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가. Tempo giusto', part.name_en = 'II. Fugue. Tempo giusto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11612 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:260d4ab2-63e0-3949-a073-3976b14020f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:260d4ab2-63e0-3949-a073-3976b14020f0', 2, NULL, '푸가. Tempo giusto', 'II. Fugue. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11612 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:260d4ab2-63e0-3949-a073-3976b14020f0'
);


-- Op. 122 11개의 코랄 전주곡 Op. 122

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '11개의 코랄 전주곡 Op. 122', '11 Chorale Preludes, Op. 122', 'album', NULL, 'Op.', '122', 1896, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '11개의 코랄 전주곡 Op. 122'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94bd1737-449a-4f6a-8257-0ab5e8937a0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94bd1737-449a-4f6a-8257-0ab5e8937a0f'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94bd1737-449a-4f6a-8257-0ab5e8937a0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dadb3a0-ec95-3268-b6e9-d8519343eb0c', 1, NULL, 'Mein Jesu, der du mich', 'Mein Jesu, der du mich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dadb3a0-ec95-3268-b6e9-d8519343eb0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03d7c55d-8fb3-3230-93d4-6b781250b950', 2, NULL, 'Herzliebster Jesu, was hast du verbrochen', 'Herzliebster Jesu, was hast du verbrochen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d7c55d-8fb3-3230-93d4-6b781250b950'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:528591e6-78d1-3f29-9294-2c6ab5630caf', 3, NULL, 'O Welt, ich muss dich lassen (1)', 'O Welt, ich muss dich lassen (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:528591e6-78d1-3f29-9294-2c6ab5630caf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1022387b-d319-331e-a22e-6c2d5138402c', 4, NULL, 'Herzlich tut mich erfreuen', 'Herzlich tut mich erfreuen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1022387b-d319-331e-a22e-6c2d5138402c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfb74b8d-7789-3b4a-8c61-7a73d0eb767a', 5, NULL, 'Schmücke dich, o liebe Seele', 'Schmücke dich, o liebe Seele', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfb74b8d-7789-3b4a-8c61-7a73d0eb767a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7752bfd4-1101-35af-9c60-7bfe994b4063', 6, NULL, 'O wie selig seid ihr doch, ihr Frommen', 'O wie selig seid ihr doch, ihr Frommen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7752bfd4-1101-35af-9c60-7bfe994b4063'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7df870af-481d-3ff1-b93a-3122a06d6703', 7, NULL, 'O Gott, du frommer Gott', 'O Gott, du frommer Gott', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7df870af-481d-3ff1-b93a-3122a06d6703'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34847216-7472-3e23-bb16-3c9cb7341f24', 8, NULL, 'Es ist ein Ros entsprungen', 'Es ist ein Ros entsprungen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34847216-7472-3e23-bb16-3c9cb7341f24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03a17b6d-3d74-34af-a9de-92f7a89337ab', 9, NULL, 'Herzlich tut mich verlangen (1)', 'Herzlich tut mich verlangen (1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a17b6d-3d74-34af-a9de-92f7a89337ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8394fd04-88e2-3ed1-b777-234fb245d22b', 10, NULL, 'Herzlich tut mich verlangen (2)', 'Herzlich tut mich verlangen (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8394fd04-88e2-3ed1-b777-234fb245d22b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d4cf352-fb89-3b0a-a323-d2a03d192638', 11, NULL, 'O Welt, ich muss dich lassen (2)', 'O Welt, ich muss dich lassen (2)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '11개의 코랄 전주곡 Op. 122' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d4cf352-fb89-3b0a-a323-d2a03d192638'
);


-- Op. 3 6개의 노래 Op. 3

UPDATE pieces piece
SET piece.title = '6개의 노래 Op. 3', piece.title_en = '6 Gesänge, Op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11479 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 11479 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Liebestreu', part.name_en = 'Liebestreu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11479 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8a23137c-eabf-38f5-bd69-30fde17355db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a23137c-eabf-38f5-bd69-30fde17355db', 1, NULL, 'Liebestreu', 'Liebestreu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11479 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a23137c-eabf-38f5-bd69-30fde17355db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Liebe und Frühling I', part.name_en = 'Liebe und Frühling I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11479 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b84970d8-4e7a-3f5f-8935-ceff44e98ce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b84970d8-4e7a-3f5f-8935-ceff44e98ce5', 2, NULL, 'Liebe und Frühling I', 'Liebe und Frühling I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11479 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b84970d8-4e7a-3f5f-8935-ceff44e98ce5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Liebe und Frühling II', part.name_en = 'Liebe und Frühling II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11479 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d6b9b51b-18d6-36a8-9eae-8dad8e33a7b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6b9b51b-18d6-36a8-9eae-8dad8e33a7b0', 3, NULL, 'Liebe und Frühling II', 'Liebe und Frühling II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11479 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6b9b51b-18d6-36a8-9eae-8dad8e33a7b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Lied aus dem Gedicht „Ivan“', part.name_en = 'Lied aus dem Gedicht „Ivan“',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11479 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6cfb0493-f91a-3982-9ce4-f93a8bba5e05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cfb0493-f91a-3982-9ce4-f93a8bba5e05', 4, NULL, 'Lied aus dem Gedicht „Ivan“', 'Lied aus dem Gedicht „Ivan“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11479 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cfb0493-f91a-3982-9ce4-f93a8bba5e05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'In der Fremde', part.name_en = 'In der Fremde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11479 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bbbffc58-42f0-3dfe-891e-a228251945f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbbffc58-42f0-3dfe-891e-a228251945f7', 5, NULL, 'In der Fremde', 'In der Fremde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11479 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbbffc58-42f0-3dfe-891e-a228251945f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Lied', part.name_en = 'Lied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11479 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:346df942-989d-339b-a000-4dbedabf6a64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:346df942-989d-339b-a000-4dbedabf6a64', 6, NULL, 'Lied', 'Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11479 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:346df942-989d-339b-a000-4dbedabf6a64'
);


-- Op. 6 6개의 노래 Op. 6

UPDATE pieces piece
SET piece.title = '6개의 노래 Op. 6', piece.title_en = '6 Gesänge, Op. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '6',
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11807 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 11807 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Spanisches Lied', part.name_en = 'Spanisches Lied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11807 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:be799717-e4b5-391a-9cb0-345c9fe1ad45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be799717-e4b5-391a-9cb0-345c9fe1ad45', 1, NULL, 'Spanisches Lied', 'Spanisches Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11807 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be799717-e4b5-391a-9cb0-345c9fe1ad45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Der Frühling', part.name_en = 'Der Frühling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11807 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:719eb50d-148f-33e3-a9e9-f0dc1659e369' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:719eb50d-148f-33e3-a9e9-f0dc1659e369', 2, NULL, 'Der Frühling', 'Der Frühling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11807 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:719eb50d-148f-33e3-a9e9-f0dc1659e369'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nachwirkung', part.name_en = 'Nachwirkung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11807 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7b8c2df7-ceec-3d5f-9fd7-bf480c9d8667' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b8c2df7-ceec-3d5f-9fd7-bf480c9d8667', 3, NULL, 'Nachwirkung', 'Nachwirkung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11807 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b8c2df7-ceec-3d5f-9fd7-bf480c9d8667'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Juchhe!', part.name_en = 'Juchhe!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11807 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:81358331-68be-3e7f-a0e6-b233d3cc69fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81358331-68be-3e7f-a0e6-b233d3cc69fc', 4, NULL, 'Juchhe!', 'Juchhe!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11807 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81358331-68be-3e7f-a0e6-b233d3cc69fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Wie die Wolke nach der Sonne', part.name_en = 'Wie die Wolke nach der Sonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11807 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:71027bff-a234-3bd2-baec-fe31b8691858' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71027bff-a234-3bd2-baec-fe31b8691858', 5, NULL, 'Wie die Wolke nach der Sonne', 'Wie die Wolke nach der Sonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11807 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71027bff-a234-3bd2-baec-fe31b8691858'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Nachtigallen schwingen', part.name_en = 'Nachtigallen schwingen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11807 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1204b7e9-9c43-3082-9d66-0baf1fd4a8c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1204b7e9-9c43-3082-9d66-0baf1fd4a8c3', 6, NULL, 'Nachtigallen schwingen', 'Nachtigallen schwingen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11807 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1204b7e9-9c43-3082-9d66-0baf1fd4a8c3'
);


-- Op. 7 6개의 노래 Op. 7

UPDATE pieces piece
SET piece.title = '6개의 노래 Op. 7', piece.title_en = '6 Gesänge, Op. 7',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '7',
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11572 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 11572 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Treue Liebe', part.name_en = 'Treue Liebe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11572 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4f6180b6-9602-3e79-9fe5-5a7581abc8d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f6180b6-9602-3e79-9fe5-5a7581abc8d9', 1, NULL, 'Treue Liebe', 'Treue Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11572 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f6180b6-9602-3e79-9fe5-5a7581abc8d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Parole', part.name_en = 'Parole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11572 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0a366bc3-ebc1-34e4-8e8b-8f16bd27d7aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a366bc3-ebc1-34e4-8e8b-8f16bd27d7aa', 2, NULL, 'Parole', 'Parole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11572 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a366bc3-ebc1-34e4-8e8b-8f16bd27d7aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Anklänge', part.name_en = 'Anklänge',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11572 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:43f58fd2-dfc8-348c-87aa-6f897bd60c27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43f58fd2-dfc8-348c-87aa-6f897bd60c27', 3, NULL, 'Anklänge', 'Anklänge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11572 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43f58fd2-dfc8-348c-87aa-6f897bd60c27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Volkslied', part.name_en = 'Volkslied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11572 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:38a60bd2-0674-3fcb-961e-d6595214ba71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38a60bd2-0674-3fcb-961e-d6595214ba71', 4, NULL, 'Volkslied', 'Volkslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11572 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38a60bd2-0674-3fcb-961e-d6595214ba71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Die Trauernde', part.name_en = 'Die Trauernde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11572 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:71677dbf-fe62-3798-b912-8c0a9364f40c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71677dbf-fe62-3798-b912-8c0a9364f40c', 5, NULL, 'Die Trauernde', 'Die Trauernde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11572 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71677dbf-fe62-3798-b912-8c0a9364f40c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Heimkehr', part.name_en = 'Heimkehr',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11572 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bc636b71-8e5b-3328-8f58-b7dcb73e4478' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc636b71-8e5b-3328-8f58-b7dcb73e4478', 6, NULL, 'Heimkehr', 'Heimkehr', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11572 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc636b71-8e5b-3328-8f58-b7dcb73e4478'
);


-- WoO 21 가곡 <Mondnacht>

UPDATE pieces piece
SET piece.title = '가곡 <Mondnacht>', piece.title_en = 'Mondnacht',
    piece.type = 'song', piece.opus_number = 'WoO 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11746 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 11746 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 27 카논 <Spruch>

UPDATE pieces piece
SET piece.title = '카논 <Spruch>', piece.title_en = 'Spruch (canon for voice and viola)',
    piece.type = 'song', piece.opus_number = 'WoO 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11705 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 11705 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 14 8개의 가곡과 로망스 Op. 14

UPDATE pieces piece
SET piece.title = '8개의 가곡과 로망스 Op. 14', piece.title_en = '8 Lieder und Romanzen, Op. 14',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '14',
    piece.composition_year = COALESCE(1858, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11484 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1858
WHERE piece.id = 11484 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vor dem Fenster', part.name_en = 'Vor dem Fenster',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11484 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:978717e4-e266-333f-b3cc-cad12887281b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:978717e4-e266-333f-b3cc-cad12887281b', 1, NULL, 'Vor dem Fenster', 'Vor dem Fenster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11484 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:978717e4-e266-333f-b3cc-cad12887281b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vom verwundeten Knaben', part.name_en = 'Vom verwundeten Knaben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11484 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:85f8751a-e358-33fc-82fe-1f65573d12d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85f8751a-e358-33fc-82fe-1f65573d12d4', 2, NULL, 'Vom verwundeten Knaben', 'Vom verwundeten Knaben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11484 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85f8751a-e358-33fc-82fe-1f65573d12d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Murrays Ermordung', part.name_en = 'Murrays Ermordung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11484 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3760e9f7-5903-3c77-bb8a-8f27e80d736e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3760e9f7-5903-3c77-bb8a-8f27e80d736e', 3, NULL, 'Murrays Ermordung', 'Murrays Ermordung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11484 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3760e9f7-5903-3c77-bb8a-8f27e80d736e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ein Sonett', part.name_en = 'Ein Sonett',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11484 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4c4c6203-4b9f-386a-8882-cad1d829c927' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c4c6203-4b9f-386a-8882-cad1d829c927', 4, NULL, 'Ein Sonett', 'Ein Sonett', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11484 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c4c6203-4b9f-386a-8882-cad1d829c927'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Trennung', part.name_en = 'Trennung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11484 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bcae9972-a8ad-3647-aedf-47cc5c698961' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcae9972-a8ad-3647-aedf-47cc5c698961', 5, NULL, 'Trennung', 'Trennung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11484 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcae9972-a8ad-3647-aedf-47cc5c698961'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gang zur Liebsten', part.name_en = 'Gang zur Liebsten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11484 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:64fc2016-d8f4-3c5e-93af-0578f0042825' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64fc2016-d8f4-3c5e-93af-0578f0042825', 6, NULL, 'Gang zur Liebsten', 'Gang zur Liebsten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11484 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64fc2016-d8f4-3c5e-93af-0578f0042825'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ständchen', part.name_en = 'Ständchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11484 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c8887610-8347-3629-82b8-75ca82c971c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8887610-8347-3629-82b8-75ca82c971c8', 7, NULL, 'Ständchen', 'Ständchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11484 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8887610-8347-3629-82b8-75ca82c971c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Sehnsucht', part.name_en = 'Sehnsucht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11484 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3964de29-491c-36ca-8830-6ac804071965' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3964de29-491c-36ca-8830-6ac804071965', 8, NULL, 'Sehnsucht', 'Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11484 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3964de29-491c-36ca-8830-6ac804071965'
);


-- Op. 19 5개의 시 Op. 19

UPDATE pieces piece
SET piece.title = '5개의 시 Op. 19', piece.title_en = '5 Gedichte, Op. 19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '19',
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11514 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 11514 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der Kuss', part.name_en = 'Der Kuss',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11514 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6b29bd9e-244b-3041-95b5-9f447c2e4a95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b29bd9e-244b-3041-95b5-9f447c2e4a95', 1, NULL, 'Der Kuss', 'Der Kuss', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11514 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b29bd9e-244b-3041-95b5-9f447c2e4a95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scheiden und Meiden', part.name_en = 'Scheiden und Meiden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11514 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0686073b-a9ca-37dd-8fd9-4dbdea17ab2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0686073b-a9ca-37dd-8fd9-4dbdea17ab2f', 2, NULL, 'Scheiden und Meiden', 'Scheiden und Meiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11514 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0686073b-a9ca-37dd-8fd9-4dbdea17ab2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'In der Ferne', part.name_en = 'In der Ferne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11514 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5230e69c-73a5-332a-ad6d-5230016417b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5230e69c-73a5-332a-ad6d-5230016417b1', 3, NULL, 'In der Ferne', 'In der Ferne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11514 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5230e69c-73a5-332a-ad6d-5230016417b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der Schmied', part.name_en = 'Der Schmied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11514 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5a136322-bc3f-3093-99f8-44758f272081' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a136322-bc3f-3093-99f8-44758f272081', 4, NULL, 'Der Schmied', 'Der Schmied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11514 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a136322-bc3f-3093-99f8-44758f272081'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'An eine Äolsharfe', part.name_en = 'An eine Äolsharfe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11514 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3d43a258-4fd8-3b12-ba14-fec7f6024782' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d43a258-4fd8-3b12-ba14-fec7f6024782', 5, NULL, 'An eine Äolsharfe', 'An eine Äolsharfe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11514 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d43a258-4fd8-3b12-ba14-fec7f6024782'
);


-- Op. 33 연가곡집 <아름다운 마겔로네>

UPDATE pieces piece
SET piece.title = '연가곡집 <아름다운 마겔로네>', piece.title_en = 'Romanzen aus L. Tiecks "Magelone" (Magelone Romances)',
    piece.type = 'album', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11961 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 11961 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Keinen hat es noch gereut', part.name_en = 'Keinen hat es noch gereut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8851cf50-5938-3ed8-ab8a-425059a670ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8851cf50-5938-3ed8-ab8a-425059a670ba', 1, NULL, 'Keinen hat es noch gereut', 'Keinen hat es noch gereut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8851cf50-5938-3ed8-ab8a-425059a670ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Traun! Bogen und Pfeil sind gut für den Feind', part.name_en = 'Traun! Bogen und Pfeil sind gut für den Feind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:202a92d5-41c9-3732-9a2f-2809dc6089e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:202a92d5-41c9-3732-9a2f-2809dc6089e4', 2, NULL, 'Traun! Bogen und Pfeil sind gut für den Feind', 'Traun! Bogen und Pfeil sind gut für den Feind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:202a92d5-41c9-3732-9a2f-2809dc6089e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sind es Schmerzen, sind es Freuden', part.name_en = 'Sind es Schmerzen, sind es Freuden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a3d02cc1-d644-384a-a441-ca0f64ea2982' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3d02cc1-d644-384a-a441-ca0f64ea2982', 3, NULL, 'Sind es Schmerzen, sind es Freuden', 'Sind es Schmerzen, sind es Freuden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3d02cc1-d644-384a-a441-ca0f64ea2982'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Liebe kam aus fernen Landen', part.name_en = 'Liebe kam aus fernen Landen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e45e310a-a8a1-3498-9cfb-56103fc346e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e45e310a-a8a1-3498-9cfb-56103fc346e3', 4, NULL, 'Liebe kam aus fernen Landen', 'Liebe kam aus fernen Landen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e45e310a-a8a1-3498-9cfb-56103fc346e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'So willst du des Armen dich gnädig erbarmen?', part.name_en = 'So willst du des Armen dich gnädig erbarmen?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b51dc084-4502-3d71-92e2-e963283383fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b51dc084-4502-3d71-92e2-e963283383fd', 5, NULL, 'So willst du des Armen dich gnädig erbarmen?', 'So willst du des Armen dich gnädig erbarmen?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b51dc084-4502-3d71-92e2-e963283383fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Wie soll ich die Freude, die Wonne denn tragen?', part.name_en = 'Wie soll ich die Freude, die Wonne denn tragen?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:dc869fe5-e6f0-34fa-8de5-0774e3b059d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc869fe5-e6f0-34fa-8de5-0774e3b059d2', 6, NULL, 'Wie soll ich die Freude, die Wonne denn tragen?', 'Wie soll ich die Freude, die Wonne denn tragen?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc869fe5-e6f0-34fa-8de5-0774e3b059d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'War es dir, dem diese Lippen bebten?', part.name_en = 'War es dir, dem diese Lippen bebten?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e67b9ddf-dee8-3a79-87e6-29e32e875f12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e67b9ddf-dee8-3a79-87e6-29e32e875f12', 7, NULL, 'War es dir, dem diese Lippen bebten?', 'War es dir, dem diese Lippen bebten?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e67b9ddf-dee8-3a79-87e6-29e32e875f12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Wir müssen uns trennen, geliebtes Saitenspiel', part.name_en = 'Wir müssen uns trennen, geliebtes Saitenspiel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8b389719-7d53-3d10-9ec0-e2febd828775' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b389719-7d53-3d10-9ec0-e2febd828775', 8, NULL, 'Wir müssen uns trennen, geliebtes Saitenspiel', 'Wir müssen uns trennen, geliebtes Saitenspiel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b389719-7d53-3d10-9ec0-e2febd828775'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ruhe, Süßliebchen, im Schatten', part.name_en = 'Ruhe, Süßliebchen, im Schatten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2edbc033-4b4c-30c5-8498-2ffd351fb7f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2edbc033-4b4c-30c5-8498-2ffd351fb7f8', 9, NULL, 'Ruhe, Süßliebchen, im Schatten', 'Ruhe, Süßliebchen, im Schatten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2edbc033-4b4c-30c5-8498-2ffd351fb7f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Verzweiflung (So tönet denn, schäumende Wellen)', part.name_en = 'Verzweiflung (So tönet denn, schäumende Wellen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:46d79257-51ba-3147-b59b-45eb4c7cb19a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46d79257-51ba-3147-b59b-45eb4c7cb19a', 10, NULL, 'Verzweiflung (So tönet denn, schäumende Wellen)', 'Verzweiflung (So tönet denn, schäumende Wellen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46d79257-51ba-3147-b59b-45eb4c7cb19a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Wie schnell verschwindet so Licht als Glanz', part.name_en = 'Wie schnell verschwindet so Licht als Glanz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1e7621b2-2a52-3b6f-9b09-4f7acc336c1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e7621b2-2a52-3b6f-9b09-4f7acc336c1e', 11, NULL, 'Wie schnell verschwindet so Licht als Glanz', 'Wie schnell verschwindet so Licht als Glanz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e7621b2-2a52-3b6f-9b09-4f7acc336c1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Muß es eine Trennung geben', part.name_en = 'Muß es eine Trennung geben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:99e89c51-c184-35a1-8d2c-e98d9174f246' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99e89c51-c184-35a1-8d2c-e98d9174f246', 12, NULL, 'Muß es eine Trennung geben', 'Muß es eine Trennung geben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99e89c51-c184-35a1-8d2c-e98d9174f246'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Sulima (Geliebter, wo zaudert dein irrender Fuß)', part.name_en = 'Sulima (Geliebter, wo zaudert dein irrender Fuß)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:62831e6f-ba48-31c3-8a84-8e5e72f0667a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62831e6f-ba48-31c3-8a84-8e5e72f0667a', 13, NULL, 'Sulima (Geliebter, wo zaudert dein irrender Fuß)', 'Sulima (Geliebter, wo zaudert dein irrender Fuß)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62831e6f-ba48-31c3-8a84-8e5e72f0667a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Wie froh und frisch mein Sinn sich hebt', part.name_en = 'Wie froh und frisch mein Sinn sich hebt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b4dc5ac0-5ed0-31d9-b1b5-7000126767bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4dc5ac0-5ed0-31d9-b1b5-7000126767bf', 14, NULL, 'Wie froh und frisch mein Sinn sich hebt', 'Wie froh und frisch mein Sinn sich hebt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4dc5ac0-5ed0-31d9-b1b5-7000126767bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Treue Liebe dauert lange', part.name_en = 'Treue Liebe dauert lange',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11961 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f096072c-b61d-3904-8f38-6a560903a108' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f096072c-b61d-3904-8f38-6a560903a108', 15, NULL, 'Treue Liebe dauert lange', 'Treue Liebe dauert lange', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11961 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f096072c-b61d-3904-8f38-6a560903a108'
);


-- Op. 32 9개의 가곡과 노래 Op. 32

UPDATE pieces piece
SET piece.title = '9개의 가곡과 노래 Op. 32', piece.title_en = '9 Lieder und Gesänge, Op. 32',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '32',
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11947 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 11947 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Wie rafft'' ich mich auf in der Nacht', part.name_en = 'Wie rafft'' ich mich auf in der Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fda1492a-d610-3410-92ea-b8214e5a06b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fda1492a-d610-3410-92ea-b8214e5a06b2', 1, NULL, 'Wie rafft'' ich mich auf in der Nacht', 'Wie rafft'' ich mich auf in der Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fda1492a-d610-3410-92ea-b8214e5a06b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nicht mehr zu dir zu gehen', part.name_en = 'Nicht mehr zu dir zu gehen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4899365b-cbb7-3c33-a89f-8bdb142b5048' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4899365b-cbb7-3c33-a89f-8bdb142b5048', 2, NULL, 'Nicht mehr zu dir zu gehen', 'Nicht mehr zu dir zu gehen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4899365b-cbb7-3c33-a89f-8bdb142b5048'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ich schleich'' umher', part.name_en = 'Ich schleich'' umher',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ed51108d-9b20-3de9-a9c1-79b794781cf7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed51108d-9b20-3de9-a9c1-79b794781cf7', 3, NULL, 'Ich schleich'' umher', 'Ich schleich'' umher', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed51108d-9b20-3de9-a9c1-79b794781cf7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der Strom, der neben mir verrauschte', part.name_en = 'Der Strom, der neben mir verrauschte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:dd4c8982-3794-3ed7-93ea-dec264c0433f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd4c8982-3794-3ed7-93ea-dec264c0433f', 4, NULL, 'Der Strom, der neben mir verrauschte', 'Der Strom, der neben mir verrauschte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd4c8982-3794-3ed7-93ea-dec264c0433f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Wehe, so willst du mich wieder', part.name_en = 'Wehe, so willst du mich wieder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:350492f1-1a1e-33db-8e84-919e56ae290d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:350492f1-1a1e-33db-8e84-919e56ae290d', 5, NULL, 'Wehe, so willst du mich wieder', 'Wehe, so willst du mich wieder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:350492f1-1a1e-33db-8e84-919e56ae290d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Du sprichst, daß ich mich täuschte', part.name_en = 'Du sprichst, daß ich mich täuschte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0bf9f264-41bf-37f5-877e-2034322e4949' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bf9f264-41bf-37f5-877e-2034322e4949', 6, NULL, 'Du sprichst, daß ich mich täuschte', 'Du sprichst, daß ich mich täuschte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bf9f264-41bf-37f5-877e-2034322e4949'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Bitteres zu sagen denkst du', part.name_en = 'Bitteres zu sagen denkst du',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b93618f6-3f1c-31fc-adab-3bd71f397db6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b93618f6-3f1c-31fc-adab-3bd71f397db6', 7, NULL, 'Bitteres zu sagen denkst du', 'Bitteres zu sagen denkst du', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b93618f6-3f1c-31fc-adab-3bd71f397db6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'So stehn wir, ich und meine Weide', part.name_en = 'So stehn wir, ich und meine Weide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ebdec098-a7fc-3a65-a018-dc110aab5685' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebdec098-a7fc-3a65-a018-dc110aab5685', 8, NULL, 'So stehn wir, ich und meine Weide', 'So stehn wir, ich und meine Weide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebdec098-a7fc-3a65-a018-dc110aab5685'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Wie bist du, meine Königin', part.name_en = 'Wie bist du, meine Königin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11947 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3f764415-c2c1-3dc4-b3d2-1cf66214508b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f764415-c2c1-3dc4-b3d2-1cf66214508b', 9, NULL, 'Wie bist du, meine Königin', 'Wie bist du, meine Königin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11947 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f764415-c2c1-3dc4-b3d2-1cf66214508b'
);


-- Op. 43 4개의 노래 Op. 43

UPDATE pieces piece
SET piece.title = '4개의 노래 Op. 43', piece.title_en = '4 Gesänge, Op. 43',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '43',
    piece.composition_year = COALESCE(1866, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11473 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1866
WHERE piece.id = 11473 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '영원한 사랑 (Von ewiger Liebe)', part.name_en = 'Von ewiger Liebe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11473 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:df0bda80-83a7-3f54-acee-d8a8c0c3a5e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df0bda80-83a7-3f54-acee-d8a8c0c3a5e7', 1, NULL, '영원한 사랑 (Von ewiger Liebe)', 'Von ewiger Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11473 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df0bda80-83a7-3f54-acee-d8a8c0c3a5e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '5월의 밤 (Die Mainacht)', part.name_en = 'Die Mainacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11473 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:40ded9eb-b9fd-3f43-935b-c8ab8416ce24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40ded9eb-b9fd-3f43-935b-c8ab8416ce24', 2, NULL, '5월의 밤 (Die Mainacht)', 'Die Mainacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11473 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40ded9eb-b9fd-3f43-935b-c8ab8416ce24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ich schell'' mein Horn ins Jammertal', part.name_en = 'Ich schell'' mein Horn ins Jammertal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11473 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:92487552-5e30-35d5-a7dd-c06571051889' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92487552-5e30-35d5-a7dd-c06571051889', 3, NULL, 'Ich schell'' mein Horn ins Jammertal', 'Ich schell'' mein Horn ins Jammertal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11473 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92487552-5e30-35d5-a7dd-c06571051889'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Das Lied vom Herrn von Falkenstein', part.name_en = 'Das Lied vom Herrn von Falkenstein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11473 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3fc8381d-d0e7-38ed-b5ab-b0cb0fb1c8b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fc8381d-d0e7-38ed-b5ab-b0cb0fb1c8b2', 4, NULL, 'Das Lied vom Herrn von Falkenstein', 'Das Lied vom Herrn von Falkenstein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11473 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fc8381d-d0e7-38ed-b5ab-b0cb0fb1c8b2'
);


-- Op. 46 4개의 노래 Op. 46

UPDATE pieces piece
SET piece.title = '4개의 노래 Op. 46', piece.title_en = '4 Gesänge, Op. 46',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '46',
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11972 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 11972 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Die Kränze', part.name_en = 'Die Kränze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11972 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f0cd51d9-95d0-3f44-a403-f5698188ade6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0cd51d9-95d0-3f44-a403-f5698188ade6', 1, NULL, 'Die Kränze', 'Die Kränze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11972 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0cd51d9-95d0-3f44-a403-f5698188ade6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Magyarisch', part.name_en = 'Magyarisch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11972 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f13f18d0-d621-39a6-a2ff-90517cf3c8c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f13f18d0-d621-39a6-a2ff-90517cf3c8c6', 2, NULL, 'Magyarisch', 'Magyarisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11972 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f13f18d0-d621-39a6-a2ff-90517cf3c8c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Die Schale der Vergessenheit', part.name_en = 'Die Schale der Vergessenheit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11972 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1d459bbc-9e16-3b91-81e3-60f8868c2c91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d459bbc-9e16-3b91-81e3-60f8868c2c91', 3, NULL, 'Die Schale der Vergessenheit', 'Die Schale der Vergessenheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11972 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d459bbc-9e16-3b91-81e3-60f8868c2c91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'An die Nachtigall', part.name_en = 'An die Nachtigall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11972 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:15dcb30e-b21f-38ad-a24f-b4172ef87374' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15dcb30e-b21f-38ad-a24f-b4172ef87374', 4, NULL, 'An die Nachtigall', 'An die Nachtigall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11972 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15dcb30e-b21f-38ad-a24f-b4172ef87374'
);


-- Op. 47 5개의 가곡 Op. 47

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 47', piece.title_en = '5 Lieder, Op. 47',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '47',
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11399 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 11399 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Botschaft', part.name_en = 'Botschaft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11399 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2626e523-5e6f-3aa2-a0d5-47ce759d6210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2626e523-5e6f-3aa2-a0d5-47ce759d6210', 1, NULL, 'Botschaft', 'Botschaft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11399 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2626e523-5e6f-3aa2-a0d5-47ce759d6210'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Liebesglut', part.name_en = 'Liebesglut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11399 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:64ecd433-61a8-309b-828c-e315506a8cc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64ecd433-61a8-309b-828c-e315506a8cc2', 2, NULL, 'Liebesglut', 'Liebesglut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11399 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64ecd433-61a8-309b-828c-e315506a8cc2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sonntag', part.name_en = 'Sonntag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11399 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:25ab3758-3fe4-34fb-85a4-d8356e5890dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25ab3758-3fe4-34fb-85a4-d8356e5890dc', 3, NULL, 'Sonntag', 'Sonntag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11399 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25ab3758-3fe4-34fb-85a4-d8356e5890dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'O liebliche Wangen', part.name_en = 'O liebliche Wangen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11399 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:59b793c9-7379-3d2d-b743-55a729797e8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59b793c9-7379-3d2d-b743-55a729797e8f', 4, NULL, 'O liebliche Wangen', 'O liebliche Wangen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11399 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59b793c9-7379-3d2d-b743-55a729797e8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Die Liebende schreibt', part.name_en = 'Die Liebende schreibt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11399 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0503de7e-def3-3d94-b410-0ee43f566a88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0503de7e-def3-3d94-b410-0ee43f566a88', 5, NULL, 'Die Liebende schreibt', 'Die Liebende schreibt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11399 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0503de7e-def3-3d94-b410-0ee43f566a88'
);


-- Op. 48 7개의 가곡 Op. 48

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7개의 가곡 Op. 48', '7 Lieder, Op. 48', 'album', NULL, 'Op.', '48', 1868, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7개의 가곡 Op. 48'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '139af616-6c70-4976-9da9-e463d3cea9bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '139af616-6c70-4976-9da9-e463d3cea9bc'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '7개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '139af616-6c70-4976-9da9-e463d3cea9bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:253e91a1-dd70-3a49-af0c-6db4fa5b7aae', 1, NULL, 'Der Gang zum Liebchen', 'Der Gang zum Liebchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '7개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:253e91a1-dd70-3a49-af0c-6db4fa5b7aae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:164d323d-0e73-318e-b3b3-762e21a1eec0', 2, NULL, 'Der Überläufer', 'Der Überläufer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '7개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:164d323d-0e73-318e-b3b3-762e21a1eec0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df9a7498-d551-3d73-a3eb-ff95be13a262', 3, NULL, 'Liebesklage des Mädchens', 'Liebesklage des Mädchens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '7개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df9a7498-d551-3d73-a3eb-ff95be13a262'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a1890fa-c2e7-3811-b507-b95453b72efe', 4, NULL, 'Gold überwiegt die Liebe', 'Gold überwiegt die Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '7개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a1890fa-c2e7-3811-b507-b95453b72efe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85261d44-80d0-3802-b0ad-66e88cf3d9db', 5, NULL, 'Trost in Tränen', 'Trost in Tränen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '7개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85261d44-80d0-3802-b0ad-66e88cf3d9db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9100b59d-ac00-31a9-bcf4-0ac2dba812db', 6, NULL, 'Vergangen ist mir Glück und Heil', 'Vergangen ist mir Glück und Heil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '7개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9100b59d-ac00-31a9-bcf4-0ac2dba812db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e49a228a-9f8a-3b83-bfac-78eceffdbc86', 7, NULL, 'Herbstgefühl', 'Herbstgefühl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '7개의 가곡 Op. 48' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e49a228a-9f8a-3b83-bfac-78eceffdbc86'
);


-- Op. 49 5개의 가곡 Op. 49

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 49', piece.title_en = '5 Lieder, Op. 49',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '49',
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11345 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 11345 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Am Sonntag Morgen', part.name_en = 'Am Sonntag Morgen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11345 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d7d5a95c-4760-410a-a6ce-194661012048' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7d5a95c-4760-410a-a6ce-194661012048', 1, NULL, 'Am Sonntag Morgen', 'Am Sonntag Morgen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11345 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7d5a95c-4760-410a-a6ce-194661012048'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'An ein Veilchen', part.name_en = 'An ein Veilchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11345 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:29be314c-b902-4353-a2d2-1b39dc25f040' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29be314c-b902-4353-a2d2-1b39dc25f040', 2, NULL, 'An ein Veilchen', 'An ein Veilchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11345 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29be314c-b902-4353-a2d2-1b39dc25f040'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sehnsucht', part.name_en = 'Sehnsucht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11345 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:109aff0b-e215-4bde-944c-4cebd42db780' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:109aff0b-e215-4bde-944c-4cebd42db780', 3, NULL, 'Sehnsucht', 'Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11345 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:109aff0b-e215-4bde-944c-4cebd42db780'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 451 AND linked.composer_id = 33),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '자장가 (Wiegenlied)', part.name_en = 'Wiegenlied “Guten Abend, gute Nacht”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11345 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e3ce6ea2-3cd5-3eed-9541-5dac7ec27e9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 451 AND linked.composer_id = 33), 'musicbrainz:e3ce6ea2-3cd5-3eed-9541-5dac7ec27e9c', 4, NULL, '자장가 (Wiegenlied)', 'Wiegenlied “Guten Abend, gute Nacht”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11345 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3ce6ea2-3cd5-3eed-9541-5dac7ec27e9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Abenddämmerung', part.name_en = 'Abenddämmerung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11345 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e7a3afb7-946a-4099-a5d5-e871b956b7a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7a3afb7-946a-4099-a5d5-e871b956b7a7', 5, NULL, 'Abenddämmerung', 'Abenddämmerung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11345 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a3afb7-946a-4099-a5d5-e871b956b7a7'
);


-- None 클라라 슈만을 위한 앨범의 한 장 <Hoch auf'm Berg, tief im Tal>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라라 슈만을 위한 앨범의 한 장 <Hoch auf''m Berg, tief im Tal>', 'Albumblatt for Clara Schumann "Hoch auf''m Berg, tief im Tal"', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라라 슈만을 위한 앨범의 한 장 <Hoch auf''m Berg, tief im Tal>'
);


-- Op. 57 8개의 가곡과 노래 Op. 57

UPDATE pieces piece
SET piece.title = '8개의 가곡과 노래 Op. 57', piece.title_en = '8 Lieder und Gesänge, Op. 57',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '57',
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11583 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 11583 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Von waldbekränzter Höhe', part.name_en = 'Von waldbekränzter Höhe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11583 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a2c1cc0f-31e2-3f64-817a-189b8b03afcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2c1cc0f-31e2-3f64-817a-189b8b03afcc', 1, NULL, 'Von waldbekränzter Höhe', 'Von waldbekränzter Höhe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11583 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2c1cc0f-31e2-3f64-817a-189b8b03afcc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Wenn du nur zuweilen lächelst', part.name_en = 'Wenn du nur zuweilen lächelst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11583 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ad85e874-d3bc-355c-9143-0e1b4d484351' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad85e874-d3bc-355c-9143-0e1b4d484351', 2, NULL, 'Wenn du nur zuweilen lächelst', 'Wenn du nur zuweilen lächelst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11583 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad85e874-d3bc-355c-9143-0e1b4d484351'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Es träumte mir', part.name_en = 'Es träumte mir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11583 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:30e716f4-f09d-357a-b0fe-b37a5bb3d2f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30e716f4-f09d-357a-b0fe-b37a5bb3d2f8', 3, NULL, 'Es träumte mir', 'Es träumte mir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11583 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30e716f4-f09d-357a-b0fe-b37a5bb3d2f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ach, wende diesen Blick', part.name_en = 'Ach, wende diesen Blick',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11583 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:26363331-a5b0-3971-b6fd-e3fb9b08d7b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26363331-a5b0-3971-b6fd-e3fb9b08d7b6', 4, NULL, 'Ach, wende diesen Blick', 'Ach, wende diesen Blick', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11583 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26363331-a5b0-3971-b6fd-e3fb9b08d7b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'In meiner Nächte Sehnen', part.name_en = 'In meiner Nächte Sehnen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11583 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:085ed4d6-83b3-33f4-a19c-8b506709bbb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:085ed4d6-83b3-33f4-a19c-8b506709bbb1', 5, NULL, 'In meiner Nächte Sehnen', 'In meiner Nächte Sehnen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11583 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:085ed4d6-83b3-33f4-a19c-8b506709bbb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Strahlt zuweilen auch ein mildes Licht', part.name_en = 'Strahlt zuweilen auch ein mildes Licht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11583 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6e42288e-f4ae-355d-a716-1fce44c32404' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e42288e-f4ae-355d-a716-1fce44c32404', 6, NULL, 'Strahlt zuweilen auch ein mildes Licht', 'Strahlt zuweilen auch ein mildes Licht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11583 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e42288e-f4ae-355d-a716-1fce44c32404'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Die Schnur, die Perl'' an Perle', part.name_en = 'Die Schnur, die Perl'' an Perle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11583 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:92129c20-5fcd-3739-b3f3-4cac00c79ee9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92129c20-5fcd-3739-b3f3-4cac00c79ee9', 7, NULL, 'Die Schnur, die Perl'' an Perle', 'Die Schnur, die Perl'' an Perle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11583 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92129c20-5fcd-3739-b3f3-4cac00c79ee9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Unbewegte laue Luft', part.name_en = 'Unbewegte laue Luft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11583 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:44ed5fdf-d1e8-3509-8a82-af14bb26c7b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44ed5fdf-d1e8-3509-8a82-af14bb26c7b6', 8, NULL, 'Unbewegte laue Luft', 'Unbewegte laue Luft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11583 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44ed5fdf-d1e8-3509-8a82-af14bb26c7b6'
);


-- Op. 58 8개의 가곡과 노래 Op. 58

UPDATE pieces piece
SET piece.title = '8개의 가곡과 노래 Op. 58', piece.title_en = '8 Lieder und Gesänge, Op. 58',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '58',
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11916 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 11916 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Blinde Kuh', part.name_en = 'Blinde Kuh',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11916 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a619ca62-5dce-4aaa-82a8-93f3cfe7152e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a619ca62-5dce-4aaa-82a8-93f3cfe7152e', 1, NULL, 'Blinde Kuh', 'Blinde Kuh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11916 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a619ca62-5dce-4aaa-82a8-93f3cfe7152e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Während des Regens', part.name_en = 'Während des Regens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11916 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:03d86609-9cdb-461a-94fd-b078cda598ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03d86609-9cdb-461a-94fd-b078cda598ee', 2, NULL, 'Während des Regens', 'Während des Regens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11916 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d86609-9cdb-461a-94fd-b078cda598ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Die Spröde', part.name_en = 'Die Spröde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11916 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:10d22089-c2b6-4f97-b2cb-06cfde36fbf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10d22089-c2b6-4f97-b2cb-06cfde36fbf8', 3, NULL, 'Die Spröde', 'Die Spröde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11916 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10d22089-c2b6-4f97-b2cb-06cfde36fbf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'O komme, holde Sommernacht verschwiegen', part.name_en = 'O komme, holde Sommernacht verschwiegen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11916 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6b45599a-055c-4ddc-880b-4c0ab5463079' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b45599a-055c-4ddc-880b-4c0ab5463079', 4, NULL, 'O komme, holde Sommernacht verschwiegen', 'O komme, holde Sommernacht verschwiegen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11916 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b45599a-055c-4ddc-880b-4c0ab5463079'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Schwermut', part.name_en = 'Schwermut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11916 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f1ff5edb-676d-436b-8f5c-105f990163fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1ff5edb-676d-436b-8f5c-105f990163fd', 5, NULL, 'Schwermut', 'Schwermut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11916 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1ff5edb-676d-436b-8f5c-105f990163fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'In der Gasse', part.name_en = 'In der Gasse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11916 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:112024d4-04a0-402d-bea6-59eed6b6af21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:112024d4-04a0-402d-bea6-59eed6b6af21', 6, NULL, 'In der Gasse', 'In der Gasse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11916 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:112024d4-04a0-402d-bea6-59eed6b6af21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vorüber', part.name_en = 'Vorüber',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11916 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:379ef912-c0c8-44f3-825b-1baf320db8c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:379ef912-c0c8-44f3-825b-1baf320db8c4', 7, NULL, 'Vorüber', 'Vorüber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11916 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:379ef912-c0c8-44f3-825b-1baf320db8c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Serenade', part.name_en = 'Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11916 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:afe02fbd-8624-4d68-8512-28a8d24ee080' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afe02fbd-8624-4d68-8512-28a8d24ee080', 8, NULL, 'Serenade', 'Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11916 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afe02fbd-8624-4d68-8512-28a8d24ee080'
);


-- WoO 23 가곡 <Regenlied>

UPDATE pieces piece
SET piece.title = '가곡 <Regenlied>', piece.title_en = 'Regenlied',
    piece.type = 'song', piece.opus_number = 'WoO 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11494 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 11494 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 59 8개의 가곡과 노래 Op. 59

UPDATE pieces piece
SET piece.title = '8개의 가곡과 노래 Op. 59', piece.title_en = '8 Lieder und Gesänge, Op. 59',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '59',
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11980 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 11980 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dämmrung senkte sich von oben', part.name_en = 'Dämmrung senkte sich von oben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11980 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7e93df60-9a3e-4ee0-af63-49805c122bd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e93df60-9a3e-4ee0-af63-49805c122bd0', 1, NULL, 'Dämmrung senkte sich von oben', 'Dämmrung senkte sich von oben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11980 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e93df60-9a3e-4ee0-af63-49805c122bd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Auf dem See', part.name_en = 'Auf dem See',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11980 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c7e693ba-7396-45d7-9e0b-fabeec499335' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7e693ba-7396-45d7-9e0b-fabeec499335', 2, NULL, 'Auf dem See', 'Auf dem See', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11980 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7e693ba-7396-45d7-9e0b-fabeec499335'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Regenlied', part.name_en = 'Regenlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11980 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3e195527-7376-4b50-b652-3b986b291403' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e195527-7376-4b50-b652-3b986b291403', 3, NULL, 'Regenlied', 'Regenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11980 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e195527-7376-4b50-b652-3b986b291403'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Nachklang', part.name_en = 'Nachklang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11980 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:59f15a79-83b9-467a-9ecd-026ef0a17cf7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59f15a79-83b9-467a-9ecd-026ef0a17cf7', 4, NULL, 'Nachklang', 'Nachklang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11980 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f15a79-83b9-467a-9ecd-026ef0a17cf7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Agnes', part.name_en = 'Agnes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11980 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c097c843-ff60-4510-9fd8-99fb09612c27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c097c843-ff60-4510-9fd8-99fb09612c27', 5, NULL, 'Agnes', 'Agnes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11980 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c097c843-ff60-4510-9fd8-99fb09612c27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Eine gute, gute Nacht', part.name_en = 'Eine gute, gute Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11980 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:61ad200e-09b3-4d49-bdea-cc03dfc6afa3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61ad200e-09b3-4d49-bdea-cc03dfc6afa3', 6, NULL, 'Eine gute, gute Nacht', 'Eine gute, gute Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11980 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61ad200e-09b3-4d49-bdea-cc03dfc6afa3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Mein wundes Herz verlangt nach milder Ruh', part.name_en = 'Mein wundes Herz verlangt nach milder Ruh',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11980 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:59f7244a-833c-486f-bcc0-ec29faf01d53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59f7244a-833c-486f-bcc0-ec29faf01d53', 7, NULL, 'Mein wundes Herz verlangt nach milder Ruh', 'Mein wundes Herz verlangt nach milder Ruh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11980 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59f7244a-833c-486f-bcc0-ec29faf01d53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Dein blaues Auge hält so still', part.name_en = 'Dein blaues Auge hält so still',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11980 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9063d9b9-8b67-395b-9f7e-30875e4ae483' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9063d9b9-8b67-395b-9f7e-30875e4ae483', 8, NULL, 'Dein blaues Auge hält so still', 'Dein blaues Auge hält so still', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11980 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9063d9b9-8b67-395b-9f7e-30875e4ae483'
);


-- WoO 22 <오필리아의 노래>

UPDATE pieces piece
SET piece.title = '<오필리아의 노래>', piece.title_en = 'Ophelia-Lieder',
    piece.type = 'album', piece.opus_number = 'WoO 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11611 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 11611 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Wie erkenn'' ich dein Treulieb?', part.name_en = 'Wie erkenn'' ich dein Treulieb?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11611 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:80609b31-dcb5-41bf-a6d4-d432a1b50b6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80609b31-dcb5-41bf-a6d4-d432a1b50b6a', 1, NULL, 'Wie erkenn'' ich dein Treulieb?', 'Wie erkenn'' ich dein Treulieb?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11611 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80609b31-dcb5-41bf-a6d4-d432a1b50b6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sein Leichenhemd weiß wie Schnee', part.name_en = 'Sein Leichenhemd weiß wie Schnee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11611 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bc48b45f-c3d4-47d7-a31d-def2f74521cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc48b45f-c3d4-47d7-a31d-def2f74521cd', 2, NULL, 'Sein Leichenhemd weiß wie Schnee', 'Sein Leichenhemd weiß wie Schnee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11611 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc48b45f-c3d4-47d7-a31d-def2f74521cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Auf morgen ist Sankt Valentins Tag', part.name_en = 'Auf morgen ist Sankt Valentins Tag',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11611 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:73e6aee0-8684-4ef3-a038-78ab0e625809' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73e6aee0-8684-4ef3-a038-78ab0e625809', 3, NULL, 'Auf morgen ist Sankt Valentins Tag', 'Auf morgen ist Sankt Valentins Tag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11611 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73e6aee0-8684-4ef3-a038-78ab0e625809'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sie trugen ihn auf der Bahre bloß', part.name_en = 'Sie trugen ihn auf der Bahre bloß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11611 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ed7d0a40-0a47-4d02-8215-9ecf4ecdf9c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed7d0a40-0a47-4d02-8215-9ecf4ecdf9c4', 4, NULL, 'Sie trugen ihn auf der Bahre bloß', 'Sie trugen ihn auf der Bahre bloß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11611 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed7d0a40-0a47-4d02-8215-9ecf4ecdf9c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Und kommt er nicht mehr zurück?', part.name_en = 'Und kommt er nicht mehr zurück?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11611 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a35d9f2c-2482-4c4e-b2df-f3c0cc8e6c8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a35d9f2c-2482-4c4e-b2df-f3c0cc8e6c8f', 5, NULL, 'Und kommt er nicht mehr zurück?', 'Und kommt er nicht mehr zurück?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11611 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a35d9f2c-2482-4c4e-b2df-f3c0cc8e6c8f'
);


-- Op. 63 9개의 가곡과 노래 Op. 63

UPDATE pieces piece
SET piece.title = '9개의 가곡과 노래 Op. 63', piece.title_en = '9 Lieder und Gesänge, Op. 63',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '63',
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11628 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 11628 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Frühlingstrost', part.name_en = 'Frühlingstrost',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ac162070-58e4-43af-8bfe-baad2a148b7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac162070-58e4-43af-8bfe-baad2a148b7c', 1, NULL, 'Frühlingstrost', 'Frühlingstrost', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac162070-58e4-43af-8bfe-baad2a148b7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Erinnerung', part.name_en = 'Erinnerung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a46b8d2c-4be7-4878-a7b9-955b4bb10592' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a46b8d2c-4be7-4878-a7b9-955b4bb10592', 2, NULL, 'Erinnerung', 'Erinnerung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a46b8d2c-4be7-4878-a7b9-955b4bb10592'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'An ein Bild', part.name_en = 'An ein Bild',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2b6fd836-def7-406e-83ac-e4f3feb492e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b6fd836-def7-406e-83ac-e4f3feb492e1', 3, NULL, 'An ein Bild', 'An ein Bild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b6fd836-def7-406e-83ac-e4f3feb492e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'An die Tauben', part.name_en = 'An die Tauben',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c47b0de1-75de-4683-8c40-765ac70e33fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c47b0de1-75de-4683-8c40-765ac70e33fd', 4, NULL, 'An die Tauben', 'An die Tauben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c47b0de1-75de-4683-8c40-765ac70e33fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11581 AND linked.composer_id = 33),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Junge Lieder I (Meine Liebe ist grün)', part.name_en = 'Junge Lieder I (Meine Liebe ist grün)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:18737021-3428-3861-9124-fc50320ba4d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11581 AND linked.composer_id = 33), 'musicbrainz:18737021-3428-3861-9124-fc50320ba4d4', 5, NULL, 'Junge Lieder I (Meine Liebe ist grün)', 'Junge Lieder I (Meine Liebe ist grün)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18737021-3428-3861-9124-fc50320ba4d4'
);

UPDATE pieces piece
SET piece.title = '9개의 가곡과 노래 Op. 63 중 "Junge Lieder I (Meine Liebe ist grün)"', piece.title_en = '9 Lieder und Gesänge, Op. 63: Junge Lieder I (Meine Liebe ist grün)', piece.editor_locked = 1
WHERE piece.id = 11581 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Junge Lieder II (Wenn um den Holunder)', part.name_en = 'Junge Lieder II (Wenn um den Holunder)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:eed99519-3bbd-45dd-9323-947d7368a4a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eed99519-3bbd-45dd-9323-947d7368a4a4', 6, NULL, 'Junge Lieder II (Wenn um den Holunder)', 'Junge Lieder II (Wenn um den Holunder)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eed99519-3bbd-45dd-9323-947d7368a4a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Heimweh I', part.name_en = 'Heimweh I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b2a333fe-2aa6-4098-b073-8a083a3b834b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2a333fe-2aa6-4098-b073-8a083a3b834b', 7, NULL, 'Heimweh I', 'Heimweh I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2a333fe-2aa6-4098-b073-8a083a3b834b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Heimweh II', part.name_en = 'Heimweh II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:42d2e3b7-8ba7-3a73-a583-0244110e8016' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42d2e3b7-8ba7-3a73-a583-0244110e8016', 8, NULL, 'Heimweh II', 'Heimweh II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42d2e3b7-8ba7-3a73-a583-0244110e8016'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Heimweh III', part.name_en = 'Heimweh III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11628 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e3f5af71-f3d6-47e6-9858-50facccc2cd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3f5af71-f3d6-47e6-9858-50facccc2cd0', 9, NULL, 'Heimweh III', 'Heimweh III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11628 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3f5af71-f3d6-47e6-9858-50facccc2cd0'
);


-- Op. 69 9개의 노래 Op. 69

UPDATE pieces piece
SET piece.title = '9개의 노래 Op. 69', piece.title_en = '9 Gesänge, Op. 69',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '69',
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11626 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 11626 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Klage I', part.name_en = 'Klage I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8d30be7e-45ec-4306-bb30-b6bfd3ecbd2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d30be7e-45ec-4306-bb30-b6bfd3ecbd2d', 1, NULL, 'Klage I', 'Klage I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d30be7e-45ec-4306-bb30-b6bfd3ecbd2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Klage II', part.name_en = 'Klage II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:457a23d7-72d8-42e0-b7ba-6bd06133474a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:457a23d7-72d8-42e0-b7ba-6bd06133474a', 2, NULL, 'Klage II', 'Klage II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:457a23d7-72d8-42e0-b7ba-6bd06133474a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Abschied', part.name_en = 'Abschied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1577ded3-efd8-48ca-8762-fb877e31cac2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1577ded3-efd8-48ca-8762-fb877e31cac2', 3, NULL, 'Abschied', 'Abschied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1577ded3-efd8-48ca-8762-fb877e31cac2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Des Liebsten Schwur', part.name_en = 'Des Liebsten Schwur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c76e1606-66ca-467e-85ed-21d5c3ddf9c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c76e1606-66ca-467e-85ed-21d5c3ddf9c0', 4, NULL, 'Des Liebsten Schwur', 'Des Liebsten Schwur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c76e1606-66ca-467e-85ed-21d5c3ddf9c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tambourliedchen', part.name_en = 'Tambourliedchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c3259f63-a12f-4cc1-abee-32ea740cbb8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3259f63-a12f-4cc1-abee-32ea740cbb8a', 5, NULL, 'Tambourliedchen', 'Tambourliedchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3259f63-a12f-4cc1-abee-32ea740cbb8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Vom Strande', part.name_en = 'Vom Strande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e861a2b1-ef69-43ac-97ae-953fb18e3b49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e861a2b1-ef69-43ac-97ae-953fb18e3b49', 6, NULL, 'Vom Strande', 'Vom Strande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e861a2b1-ef69-43ac-97ae-953fb18e3b49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Über die See', part.name_en = 'Über die See',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b67f65fe-9ad2-4cc9-b157-6c3424615534' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b67f65fe-9ad2-4cc9-b157-6c3424615534', 7, NULL, 'Über die See', 'Über die See', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b67f65fe-9ad2-4cc9-b157-6c3424615534'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Salome', part.name_en = 'Salome',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:156563b8-d1e0-4184-8f71-b8cc01d7c183' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:156563b8-d1e0-4184-8f71-b8cc01d7c183', 8, NULL, 'Salome', 'Salome', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:156563b8-d1e0-4184-8f71-b8cc01d7c183'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Mädchenfluch', part.name_en = 'Mädchenfluch',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11626 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:601b51e4-3ff0-47bf-a428-44dd4eb1f615' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:601b51e4-3ff0-47bf-a428-44dd4eb1f615', 9, NULL, 'Mädchenfluch', 'Mädchenfluch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11626 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:601b51e4-3ff0-47bf-a428-44dd4eb1f615'
);


-- Op. 70 4개의 노래 Op. 70

UPDATE pieces piece
SET piece.title = '4개의 노래 Op. 70', piece.title_en = '4 Gesänge, Op. 70',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '70',
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11820 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 11820 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Im Garten am Seegestade', part.name_en = 'Im Garten am Seegestade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11820 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:65e75ce0-06e3-4f6a-8ee7-3b3c03e9ba41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e75ce0-06e3-4f6a-8ee7-3b3c03e9ba41', 1, NULL, 'Im Garten am Seegestade', 'Im Garten am Seegestade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11820 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e75ce0-06e3-4f6a-8ee7-3b3c03e9ba41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lerchengesang', part.name_en = 'Lerchengesang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11820 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bae862e1-e372-441d-ba8d-06bf5e592dff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bae862e1-e372-441d-ba8d-06bf5e592dff', 2, NULL, 'Lerchengesang', 'Lerchengesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11820 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bae862e1-e372-441d-ba8d-06bf5e592dff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Serenade', part.name_en = 'Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11820 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:174c48a7-2872-4b63-a6ee-76d635335cc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:174c48a7-2872-4b63-a6ee-76d635335cc2', 3, NULL, 'Serenade', 'Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11820 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:174c48a7-2872-4b63-a6ee-76d635335cc2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Abendregen', part.name_en = 'Abendregen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11820 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:58209da7-463f-4103-8d4a-3fc42604d57f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58209da7-463f-4103-8d4a-3fc42604d57f', 4, NULL, 'Abendregen', 'Abendregen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11820 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58209da7-463f-4103-8d4a-3fc42604d57f'
);


-- Op. 71 5개의 노래 Op. 71

UPDATE pieces piece
SET piece.title = '5개의 노래 Op. 71', piece.title_en = '5 Gesänge, Op. 71',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '71',
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11414 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 11414 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Es liebt sich so lieblich im Lenze!', part.name_en = 'Es liebt sich so lieblich im Lenze!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11414 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e5597139-0621-4fc2-8b11-10f81113b327' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5597139-0621-4fc2-8b11-10f81113b327', 1, NULL, 'Es liebt sich so lieblich im Lenze!', 'Es liebt sich so lieblich im Lenze!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11414 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5597139-0621-4fc2-8b11-10f81113b327'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'An den Mond', part.name_en = 'An den Mond',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11414 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f271072b-c73e-4d60-a53f-cab313c02518' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f271072b-c73e-4d60-a53f-cab313c02518', 2, NULL, 'An den Mond', 'An den Mond', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11414 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f271072b-c73e-4d60-a53f-cab313c02518'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Geheimnis', part.name_en = 'Geheimnis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11414 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3896de66-48b5-4674-b4fe-16242420983f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3896de66-48b5-4674-b4fe-16242420983f', 3, NULL, 'Geheimnis', 'Geheimnis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11414 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3896de66-48b5-4674-b4fe-16242420983f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Willst du, dass ich geh''?', part.name_en = 'Willst du, dass ich geh''?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11414 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3d0f2a21-8d74-49b3-9100-6d585c7f628f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d0f2a21-8d74-49b3-9100-6d585c7f628f', 4, NULL, 'Willst du, dass ich geh''?', 'Willst du, dass ich geh''?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11414 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d0f2a21-8d74-49b3-9100-6d585c7f628f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Minnelied', part.name_en = 'Minnelied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11414 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:55a88897-e24f-42ab-9a5e-785e7119a8a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55a88897-e24f-42ab-9a5e-785e7119a8a4', 5, NULL, 'Minnelied', 'Minnelied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11414 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55a88897-e24f-42ab-9a5e-785e7119a8a4'
);


-- Op. 72 5개의 노래 Op. 72

UPDATE pieces piece
SET piece.title = '5개의 노래 Op. 72', piece.title_en = '5 Gesänge, Op. 72',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '72',
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11704 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 11704 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Alte Liebe', part.name_en = 'Alte Liebe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11704 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:65fc8c2d-958a-3c42-a52d-64d06bad1a1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65fc8c2d-958a-3c42-a52d-64d06bad1a1f', 1, NULL, 'Alte Liebe', 'Alte Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11704 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65fc8c2d-958a-3c42-a52d-64d06bad1a1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sommerfäden', part.name_en = 'Sommerfäden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11704 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7b8f4921-5eb0-316e-9985-6b4ff8424414' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b8f4921-5eb0-316e-9985-6b4ff8424414', 2, NULL, 'Sommerfäden', 'Sommerfäden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11704 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b8f4921-5eb0-316e-9985-6b4ff8424414'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O kühler Wald', part.name_en = 'O kühler Wald',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11704 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:809c83ac-616e-3913-9916-9350da20f68a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:809c83ac-616e-3913-9916-9350da20f68a', 3, NULL, 'O kühler Wald', 'O kühler Wald', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11704 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:809c83ac-616e-3913-9916-9350da20f68a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Verzagen', part.name_en = 'Verzagen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11704 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:914124c2-37c0-33db-a014-dc28144602b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:914124c2-37c0-33db-a014-dc28144602b2', 4, NULL, 'Verzagen', 'Verzagen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11704 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:914124c2-37c0-33db-a014-dc28144602b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Unüberwindlich', part.name_en = 'Unüberwindlich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11704 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:90eca649-0532-39e9-b79d-abb194980b98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90eca649-0532-39e9-b79d-abb194980b98', 5, NULL, 'Unüberwindlich', 'Unüberwindlich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11704 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90eca649-0532-39e9-b79d-abb194980b98'
);


-- Op. 85 6개의 가곡 Op. 85

UPDATE pieces piece
SET piece.title = '6개의 가곡 Op. 85', piece.title_en = '6 Lieder, Op. 85',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '85',
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11551 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 11551 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sommerabend', part.name_en = 'Sommerabend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11551 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:29bb1479-11f7-48bf-be85-020426dfea52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29bb1479-11f7-48bf-be85-020426dfea52', 1, NULL, 'Sommerabend', 'Sommerabend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11551 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29bb1479-11f7-48bf-be85-020426dfea52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mondenschein', part.name_en = 'Mondenschein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11551 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d7f612b8-e140-4496-b1cd-af8a28db0f2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7f612b8-e140-4496-b1cd-af8a28db0f2c', 2, NULL, 'Mondenschein', 'Mondenschein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11551 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7f612b8-e140-4496-b1cd-af8a28db0f2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mädchenlied', part.name_en = 'Mädchenlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11551 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:655c82c7-9fe1-4d99-a421-78c3d6f46d45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:655c82c7-9fe1-4d99-a421-78c3d6f46d45', 3, NULL, 'Mädchenlied', 'Mädchenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11551 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:655c82c7-9fe1-4d99-a421-78c3d6f46d45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ade!', part.name_en = 'Ade!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11551 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7ab9d260-68a6-4aa9-8423-fe3ebc75f5bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ab9d260-68a6-4aa9-8423-fe3ebc75f5bf', 4, NULL, 'Ade!', 'Ade!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11551 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ab9d260-68a6-4aa9-8423-fe3ebc75f5bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Frühlingslied', part.name_en = 'Frühlingslied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11551 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:faf0dc50-f708-4fb9-b320-44c2bb2a7bfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faf0dc50-f708-4fb9-b320-44c2bb2a7bfb', 5, NULL, 'Frühlingslied', 'Frühlingslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11551 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faf0dc50-f708-4fb9-b320-44c2bb2a7bfb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'In Waldeinsamkeit', part.name_en = 'In Waldeinsamkeit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11551 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7229e565-e48b-44fc-af52-d7073bacfa2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7229e565-e48b-44fc-af52-d7073bacfa2d', 6, NULL, 'In Waldeinsamkeit', 'In Waldeinsamkeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11551 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7229e565-e48b-44fc-af52-d7073bacfa2d'
);


-- Op. 86 6개의 가곡 Op. 86

UPDATE pieces piece
SET piece.title = '6개의 가곡 Op. 86', piece.title_en = '6 Lieder, Op. 86',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '86',
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11911 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 11911 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Therese', part.name_en = 'Therese',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11911 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e13fe8ff-81b6-4fe6-8768-732f87123622' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e13fe8ff-81b6-4fe6-8768-732f87123622', 1, NULL, 'Therese', 'Therese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11911 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e13fe8ff-81b6-4fe6-8768-732f87123622'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11449 AND linked.composer_id = 33),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Feldeinsamkeit', part.name_en = 'Feldeinsamkeit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11911 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d6ddf9ee-9890-4ee9-a8ef-0867ff2a9098' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 11449 AND linked.composer_id = 33), 'musicbrainz:d6ddf9ee-9890-4ee9-a8ef-0867ff2a9098', 2, NULL, 'Feldeinsamkeit', 'Feldeinsamkeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11911 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6ddf9ee-9890-4ee9-a8ef-0867ff2a9098'
);

UPDATE pieces piece
SET piece.title = '6개의 가곡 Op. 86 중 "Feldeinsamkeit"', piece.title_en = '6 Lieder, Op. 86: Feldeinsamkeit', piece.editor_locked = 1
WHERE piece.id = 11449 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nachtwandler', part.name_en = 'Nachtwandler',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11911 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f93d3dda-4dc3-4211-ba87-03646a15ac82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f93d3dda-4dc3-4211-ba87-03646a15ac82', 3, NULL, 'Nachtwandler', 'Nachtwandler', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11911 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f93d3dda-4dc3-4211-ba87-03646a15ac82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Über die Heide', part.name_en = 'Über die Heide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11911 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a9249217-5fc8-485f-8c4b-db22bf2b7ebe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9249217-5fc8-485f-8c4b-db22bf2b7ebe', 4, NULL, 'Über die Heide', 'Über die Heide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11911 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9249217-5fc8-485f-8c4b-db22bf2b7ebe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Versunken', part.name_en = 'Versunken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11911 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e58c9318-541a-44c9-b02c-69cb05c94275' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e58c9318-541a-44c9-b02c-69cb05c94275', 5, NULL, 'Versunken', 'Versunken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11911 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e58c9318-541a-44c9-b02c-69cb05c94275'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Todessehnen', part.name_en = 'Todessehnen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11911 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c98219da-17d2-4b43-aa1a-6463bc7cebae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c98219da-17d2-4b43-aa1a-6463bc7cebae', 6, NULL, 'Todessehnen', 'Todessehnen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11911 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c98219da-17d2-4b43-aa1a-6463bc7cebae'
);


-- Anh. III/8 나폴리 칸초네타 <So bello non>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '나폴리 칸초네타 <So bello non>', 'So bello non (Neapolitan canzonetta)', 'song', 'Anh. III/8', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '나폴리 칸초네타 <So bello non>'
);


-- Op. 91 알토, 비올라와 피아노를 위한 2개의 노래 Op. 91

UPDATE pieces piece
SET piece.title = '알토, 비올라와 피아노를 위한 2개의 노래 Op. 91', piece.title_en = '2 Gesänge for alto, viola and piano, Op. 91',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '91',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11787 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 11787 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gestillte Sehnsucht', part.name_en = 'Gestillte Sehnsucht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11787 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bc6ea203-6173-3c94-85df-eaaa5349706f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc6ea203-6173-3c94-85df-eaaa5349706f', 1, NULL, 'Gestillte Sehnsucht', 'Gestillte Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11787 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc6ea203-6173-3c94-85df-eaaa5349706f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Geistliches Wiegenlied', part.name_en = 'Geistliches Wiegenlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11787 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d636416a-a195-3e72-940f-c74e0cc254f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d636416a-a195-3e72-940f-c74e0cc254f7', 2, NULL, 'Geistliches Wiegenlied', 'Geistliches Wiegenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11787 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d636416a-a195-3e72-940f-c74e0cc254f7'
);


-- Op. 94 5개의 가곡 Op. 94

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 94', piece.title_en = '5 Lieder, Op. 94',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '94',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11467 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 11467 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mit vierzig Jahren', part.name_en = 'Mit vierzig Jahren',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11467 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:76b259cf-8f85-3fb3-a9d6-01fb0e05c272' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76b259cf-8f85-3fb3-a9d6-01fb0e05c272', 1, NULL, 'Mit vierzig Jahren', 'Mit vierzig Jahren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11467 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76b259cf-8f85-3fb3-a9d6-01fb0e05c272'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Steig auf, geliebter Schatten', part.name_en = 'Steig auf, geliebter Schatten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11467 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bd7e0c33-6cfb-3aff-baf3-d3c0838774ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd7e0c33-6cfb-3aff-baf3-d3c0838774ac', 2, NULL, 'Steig auf, geliebter Schatten', 'Steig auf, geliebter Schatten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11467 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd7e0c33-6cfb-3aff-baf3-d3c0838774ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mein Herz ist schwer', part.name_en = 'Mein Herz ist schwer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11467 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:eb483784-9f5b-356f-8a69-de829104d08d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb483784-9f5b-356f-8a69-de829104d08d', 3, NULL, 'Mein Herz ist schwer', 'Mein Herz ist schwer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11467 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb483784-9f5b-356f-8a69-de829104d08d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sapphische Ode', part.name_en = 'Sapphische Ode',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11467 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d4963897-cc65-3f04-88b9-e553837109c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4963897-cc65-3f04-88b9-e553837109c8', 4, NULL, 'Sapphische Ode', 'Sapphische Ode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11467 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4963897-cc65-3f04-88b9-e553837109c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Kein Haus, keine Heimat', part.name_en = 'Kein Haus, keine Heimat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11467 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c254b3cd-1ef2-3502-ab86-997d57e3677f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c254b3cd-1ef2-3502-ab86-997d57e3677f', 5, NULL, 'Kein Haus, keine Heimat', 'Kein Haus, keine Heimat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11467 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c254b3cd-1ef2-3502-ab86-997d57e3677f'
);


-- Op. 95 7개의 가곡 Op. 95

UPDATE pieces piece
SET piece.title = '7개의 가곡 Op. 95', piece.title_en = '7 Lieder, Op. 95',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '95',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11641 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 11641 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Das Mädchen', part.name_en = 'Das Mädchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11641 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:97230ccf-8d43-4f93-8dd0-b6267782438b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97230ccf-8d43-4f93-8dd0-b6267782438b', 1, NULL, 'Das Mädchen', 'Das Mädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11641 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97230ccf-8d43-4f93-8dd0-b6267782438b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bei dir sind meine Gedanken', part.name_en = 'Bei dir sind meine Gedanken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11641 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9bf677ab-4554-497f-bd80-ee420913187d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bf677ab-4554-497f-bd80-ee420913187d', 2, NULL, 'Bei dir sind meine Gedanken', 'Bei dir sind meine Gedanken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11641 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bf677ab-4554-497f-bd80-ee420913187d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Beim Abschied', part.name_en = 'Beim Abschied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11641 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a4f9c7fc-dc80-4698-91f8-5a4487ae48fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4f9c7fc-dc80-4698-91f8-5a4487ae48fa', 3, NULL, 'Beim Abschied', 'Beim Abschied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11641 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4f9c7fc-dc80-4698-91f8-5a4487ae48fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der Jäger', part.name_en = 'Der Jäger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11641 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:031d64d7-d470-44c2-95a2-dba9d859e146' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:031d64d7-d470-44c2-95a2-dba9d859e146', 4, NULL, 'Der Jäger', 'Der Jäger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11641 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:031d64d7-d470-44c2-95a2-dba9d859e146'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Vorschneller Schwur', part.name_en = 'Vorschneller Schwur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11641 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2a0f11d0-2022-423f-9e7b-31b9cb1cfa35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a0f11d0-2022-423f-9e7b-31b9cb1cfa35', 5, NULL, 'Vorschneller Schwur', 'Vorschneller Schwur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11641 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a0f11d0-2022-423f-9e7b-31b9cb1cfa35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Mädchenlied', part.name_en = 'Mädchenlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11641 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5d2de14f-d138-4200-bed0-0b39a9699825' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d2de14f-d138-4200-bed0-0b39a9699825', 6, NULL, 'Mädchenlied', 'Mädchenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11641 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d2de14f-d138-4200-bed0-0b39a9699825'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Schön war, das ich dir weihte', part.name_en = 'Schön war, das ich dir weihte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11641 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f109a0a4-8cac-4ee2-80e8-5e86f23e4a0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f109a0a4-8cac-4ee2-80e8-5e86f23e4a0c', 7, NULL, 'Schön war, das ich dir weihte', 'Schön war, das ich dir weihte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11641 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f109a0a4-8cac-4ee2-80e8-5e86f23e4a0c'
);


-- Op. 96 4개의 가곡 Op. 96

UPDATE pieces piece
SET piece.title = '4개의 가곡 Op. 96', piece.title_en = '4 Lieder, Op. 96',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '96',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11689 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 11689 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der Tod, das ist die kühle Nacht', part.name_en = 'Der Tod, das ist die kühle Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11689 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fd1f74ed-ddf7-466e-96fd-d73784905182' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd1f74ed-ddf7-466e-96fd-d73784905182', 1, NULL, 'Der Tod, das ist die kühle Nacht', 'Der Tod, das ist die kühle Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11689 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd1f74ed-ddf7-466e-96fd-d73784905182'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Wir wandelten, wir zwei zusammen', part.name_en = 'Wir wandelten, wir zwei zusammen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11689 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1dffd085-cafe-4c0d-8ba2-d43c57ef5655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dffd085-cafe-4c0d-8ba2-d43c57ef5655', 2, NULL, 'Wir wandelten, wir zwei zusammen', 'Wir wandelten, wir zwei zusammen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11689 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dffd085-cafe-4c0d-8ba2-d43c57ef5655'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Es schauen die Blumen', part.name_en = 'Es schauen die Blumen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11689 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:63c6c906-7a90-41fb-8301-889ff10f395b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63c6c906-7a90-41fb-8301-889ff10f395b', 3, NULL, 'Es schauen die Blumen', 'Es schauen die Blumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11689 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63c6c906-7a90-41fb-8301-889ff10f395b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Meerfahrt', part.name_en = 'Meerfahrt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11689 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a5e53885-d764-4098-a5ab-f9acc06e6d52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e53885-d764-4098-a5ab-f9acc06e6d52', 4, NULL, 'Meerfahrt', 'Meerfahrt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11689 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e53885-d764-4098-a5ab-f9acc06e6d52'
);


-- Op. 97 6개의 가곡 Op. 97

UPDATE pieces piece
SET piece.title = '6개의 가곡 Op. 97', piece.title_en = '6 Lieder, Op. 97',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '97',
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11930 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 11930 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nachtigall', part.name_en = 'Nachtigall',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11930 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:141fd1ee-2048-4847-aeef-c61bbbeddc16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:141fd1ee-2048-4847-aeef-c61bbbeddc16', 1, NULL, 'Nachtigall', 'Nachtigall', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11930 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:141fd1ee-2048-4847-aeef-c61bbbeddc16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Auf dem Schiffe', part.name_en = 'Auf dem Schiffe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11930 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:db300cd1-28cd-4e36-b5c7-4bf0f12a24d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db300cd1-28cd-4e36-b5c7-4bf0f12a24d0', 2, NULL, 'Auf dem Schiffe', 'Auf dem Schiffe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11930 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db300cd1-28cd-4e36-b5c7-4bf0f12a24d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Entführung', part.name_en = 'Entführung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11930 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:598b0ca7-f224-49af-aa06-791205a64213' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:598b0ca7-f224-49af-aa06-791205a64213', 3, NULL, 'Entführung', 'Entführung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11930 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:598b0ca7-f224-49af-aa06-791205a64213'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dort in den Weiden steht ein Haus', part.name_en = 'Dort in den Weiden steht ein Haus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11930 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ed9a8a27-11e0-38fe-938e-7a872d4ce4a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed9a8a27-11e0-38fe-938e-7a872d4ce4a9', 4, NULL, 'Dort in den Weiden steht ein Haus', 'Dort in den Weiden steht ein Haus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11930 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed9a8a27-11e0-38fe-938e-7a872d4ce4a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Komm bald', part.name_en = 'Komm bald',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11930 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:be5cbefd-22b5-4b9e-99a8-be80d0f1d98e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be5cbefd-22b5-4b9e-99a8-be80d0f1d98e', 5, NULL, 'Komm bald', 'Komm bald', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11930 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be5cbefd-22b5-4b9e-99a8-be80d0f1d98e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Trennung', part.name_en = 'Trennung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11930 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d2b4da9e-061b-4226-bd43-d0159bafb30c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2b4da9e-061b-4226-bd43-d0159bafb30c', 6, NULL, 'Trennung', 'Trennung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11930 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2b4da9e-061b-4226-bd43-d0159bafb30c'
);


-- Op. 105 5개의 가곡 Op. 105

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 105', piece.title_en = '5 Lieder, Op. 105',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '105',
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11732 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 11732 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Wie Melodien zieht es mir leise durch den Sinn', part.name_en = 'Wie Melodien zieht es mir leise durch den Sinn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11732 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:10cc0ec9-7b6e-4dd0-bf6f-5cba458bfc27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10cc0ec9-7b6e-4dd0-bf6f-5cba458bfc27', 1, NULL, 'Wie Melodien zieht es mir leise durch den Sinn', 'Wie Melodien zieht es mir leise durch den Sinn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11732 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10cc0ec9-7b6e-4dd0-bf6f-5cba458bfc27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Immer leiser wird mein Schlummer', part.name_en = 'Immer leiser wird mein Schlummer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11732 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0ff1fac2-8de3-4d1e-98cf-dd19c62b130b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ff1fac2-8de3-4d1e-98cf-dd19c62b130b', 2, NULL, 'Immer leiser wird mein Schlummer', 'Immer leiser wird mein Schlummer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11732 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ff1fac2-8de3-4d1e-98cf-dd19c62b130b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Klage', part.name_en = 'Klage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11732 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3f45bd22-e89e-4896-bff7-486b7a99fead' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f45bd22-e89e-4896-bff7-486b7a99fead', 3, NULL, 'Klage', 'Klage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11732 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f45bd22-e89e-4896-bff7-486b7a99fead'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Auf dem Kirchhofe', part.name_en = 'Auf dem Kirchhofe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11732 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c07edee0-f60b-4646-82b0-076dd7eae8dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c07edee0-f60b-4646-82b0-076dd7eae8dd', 4, NULL, 'Auf dem Kirchhofe', 'Auf dem Kirchhofe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11732 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c07edee0-f60b-4646-82b0-076dd7eae8dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Verrat', part.name_en = 'Verrat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11732 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3621116d-e73f-4a9c-b24f-f2c3139a0155' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3621116d-e73f-4a9c-b24f-f2c3139a0155', 5, NULL, 'Verrat', 'Verrat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11732 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3621116d-e73f-4a9c-b24f-f2c3139a0155'
);


-- Op. 106 5개의 가곡 Op. 106

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 106', piece.title_en = '5 Lieder, Op. 106',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '106',
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11756 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 11756 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ständchen', part.name_en = 'Ständchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11756 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8fe95fd2-9e4f-3b2c-a8f7-2b58c2ee547e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fe95fd2-9e4f-3b2c-a8f7-2b58c2ee547e', 1, NULL, 'Ständchen', 'Ständchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11756 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fe95fd2-9e4f-3b2c-a8f7-2b58c2ee547e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Auf dem See', part.name_en = 'Auf dem See',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11756 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:42ce9145-6197-44f2-abbb-c76608065c28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42ce9145-6197-44f2-abbb-c76608065c28', 2, NULL, 'Auf dem See', 'Auf dem See', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11756 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42ce9145-6197-44f2-abbb-c76608065c28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Es hing der Reif im Lindenbaum', part.name_en = 'Es hing der Reif im Lindenbaum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11756 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4da06b3c-9937-4963-a410-bd374a5849a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4da06b3c-9937-4963-a410-bd374a5849a7', 3, NULL, 'Es hing der Reif im Lindenbaum', 'Es hing der Reif im Lindenbaum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11756 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4da06b3c-9937-4963-a410-bd374a5849a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Meine Lieder', part.name_en = 'Meine Lieder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11756 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:53f50fdd-c0c1-444e-ac8d-e3eb088bea6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53f50fdd-c0c1-444e-ac8d-e3eb088bea6a', 4, NULL, 'Meine Lieder', 'Meine Lieder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11756 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53f50fdd-c0c1-444e-ac8d-e3eb088bea6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ein Wanderer', part.name_en = 'Ein Wanderer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11756 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:633eaf6e-9657-4563-a77a-1836fcfe8ea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:633eaf6e-9657-4563-a77a-1836fcfe8ea8', 5, NULL, 'Ein Wanderer', 'Ein Wanderer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11756 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:633eaf6e-9657-4563-a77a-1836fcfe8ea8'
);


-- Op. 107 5개의 가곡 Op. 107

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 107', piece.title_en = '5 Lieder, Op. 107',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '107',
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11673 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 11673 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'An die Stolze', part.name_en = 'An die Stolze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11673 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ec679d47-752e-4d49-b91a-10d31d097ffa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec679d47-752e-4d49-b91a-10d31d097ffa', 1, NULL, 'An die Stolze', 'An die Stolze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11673 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec679d47-752e-4d49-b91a-10d31d097ffa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Salamander', part.name_en = 'Salamander',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11673 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:85e6f6cf-bca0-4d35-813f-017b17717312' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85e6f6cf-bca0-4d35-813f-017b17717312', 2, NULL, 'Salamander', 'Salamander', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11673 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85e6f6cf-bca0-4d35-813f-017b17717312'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Das Mädchen spricht', part.name_en = 'Das Mädchen spricht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11673 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0fd27ea0-ea93-45a9-81ab-666193488db4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fd27ea0-ea93-45a9-81ab-666193488db4', 3, NULL, 'Das Mädchen spricht', 'Das Mädchen spricht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11673 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fd27ea0-ea93-45a9-81ab-666193488db4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Maienkätzchen', part.name_en = 'Maienkätzchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11673 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d78793a8-a590-4be4-8c5c-bc9060c30218' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d78793a8-a590-4be4-8c5c-bc9060c30218', 4, NULL, 'Maienkätzchen', 'Maienkätzchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11673 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d78793a8-a590-4be4-8c5c-bc9060c30218'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Mädchenlied', part.name_en = 'Mädchenlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11673 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a0254321-c8cc-38b3-bde3-cc63d6dab037' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0254321-c8cc-38b3-bde3-cc63d6dab037', 5, NULL, 'Mädchenlied', 'Mädchenlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11673 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0254321-c8cc-38b3-bde3-cc63d6dab037'
);


-- Anh. III/7 아포리즘 <Doch was hör ich?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아포리즘 <Doch was hör ich?>', 'Doch was hör ich? (aphorism)', 'song', 'Anh. III/7', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아포리즘 <Doch was hör ich?>'
);


-- Op. 121 가곡집 <4개의 엄숙한 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <4개의 엄숙한 노래>', 'Vier ernste Gesänge (Four Serious Songs)', 'album', 'Op. 121', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <4개의 엄숙한 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '574efe94-4636-4e65-973e-e5495298ed8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '574efe94-4636-4e65-973e-e5495298ed8a'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '가곡집 <4개의 엄숙한 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '574efe94-4636-4e65-973e-e5495298ed8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ac9a62e-1632-3b91-ab27-eca0b993f3ca', 1, NULL, 'Denn es gehet dem Menschen wie dem Vieh', 'Denn es gehet dem Menschen wie dem Vieh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '가곡집 <4개의 엄숙한 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ac9a62e-1632-3b91-ab27-eca0b993f3ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00464bd7-d725-3211-9ed9-631ca5e1bd45', 2, NULL, 'Ich wandte mich und sahe an alle', 'Ich wandte mich und sahe an alle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '가곡집 <4개의 엄숙한 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00464bd7-d725-3211-9ed9-631ca5e1bd45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa61e1cb-eff3-3c1f-93e0-538efa3df947', 3, NULL, 'O Tod, wie bitter bist du', 'O Tod, wie bitter bist du', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '가곡집 <4개의 엄숙한 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa61e1cb-eff3-3c1f-93e0-538efa3df947'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:207daea5-990e-3d3e-b2ae-ff18667b9ce0', 4, NULL, 'Wenn ich mit Menschen- und mit Engelszungen redete', 'Wenn ich mit Menschen- und mit Engelszungen redete', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '가곡집 <4개의 엄숙한 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:207daea5-990e-3d3e-b2ae-ff18667b9ce0'
);


-- Op. 20 3개의 2중창 Op. 20

UPDATE pieces piece
SET piece.title = '3개의 2중창 Op. 20', piece.title_en = '3 Duets, Op. 20',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '20',
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11812 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 11812 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Weg der Liebe I', part.name_en = 'Weg der Liebe I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11812 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:aa1c64be-a0a0-48ba-87a5-960e51fcfa0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa1c64be-a0a0-48ba-87a5-960e51fcfa0f', 1, NULL, 'Weg der Liebe I', 'Weg der Liebe I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11812 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa1c64be-a0a0-48ba-87a5-960e51fcfa0f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Weg der Liebe II', part.name_en = 'Weg der Liebe II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11812 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8e0df8d2-daef-4582-8fc5-520c1e8d2daf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e0df8d2-daef-4582-8fc5-520c1e8d2daf', 2, NULL, 'Weg der Liebe II', 'Weg der Liebe II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11812 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e0df8d2-daef-4582-8fc5-520c1e8d2daf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Die Meere', part.name_en = 'Die Meere',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11812 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:db395e4a-2480-40d6-8ca2-be81bb3dd641' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db395e4a-2480-40d6-8ca2-be81bb3dd641', 3, NULL, 'Die Meere', 'Die Meere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11812 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db395e4a-2480-40d6-8ca2-be81bb3dd641'
);


-- Op. 28 4개의 2중창 Op. 28

UPDATE pieces piece
SET piece.title = '4개의 2중창 Op. 28', piece.title_en = '4 Duets, Op. 28',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '28',
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11803 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 11803 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Die Nonne und der Ritter', part.name_en = 'Die Nonne und der Ritter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11803 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:cf11f264-b3ad-49d3-9446-16db119f107f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf11f264-b3ad-49d3-9446-16db119f107f', 1, NULL, 'Die Nonne und der Ritter', 'Die Nonne und der Ritter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11803 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf11f264-b3ad-49d3-9446-16db119f107f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vor der Tür', part.name_en = 'Vor der Tür',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11803 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e8e983a1-4a71-45b3-9d61-28fcf6f9adee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8e983a1-4a71-45b3-9d61-28fcf6f9adee', 2, NULL, 'Vor der Tür', 'Vor der Tür', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11803 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8e983a1-4a71-45b3-9d61-28fcf6f9adee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Es rauschet das Wasser', part.name_en = 'Es rauschet das Wasser',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11803 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ce0c8866-3234-4904-8d48-caa76f0b3ddb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce0c8866-3234-4904-8d48-caa76f0b3ddb', 3, NULL, 'Es rauschet das Wasser', 'Es rauschet das Wasser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11803 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce0c8866-3234-4904-8d48-caa76f0b3ddb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der Jäger und sein Liebchen', part.name_en = 'Der Jäger und sein Liebchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11803 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:decabc03-5c7a-4fcd-b460-e74a6906be74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:decabc03-5c7a-4fcd-b460-e74a6906be74', 4, NULL, 'Der Jäger und sein Liebchen', 'Der Jäger und sein Liebchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11803 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:decabc03-5c7a-4fcd-b460-e74a6906be74'
);


-- Op. 61 4개의 2중창 Op. 61

UPDATE pieces piece
SET piece.title = '4개의 2중창 Op. 61', piece.title_en = '4 Duets, Op. 61',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '61',
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11697 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 11697 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Die Schwestern', part.name_en = 'Die Schwestern',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11697 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e6333c52-10f5-43d9-980a-6c866be53de4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6333c52-10f5-43d9-980a-6c866be53de4', 1, NULL, 'Die Schwestern', 'Die Schwestern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11697 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6333c52-10f5-43d9-980a-6c866be53de4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Klosterfräulein', part.name_en = 'Klosterfräulein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11697 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f019a8c7-f84c-44a2-8e97-021f28a0b0ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f019a8c7-f84c-44a2-8e97-021f28a0b0ee', 2, NULL, 'Klosterfräulein', 'Klosterfräulein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11697 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f019a8c7-f84c-44a2-8e97-021f28a0b0ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Phänomen', part.name_en = 'Phänomen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11697 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d4f451d1-0745-46a2-82fb-01039f14f74a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4f451d1-0745-46a2-82fb-01039f14f74a', 3, NULL, 'Phänomen', 'Phänomen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11697 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4f451d1-0745-46a2-82fb-01039f14f74a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Die Boten der Liebe', part.name_en = 'Die Boten der Liebe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11697 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:136420f1-93a4-4a17-af0e-287021fcd9c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:136420f1-93a4-4a17-af0e-287021fcd9c4', 4, NULL, 'Die Boten der Liebe', 'Die Boten der Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11697 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:136420f1-93a4-4a17-af0e-287021fcd9c4'
);


-- Op. 66 5개의 2중창 Op. 66

UPDATE pieces piece
SET piece.title = '5개의 2중창 Op. 66', piece.title_en = '5 Duets, Op. 66',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '66',
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11652 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 11652 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Klänge I', part.name_en = 'Klänge I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11652 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7c5c426e-9ce5-470c-8f02-25eb7e0d8fb1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c5c426e-9ce5-470c-8f02-25eb7e0d8fb1', 1, NULL, 'Klänge I', 'Klänge I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11652 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c5c426e-9ce5-470c-8f02-25eb7e0d8fb1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Klänge II', part.name_en = 'Klänge II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11652 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5125f75e-e37c-46b8-92a2-f798ce8ce588' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5125f75e-e37c-46b8-92a2-f798ce8ce588', 2, NULL, 'Klänge II', 'Klänge II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11652 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5125f75e-e37c-46b8-92a2-f798ce8ce588'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Am Strande', part.name_en = 'Am Strande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11652 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d6e6e2b6-c936-4360-9350-2b73210f430d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6e6e2b6-c936-4360-9350-2b73210f430d', 3, NULL, 'Am Strande', 'Am Strande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11652 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e6e2b6-c936-4360-9350-2b73210f430d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jägerlied', part.name_en = 'Jägerlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11652 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7c35a498-5a32-4a94-a61c-7e9eae7cf9ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c35a498-5a32-4a94-a61c-7e9eae7cf9ba', 4, NULL, 'Jägerlied', 'Jägerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11652 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c35a498-5a32-4a94-a61c-7e9eae7cf9ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Hüt du dich!', part.name_en = 'Hüt du dich!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11652 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0198c34c-82da-49b4-bf6c-a3c9d6b6a2f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0198c34c-82da-49b4-bf6c-a3c9d6b6a2f6', 5, NULL, 'Hüt du dich!', 'Hüt du dich!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11652 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0198c34c-82da-49b4-bf6c-a3c9d6b6a2f6'
);


-- Op. 75 4개의 발라드와 로망스 Op. 75

UPDATE pieces piece
SET piece.title = '4개의 발라드와 로망스 Op. 75', piece.title_en = '4 Balladen und Romanzen, Op. 75',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '75',
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11988 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 11988 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Edward', part.name_en = 'Edward',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11988 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:067c5e3e-e216-45f8-b4ab-e85be8fad790' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:067c5e3e-e216-45f8-b4ab-e85be8fad790', 1, NULL, 'Edward', 'Edward', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11988 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:067c5e3e-e216-45f8-b4ab-e85be8fad790'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Guter Rat', part.name_en = 'Guter Rat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11988 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d5a7cf92-dc3e-41da-b895-edc99d97b7ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5a7cf92-dc3e-41da-b895-edc99d97b7ac', 2, NULL, 'Guter Rat', 'Guter Rat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11988 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5a7cf92-dc3e-41da-b895-edc99d97b7ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'So lass uns wandern!', part.name_en = 'So lass uns wandern!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11988 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5ce939e5-acca-479d-828e-69944b2aa87f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ce939e5-acca-479d-828e-69944b2aa87f', 3, NULL, 'So lass uns wandern!', 'So lass uns wandern!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11988 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ce939e5-acca-479d-828e-69944b2aa87f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Walpurgisnacht', part.name_en = 'Walpurgisnacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11988 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3289a47e-63eb-4c5d-a1e3-af04f357c4a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3289a47e-63eb-4c5d-a1e3-af04f357c4a4', 4, NULL, 'Walpurgisnacht', 'Walpurgisnacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11988 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3289a47e-63eb-4c5d-a1e3-af04f357c4a4'
);


-- Op. 84 5개의 로망스와 가곡 Op. 84

UPDATE pieces piece
SET piece.title = '5개의 로망스와 가곡 Op. 84', piece.title_en = '5 Romanzen und Lieder, Op. 84',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '84',
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11436 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 11436 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sommerabend', part.name_en = 'Sommerabend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11436 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:804318ad-21ed-43ba-bf5b-1e5032c4c50f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:804318ad-21ed-43ba-bf5b-1e5032c4c50f', 1, NULL, 'Sommerabend', 'Sommerabend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11436 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:804318ad-21ed-43ba-bf5b-1e5032c4c50f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Der Kranz', part.name_en = 'Der Kranz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11436 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f129fced-328e-46b2-a93a-cb89ef23f52d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f129fced-328e-46b2-a93a-cb89ef23f52d', 2, NULL, 'Der Kranz', 'Der Kranz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11436 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f129fced-328e-46b2-a93a-cb89ef23f52d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'In den Beeren', part.name_en = 'In den Beeren',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11436 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:21835066-cad8-4e90-981c-8b2cf2f8e208' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21835066-cad8-4e90-981c-8b2cf2f8e208', 3, NULL, 'In den Beeren', 'In den Beeren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11436 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21835066-cad8-4e90-981c-8b2cf2f8e208'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Vergebliches Ständchen', part.name_en = 'Vergebliches Ständchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11436 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9ff05be7-ab6d-38f1-99f0-c171c362191c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ff05be7-ab6d-38f1-99f0-c171c362191c', 4, NULL, 'Vergebliches Ständchen', 'Vergebliches Ständchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11436 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ff05be7-ab6d-38f1-99f0-c171c362191c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Spannung', part.name_en = 'Spannung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11436 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1d288e4a-3565-4896-b90a-c64525ef4043' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d288e4a-3565-4896-b90a-c64525ef4043', 5, NULL, 'Spannung', 'Spannung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11436 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d288e4a-3565-4896-b90a-c64525ef4043'
);


-- Op. 31 3개의 4중창 Op. 31

UPDATE pieces piece
SET piece.title = '3개의 4중창 Op. 31', piece.title_en = '3 Quartets, Op. 31',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '31',
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11610 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 11610 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Wechsellied zum Tanze', part.name_en = 'Wechsellied zum Tanze',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11610 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3df7e26f-5dbc-4042-8c8a-020b10c66674' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3df7e26f-5dbc-4042-8c8a-020b10c66674', 1, NULL, 'Wechsellied zum Tanze', 'Wechsellied zum Tanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11610 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3df7e26f-5dbc-4042-8c8a-020b10c66674'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Neckereien', part.name_en = 'Neckereien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11610 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5288e918-49bc-42fb-8e33-62f1a47768fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5288e918-49bc-42fb-8e33-62f1a47768fe', 2, NULL, 'Neckereien', 'Neckereien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11610 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5288e918-49bc-42fb-8e33-62f1a47768fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Der Gang zum Liebchen', part.name_en = 'Der Gang zum Liebchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11610 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:39fd21ae-925c-42f2-ba1e-b367f32dcb0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39fd21ae-925c-42f2-ba1e-b367f32dcb0b', 3, NULL, 'Der Gang zum Liebchen', 'Der Gang zum Liebchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11610 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39fd21ae-925c-42f2-ba1e-b367f32dcb0b'
);


-- Op. 52 4중창 왈츠 <사랑의 노래>

UPDATE pieces piece
SET piece.title = '4중창 왈츠 <사랑의 노래>', piece.title_en = 'Liebeslieder-Walzer, Op. 52',
    piece.type = 'album', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11326 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 11326 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rede, Mädchen, allzu liebes', part.name_en = 'Rede, Mädchen, allzu liebes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3f4b2d6c-45ed-34db-84da-9f09a5f10bdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f4b2d6c-45ed-34db-84da-9f09a5f10bdc', 1, NULL, 'Rede, Mädchen, allzu liebes', 'Rede, Mädchen, allzu liebes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f4b2d6c-45ed-34db-84da-9f09a5f10bdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Am Gesteine rauscht die Flut', part.name_en = 'Am Gesteine rauscht die Flut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b7d666f9-1ac8-363c-b0a4-e9c473a4cf3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7d666f9-1ac8-363c-b0a4-e9c473a4cf3b', 2, NULL, 'Am Gesteine rauscht die Flut', 'Am Gesteine rauscht die Flut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7d666f9-1ac8-363c-b0a4-e9c473a4cf3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O die Frauen', part.name_en = 'O die Frauen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e5f542d9-c2fd-3236-8289-3ab8be1c0a28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5f542d9-c2fd-3236-8289-3ab8be1c0a28', 3, NULL, 'O die Frauen', 'O die Frauen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5f542d9-c2fd-3236-8289-3ab8be1c0a28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Wie des Abends schöne Röte', part.name_en = 'Wie des Abends schöne Röte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:eae7554f-4758-37a0-ab4d-7b8fd886f101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eae7554f-4758-37a0-ab4d-7b8fd886f101', 4, NULL, 'Wie des Abends schöne Röte', 'Wie des Abends schöne Röte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae7554f-4758-37a0-ab4d-7b8fd886f101'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Die grüne Hopfenranke', part.name_en = 'Die grüne Hopfenranke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:dde24802-8d21-35a3-995a-8b8111085f5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dde24802-8d21-35a3-995a-8b8111085f5c', 5, NULL, 'Die grüne Hopfenranke', 'Die grüne Hopfenranke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dde24802-8d21-35a3-995a-8b8111085f5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ein kleiner, hübscher Vogel', part.name_en = 'Ein kleiner, hübscher Vogel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:728594f0-c613-346f-957e-a7398cd5652e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:728594f0-c613-346f-957e-a7398cd5652e', 6, NULL, 'Ein kleiner, hübscher Vogel', 'Ein kleiner, hübscher Vogel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:728594f0-c613-346f-957e-a7398cd5652e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Wohl schön bewandt war es', part.name_en = 'Wohl schön bewandt war es',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:100ece3c-0542-32e4-97ef-72da18e15534' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:100ece3c-0542-32e4-97ef-72da18e15534', 7, NULL, 'Wohl schön bewandt war es', 'Wohl schön bewandt war es', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:100ece3c-0542-32e4-97ef-72da18e15534'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Wenn so lind dein Auge mir', part.name_en = 'Wenn so lind dein Auge mir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:64937320-8ca2-3006-bf19-548c3b79c891' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64937320-8ca2-3006-bf19-548c3b79c891', 8, NULL, 'Wenn so lind dein Auge mir', 'Wenn so lind dein Auge mir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64937320-8ca2-3006-bf19-548c3b79c891'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Am Donaustrande', part.name_en = 'Am Donaustrande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f9ceaca5-d6b3-3c14-b4aa-411412428129' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9ceaca5-d6b3-3c14-b4aa-411412428129', 9, NULL, 'Am Donaustrande', 'Am Donaustrande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9ceaca5-d6b3-3c14-b4aa-411412428129'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'O, wie sanft die Quelle', part.name_en = 'O, wie sanft die Quelle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1dafa480-3142-37e2-ad52-18ac3da7c680' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dafa480-3142-37e2-ad52-18ac3da7c680', 10, NULL, 'O, wie sanft die Quelle', 'O, wie sanft die Quelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dafa480-3142-37e2-ad52-18ac3da7c680'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Nein, es ist nicht auszukommen', part.name_en = 'Nein, es ist nicht auszukommen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5cd5bcb8-ce2c-32c1-8816-621380f3f3f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cd5bcb8-ce2c-32c1-8816-621380f3f3f7', 11, NULL, 'Nein, es ist nicht auszukommen', 'Nein, es ist nicht auszukommen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cd5bcb8-ce2c-32c1-8816-621380f3f3f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Schlosser auf, und mache Schlösser', part.name_en = 'Schlosser auf, und mache Schlösser',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a5fb417b-8af7-3594-aaf0-b9d6fc2d8a20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5fb417b-8af7-3594-aaf0-b9d6fc2d8a20', 12, NULL, 'Schlosser auf, und mache Schlösser', 'Schlosser auf, und mache Schlösser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5fb417b-8af7-3594-aaf0-b9d6fc2d8a20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Vöglein durchrauscht die Luft', part.name_en = 'Vöglein durchrauscht die Luft',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5e6826c2-4a3a-3337-b97f-ddf0e3104503' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e6826c2-4a3a-3337-b97f-ddf0e3104503', 13, NULL, 'Vöglein durchrauscht die Luft', 'Vöglein durchrauscht die Luft', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e6826c2-4a3a-3337-b97f-ddf0e3104503'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Sieh'', wie ist die Welle klar', part.name_en = 'Sieh'', wie ist die Welle klar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ceb4729e-b5a4-3766-8a7c-8167717f2b42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceb4729e-b5a4-3766-8a7c-8167717f2b42', 14, NULL, 'Sieh'', wie ist die Welle klar', 'Sieh'', wie ist die Welle klar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceb4729e-b5a4-3766-8a7c-8167717f2b42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Nachtigall, sie singt so schön', part.name_en = 'Nachtigall, sie singt so schön',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fc7063e9-9a39-3a31-9925-67b4bc1a83a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc7063e9-9a39-3a31-9925-67b4bc1a83a6', 15, NULL, 'Nachtigall, sie singt so schön', 'Nachtigall, sie singt so schön', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc7063e9-9a39-3a31-9925-67b4bc1a83a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Ein dunkeler Schacht ist Liebe', part.name_en = 'Ein dunkeler Schacht ist Liebe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:feb18d2a-5cbf-3580-b2c8-672a6b1500eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feb18d2a-5cbf-3580-b2c8-672a6b1500eb', 16, NULL, 'Ein dunkeler Schacht ist Liebe', 'Ein dunkeler Schacht ist Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feb18d2a-5cbf-3580-b2c8-672a6b1500eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Nicht wandle, mein Licht', part.name_en = 'Nicht wandle, mein Licht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:cf753778-6320-3714-a380-27d42cdc83d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf753778-6320-3714-a380-27d42cdc83d7', 17, NULL, 'Nicht wandle, mein Licht', 'Nicht wandle, mein Licht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf753778-6320-3714-a380-27d42cdc83d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Es bebet das Gesträuche', part.name_en = 'Es bebet das Gesträuche',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11326 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:67320703-7d46-3edc-9dfa-76773901fe6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67320703-7d46-3edc-9dfa-76773901fe6f', 18, NULL, 'Es bebet das Gesträuche', 'Es bebet das Gesträuche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11326 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67320703-7d46-3edc-9dfa-76773901fe6f'
);


-- Op. 64 3개의 4중창 Op. 64

UPDATE pieces piece
SET piece.title = '3개의 4중창 Op. 64', piece.title_en = '3 Quartets, Op. 64',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '64',
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11922 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 11922 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'An die Heimat', part.name_en = 'An die Heimat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11922 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:72d55188-4227-4b81-af6b-ae6226d457e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72d55188-4227-4b81-af6b-ae6226d457e3', 1, NULL, 'An die Heimat', 'An die Heimat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11922 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d55188-4227-4b81-af6b-ae6226d457e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Der Abend', part.name_en = 'Der Abend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11922 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3673f6db-175c-3870-9ff7-40b4cbee2aaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3673f6db-175c-3870-9ff7-40b4cbee2aaf', 2, NULL, 'Der Abend', 'Der Abend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11922 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3673f6db-175c-3870-9ff7-40b4cbee2aaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Fragen', part.name_en = 'Fragen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11922 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:227e41da-1c09-415e-a68b-c8e31386a29e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:227e41da-1c09-415e-a68b-c8e31386a29e', 3, NULL, 'Fragen', 'Fragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11922 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:227e41da-1c09-415e-a68b-c8e31386a29e'
);


-- Op. 65 4중창 왈츠 <새로운 사랑의 노래>

UPDATE pieces piece
SET piece.title = '4중창 왈츠 <새로운 사랑의 노래>', piece.title_en = 'Neue Liebeslieder, Op. 65',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11415 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 11415 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Verzicht, o Herz, auf Rettung', part.name_en = 'Verzicht, o Herz, auf Rettung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:73011c15-25bb-3fef-9ac5-d2213c772870' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73011c15-25bb-3fef-9ac5-d2213c772870', 1, NULL, 'Verzicht, o Herz, auf Rettung', 'Verzicht, o Herz, auf Rettung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73011c15-25bb-3fef-9ac5-d2213c772870'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Finstere Schatten der Nacht', part.name_en = 'Finstere Schatten der Nacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:76809382-1bcf-3748-a062-7a1e99ab1940' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76809382-1bcf-3748-a062-7a1e99ab1940', 2, NULL, 'Finstere Schatten der Nacht', 'Finstere Schatten der Nacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76809382-1bcf-3748-a062-7a1e99ab1940'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'An jeder Hand die Finger', part.name_en = 'An jeder Hand die Finger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5621f8a3-1048-3200-ab47-d69e127403ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5621f8a3-1048-3200-ab47-d69e127403ad', 3, NULL, 'An jeder Hand die Finger', 'An jeder Hand die Finger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5621f8a3-1048-3200-ab47-d69e127403ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ihr schwarzen Augen', part.name_en = 'Ihr schwarzen Augen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fa4357b2-75c7-3755-bc5b-8b2356cae20d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa4357b2-75c7-3755-bc5b-8b2356cae20d', 4, NULL, 'Ihr schwarzen Augen', 'Ihr schwarzen Augen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa4357b2-75c7-3755-bc5b-8b2356cae20d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Wahre, wahre deinen Sohn', part.name_en = 'Wahre, wahre deinen Sohn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c61f6949-ee94-37f4-8823-363366c78d0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c61f6949-ee94-37f4-8823-363366c78d0c', 5, NULL, 'Wahre, wahre deinen Sohn', 'Wahre, wahre deinen Sohn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c61f6949-ee94-37f4-8823-363366c78d0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Rosen steckt mir an die Mutter', part.name_en = 'Rosen steckt mir an die Mutter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9b3c0929-5e68-383b-8537-f764a7344398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b3c0929-5e68-383b-8537-f764a7344398', 6, NULL, 'Rosen steckt mir an die Mutter', 'Rosen steckt mir an die Mutter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b3c0929-5e68-383b-8537-f764a7344398'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vom Gebirge Well'' auf Well''', part.name_en = 'Vom Gebirge Well'' auf Well''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fd1115f7-091b-3076-8335-25fae41faabd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd1115f7-091b-3076-8335-25fae41faabd', 7, NULL, 'Vom Gebirge Well'' auf Well''', 'Vom Gebirge Well'' auf Well''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd1115f7-091b-3076-8335-25fae41faabd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Weiche Gräser im Revier', part.name_en = 'Weiche Gräser im Revier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:522f89ab-57fd-345f-a44c-06e0b9d69673' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:522f89ab-57fd-345f-a44c-06e0b9d69673', 8, NULL, 'Weiche Gräser im Revier', 'Weiche Gräser im Revier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:522f89ab-57fd-345f-a44c-06e0b9d69673'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Nagen am Herzen fühl ich', part.name_en = 'Nagen am Herzen fühl ich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7a0b35d9-c3f0-3cd8-b87a-1022367bbc11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a0b35d9-c3f0-3cd8-b87a-1022367bbc11', 9, NULL, 'Nagen am Herzen fühl ich', 'Nagen am Herzen fühl ich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a0b35d9-c3f0-3cd8-b87a-1022367bbc11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Ich kose süss mit der und der', part.name_en = 'Ich kose süss mit der und der',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7f29c388-bea1-37cb-9342-fc98e7770e69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f29c388-bea1-37cb-9342-fc98e7770e69', 10, NULL, 'Ich kose süss mit der und der', 'Ich kose süss mit der und der', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f29c388-bea1-37cb-9342-fc98e7770e69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Alles, alles in den Wind', part.name_en = 'Alles, alles in den Wind',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f3efd178-4c5a-37c5-83c7-5dcf2e57daf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3efd178-4c5a-37c5-83c7-5dcf2e57daf1', 11, NULL, 'Alles, alles in den Wind', 'Alles, alles in den Wind', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3efd178-4c5a-37c5-83c7-5dcf2e57daf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Schwarzer Wald', part.name_en = 'Schwarzer Wald',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:4b9cb53f-3750-30ce-b44a-29f078a3914e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b9cb53f-3750-30ce-b44a-29f078a3914e', 12, NULL, 'Schwarzer Wald', 'Schwarzer Wald', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b9cb53f-3750-30ce-b44a-29f078a3914e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Nein, Geliebter, setze dich', part.name_en = 'Nein, Geliebter, setze dich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:5475a931-3172-3814-8c94-4194d3defedf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5475a931-3172-3814-8c94-4194d3defedf', 13, NULL, 'Nein, Geliebter, setze dich', 'Nein, Geliebter, setze dich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5475a931-3172-3814-8c94-4194d3defedf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Flammenauge, dunkles Haar', part.name_en = 'Flammenauge, dunkles Haar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:44a3569f-30da-3650-82e8-3c6e9bae2fef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44a3569f-30da-3650-82e8-3c6e9bae2fef', 14, NULL, 'Flammenauge, dunkles Haar', 'Flammenauge, dunkles Haar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44a3569f-30da-3650-82e8-3c6e9bae2fef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Nun, ihr Musen, genug!', part.name_en = 'Nun, ihr Musen, genug!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11415 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c3360ad5-36d2-3f94-9752-9439260d3e38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3360ad5-36d2-3f94-9752-9439260d3e38', 15, NULL, 'Nun, ihr Musen, genug!', 'Nun, ihr Musen, genug!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11415 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3360ad5-36d2-3f94-9752-9439260d3e38'
);


-- Op. 92 4개의 4중창 Op. 92

UPDATE pieces piece
SET piece.title = '4개의 4중창 Op. 92', piece.title_en = '4 Quartets, Op. 92',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '92',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11830 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 11830 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O schöne Nacht!', part.name_en = 'O schöne Nacht!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11830 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:061b289d-6d4e-3872-a5ce-be36eb485d8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:061b289d-6d4e-3872-a5ce-be36eb485d8a', 1, NULL, 'O schöne Nacht!', 'O schöne Nacht!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11830 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:061b289d-6d4e-3872-a5ce-be36eb485d8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Spätherbst', part.name_en = 'Spätherbst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11830 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1c63cfdc-636a-4b10-a25c-3fa5c363c5e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c63cfdc-636a-4b10-a25c-3fa5c363c5e9', 2, NULL, 'Spätherbst', 'Spätherbst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11830 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c63cfdc-636a-4b10-a25c-3fa5c363c5e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Abendlied', part.name_en = 'Abendlied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11830 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:16959fac-77b4-3f54-bf7d-dd5c2888e01c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16959fac-77b4-3f54-bf7d-dd5c2888e01c', 3, NULL, 'Abendlied', 'Abendlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11830 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16959fac-77b4-3f54-bf7d-dd5c2888e01c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Warum?', part.name_en = 'Warum?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11830 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e7fa29f6-19a1-41f5-9371-22ec1f6d08d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7fa29f6-19a1-41f5-9371-22ec1f6d08d7', 4, NULL, 'Warum?', 'Warum?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11830 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7fa29f6-19a1-41f5-9371-22ec1f6d08d7'
);


-- Op. 103 4중창곡집 <집시의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4중창곡집 <집시의 노래>', 'Zigeunerlieder, Op. 103', 'album', 'Op. 103', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4중창곡집 <집시의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3f17397-b3a9-4c9c-b4c3-89f58cce908c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3f17397-b3a9-4c9c-b4c3-89f58cce908c'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3f17397-b3a9-4c9c-b4c3-89f58cce908c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dc5a7f1-0ecf-3690-8cca-8fb323460bb7', 1, NULL, 'He, Zigeuner, greife in die Saiten ein!', 'He, Zigeuner, greife in die Saiten ein!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dc5a7f1-0ecf-3690-8cca-8fb323460bb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af1323e9-d3c9-31c6-b518-7674320cfdc1', 2, NULL, 'Hochgetürmte Rimaflut, wie bist du trüb', 'Hochgetürmte Rimaflut, wie bist du trüb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af1323e9-d3c9-31c6-b518-7674320cfdc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9482297b-2a21-39c0-a77d-3722c1b3f51b', 3, NULL, 'Wißt ihr, wann mein Kindchen am allerschönsten ist?', 'Wißt ihr, wann mein Kindchen am allerschönsten ist?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9482297b-2a21-39c0-a77d-3722c1b3f51b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:125d07e1-3c03-3f71-8621-6d7168adeed5', 4, NULL, 'Lieber Gott, du weißt, wie oft bereut ich hab''', 'Lieber Gott, du weißt, wie oft bereut ich hab''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:125d07e1-3c03-3f71-8621-6d7168adeed5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7345f0bd-b117-3ab3-86f0-55f8c949c62f', 5, NULL, 'Brauner Bursche führt zum Tanze', 'Brauner Bursche führt zum Tanze', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7345f0bd-b117-3ab3-86f0-55f8c949c62f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:781e0506-2c9f-3439-a6d5-fdba74237945', 6, NULL, 'Röslein dreie in der Reihe blühn so rot', 'Röslein dreie in der Reihe blühn so rot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:781e0506-2c9f-3439-a6d5-fdba74237945'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae45b222-3cde-3b8f-af6c-8930e3a5610b', 7, NULL, 'Kommt dir manchmal in den Sinn', 'Kommt dir manchmal in den Sinn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae45b222-3cde-3b8f-af6c-8930e3a5610b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfa3fff2-4baf-47c1-bb40-ed474e430a45', 8, NULL, 'Horch, der Wind klagt in den Zweigen traurig sacht', 'Horch, der Wind klagt in den Zweigen traurig sacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfa3fff2-4baf-47c1-bb40-ed474e430a45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6302730-103a-4f15-b504-5630d89971b5', 9, NULL, 'Weit und breit schaut niemand mich an', 'Weit und breit schaut niemand mich an', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6302730-103a-4f15-b504-5630d89971b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29f3af48-a07b-4712-ad95-ddedec7cae68', 10, NULL, 'Mond verhüllt sein Angesicht', 'Mond verhüllt sein Angesicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29f3af48-a07b-4712-ad95-ddedec7cae68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e39578b-df19-3304-9e1a-7931a8da0f24', 11, NULL, 'Rote Abendwolken ziehn am Firmament', 'Rote Abendwolken ziehn am Firmament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '4중창곡집 <집시의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e39578b-df19-3304-9e1a-7931a8da0f24'
);


-- Op. 112 6개의 4중창 Op. 112

UPDATE pieces piece
SET piece.title = '6개의 4중창 Op. 112', piece.title_en = '6 Quartets, Op. 112',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '112',
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11458 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 11458 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sehnsucht', part.name_en = 'Sehnsucht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11458 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b4c06c57-269a-41b8-961b-36abc3bf423a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4c06c57-269a-41b8-961b-36abc3bf423a', 1, NULL, 'Sehnsucht', 'Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11458 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4c06c57-269a-41b8-961b-36abc3bf423a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nächtens', part.name_en = 'Nächtens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11458 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:44b66798-7aa4-39ce-a622-7bd42c3980fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44b66798-7aa4-39ce-a622-7bd42c3980fb', 2, NULL, 'Nächtens', 'Nächtens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11458 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44b66798-7aa4-39ce-a622-7bd42c3980fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Himmel strahlt so helle', part.name_en = 'Himmel strahlt so helle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11458 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c1d29e8d-9ded-4f48-8f7c-cf0f9b768a06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1d29e8d-9ded-4f48-8f7c-cf0f9b768a06', 3, NULL, 'Himmel strahlt so helle', 'Himmel strahlt so helle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11458 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1d29e8d-9ded-4f48-8f7c-cf0f9b768a06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Rote Rosenknospen', part.name_en = 'Rote Rosenknospen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11458 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6cafbeac-1934-4e3c-a34e-21395775b1ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cafbeac-1934-4e3c-a34e-21395775b1ca', 4, NULL, 'Rote Rosenknospen', 'Rote Rosenknospen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11458 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cafbeac-1934-4e3c-a34e-21395775b1ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Brennessel steht an Weges Rand', part.name_en = 'Brennessel steht an Weges Rand',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11458 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:673cfd96-d7ac-4573-b629-4126ea209ee6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:673cfd96-d7ac-4573-b629-4126ea209ee6', 5, NULL, 'Brennessel steht an Weges Rand', 'Brennessel steht an Weges Rand', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11458 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:673cfd96-d7ac-4573-b629-4126ea209ee6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Liebe Schwalbe, kleine Schwalbe', part.name_en = 'Liebe Schwalbe, kleine Schwalbe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11458 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ab3fe4ab-3e59-45ff-838c-7e4dbf56f94d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab3fe4ab-3e59-45ff-838c-7e4dbf56f94d', 6, NULL, 'Liebe Schwalbe, kleine Schwalbe', 'Liebe Schwalbe, kleine Schwalbe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11458 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab3fe4ab-3e59-45ff-838c-7e4dbf56f94d'
);


-- WoO 17 키리에 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '키리에 G단조', 'Kyrie in G minor', 'song', 'WoO 17', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '키리에 G단조'
);


-- WoO 18 미사 카노니카

UPDATE pieces piece
SET piece.title = '미사 카노니카', piece.title_en = 'Missa canonica',
    piece.type = 'album', piece.opus_number = 'WoO 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11661 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11661 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '키리에', part.name_en = 'Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11661 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bb3a6527-ad20-408a-936c-e3cda691641b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb3a6527-ad20-408a-936c-e3cda691641b', 1, NULL, '키리에', 'Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11661 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb3a6527-ad20-408a-936c-e3cda691641b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '상투스', part.name_en = 'Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11661 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2abd7093-4e4c-45c9-a625-d933b00d03f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2abd7093-4e4c-45c9-a625-d933b00d03f4', 2, NULL, '상투스', 'Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11661 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2abd7093-4e4c-45c9-a625-d933b00d03f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '베네딕투스', part.name_en = 'Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11661 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a66d7632-5ee6-4ab6-92fa-da4e7b5544e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a66d7632-5ee6-4ab6-92fa-da4e7b5544e6', 3, NULL, '베네딕투스', 'Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11661 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a66d7632-5ee6-4ab6-92fa-da4e7b5544e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '아뉴스 데이', part.name_en = 'Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11661 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:59c3d167-2513-4576-a875-8057b37e1704' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59c3d167-2513-4576-a875-8057b37e1704', 4, NULL, '아뉴스 데이', 'Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11661 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59c3d167-2513-4576-a875-8057b37e1704'
);


-- Op. 45 독일 레퀴엠

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Selig sind, die da Leid tragen', part.name_en = 'I. Selig sind, die da Leid tragen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 157 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bf06d01e-dc3d-39a1-a1fa-0e1ed3110977' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf06d01e-dc3d-39a1-a1fa-0e1ed3110977', 1, 'I', 'Selig sind, die da Leid tragen', 'I. Selig sind, die da Leid tragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 157 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf06d01e-dc3d-39a1-a1fa-0e1ed3110977'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Denn alles Fleisch, es ist wie Gras', part.name_en = 'II. Denn alles Fleisch, es ist wie Gras',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 157 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c29780e7-625c-39fc-b48f-b718c7992452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c29780e7-625c-39fc-b48f-b718c7992452', 2, 'II', 'Denn alles Fleisch, es ist wie Gras', 'II. Denn alles Fleisch, es ist wie Gras', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 157 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c29780e7-625c-39fc-b48f-b718c7992452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Herr, lehre doch mich', part.name_en = 'III. Herr, lehre doch mich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 157 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:049941b2-fb4b-34ab-bf5c-eb32d1f1ba5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:049941b2-fb4b-34ab-bf5c-eb32d1f1ba5f', 3, 'III', 'Herr, lehre doch mich', 'III. Herr, lehre doch mich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 157 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:049941b2-fb4b-34ab-bf5c-eb32d1f1ba5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Wie lieblich sind deine Wohnungen', part.name_en = 'IV. Wie lieblich sind deine Wohnungen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 157 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2f329662-c95a-3a0b-9fd7-bd519ced9cd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f329662-c95a-3a0b-9fd7-bd519ced9cd5', 4, 'IV', 'Wie lieblich sind deine Wohnungen', 'IV. Wie lieblich sind deine Wohnungen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 157 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f329662-c95a-3a0b-9fd7-bd519ced9cd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ihr habt nun Traurigkeit', part.name_en = 'V. Ihr habt nun Traurigkeit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 157 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6e9211ff-776d-3743-8d00-f4fc3d2cd9aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e9211ff-776d-3743-8d00-f4fc3d2cd9aa', 5, 'V', 'Ihr habt nun Traurigkeit', 'V. Ihr habt nun Traurigkeit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 157 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e9211ff-776d-3743-8d00-f4fc3d2cd9aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Denn wir haben hie keine bleibende Statt', part.name_en = 'VI. Denn wir haben hie keine bleibende Statt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 157 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f1465e6d-e31e-35ae-a2b8-5db4182c1058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1465e6d-e31e-35ae-a2b8-5db4182c1058', 6, 'VI', 'Denn wir haben hie keine bleibende Statt', 'VI. Denn wir haben hie keine bleibende Statt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 157 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1465e6d-e31e-35ae-a2b8-5db4182c1058'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Selig sind die Toten', part.name_en = 'VII. Selig sind die Toten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 157 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:02147004-2e5a-320e-a9ca-d5e8ee254e49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02147004-2e5a-320e-a9ca-d5e8ee254e49', 7, 'VII', 'Selig sind die Toten', 'VII. Selig sind die Toten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 157 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02147004-2e5a-320e-a9ca-d5e8ee254e49'
);


-- Op. 30 합창곡 <영적인 노래>

UPDATE pieces piece
SET piece.title = '합창곡 <영적인 노래>', piece.title_en = 'Geistliches Lied',
    piece.type = 'song', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1856, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11295 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1856
WHERE piece.id = 11295 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 12 합창곡 <아베 마리아>

UPDATE pieces piece
SET piece.title = '합창곡 <아베 마리아>', piece.title_en = 'Ave Maria',
    piece.type = 'song', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11701 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 11701 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 27 합창곡 <시편 13편>

UPDATE pieces piece
SET piece.title = '합창곡 <시편 13편>', piece.title_en = 'Psalm 13',
    piece.type = 'song', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11321 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 11321 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 29 2개의 모테트 Op. 29

UPDATE pieces piece
SET piece.title = '2개의 모테트 Op. 29', piece.title_en = '2 Motets, Op. 29',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '29',
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11459 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 11459 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Es ist das Heil uns kommen her', part.name_en = 'Es ist das Heil uns kommen her',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11459 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:12eeedae-3b7d-36f0-a715-0636e1bc110a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12eeedae-3b7d-36f0-a715-0636e1bc110a', 1, NULL, 'Es ist das Heil uns kommen her', 'Es ist das Heil uns kommen her', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11459 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12eeedae-3b7d-36f0-a715-0636e1bc110a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Schaffe in mir, Gott, ein rein Herz', part.name_en = 'Schaffe in mir, Gott, ein rein Herz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11459 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6d9452b6-a2cd-348e-8254-fb0c3acc7778' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d9452b6-a2cd-348e-8254-fb0c3acc7778', 2, NULL, 'Schaffe in mir, Gott, ein rein Herz', 'Schaffe in mir, Gott, ein rein Herz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11459 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d9452b6-a2cd-348e-8254-fb0c3acc7778'
);


-- Op. 37 3개의 종교 합창곡 Op. 37

UPDATE pieces piece
SET piece.title = '3개의 종교 합창곡 Op. 37', piece.title_en = '3 Sacred Choruses, Op. 37',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '37',
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11390 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 11390 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O bone Jesu', part.name_en = 'O bone Jesu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11390 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:365eed69-8e8e-3ceb-a2c7-343b7772bc05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:365eed69-8e8e-3ceb-a2c7-343b7772bc05', 1, NULL, 'O bone Jesu', 'O bone Jesu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11390 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:365eed69-8e8e-3ceb-a2c7-343b7772bc05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adoramus te, Christe', part.name_en = 'Adoramus te, Christe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11390 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ef034e7a-ecf6-3b77-bd7e-9aad9e6fdd83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef034e7a-ecf6-3b77-bd7e-9aad9e6fdd83', 2, NULL, 'Adoramus te, Christe', 'Adoramus te, Christe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11390 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef034e7a-ecf6-3b77-bd7e-9aad9e6fdd83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Regina coeli', part.name_en = 'Regina coeli',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11390 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2db04cfd-9f78-35a7-8bf8-679315b0bce5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2db04cfd-9f78-35a7-8bf8-679315b0bce5', 3, NULL, 'Regina coeli', 'Regina coeli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11390 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2db04cfd-9f78-35a7-8bf8-679315b0bce5'
);


-- Op. 74 2개의 모테트 Op. 74

UPDATE pieces piece
SET piece.title = '2개의 모테트 Op. 74', piece.title_en = '2 Motets, Op. 74',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '74',
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11604 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 11604 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Warum ist das Licht gegeben dem Mühseligen?', part.name_en = 'Warum ist das Licht gegeben dem Mühseligen?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11604 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:31a8acf2-9d87-3bae-9478-60cf9bb2dab4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31a8acf2-9d87-3bae-9478-60cf9bb2dab4', 1, NULL, 'Warum ist das Licht gegeben dem Mühseligen?', 'Warum ist das Licht gegeben dem Mühseligen?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11604 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31a8acf2-9d87-3bae-9478-60cf9bb2dab4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'O Heiland, reiß die Himmel auf', part.name_en = 'O Heiland, reiß die Himmel auf',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11604 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a310ca71-0ae6-335e-be1d-88d3b4610ed3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a310ca71-0ae6-335e-be1d-88d3b4610ed3', 2, NULL, 'O Heiland, reiß die Himmel auf', 'O Heiland, reiß die Himmel auf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11604 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a310ca71-0ae6-335e-be1d-88d3b4610ed3'
);


-- Op. 109 모테트 <축제와 기념의 격언>

UPDATE pieces piece
SET piece.title = '모테트 <축제와 기념의 격언>', piece.title_en = 'Fest- und Gedenksprüche, Op. 109',
    piece.type = 'album', piece.opus_number = 'Op. 109',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11557 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 11557 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Unsere Väter hofften auf dich', part.name_en = 'Unsere Väter hofften auf dich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11557 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7fc5bf53-d3be-4019-8862-98cfdd3566c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fc5bf53-d3be-4019-8862-98cfdd3566c8', 1, NULL, 'Unsere Väter hofften auf dich', 'Unsere Väter hofften auf dich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11557 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fc5bf53-d3be-4019-8862-98cfdd3566c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Wenn ein starker Gewappneter', part.name_en = 'Wenn ein starker Gewappneter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11557 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:017fdc13-dddb-460a-bb89-623ab2a6b68f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:017fdc13-dddb-460a-bb89-623ab2a6b68f', 2, NULL, 'Wenn ein starker Gewappneter', 'Wenn ein starker Gewappneter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11557 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:017fdc13-dddb-460a-bb89-623ab2a6b68f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Wo ist ein so herrlich Volk', part.name_en = 'Wo ist ein so herrlich Volk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11557 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9fe95aff-84cf-44a9-9a90-a47fd94ad6ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fe95aff-84cf-44a9-9a90-a47fd94ad6ef', 3, NULL, 'Wo ist ein so herrlich Volk', 'Wo ist ein so herrlich Volk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11557 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fe95aff-84cf-44a9-9a90-a47fd94ad6ef'
);


-- Op. 110 3개의 모테트 Op. 110

UPDATE pieces piece
SET piece.title = '3개의 모테트 Op. 110', piece.title_en = '3 Motets, Op. 110',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '110',
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11983 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 11983 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ich aber bin elend', part.name_en = 'Ich aber bin elend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11983 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:dba564cc-42ad-4905-9041-e02dc8009c41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dba564cc-42ad-4905-9041-e02dc8009c41', 1, NULL, 'Ich aber bin elend', 'Ich aber bin elend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11983 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dba564cc-42ad-4905-9041-e02dc8009c41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ach, arme Welt, du trügest mich', part.name_en = 'Ach, arme Welt, du trügest mich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11983 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3d493afd-7583-4cf6-92e4-3e22279a2d24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d493afd-7583-4cf6-92e4-3e22279a2d24', 2, NULL, 'Ach, arme Welt, du trügest mich', 'Ach, arme Welt, du trügest mich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11983 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d493afd-7583-4cf6-92e4-3e22279a2d24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Wenn wir in höchsten Nöten sein', part.name_en = 'Wenn wir in höchsten Nöten sein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11983 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:43a306cf-3ade-3f0a-aaa8-0639a987e103' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43a306cf-3ade-3f0a-aaa8-0639a987e103', 3, NULL, 'Wenn wir in höchsten Nöten sein', 'Wenn wir in höchsten Nöten sein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11983 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43a306cf-3ade-3f0a-aaa8-0639a987e103'
);


-- Op. 50 칸타타 <리날도>

UPDATE pieces piece
SET piece.title = '칸타타 <리날도>', piece.title_en = 'Rinaldo',
    piece.type = 'song', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11567 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 11567 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 16 작은 결혼 칸타타

UPDATE pieces piece
SET piece.title = '작은 결혼 칸타타', piece.title_en = 'Kleine Hochzeitskantate',
    piece.type = 'song', piece.opus_number = 'WoO 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11656 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 11656 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 28 카논 <Töne, lindernder Klang>

UPDATE pieces piece
SET piece.title = '카논 <Töne, lindernder Klang>', piece.title_en = 'Töne, lindernder Klang (canon)',
    piece.type = 'song', piece.opus_number = 'WoO 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11622 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11622 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 24 카논 <Grausam erweiset sich Amor>

UPDATE pieces piece
SET piece.title = '카논 <Grausam erweiset sich Amor>', piece.title_en = 'Grausam erweiset sich Amor (canon)',
    piece.type = 'song', piece.opus_number = 'WoO 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11783 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 11783 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 26 카논 <O wie sanft!>

UPDATE pieces piece
SET piece.title = '카논 <O wie sanft!>', piece.title_en = 'O wie sanft! (canon)',
    piece.type = 'song', piece.opus_number = 'WoO 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1870, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11969 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1870
WHERE piece.id = 11969 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 30 카논 <Zu Rauch muss werden>

UPDATE pieces piece
SET piece.title = '카논 <Zu Rauch muss werden>', piece.title_en = 'Zu Rauch muss werden (canon)',
    piece.type = 'song', piece.opus_number = 'WoO 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1870, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11797 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1870
WHERE piece.id = 11797 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 25 카논 <Mir lächelt kein Frühling>

UPDATE pieces piece
SET piece.title = '카논 <Mir lächelt kein Frühling>', piece.title_en = 'Mir lächelt kein Frühling (canon)',
    piece.type = 'song', piece.opus_number = 'WoO 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11710 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 11710 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- WoO 29 카논 <Wann?>

UPDATE pieces piece
SET piece.title = '카논 <Wann?>', piece.title_en = 'Wann? (canon)',
    piece.type = 'song', piece.opus_number = 'WoO 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11811 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 11811 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 113 여성 합창을 위한 13개의 카논 Op. 113

UPDATE pieces piece
SET piece.title = '여성 합창을 위한 13개의 카논 Op. 113', piece.title_en = '13 Canons for female chorus, Op. 113',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '113',
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11734 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 11734 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Göttlicher Morpheus', part.name_en = 'Göttlicher Morpheus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3daf601e-7c86-4716-bfd2-d965302074dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3daf601e-7c86-4716-bfd2-d965302074dc', 1, NULL, 'Göttlicher Morpheus', 'Göttlicher Morpheus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3daf601e-7c86-4716-bfd2-d965302074dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Grausam erweiset sich Amor am mir', part.name_en = 'Grausam erweiset sich Amor am mir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0f870c7b-5515-4006-8f24-2bdc84f83971' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f870c7b-5515-4006-8f24-2bdc84f83971', 2, NULL, 'Grausam erweiset sich Amor am mir', 'Grausam erweiset sich Amor am mir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f870c7b-5515-4006-8f24-2bdc84f83971'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sitzt a schöns Vögerl aufm Dannabaum', part.name_en = 'Sitzt a schöns Vögerl aufm Dannabaum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:86f61fe3-64f8-45ce-a778-c4c8ad43b588' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86f61fe3-64f8-45ce-a778-c4c8ad43b588', 3, NULL, 'Sitzt a schöns Vögerl aufm Dannabaum', 'Sitzt a schöns Vögerl aufm Dannabaum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86f61fe3-64f8-45ce-a778-c4c8ad43b588'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Schlaf, Kindlein, schlaf!', part.name_en = 'Schlaf, Kindlein, schlaf!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:24a5a7ce-9bfa-4a92-9d84-d59515d05a69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24a5a7ce-9bfa-4a92-9d84-d59515d05a69', 4, NULL, 'Schlaf, Kindlein, schlaf!', 'Schlaf, Kindlein, schlaf!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24a5a7ce-9bfa-4a92-9d84-d59515d05a69'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Wille, wille, will', part.name_en = 'Wille, wille, will',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3ed79df5-d9bd-4724-a538-c356689e8381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ed79df5-d9bd-4724-a538-c356689e8381', 5, NULL, 'Wille, wille, will', 'Wille, wille, will', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ed79df5-d9bd-4724-a538-c356689e8381'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'So lange Schönheit wird bestehn', part.name_en = 'So lange Schönheit wird bestehn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6451ebb4-fea4-497a-a349-a2346797ca77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6451ebb4-fea4-497a-a349-a2346797ca77', 6, NULL, 'So lange Schönheit wird bestehn', 'So lange Schönheit wird bestehn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6451ebb4-fea4-497a-a349-a2346797ca77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Wenn die Klänge nahn und fliehen', part.name_en = 'Wenn die Klänge nahn und fliehen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1064aa65-128d-4f65-b832-66831a59654e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1064aa65-128d-4f65-b832-66831a59654e', 7, NULL, 'Wenn die Klänge nahn und fliehen', 'Wenn die Klänge nahn und fliehen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1064aa65-128d-4f65-b832-66831a59654e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Ein Gems auf dem Stein', part.name_en = 'Ein Gems auf dem Stein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e74c3c08-4fae-431a-9f77-ed821b61bce3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e74c3c08-4fae-431a-9f77-ed821b61bce3', 8, NULL, 'Ein Gems auf dem Stein', 'Ein Gems auf dem Stein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e74c3c08-4fae-431a-9f77-ed821b61bce3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ans Auge des Liebsten', part.name_en = 'Ans Auge des Liebsten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:eae6ff74-1f81-4170-873e-64aad9cc75a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eae6ff74-1f81-4170-873e-64aad9cc75a4', 9, NULL, 'Ans Auge des Liebsten', 'Ans Auge des Liebsten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eae6ff74-1f81-4170-873e-64aad9cc75a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Leise Töne der Brust', part.name_en = 'Leise Töne der Brust',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e84a5168-7eb0-47cc-b42d-16922df36bb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e84a5168-7eb0-47cc-b42d-16922df36bb4', 10, NULL, 'Leise Töne der Brust', 'Leise Töne der Brust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e84a5168-7eb0-47cc-b42d-16922df36bb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ich weiss nicht was im Hain die Taube girret', part.name_en = 'Ich weiss nicht was im Hain die Taube girret',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1c4b084d-8a7b-423b-8cc2-c549c8f4e943' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c4b084d-8a7b-423b-8cc2-c549c8f4e943', 11, NULL, 'Ich weiss nicht was im Hain die Taube girret', 'Ich weiss nicht was im Hain die Taube girret', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c4b084d-8a7b-423b-8cc2-c549c8f4e943'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Wenn Kummer hätte zu töten Macht', part.name_en = 'Wenn Kummer hätte zu töten Macht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7adb92d6-b9de-424c-a1cd-fde3bc52b5a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7adb92d6-b9de-424c-a1cd-fde3bc52b5a9', 12, NULL, 'Wenn Kummer hätte zu töten Macht', 'Wenn Kummer hätte zu töten Macht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7adb92d6-b9de-424c-a1cd-fde3bc52b5a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Einförmig ist der Liebe Gram', part.name_en = 'Einförmig ist der Liebe Gram',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11734 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b5c30c07-1367-3b21-99c9-5f29486dddfd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5c30c07-1367-3b21-99c9-5f29486dddfd', 13, NULL, 'Einförmig ist der Liebe Gram', 'Einförmig ist der Liebe Gram', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11734 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5c30c07-1367-3b21-99c9-5f29486dddfd'
);


-- Op. 13 합창곡 <장송가>

UPDATE pieces piece
SET piece.title = '합창곡 <장송가>', piece.title_en = 'Begräbnisgesang',
    piece.type = 'song', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11855 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 11855 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 17 여성 합창을 위한 4개의 노래 Op. 17

UPDATE pieces piece
SET piece.title = '여성 합창을 위한 4개의 노래 Op. 17', piece.title_en = '4 Gesänge for female chorus, 2 horns and harp, Op. 17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '17',
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11602 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 11602 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Es tönt ein voller Harfenklang', part.name_en = 'Es tönt ein voller Harfenklang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11602 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b8d89c8b-cd2d-315f-a1c9-d4f964634def' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d89c8b-cd2d-315f-a1c9-d4f964634def', 1, NULL, 'Es tönt ein voller Harfenklang', 'Es tönt ein voller Harfenklang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11602 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d89c8b-cd2d-315f-a1c9-d4f964634def'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lied von Shakespeare', part.name_en = 'Lied von Shakespeare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11602 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:d9491410-5551-415f-abb5-ac7606af13b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9491410-5551-415f-abb5-ac7606af13b2', 2, NULL, 'Lied von Shakespeare', 'Lied von Shakespeare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11602 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9491410-5551-415f-abb5-ac7606af13b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Der Gärtner', part.name_en = 'Der Gärtner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11602 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:6797cec3-e545-4f61-b404-70bb0ecaff18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6797cec3-e545-4f61-b404-70bb0ecaff18', 3, NULL, 'Der Gärtner', 'Der Gärtner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11602 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6797cec3-e545-4f61-b404-70bb0ecaff18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Gesang aus Fingal', part.name_en = 'Gesang aus Fingal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11602 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ac8c5293-3b41-410a-9726-2128999bf6b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac8c5293-3b41-410a-9726-2128999bf6b0', 4, NULL, 'Gesang aus Fingal', 'Gesang aus Fingal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11602 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac8c5293-3b41-410a-9726-2128999bf6b0'
);


-- Op. 22 합창곡집 <마리아의 노래>

UPDATE pieces piece
SET piece.title = '합창곡집 <마리아의 노래>', piece.title_en = 'Marienlieder, Op. 22',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11971 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 11971 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der englische Gruß', part.name_en = 'Der englische Gruß',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11971 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bca17c9c-fdc7-3d0e-812e-d3217fe61cb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bca17c9c-fdc7-3d0e-812e-d3217fe61cb7', 1, NULL, 'Der englische Gruß', 'Der englische Gruß', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11971 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bca17c9c-fdc7-3d0e-812e-d3217fe61cb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Marias Kirchgang', part.name_en = 'Marias Kirchgang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11971 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a27175a4-72bf-3c0c-8460-42182e44657c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a27175a4-72bf-3c0c-8460-42182e44657c', 2, NULL, 'Marias Kirchgang', 'Marias Kirchgang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11971 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a27175a4-72bf-3c0c-8460-42182e44657c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Marias Wallfahrt', part.name_en = 'Marias Wallfahrt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11971 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:f65b04e4-8a6a-323a-b7b9-c008a5cacace' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f65b04e4-8a6a-323a-b7b9-c008a5cacace', 3, NULL, 'Marias Wallfahrt', 'Marias Wallfahrt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11971 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f65b04e4-8a6a-323a-b7b9-c008a5cacace'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der Jäger', part.name_en = 'Der Jäger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11971 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b0ce002d-8c70-3e01-8c6f-cda4089ef023' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0ce002d-8c70-3e01-8c6f-cda4089ef023', 4, NULL, 'Der Jäger', 'Der Jäger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11971 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0ce002d-8c70-3e01-8c6f-cda4089ef023'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ruf zur Maria', part.name_en = 'Ruf zur Maria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11971 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9f95e8dc-3527-318d-9000-b72a400cdf5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f95e8dc-3527-318d-9000-b72a400cdf5c', 5, NULL, 'Ruf zur Maria', 'Ruf zur Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11971 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f95e8dc-3527-318d-9000-b72a400cdf5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Magdalena', part.name_en = 'Magdalena',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11971 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3701a262-ac59-37b9-96eb-f93396eda3e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3701a262-ac59-37b9-96eb-f93396eda3e0', 6, NULL, 'Magdalena', 'Magdalena', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11971 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3701a262-ac59-37b9-96eb-f93396eda3e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Marias Lob', part.name_en = 'Marias Lob',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11971 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:41a78e6f-e048-386d-8769-04f5e4ade81c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41a78e6f-e048-386d-8769-04f5e4ade81c', 7, NULL, 'Marias Lob', 'Marias Lob', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11971 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41a78e6f-e048-386d-8769-04f5e4ade81c'
);


-- Op. 44 여성 합창을 위한 12개의 가곡과 로망스 Op. 44

UPDATE pieces piece
SET piece.title = '여성 합창을 위한 12개의 가곡과 로망스 Op. 44', piece.title_en = '12 Lieder und Romanzen for female chorus, Op. 44',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '44',
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11853 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 11853 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Minnelied', part.name_en = 'Minnelied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:1816c49a-2a16-4ab8-b689-eed580847593' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1816c49a-2a16-4ab8-b689-eed580847593', 1, NULL, 'Minnelied', 'Minnelied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1816c49a-2a16-4ab8-b689-eed580847593'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Der Bräutigam', part.name_en = 'Der Bräutigam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b1fa5c2d-f010-44bf-844f-6c1978765527' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1fa5c2d-f010-44bf-844f-6c1978765527', 2, NULL, 'Der Bräutigam', 'Der Bräutigam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1fa5c2d-f010-44bf-844f-6c1978765527'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Barcarole', part.name_en = 'Barcarole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:48956e52-489c-49ff-ace0-3ae845de2016' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48956e52-489c-49ff-ace0-3ae845de2016', 3, NULL, 'Barcarole', 'Barcarole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48956e52-489c-49ff-ace0-3ae845de2016'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fragen', part.name_en = 'Fragen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:9befefff-5c28-48c4-b4ec-db52f9baee34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9befefff-5c28-48c4-b4ec-db52f9baee34', 4, NULL, 'Fragen', 'Fragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9befefff-5c28-48c4-b4ec-db52f9baee34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Die Müllerin', part.name_en = 'Die Müllerin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:391f9d72-3c20-4a6a-beb3-0408b4803e75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:391f9d72-3c20-4a6a-beb3-0408b4803e75', 5, NULL, 'Die Müllerin', 'Die Müllerin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:391f9d72-3c20-4a6a-beb3-0408b4803e75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Die Nonne', part.name_en = 'Die Nonne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e13a5680-e1c0-438a-bc01-8081773c5fc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e13a5680-e1c0-438a-bc01-8081773c5fc9', 6, NULL, 'Die Nonne', 'Die Nonne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e13a5680-e1c0-438a-bc01-8081773c5fc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Nun stehn die Rosen in Blüte', part.name_en = 'Nun stehn die Rosen in Blüte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c4e9cc9c-3b37-4a64-afc4-67e36355ee4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4e9cc9c-3b37-4a64-afc4-67e36355ee4b', 7, NULL, 'Nun stehn die Rosen in Blüte', 'Nun stehn die Rosen in Blüte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4e9cc9c-3b37-4a64-afc4-67e36355ee4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Die Berge sind spitz', part.name_en = 'Die Berge sind spitz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3b7e5ad6-15b9-42b8-b41a-9cf3d31160fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b7e5ad6-15b9-42b8-b41a-9cf3d31160fb', 8, NULL, 'Die Berge sind spitz', 'Die Berge sind spitz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7e5ad6-15b9-42b8-b41a-9cf3d31160fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Am Wildbach die Weiden', part.name_en = 'Am Wildbach die Weiden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a8d0c305-8481-4b8d-9238-e2e3b4a16cc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8d0c305-8481-4b8d-9238-e2e3b4a16cc5', 9, NULL, 'Am Wildbach die Weiden', 'Am Wildbach die Weiden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8d0c305-8481-4b8d-9238-e2e3b4a16cc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Und gehst du über den Kirchhof', part.name_en = 'Und gehst du über den Kirchhof',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:b23e0fff-80c0-4c79-ae7d-39700e66614d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b23e0fff-80c0-4c79-ae7d-39700e66614d', 10, NULL, 'Und gehst du über den Kirchhof', 'Und gehst du über den Kirchhof', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b23e0fff-80c0-4c79-ae7d-39700e66614d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Die Braut', part.name_en = 'Die Braut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8b0ed624-1bb5-4cfc-8cb4-f7e36c708e88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b0ed624-1bb5-4cfc-8cb4-f7e36c708e88', 11, NULL, 'Die Braut', 'Die Braut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b0ed624-1bb5-4cfc-8cb4-f7e36c708e88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Märznacht', part.name_en = 'Märznacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11853 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:eb3cc3e9-0160-41ec-9470-109cb02654c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb3cc3e9-0160-41ec-9470-109cb02654c3', 12, NULL, 'Märznacht', 'Märznacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11853 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb3cc3e9-0160-41ec-9470-109cb02654c3'
);


-- WoO 19 합창곡 <Dein Herzlein mild>

UPDATE pieces piece
SET piece.title = '합창곡 <Dein Herzlein mild>', piece.title_en = 'Dein Herzlein mild',
    piece.type = 'song', piece.opus_number = 'WoO 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11991 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 11991 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 42 혼성 합창을 위한 3개의 노래 Op. 42

UPDATE pieces piece
SET piece.title = '혼성 합창을 위한 3개의 노래 Op. 42', piece.title_en = '3 Gesänge for six-part chorus, Op. 42',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '42',
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11796 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 11796 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Abendständchen', part.name_en = 'Abendständchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11796 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3f148846-73db-3933-a02c-8682d701b556' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f148846-73db-3933-a02c-8682d701b556', 1, NULL, 'Abendständchen', 'Abendständchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11796 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f148846-73db-3933-a02c-8682d701b556'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vineta', part.name_en = 'Vineta',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11796 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7c6a7f57-d857-488d-aa45-eda2527a27fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c6a7f57-d857-488d-aa45-eda2527a27fd', 2, NULL, 'Vineta', 'Vineta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11796 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c6a7f57-d857-488d-aa45-eda2527a27fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Darthulas Grabgesang', part.name_en = 'Darthulas Grabgesang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11796 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:12268c7a-7273-30a3-a88b-836230e660f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12268c7a-7273-30a3-a88b-836230e660f7', 3, NULL, 'Darthulas Grabgesang', 'Darthulas Grabgesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11796 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12268c7a-7273-30a3-a88b-836230e660f7'
);


-- Op. 41 남성 합창을 위한 5개의 가곡 Op. 41

UPDATE pieces piece
SET piece.title = '남성 합창을 위한 5개의 가곡 Op. 41', piece.title_en = '5 Lieder for male chorus, Op. 41',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '41',
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11881 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 11881 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ich schwing mein Horn ins Jammertal', part.name_en = 'Ich schwing mein Horn ins Jammertal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11881 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e9e8fdca-1668-35bd-b2aa-a6b7f3b80e5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9e8fdca-1668-35bd-b2aa-a6b7f3b80e5b', 1, NULL, 'Ich schwing mein Horn ins Jammertal', 'Ich schwing mein Horn ins Jammertal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11881 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9e8fdca-1668-35bd-b2aa-a6b7f3b80e5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Freiwillige her!', part.name_en = 'Freiwillige her!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11881 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:7a85c848-9d07-404e-8d16-63ccac2991f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a85c848-9d07-404e-8d16-63ccac2991f8', 2, NULL, 'Freiwillige her!', 'Freiwillige her!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11881 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a85c848-9d07-404e-8d16-63ccac2991f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Geleit', part.name_en = 'Geleit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11881 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:65ffab5b-a7c6-46ea-bee3-0589ed18a72d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65ffab5b-a7c6-46ea-bee3-0589ed18a72d', 3, NULL, 'Geleit', 'Geleit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11881 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65ffab5b-a7c6-46ea-bee3-0589ed18a72d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Marschieren', part.name_en = 'Marschieren',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11881 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:e149429d-087a-4289-874a-7ad1599c219c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e149429d-087a-4289-874a-7ad1599c219c', 4, NULL, 'Marschieren', 'Marschieren', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11881 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e149429d-087a-4289-874a-7ad1599c219c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Gebt acht!', part.name_en = 'Gebt acht!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11881 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:ffb2f9d7-19ff-40f6-ad48-a823843a779e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffb2f9d7-19ff-40f6-ad48-a823843a779e', 5, NULL, 'Gebt acht!', 'Gebt acht!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11881 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffb2f9d7-19ff-40f6-ad48-a823843a779e'
);


-- Op. 53 알토 랩소디

UPDATE pieces piece
SET piece.title = '알토 랩소디', piece.title_en = 'Alto Rhapsody',
    piece.type = 'song', piece.opus_number = 'Op. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11344 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 11344 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 54 합창곡 <운명의 노래>

UPDATE pieces piece
SET piece.title = '합창곡 <운명의 노래>', piece.title_en = 'Schicksalslied (Song of Destiny)',
    piece.type = 'song', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11300 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 11300 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 55 합창곡 <승리의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <승리의 노래>', 'Triumphlied (Song of Triumph)', 'album', 'Op. 55', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 33
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <승리의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67667241-0b18-452b-b878-e52528566786'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '67667241-0b18-452b-b878-e52528566786'
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '합창곡 <승리의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67667241-0b18-452b-b878-e52528566786'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:add7b94d-7f84-3004-9e37-28199102e29f', 1, 'I', 'Lebhaft, feierlich „Halleluja! Heil und Preis“', 'I. Lebhaft, feierlich „Halleluja! Heil und Preis“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '합창곡 <승리의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:add7b94d-7f84-3004-9e37-28199102e29f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd0cc7ef-6e1d-31b4-abe8-4a374a8d7f65', 2, 'II', 'Mäßig belebt – Lebhaft – Ziemlich langsam, doch nicht schleppend „Lobet unsern Gott“', 'II. Mäßig belebt – Lebhaft – Ziemlich langsam, doch nicht schleppend „Lobet unsern Gott“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '합창곡 <승리의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd0cc7ef-6e1d-31b4-abe8-4a374a8d7f65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc07811a-af74-33c9-a4a8-944160c95fd0', 3, 'III', 'Lebhaft, feierlich „Und ich sahe den Himmel aufgetan“', 'III. Lebhaft, feierlich „Und ich sahe den Himmel aufgetan“', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 33 AND p.title = '합창곡 <승리의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc07811a-af74-33c9-a4a8-944160c95fd0'
);


-- Op. 62 혼성 합창을 위한 7개의 가곡 Op. 62

UPDATE pieces piece
SET piece.title = '혼성 합창을 위한 7개의 가곡 Op. 62', piece.title_en = '7 Lieder for mixed chorus, Op. 62',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '62',
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11507 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 11507 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rosmarin', part.name_en = 'Rosmarin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11507 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:03b93754-385f-45f2-ab0e-50b71280b439' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03b93754-385f-45f2-ab0e-50b71280b439', 1, NULL, 'Rosmarin', 'Rosmarin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11507 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03b93754-385f-45f2-ab0e-50b71280b439'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Von alten Liebesliedern', part.name_en = 'Von alten Liebesliedern',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11507 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:bd237ebf-61ad-4f25-958a-d5f407d94843' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd237ebf-61ad-4f25-958a-d5f407d94843', 2, NULL, 'Von alten Liebesliedern', 'Von alten Liebesliedern', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11507 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd237ebf-61ad-4f25-958a-d5f407d94843'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Waldesnacht', part.name_en = 'Waldesnacht',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11507 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:a21eb0dd-1828-370f-8476-bcade0e710c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a21eb0dd-1828-370f-8476-bcade0e710c1', 3, NULL, 'Waldesnacht', 'Waldesnacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11507 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a21eb0dd-1828-370f-8476-bcade0e710c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dein Herzlein mild', part.name_en = 'Dein Herzlein mild',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11507 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:c89176f9-71a6-485d-ac28-375e9d734815' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c89176f9-71a6-485d-ac28-375e9d734815', 4, NULL, 'Dein Herzlein mild', 'Dein Herzlein mild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11507 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c89176f9-71a6-485d-ac28-375e9d734815'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'All meine Herzgedanken', part.name_en = 'All meine Herzgedanken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11507 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:8e9a908d-a461-4309-9e57-21e2b79ab1da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e9a908d-a461-4309-9e57-21e2b79ab1da', 5, NULL, 'All meine Herzgedanken', 'All meine Herzgedanken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11507 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e9a908d-a461-4309-9e57-21e2b79ab1da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Es geht ein Wehen durch den Wald', part.name_en = 'Es geht ein Wehen durch den Wald',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11507 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:2a2dffca-ab26-49ab-80a0-99b145edaf73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a2dffca-ab26-49ab-80a0-99b145edaf73', 6, NULL, 'Es geht ein Wehen durch den Wald', 'Es geht ein Wehen durch den Wald', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11507 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a2dffca-ab26-49ab-80a0-99b145edaf73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vergangen ist mir Glück und Heil', part.name_en = 'Vergangen ist mir Glück und Heil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11507 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:595f85b3-cb9a-40b8-8630-96f20457077e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:595f85b3-cb9a-40b8-8630-96f20457077e', 7, NULL, 'Vergangen ist mir Glück und Heil', 'Vergangen ist mir Glück und Heil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11507 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:595f85b3-cb9a-40b8-8630-96f20457077e'
);


-- WoO 20 합창곡 <Dem dunkeln Schoß der heil'gen Erde>

UPDATE pieces piece
SET piece.title = '합창곡 <Dem dunkeln Schoß der heil''gen Erde>', piece.title_en = 'Dem dunkeln Schoß der heil''gen Erde',
    piece.type = 'song', piece.opus_number = 'WoO 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11469 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 11469 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 82 합창곡 <나니에>

UPDATE pieces piece
SET piece.title = '합창곡 <나니에>', piece.title_en = 'Nänie',
    piece.type = 'song', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11319 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 11319 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 89 합창곡 <운명의 여신들의 노래>

UPDATE pieces piece
SET piece.title = '합창곡 <운명의 여신들의 노래>', piece.title_en = 'Gesang der Parzen (Song of the Fates)',
    piece.type = 'song', piece.opus_number = 'Op. 89',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11324 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 11324 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 93a 혼성 합창을 위한 6개의 가곡과 로망스 Op. 93a

UPDATE pieces piece
SET piece.title = '혼성 합창을 위한 6개의 가곡과 로망스 Op. 93a', piece.title_en = '6 Lieder und Romanzen for mixed chorus, Op. 93a',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '93a',
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11523 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 11523 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der bucklichte Fiedler', part.name_en = 'Der bucklichte Fiedler',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11523 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:58731815-5bd6-4ad4-a7a7-8c26bc34eb90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58731815-5bd6-4ad4-a7a7-8c26bc34eb90', 1, NULL, 'Der bucklichte Fiedler', 'Der bucklichte Fiedler', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11523 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58731815-5bd6-4ad4-a7a7-8c26bc34eb90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Das Mädchen', part.name_en = 'Das Mädchen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11523 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:49560a06-cd07-4a0b-b918-cea90c9a68a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49560a06-cd07-4a0b-b918-cea90c9a68a3', 2, NULL, 'Das Mädchen', 'Das Mädchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11523 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49560a06-cd07-4a0b-b918-cea90c9a68a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'O süsser Mai', part.name_en = 'O süsser Mai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11523 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fbc2e8dc-4ed5-4629-bb52-7a393d4f6a79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbc2e8dc-4ed5-4629-bb52-7a393d4f6a79', 3, NULL, 'O süsser Mai', 'O süsser Mai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11523 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbc2e8dc-4ed5-4629-bb52-7a393d4f6a79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fahr wohl!', part.name_en = 'Fahr wohl!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11523 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:fb7b6a2b-1faa-41c9-a592-d5918d45a486' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb7b6a2b-1faa-41c9-a592-d5918d45a486', 4, NULL, 'Fahr wohl!', 'Fahr wohl!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11523 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb7b6a2b-1faa-41c9-a592-d5918d45a486'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Der Falke', part.name_en = 'Der Falke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11523 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:51519a03-11a2-4912-b16d-c83a91679f5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51519a03-11a2-4912-b16d-c83a91679f5b', 5, NULL, 'Der Falke', 'Der Falke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11523 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51519a03-11a2-4912-b16d-c83a91679f5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Beherzigung', part.name_en = 'Beherzigung',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11523 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:0e683ca1-66b5-4761-b401-e2738ddc8b0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e683ca1-66b5-4761-b401-e2738ddc8b0a', 6, NULL, 'Beherzigung', 'Beherzigung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11523 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e683ca1-66b5-4761-b401-e2738ddc8b0a'
);


-- Op. 93b 합창곡 <식탁의 노래>

UPDATE pieces piece
SET piece.title = '합창곡 <식탁의 노래>', piece.title_en = 'Tafellied (Dank der Damen)',
    piece.type = 'song', piece.opus_number = 'Op. 93b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11472 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 11472 AND piece.composer_id = 33 AND piece.composition_year IS NULL;


-- Op. 104 혼성 합창을 위한 5개의 노래 Op. 104

UPDATE pieces piece
SET piece.title = '혼성 합창을 위한 5개의 노래 Op. 104', piece.title_en = '5 Gesänge for mixed chorus, Op. 104',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '104',
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11946 AND piece.composer_id = 33
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 11946 AND piece.composer_id = 33 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nachtwache I', part.name_en = 'Nachtwache I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11946 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:772ce068-c9dd-374b-a606-36dfd61025d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:772ce068-c9dd-374b-a606-36dfd61025d9', 1, NULL, 'Nachtwache I', 'Nachtwache I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11946 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:772ce068-c9dd-374b-a606-36dfd61025d9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nachtwache II', part.name_en = 'Nachtwache II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11946 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:851414d6-63b7-3dd9-a4f8-062183d9dc50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:851414d6-63b7-3dd9-a4f8-062183d9dc50', 2, NULL, 'Nachtwache II', 'Nachtwache II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11946 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:851414d6-63b7-3dd9-a4f8-062183d9dc50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Letztes Glück', part.name_en = 'Letztes Glück',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11946 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3b930fa0-2f28-3888-9bc6-868d56cc8a23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b930fa0-2f28-3888-9bc6-868d56cc8a23', 3, NULL, 'Letztes Glück', 'Letztes Glück', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11946 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b930fa0-2f28-3888-9bc6-868d56cc8a23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Verlorene Jugend', part.name_en = 'Verlorene Jugend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11946 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:3558f6ca-1332-450d-b187-d51d280726f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3558f6ca-1332-450d-b187-d51d280726f6', 4, NULL, 'Verlorene Jugend', 'Verlorene Jugend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11946 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3558f6ca-1332-450d-b187-d51d280726f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Im Herbst', part.name_en = 'Im Herbst',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11946 AND p.composer_id = 33 AND part.part_key = 'musicbrainz:91f25792-f501-4101-84ce-02f65e5162eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91f25792-f501-4101-84ce-02f65e5162eb', 5, NULL, 'Im Herbst', 'Im Herbst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11946 AND p.composer_id = 33
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91f25792-f501-4101-84ce-02f65e5162eb'
);

-- 카탈로그에 대응이 없는 seed 작품 114개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 33 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    2603, 8535, 11292, 11310, 11314, 11332, 11334, 11370, 11371, 11372, 11374, 11375, 11376, 11377, 11378, 11382, 11384, 11386, 11389, 11404,
    11413, 11442, 11447, 11452, 11463, 11464, 11468, 11471, 11489, 11492, 11502, 11512, 11513, 11524, 11527, 11528, 11531, 11535, 11536, 11537,
    11542, 11547, 11554, 11559, 11570, 11576, 11580, 11592, 11605, 11606, 11615, 11616, 11621, 11624, 11629, 11630, 11635, 11638, 11659, 11678,
    11683, 11687, 11688, 11694, 11703, 11712, 11714, 11718, 11719, 11731, 11735, 11737, 11747, 11750, 11757, 11771, 11773, 11777, 11790, 11791,
    11801, 11808, 11809, 11828, 11829, 11832, 11848, 11851, 11861, 11872, 11875, 11876, 11884, 11885, 11902, 11904, 11917, 11926, 11927, 11936,
    11939, 11942, 11944, 11951, 11953, 11970, 11975, 11978, 11994, 11995, 11996, 11997, 12000, 15368
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
