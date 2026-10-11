-- 그리그 작품을 출판 단위로 다시 짠다(카탈로그: Op.·EG). 작품 149개(묶음 63, 다악장 21, 낱곡 65),
-- 새 작품 22개, 기존 작품 127개(seed 제목 고침 134개), part 512개, 그 아래 0개,
-- 기존 part 고쳐 씀 0개, 기존 작품 연결 8개. 카탈로그에 대응이 없는 seed 174개는 목록에서 숨긴다.
--
-- 정한 것
--   <노르웨이 선율집> EG 108 은 남의 선율 편곡집이라 뺀다. <페르 귄트> Op. 23 은 seed 가 번호를 가리켜 part 를 둔다.
--   462 「서정 소품집」(10권 전체, 비교 구간 있음)은 그대로 두고 권마다 묶음을 새로 넣는다.
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

-- Op. 1 4개의 피아노 소품 Op. 1

UPDATE pieces piece
SET piece.title = '4개의 피아노 소품 Op. 1', piece.title_en = '4 Piano Pieces, Op. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '1',
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13855 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 13855 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro con leggerezza', part.name_en = 'No. 1 Allegro con leggerezza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13855 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:20697154-f429-32d1-b531-770d158b5aef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20697154-f429-32d1-b531-770d158b5aef', 1, NULL, 'Allegro con leggerezza', 'No. 1 Allegro con leggerezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13855 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20697154-f429-32d1-b531-770d158b5aef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Non allegro e molto espressivo', part.name_en = 'No. 2 Non allegro e molto espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13855 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ddf132f3-60a4-3160-96ff-dcb9d636548b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddf132f3-60a4-3160-96ff-dcb9d636548b', 2, NULL, 'Non allegro e molto espressivo', 'No. 2 Non allegro e molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13855 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddf132f3-60a4-3160-96ff-dcb9d636548b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '마주르카. Con grazia', part.name_en = 'No. 3 Mazurka. Con grazia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13855 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e902a724-db19-3762-a9f7-26b912227046' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e902a724-db19-3762-a9f7-26b912227046', 3, NULL, '마주르카. Con grazia', 'No. 3 Mazurka. Con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13855 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e902a724-db19-3762-a9f7-26b912227046'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegretto con moto', part.name_en = 'No. 4 Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13855 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3b207f5d-250d-3605-a0fa-0ecc09b7da90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b207f5d-250d-3605-a0fa-0ecc09b7da90', 4, NULL, 'Allegretto con moto', 'No. 4 Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13855 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b207f5d-250d-3605-a0fa-0ecc09b7da90'
);


-- Op. 2 4개의 가곡 Op. 2

UPDATE pieces piece
SET piece.title = '4개의 가곡 Op. 2', piece.title_en = '4 Songs, Op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13784 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 13784 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Die Müllerin', part.name_en = 'No. 1 Die Müllerin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13784 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:76aa6c11-b156-483d-b29e-06c0b2471b8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76aa6c11-b156-483d-b29e-06c0b2471b8e', 1, NULL, 'Die Müllerin', 'No. 1 Die Müllerin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13784 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76aa6c11-b156-483d-b29e-06c0b2471b8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Eingehüllt in grauen Wolken', part.name_en = 'No. 2 Eingehüllt in grauen Wolken',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13784 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fef0b072-59a5-45fc-a096-4c977a3fd2b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fef0b072-59a5-45fc-a096-4c977a3fd2b5', 2, NULL, 'Eingehüllt in grauen Wolken', 'No. 2 Eingehüllt in grauen Wolken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13784 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fef0b072-59a5-45fc-a096-4c977a3fd2b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ich stand in dunkeln Träumen', part.name_en = 'No. 3 Ich stand in dunkeln Träumen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13784 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:312037c9-236d-42a0-b3af-d6c1ecfec564' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:312037c9-236d-42a0-b3af-d6c1ecfec564', 3, NULL, 'Ich stand in dunkeln Träumen', 'No. 3 Ich stand in dunkeln Träumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13784 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:312037c9-236d-42a0-b3af-d6c1ecfec564'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Was soll ich sagen?', part.name_en = 'No. 4 Was soll ich sagen?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13784 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:25150239-22b2-4bd8-806f-9a4350a9e12d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25150239-22b2-4bd8-806f-9a4350a9e12d', 4, NULL, 'Was soll ich sagen?', 'No. 4 Was soll ich sagen?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13784 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25150239-22b2-4bd8-806f-9a4350a9e12d'
);


-- Op. 3 피아노 모음곡 <시적 음화>

UPDATE pieces piece
SET piece.title = '피아노 모음곡 <시적 음화>', piece.title_en = 'Poetic Tone Pictures, Op. 3',
    piece.type = 'album', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13935 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 13935 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'No. 1 Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13935 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:529eed06-0e61-3526-85d3-0c6f153409bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:529eed06-0e61-3526-85d3-0c6f153409bb', 1, NULL, 'Allegro ma non troppo', 'No. 1 Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13935 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:529eed06-0e61-3526-85d3-0c6f153409bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro cantabile', part.name_en = 'No. 2 Allegro cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13935 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e54d155b-9168-3fec-8224-486f41ac59b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e54d155b-9168-3fec-8224-486f41ac59b6', 2, NULL, 'Allegro cantabile', 'No. 2 Allegro cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13935 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e54d155b-9168-3fec-8224-486f41ac59b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Con moto', part.name_en = 'No. 3 Con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13935 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:23b55e12-f332-32f4-a9a8-d39ca23b7de2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23b55e12-f332-32f4-a9a8-d39ca23b7de2', 3, NULL, 'Con moto', 'No. 3 Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13935 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23b55e12-f332-32f4-a9a8-d39ca23b7de2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante con sentimento', part.name_en = 'No. 4 Andante con sentimento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13935 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:7f22537b-ef01-32c0-b428-23dbdf04920b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f22537b-ef01-32c0-b428-23dbdf04920b', 4, NULL, 'Andante con sentimento', 'No. 4 Andante con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13935 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f22537b-ef01-32c0-b428-23dbdf04920b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'No. 5 Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13935 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4885f41f-5eae-3da7-af9a-d99a6b6606f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4885f41f-5eae-3da7-af9a-d99a6b6606f8', 5, NULL, 'Allegro moderato', 'No. 5 Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13935 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4885f41f-5eae-3da7-af9a-d99a6b6606f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allegro scherzando', part.name_en = 'No. 6 Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13935 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e80ec34e-511a-3927-8411-7e90657e2ba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e80ec34e-511a-3927-8411-7e90657e2ba5', 6, NULL, 'Allegro scherzando', 'No. 6 Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13935 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e80ec34e-511a-3927-8411-7e90657e2ba5'
);


-- Op. 4 6개의 가곡 Op. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 가곡 Op. 4', '6 Songs, Op. 4', 'album', NULL, 'Op.', '4', 1864, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 가곡 Op. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5619e365-4ea6-48cd-9def-f4bef9c16437'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5619e365-4ea6-48cd-9def-f4bef9c16437'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '6개의 가곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5619e365-4ea6-48cd-9def-f4bef9c16437'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:771e77d0-52ec-4005-8402-9485a3fc28b3', 1, NULL, 'Die Waise', 'No. 1 Die Waise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '6개의 가곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:771e77d0-52ec-4005-8402-9485a3fc28b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd620666-43d2-4d1f-a318-85640b9be211', 2, NULL, 'Morgenthau', 'No. 2 Morgenthau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '6개의 가곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd620666-43d2-4d1f-a318-85640b9be211'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0170a3f-2ebf-4cba-8e56-3c1423a34fb4', 3, NULL, 'Abschied', 'No. 3 Abschied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '6개의 가곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0170a3f-2ebf-4cba-8e56-3c1423a34fb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee1fb152-a5d4-41d4-acd5-b067303bc699', 4, NULL, 'Jägerlied', 'No. 4 Jägerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '6개의 가곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee1fb152-a5d4-41d4-acd5-b067303bc699'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9546f18e-8f56-44e3-b86b-e7e380385595', 5, NULL, 'Das alte Lied', 'No. 5 Das alte Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '6개의 가곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9546f18e-8f56-44e3-b86b-e7e380385595'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ff2c40b-6e57-4b7a-8e0c-272154094a3e', 6, NULL, 'Wo sind sie hin?', 'No. 6 Wo sind sie hin?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '6개의 가곡 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ff2c40b-6e57-4b7a-8e0c-272154094a3e'
);


-- Op. 5 가곡집 <마음의 멜로디>

UPDATE pieces piece
SET piece.title = '가곡집 <마음의 멜로디>', piece.title_en = 'Melodies of the Heart, Op. 5',
    piece.type = 'album', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13757 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 13757 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'To brune Øjne', part.name_en = 'No. 1 To brune Øjne (Two Brown Eyes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13757 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d0c345dd-f02e-4b2d-9a91-6789c06fca23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0c345dd-f02e-4b2d-9a91-6789c06fca23', 1, NULL, 'To brune Øjne', 'No. 1 To brune Øjne (Two Brown Eyes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13757 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c345dd-f02e-4b2d-9a91-6789c06fca23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Du fatter ej Bølgernes evige Gang', part.name_en = 'No. 2 Du fatter ej Bølgernes evige Gang (The Poet''s Heart)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13757 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2e7625d6-895a-4491-befa-6a8a9dc8baf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e7625d6-895a-4491-befa-6a8a9dc8baf9', 2, NULL, 'Du fatter ej Bølgernes evige Gang', 'No. 2 Du fatter ej Bølgernes evige Gang (The Poet''s Heart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13757 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e7625d6-895a-4491-befa-6a8a9dc8baf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '그대를 사랑해 (Jeg elsker dig)', part.name_en = 'No. 3 Jeg elsker dig (I Love But Thee)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13757 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c1db9699-fb43-367f-b555-45bdd06644be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1db9699-fb43-367f-b555-45bdd06644be', 3, NULL, '그대를 사랑해 (Jeg elsker dig)', 'No. 3 Jeg elsker dig (I Love But Thee)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13757 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1db9699-fb43-367f-b555-45bdd06644be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Min Tanke er et mægtigt Fjeld', part.name_en = 'No. 4 Min Tanke er et mægtigt Fjeld (My Mind Is Like a Mountain Steep)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13757 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0831ef58-84c6-491c-ad05-8bae53f9be57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0831ef58-84c6-491c-ad05-8bae53f9be57', 4, NULL, 'Min Tanke er et mægtigt Fjeld', 'No. 4 Min Tanke er et mægtigt Fjeld (My Mind Is Like a Mountain Steep)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13757 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0831ef58-84c6-491c-ad05-8bae53f9be57'
);


-- Op. 6 4개의 유모레스크 Op. 6

UPDATE pieces piece
SET piece.title = '4개의 유모레스크 Op. 6', piece.title_en = '4 Humoresques, Op. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '6',
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13820 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 13820 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tempo di valse', part.name_en = 'No. 1 Tempo di valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13820 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f05e83b8-f7b2-3814-b8fc-3e36faaeac47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f05e83b8-f7b2-3814-b8fc-3e36faaeac47', 1, NULL, 'Tempo di valse', 'No. 1 Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13820 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f05e83b8-f7b2-3814-b8fc-3e36faaeac47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tempo di menuetto ed energico', part.name_en = 'No. 2 Tempo di menuetto ed energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13820 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:28fb3ce7-9bf3-362f-9dfb-3416632156c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28fb3ce7-9bf3-362f-9dfb-3416632156c9', 2, NULL, 'Tempo di menuetto ed energico', 'No. 2 Tempo di menuetto ed energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13820 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28fb3ce7-9bf3-362f-9dfb-3416632156c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegretto con grazia', part.name_en = 'No. 3 Allegretto con grazia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13820 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9aed2192-f68e-3849-bf6a-7e732346d740' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9aed2192-f68e-3849-bf6a-7e732346d740', 3, NULL, 'Allegretto con grazia', 'No. 3 Allegretto con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13820 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aed2192-f68e-3849-bf6a-7e732346d740'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro alla burla', part.name_en = 'No. 4 Allegro alla burla',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13820 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:558e05e9-085c-39e0-bda2-bffac5beb4b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:558e05e9-085c-39e0-bda2-bffac5beb4b8', 4, NULL, 'Allegro alla burla', 'No. 4 Allegro alla burla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13820 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:558e05e9-085c-39e0-bda2-bffac5beb4b8'
);


-- Op. 7 피아노 소나타 E단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 E단조', piece.title_en = 'Piano Sonata in E minor',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1867, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13873 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1867
WHERE piece.id = 13873 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13873 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c3a3d6fe-cc88-3509-a13b-5fda0567e3cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3a3d6fe-cc88-3509-a13b-5fda0567e3cb', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13873 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3a3d6fe-cc88-3509-a13b-5fda0567e3cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante molto', part.name_en = 'II. Andante molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13873 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:59eb8e56-7a4a-3501-905d-b9195e114086' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59eb8e56-7a4a-3501-905d-b9195e114086', 2, 'II', 'Andante molto', 'II. Andante molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13873 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59eb8e56-7a4a-3501-905d-b9195e114086'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Alla menuetto, ma poco più lento', part.name_en = 'III. Alla menuetto, ma poco più lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13873 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6c297b99-dcc0-32b6-a4d3-1b3b88b2fd04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c297b99-dcc0-32b6-a4d3-1b3b88b2fd04', 3, 'III', 'Alla menuetto, ma poco più lento', 'III. Alla menuetto, ma poco più lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13873 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c297b99-dcc0-32b6-a4d3-1b3b88b2fd04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Molto allegro', part.name_en = 'IV. Finale. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13873 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:060c6fad-db11-33d5-b6c1-489f088e6078' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:060c6fad-db11-33d5-b6c1-489f088e6078', 4, 'IV', '피날레. Molto allegro', 'IV. Finale. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13873 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:060c6fad-db11-33d5-b6c1-489f088e6078'
);


-- Op. 8 바이올린 소나타 1번 F장조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 1번 F장조', piece.title_en = 'Violin Sonata No. 1 in F major',
    piece.type = 'album', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13778 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 13778 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13778 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5bb5be29-4b18-42b2-b63e-e76f53cc5164' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bb5be29-4b18-42b2-b63e-e76f53cc5164', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13778 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bb5be29-4b18-42b2-b63e-e76f53cc5164'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto quasi andantino', part.name_en = 'II. Allegretto quasi andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13778 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3ad0d8bb-49ec-4dfe-bb96-71ba8a01dd82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ad0d8bb-49ec-4dfe-bb96-71ba8a01dd82', 2, 'II', 'Allegretto quasi andantino', 'II. Allegretto quasi andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13778 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad0d8bb-49ec-4dfe-bb96-71ba8a01dd82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto vivace', part.name_en = 'III. Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13778 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0e5e4f4f-637e-454e-86c5-4f8c3b5c06bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e5e4f4f-637e-454e-86c5-4f8c3b5c06bb', 3, 'III', 'Allegro molto vivace', 'III. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13778 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e5e4f4f-637e-454e-86c5-4f8c3b5c06bb'
);


-- Op. 9 4개의 로망스와 발라드 Op. 9

UPDATE pieces piece
SET piece.title = '4개의 로망스와 발라드 Op. 9', piece.title_en = '4 Romances and Ballads, Op. 9',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '9',
    piece.composition_year = COALESCE(1866, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13834 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1866
WHERE piece.id = 13834 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Harpen', part.name_en = 'No. 1 Harpen (The Harp)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13834 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:38ae8025-18a9-4eab-8adb-e13d7e8c8918' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38ae8025-18a9-4eab-8adb-e13d7e8c8918', 1, NULL, 'Harpen', 'No. 1 Harpen (The Harp)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13834 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38ae8025-18a9-4eab-8adb-e13d7e8c8918'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vuggesang', part.name_en = 'No. 2 Vuggesang (Cradle Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13834 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:86eb5e72-0a4f-4db3-b2ad-47c52ddb55a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86eb5e72-0a4f-4db3-b2ad-47c52ddb55a2', 2, NULL, 'Vuggesang', 'No. 2 Vuggesang (Cradle Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13834 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86eb5e72-0a4f-4db3-b2ad-47c52ddb55a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Solnedgang', part.name_en = 'No. 3 Solnedgang (Sunset)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13834 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5afe0e34-7139-4993-b531-9b638a90073a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5afe0e34-7139-4993-b531-9b638a90073a', 3, NULL, 'Solnedgang', 'No. 3 Solnedgang (Sunset)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13834 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5afe0e34-7139-4993-b531-9b638a90073a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Udfarten', part.name_en = 'No. 4 Udfarten (Outward Bound)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13834 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fab9b3b7-b793-4ce9-9c10-86e3aba57d3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fab9b3b7-b793-4ce9-9c10-86e3aba57d3a', 4, NULL, 'Udfarten', 'No. 4 Udfarten (Outward Bound)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13834 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fab9b3b7-b793-4ce9-9c10-86e3aba57d3a'
);


-- Op. 10 4개의 로망스 Op. 10

UPDATE pieces piece
SET piece.title = '4개의 로망스 Op. 10', piece.title_en = '4 Romances, Op. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '10',
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14182 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 14182 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tagsigelse', part.name_en = 'No. 1 Tagsigelse (Thanks)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14182 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:334ee22d-a593-41a8-bda4-17f7d110c02d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:334ee22d-a593-41a8-bda4-17f7d110c02d', 1, NULL, 'Tagsigelse', 'No. 1 Tagsigelse (Thanks)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14182 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:334ee22d-a593-41a8-bda4-17f7d110c02d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Skovsang', part.name_en = 'No. 2 Skovsang (Woodland Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14182 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:996f9d07-0c23-41a3-bf18-80058b33af74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:996f9d07-0c23-41a3-bf18-80058b33af74', 2, NULL, 'Skovsang', 'No. 2 Skovsang (Woodland Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14182 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:996f9d07-0c23-41a3-bf18-80058b33af74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Blomsterne tale', part.name_en = 'No. 3 Blomsterne tale (Song of the Flowers)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14182 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fad47b5f-1eed-4367-9710-ee003822d473' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fad47b5f-1eed-4367-9710-ee003822d473', 3, NULL, 'Blomsterne tale', 'No. 3 Blomsterne tale (Song of the Flowers)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14182 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fad47b5f-1eed-4367-9710-ee003822d473'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sang på Fjeldet', part.name_en = 'No. 4 Sang på Fjeldet (Song on the Mountain)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14182 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:cd6f0bb4-b589-4aa6-a93e-503cd882ab3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd6f0bb4-b589-4aa6-a93e-503cd882ab3d', 4, NULL, 'Sang på Fjeldet', 'No. 4 Sang på Fjeldet (Song on the Mountain)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14182 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd6f0bb4-b589-4aa6-a93e-503cd882ab3d'
);


-- Op. 11 연주회용 서곡 <가을에>

UPDATE pieces piece
SET piece.title = '연주회용 서곡 <가을에>', piece.title_en = 'In Autumn, Concert Overture',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13812 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 13812 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- Op. 12 서정 소곡집 1권 Op. 12

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 1권 Op. 12', 'Lyric Pieces, Book I, Op. 12', 'album', NULL, 'Op.', '12', 1867, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 1권 Op. 12'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e2073df-8203-4383-ab9d-62eaa55f24d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8e2073df-8203-4383-ab9d-62eaa55f24d2'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e2073df-8203-4383-ab9d-62eaa55f24d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6115546-141a-3366-9e3c-77c1459d21f8', 1, NULL, '아리에타 (Arietta)', 'No. 1 Arietta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6115546-141a-3366-9e3c-77c1459d21f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45b7d225-3993-397f-b853-00bae7286077', 2, NULL, '왈츠 (Vals)', 'No. 2 Vals (Waltz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45b7d225-3993-397f-b853-00bae7286077'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f015f17-29a8-3e53-989f-cc7f2fa2babf', 3, NULL, '파수꾼의 노래 (Vægtersang)', 'No. 3 Vægtersang (Watchman''s Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f015f17-29a8-3e53-989f-cc7f2fa2babf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0240b972-5f42-30b7-acbb-0b9e28c69b42', 4, NULL, '요정의 춤 (Elverdans)', 'No. 4 Elverdans (Elves'' Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0240b972-5f42-30b7-acbb-0b9e28c69b42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce4b0bb1-7bd8-3290-b0d8-b69c841d40fc', 5, NULL, '민요 (Folkevise)', 'No. 5 Folkevise (Folk Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce4b0bb1-7bd8-3290-b0d8-b69c841d40fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afd31d11-36f7-3932-9eb4-b0ac3e386445', 6, NULL, '노르웨이 선율 (Norsk)', 'No. 6 Norsk (Norwegian Melody)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afd31d11-36f7-3932-9eb4-b0ac3e386445'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d660b81-b1b3-35ee-8850-be158026146a', 7, NULL, '앨범의 잎 (Stambogsblad)', 'No. 7 Stambogsblad (Album Leaf)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d660b81-b1b3-35ee-8850-be158026146a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c3e3f81-84aa-3f08-9f4e-1a53f6f4f90b', 8, NULL, '조국의 노래 (Fædrelandssang)', 'No. 8 Fædrelandssang (National Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 1권 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c3e3f81-84aa-3f08-9f4e-1a53f6f4f90b'
);


-- Op. 13 바이올린 소나타 2번 G장조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 G장조', piece.title_en = 'Violin Sonata No. 2 in G major',
    piece.type = 'album', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1867, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14007 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1867
WHERE piece.id = 14007 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento doloroso – Allegro vivace', part.name_en = 'I. Lento doloroso – Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14007 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:378e0270-84f2-4da2-9e74-b430a87c5622' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:378e0270-84f2-4da2-9e74-b430a87c5622', 1, 'I', 'Lento doloroso – Allegro vivace', 'I. Lento doloroso – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14007 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:378e0270-84f2-4da2-9e74-b430a87c5622'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto tranquillo', part.name_en = 'II. Allegretto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14007 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:13bee0f7-b636-4ac1-9ea2-25e9a101edb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13bee0f7-b636-4ac1-9ea2-25e9a101edb2', 2, 'II', 'Allegretto tranquillo', 'II. Allegretto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14007 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13bee0f7-b636-4ac1-9ea2-25e9a101edb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro animato', part.name_en = 'III. Allegro animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14007 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a636c4b2-6573-48c3-a116-1122aa01301c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a636c4b2-6573-48c3-a116-1122aa01301c', 3, 'III', 'Allegro animato', 'III. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14007 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a636c4b2-6573-48c3-a116-1122aa01301c'
);


-- Op. 14 2개의 교향적 소품 Op. 14

UPDATE pieces piece
SET piece.title = '2개의 교향적 소품 Op. 14', piece.title_en = '2 Symphonic Pieces, Op. 14',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '14',
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13909 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 13909 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Adagio cantabile', part.name_en = 'No. 1 Adagio cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13909 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e47a52a5-25eb-4ab3-948d-c5d6c2041bf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e47a52a5-25eb-4ab3-948d-c5d6c2041bf3', 1, NULL, 'Adagio cantabile', 'No. 1 Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13909 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e47a52a5-25eb-4ab3-948d-c5d6c2041bf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro energico', part.name_en = 'No. 2 Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13909 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fd3551aa-362f-48f7-8caa-ad440e29437b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd3551aa-362f-48f7-8caa-ad440e29437b', 2, NULL, 'Allegro energico', 'No. 2 Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13909 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd3551aa-362f-48f7-8caa-ad440e29437b'
);


-- Op. 15 4개의 로망스 Op. 15

UPDATE pieces piece
SET piece.title = '4개의 로망스 Op. 15', piece.title_en = '4 Romances, Op. 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '15',
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13860 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 13860 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Margretes Vuggesang', part.name_en = 'No. 1 Margretes Vuggesang (Margaret''s Cradle Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13860 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4660f5a0-694c-475e-81c6-ef60efe30b17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4660f5a0-694c-475e-81c6-ef60efe30b17', 1, NULL, 'Margretes Vuggesang', 'No. 1 Margretes Vuggesang (Margaret''s Cradle Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13860 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4660f5a0-694c-475e-81c6-ef60efe30b17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Kjærlighed', part.name_en = 'No. 2 Kjærlighed (Love)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13860 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e5c65b40-701c-4884-9c6e-e067c189d03b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5c65b40-701c-4884-9c6e-e067c189d03b', 2, NULL, 'Kjærlighed', 'No. 2 Kjærlighed (Love)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13860 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5c65b40-701c-4884-9c6e-e067c189d03b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Langelandsk Folkemelodi', part.name_en = 'No. 3 Langelandsk Folkemelodi (Folk Song from Langeland)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13860 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:14b3990c-a51e-4b74-8f4f-968a5dd6c0b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14b3990c-a51e-4b74-8f4f-968a5dd6c0b1', 3, NULL, 'Langelandsk Folkemelodi', 'No. 3 Langelandsk Folkemelodi (Folk Song from Langeland)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13860 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14b3990c-a51e-4b74-8f4f-968a5dd6c0b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Modersorg', part.name_en = 'No. 4 Modersorg (A Mother''s Grief)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13860 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:1ab60ad5-7253-49c1-89bd-f4dda559422e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ab60ad5-7253-49c1-89bd-f4dda559422e', 4, NULL, 'Modersorg', 'No. 4 Modersorg (A Mother''s Grief)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13860 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab60ad5-7253-49c1-89bd-f4dda559422e'
);


-- Op. 16 피아노 협주곡 A단조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 A단조', piece.title_en = 'Piano Concerto in A minor',
    piece.type = 'album', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13959 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 13959 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto moderato', part.name_en = 'I. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13959 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d94d2e8b-78d3-3d2f-a71b-b60a7dfa2660' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d94d2e8b-78d3-3d2f-a71b-b60a7dfa2660', 1, 'I', 'Allegro molto moderato', 'I. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13959 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d94d2e8b-78d3-3d2f-a71b-b60a7dfa2660'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13959 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3c8a3c17-ef95-3b44-a10f-d38785d72bb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c8a3c17-ef95-3b44-a10f-d38785d72bb8', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13959 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c8a3c17-ef95-3b44-a10f-d38785d72bb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato molto e marcato', part.name_en = 'III. Allegro moderato molto e marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13959 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a28b383f-480c-33d5-8cc6-bd88a2562686' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a28b383f-480c-33d5-8cc6-bd88a2562686', 3, 'III', 'Allegro moderato molto e marcato', 'III. Allegro moderato molto e marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13959 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a28b383f-480c-33d5-8cc6-bd88a2562686'
);


-- Op. 17 25개의 노르웨이 민요와 춤곡 Op. 17

UPDATE pieces piece
SET piece.title = '25개의 노르웨이 민요와 춤곡 Op. 17', piece.title_en = '25 Norwegian Folk Songs and Dances, Op. 17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '17',
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13783 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 13783 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Springdans', part.name_en = 'No. 1 Springdans (Spring Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c037a134-19c5-35cc-a22a-06e750ae07df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c037a134-19c5-35cc-a22a-06e750ae07df', 1, NULL, 'Springdans', 'No. 1 Springdans (Spring Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c037a134-19c5-35cc-a22a-06e750ae07df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ungersvenden han bad sin pige', part.name_en = 'No. 2 Ungersvenden han bad sin pige (The Young Man Asked His Maiden)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b74e7989-4784-3bc9-8aa3-2ffe54cd803a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b74e7989-4784-3bc9-8aa3-2ffe54cd803a', 2, NULL, 'Ungersvenden han bad sin pige', 'No. 2 Ungersvenden han bad sin pige (The Young Man Asked His Maiden)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b74e7989-4784-3bc9-8aa3-2ffe54cd803a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Springdans', part.name_en = 'No. 3 Springdans (Spring Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:18c500ff-c727-3e8f-b9a8-e9f02219b696' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18c500ff-c727-3e8f-b9a8-e9f02219b696', 3, NULL, 'Springdans', 'No. 3 Springdans (Spring Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18c500ff-c727-3e8f-b9a8-e9f02219b696'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Niels Tallefjorn den kaute karen', part.name_en = 'No. 4 Niels Tallefjorn den kaute karen (Niels Tallefjorn, Proud Fellow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:83437451-059e-3e15-a113-662d4454477d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83437451-059e-3e15-a113-662d4454477d', 4, NULL, 'Niels Tallefjorn den kaute karen', 'No. 4 Niels Tallefjorn den kaute karen (Niels Tallefjorn, Proud Fellow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83437451-059e-3e15-a113-662d4454477d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Jølstring', part.name_en = 'No. 5 Jølstring (Dance from Jølster)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:06d13ff2-9279-3cee-8e53-2bd9002c2a16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06d13ff2-9279-3cee-8e53-2bd9002c2a16', 5, NULL, 'Jølstring', 'No. 5 Jølstring (Dance from Jølster)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06d13ff2-9279-3cee-8e53-2bd9002c2a16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Brulåt', part.name_en = 'No. 6 Brulåt (Wedding Tune)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9b7dedb0-33e3-36e3-b4e2-577cfd26b5a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b7dedb0-33e3-36e3-b4e2-577cfd26b5a3', 6, NULL, 'Brulåt', 'No. 6 Brulåt (Wedding Tune)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b7dedb0-33e3-36e3-b4e2-577cfd26b5a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Halling', part.name_en = 'No. 7 Halling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5befb1e8-c1cd-303a-ad62-19d294f0addd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5befb1e8-c1cd-303a-ad62-19d294f0addd', 7, NULL, 'Halling', 'No. 7 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5befb1e8-c1cd-303a-ad62-19d294f0addd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Aa grisen hadde eit tryne', part.name_en = 'No. 8 Aa grisen hadde eit tryne (Oh, the Pig Had a Snout)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4319b01c-659d-390a-89bd-89b236295d4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4319b01c-659d-390a-89bd-89b236295d4e', 8, NULL, 'Aa grisen hadde eit tryne', 'No. 8 Aa grisen hadde eit tryne (Oh, the Pig Had a Snout)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4319b01c-659d-390a-89bd-89b236295d4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Naar mit øie', part.name_en = 'No. 9 Naar mit øie (When My Eyes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:03544775-e23c-3293-87a8-b17bb576d4f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03544775-e23c-3293-87a8-b17bb576d4f6', 9, NULL, 'Naar mit øie', 'No. 9 Naar mit øie (When My Eyes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03544775-e23c-3293-87a8-b17bb576d4f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Aa Ole engang i sinde', part.name_en = 'No. 10 Aa Ole engang i sinde (Ole Once in Anger)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3ebaa2c4-d8fb-36a2-a132-ad01f363a82e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ebaa2c4-d8fb-36a2-a132-ad01f363a82e', 10, NULL, 'Aa Ole engang i sinde', 'No. 10 Aa Ole engang i sinde (Ole Once in Anger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ebaa2c4-d8fb-36a2-a132-ad01f363a82e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'På Dovrefjeld i Norge', part.name_en = 'No. 11 På Dovrefjeld i Norge (On the Dovrefjeld in Norway)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2fe4514e-839b-3ae0-8dc1-80b390c2d75d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fe4514e-839b-3ae0-8dc1-80b390c2d75d', 11, NULL, 'På Dovrefjeld i Norge', 'No. 11 På Dovrefjeld i Norge (On the Dovrefjeld in Norway)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fe4514e-839b-3ae0-8dc1-80b390c2d75d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Solfager og Ormekongen', part.name_en = 'No. 12 Solfager og Ormekongen (Solfager and the Snake King)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ab6ae5ac-4c4c-385e-bdab-022de5afc89c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab6ae5ac-4c4c-385e-bdab-022de5afc89c', 12, NULL, 'Solfager og Ormekongen', 'No. 12 Solfager og Ormekongen (Solfager and the Snake King)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab6ae5ac-4c4c-385e-bdab-022de5afc89c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Reiseslaatt', part.name_en = 'No. 13 Reiseslaatt (Wedding Recessional March)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:655a2a1b-a23c-3b15-90b8-0c2f9543fe49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:655a2a1b-a23c-3b15-90b8-0c2f9543fe49', 13, NULL, 'Reiseslaatt', 'No. 13 Reiseslaatt (Wedding Recessional March)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:655a2a1b-a23c-3b15-90b8-0c2f9543fe49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Jeg sjunger med sorrigfuldt hjerte', part.name_en = 'No. 14 Jeg sjunger med sorrigfuldt hjerte (I Sing with a Sorrowful Heart)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c14f53da-3491-3673-95a3-1f535157cdfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c14f53da-3491-3673-95a3-1f535157cdfa', 14, NULL, 'Jeg sjunger med sorrigfuldt hjerte', 'No. 14 Jeg sjunger med sorrigfuldt hjerte (I Sing with a Sorrowful Heart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c14f53da-3491-3673-95a3-1f535157cdfa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Den sidste laurdags kvelden', part.name_en = 'No. 15 Den sidste laurdags kvelden (The Last Saturday Night)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:cadaf5cb-ce4d-3a58-8f45-f2dd9474dc36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cadaf5cb-ce4d-3a58-8f45-f2dd9474dc36', 15, NULL, 'Den sidste laurdags kvelden', 'No. 15 Den sidste laurdags kvelden (The Last Saturday Night)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cadaf5cb-ce4d-3a58-8f45-f2dd9474dc36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Je veit ei lita jente', part.name_en = 'No. 16 Je veit ei lita jente (I Know of a Little Maiden)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c763cbcc-6f27-388b-ac28-ed99bab90842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c763cbcc-6f27-388b-ac28-ed99bab90842', 16, NULL, 'Je veit ei lita jente', 'No. 16 Je veit ei lita jente (I Know of a Little Maiden)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c763cbcc-6f27-388b-ac28-ed99bab90842'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Aa kleggen han sa no te flugga si', part.name_en = 'No. 17 Aa kleggen han sa no te flugga si (The Gadfly Said to the Fly)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:efec81dc-90e2-3702-a38d-aba149ac0f13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efec81dc-90e2-3702-a38d-aba149ac0f13', 17, NULL, 'Aa kleggen han sa no te flugga si', 'No. 17 Aa kleggen han sa no te flugga si (The Gadfly Said to the Fly)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efec81dc-90e2-3702-a38d-aba149ac0f13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Stabbe-Låten', part.name_en = 'No. 18 Stabbe-Låten (Stumping Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4792e490-7bce-3d6f-8f07-fa7fb36c4483' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4792e490-7bce-3d6f-8f07-fa7fb36c4483', 18, NULL, 'Stabbe-Låten', 'No. 18 Stabbe-Låten (Stumping Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4792e490-7bce-3d6f-8f07-fa7fb36c4483'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Hølje Dale', part.name_en = 'No. 19 Hølje Dale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5b94dac2-03e9-39c9-a875-163827d74333' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b94dac2-03e9-39c9-a875-163827d74333', 19, NULL, 'Hølje Dale', 'No. 19 Hølje Dale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b94dac2-03e9-39c9-a875-163827d74333'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Halling', part.name_en = 'No. 20 Halling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5b18a316-ffab-3384-8f40-8bd869f56d92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b18a316-ffab-3384-8f40-8bd869f56d92', 20, NULL, 'Halling', 'No. 20 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b18a316-ffab-3384-8f40-8bd869f56d92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Sæbygga', part.name_en = 'No. 21 Sæbygga (The Woman from Setesdal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ad69e04e-0880-35b0-8517-18083189e515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad69e04e-0880-35b0-8517-18083189e515', 21, NULL, 'Sæbygga', 'No. 21 Sæbygga (The Woman from Setesdal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad69e04e-0880-35b0-8517-18083189e515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'So lokka me over den myra', part.name_en = 'No. 22 So lokka me over den myra (Cattle Call)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ff2da89a-c695-352a-8a2d-c2ee7c234ef8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff2da89a-c695-352a-8a2d-c2ee7c234ef8', 22, NULL, 'So lokka me over den myra', 'No. 22 So lokka me over den myra (Cattle Call)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff2da89a-c695-352a-8a2d-c2ee7c234ef8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Saag du nokke te kjæringa mi', part.name_en = 'No. 23 Saag du nokke te kjæringa mi (Did You See Anything of My Wife?)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:132c81c7-e434-3d01-873e-71374fea50d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:132c81c7-e434-3d01-873e-71374fea50d6', 23, NULL, 'Saag du nokke te kjæringa mi', 'No. 23 Saag du nokke te kjæringa mi (Did You See Anything of My Wife?)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:132c81c7-e434-3d01-873e-71374fea50d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Brulåten', part.name_en = 'No. 24 Brulåten (Wedding Tune)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:bcf18ffa-54a3-3527-9476-41bc0eab0eca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcf18ffa-54a3-3527-9476-41bc0eab0eca', 24, NULL, 'Brulåten', 'No. 24 Brulåten (Wedding Tune)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcf18ffa-54a3-3527-9476-41bc0eab0eca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Rabnabryllaup i Kraakeland', part.name_en = 'No. 25 Rabnabryllaup i Kraakeland (The Raven''s Wedding in Kraakeland)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13783 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0d23e749-b96d-3172-825d-32a639448aef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d23e749-b96d-3172-825d-32a639448aef', 25, NULL, 'Rabnabryllaup i Kraakeland', 'No. 25 Rabnabryllaup i Kraakeland (The Raven''s Wedding in Kraakeland)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13783 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d23e749-b96d-3172-825d-32a639448aef'
);


-- Op. 18 9개의 로망스와 노래 Op. 18

UPDATE pieces piece
SET piece.title = '9개의 로망스와 노래 Op. 18', piece.title_en = '9 Romances and Songs, Op. 18',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '18',
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13815 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 13815 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vandring i Skoven', part.name_en = 'No. 1 Vandring i Skoven (Moonlit Forest)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6f0ed349-0031-44bf-b4dc-7d75f21cd6b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f0ed349-0031-44bf-b4dc-7d75f21cd6b4', 1, NULL, 'Vandring i Skoven', 'No. 1 Vandring i Skoven (Moonlit Forest)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f0ed349-0031-44bf-b4dc-7d75f21cd6b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Hun er saa hvid', part.name_en = 'No. 2 Hun er saa hvid (My Darling Is as White as Snow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0be0dd09-10d6-4378-a41b-bd756451ebe2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0be0dd09-10d6-4378-a41b-bd756451ebe2', 2, NULL, 'Hun er saa hvid', 'No. 2 Hun er saa hvid (My Darling Is as White as Snow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0be0dd09-10d6-4378-a41b-bd756451ebe2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'En Digters sidste Sang', part.name_en = 'No. 3 En Digters sidste Sang (The Poet''s Farewell)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:aca4555a-0daf-498b-9ab2-ef56dadad765' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aca4555a-0daf-498b-9ab2-ef56dadad765', 3, NULL, 'En Digters sidste Sang', 'No. 3 En Digters sidste Sang (The Poet''s Farewell)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aca4555a-0daf-498b-9ab2-ef56dadad765'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Efteraarsstormen', part.name_en = 'No. 4 Efteraarsstormen (Autumn Storms)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:cba3be1c-8b2e-4a43-a3d0-8ba74a09f88b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cba3be1c-8b2e-4a43-a3d0-8ba74a09f88b', 4, NULL, 'Efteraarsstormen', 'No. 4 Efteraarsstormen (Autumn Storms)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cba3be1c-8b2e-4a43-a3d0-8ba74a09f88b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Poesien', part.name_en = 'No. 5 Poesien (Poetry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a93400e1-bfe2-494c-82cc-2f2e16b9dc4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a93400e1-bfe2-494c-82cc-2f2e16b9dc4b', 5, NULL, 'Poesien', 'No. 5 Poesien (Poetry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a93400e1-bfe2-494c-82cc-2f2e16b9dc4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ungbirken', part.name_en = 'No. 6 Ungbirken (The Young Birch Tree)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5969c52b-66ee-49b3-a218-b1f9411882be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5969c52b-66ee-49b3-a218-b1f9411882be', 6, NULL, 'Ungbirken', 'No. 6 Ungbirken (The Young Birch Tree)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5969c52b-66ee-49b3-a218-b1f9411882be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Hytten', part.name_en = 'No. 7 Hytten (The Cottage)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:52c04a0c-fb68-4b99-9eb4-634b2d7c2ebc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52c04a0c-fb68-4b99-9eb4-634b2d7c2ebc', 7, NULL, 'Hytten', 'No. 7 Hytten (The Cottage)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c04a0c-fb68-4b99-9eb4-634b2d7c2ebc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Rosenknoppen', part.name_en = 'No. 8 Rosenknoppen (Rosebuds)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:833849b6-9682-45bb-8499-fafd0a9469fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:833849b6-9682-45bb-8499-fafd0a9469fd', 8, NULL, 'Rosenknoppen', 'No. 8 Rosenknoppen (Rosebuds)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:833849b6-9682-45bb-8499-fafd0a9469fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Serenade til Welhaven', part.name_en = 'No. 9 Serenade til Welhaven (Serenade for Welhaven)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13815 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9e250bcb-7145-466a-a52b-fda07d9c21a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e250bcb-7145-466a-a52b-fda07d9c21a5', 9, NULL, 'Serenade til Welhaven', 'No. 9 Serenade til Welhaven (Serenade for Welhaven)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13815 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e250bcb-7145-466a-a52b-fda07d9c21a5'
);


-- Op. 19 피아노 모음곡 <민중 생활의 정경>

UPDATE pieces piece
SET piece.title = '피아노 모음곡 <민중 생활의 정경>', piece.title_en = 'Scenes from Folk Life, Op. 19',
    piece.type = 'album', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13747 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 13747 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '산의 춤 (Fjeldslåt)', part.name_en = 'No. 1 Fjeldslåt (Mountain Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13747 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:12f64bb8-4306-384e-baec-2a3128a51b0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12f64bb8-4306-384e-baec-2a3128a51b0b', 1, NULL, '산의 춤 (Fjeldslåt)', 'No. 1 Fjeldslåt (Mountain Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13747 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12f64bb8-4306-384e-baec-2a3128a51b0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '신부 행렬이 지나간다 (Brudefølget drar forbi)', part.name_en = 'No. 2 Brudefølget drar forbi (The Bridal Procession Passes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13747 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:be3ac7b2-e1ad-3a9e-800b-5dde28e3d175' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be3ac7b2-e1ad-3a9e-800b-5dde28e3d175', 2, NULL, '신부 행렬이 지나간다 (Brudefølget drar forbi)', 'No. 2 Brudefølget drar forbi (The Bridal Procession Passes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13747 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be3ac7b2-e1ad-3a9e-800b-5dde28e3d175'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '사육제에서 (Fra Karnevalet)', part.name_en = 'No. 3 Fra Karnevalet (From the Carnival)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13747 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:02506192-c189-3edd-a967-041011ccfa81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02506192-c189-3edd-a967-041011ccfa81', 3, NULL, '사육제에서 (Fra Karnevalet)', 'No. 3 Fra Karnevalet (From the Carnival)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13747 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02506192-c189-3edd-a967-041011ccfa81'
);


-- Op. 20 합창과 관현악을 위한 <수도원 문 앞에서>

UPDATE pieces piece
SET piece.title = '합창과 관현악을 위한 <수도원 문 앞에서>', piece.title_en = 'Before a Southern Convent (Foran Sydens Kloster)',
    piece.type = 'song', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13763 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 13763 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- Op. 21 <어부의 딸>에 의한 4개의 가곡

UPDATE pieces piece
SET piece.title = '<어부의 딸>에 의한 4개의 가곡', piece.title_en = '4 Poems from "Fiskerjenten", Op. 21',
    piece.type = 'album', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14463 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 14463 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '첫 만남 (Det første Møde)', part.name_en = 'No. 1 Det første Møde (The First Meeting)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14463 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:13d475da-6c16-43d7-9511-0edf41ba24e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d475da-6c16-43d7-9511-0edf41ba24e0', 1, NULL, '첫 만남 (Det første Møde)', 'No. 1 Det første Møde (The First Meeting)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14463 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d475da-6c16-43d7-9511-0edf41ba24e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'God morgen', part.name_en = 'No. 2 God morgen (Good Morning)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14463 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4d51e4ee-efd5-483c-b0ea-ecc2638e6515' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d51e4ee-efd5-483c-b0ea-ecc2638e6515', 2, NULL, 'God morgen', 'No. 2 God morgen (Good Morning)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14463 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d51e4ee-efd5-483c-b0ea-ecc2638e6515'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jeg giver mit Digt til Våren', part.name_en = 'No. 3 Jeg giver mit Digt til Våren (To Springtime My Song I''m Singing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14463 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:18ae58dc-a934-4d70-bdca-ad4e21ac21d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18ae58dc-a934-4d70-bdca-ad4e21ac21d7', 3, NULL, 'Jeg giver mit Digt til Våren', 'No. 3 Jeg giver mit Digt til Våren (To Springtime My Song I''m Singing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14463 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18ae58dc-a934-4d70-bdca-ad4e21ac21d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tak for dit Råd', part.name_en = 'No. 4 Tak for dit Råd (Say What You Will)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14463 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:418e76db-9e32-4ca7-8430-97c0db6858ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:418e76db-9e32-4ca7-8430-97c0db6858ba', 4, NULL, 'Tak for dit Råd', 'No. 4 Tak for dit Råd (Say What You Will)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14463 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:418e76db-9e32-4ca7-8430-97c0db6858ba'
);


-- Op. 22 부수음악 <시구르드 요르살파르>

UPDATE pieces piece
SET piece.title = '부수음악 <시구르드 요르살파르>', piece.title_en = 'Sigurd Jorsalfar, Incidental Music',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14816 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 14816 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '제1막 전주곡 (Innledning til Akt I)', part.name_en = 'No. 1 Prelude to Act I (Innledning til Akt I)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5bc07ef4-ce55-356c-86b2-59864a28bfec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bc07ef4-ce55-356c-86b2-59864a28bfec', 1, NULL, '제1막 전주곡 (Innledning til Akt I)', 'No. 1 Prelude to Act I (Innledning til Akt I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bc07ef4-ce55-356c-86b2-59864a28bfec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '보르힐드의 꿈 (Borghilds Drøm)', part.name_en = 'No. 2 Borghild''s Dream (Borghilds Drøm)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3aa799a2-9336-3a0e-9cfb-2efda9efded8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aa799a2-9336-3a0e-9cfb-2efda9efded8', 2, NULL, '보르힐드의 꿈 (Borghilds Drøm)', 'No. 2 Borghild''s Dream (Borghilds Drøm)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aa799a2-9336-3a0e-9cfb-2efda9efded8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '겨루기에서 (Ved Mandjevningen)', part.name_en = 'No. 3 At the Matching Game (Ved Mandjevningen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2ee5a38a-1f95-3e72-97df-2bf80142c860' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ee5a38a-1f95-3e72-97df-2bf80142c860', 3, NULL, '겨루기에서 (Ved Mandjevningen)', 'No. 3 At the Matching Game (Ved Mandjevningen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ee5a38a-1f95-3e72-97df-2bf80142c860'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '노래: 북방 민족 (Kvad: Norrønafolket)', part.name_en = 'No. 4 Song: The Northland Folk (Kvad: Norrønafolket)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:aae5e62f-dfcb-3fcd-b9a2-7e4e7983a7ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aae5e62f-dfcb-3fcd-b9a2-7e4e7983a7ba', 4, NULL, '노래: 북방 민족 (Kvad: Norrønafolket)', 'No. 4 Song: The Northland Folk (Kvad: Norrønafolket)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aae5e62f-dfcb-3fcd-b9a2-7e4e7983a7ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '충성 행진곡 (Hyldningsmarsch)', part.name_en = 'No. 5 Homage March (Hyldningsmarsch)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ebdf0a1b-1b7e-3ee5-b2d4-d0c8135cb8bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebdf0a1b-1b7e-3ee5-b2d4-d0c8135cb8bb', 5, NULL, '충성 행진곡 (Hyldningsmarsch)', 'No. 5 Homage March (Hyldningsmarsch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebdf0a1b-1b7e-3ee5-b2d4-d0c8135cb8bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '간주곡 I (Mellomspill I)', part.name_en = 'No. 6 Interlude I (Mellomspill I)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:15f131e0-bf6e-3f28-8e3e-3090e42cad43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15f131e0-bf6e-3f28-8e3e-3090e42cad43', 6, NULL, '간주곡 I (Mellomspill I)', 'No. 6 Interlude I (Mellomspill I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f131e0-bf6e-3f28-8e3e-3090e42cad43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '간주곡 II (Mellomspill II)', part.name_en = 'No. 7 Interlude II (Mellomspill II)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8f2deb4a-846c-3508-a80b-927a543b9d2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f2deb4a-846c-3508-a80b-927a543b9d2e', 7, NULL, '간주곡 II (Mellomspill II)', 'No. 7 Interlude II (Mellomspill II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f2deb4a-846c-3508-a80b-927a543b9d2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '왕의 노래 (Kongekvadet)', part.name_en = 'No. 8 The King''s Song (Kongekvadet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:da4eb628-7c89-3ea8-a35f-09504af424b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da4eb628-7c89-3ea8-a35f-09504af424b0', 8, NULL, '왕의 노래 (Kongekvadet)', 'No. 8 The King''s Song (Kongekvadet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da4eb628-7c89-3ea8-a35f-09504af424b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '호른 신호 (Hornsignaler)', part.name_en = 'No. 9 Horn Signals (Hornsignaler)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14816 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:87deb0ee-2a91-3799-a7ce-9073a739d81d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87deb0ee-2a91-3799-a7ce-9073a739d81d', 9, NULL, '호른 신호 (Hornsignaler)', 'No. 9 Horn Signals (Hornsignaler)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14816 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87deb0ee-2a91-3799-a7ce-9073a739d81d'
);


-- Op. 23 극음악 <페르 귄트>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 15474 AND linked.composer_id = 117),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '제1막 전주곡: 결혼식장에서 (I Bryllupsgården)', part.name_en = 'No. 1 Prelude to Act I: At the Wedding (I Bryllupsgården)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:99bf63d6-a8a7-3a40-ab32-ab9f12d84c4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15474 AND linked.composer_id = 117), 'musicbrainz:99bf63d6-a8a7-3a40-ab32-ab9f12d84c4a', 1, NULL, '제1막 전주곡: 결혼식장에서 (I Bryllupsgården)', 'No. 1 Prelude to Act I: At the Wedding (I Bryllupsgården)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99bf63d6-a8a7-3a40-ab32-ab9f12d84c4a'
);

UPDATE pieces piece
SET piece.title = '극음악 <페르 귄트> 중 "제1막 전주곡: 결혼식장에서 (I Bryllupsgården)"', piece.title_en = 'Peer Gynt, Incidental Music: No. 1 Prelude to Act I: At the Wedding (I Bryllupsgården)', piece.editor_locked = 1
WHERE piece.id = 15474 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '신부 행렬이 지나간다 (Brudefølget drar forbi)', part.name_en = 'No. 2 The Bridal Procession (Brudefølget drar forbi)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b88b0f6b-d5cc-42c4-9d62-fd44dc1b8a6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b88b0f6b-d5cc-42c4-9d62-fd44dc1b8a6a', 2, NULL, '신부 행렬이 지나간다 (Brudefølget drar forbi)', 'No. 2 The Bridal Procession (Brudefølget drar forbi)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b88b0f6b-d5cc-42c4-9d62-fd44dc1b8a6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '할링 (Halling)', part.name_en = 'No. 3 Halling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fb981465-16bc-3c81-8d65-5f2dec0d8050' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb981465-16bc-3c81-8d65-5f2dec0d8050', 3, NULL, '할링 (Halling)', 'No. 3 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb981465-16bc-3c81-8d65-5f2dec0d8050'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '스프링가르 (Springar)', part.name_en = 'No. 4 Springar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:91341b87-7e59-361f-8cd3-f0118822ad5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91341b87-7e59-361f-8cd3-f0118822ad5c', 4, NULL, '스프링가르 (Springar)', 'No. 4 Springar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91341b87-7e59-361f-8cd3-f0118822ad5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '제2막 전주곡: 신부의 약탈, 잉그리드의 탄식 (Bruderovet. Ingrids klage)', part.name_en = 'No. 5 Prelude to Act II: The Abduction of the Bride. Ingrid''s Lament (Bruderovet. Ingrids klage)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e93e74de-85ee-3823-801d-497c044a6c3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e93e74de-85ee-3823-801d-497c044a6c3a', 5, NULL, '제2막 전주곡: 신부의 약탈, 잉그리드의 탄식 (Bruderovet. Ingrids klage)', 'No. 5 Prelude to Act II: The Abduction of the Bride. Ingrid''s Lament (Bruderovet. Ingrids klage)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e93e74de-85ee-3823-801d-497c044a6c3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '페르 귄트와 목장 처녀들 (Peer Gynt og sæterjentene)', part.name_en = 'No. 6 Peer Gynt and the Herd-Girls (Peer Gynt og sæterjentene)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2c08072a-3176-3681-a679-0d1f5ef53cd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c08072a-3176-3681-a679-0d1f5ef53cd4', 6, NULL, '페르 귄트와 목장 처녀들 (Peer Gynt og sæterjentene)', 'No. 6 Peer Gynt and the Herd-Girls (Peer Gynt og sæterjentene)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c08072a-3176-3681-a679-0d1f5ef53cd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 14421 AND linked.composer_id = 117),
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '페르 귄트와 초록 옷의 여인 (Peer Gynt og den grønkledte)', part.name_en = 'No. 7 Peer Gynt and the Woman in Green (Peer Gynt og den grønkledte)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9e721a3f-6c71-3735-9cb4-74a52ed18476' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 14421 AND linked.composer_id = 117), 'musicbrainz:9e721a3f-6c71-3735-9cb4-74a52ed18476', 7, NULL, '페르 귄트와 초록 옷의 여인 (Peer Gynt og den grønkledte)', 'No. 7 Peer Gynt and the Woman in Green (Peer Gynt og den grønkledte)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e721a3f-6c71-3735-9cb4-74a52ed18476'
);

UPDATE pieces piece
SET piece.title = '극음악 <페르 귄트> 중 "페르 귄트와 초록 옷의 여인 (Peer Gynt og den grønkledte)"', piece.title_en = 'Peer Gynt, Incidental Music: No. 7 Peer Gynt and the Woman in Green (Peer Gynt og den grønkledte)', piece.editor_locked = 1
WHERE piece.id = 14421 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '말 탄 모습으로 귀인을 알아본다 (På ridestellet skal storfolk kjendes)', part.name_en = 'No. 8 By His Mount You Shall Judge Him (På ridestellet skal storfolk kjendes)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e0a1e38c-8f06-3c28-b831-07c4a79be751' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0a1e38c-8f06-3c28-b831-07c4a79be751', 8, NULL, '말 탄 모습으로 귀인을 알아본다 (På ridestellet skal storfolk kjendes)', 'No. 8 By His Mount You Shall Judge Him (På ridestellet skal storfolk kjendes)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0a1e38c-8f06-3c28-b831-07c4a79be751'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '산속 마왕의 궁전에서 (I Dovregubbens hall)', part.name_en = 'No. 9 In the Hall of the Mountain King (I Dovregubbens hall)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6d5d6196-a6bd-357f-91b4-ea9c2cae5214' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d5d6196-a6bd-357f-91b4-ea9c2cae5214', 9, NULL, '산속 마왕의 궁전에서 (I Dovregubbens hall)', 'No. 9 In the Hall of the Mountain King (I Dovregubbens hall)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d5d6196-a6bd-357f-91b4-ea9c2cae5214'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 14371 AND linked.composer_id = 117),
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '마왕의 딸의 춤 (Dans av Dovregubbens datter)', part.name_en = 'No. 10 Dance of the Mountain King''s Daughter (Dans av Dovregubbens datter)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ecbb9498-23b5-36b9-a1d2-85fb0a13626b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 14371 AND linked.composer_id = 117), 'musicbrainz:ecbb9498-23b5-36b9-a1d2-85fb0a13626b', 10, NULL, '마왕의 딸의 춤 (Dans av Dovregubbens datter)', 'No. 10 Dance of the Mountain King''s Daughter (Dans av Dovregubbens datter)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecbb9498-23b5-36b9-a1d2-85fb0a13626b'
);

UPDATE pieces piece
SET piece.title = '극음악 <페르 귄트> 중 "마왕의 딸의 춤 (Dans av Dovregubbens datter)"', piece.title_en = 'Peer Gynt, Incidental Music: No. 10 Dance of the Mountain King''s Daughter (Dans av Dovregubbens datter)', piece.editor_locked = 1
WHERE piece.id = 14371 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '트롤에게 쫓기는 페르 귄트 (Peer Gynt jages av troll)', part.name_en = 'No. 11 Peer Gynt Hunted by the Trolls (Peer Gynt jages av troll)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:19536fed-4746-37bb-8691-3746bb834d37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19536fed-4746-37bb-8691-3746bb834d37', 11, NULL, '트롤에게 쫓기는 페르 귄트 (Peer Gynt jages av troll)', 'No. 11 Peer Gynt Hunted by the Trolls (Peer Gynt jages av troll)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19536fed-4746-37bb-8691-3746bb834d37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '페르 귄트와 뵈위그 (Peer Gynt og Bøygen)', part.name_en = 'No. 12 Peer Gynt and the Bøyg (Peer Gynt og Bøygen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d35589ff-04fd-373e-8472-9cb8cc019cc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d35589ff-04fd-373e-8472-9cb8cc019cc6', 12, NULL, '페르 귄트와 뵈위그 (Peer Gynt og Bøygen)', 'No. 12 Peer Gynt and the Bøyg (Peer Gynt og Bøygen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d35589ff-04fd-373e-8472-9cb8cc019cc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '제3막 전주곡: 깊은 숲속에서 (Dypt inne i barskogen)', part.name_en = 'No. 13 Prelude to Act III: Deep in the Forest (Dypt inne i barskogen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0930fef3-8168-45f9-8130-603b0892935c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0930fef3-8168-45f9-8130-603b0892935c', 13, NULL, '제3막 전주곡: 깊은 숲속에서 (Dypt inne i barskogen)', 'No. 13 Prelude to Act III: Deep in the Forest (Dypt inne i barskogen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0930fef3-8168-45f9-8130-603b0892935c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '오세의 죽음 (Åses død)', part.name_en = 'No. 14 The Death of Åse (Åses død)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8a6d9426-75d3-360a-8eaa-898158aedc04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a6d9426-75d3-360a-8eaa-898158aedc04', 14, NULL, '오세의 죽음 (Åses død)', 'No. 14 The Death of Åse (Åses død)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a6d9426-75d3-360a-8eaa-898158aedc04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '제4막 전주곡: 아침 기분 (Morgenstemning)', part.name_en = 'No. 15 Prelude to Act IV: Morning Mood (Morgenstemning)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a6cd27b7-1bd4-3c53-bacc-fc16d23cb21b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6cd27b7-1bd4-3c53-bacc-fc16d23cb21b', 15, NULL, '제4막 전주곡: 아침 기분 (Morgenstemning)', 'No. 15 Prelude to Act IV: Morning Mood (Morgenstemning)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6cd27b7-1bd4-3c53-bacc-fc16d23cb21b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '도둑과 장물아비 (Tyven og heleren)', part.name_en = 'No. 16 The Thief and the Receiver (Tyven og heleren)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f160a1dd-8a23-377a-ad7f-d3e65716f396' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f160a1dd-8a23-377a-ad7f-d3e65716f396', 16, NULL, '도둑과 장물아비 (Tyven og heleren)', 'No. 16 The Thief and the Receiver (Tyven og heleren)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f160a1dd-8a23-377a-ad7f-d3e65716f396'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '아라비아의 춤 (Arabisk dans)', part.name_en = 'No. 17 Arabian Dance (Arabisk dans)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:86d7d524-67df-36be-9a73-de5813fa6f93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86d7d524-67df-36be-9a73-de5813fa6f93', 17, NULL, '아라비아의 춤 (Arabisk dans)', 'No. 17 Arabian Dance (Arabisk dans)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86d7d524-67df-36be-9a73-de5813fa6f93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '아니트라의 춤 (Anitras dans)', part.name_en = 'No. 18 Anitra''s Dance (Anitras dans)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:23862aa9-ff43-3103-bb27-59a3283bccf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23862aa9-ff43-3103-bb27-59a3283bccf1', 18, NULL, '아니트라의 춤 (Anitras dans)', 'No. 18 Anitra''s Dance (Anitras dans)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23862aa9-ff43-3103-bb27-59a3283bccf1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = '페르 귄트의 세레나데 (Peer Gynts serenade)', part.name_en = 'No. 19 Peer Gynt''s Serenade (Peer Gynts serenade)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6bc4f9f9-6351-35f7-946f-9e6b8a664216' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bc4f9f9-6351-35f7-946f-9e6b8a664216', 19, NULL, '페르 귄트의 세레나데 (Peer Gynts serenade)', 'No. 19 Peer Gynt''s Serenade (Peer Gynts serenade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bc4f9f9-6351-35f7-946f-9e6b8a664216'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '페르 귄트와 아니트라 (Peer Gynt og Anitra)', part.name_en = 'No. 20 Peer Gynt and Anitra (Peer Gynt og Anitra)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:34b75153-be30-3ff7-8393-6ae7a7faefc0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34b75153-be30-3ff7-8393-6ae7a7faefc0', 20, NULL, '페르 귄트와 아니트라 (Peer Gynt og Anitra)', 'No. 20 Peer Gynt and Anitra (Peer Gynt og Anitra)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34b75153-be30-3ff7-8393-6ae7a7faefc0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = '솔베이그의 노래 (Solveigs sang)', part.name_en = 'No. 21 Solveig''s Song (Solveigs sang)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:16772929-23c7-3615-9135-97c90940ea93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16772929-23c7-3615-9135-97c90940ea93', 21, NULL, '솔베이그의 노래 (Solveigs sang)', 'No. 21 Solveig''s Song (Solveigs sang)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16772929-23c7-3615-9135-97c90940ea93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = '멤논 석상 앞의 페르 귄트 (Peer Gynt ved Memnonstøtten)', part.name_en = 'No. 22 Peer Gynt at the Statue of Memnon (Peer Gynt ved Memnonstøtten)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c9738be1-5f23-3a96-9fc5-802e89af9ecc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9738be1-5f23-3a96-9fc5-802e89af9ecc', 22, NULL, '멤논 석상 앞의 페르 귄트 (Peer Gynt ved Memnonstøtten)', 'No. 22 Peer Gynt at the Statue of Memnon (Peer Gynt ved Memnonstøtten)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9738be1-5f23-3a96-9fc5-802e89af9ecc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = '제5막 전주곡: 페르 귄트의 귀향 (Peer Gynts hjemfart)', part.name_en = 'No. 23 Prelude to Act V: Peer Gynt''s Homecoming (Peer Gynts hjemfart)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4e7f0e2e-f81a-309a-9248-ab0feae976c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7f0e2e-f81a-309a-9248-ab0feae976c3', 23, NULL, '제5막 전주곡: 페르 귄트의 귀향 (Peer Gynts hjemfart)', 'No. 23 Prelude to Act V: Peer Gynt''s Homecoming (Peer Gynts hjemfart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7f0e2e-f81a-309a-9248-ab0feae976c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = '난파 (Skipsforliset)', part.name_en = 'No. 24 The Shipwreck (Skipsforliset)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:7d5c5c5f-c780-31a9-9caf-179e0570d093' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d5c5c5f-c780-31a9-9caf-179e0570d093', 24, NULL, '난파 (Skipsforliset)', 'No. 24 The Shipwreck (Skipsforliset)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d5c5c5f-c780-31a9-9caf-179e0570d093'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = '오두막에서 노래하는 솔베이그 (Solveig synger i hytten)', part.name_en = 'No. 25 Solveig Sings in the Hut (Solveig synger i hytten)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4e88b44a-1421-395a-9f98-11ea4f8aa9be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e88b44a-1421-395a-9f98-11ea4f8aa9be', 25, NULL, '오두막에서 노래하는 솔베이그 (Solveig synger i hytten)', 'No. 25 Solveig Sings in the Hut (Solveig synger i hytten)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e88b44a-1421-395a-9f98-11ea4f8aa9be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 14306 AND linked.composer_id = 117),
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = '밤 장면 (Nattscene)', part.name_en = 'No. 26 Night Scene (Nattscene)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:1a726a05-8cfc-34fa-95e5-80615654e9d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 14306 AND linked.composer_id = 117), 'musicbrainz:1a726a05-8cfc-34fa-95e5-80615654e9d1', 26, NULL, '밤 장면 (Nattscene)', 'No. 26 Night Scene (Nattscene)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a726a05-8cfc-34fa-95e5-80615654e9d1'
);

UPDATE pieces piece
SET piece.title = '극음악 <페르 귄트> 중 "밤 장면 (Nattscene)"', piece.title_en = 'Peer Gynt, Incidental Music: No. 26 Night Scene (Nattscene)', piece.editor_locked = 1
WHERE piece.id = 14306 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = '성령강림절 찬송 (Pinsesalme)', part.name_en = 'No. 27 Whitsun Hymn (Pinsesalme)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:47e94dce-ce5c-36c5-8297-ff88291b387a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47e94dce-ce5c-36c5-8297-ff88291b387a', 27, NULL, '성령강림절 찬송 (Pinsesalme)', 'No. 27 Whitsun Hymn (Pinsesalme)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47e94dce-ce5c-36c5-8297-ff88291b387a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = '솔베이그의 자장가 (Solveigs vuggevise)', part.name_en = 'No. 28 Solveig''s Cradle Song (Solveigs vuggevise)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14198 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3f301626-5e0b-37c2-82b8-40e5410d7eed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f301626-5e0b-37c2-82b8-40e5410d7eed', 28, NULL, '솔베이그의 자장가 (Solveigs vuggevise)', 'No. 28 Solveig''s Cradle Song (Solveigs vuggevise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14198 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f301626-5e0b-37c2-82b8-40e5410d7eed'
);


-- Op. 24 발라드 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 G단조', 'Ballade in G minor (in the Form of Variations on a Norwegian Folk Song)', 'song', 'Op. 24', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd811e5b2-006d-4855-8984-ee8fdbb8d7ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd811e5b2-006d-4855-8984-ee8fdbb8d7ae'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '발라드 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd811e5b2-006d-4855-8984-ee8fdbb8d7ae'
);


-- Op. 25 입센 시에 의한 6개의 가곡

UPDATE pieces piece
SET piece.title = '입센 시에 의한 6개의 가곡', piece.title_en = '6 Poems by Henrik Ibsen, Op. 25',
    piece.type = 'album', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1876, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14993 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1876
WHERE piece.id = 14993 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Spillemænd', part.name_en = 'No. 1 Spillemænd (Fiddlers)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14993 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ef9a4f7e-8a25-4e20-912b-e7e0ce50684c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef9a4f7e-8a25-4e20-912b-e7e0ce50684c', 1, NULL, 'Spillemænd', 'No. 1 Spillemænd (Fiddlers)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14993 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef9a4f7e-8a25-4e20-912b-e7e0ce50684c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '백조 (En Svane)', part.name_en = 'No. 2 En Svane (A Swan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14993 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e3d56a2e-28ea-4836-9eba-b0dda4a8a6bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3d56a2e-28ea-4836-9eba-b0dda4a8a6bc', 2, NULL, '백조 (En Svane)', 'No. 2 En Svane (A Swan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14993 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3d56a2e-28ea-4836-9eba-b0dda4a8a6bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Stambogsrim', part.name_en = 'No. 3 Stambogsrim (Album Lines)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14993 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:38b066c3-e2dc-43fb-90ce-b094890cf7b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38b066c3-e2dc-43fb-90ce-b094890cf7b4', 3, NULL, 'Stambogsrim', 'No. 3 Stambogsrim (Album Lines)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14993 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38b066c3-e2dc-43fb-90ce-b094890cf7b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Med en Vandlilje', part.name_en = 'No. 4 Med en Vandlilje (With a Water Lily)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14993 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:dc8f76c2-5249-4df2-9f7a-adbf75e481c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc8f76c2-5249-4df2-9f7a-adbf75e481c7', 4, NULL, 'Med en Vandlilje', 'No. 4 Med en Vandlilje (With a Water Lily)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14993 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc8f76c2-5249-4df2-9f7a-adbf75e481c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Borte!', part.name_en = 'No. 5 Borte! (Departed)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14993 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:704a3e46-3603-43bc-8902-e480761d2975' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:704a3e46-3603-43bc-8902-e480761d2975', 5, NULL, 'Borte!', 'No. 5 Borte! (Departed)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14993 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:704a3e46-3603-43bc-8902-e480761d2975'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'En Fuglevise', part.name_en = 'No. 6 En Fuglevise (A Bird-Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14993 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5c30a029-f719-4620-acd2-9feb0ea54dbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c30a029-f719-4620-acd2-9feb0ea54dbf', 6, NULL, 'En Fuglevise', 'No. 6 En Fuglevise (A Bird-Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14993 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c30a029-f719-4620-acd2-9feb0ea54dbf'
);


-- Op. 26 욘 파울센 시에 의한 5개의 가곡

UPDATE pieces piece
SET piece.title = '욘 파울센 시에 의한 5개의 가곡', piece.title_en = '5 Poems by John Paulsen, Op. 26',
    piece.type = 'album', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1876, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15161 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1876
WHERE piece.id = 15161 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Et Håb', part.name_en = 'No. 1 Et Håb (Hope)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15161 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4c8f4830-6818-49fa-9c3b-110bc135e154' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c8f4830-6818-49fa-9c3b-110bc135e154', 1, NULL, 'Et Håb', 'No. 1 Et Håb (Hope)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15161 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c8f4830-6818-49fa-9c3b-110bc135e154'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Jeg reiste en deilig Sommerkvæld', part.name_en = 'No. 2 Jeg reiste en deilig Sommerkvæld (I Walked One Balmy Summer Eve)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15161 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:155646bb-73ac-4f56-aa29-d90db99251e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:155646bb-73ac-4f56-aa29-d90db99251e7', 2, NULL, 'Jeg reiste en deilig Sommerkvæld', 'No. 2 Jeg reiste en deilig Sommerkvæld (I Walked One Balmy Summer Eve)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15161 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:155646bb-73ac-4f56-aa29-d90db99251e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'De Ærgjerrige', part.name_en = 'No. 3 De Ærgjerrige (You Whispered That You Loved Me)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15161 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9f1aab80-6e5c-46f9-b7b4-500b90a3db62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f1aab80-6e5c-46f9-b7b4-500b90a3db62', 3, NULL, 'De Ærgjerrige', 'No. 3 De Ærgjerrige (You Whispered That You Loved Me)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15161 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f1aab80-6e5c-46f9-b7b4-500b90a3db62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Med en Primula veris', part.name_en = 'No. 4 Med en Primula veris (The First Primrose)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15161 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f1bbd2dc-f45b-4030-a972-1f7da80c2536' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1bbd2dc-f45b-4030-a972-1f7da80c2536', 4, NULL, 'Med en Primula veris', 'No. 4 Med en Primula veris (The First Primrose)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15161 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1bbd2dc-f45b-4030-a972-1f7da80c2536'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'På Skogstien', part.name_en = 'No. 5 På Skogstien (Autumn Thoughts)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15161 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c858e1d7-3a3f-4868-912a-baef3c860215' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c858e1d7-3a3f-4868-912a-baef3c860215', 5, NULL, 'På Skogstien', 'No. 5 På Skogstien (Autumn Thoughts)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15161 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c858e1d7-3a3f-4868-912a-baef3c860215'
);


-- Op. 27 현악 4중주 1번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번 G단조', 'String Quartet No. 1 in G minor', 'album', 'Op. 27', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6438fd2a-1791-4cac-91e3-907bab521b4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6438fd2a-1791-4cac-91e3-907bab521b4a'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '현악 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6438fd2a-1791-4cac-91e3-907bab521b4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8d34922-9225-3f7a-8e94-2ba5a46963df', 1, 'I', 'Un poco andante – Allegro molto ed agitato', 'I. Un poco andante – Allegro molto ed agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '현악 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8d34922-9225-3f7a-8e94-2ba5a46963df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2927a86-2fb1-3c50-be89-1c2f08a77fa6', 2, 'II', '로망스. Andantino – Allegro agitato', 'II. Romanze. Andantino – Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '현악 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2927a86-2fb1-3c50-be89-1c2f08a77fa6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f68a5f3-9a5a-38c1-9a88-4448233a1540', 3, 'III', '간주곡. Allegro molto marcato – Più vivo e scherzando', 'III. Intermezzo. Allegro molto marcato – Più vivo e scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '현악 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f68a5f3-9a5a-38c1-9a88-4448233a1540'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b6378fb-c9a2-3cd6-8a2c-b1b5dc822e37', 4, 'IV', '피날레. Lento – Presto al saltarello', 'IV. Finale. Lento – Presto al saltarello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '현악 4중주 1번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b6378fb-c9a2-3cd6-8a2c-b1b5dc822e37'
);


-- Op. 28 4개의 앨범의 잎 Op. 28

UPDATE pieces piece
SET piece.title = '4개의 앨범의 잎 Op. 28', piece.title_en = '4 Album Leaves, Op. 28',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '28',
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13944 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 13944 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'A♭장조', part.name_en = 'No. 1 Allegro con moto in A♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13944 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b4a8cafb-76d7-35c9-9967-a01a8168639e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4a8cafb-76d7-35c9-9967-a01a8168639e', 1, NULL, 'A♭장조', 'No. 1 Allegro con moto in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13944 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4a8cafb-76d7-35c9-9967-a01a8168639e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = 'No. 2 Allegretto espressivo in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13944 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f1f8993c-5b37-3ec4-aef1-99069121cfd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1f8993c-5b37-3ec4-aef1-99069121cfd6', 2, NULL, 'F장조', 'No. 2 Allegretto espressivo in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13944 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1f8993c-5b37-3ec4-aef1-99069121cfd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'No. 3 Vivace in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13944 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fac59269-6895-334a-b3a6-0cc836703800' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fac59269-6895-334a-b3a6-0cc836703800', 3, NULL, 'A장조', 'No. 3 Vivace in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13944 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fac59269-6895-334a-b3a6-0cc836703800'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C#단조', part.name_en = 'No. 4 Andantino serioso in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13944 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ca068781-c388-3bcb-9d2b-29b7b8c9027e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca068781-c388-3bcb-9d2b-29b7b8c9027e', 4, NULL, 'C#단조', 'No. 4 Andantino serioso in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13944 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca068781-c388-3bcb-9d2b-29b7b8c9027e'
);


-- Op. 29 노르웨이 민요에 의한 2개의 즉흥곡

UPDATE pieces piece
SET piece.title = '노르웨이 민요에 의한 2개의 즉흥곡', piece.title_en = 'Improvisations on Two Norwegian Folk Songs, Op. 29',
    piece.type = 'album', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14443 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 14443 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Guten og gjenta på fjøshellen', part.name_en = 'No. 1 Guten og gjenta på fjøshellen. Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14443 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5d3c97e7-3a83-3516-afe3-745ee4affab4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d3c97e7-3a83-3516-afe3-745ee4affab4', 1, NULL, 'Guten og gjenta på fjøshellen', 'No. 1 Guten og gjenta på fjøshellen. Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14443 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d3c97e7-3a83-3516-afe3-745ee4affab4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dæ var eigong en Kungje', part.name_en = 'No. 2 Dæ var eigong en Kungje. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14443 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b4ea36a9-486e-305b-98fd-f655effda358' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4ea36a9-486e-305b-98fd-f655effda358', 2, NULL, 'Dæ var eigong en Kungje', 'No. 2 Dæ var eigong en Kungje. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14443 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4ea36a9-486e-305b-98fd-f655effda358'
);


-- Op. 30 남성 합창곡집 Op. 30

UPDATE pieces piece
SET piece.title = '남성 합창곡집 Op. 30', piece.title_en = 'Album for Male Voices, Op. 30',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '30',
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13897 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 13897 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jeg lagde mig så sildig', part.name_en = 'No. 1 Jeg lagde mig så sildig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0ce275fe-58d4-3993-addf-a647dea81bed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ce275fe-58d4-3993-addf-a647dea81bed', 1, NULL, 'Jeg lagde mig så sildig', 'No. 1 Jeg lagde mig så sildig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ce275fe-58d4-3993-addf-a647dea81bed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bådn-Låt', part.name_en = 'No. 2 Bådn-Låt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2e76128f-2f0a-4e9e-b9c8-05f83189ad9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e76128f-2f0a-4e9e-b9c8-05f83189ad9f', 2, NULL, 'Bådn-Låt', 'No. 2 Bådn-Låt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e76128f-2f0a-4e9e-b9c8-05f83189ad9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Torø liti', part.name_en = 'No. 3 Torø liti',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:96a997f0-f80f-3c13-914c-c281bef7d8f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96a997f0-f80f-3c13-914c-c281bef7d8f5', 3, NULL, 'Torø liti', 'No. 3 Torø liti', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96a997f0-f80f-3c13-914c-c281bef7d8f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Halling', part.name_en = 'No. 4 Halling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:720be6e0-33b2-3d00-b09b-ac412386a856' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:720be6e0-33b2-3d00-b09b-ac412386a856', 4, NULL, 'Halling', 'No. 4 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:720be6e0-33b2-3d00-b09b-ac412386a856'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Dæ æ den største Dårligheit', part.name_en = 'No. 5 Dæ æ den største Dårligheit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:03a8661b-a269-47f3-a608-b6273555a9d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03a8661b-a269-47f3-a608-b6273555a9d8', 5, NULL, 'Dæ æ den største Dårligheit', 'No. 5 Dæ æ den største Dårligheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a8661b-a269-47f3-a608-b6273555a9d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Går e ut ein Kveld', part.name_en = 'No. 6 Går e ut ein Kveld',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:88807408-c0b0-39eb-9b5f-83c65404c34a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88807408-c0b0-39eb-9b5f-83c65404c34a', 6, NULL, 'Går e ut ein Kveld', 'No. 6 Går e ut ein Kveld', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88807408-c0b0-39eb-9b5f-83c65404c34a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Han Ole', part.name_en = 'No. 7 Han Ole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c1063699-fd4e-45f3-b93d-c6b787ce5a3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1063699-fd4e-45f3-b93d-c6b787ce5a3e', 7, NULL, 'Han Ole', 'No. 7 Han Ole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1063699-fd4e-45f3-b93d-c6b787ce5a3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Halling', part.name_en = 'No. 8 Halling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5d1c2a8f-5272-44e4-9d02-7273284cdf6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d1c2a8f-5272-44e4-9d02-7273284cdf6e', 8, NULL, 'Halling', 'No. 8 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d1c2a8f-5272-44e4-9d02-7273284cdf6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Deiligste blandt Kvinder', part.name_en = 'No. 9 Deiligste blandt Kvinder',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8f3e5e39-6889-44f0-98cd-5d231b42eeae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f3e5e39-6889-44f0-98cd-5d231b42eeae', 9, NULL, 'Deiligste blandt Kvinder', 'No. 9 Deiligste blandt Kvinder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f3e5e39-6889-44f0-98cd-5d231b42eeae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Den store, hvide Flok', part.name_en = 'No. 10 Den store, hvide Flok',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:21f2f7a4-ad67-4bbf-b274-4ae7c3ecfbdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21f2f7a4-ad67-4bbf-b274-4ae7c3ecfbdf', 10, NULL, 'Den store, hvide Flok', 'No. 10 Den store, hvide Flok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f2f7a4-ad67-4bbf-b274-4ae7c3ecfbdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Fantegutten', part.name_en = 'No. 11 Fantegutten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4258d6fb-b09c-4193-b1fa-8de84bce33c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4258d6fb-b09c-4193-b1fa-8de84bce33c4', 11, NULL, 'Fantegutten', 'No. 11 Fantegutten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4258d6fb-b09c-4193-b1fa-8de84bce33c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Røtnams Knut', part.name_en = 'No. 12 Røtnams Knut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13897 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4a52985b-7896-4597-9bf8-1a41203667bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a52985b-7896-4597-9bf8-1a41203667bf', 12, NULL, 'Røtnams Knut', 'No. 12 Røtnams Knut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13897 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a52985b-7896-4597-9bf8-1a41203667bf'
);


-- Op. 31 남성 합창곡 <육지가 보인다>

UPDATE pieces piece
SET piece.title = '남성 합창곡 <육지가 보인다>', piece.title_en = 'Land Sighting (Landkjenning)',
    piece.type = 'song', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14698 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 14698 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- Op. 32 독창과 관현악을 위한 <산에 홀린 사람>

UPDATE pieces piece
SET piece.title = '독창과 관현악을 위한 <산에 홀린 사람>', piece.title_en = 'The Mountain Thrall (Den Bergtekne)',
    piece.type = 'song', piece.opus_number = 'Op. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13842 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 13842 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- Op. 33 비녜 시에 의한 12개의 가곡

UPDATE pieces piece
SET piece.title = '비녜 시에 의한 12개의 가곡', piece.title_en = '12 Melodies to Poems by Aasmund Olavsson Vinje, Op. 33',
    piece.type = 'album', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15040 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 15040 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Guten', part.name_en = 'No. 1 Guten (The Youth)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6d77e1bf-a63e-4aa1-9339-8b101fb29025' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d77e1bf-a63e-4aa1-9339-8b101fb29025', 1, NULL, 'Guten', 'No. 1 Guten (The Youth)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d77e1bf-a63e-4aa1-9339-8b101fb29025'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '봄 (Våren)', part.name_en = 'No. 2 Våren (Last Spring)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f9d1dd87-7617-4707-a5a3-42200ce2ff73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9d1dd87-7617-4707-a5a3-42200ce2ff73', 2, NULL, '봄 (Våren)', 'No. 2 Våren (Last Spring)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9d1dd87-7617-4707-a5a3-42200ce2ff73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Den særde', part.name_en = 'No. 3 Den særde (The Wounded Heart)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ea43a618-e06d-45da-a60e-86ae6fc44adc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea43a618-e06d-45da-a60e-86ae6fc44adc', 3, NULL, 'Den særde', 'No. 3 Den særde (The Wounded Heart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea43a618-e06d-45da-a60e-86ae6fc44adc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Tytebæret', part.name_en = 'No. 4 Tytebæret (The Berry)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:85b81bcd-5e55-4a53-b388-8d919af8a0b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85b81bcd-5e55-4a53-b388-8d919af8a0b4', 4, NULL, 'Tytebæret', 'No. 4 Tytebæret (The Berry)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85b81bcd-5e55-4a53-b388-8d919af8a0b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Langs ei Aa', part.name_en = 'No. 5 Langs ei Aa (Beside the Stream)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c31986c9-3d90-44d2-80cb-1eb7191107d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c31986c9-3d90-44d2-80cb-1eb7191107d1', 5, NULL, 'Langs ei Aa', 'No. 5 Langs ei Aa (Beside the Stream)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c31986c9-3d90-44d2-80cb-1eb7191107d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Eit Syn', part.name_en = 'No. 6 Eit Syn (A Vision)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e9864c50-7604-4e76-8cf7-63fe7870dec2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9864c50-7604-4e76-8cf7-63fe7870dec2', 6, NULL, 'Eit Syn', 'No. 6 Eit Syn (A Vision)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9864c50-7604-4e76-8cf7-63fe7870dec2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Gamle Mor', part.name_en = 'No. 7 Gamle Mor (The Old Mother)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ef91b922-33e2-4306-8c56-b11111ad7de7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef91b922-33e2-4306-8c56-b11111ad7de7', 7, NULL, 'Gamle Mor', 'No. 7 Gamle Mor (The Old Mother)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef91b922-33e2-4306-8c56-b11111ad7de7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Det Første', part.name_en = 'No. 8 Det Første (The First Thing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8d4e549c-bff4-41d6-9677-180d9af387e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d4e549c-bff4-41d6-9677-180d9af387e5', 8, NULL, 'Det Første', 'No. 8 Det Første (The First Thing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d4e549c-bff4-41d6-9677-180d9af387e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ved Rundarne', part.name_en = 'No. 9 Ved Rundarne (At Rondane)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2d9c55d4-9cd3-3a3d-9b04-c8314bac0ba3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d9c55d4-9cd3-3a3d-9b04-c8314bac0ba3', 9, NULL, 'Ved Rundarne', 'No. 9 Ved Rundarne (At Rondane)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d9c55d4-9cd3-3a3d-9b04-c8314bac0ba3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Et Vennestykke', part.name_en = 'No. 10 Et Vennestykke (A Piece of Friendship)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3f839442-e388-4f85-94cb-bf5b46fc2bd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f839442-e388-4f85-94cb-bf5b46fc2bd1', 10, NULL, 'Et Vennestykke', 'No. 10 Et Vennestykke (A Piece of Friendship)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f839442-e388-4f85-94cb-bf5b46fc2bd1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Trudom', part.name_en = 'No. 11 Trudom (Faith)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:70b785e6-33cf-473b-94ed-afe1739af06e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70b785e6-33cf-473b-94ed-afe1739af06e', 11, NULL, 'Trudom', 'No. 11 Trudom (Faith)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70b785e6-33cf-473b-94ed-afe1739af06e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Fyremål', part.name_en = 'No. 12 Fyremål (The Goal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15040 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:18ed016a-45a6-44b4-b048-291fd577aeeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18ed016a-45a6-44b4-b048-291fd577aeeb', 12, NULL, 'Fyremål', 'No. 12 Fyremål (The Goal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15040 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18ed016a-45a6-44b4-b048-291fd577aeeb'
);


-- Op. 34 2개의 비가적 선율

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 비가적 선율', '2 Elegiac Melodies, Op. 34', 'album', 'Op. 34', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 비가적 선율'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71060811-347f-4c0c-b11b-851349f635c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '71060811-347f-4c0c-b11b-851349f635c3'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '2개의 비가적 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71060811-347f-4c0c-b11b-851349f635c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bd86dad-3db5-307e-929a-b4aee2fdfb90', 1, NULL, '가슴의 상처 (Hjertesår)', 'No. 1 Hjertesår (The Wounded Heart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '2개의 비가적 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bd86dad-3db5-307e-929a-b4aee2fdfb90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af16ae4d-5cbc-3e75-a4b4-f96b2582e1aa', 2, NULL, '지난 봄 (Våren)', 'No. 2 Våren (The Last Spring)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '2개의 비가적 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af16ae4d-5cbc-3e75-a4b4-f96b2582e1aa'
);


-- Op. 35 4개의 노르웨이 무곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 노르웨이 무곡', '4 Norwegian Dances, Op. 35', 'album', 'Op. 35', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 노르웨이 무곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec14959e-60e6-49f8-b26b-19f5a6267fa3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec14959e-60e6-49f8-b26b-19f5a6267fa3'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '4개의 노르웨이 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec14959e-60e6-49f8-b26b-19f5a6267fa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c274c46-e596-4122-810a-2315d2e2618b', 1, NULL, 'D단조', 'No. 1 Allegro marcato in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '4개의 노르웨이 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c274c46-e596-4122-810a-2315d2e2618b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00e93fcf-0ddf-4975-9e09-9f46bbb8ecc9', 2, NULL, 'A장조', 'No. 2 Allegretto tranquillo e grazioso in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '4개의 노르웨이 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00e93fcf-0ddf-4975-9e09-9f46bbb8ecc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e122cf32-4020-48f0-9a82-dcad4247b491', 3, NULL, 'G장조', 'No. 3 Allegro moderato alla marcia in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '4개의 노르웨이 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e122cf32-4020-48f0-9a82-dcad4247b491'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:900a1d7c-d76a-4295-9885-2081d0537ca7', 4, NULL, 'D장조', 'No. 4 Allegro molto in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '4개의 노르웨이 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:900a1d7c-d76a-4295-9885-2081d0537ca7'
);


-- Op. 36 첼로 소나타 A단조

UPDATE pieces piece
SET piece.title = '첼로 소나타 A단조', piece.title_en = 'Cello Sonata in A minor',
    piece.type = 'album', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13940 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 13940 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro agitato', part.name_en = 'I. Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13940 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:45368d38-7c56-4b9a-8af0-5aea232c740d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45368d38-7c56-4b9a-8af0-5aea232c740d', 1, 'I', 'Allegro agitato', 'I. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13940 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45368d38-7c56-4b9a-8af0-5aea232c740d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante molto tranquillo', part.name_en = 'II. Andante molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13940 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b2d6fcf6-e809-4402-98b6-1b96ac1ea7b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2d6fcf6-e809-4402-98b6-1b96ac1ea7b1', 2, 'II', 'Andante molto tranquillo', 'II. Andante molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13940 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2d6fcf6-e809-4402-98b6-1b96ac1ea7b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto e marcato', part.name_en = 'III. Allegro molto e marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13940 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:053c0adf-f467-4d53-bbcf-d954069a4e0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:053c0adf-f467-4d53-bbcf-d954069a4e0e', 3, 'III', 'Allegro molto e marcato', 'III. Allegro molto e marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13940 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:053c0adf-f467-4d53-bbcf-d954069a4e0e'
);


-- Op. 37 2개의 왈츠 카프리스

UPDATE pieces piece
SET piece.title = '2개의 왈츠 카프리스', piece.title_en = '2 Valse-Caprices, Op. 37',
    piece.type = 'album', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14672 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 14672 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C#단조', part.name_en = 'No. 1 Tempo di valse moderato in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14672 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:059f024d-791d-348b-abfc-495bf4830dd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:059f024d-791d-348b-abfc-495bf4830dd8', 1, NULL, 'C#단조', 'No. 1 Tempo di valse moderato in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14672 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:059f024d-791d-348b-abfc-495bf4830dd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'No. 2 Tempo di valse in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14672 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0ab7f2d5-fac3-3fe5-9357-04af874f88a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ab7f2d5-fac3-3fe5-9357-04af874f88a4', 2, NULL, 'E단조', 'No. 2 Tempo di valse in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14672 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ab7f2d5-fac3-3fe5-9357-04af874f88a4'
);


-- Op. 38 서정 소곡집 2권 Op. 38

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 2권 Op. 38', 'Lyric Pieces, Book II, Op. 38', 'album', NULL, 'Op.', '38', 1883, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 2권 Op. 38'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00e59c49-14ad-47f5-9778-967e1b8d1c91'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00e59c49-14ad-47f5-9778-967e1b8d1c91'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00e59c49-14ad-47f5-9778-967e1b8d1c91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bea9c22d-4143-39c6-9b5e-73f936a00719', 1, NULL, '자장가 (Vuggevise)', 'No. 1 Vuggevise (Cradle Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bea9c22d-4143-39c6-9b5e-73f936a00719'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfdff733-6056-31cd-be23-43802349c175', 2, NULL, '민요 (Folkevise)', 'No. 2 Folkevise (Folk Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfdff733-6056-31cd-be23-43802349c175'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51269482-fbd2-3a3b-87c7-35c3b50f59d7', 3, NULL, '선율 (Melodie)', 'No. 3 Melodie (Melody)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51269482-fbd2-3a3b-87c7-35c3b50f59d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe334115-ea24-3984-8b4c-7c8f4870ebd3', 4, NULL, '할링 (Halling)', 'No. 4 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe334115-ea24-3984-8b4c-7c8f4870ebd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57fee97d-b8ad-3a89-a012-275ffc21fee5', 5, NULL, '스프링당스 (Springdans)', 'No. 5 Springdans (Spring Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57fee97d-b8ad-3a89-a012-275ffc21fee5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b2fb536-5e97-39d9-b76b-6e6418279286', 6, NULL, '엘레지 (Elegie)', 'No. 6 Elegie (Elegy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b2fb536-5e97-39d9-b76b-6e6418279286'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f99723b-8817-3803-b822-c38c02dfcf5c', 7, NULL, '왈츠 (Vals)', 'No. 7 Vals (Waltz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f99723b-8817-3803-b822-c38c02dfcf5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebdb5419-8851-3cc2-93aa-9dc8b1a8f38f', 8, NULL, '카논 (Kanon)', 'No. 8 Kanon (Canon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 2권 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebdb5419-8851-3cc2-93aa-9dc8b1a8f38f'
);


-- Op. 39 6개의 로망스 Op. 39

UPDATE pieces piece
SET piece.title = '6개의 로망스 Op. 39', piece.title_en = 'Romances (Earlier and Later), Op. 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14332 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 14332 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '몬테 핀치오에서 (Fra Monte Pincio)', part.name_en = 'No. 1 Fra Monte Pincio (From Monte Pincio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14332 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:96be11c0-f57c-47de-91af-5f14fb8f48aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96be11c0-f57c-47de-91af-5f14fb8f48aa', 1, NULL, '몬테 핀치오에서 (Fra Monte Pincio)', 'No. 1 Fra Monte Pincio (From Monte Pincio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14332 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96be11c0-f57c-47de-91af-5f14fb8f48aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dulgt Kjærlighed', part.name_en = 'No. 2 Dulgt Kjærlighed (Hidden Love)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14332 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0ccaef77-c8ad-4d8e-b71a-b50faa11dad3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ccaef77-c8ad-4d8e-b71a-b50faa11dad3', 2, NULL, 'Dulgt Kjærlighed', 'No. 2 Dulgt Kjærlighed (Hidden Love)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14332 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ccaef77-c8ad-4d8e-b71a-b50faa11dad3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'I Liden højt deroppe', part.name_en = 'No. 3 I Liden højt deroppe (Upon a Grassy Hillside)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14332 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:82b46baf-b859-4c10-bc86-96ba9935bb4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82b46baf-b859-4c10-bc86-96ba9935bb4c', 3, NULL, 'I Liden højt deroppe', 'No. 3 I Liden højt deroppe (Upon a Grassy Hillside)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14332 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82b46baf-b859-4c10-bc86-96ba9935bb4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Millom Roser', part.name_en = 'No. 4 Millom Roser (Among Roses)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14332 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6a0dd5de-1018-4b7e-a6fe-4df49553f8ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a0dd5de-1018-4b7e-a6fe-4df49553f8ce', 4, NULL, 'Millom Roser', 'No. 4 Millom Roser (Among Roses)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14332 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a0dd5de-1018-4b7e-a6fe-4df49553f8ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 14845 AND linked.composer_id = 117),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ved en ung Hustrus Båre', part.name_en = 'No. 5 Ved en ung Hustrus Båre (At the Grave of a Young Wife)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14332 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:dc91e423-f521-4a67-a35d-5d6e3f73093f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 14845 AND linked.composer_id = 117), 'musicbrainz:dc91e423-f521-4a67-a35d-5d6e3f73093f', 5, NULL, 'Ved en ung Hustrus Båre', 'No. 5 Ved en ung Hustrus Båre (At the Grave of a Young Wife)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14332 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc91e423-f521-4a67-a35d-5d6e3f73093f'
);

UPDATE pieces piece
SET piece.title = '6개의 로망스 Op. 39 중 "Ved en ung Hustrus Båre"', piece.title_en = 'Romances (Earlier and Later), Op. 39: No. 5 Ved en ung Hustrus Båre (At the Grave of a Young Wife)', piece.editor_locked = 1
WHERE piece.id = 14845 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Hører jeg Sangen klinge', part.name_en = 'No. 6 Hører jeg Sangen klinge (Hearing a Song or Carol)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14332 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:169e61e6-c31e-484b-8d30-37cd897cd655' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:169e61e6-c31e-484b-8d30-37cd897cd655', 6, NULL, 'Hører jeg Sangen klinge', 'No. 6 Hører jeg Sangen klinge (Hearing a Song or Carol)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14332 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:169e61e6-c31e-484b-8d30-37cd897cd655'
);


-- Op. 40 <홀베르그 모음곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<홀베르그 모음곡>', 'Holberg Suite (From Holberg''s Time)', 'album', 'Op. 40', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<홀베르그 모음곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7554a660-ebc9-4972-96e5-8334da79c878'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7554a660-ebc9-4972-96e5-8334da79c878'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<홀베르그 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7554a660-ebc9-4972-96e5-8334da79c878'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4dfa31f-7a43-3f1b-a3fc-883d06d8108b', 1, 'I', '전주곡. Allegro vivace', 'I. Præludium. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<홀베르그 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4dfa31f-7a43-3f1b-a3fc-883d06d8108b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c826e46-c14a-3e3d-a7e0-bf153b626d3e', 2, 'II', '사라방드. Andante', 'II. Sarabande. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<홀베르그 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c826e46-c14a-3e3d-a7e0-bf153b626d3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50321c5d-032a-3f5f-b0f4-a6396bb7457d', 3, 'III', '가보트. Allegretto', 'III. Gavotte. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<홀베르그 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50321c5d-032a-3f5f-b0f4-a6396bb7457d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1898c18c-a817-34e6-9244-616a648a40e1', 4, 'IV', '아리아. Andante religioso', 'IV. Air. Andante religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<홀베르그 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1898c18c-a817-34e6-9244-616a648a40e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d7d788b-613a-3750-b4ec-9ad8c5a088e9', 5, 'V', '리고동. Allegro con brio', 'V. Rigaudon. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<홀베르그 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7d788b-613a-3750-b4ec-9ad8c5a088e9'
);


-- Op. 41 자작 가곡에 의한 피아노 소품 1권 Op. 41

UPDATE pieces piece
SET piece.title = '자작 가곡에 의한 피아노 소품 1권 Op. 41', piece.title_en = 'Piano Pieces after Original Songs, Book I, Op. 41',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '41',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13917 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 13917 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vuggesang', part.name_en = 'No. 1 Vuggesang (Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13917 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:1ddb0feb-8788-3835-a36c-33fc3c65b543' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ddb0feb-8788-3835-a36c-33fc3c65b543', 1, NULL, 'Vuggesang', 'No. 1 Vuggesang (Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13917 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ddb0feb-8788-3835-a36c-33fc3c65b543'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Liden Håkon', part.name_en = 'No. 2 Liden Håkon (Little Håkon)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13917 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:913f3364-08b4-34df-a167-82f23482880f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:913f3364-08b4-34df-a167-82f23482880f', 2, NULL, 'Liden Håkon', 'No. 2 Liden Håkon (Little Håkon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13917 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:913f3364-08b4-34df-a167-82f23482880f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '그대를 사랑해 (Jeg elsker dig)', part.name_en = 'No. 3 Jeg elsker dig (I Love Thee)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13917 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d92efc1f-5e5a-347f-b715-4e56e7f7aeb3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d92efc1f-5e5a-347f-b715-4e56e7f7aeb3', 3, NULL, '그대를 사랑해 (Jeg elsker dig)', 'No. 3 Jeg elsker dig (I Love Thee)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13917 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d92efc1f-5e5a-347f-b715-4e56e7f7aeb3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Hun er saa hvid', part.name_en = 'No. 4 Hun er saa hvid (She Is So White)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13917 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:060dc063-dad0-3168-b10e-ca71d192ce5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:060dc063-dad0-3168-b10e-ca71d192ce5c', 4, NULL, 'Hun er saa hvid', 'No. 4 Hun er saa hvid (She Is So White)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13917 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:060dc063-dad0-3168-b10e-ca71d192ce5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Prinsessen', part.name_en = 'No. 5 Prinsessen (The Princess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13917 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8f874a76-724a-3f97-aabb-d06b29929849' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f874a76-724a-3f97-aabb-d06b29929849', 5, NULL, 'Prinsessen', 'No. 5 Prinsessen (The Princess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13917 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f874a76-724a-3f97-aabb-d06b29929849'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Jeg giver mit digt til våren', part.name_en = 'No. 6 Jeg giver mit digt til våren (To Springtime)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13917 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fb3f5651-9402-36d9-acc8-864d40eea7b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb3f5651-9402-36d9-acc8-864d40eea7b9', 6, NULL, 'Jeg giver mit digt til våren', 'No. 6 Jeg giver mit digt til våren (To Springtime)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13917 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb3f5651-9402-36d9-acc8-864d40eea7b9'
);


-- Op. 42 멜로드라마 <베르글리오트>

UPDATE pieces piece
SET piece.title = '멜로드라마 <베르글리오트>', piece.title_en = 'Bergliot',
    piece.type = 'song', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15376 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 15376 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- Op. 43 서정 소곡집 3권 Op. 43

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 3권 Op. 43', 'Lyric Pieces, Book III, Op. 43', 'album', NULL, 'Op.', '43', 1886, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 3권 Op. 43'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3378f18f-d2c7-4f97-8e30-027f4fbead5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3378f18f-d2c7-4f97-8e30-027f4fbead5d'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 3권 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3378f18f-d2c7-4f97-8e30-027f4fbead5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5da47cc1-58d7-33d0-8c05-a3b7fab34018', 1, NULL, '나비 (Sommerfugl)', 'No. 1 Sommerfugl (Butterfly)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 3권 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5da47cc1-58d7-33d0-8c05-a3b7fab34018'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec0360d4-ca95-37af-bcb3-598b21add0ca', 2, NULL, '외로운 나그네 (Ensom vandrer)', 'No. 2 Ensom vandrer (Solitary Traveller)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 3권 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec0360d4-ca95-37af-bcb3-598b21add0ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c0fae18-33d0-3946-b923-eac4b193d9fc', 3, NULL, '고향에서 (I Hjemmet)', 'No. 3 I Hjemmet (In My Native Country)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 3권 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c0fae18-33d0-3946-b923-eac4b193d9fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e143678-8970-3cbc-9378-0779f654a714', 4, NULL, '작은 새 (Liden Fugl)', 'No. 4 Liden Fugl (Little Bird)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 3권 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e143678-8970-3cbc-9378-0779f654a714'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0702e13-1a32-332b-af98-7a533247e786', 5, NULL, '에로티크 (Erotik)', 'No. 5 Erotik (Erotikon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 3권 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0702e13-1a32-332b-af98-7a533247e786'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1fd966e-03e9-3858-a1ff-7031d9ba81ad', 6, NULL, '봄에게 (Til Foråret)', 'No. 6 Til Foråret (To Spring)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 3권 Op. 43' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1fd966e-03e9-3858-a1ff-7031d9ba81ad'
);


-- Op. 44 가곡집 <산과 피오르의 추억>

UPDATE pieces piece
SET piece.title = '가곡집 <산과 피오르의 추억>', piece.title_en = 'Reminiscences from Mountain and Fjord, Op. 44',
    piece.type = 'album', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15202 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 15202 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prolog', part.name_en = 'No. 1 Prolog (Prologue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15202 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-op44:1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-op44:1', 1, NULL, 'Prolog', 'No. 1 Prolog (Prologue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15202 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-op44:1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Johanne', part.name_en = 'No. 2 Johanne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15202 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-op44:2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-op44:2', 2, NULL, 'Johanne', 'No. 2 Johanne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15202 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-op44:2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ragnhild', part.name_en = 'No. 3 Ragnhild',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15202 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-op44:3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-op44:3', 3, NULL, 'Ragnhild', 'No. 3 Ragnhild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15202 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-op44:3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ingebjørg', part.name_en = 'No. 4 Ingebjørg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15202 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-op44:4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-op44:4', 4, NULL, 'Ingebjørg', 'No. 4 Ingebjørg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15202 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-op44:4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Ragna', part.name_en = 'No. 5 Ragna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15202 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-op44:5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-op44:5', 5, NULL, 'Ragna', 'No. 5 Ragna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15202 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-op44:5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Epilog', part.name_en = 'No. 6 Epilog (Epilogue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15202 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-op44:6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-op44:6', 6, NULL, 'Epilog', 'No. 6 Epilog (Epilogue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15202 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-op44:6'
);


-- Op. 45 바이올린 소나타 3번 C단조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 3번 C단조', piece.title_en = 'Violin Sonata No. 3 in C minor',
    piece.type = 'album', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13849 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 13849 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto ed appassionato', part.name_en = 'I. Allegro molto ed appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13849 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4c3a9f0f-9931-4f23-82e8-46e90d7a3daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c3a9f0f-9931-4f23-82e8-46e90d7a3daa', 1, 'I', 'Allegro molto ed appassionato', 'I. Allegro molto ed appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13849 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c3a9f0f-9931-4f23-82e8-46e90d7a3daa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto espressivo alla romanza', part.name_en = 'II. Allegretto espressivo alla romanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13849 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a4486fa9-6e97-4819-bc9d-518b1661866e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4486fa9-6e97-4819-bc9d-518b1661866e', 2, 'II', 'Allegretto espressivo alla romanza', 'II. Allegretto espressivo alla romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13849 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4486fa9-6e97-4819-bc9d-518b1661866e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro animato', part.name_en = 'III. Allegro animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13849 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:7d054f56-e829-4736-8709-3dd7e666e858' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d054f56-e829-4736-8709-3dd7e666e858', 3, 'III', 'Allegro animato', 'III. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13849 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d054f56-e829-4736-8709-3dd7e666e858'
);


-- Op. 46 <페르 귄트> 모음곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<페르 귄트> 모음곡 1번', 'Peer Gynt Suite No. 1', 'album', 'Op. 46', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<페르 귄트> 모음곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5d9aa32-e0b0-33ac-aa1f-c4860ffb01bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5d9aa32-e0b0-33ac-aa1f-c4860ffb01bf'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5d9aa32-e0b0-33ac-aa1f-c4860ffb01bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3093f0ce-0b78-378a-9bc8-e4f5d7ed23aa', 1, 'I', '아침 기분 (Morgenstemning)', 'I. Morning Mood (Morgenstemning)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3093f0ce-0b78-378a-9bc8-e4f5d7ed23aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cbadb22-52d3-39a6-ac34-ac4493ef0b19', 2, 'II', '오세의 죽음 (Åses død)', 'II. The Death of Åse (Åses død)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cbadb22-52d3-39a6-ac34-ac4493ef0b19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64ff64dd-c580-3d70-b3dc-b58fd371923a', 3, 'III', '아니트라의 춤 (Anitras dans)', 'III. Anitra''s Dance (Anitras dans)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64ff64dd-c580-3d70-b3dc-b58fd371923a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6aabde58-948e-3120-a9a3-f43257f04b81', 4, 'IV', '산속 마왕의 궁전에서 (I Dovregubbens hall)', 'IV. In the Hall of the Mountain King (I Dovregubbens hall)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6aabde58-948e-3120-a9a3-f43257f04b81'
);


-- Op. 47 서정 소곡집 4권 Op. 47

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 4권 Op. 47', 'Lyric Pieces, Book IV, Op. 47', 'album', NULL, 'Op.', '47', 1888, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 4권 Op. 47'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56161c3b-977f-4b69-8be7-0f2b2476dc87'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56161c3b-977f-4b69-8be7-0f2b2476dc87'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 4권 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56161c3b-977f-4b69-8be7-0f2b2476dc87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02e09121-98d8-3103-b245-a85f01b29c89', 1, NULL, '왈츠 즉흥곡 (Valse-Impromptu)', 'No. 1 Valse-Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 4권 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02e09121-98d8-3103-b245-a85f01b29c89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce061d13-efa4-3900-af14-074ece0925b3', 2, NULL, '앨범의 잎 (Albumblad)', 'No. 2 Albumblad (Album Leaf)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 4권 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce061d13-efa4-3900-af14-074ece0925b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad51aa9e-28c1-3ab6-8c99-b67b7546ea42', 3, NULL, '선율 (Melodie)', 'No. 3 Melodie (Melody)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 4권 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad51aa9e-28c1-3ab6-8c99-b67b7546ea42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0e297d2-a477-328b-89f0-f0cf4b6986c5', 4, NULL, '할링 (Halling)', 'No. 4 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 4권 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0e297d2-a477-328b-89f0-f0cf4b6986c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66e7d023-3d4b-3442-9d0d-e635cb5032ce', 5, NULL, '멜랑콜리 (Melankoli)', 'No. 5 Melankoli (Melancholy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 4권 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66e7d023-3d4b-3442-9d0d-e635cb5032ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:735eabcc-d411-3a9d-a955-dcab7fb1064e', 6, NULL, '스프링당스 (Springdans)', 'No. 6 Springdans (Spring Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 4권 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:735eabcc-d411-3a9d-a955-dcab7fb1064e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60573883-21a3-3082-b6c8-4972a0183509', 7, NULL, '엘레지 (Elegie)', 'No. 7 Elegie (Elegy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 4권 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60573883-21a3-3082-b6c8-4972a0183509'
);


-- Op. 48 6개의 가곡 Op. 48

UPDATE pieces piece
SET piece.title = '6개의 가곡 Op. 48', piece.title_en = '6 Songs, Op. 48',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '48',
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13803 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 13803 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gruß', part.name_en = 'No. 1 Gruß (Greeting)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13803 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:7b4fb43c-44a8-4516-97ea-c8da39ce628d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b4fb43c-44a8-4516-97ea-c8da39ce628d', 1, NULL, 'Gruß', 'No. 1 Gruß (Greeting)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13803 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b4fb43c-44a8-4516-97ea-c8da39ce628d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dereinst, Gedanke mein', part.name_en = 'No. 2 Dereinst, Gedanke mein (One Day, O Heart of Mine)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13803 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6946f691-0877-4342-8149-f26533bd5d2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6946f691-0877-4342-8149-f26533bd5d2a', 2, NULL, 'Dereinst, Gedanke mein', 'No. 2 Dereinst, Gedanke mein (One Day, O Heart of Mine)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13803 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6946f691-0877-4342-8149-f26533bd5d2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lauf der Welt', part.name_en = 'No. 3 Lauf der Welt (The Way of the World)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13803 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4bef75a9-5dc9-42bd-ac70-6b099afb411c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bef75a9-5dc9-42bd-ac70-6b099afb411c', 3, NULL, 'Lauf der Welt', 'No. 3 Lauf der Welt (The Way of the World)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13803 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bef75a9-5dc9-42bd-ac70-6b099afb411c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Die verschwiegene Nachtigall', part.name_en = 'No. 4 Die verschwiegene Nachtigall (The Nightingale''s Secret)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13803 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:70773460-e51c-42ec-a5d5-85d2d7de980f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70773460-e51c-42ec-a5d5-85d2d7de980f', 4, NULL, 'Die verschwiegene Nachtigall', 'No. 4 Die verschwiegene Nachtigall (The Nightingale''s Secret)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13803 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70773460-e51c-42ec-a5d5-85d2d7de980f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '장미의 계절에 (Zur Rosenzeit)', part.name_en = 'No. 5 Zur Rosenzeit (The Time of Roses)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13803 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a1d39f72-71e0-44d0-9aac-ca6b9110abda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1d39f72-71e0-44d0-9aac-ca6b9110abda', 5, NULL, '장미의 계절에 (Zur Rosenzeit)', 'No. 5 Zur Rosenzeit (The Time of Roses)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13803 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1d39f72-71e0-44d0-9aac-ca6b9110abda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '꿈 (Ein Traum)', part.name_en = 'No. 6 Ein Traum (A Dream)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13803 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8630eb2b-f98c-465e-8f73-b032068e5a94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8630eb2b-f98c-465e-8f73-b032068e5a94', 6, NULL, '꿈 (Ein Traum)', 'No. 6 Ein Traum (A Dream)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13803 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8630eb2b-f98c-465e-8f73-b032068e5a94'
);


-- Op. 49 드라크만 시에 의한 6개의 가곡

UPDATE pieces piece
SET piece.title = '드라크만 시에 의한 6개의 가곡', piece.title_en = '6 Poems by Holger Drachmann, Op. 49',
    piece.type = 'album', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15245 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 15245 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Så du Knøsen, som strøg forbi', part.name_en = 'No. 1 Så du Knøsen, som strøg forbi (Tell Me Now, Did You See the Lad)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15245 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:db7a467b-0739-411d-b340-b4d6260ee9fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db7a467b-0739-411d-b340-b4d6260ee9fc', 1, NULL, 'Så du Knøsen, som strøg forbi', 'No. 1 Så du Knøsen, som strøg forbi (Tell Me Now, Did You See the Lad)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15245 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db7a467b-0739-411d-b340-b4d6260ee9fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vug, o Vove', part.name_en = 'No. 2 Vug, o Vove (Rocking, Rocking on Gentle Waves)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15245 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:64fbdb99-3a20-416d-9129-d01fb83d97a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64fbdb99-3a20-416d-9129-d01fb83d97a5', 2, NULL, 'Vug, o Vove', 'No. 2 Vug, o Vove (Rocking, Rocking on Gentle Waves)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15245 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64fbdb99-3a20-416d-9129-d01fb83d97a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Vær hilset, i Damer', part.name_en = 'No. 3 Vær hilset, i Damer (Kind Greetings, Fair Ladies)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15245 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:bd43a028-c865-454a-a63e-e935bc8097a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd43a028-c865-454a-a63e-e935bc8097a1', 3, NULL, 'Vær hilset, i Damer', 'No. 3 Vær hilset, i Damer (Kind Greetings, Fair Ladies)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15245 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd43a028-c865-454a-a63e-e935bc8097a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Nu er Aftnen lys og lang', part.name_en = 'No. 4 Nu er Aftnen lys og lang (Now Is Evening Light and Long)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15245 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b285d51f-1351-465c-8d68-477ff1f63043' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b285d51f-1351-465c-8d68-477ff1f63043', 4, NULL, 'Nu er Aftnen lys og lang', 'No. 4 Nu er Aftnen lys og lang (Now Is Evening Light and Long)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15245 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b285d51f-1351-465c-8d68-477ff1f63043'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Jule-Sne', part.name_en = 'No. 5 Jule-Sne (Christmas Snow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15245 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fb91c2b1-e3df-4c1e-b7f1-2ef3ec815ff0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb91c2b1-e3df-4c1e-b7f1-2ef3ec815ff0', 5, NULL, 'Jule-Sne', 'No. 5 Jule-Sne (Christmas Snow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15245 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb91c2b1-e3df-4c1e-b7f1-2ef3ec815ff0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Forårsregn', part.name_en = 'No. 6 Forårsregn (Spring Showers)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15245 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:35b187a1-9694-406b-9aff-1394cbc22b65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35b187a1-9694-406b-9aff-1394cbc22b65', 6, NULL, 'Forårsregn', 'No. 6 Forårsregn (Spring Showers)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15245 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35b187a1-9694-406b-9aff-1394cbc22b65'
);


-- Op. 50 <올라브 트뤼그바손>의 장면

UPDATE pieces piece
SET piece.title = '<올라브 트뤼그바손>의 장면', piece.title_en = 'Scenes from Olav Trygvason',
    piece.type = 'album', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15627 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 15627 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Skjult i de mange manende navne / I, som op af Urdarbrønden', part.name_en = 'No. 1 Scene I: »Skjult i de mange manende navne« / »I, som op af Urdarbrønden«',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15627 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:12403877-28ac-4bdc-86e9-f8204d405404' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12403877-28ac-4bdc-86e9-f8204d405404', 1, NULL, 'Skjult i de mange manende navne / I, som op af Urdarbrønden', 'No. 1 Scene I: »Skjult i de mange manende navne« / »I, som op af Urdarbrønden«', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15627 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12403877-28ac-4bdc-86e9-f8204d405404'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ej er det nok / Tak, at I talte', part.name_en = 'No. 2 Scene II: »Ej er det nok« / »Tak, at I talte«',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15627 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2dabacc3-c8e3-4ee1-9a62-c6466377bfc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dabacc3-c8e3-4ee1-9a62-c6466377bfc9', 2, NULL, 'Ej er det nok / Tak, at I talte', 'No. 2 Scene II: »Ej er det nok« / »Tak, at I talte«', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15627 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dabacc3-c8e3-4ee1-9a62-c6466377bfc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Giv alle guder gammens og glædes-skål / Alfer og vætter / Evige asatro', part.name_en = 'No. 3 Scene III: »Giv alle guder gammens og glædes-skål« / »Alfer og vætter« / »Evige asatro«',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15627 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fd0fe1ac-3a0d-4872-82d5-3ee759fab07f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd0fe1ac-3a0d-4872-82d5-3ee759fab07f', 3, NULL, 'Giv alle guder gammens og glædes-skål / Alfer og vætter / Evige asatro', 'No. 3 Scene III: »Giv alle guder gammens og glædes-skål« / »Alfer og vætter« / »Evige asatro«', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15627 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd0fe1ac-3a0d-4872-82d5-3ee759fab07f'
);


-- Op. 51 옛 노르웨이 선율과 변주곡

UPDATE pieces piece
SET piece.title = '옛 노르웨이 선율과 변주곡', piece.title_en = 'Old Norwegian Melody with Variations',
    piece.type = 'album', piece.opus_number = 'Op. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13736 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 13736 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Poco tranquillo – 주제. Andantino espressivo', part.name_en = 'Theme: Poco tranquillo – Andantino espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:cf485a5a-9623-3db9-861d-3678e82822b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf485a5a-9623-3db9-861d-3678e82822b2', 1, NULL, 'Poco tranquillo – 주제. Andantino espressivo', 'Theme: Poco tranquillo – Andantino espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf485a5a-9623-3db9-861d-3678e82822b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Poco allegro, ma tranquillo', part.name_en = 'Variation 1: Poco allegro, ma tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:46542714-4c3b-4d71-ba02-33cacd338a42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46542714-4c3b-4d71-ba02-33cacd338a42', 2, NULL, 'Poco allegro, ma tranquillo', 'Variation 1: Poco allegro, ma tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46542714-4c3b-4d71-ba02-33cacd338a42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Energico', part.name_en = 'Variation 2: Energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:37ad9356-f462-4948-8cda-eb2afa449024' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37ad9356-f462-4948-8cda-eb2afa449024', 3, NULL, 'Energico', 'Variation 2: Energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37ad9356-f462-4948-8cda-eb2afa449024'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro leggiero', part.name_en = 'Variation 3: Allegro leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:aec53cc3-bb59-4582-94fa-3692cd7a73b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aec53cc3-bb59-4582-94fa-3692cd7a73b1', 4, NULL, 'Allegro leggiero', 'Variation 3: Allegro leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aec53cc3-bb59-4582-94fa-3692cd7a73b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Poco andante', part.name_en = 'Variation 4: Poco andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b11bb65a-193b-4108-86b7-80d61fd1e498' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b11bb65a-193b-4108-86b7-80d61fd1e498', 5, NULL, 'Poco andante', 'Variation 4: Poco andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b11bb65a-193b-4108-86b7-80d61fd1e498'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Maestoso', part.name_en = 'Variation 5: Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:15b5482d-ff38-41f3-b5e2-cdc3ae7f6a39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15b5482d-ff38-41f3-b5e2-cdc3ae7f6a39', 6, NULL, 'Maestoso', 'Variation 5: Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b5482d-ff38-41f3-b5e2-cdc3ae7f6a39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Allegro scherzando e leggiero', part.name_en = 'Variation 6: Allegro scherzando e leggiero',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:22c1ac5b-ac94-48cc-a529-721c5fb0b003' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22c1ac5b-ac94-48cc-a529-721c5fb0b003', 7, NULL, 'Allegro scherzando e leggiero', 'Variation 6: Allegro scherzando e leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22c1ac5b-ac94-48cc-a529-721c5fb0b003'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Variation 7: Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:1718e064-58d8-4725-9dff-ea690a956ea5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1718e064-58d8-4725-9dff-ea690a956ea5', 8, NULL, 'Andante', 'Variation 7: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1718e064-58d8-4725-9dff-ea690a956ea5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Andante molto tranquillo', part.name_en = 'Variation 8: Andante molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:24e2523d-4ef2-4746-81f6-0f549e7b9ae6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24e2523d-4ef2-4746-81f6-0f549e7b9ae6', 9, NULL, 'Andante molto tranquillo', 'Variation 8: Andante molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24e2523d-4ef2-4746-81f6-0f549e7b9ae6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Presto', part.name_en = 'Variation 9: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b504b875-9697-45ec-bc8e-743b2be5026b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b504b875-9697-45ec-bc8e-743b2be5026b', 10, NULL, 'Presto', 'Variation 9: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b504b875-9697-45ec-bc8e-743b2be5026b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Tempo di menuetto', part.name_en = 'Variation 10: Tempo di menuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ebabaf6e-325f-4dab-940b-74fdf044e450' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebabaf6e-325f-4dab-940b-74fdf044e450', 11, NULL, 'Tempo di menuetto', 'Variation 10: Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebabaf6e-325f-4dab-940b-74fdf044e450'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Allegro marcato', part.name_en = 'Variation 11: Allegro marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:98bd8aa5-25e1-4382-9dc6-91e25373ee6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98bd8aa5-25e1-4382-9dc6-91e25373ee6a', 12, NULL, 'Allegro marcato', 'Variation 11: Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98bd8aa5-25e1-4382-9dc6-91e25373ee6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Tempo di valse', part.name_en = 'Variation 12: Tempo di valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e4b776e7-b272-4d27-b272-95886f9f514b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4b776e7-b272-4d27-b272-95886f9f514b', 13, NULL, 'Tempo di valse', 'Variation 12: Tempo di valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b776e7-b272-4d27-b272-95886f9f514b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Adagio molto espressivo', part.name_en = 'Variation 13: Adagio molto espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0e233fb0-6e4f-4ee1-ab30-4a8f12e66a06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e233fb0-6e4f-4ee1-ab30-4a8f12e66a06', 14, NULL, 'Adagio molto espressivo', 'Variation 13: Adagio molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e233fb0-6e4f-4ee1-ab30-4a8f12e66a06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '피날레. Allegro molto marcato – Pomposo – Prestissimo – Andante molto tranquillo', part.name_en = 'Variation 14: Finale. Allegro molto marcato – Pomposo – Prestissimo – Andante molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13736 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:eef53058-9497-30d8-910b-289699f3f2e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eef53058-9497-30d8-910b-289699f3f2e7', 15, NULL, '피날레. Allegro molto marcato – Pomposo – Prestissimo – Andante molto tranquillo', 'Variation 14: Finale. Allegro molto marcato – Pomposo – Prestissimo – Andante molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13736 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eef53058-9497-30d8-910b-289699f3f2e7'
);


-- Op. 52 자작 가곡에 의한 피아노 소품 2권 Op. 52

UPDATE pieces piece
SET piece.title = '자작 가곡에 의한 피아노 소품 2권 Op. 52', piece.title_en = 'Piano Pieces after Original Songs, Book II, Op. 52',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '52',
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14934 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 14934 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Modersorg', part.name_en = 'No. 1 Modersorg (A Mother''s Grief)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14934 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c3147f7b-9b1e-46ff-bdf6-7ce2013cb3ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3147f7b-9b1e-46ff-bdf6-7ce2013cb3ba', 1, NULL, 'Modersorg', 'No. 1 Modersorg (A Mother''s Grief)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14934 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3147f7b-9b1e-46ff-bdf6-7ce2013cb3ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '첫 만남 (Det første møte)', part.name_en = 'No. 2 Det første møte (The First Meeting)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14934 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:32010f40-ae7d-41e9-add1-326595057953' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32010f40-ae7d-41e9-add1-326595057953', 2, NULL, '첫 만남 (Det første møte)', 'No. 2 Det første møte (The First Meeting)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14934 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32010f40-ae7d-41e9-add1-326595057953'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Du fatter ej Bølgernes evige Gang', part.name_en = 'No. 3 Du fatter ej Bølgernes evige Gang (The Poet''s Heart)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14934 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:34ac8b3f-e2cc-4078-a638-9e8c2bacf5f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34ac8b3f-e2cc-4078-a638-9e8c2bacf5f4', 3, NULL, 'Du fatter ej Bølgernes evige Gang', 'No. 3 Du fatter ej Bølgernes evige Gang (The Poet''s Heart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14934 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34ac8b3f-e2cc-4078-a638-9e8c2bacf5f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '솔베이그의 노래 (Solveigs sang)', part.name_en = 'No. 4 Solveigs sang (Solveig''s Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14934 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:36f1bc0a-ad4c-47c4-84a4-6f67b6a2da70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36f1bc0a-ad4c-47c4-84a4-6f67b6a2da70', 4, NULL, '솔베이그의 노래 (Solveigs sang)', 'No. 4 Solveigs sang (Solveig''s Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14934 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36f1bc0a-ad4c-47c4-84a4-6f67b6a2da70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Kjærlighed', part.name_en = 'No. 5 Kjærlighed (Love)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14934 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e84f08a6-2181-45b3-bba3-8076dd444794' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e84f08a6-2181-45b3-bba3-8076dd444794', 5, NULL, 'Kjærlighed', 'No. 5 Kjærlighed (Love)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14934 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e84f08a6-2181-45b3-bba3-8076dd444794'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gamle mor', part.name_en = 'No. 6 Gamle mor (The Old Mother)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14934 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5c3a2d57-106d-44df-b254-6ae758ba1c4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c3a2d57-106d-44df-b254-6ae758ba1c4b', 6, NULL, 'Gamle mor', 'No. 6 Gamle mor (The Old Mother)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14934 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c3a2d57-106d-44df-b254-6ae758ba1c4b'
);


-- Op. 53 현악 합주를 위한 2개의 선율

UPDATE pieces piece
SET piece.title = '현악 합주를 위한 2개의 선율', piece.title_en = '2 Melodies for String Orchestra after Original Songs, Op. 53',
    piece.type = 'album', piece.opus_number = 'Op. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13750 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 13750 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '노르웨이 선율 (Norsk)', part.name_en = 'No. 1 Norsk (Norwegian)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13750 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f2873ed7-c6d7-47cc-b19b-5cb8b094de25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2873ed7-c6d7-47cc-b19b-5cb8b094de25', 1, NULL, '노르웨이 선율 (Norsk)', 'No. 1 Norsk (Norwegian)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13750 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2873ed7-c6d7-47cc-b19b-5cb8b094de25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '첫 만남 (Det første møte)', part.name_en = 'No. 2 Det første møte (The First Meeting)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13750 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0ee21333-0777-4d5d-8edc-465763367c42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee21333-0777-4d5d-8edc-465763367c42', 2, NULL, '첫 만남 (Det første møte)', 'No. 2 Det første møte (The First Meeting)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13750 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee21333-0777-4d5d-8edc-465763367c42'
);


-- Op. 54 서정 소곡집 5권 Op. 54

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 5권 Op. 54', 'Lyric Pieces, Book V, Op. 54', 'album', NULL, 'Op.', '54', 1891, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 5권 Op. 54'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47264140-c918-4b6a-96b0-e91f55a56568'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47264140-c918-4b6a-96b0-e91f55a56568'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 5권 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47264140-c918-4b6a-96b0-e91f55a56568'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d65754d-84fd-3757-99ff-6d9d393b7237', 1, NULL, '양치기 소년 (Gjætergut)', 'No. 1 Gjætergut (Shepherd''s Boy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 5권 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d65754d-84fd-3757-99ff-6d9d393b7237'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a8dc0bd-6972-3f5d-b4aa-b52d8fe13ba9', 2, NULL, '노르웨이 행진곡 (Gangar)', 'No. 2 Gangar (Norwegian March)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 5권 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a8dc0bd-6972-3f5d-b4aa-b52d8fe13ba9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f23bb9a-2531-3ba4-a99e-70305990d5be', 3, NULL, '난쟁이의 행진 (Troldtog)', 'No. 3 Troldtog (March of the Dwarfs)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 5권 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f23bb9a-2531-3ba4-a99e-70305990d5be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 14870 AND linked.composer_id = 117), 'musicbrainz:cd0500ff-5b10-34b1-a4bc-f7cde1e1b3ce', 4, NULL, '녹턴 (Notturno)', 'No. 4 Notturno (Nocturne)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 5권 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd0500ff-5b10-34b1-a4bc-f7cde1e1b3ce'
);

UPDATE pieces piece
SET piece.title = '서정 소곡집 5권 Op. 54 중 "녹턴 (Notturno)"', piece.title_en = 'Lyric Pieces, Book V, Op. 54: No. 4 Notturno (Nocturne)', piece.editor_locked = 1
WHERE piece.id = 14870 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30cef28e-c014-3092-ae80-c8ccbb6f81e9', 5, NULL, '스케르초 (Scherzo)', 'No. 5 Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 5권 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30cef28e-c014-3092-ae80-c8ccbb6f81e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83712a5a-5826-3498-89f1-e50fbdfa7ea3', 6, NULL, '종소리 (Klokkeklang)', 'No. 6 Klokkeklang (Bell Ringing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 5권 Op. 54' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83712a5a-5826-3498-89f1-e50fbdfa7ea3'
);


-- Op. 54 서정 모음곡

UPDATE pieces piece
SET piece.title = '서정 모음곡', piece.title_en = 'Lyric Suite',
    piece.type = 'album', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13776 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 13776 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '양치기 소년 (Gjætergut)', part.name_en = 'I. Shepherd''s Boy (Gjætergut)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13776 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:082d672d-a8d2-334c-b515-8d88150d36e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:082d672d-a8d2-334c-b515-8d88150d36e9', 1, 'I', '양치기 소년 (Gjætergut)', 'I. Shepherd''s Boy (Gjætergut)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13776 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:082d672d-a8d2-334c-b515-8d88150d36e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '노르웨이 행진곡 (Gangar)', part.name_en = 'II. Norwegian March (Gangar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13776 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d0c18f28-6f46-3c9d-bbcc-e752b6d1f3ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0c18f28-6f46-3c9d-bbcc-e752b6d1f3ae', 2, 'II', '노르웨이 행진곡 (Gangar)', 'II. Norwegian March (Gangar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13776 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c18f28-6f46-3c9d-bbcc-e752b6d1f3ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '녹턴 (Notturno)', part.name_en = 'III. Nocturne (Notturno)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13776 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:945399d9-fdcf-302e-b5af-5798ee31d54d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:945399d9-fdcf-302e-b5af-5798ee31d54d', 3, 'III', '녹턴 (Notturno)', 'III. Nocturne (Notturno)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13776 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:945399d9-fdcf-302e-b5af-5798ee31d54d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '난쟁이의 행진 (Troldtog)', part.name_en = 'IV. March of the Dwarfs (Troldtog)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13776 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b91fdf89-f6a7-316c-8ed9-0392548623d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b91fdf89-f6a7-316c-8ed9-0392548623d6', 4, 'IV', '난쟁이의 행진 (Troldtog)', 'IV. March of the Dwarfs (Troldtog)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13776 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b91fdf89-f6a7-316c-8ed9-0392548623d6'
);


-- Op. 55 <페르 귄트> 모음곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<페르 귄트> 모음곡 2번', 'Peer Gynt Suite No. 2', 'album', 'Op. 55', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<페르 귄트> 모음곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46001164-7168-3b74-bc7f-9cc8b77b51d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46001164-7168-3b74-bc7f-9cc8b77b51d4'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46001164-7168-3b74-bc7f-9cc8b77b51d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e87213be-4ad1-3542-a169-427f26ba9611', 1, 'I', '신부의 약탈, 잉그리드의 탄식 (Bruderovet. Ingrids klage)', 'I. The Abduction of the Bride. Ingrid''s Lament (Bruderovet. Ingrids klage)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e87213be-4ad1-3542-a169-427f26ba9611'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:772e25e2-209b-3edb-9426-10f38750c9cd', 2, 'II', '아라비아의 춤 (Arabisk dans)', 'II. Arabian Dance (Arabisk dans)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:772e25e2-209b-3edb-9426-10f38750c9cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4154671c-f004-32af-be62-52c6b2b9f18f', 3, 'III', '페르 귄트의 귀향 (Peer Gynts hjemfart)', 'III. Peer Gynt''s Homecoming (Peer Gynts hjemfart)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4154671c-f004-32af-be62-52c6b2b9f18f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7d54460-6466-3fca-8f32-6b52a358ea95', 4, 'IV', '솔베이그의 노래 (Solveigs sang)', 'IV. Solveig''s Song (Solveigs sang)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<페르 귄트> 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7d54460-6466-3fca-8f32-6b52a358ea95'
);


-- Op. 56 <시구르드 요르살파르> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<시구르드 요르살파르> 모음곡', 'Sigurd Jorsalfar Suite (3 Orchestral Pieces)', 'album', 'Op. 56', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<시구르드 요르살파르> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4df9d41-8e9b-4870-8bad-0684e5f1439f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4df9d41-8e9b-4870-8bad-0684e5f1439f'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<시구르드 요르살파르> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4df9d41-8e9b-4870-8bad-0684e5f1439f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3a043d4-143e-3f03-b202-a26ad4271c1d', 1, 'I', '전주곡: 겨루기에서 (Ved Mannjevningen)', 'I. Prelude: At the Matching Game (Ved Mannjevningen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<시구르드 요르살파르> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3a043d4-143e-3f03-b202-a26ad4271c1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5084a89f-48c0-4344-953a-e5bc0fdc98d2', 2, 'II', '간주곡: 보르힐드의 꿈 (Borghilds Drøm)', 'II. Intermezzo: Borghild''s Dream (Borghilds Drøm)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<시구르드 요르살파르> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5084a89f-48c0-4344-953a-e5bc0fdc98d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7512d85-46d9-3555-87d6-f1b0925a907f', 3, 'III', '충성 행진곡 (Hyldningsmarsch)', 'III. Homage March (Hyldningsmarsch)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '<시구르드 요르살파르> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7512d85-46d9-3555-87d6-f1b0925a907f'
);


-- Op. 57 서정 소곡집 6권 Op. 57

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 6권 Op. 57', 'Lyric Pieces, Book VI, Op. 57', 'album', NULL, 'Op.', '57', 1893, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 6권 Op. 57'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f52a28bf-0cb3-4e92-8ca5-d6ac81cd93f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f52a28bf-0cb3-4e92-8ca5-d6ac81cd93f5'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 6권 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f52a28bf-0cb3-4e92-8ca5-d6ac81cd93f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de4909c6-ee83-3d78-80cd-790c6ad09a44', 1, NULL, '지나간 날들 (Svundne Dage)', 'No. 1 Svundne Dage (Vanished Days)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 6권 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de4909c6-ee83-3d78-80cd-790c6ad09a44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deedcb5f-3a62-38cb-b414-7758438c3a81', 2, NULL, '가데 (Gade)', 'No. 2 Gade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 6권 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deedcb5f-3a62-38cb-b414-7758438c3a81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33edb8fc-ffd4-3b35-b77a-1d5ca6fd579a', 3, NULL, '환상 (Illusion)', 'No. 3 Illusion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 6권 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33edb8fc-ffd4-3b35-b77a-1d5ca6fd579a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e12d29d4-816d-38d4-b407-df90f05bce27', 4, NULL, '비밀 (Hemmelighed)', 'No. 4 Hemmelighed (Secret)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 6권 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e12d29d4-816d-38d4-b407-df90f05bce27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7b0ff01-f991-30fe-a888-50a38a493b4d', 5, NULL, '그녀는 춤춘다 (Hun danser)', 'No. 5 Hun danser (She Dances)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 6권 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7b0ff01-f991-30fe-a888-50a38a493b4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3417b33b-bc37-3eed-85e2-c8ae7ec8ee08', 6, NULL, '향수 (Hjemve)', 'No. 6 Hjemve (Homesickness)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 6권 Op. 57' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3417b33b-bc37-3eed-85e2-c8ae7ec8ee08'
);


-- Op. 58 가곡집 <노르웨이>

UPDATE pieces piece
SET piece.title = '가곡집 <노르웨이>', piece.title_en = 'Norway, Op. 58',
    piece.type = 'album', piece.opus_number = 'Op. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15037 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 15037 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hjemkomst', part.name_en = 'No. 1 Hjemkomst (Homeward)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15037 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8d43f83e-d266-4dcb-858d-e6cdb58ec19e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d43f83e-d266-4dcb-858d-e6cdb58ec19e', 1, NULL, 'Hjemkomst', 'No. 1 Hjemkomst (Homeward)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15037 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d43f83e-d266-4dcb-858d-e6cdb58ec19e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Til Norge', part.name_en = 'No. 2 Til Norge (To the Motherland)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15037 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:09d48490-295c-48cc-8a0d-ad3b9c85cf10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09d48490-295c-48cc-8a0d-ad3b9c85cf10', 2, NULL, 'Til Norge', 'No. 2 Til Norge (To the Motherland)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15037 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09d48490-295c-48cc-8a0d-ad3b9c85cf10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Henrik Wergeland', part.name_en = 'No. 3 Henrik Wergeland',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15037 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:420852d7-5e1c-40c8-8538-d12d3c3c4765' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:420852d7-5e1c-40c8-8538-d12d3c3c4765', 3, NULL, 'Henrik Wergeland', 'No. 3 Henrik Wergeland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15037 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:420852d7-5e1c-40c8-8538-d12d3c3c4765'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Turisten', part.name_en = 'No. 4 Turisten (The Shepherdess)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15037 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a7cb990b-6263-47ed-861d-9d1078a38f81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7cb990b-6263-47ed-861d-9d1078a38f81', 4, NULL, 'Turisten', 'No. 4 Turisten (The Shepherdess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15037 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7cb990b-6263-47ed-861d-9d1078a38f81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Udvandreren', part.name_en = 'No. 5 Udvandreren (The Emigrant)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15037 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fb007e9a-e083-41db-bf4f-1d231f058a62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb007e9a-e083-41db-bf4f-1d231f058a62', 5, NULL, 'Udvandreren', 'No. 5 Udvandreren (The Emigrant)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15037 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb007e9a-e083-41db-bf4f-1d231f058a62'
);


-- Op. 59 가곡집 <비가풍의 시>

UPDATE pieces piece
SET piece.title = '가곡집 <비가풍의 시>', piece.title_en = 'Elegiac Poems, Op. 59',
    piece.type = 'album', piece.opus_number = 'Op. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14745 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 14745 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Når jeg vil dø', part.name_en = 'No. 1 Når jeg vil dø (Autumn''s Farewell)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14745 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:45a58586-1982-4ae9-bc00-cfd4edcfd9fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45a58586-1982-4ae9-bc00-cfd4edcfd9fd', 1, NULL, 'Når jeg vil dø', 'No. 1 Når jeg vil dø (Autumn''s Farewell)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14745 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45a58586-1982-4ae9-bc00-cfd4edcfd9fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'På Norges nøgne fjelde', part.name_en = 'No. 2 På Norges nøgne fjelde (The Pine Tree)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14745 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:92b7d83b-1029-460a-bcbd-4cc17a30a732' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92b7d83b-1029-460a-bcbd-4cc17a30a732', 2, NULL, 'På Norges nøgne fjelde', 'No. 2 På Norges nøgne fjelde (The Pine Tree)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14745 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92b7d83b-1029-460a-bcbd-4cc17a30a732'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Til Én I', part.name_en = 'No. 3 Til Én I (To Her I)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14745 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f297d0cc-01d6-40b3-ac01-d9ec23900f06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f297d0cc-01d6-40b3-ac01-d9ec23900f06', 3, NULL, 'Til Én I', 'No. 3 Til Én I (To Her I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14745 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f297d0cc-01d6-40b3-ac01-d9ec23900f06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Til Én II', part.name_en = 'No. 4 Til Én II (To Her II)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14745 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9e41d223-77b1-4a2f-a5d3-158775ee8130' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e41d223-77b1-4a2f-a5d3-158775ee8130', 4, NULL, 'Til Én II', 'No. 4 Til Én II (To Her II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14745 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e41d223-77b1-4a2f-a5d3-158775ee8130'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Farvel', part.name_en = 'No. 5 Farvel (Good-bye)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14745 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f56544d7-c4c0-4367-853e-c12eb4369c4f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f56544d7-c4c0-4367-853e-c12eb4369c4f', 5, NULL, 'Farvel', 'No. 5 Farvel (Good-bye)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14745 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f56544d7-c4c0-4367-853e-c12eb4369c4f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Nu hviler du i jorden', part.name_en = 'No. 6 Nu hviler du i jorden (Your Eyes Are Closed Forever)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14745 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:758d7079-323d-46d2-8d99-42b2015ced89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:758d7079-323d-46d2-8d99-42b2015ced89', 6, NULL, 'Nu hviler du i jorden', 'No. 6 Nu hviler du i jorden (Your Eyes Are Closed Forever)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14745 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:758d7079-323d-46d2-8d99-42b2015ced89'
);


-- Op. 60 5개의 가곡 Op. 60

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 60', piece.title_en = '5 Poems by Vilhelm Krag, Op. 60',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '60',
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15639 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 15639 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Liden Kirsten', part.name_en = 'No. 1 Liden Kirsten (Little Kirsten)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15639 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:80cadce6-67e0-4c66-b947-e7307fa98b56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80cadce6-67e0-4c66-b947-e7307fa98b56', 1, NULL, 'Liden Kirsten', 'No. 1 Liden Kirsten (Little Kirsten)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15639 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80cadce6-67e0-4c66-b947-e7307fa98b56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Moderen synger', part.name_en = 'No. 2 Moderen synger (The Mother''s Lament)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15639 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a5139186-9b59-42d4-a05b-7c15d1cbca6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5139186-9b59-42d4-a05b-7c15d1cbca6f', 2, NULL, 'Moderen synger', 'No. 2 Moderen synger (The Mother''s Lament)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15639 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5139186-9b59-42d4-a05b-7c15d1cbca6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mens jeg venter', part.name_en = 'No. 3 Mens jeg venter (On the Water)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15639 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:bb6b9289-54b1-4286-9518-33d8625f3cf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb6b9289-54b1-4286-9518-33d8625f3cf6', 3, NULL, 'Mens jeg venter', 'No. 3 Mens jeg venter (On the Water)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15639 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb6b9289-54b1-4286-9518-33d8625f3cf6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Der skreg en fugl', part.name_en = 'No. 4 Der skreg en fugl (A Bird Cried Out)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15639 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:691a33a2-3143-4704-bf91-b2b5b4ff4618' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:691a33a2-3143-4704-bf91-b2b5b4ff4618', 4, NULL, 'Der skreg en fugl', 'No. 4 Der skreg en fugl (A Bird Cried Out)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15639 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:691a33a2-3143-4704-bf91-b2b5b4ff4618'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Og jeg vil ha mig en hjertenskjær', part.name_en = 'No. 5 Og jeg vil ha mig en hjertenskjær (Midsummer Eve)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15639 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ecc0a3e8-b464-45c5-8c99-b3d1ba0d6c6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecc0a3e8-b464-45c5-8c99-b3d1ba0d6c6f', 5, NULL, 'Og jeg vil ha mig en hjertenskjær', 'No. 5 Og jeg vil ha mig en hjertenskjær (Midsummer Eve)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15639 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecc0a3e8-b464-45c5-8c99-b3d1ba0d6c6f'
);


-- Op. 61 가곡집 <어린이의 노래>

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 노래>', piece.title_en = 'Children''s Songs, Op. 61',
    piece.type = 'album', piece.opus_number = 'Op. 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13790 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 13790 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Havet', part.name_en = 'No. 1 Havet (The Ocean)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13790 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:96e25b36-b029-46c2-b0c6-bce41a0a6b67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96e25b36-b029-46c2-b0c6-bce41a0a6b67', 1, NULL, 'Havet', 'No. 1 Havet (The Ocean)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13790 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96e25b36-b029-46c2-b0c6-bce41a0a6b67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sang til Juletræet', part.name_en = 'No. 2 Sang til Juletræet (The Christmas Tree)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13790 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:39c5d5e7-c714-4265-8cd9-c430f237f665' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39c5d5e7-c714-4265-8cd9-c430f237f665', 2, NULL, 'Sang til Juletræet', 'No. 2 Sang til Juletræet (The Christmas Tree)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13790 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39c5d5e7-c714-4265-8cd9-c430f237f665'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lok', part.name_en = 'No. 3 Lok (Farmyard)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13790 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8c24e171-08ec-49bf-8d9f-f08c3c946020' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c24e171-08ec-49bf-8d9f-f08c3c946020', 3, NULL, 'Lok', 'No. 3 Lok (Farmyard)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13790 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c24e171-08ec-49bf-8d9f-f08c3c946020'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Fiskervise', part.name_en = 'No. 4 Fiskervise (Fisherman''s Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13790 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e0b46403-43a8-4cc3-bd96-86009992c668' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0b46403-43a8-4cc3-bd96-86009992c668', 4, NULL, 'Fiskervise', 'No. 4 Fiskervise (Fisherman''s Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13790 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0b46403-43a8-4cc3-bd96-86009992c668'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 15281 AND linked.composer_id = 117),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Kveldsang for Blakken', part.name_en = 'No. 5 Kveldsang for Blakken (Good-night Song for Dobbin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13790 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5ea313c2-8cb4-4700-952f-937884ee0f5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15281 AND linked.composer_id = 117), 'musicbrainz:5ea313c2-8cb4-4700-952f-937884ee0f5c', 5, NULL, 'Kveldsang for Blakken', 'No. 5 Kveldsang for Blakken (Good-night Song for Dobbin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13790 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ea313c2-8cb4-4700-952f-937884ee0f5c'
);

UPDATE pieces piece
SET piece.title = '가곡집 <어린이의 노래> 중 "Kveldsang for Blakken"', piece.title_en = 'Children''s Songs, Op. 61: No. 5 Kveldsang for Blakken (Good-night Song for Dobbin)', piece.editor_locked = 1
WHERE piece.id = 15281 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'De norske Fjelde', part.name_en = 'No. 6 De norske Fjelde (The Norwegian Mountains)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13790 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:7c4bba49-4df5-41f1-9ba2-9478d154cfd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c4bba49-4df5-41f1-9ba2-9478d154cfd4', 6, NULL, 'De norske Fjelde', 'No. 6 De norske Fjelde (The Norwegian Mountains)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13790 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c4bba49-4df5-41f1-9ba2-9478d154cfd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Fædrelandssalme', part.name_en = 'No. 7 Fædrelandssalme (Hymn of the Fatherland)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13790 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ceb3da86-406f-4172-9e03-751eb6a9fcaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceb3da86-406f-4172-9e03-751eb6a9fcaa', 7, NULL, 'Fædrelandssalme', 'No. 7 Fædrelandssalme (Hymn of the Fatherland)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13790 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceb3da86-406f-4172-9e03-751eb6a9fcaa'
);


-- Op. 62 서정 소곡집 7권 Op. 62

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 7권 Op. 62', 'Lyric Pieces, Book VII, Op. 62', 'album', NULL, 'Op.', '62', 1895, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 7권 Op. 62'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9c5932e-f20d-43bf-b4c1-cc64637602ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9c5932e-f20d-43bf-b4c1-cc64637602ab'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 7권 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9c5932e-f20d-43bf-b4c1-cc64637602ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c967d709-c1d0-3f5b-9771-d798a8380ac5', 1, NULL, '실프 (Sylphe)', 'No. 1 Sylphe (Sylph)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 7권 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c967d709-c1d0-3f5b-9771-d798a8380ac5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d56d681-11c3-3576-bd55-90fba35ff35f', 2, NULL, '감사 (Takk)', 'No. 2 Takk (Gratitude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 7권 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d56d681-11c3-3576-bd55-90fba35ff35f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:254166e1-4a98-3229-a115-11c429bc5e91', 3, NULL, '프랑스 세레나데 (Fransk Serenade)', 'No. 3 Fransk Serenade (French Serenade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 7권 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:254166e1-4a98-3229-a115-11c429bc5e91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49a4aac7-ccef-3434-a930-9577785c73be', 4, NULL, '시냇물 (Bækken)', 'No. 4 Bækken (Brooklet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 7권 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49a4aac7-ccef-3434-a930-9577785c73be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ece8637-e118-3c9e-ab02-1d8d1600e2b0', 5, NULL, '환영 (Drømmesyn)', 'No. 5 Drømmesyn (Phantom)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 7권 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ece8637-e118-3c9e-ab02-1d8d1600e2b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0d3d169-f999-3a51-9db3-580419e4dc0b', 6, NULL, '집으로 (Hjemad)', 'No. 6 Hjemad (Homeward)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 7권 Op. 62' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0d3d169-f999-3a51-9db3-580419e4dc0b'
);


-- Op. 63 2개의 북유럽 선율

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 북유럽 선율', '2 Nordic Melodies, Op. 63', 'album', 'Op. 63', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 북유럽 선율'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80e3c866-544a-41b7-a8f5-51798aaac715'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80e3c866-544a-41b7-a8f5-51798aaac715'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '2개의 북유럽 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80e3c866-544a-41b7-a8f5-51798aaac715'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fb35ee1-ec3d-44f2-b465-f43f0928ba25', 1, NULL, '민요풍으로 (I folketonestil)', 'No. 1 I folketonestil (In Folk Style)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '2개의 북유럽 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fb35ee1-ec3d-44f2-b465-f43f0928ba25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91042376-ffe4-4814-b95b-fb769a379a17', 2, NULL, 'Kulok og Stabbelåten', 'No. 2 Kulok og Stabbelåten (Cattle Call and Peasant Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '2개의 북유럽 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91042376-ffe4-4814-b95b-fb769a379a17'
);


-- Op. 64 교향적 무곡

UPDATE pieces piece
SET piece.title = '교향적 무곡', piece.title_en = 'Symphonic Dances',
    piece.type = 'album', piece.opus_number = 'Op. 64',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13887 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 13887 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato e marcato', part.name_en = 'I. Allegro moderato e marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13887 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:83e2086b-d6c3-4f6a-8ebf-e3d485a2a700' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83e2086b-d6c3-4f6a-8ebf-e3d485a2a700', 1, 'I', 'Allegro moderato e marcato', 'I. Allegro moderato e marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13887 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e2086b-d6c3-4f6a-8ebf-e3d485a2a700'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto grazioso', part.name_en = 'II. Allegretto grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13887 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:21ee9c8a-f112-3a68-8055-452948647a16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21ee9c8a-f112-3a68-8055-452948647a16', 2, 'II', 'Allegretto grazioso', 'II. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13887 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21ee9c8a-f112-3a68-8055-452948647a16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro giocoso', part.name_en = 'III. Allegro giocoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13887 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0245a03c-308b-4c11-96b9-9b8fdd132353' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0245a03c-308b-4c11-96b9-9b8fdd132353', 3, 'III', 'Allegro giocoso', 'III. Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13887 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0245a03c-308b-4c11-96b9-9b8fdd132353'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andante – Allegro molto e risoluto', part.name_en = 'IV. Andante – Allegro molto e risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13887 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ac3c65bd-bcef-4c9e-9113-5ee4dec252f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac3c65bd-bcef-4c9e-9113-5ee4dec252f4', 4, 'IV', 'Andante – Allegro molto e risoluto', 'IV. Andante – Allegro molto e risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13887 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac3c65bd-bcef-4c9e-9113-5ee4dec252f4'
);


-- Op. 65 서정 소곡집 8권 Op. 65

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 8권 Op. 65', 'Lyric Pieces, Book VIII, Op. 65', 'album', NULL, 'Op.', '65', 1896, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 8권 Op. 65'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39941d10-7984-4a18-8cf1-fe7dd5f04546'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '39941d10-7984-4a18-8cf1-fe7dd5f04546'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 8권 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39941d10-7984-4a18-8cf1-fe7dd5f04546'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:940acb4c-16b9-3c0c-9358-b3485098b5dc', 1, NULL, '젊은 날에서 (Fra Ungdomsdagene)', 'No. 1 Fra Ungdomsdagene (From Early Years)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 8권 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:940acb4c-16b9-3c0c-9358-b3485098b5dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b954ef8-6384-397b-bbf2-5181ebd34105', 2, NULL, '농부의 노래 (Bondens Sang)', 'No. 2 Bondens Sang (Peasant''s Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 8권 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b954ef8-6384-397b-bbf2-5181ebd34105'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7be0884b-a11f-3d34-bcc7-ebcbe3f1e166', 3, NULL, '우울 (Tungsind)', 'No. 3 Tungsind (Melancholy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 8권 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7be0884b-a11f-3d34-bcc7-ebcbe3f1e166'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31245f01-487d-3db8-b79f-4233317aa200', 4, NULL, '살롱 (Salon)', 'No. 4 Salon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 8권 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31245f01-487d-3db8-b79f-4233317aa200'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:014fa0ea-22e4-310c-b234-e170b00f109c', 5, NULL, '발라드풍으로 (I Balladetone)', 'No. 5 I Balladetone (Ballad)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 8권 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:014fa0ea-22e4-310c-b234-e170b00f109c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d58b9e2-02ed-3ef1-b916-40aa74935551', 6, NULL, '트롤드하우겐의 결혼식 날 (Bryllupsdag på Troldhaugen)', 'No. 6 Bryllupsdag på Troldhaugen (Wedding Day at Troldhaugen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 8권 Op. 65' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d58b9e2-02ed-3ef1-b916-40aa74935551'
);


-- Op. 66 19개의 노르웨이 민요 Op. 66

UPDATE pieces piece
SET piece.title = '19개의 노르웨이 민요 Op. 66', piece.title_en = '19 Norwegian Folk Songs, Op. 66',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '66',
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13967 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 13967 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Kulok', part.name_en = 'No. 1 Kulok (Cattle Call)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0fb77e12-bd4a-3d04-9247-738923b3e209' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fb77e12-bd4a-3d04-9247-738923b3e209', 1, NULL, 'Kulok', 'No. 1 Kulok (Cattle Call)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fb77e12-bd4a-3d04-9247-738923b3e209'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Det er den største Dårlighed', part.name_en = 'No. 2 Det er den største Dårlighed (It Is the Greatest Folly)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:331876ea-6395-32ea-af7a-099366c79382' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:331876ea-6395-32ea-af7a-099366c79382', 2, NULL, 'Det er den største Dårlighed', 'No. 2 Det er den største Dårlighed (It Is the Greatest Folly)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:331876ea-6395-32ea-af7a-099366c79382'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'En Konge hersked i Østerland', part.name_en = 'No. 3 En Konge hersked i Østerland (A King Ruled in the East)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:08c75115-424b-3806-b0eb-73436fa5da0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08c75115-424b-3806-b0eb-73436fa5da0e', 3, NULL, 'En Konge hersked i Østerland', 'No. 3 En Konge hersked i Østerland (A King Ruled in the East)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08c75115-424b-3806-b0eb-73436fa5da0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Siri Dale-Visen', part.name_en = 'No. 4 Siri Dale-Visen (A Song of Siri Dale)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d9d1f1d1-6888-36b3-8979-1845c13ad3d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9d1f1d1-6888-36b3-8979-1845c13ad3d7', 4, NULL, 'Siri Dale-Visen', 'No. 4 Siri Dale-Visen (A Song of Siri Dale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9d1f1d1-6888-36b3-8979-1845c13ad3d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Det var i min Ungdom', part.name_en = 'No. 5 Det var i min Ungdom (It Was in My Youth)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:33d26246-e593-3388-af78-d503bb65447a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33d26246-e593-3388-af78-d503bb65447a', 5, NULL, 'Det var i min Ungdom', 'No. 5 Det var i min Ungdom (It Was in My Youth)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33d26246-e593-3388-af78-d503bb65447a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Lok og bådnlåt', part.name_en = 'No. 6 Lok og bådnlåt (Cattle Call and Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d0105e8b-0045-321e-a7f4-554bc884ff93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0105e8b-0045-321e-a7f4-554bc884ff93', 6, NULL, 'Lok og bådnlåt', 'No. 6 Lok og bådnlåt (Cattle Call and Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0105e8b-0045-321e-a7f4-554bc884ff93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Bådnlåt', part.name_en = 'No. 7 Bådnlåt (Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:582ce989-ffdc-36cc-b2bb-4b3eb648ae19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:582ce989-ffdc-36cc-b2bb-4b3eb648ae19', 7, NULL, 'Bådnlåt', 'No. 7 Bådnlåt (Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:582ce989-ffdc-36cc-b2bb-4b3eb648ae19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Lok', part.name_en = 'No. 8 Lok (Cattle Call)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:74ed0ac2-5577-3d0e-8678-98388f91cd56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74ed0ac2-5577-3d0e-8678-98388f91cd56', 8, NULL, 'Lok', 'No. 8 Lok (Cattle Call)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74ed0ac2-5577-3d0e-8678-98388f91cd56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Liten va Guten', part.name_en = 'No. 9 Liten va Guten (Small Was the Lad)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a1d79de0-f19a-3d5c-8edd-e135eb820b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1d79de0-f19a-3d5c-8edd-e135eb820b7f', 9, NULL, 'Liten va Guten', 'No. 9 Liten va Guten (Small Was the Lad)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1d79de0-f19a-3d5c-8edd-e135eb820b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Morgo ska du få gifta deg', part.name_en = 'No. 10 Morgo ska du få gifta deg (Tomorrow You Shall Marry Her)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4fd97119-4d83-33c6-ae13-08919a7a5e37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fd97119-4d83-33c6-ae13-08919a7a5e37', 10, NULL, 'Morgo ska du få gifta deg', 'No. 10 Morgo ska du få gifta deg (Tomorrow You Shall Marry Her)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fd97119-4d83-33c6-ae13-08919a7a5e37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Det stander to Piger', part.name_en = 'No. 11 Det stander to Piger (There Stood Two Girls)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6ff29236-edbc-39e9-a4df-02f50263701c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ff29236-edbc-39e9-a4df-02f50263701c', 11, NULL, 'Det stander to Piger', 'No. 11 Det stander to Piger (There Stood Two Girls)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ff29236-edbc-39e9-a4df-02f50263701c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Ranveig', part.name_en = 'No. 12 Ranveig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a3f8078f-7f05-34dc-a893-d36a7f48ea1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3f8078f-7f05-34dc-a893-d36a7f48ea1f', 12, NULL, 'Ranveig', 'No. 12 Ranveig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3f8078f-7f05-34dc-a893-d36a7f48ea1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'En liten grå Man', part.name_en = 'No. 13 En liten grå Man (A Little Gray Man)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:1a184590-febd-3e9b-823c-1d07aab844f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a184590-febd-3e9b-823c-1d07aab844f1', 13, NULL, 'En liten grå Man', 'No. 13 En liten grå Man (A Little Gray Man)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a184590-febd-3e9b-823c-1d07aab844f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'I Ola-dalom, i Ola-Kjønn', part.name_en = 'No. 14 I Ola-dalom, i Ola-Kjønn (In Ola Valley, in Ola Lake)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5c52ab17-2829-30c1-bacb-484221ac605a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c52ab17-2829-30c1-bacb-484221ac605a', 14, NULL, 'I Ola-dalom, i Ola-Kjønn', 'No. 14 I Ola-dalom, i Ola-Kjønn (In Ola Valley, in Ola Lake)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c52ab17-2829-30c1-bacb-484221ac605a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Bådnlåt', part.name_en = 'No. 15 Bådnlåt (Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:eb936618-b43b-3abc-89e2-424155348f90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb936618-b43b-3abc-89e2-424155348f90', 15, NULL, 'Bådnlåt', 'No. 15 Bådnlåt (Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb936618-b43b-3abc-89e2-424155348f90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Ho vesle Astrid vor', part.name_en = 'No. 16 Ho vesle Astrid vor (Our Little Astrid)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:71c0f90c-7903-3a51-9830-cefcbc1a6199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71c0f90c-7903-3a51-9830-cefcbc1a6199', 16, NULL, 'Ho vesle Astrid vor', 'No. 16 Ho vesle Astrid vor (Our Little Astrid)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71c0f90c-7903-3a51-9830-cefcbc1a6199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Bådnlåt', part.name_en = 'No. 17 Bådnlåt (Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9bd8af75-541f-394f-9ecd-274d84dd103b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bd8af75-541f-394f-9ecd-274d84dd103b', 17, NULL, 'Bådnlåt', 'No. 17 Bådnlåt (Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bd8af75-541f-394f-9ecd-274d84dd103b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Jeg går i tusind Tanker', part.name_en = 'No. 18 Jeg går i tusind Tanker (I Wander Deep in Thought)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e599032d-2d76-30ef-8b2a-8369609d675c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e599032d-2d76-30ef-8b2a-8369609d675c', 18, NULL, 'Jeg går i tusind Tanker', 'No. 18 Jeg går i tusind Tanker (I Wander Deep in Thought)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e599032d-2d76-30ef-8b2a-8369609d675c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Gjendines Bådnlåt', part.name_en = 'No. 19 Gjendines Bådnlåt (Gjendine''s Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13967 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d0a20d37-406c-3cc5-a75c-e9aa85da23d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0a20d37-406c-3cc5-a75c-e9aa85da23d2', 19, NULL, 'Gjendines Bådnlåt', 'No. 19 Gjendines Bådnlåt (Gjendine''s Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13967 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0a20d37-406c-3cc5-a75c-e9aa85da23d2'
);


-- Op. 67 연가곡집 <하우그투사>

UPDATE pieces piece
SET piece.title = '연가곡집 <하우그투사>', piece.title_en = 'Haugtussa (The Mountain Maid), Op. 67',
    piece.type = 'album', piece.opus_number = 'Op. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14903 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 14903 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Det syng', part.name_en = 'No. 1 Det syng (The Enticement)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14903 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c16ea4ca-7925-44e6-bcf2-e1d62886aa8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c16ea4ca-7925-44e6-bcf2-e1d62886aa8f', 1, NULL, 'Det syng', 'No. 1 Det syng (The Enticement)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14903 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c16ea4ca-7925-44e6-bcf2-e1d62886aa8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Veslemøy', part.name_en = 'No. 2 Veslemøy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14903 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9c47e1c6-ee4b-4d1b-afb0-1201d5ceaeed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c47e1c6-ee4b-4d1b-afb0-1201d5ceaeed', 2, NULL, 'Veslemøy', 'No. 2 Veslemøy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14903 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c47e1c6-ee4b-4d1b-afb0-1201d5ceaeed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Blaabærli', part.name_en = 'No. 3 Blaabærli (Blueberry Slope)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14903 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:efdd808b-052b-49eb-a0df-8653368214a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efdd808b-052b-49eb-a0df-8653368214a6', 3, NULL, 'Blaabærli', 'No. 3 Blaabærli (Blueberry Slope)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14903 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efdd808b-052b-49eb-a0df-8653368214a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Møte', part.name_en = 'No. 4 Møte (The Tryst)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14903 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2278fab0-c23b-4c99-8cc1-f7def2914e14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2278fab0-c23b-4c99-8cc1-f7def2914e14', 4, NULL, 'Møte', 'No. 4 Møte (The Tryst)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14903 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2278fab0-c23b-4c99-8cc1-f7def2914e14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Elsk', part.name_en = 'No. 5 Elsk (Love)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14903 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c5e4dc81-d0d7-4f06-8b7e-ead9197b2b9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5e4dc81-d0d7-4f06-8b7e-ead9197b2b9d', 5, NULL, 'Elsk', 'No. 5 Elsk (Love)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14903 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e4dc81-d0d7-4f06-8b7e-ead9197b2b9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Killingdans', part.name_en = 'No. 6 Killingdans (Kidlings'' Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14903 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:85493f3e-a446-4748-9df1-3df9aa310ec1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85493f3e-a446-4748-9df1-3df9aa310ec1', 6, NULL, 'Killingdans', 'No. 6 Killingdans (Kidlings'' Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14903 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85493f3e-a446-4748-9df1-3df9aa310ec1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Vond Dag', part.name_en = 'No. 7 Vond Dag (Hurtful Day)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14903 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e89511d8-610f-48a4-84e2-26c9428a9abe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e89511d8-610f-48a4-84e2-26c9428a9abe', 7, NULL, 'Vond Dag', 'No. 7 Vond Dag (Hurtful Day)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14903 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e89511d8-610f-48a4-84e2-26c9428a9abe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Ved Gjætle-Bekken', part.name_en = 'No. 8 Ved Gjætle-Bekken (At the Brook)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14903 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c37632ea-a729-4c4d-833a-efa968fd7087' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c37632ea-a729-4c4d-833a-efa968fd7087', 8, NULL, 'Ved Gjætle-Bekken', 'No. 8 Ved Gjætle-Bekken (At the Brook)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14903 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c37632ea-a729-4c4d-833a-efa968fd7087'
);


-- Op. 68 서정 소곡집 9권 Op. 68

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 9권 Op. 68', 'Lyric Pieces, Book IX, Op. 68', 'album', NULL, 'Op.', '68', 1898, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 9권 Op. 68'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2123f30-7ec2-4802-bdae-ca623590e612'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a2123f30-7ec2-4802-bdae-ca623590e612'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 9권 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2123f30-7ec2-4802-bdae-ca623590e612'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf50a6c4-33ff-38ee-b471-c9e40d24b02c', 1, NULL, '뱃사람의 노래 (Matrosernes Opsang)', 'No. 1 Matrosernes Opsang (Sailors'' Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 9권 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf50a6c4-33ff-38ee-b471-c9e40d24b02c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3eeba41c-eed8-3809-aa2d-45807cecc1bb', 2, NULL, '할머니의 미뉴에트 (Bedstemors Menuet)', 'No. 2 Bedstemors Menuet (Grandmother''s Minuet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 9권 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3eeba41c-eed8-3809-aa2d-45807cecc1bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85114dec-a93d-36a7-a2bb-baa466debf6d', 3, NULL, '그대 발밑에 (For dine Føtter)', 'No. 3 For dine Føtter (At Your Feet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 9권 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85114dec-a93d-36a7-a2bb-baa466debf6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ba972be-ac44-30fa-942d-f6b1f3ec45e4', 4, NULL, '산 위의 저녁 (Aften på Højfjeldet)', 'No. 4 Aften på Højfjeldet (Evening in the Mountains)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 9권 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ba972be-ac44-30fa-942d-f6b1f3ec45e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc516557-6e2b-328f-8f76-c4288ed652c7', 5, NULL, '요람에서 (Bådnlåt)', 'No. 5 Bådnlåt (At the Cradle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 9권 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc516557-6e2b-328f-8f76-c4288ed652c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:701e88c6-b9c0-3105-a487-9fe2f284aa1e', 6, NULL, '우울한 왈츠 (Valse mélancolique)', 'No. 6 Valse mélancolique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 9권 Op. 68' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:701e88c6-b9c0-3105-a487-9fe2f284aa1e'
);


-- Op. 68 현악 합주를 위한 2개의 서정 소곡

UPDATE pieces piece
SET piece.title = '현악 합주를 위한 2개의 서정 소곡', piece.title_en = '2 Lyric Pieces for String Orchestra, Op. 68',
    piece.type = 'album', piece.opus_number = 'Op. 68',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13974 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 13974 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '산 위의 저녁 (Aften på Højfjeldet)', part.name_en = 'No. 1 Aften på Højfjeldet (Evening in the Mountains)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13974 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3c5836be-f0bf-3541-9acc-64faad3929d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c5836be-f0bf-3541-9acc-64faad3929d0', 1, NULL, '산 위의 저녁 (Aften på Højfjeldet)', 'No. 1 Aften på Højfjeldet (Evening in the Mountains)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13974 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c5836be-f0bf-3541-9acc-64faad3929d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '요람에서 (Bådnlåt)', part.name_en = 'No. 2 Bådnlåt (At the Cradle)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13974 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4789f4e5-25af-3c1d-bfcd-bd5a3d9dba32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4789f4e5-25af-3c1d-bfcd-bd5a3d9dba32', 2, NULL, '요람에서 (Bådnlåt)', 'No. 2 Bådnlåt (At the Cradle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13974 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4789f4e5-25af-3c1d-bfcd-bd5a3d9dba32'
);


-- Op. 69 5개의 가곡 Op. 69

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 69', piece.title_en = '5 Poems by Otto Benzon, Op. 69',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '69',
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13730 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 13730 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Der gynger en Båd på Bølge', part.name_en = 'No. 1 Der gynger en Båd på Bølge (A Boat on the Waves Is Rocking)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13730 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9205cb27-677a-40a3-96d3-6338a16e7e7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9205cb27-677a-40a3-96d3-6338a16e7e7e', 1, NULL, 'Der gynger en Båd på Bølge', 'No. 1 Der gynger en Båd på Bølge (A Boat on the Waves Is Rocking)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13730 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9205cb27-677a-40a3-96d3-6338a16e7e7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Til min Dreng', part.name_en = 'No. 2 Til min Dreng (To My Son)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13730 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3bf92104-530d-428b-9ed0-5cfcc2549606' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bf92104-530d-428b-9ed0-5cfcc2549606', 2, NULL, 'Til min Dreng', 'No. 2 Til min Dreng (To My Son)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13730 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bf92104-530d-428b-9ed0-5cfcc2549606'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ved Moders Grav', part.name_en = 'No. 3 Ved Moders Grav (At Mother''s Grave)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13730 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0add5ffa-6f44-45d7-a90d-ffbf4f2c7a64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0add5ffa-6f44-45d7-a90d-ffbf4f2c7a64', 3, NULL, 'Ved Moders Grav', 'No. 3 Ved Moders Grav (At Mother''s Grave)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13730 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0add5ffa-6f44-45d7-a90d-ffbf4f2c7a64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Snegl, Snegl!', part.name_en = 'No. 4 Snegl, Snegl! (Snail, Snail)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13730 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:1029c5a0-4e84-4f7b-bb76-768a1b46d433' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1029c5a0-4e84-4f7b-bb76-768a1b46d433', 4, NULL, 'Snegl, Snegl!', 'No. 4 Snegl, Snegl! (Snail, Snail)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13730 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1029c5a0-4e84-4f7b-bb76-768a1b46d433'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Drømme', part.name_en = 'No. 5 Drømme (Dreams)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13730 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d52bac13-2074-464f-986a-2932a76c61ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d52bac13-2074-464f-986a-2932a76c61ab', 5, NULL, 'Drømme', 'No. 5 Drømme (Dreams)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13730 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d52bac13-2074-464f-986a-2932a76c61ab'
);


-- Op. 70 5개의 가곡 Op. 70

UPDATE pieces piece
SET piece.title = '5개의 가곡 Op. 70', piece.title_en = '5 Poems by Otto Benzon, Op. 70',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '70',
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13976 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 13976 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Eros', part.name_en = 'No. 1 Eros',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13976 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2ae2b573-6893-4f13-b097-853e7480d148' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ae2b573-6893-4f13-b097-853e7480d148', 1, NULL, 'Eros', 'No. 1 Eros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13976 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ae2b573-6893-4f13-b097-853e7480d148'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Jeg lever et Liv i Længsel', part.name_en = 'No. 2 Jeg lever et Liv i Længsel (A Life of Longing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13976 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:39960a52-53fa-4614-a681-768b12fceb8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39960a52-53fa-4614-a681-768b12fceb8f', 2, NULL, 'Jeg lever et Liv i Længsel', 'No. 2 Jeg lever et Liv i Længsel (A Life of Longing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13976 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39960a52-53fa-4614-a681-768b12fceb8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Lys Nat', part.name_en = 'No. 3 Lys Nat (Summer Night)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13976 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:10d5afab-f73b-4eb1-b621-77f1b263d093' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10d5afab-f73b-4eb1-b621-77f1b263d093', 3, NULL, 'Lys Nat', 'No. 3 Lys Nat (Summer Night)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13976 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10d5afab-f73b-4eb1-b621-77f1b263d093'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Se dig for, naar du vælger din Vej', part.name_en = 'No. 4 Se dig for, naar du vælger din Vej (Walk with Care)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13976 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:985a87ad-56b0-4d33-817f-a988f360c90f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:985a87ad-56b0-4d33-817f-a988f360c90f', 4, NULL, 'Se dig for, naar du vælger din Vej', 'No. 4 Se dig for, naar du vælger din Vej (Walk with Care)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13976 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:985a87ad-56b0-4d33-817f-a988f360c90f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Digtervise', part.name_en = 'No. 5 Digtervise (A Poet''s Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13976 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:69f3f4bb-e0dc-47cb-8044-5d9c0a15e555' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69f3f4bb-e0dc-47cb-8044-5d9c0a15e555', 5, NULL, 'Digtervise', 'No. 5 Digtervise (A Poet''s Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13976 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69f3f4bb-e0dc-47cb-8044-5d9c0a15e555'
);


-- Op. 71 서정 소곡집 10권 Op. 71

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서정 소곡집 10권 Op. 71', 'Lyric Pieces, Book X, Op. 71', 'album', NULL, 'Op.', '71', 1901, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서정 소곡집 10권 Op. 71'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f94dd8ba-fc77-4b48-95e3-304a7e255480'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f94dd8ba-fc77-4b48-95e3-304a7e255480'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 10권 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f94dd8ba-fc77-4b48-95e3-304a7e255480'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bb9392d-bdc1-3e26-b948-ae113f66b1d7', 1, NULL, '옛날 옛적에 (Der var engang)', 'No. 1 Der var engang (Once Upon a Time)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 10권 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb9392d-bdc1-3e26-b948-ae113f66b1d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9bba67a-2709-3342-9f76-10f936541615', 2, NULL, '여름 저녁 (Sommeraften)', 'No. 2 Sommeraften (Summer''s Eve)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 10권 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9bba67a-2709-3342-9f76-10f936541615'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33514260-3a34-3c4c-b5f5-bfbdd48d6545', 3, NULL, '꼬마 요정 (Småtrold)', 'No. 3 Småtrold (Puck)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 10권 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33514260-3a34-3c4c-b5f5-bfbdd48d6545'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45cdae30-0ecb-31e8-8284-d57d9e85766d', 4, NULL, '숲의 고요 (Skovstilhed)', 'No. 4 Skovstilhed (Peace of the Woods)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 10권 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45cdae30-0ecb-31e8-8284-d57d9e85766d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80295be7-17ea-359a-b50b-9da5eb19701c', 5, NULL, '할링 (Halling)', 'No. 5 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 10권 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80295be7-17ea-359a-b50b-9da5eb19701c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee4c7d60-10d4-3efb-aa4a-cdc38c009ec6', 6, NULL, '지나간 날 (Forbi)', 'No. 6 Forbi (Gone)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 10권 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee4c7d60-10d4-3efb-aa4a-cdc38c009ec6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfc8a23f-3f7b-36ca-8fb9-519952ea588e', 7, NULL, '회상 (Efterklang)', 'No. 7 Efterklang (Remembrances)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '서정 소곡집 10권 Op. 71' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfc8a23f-3f7b-36ca-8fb9-519952ea588e'
);


-- Op. 72 노르웨이 농민 무곡 <슬로테르>

UPDATE pieces piece
SET piece.title = '노르웨이 농민 무곡 <슬로테르>', piece.title_en = 'Slåtter (Norwegian Peasant Dances), Op. 72',
    piece.type = 'album', piece.opus_number = 'Op. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13785 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 13785 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gibøens Bruremarsch', part.name_en = 'No. 1 Gibøens Bruremarsch (Gibøen''s Bridal March)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c15440ef-9bf1-3512-bbd7-6c887d1e3102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c15440ef-9bf1-3512-bbd7-6c887d1e3102', 1, NULL, 'Gibøens Bruremarsch', 'No. 1 Gibøens Bruremarsch (Gibøen''s Bridal March)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c15440ef-9bf1-3512-bbd7-6c887d1e3102'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'John Væstafæs Springdans', part.name_en = 'No. 2 John Væstafæs Springdans (John Væstafæ''s Spring Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:83b77215-5350-37a1-9205-f6815b2c95eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83b77215-5350-37a1-9205-f6815b2c95eb', 2, NULL, 'John Væstafæs Springdans', 'No. 2 John Væstafæs Springdans (John Væstafæ''s Spring Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83b77215-5350-37a1-9205-f6815b2c95eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Bruremarsch fra Telemarken', part.name_en = 'No. 3 Bruremarsch fra Telemarken (Bridal March from Telemark)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ac9087e4-a695-3ed3-8b85-61b864a10eaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac9087e4-a695-3ed3-8b85-61b864a10eaa', 3, NULL, 'Bruremarsch fra Telemarken', 'No. 3 Bruremarsch fra Telemarken (Bridal March from Telemark)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac9087e4-a695-3ed3-8b85-61b864a10eaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Haugelåt', part.name_en = 'No. 4 Haugelåt (Halling from the Hills)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:cb27ee11-47ef-358c-abb7-69b172fae819' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb27ee11-47ef-358c-abb7-69b172fae819', 4, NULL, 'Haugelåt', 'No. 4 Haugelåt (Halling from the Hills)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb27ee11-47ef-358c-abb7-69b172fae819'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Prillaren fra Os Præstegjeld', part.name_en = 'No. 5 Prillaren fra Os Præstegjeld (Prillar from Os Parish)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e96f94a1-37f7-38d4-bc94-6f173a9f69b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e96f94a1-37f7-38d4-bc94-6f173a9f69b5', 5, NULL, 'Prillaren fra Os Præstegjeld', 'No. 5 Prillaren fra Os Præstegjeld (Prillar from Os Parish)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e96f94a1-37f7-38d4-bc94-6f173a9f69b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gangar', part.name_en = 'No. 6 Gangar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ac49ea6a-ca81-311d-969e-eaf062ddad9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac49ea6a-ca81-311d-969e-eaf062ddad9c', 6, NULL, 'Gangar', 'No. 6 Gangar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac49ea6a-ca81-311d-969e-eaf062ddad9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Røtnamsknut', part.name_en = 'No. 7 Røtnamsknut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a4ed26ef-7a74-3605-92dd-4b1d7d5544b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4ed26ef-7a74-3605-92dd-4b1d7d5544b2', 7, NULL, 'Røtnamsknut', 'No. 7 Røtnamsknut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4ed26ef-7a74-3605-92dd-4b1d7d5544b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Bruremarsch (efter Møllarguten)', part.name_en = 'No. 8 Bruremarsch (efter Møllarguten) (Bridal March after Myllarguten)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:7f829643-4844-353d-8fe4-a5a633cc8c77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f829643-4844-353d-8fe4-a5a633cc8c77', 8, NULL, 'Bruremarsch (efter Møllarguten)', 'No. 8 Bruremarsch (efter Møllarguten) (Bridal March after Myllarguten)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f829643-4844-353d-8fe4-a5a633cc8c77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Nils Rekves Halling', part.name_en = 'No. 9 Nils Rekves Halling (Nils Rekve''s Halling)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a94e8574-336e-39aa-acb7-43aacdf9d388' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a94e8574-336e-39aa-acb7-43aacdf9d388', 9, NULL, 'Nils Rekves Halling', 'No. 9 Nils Rekves Halling (Nils Rekve''s Halling)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a94e8574-336e-39aa-acb7-43aacdf9d388'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Knut Luråsens Halling I', part.name_en = 'No. 10 Knut Luråsens Halling I (Knut Luråsen''s Halling I)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a5ce8fab-7a3e-376f-a286-012c54061d3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5ce8fab-7a3e-376f-a286-012c54061d3f', 10, NULL, 'Knut Luråsens Halling I', 'No. 10 Knut Luråsens Halling I (Knut Luråsen''s Halling I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5ce8fab-7a3e-376f-a286-012c54061d3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Knut Luråsens Halling II', part.name_en = 'No. 11 Knut Luråsens Halling II (Knut Luråsen''s Halling II)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:abae486a-54e6-3ced-8c25-f757ad08fb97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abae486a-54e6-3ced-8c25-f757ad08fb97', 11, NULL, 'Knut Luråsens Halling II', 'No. 11 Knut Luråsens Halling II (Knut Luråsen''s Halling II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abae486a-54e6-3ced-8c25-f757ad08fb97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Springdans (efter Møllarguten)', part.name_en = 'No. 12 Springdans (efter Møllarguten) (Spring Dance after Myllarguten)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8413b4b7-c450-3217-a59d-cedc81ee4ab6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8413b4b7-c450-3217-a59d-cedc81ee4ab6', 12, NULL, 'Springdans (efter Møllarguten)', 'No. 12 Springdans (efter Møllarguten) (Spring Dance after Myllarguten)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8413b4b7-c450-3217-a59d-cedc81ee4ab6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Håvar Gibøens Draum', part.name_en = 'No. 13 Håvar Gibøens Draum (Håvar Gibøen''s Dream)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4fe6b060-03d4-3fe9-9386-3c71be2a2cf3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fe6b060-03d4-3fe9-9386-3c71be2a2cf3', 13, NULL, 'Håvar Gibøens Draum', 'No. 13 Håvar Gibøens Draum (Håvar Gibøen''s Dream)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fe6b060-03d4-3fe9-9386-3c71be2a2cf3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Tussebrurefæra på Vossevangen', part.name_en = 'No. 14 Tussebrurefæra på Vossevangen (The Goblin''s Bridal Procession at Vossevangen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:850de567-2024-33a6-8c1b-9b536ec7c708' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:850de567-2024-33a6-8c1b-9b536ec7c708', 14, NULL, 'Tussebrurefæra på Vossevangen', 'No. 14 Tussebrurefæra på Vossevangen (The Goblin''s Bridal Procession at Vossevangen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:850de567-2024-33a6-8c1b-9b536ec7c708'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Skuldalsbruri', part.name_en = 'No. 15 Skuldalsbruri (The Bride of Skuldal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e8926246-64bb-32ce-b385-b8ae6dff1543' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8926246-64bb-32ce-b385-b8ae6dff1543', 15, NULL, 'Skuldalsbruri', 'No. 15 Skuldalsbruri (The Bride of Skuldal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8926246-64bb-32ce-b385-b8ae6dff1543'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Kivlemøyerne (Springdans)', part.name_en = 'No. 16 Kivlemøyerne (Springdans) (The Girls from Kivledal, Spring Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:48515368-325e-38c3-aa85-2f8281bcadee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48515368-325e-38c3-aa85-2f8281bcadee', 16, NULL, 'Kivlemøyerne (Springdans)', 'No. 16 Kivlemøyerne (Springdans) (The Girls from Kivledal, Spring Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48515368-325e-38c3-aa85-2f8281bcadee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Kivlemøyerne (Gangar)', part.name_en = 'No. 17 Kivlemøyerne (Gangar) (The Girls from Kivledal, Gangar)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13785 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8845f17a-f259-36e4-8177-827150adb16f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8845f17a-f259-36e4-8177-827150adb16f', 17, NULL, 'Kivlemøyerne (Gangar)', 'No. 17 Kivlemøyerne (Gangar) (The Girls from Kivledal, Gangar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13785 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8845f17a-f259-36e4-8177-827150adb16f'
);


-- Op. 73 피아노 모음곡 <분위기>

UPDATE pieces piece
SET piece.title = '피아노 모음곡 <분위기>', piece.title_en = 'Moods (Stemninger), Op. 73',
    piece.type = 'album', piece.opus_number = 'Op. 73',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13998 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 13998 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Resignation', part.name_en = 'No. 1 Resignation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13998 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:97e02192-1498-34fa-88e6-a8a7c1522821' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e02192-1498-34fa-88e6-a8a7c1522821', 1, NULL, 'Resignation', 'No. 1 Resignation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13998 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e02192-1498-34fa-88e6-a8a7c1522821'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scherzo-Impromptu', part.name_en = 'No. 2 Scherzo-Impromptu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13998 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0acc028e-1865-335d-ba9c-17fa38328ebf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0acc028e-1865-335d-ba9c-17fa38328ebf', 2, NULL, 'Scherzo-Impromptu', 'No. 2 Scherzo-Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13998 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0acc028e-1865-335d-ba9c-17fa38328ebf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Nattligt Ridt', part.name_en = 'No. 3 Nattligt Ridt (Night Ride)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13998 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c68c3841-366a-3192-95d6-59e4651e94a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c68c3841-366a-3192-95d6-59e4651e94a2', 3, NULL, 'Nattligt Ridt', 'No. 3 Nattligt Ridt (Night Ride)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13998 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c68c3841-366a-3192-95d6-59e4651e94a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Folketone', part.name_en = 'No. 4 Folketone (Folk Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13998 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:7c33d8db-f94a-3a1d-9a7d-d34225d01f12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c33d8db-f94a-3a1d-9a7d-d34225d01f12', 4, NULL, 'Folketone', 'No. 4 Folketone (Folk Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13998 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c33d8db-f94a-3a1d-9a7d-d34225d01f12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Studie (Hommage à Chopin)', part.name_en = 'No. 5 Studie (Hommage à Chopin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13998 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0be1abca-0b87-3c20-9c7a-0cd12e27ae8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0be1abca-0b87-3c20-9c7a-0cd12e27ae8f', 5, NULL, 'Studie (Hommage à Chopin)', 'No. 5 Studie (Hommage à Chopin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13998 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0be1abca-0b87-3c20-9c7a-0cd12e27ae8f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Studenternes Serenade', part.name_en = 'No. 6 Studenternes Serenade (Students'' Serenade)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13998 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5a84bf03-3bcd-3949-92b8-d3a661de60a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a84bf03-3bcd-3949-92b8-d3a661de60a4', 6, NULL, 'Studenternes Serenade', 'No. 6 Studenternes Serenade (Students'' Serenade)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13998 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a84bf03-3bcd-3949-92b8-d3a661de60a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Lualåt', part.name_en = 'No. 7 Lualåt (The Mountaineer''s Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13998 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fb91fbae-6bf7-3469-b9a3-526b14790a45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb91fbae-6bf7-3469-b9a3-526b14790a45', 7, NULL, 'Lualåt', 'No. 7 Lualåt (The Mountaineer''s Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13998 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb91fbae-6bf7-3469-b9a3-526b14790a45'
);


-- Op. 74 4개의 시편

UPDATE pieces piece
SET piece.title = '4개의 시편', piece.title_en = '4 Psalms after Old Norwegian Church Melodies, Op. 74',
    piece.type = 'album', piece.opus_number = 'Op. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13825 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 13825 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hvad est du dog skjøn', part.name_en = 'No. 1 Hvad est du dog skjøn (How Fair Is Thy Face)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13825 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:df1bfe7a-220d-4c7c-857b-c89fcf487ad6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df1bfe7a-220d-4c7c-857b-c89fcf487ad6', 1, NULL, 'Hvad est du dog skjøn', 'No. 1 Hvad est du dog skjøn (How Fair Is Thy Face)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13825 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df1bfe7a-220d-4c7c-857b-c89fcf487ad6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Guds Søn har gjordt meg fri', part.name_en = 'No. 2 Guds Søn har gjordt meg fri (God''s Son Hath Set Me Free)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13825 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d9f53378-bd83-440a-af9e-95a3d820a24c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9f53378-bd83-440a-af9e-95a3d820a24c', 2, NULL, 'Guds Søn har gjordt meg fri', 'No. 2 Guds Søn har gjordt meg fri (God''s Son Hath Set Me Free)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13825 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9f53378-bd83-440a-af9e-95a3d820a24c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Jesus Christus er opfaren', part.name_en = 'No. 3 Jesus Christus er opfaren (Jesus Christ Our Lord Is Risen)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13825 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6452bbe2-8f78-4b66-bfc7-1692e3bf8187' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6452bbe2-8f78-4b66-bfc7-1692e3bf8187', 3, NULL, 'Jesus Christus er opfaren', 'No. 3 Jesus Christus er opfaren (Jesus Christ Our Lord Is Risen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13825 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6452bbe2-8f78-4b66-bfc7-1692e3bf8187'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'I Himmelen', part.name_en = 'No. 4 I Himmelen (In Heaven Above)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13825 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:3456d009-8b26-48af-b22e-4a9c7dd65583' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3456d009-8b26-48af-b22e-4a9c7dd65583', 4, NULL, 'I Himmelen', 'No. 4 I Himmelen (In Heaven Above)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13825 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3456d009-8b26-48af-b22e-4a9c7dd65583'
);


-- EG 102 3개의 피아노 소품 EG 102

UPDATE pieces piece
SET piece.title = '3개의 피아노 소품 EG 102', piece.title_en = '3 Piano Pieces, EG 102',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'EG', piece.catalogue_number = '102',
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15043 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 15043 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lengsel', part.name_en = 'No. 1 Lengsel (Longing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15043 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b66351d2-eb60-4ea5-95dd-a5d67037b950' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b66351d2-eb60-4ea5-95dd-a5d67037b950', 1, NULL, 'Lengsel', 'No. 1 Lengsel (Longing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15043 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b66351d2-eb60-4ea5-95dd-a5d67037b950'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro con moto', part.name_en = 'No. 2 Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15043 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:488af531-0871-4b26-ac77-edbdbacfa3af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:488af531-0871-4b26-ac77-edbdbacfa3af', 2, NULL, 'Allegro con moto', 'No. 2 Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15043 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:488af531-0871-4b26-ac77-edbdbacfa3af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro assai', part.name_en = 'No. 3 Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15043 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8f74159e-1ab6-4f6f-b230-9f8a30063192' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f74159e-1ab6-4f6f-b230-9f8a30063192', 3, NULL, 'Allegro assai', 'No. 3 Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15043 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f74159e-1ab6-4f6f-b230-9f8a30063192'
);


-- EG 103 9개의 어린이 소품 EG 103

UPDATE pieces piece
SET piece.title = '9개의 어린이 소품 EG 103', piece.title_en = '9 Pieces for Children, EG 103',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'EG', piece.catalogue_number = '103',
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14011 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 14011 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro agitato', part.name_en = 'No. 1 Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:69739693-03f1-41a1-9dd6-6a7cb7e1b0d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69739693-03f1-41a1-9dd6-6a7cb7e1b0d2', 1, NULL, 'Allegro agitato', 'No. 1 Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69739693-03f1-41a1-9dd6-6a7cb7e1b0d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Perler', part.name_en = 'No. 2 Perler (Pearls)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:094393d9-5e51-4e3b-ab58-1744046b8280' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:094393d9-5e51-4e3b-ab58-1744046b8280', 2, NULL, 'Perler', 'No. 2 Perler (Pearls)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:094393d9-5e51-4e3b-ab58-1744046b8280'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ved Gellerts Grav', part.name_en = 'No. 3 Ved Gellerts Grav (At Gellert''s Grave)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:cb020beb-8e08-4b61-b498-cf8cfc45b01e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb020beb-8e08-4b61-b498-cf8cfc45b01e', 3, NULL, 'Ved Gellerts Grav', 'No. 3 Ved Gellerts Grav (At Gellert''s Grave)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb020beb-8e08-4b61-b498-cf8cfc45b01e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Bønn', part.name_en = 'No. 4 Bønn (Prayer)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:aa22f90a-3899-4471-8e44-fe6729b0dd22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa22f90a-3899-4471-8e44-fe6729b0dd22', 4, NULL, 'Bønn', 'No. 4 Bønn (Prayer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa22f90a-3899-4471-8e44-fe6729b0dd22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tap', part.name_en = 'No. 5 Tap (Loss)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2a216c01-494d-4456-b020-a03e39af5555' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a216c01-494d-4456-b020-a03e39af5555', 5, NULL, 'Tap', 'No. 5 Tap (Loss)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a216c01-494d-4456-b020-a03e39af5555'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Femårsdagen', part.name_en = 'No. 6 Femårsdagen (The Fifth Birthday)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:85193d64-7332-4555-8934-0c195a40e063' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85193d64-7332-4555-8934-0c195a40e063', 6, NULL, 'Femårsdagen', 'No. 6 Femårsdagen (The Fifth Birthday)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85193d64-7332-4555-8934-0c195a40e063'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Allegretto con moto', part.name_en = 'No. 7 Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:74837f89-d59b-411e-bc4c-abcef9ca21bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74837f89-d59b-411e-bc4c-abcef9ca21bd', 7, NULL, 'Allegretto con moto', 'No. 7 Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74837f89-d59b-411e-bc4c-abcef9ca21bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '스케르초 (Scherzo)', part.name_en = 'No. 8 Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f4377abd-4b69-436c-890e-91476e1ed88c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4377abd-4b69-436c-890e-91476e1ed88c', 8, NULL, '스케르초 (Scherzo)', 'No. 8 Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4377abd-4b69-436c-890e-91476e1ed88c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'En Drøm', part.name_en = 'No. 9 En Drøm (A Dream)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14011 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:97e2e469-9193-4912-89b4-76c9223fe2ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e2e469-9193-4912-89b4-76c9223fe2ad', 9, NULL, 'En Drøm', 'No. 9 En Drøm (A Dream)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14011 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e2e469-9193-4912-89b4-76c9223fe2ad'
);


-- EG 104 23개의 작은 소품 EG 104

UPDATE pieces piece
SET piece.title = '23개의 작은 소품 EG 104', piece.title_en = '23 Little Piano Pieces, EG 104',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'EG', piece.catalogue_number = '104',
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14017 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 14017 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegretto agitato', part.name_en = 'No. 1 Allegretto agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:842cfb62-f81e-375f-9bf6-61ccbe7cb677' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:842cfb62-f81e-375f-9bf6-61ccbe7cb677', 1, NULL, 'Allegretto agitato', 'No. 1 Allegretto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:842cfb62-f81e-375f-9bf6-61ccbe7cb677'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lengsel', part.name_en = 'No. 2 Lengsel (Longing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:230c0f6d-19f6-3739-8d66-8896af451f90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:230c0f6d-19f6-3739-8d66-8896af451f90', 2, NULL, 'Lengsel', 'No. 2 Lengsel (Longing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:230c0f6d-19f6-3739-8d66-8896af451f90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro desiderio', part.name_en = 'No. 3 Allegro desiderio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9156fdda-93e6-3c00-9889-4521f9c2b499' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9156fdda-93e6-3c00-9889-4521f9c2b499', 3, NULL, 'Allegro desiderio', 'No. 3 Allegro desiderio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9156fdda-93e6-3c00-9889-4521f9c2b499'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante quasi allegretto', part.name_en = 'No. 4 Andante quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b6971007-1dcd-3329-b38c-8f0081e09dc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6971007-1dcd-3329-b38c-8f0081e09dc6', 4, NULL, 'Andante quasi allegretto', 'No. 4 Andante quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6971007-1dcd-3329-b38c-8f0081e09dc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro assai', part.name_en = 'No. 5 Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:757c06b2-c51a-34ef-8407-31275d544ed0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:757c06b2-c51a-34ef-8407-31275d544ed0', 5, NULL, 'Allegro assai', 'No. 5 Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:757c06b2-c51a-34ef-8407-31275d544ed0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allegro con moto', part.name_en = 'No. 6 Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:66ebda24-9fa2-37eb-a8d4-969bf4b7fb65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66ebda24-9fa2-37eb-a8d4-969bf4b7fb65', 6, NULL, 'Allegro con moto', 'No. 6 Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ebda24-9fa2-37eb-a8d4-969bf4b7fb65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'En drøm', part.name_en = 'No. 7 En drøm (A Dream)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4a99abdb-20cd-3a8e-ae30-269f12d7ea8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a99abdb-20cd-3a8e-ae30-269f12d7ea8d', 7, NULL, 'En drøm', 'No. 7 En drøm (A Dream)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a99abdb-20cd-3a8e-ae30-269f12d7ea8d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Allegro assai', part.name_en = 'No. 8 Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d26a6745-5156-3a83-a26d-85b410cd082c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26a6745-5156-3a83-a26d-85b410cd082c', 8, NULL, 'Allegro assai', 'No. 8 Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26a6745-5156-3a83-a26d-85b410cd082c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Perler', part.name_en = 'No. 9 Perler (Pearls)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fcb3c665-30a0-3afb-9196-f78e5c959602' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcb3c665-30a0-3afb-9196-f78e5c959602', 9, NULL, 'Perler', 'No. 9 Perler (Pearls)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcb3c665-30a0-3afb-9196-f78e5c959602'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Ved Gellerts Grav', part.name_en = 'No. 10 Ved Gellerts Grav (At Gellert''s Grave)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:5be4bb47-3837-3915-a5fd-d27641b90982' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5be4bb47-3837-3915-a5fd-d27641b90982', 10, NULL, 'Ved Gellerts Grav', 'No. 10 Ved Gellerts Grav (At Gellert''s Grave)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5be4bb47-3837-3915-a5fd-d27641b90982'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Vivace', part.name_en = 'No. 11 Vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:edeac096-8e4f-3b7f-9866-eb6ae7c78b22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edeac096-8e4f-3b7f-9866-eb6ae7c78b22', 11, NULL, 'Vivace', 'No. 11 Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edeac096-8e4f-3b7f-9866-eb6ae7c78b22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '전주곡 (Preludium)', part.name_en = 'No. 12 Preludium (Prelude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a1651237-ea27-3efe-b14d-3bd885a35458' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1651237-ea27-3efe-b14d-3bd885a35458', 12, NULL, '전주곡 (Preludium)', 'No. 12 Preludium (Prelude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1651237-ea27-3efe-b14d-3bd885a35458'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Allegretto con moto', part.name_en = 'No. 13 Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:05871942-2981-339b-8abf-3ae5e14f7aa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05871942-2981-339b-8abf-3ae5e14f7aa9', 13, NULL, 'Allegretto con moto', 'No. 13 Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05871942-2981-339b-8abf-3ae5e14f7aa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Allegretto con moto', part.name_en = 'No. 14 Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:60584349-58dd-3a15-b640-865a913c0917' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60584349-58dd-3a15-b640-865a913c0917', 14, NULL, 'Allegretto con moto', 'No. 14 Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60584349-58dd-3a15-b640-865a913c0917'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '2성부 전주곡 (To-stemmig Preludium)', part.name_en = 'No. 15 To-stemmig Preludium (Two-part Prelude)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ce6736ba-d890-3177-b08b-2cbdfece585e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce6736ba-d890-3177-b08b-2cbdfece585e', 15, NULL, '2성부 전주곡 (To-stemmig Preludium)', 'No. 15 To-stemmig Preludium (Two-part Prelude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce6736ba-d890-3177-b08b-2cbdfece585e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '스케르초 (Scherzo)', part.name_en = 'No. 16 Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0aa446bb-edaf-3792-ae4c-76d3c1c69bef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aa446bb-edaf-3792-ae4c-76d3c1c69bef', 16, NULL, '스케르초 (Scherzo)', 'No. 16 Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aa446bb-edaf-3792-ae4c-76d3c1c69bef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Molto adagio religioso', part.name_en = 'No. 17 Molto adagio religioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c9d0fb5f-8d2f-3912-8f61-91e411ed4d3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9d0fb5f-8d2f-3912-8f61-91e411ed4d3b', 17, NULL, 'Molto adagio religioso', 'No. 17 Molto adagio religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9d0fb5f-8d2f-3912-8f61-91e411ed4d3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Femårsdagen', part.name_en = 'No. 18 Femårsdagen (The Fifth Birthday)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d68a48a3-4dbf-3f6f-8db9-e2821e54bd51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d68a48a3-4dbf-3f6f-8db9-e2821e54bd51', 18, NULL, 'Femårsdagen', 'No. 18 Femårsdagen (The Fifth Birthday)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d68a48a3-4dbf-3f6f-8db9-e2821e54bd51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Bønn', part.name_en = 'No. 19 Bønn (Prayer)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:bf5feb38-9298-3818-b48b-389e2ad2f54a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf5feb38-9298-3818-b48b-389e2ad2f54a', 19, NULL, 'Bønn', 'No. 19 Bønn (Prayer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf5feb38-9298-3818-b48b-389e2ad2f54a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Allegro vivace', part.name_en = 'No. 20 Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:bec6d88e-157d-32da-b2eb-f24bb955edaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bec6d88e-157d-32da-b2eb-f24bb955edaf', 20, NULL, 'Allegro vivace', 'No. 20 Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bec6d88e-157d-32da-b2eb-f24bb955edaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Tap', part.name_en = 'No. 21 Tap (Loss)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f57eebd6-b6c5-3404-b5c9-a2b878df0211' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f57eebd6-b6c5-3404-b5c9-a2b878df0211', 21, NULL, 'Tap', 'No. 21 Tap (Loss)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f57eebd6-b6c5-3404-b5c9-a2b878df0211'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Nicht zu schnell, ruhig', part.name_en = 'No. 22 Nicht zu schnell, ruhig',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:cec59719-ccd3-31f9-915c-4890c4122300' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cec59719-ccd3-31f9-915c-4890c4122300', 22, NULL, 'Nicht zu schnell, ruhig', 'No. 22 Nicht zu schnell, ruhig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cec59719-ccd3-31f9-915c-4890c4122300'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Assai allegro furioso', part.name_en = 'No. 23 Assai allegro furioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14017 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:95930e54-97fe-3fec-908a-41e0ccb44880' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95930e54-97fe-3fec-908a-41e0ccb44880', 23, NULL, 'Assai allegro furioso', 'No. 23 Assai allegro furioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14017 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95930e54-97fe-3fec-908a-41e0ccb44880'
);


-- EG 105 3개의 피아노 소품 EG 105

UPDATE pieces piece
SET piece.title = '3개의 피아노 소품 EG 105', piece.title_en = '3 Piano Pieces, EG 105',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'EG', piece.catalogue_number = '105',
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14382 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 14382 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro agitato', part.name_en = 'No. 1 Allegro agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14382 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:4ba1cb4a-b8b2-3759-a6c9-4b2e511d05b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ba1cb4a-b8b2-3759-a6c9-4b2e511d05b1', 1, NULL, 'Allegro agitato', 'No. 1 Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14382 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ba1cb4a-b8b2-3759-a6c9-4b2e511d05b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'No. 2 Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14382 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b79b29df-6b9c-3f0e-a719-25bc7e548145' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b79b29df-6b9c-3f0e-a719-25bc7e548145', 2, NULL, 'Allegretto', 'No. 2 Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14382 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b79b29df-6b9c-3f0e-a719-25bc7e548145'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro molto e vivace, quasi presto', part.name_en = 'No. 3 Allegro molto e vivace, quasi presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14382 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:59c1d23a-cfc6-3d8e-a24d-c46f27c8e2cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59c1d23a-cfc6-3d8e-a24d-c46f27c8e2cd', 3, NULL, 'Allegro molto e vivace, quasi presto', 'No. 3 Allegro molto e vivace, quasi presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14382 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59c1d23a-cfc6-3d8e-a24d-c46f27c8e2cd'
);


-- EG 106 피아노곡 <Agitato>

UPDATE pieces piece
SET piece.title = '피아노곡 <Agitato>', piece.title_en = 'Agitato',
    piece.type = 'song', piece.opus_number = 'EG 106',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15584 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 15584 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 107 리카르드 노르드라크 추모 장송 행진곡 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리카르드 노르드라크 추모 장송 행진곡 A단조', 'Funeral March in Memory of Rikard Nordraak in A minor', 'song', 'EG 107', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리카르드 노르드라크 추모 장송 행진곡 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4aa24772-d04f-3091-b5b6-bf4ed0cb6f62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4aa24772-d04f-3091-b5b6-bf4ed0cb6f62'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '리카르드 노르드라크 추모 장송 행진곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4aa24772-d04f-3091-b5b6-bf4ed0cb6f62'
);


-- EG 108 6개의 노르웨이 산의 선율

UPDATE pieces piece
SET piece.title = '6개의 노르웨이 산의 선율', piece.title_en = '6 Norwegian Mountain Melodies, EG 108',
    piece.type = 'album', piece.opus_number = 'EG 108',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1886, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13807 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1886
WHERE piece.id = 13807 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Springdans', part.name_en = 'No. 1 Springdans (Spring Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13807 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:745cad83-a4ed-322b-abef-b32e116f865b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:745cad83-a4ed-322b-abef-b32e116f865b', 1, NULL, 'Springdans', 'No. 1 Springdans (Spring Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13807 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:745cad83-a4ed-322b-abef-b32e116f865b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bådnlåt', part.name_en = 'No. 2 Bådnlåt (Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13807 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ceca847b-03eb-3307-929c-5e08e775ede7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceca847b-03eb-3307-929c-5e08e775ede7', 2, NULL, 'Bådnlåt', 'No. 2 Bådnlåt (Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13807 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceca847b-03eb-3307-929c-5e08e775ede7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Springdans', part.name_en = 'No. 3 Springdans (Spring Dance)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13807 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:354069cf-89ee-3d05-ad88-ff601ac02d45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:354069cf-89ee-3d05-ad88-ff601ac02d45', 3, NULL, 'Springdans', 'No. 3 Springdans (Spring Dance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13807 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354069cf-89ee-3d05-ad88-ff601ac02d45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sjugurd og trollbrura', part.name_en = 'No. 4 Sjugurd og trollbrura (Sigurd and the Troll Bride)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13807 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:6e8e1ddb-45f5-3f27-a2f0-2e0a5b135a81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e8e1ddb-45f5-3f27-a2f0-2e0a5b135a81', 4, NULL, 'Sjugurd og trollbrura', 'No. 4 Sjugurd og trollbrura (Sigurd and the Troll Bride)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13807 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e8e1ddb-45f5-3f27-a2f0-2e0a5b135a81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Halling', part.name_en = 'No. 5 Halling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13807 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:93641314-c339-301b-b7db-38c51ba1efe5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93641314-c339-301b-b7db-38c51ba1efe5', 5, NULL, 'Halling', 'No. 5 Halling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13807 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93641314-c339-301b-b7db-38c51ba1efe5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Guten og jenta på fjøshjellen', part.name_en = 'No. 6 Guten og jenta på fjøshjellen (The Boy and the Girl in the Cow-shed Loft)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13807 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:00125e3d-4dbc-3963-a1fb-2f424ee7b15c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00125e3d-4dbc-3963-a1fb-2f424ee7b15c', 6, NULL, 'Guten og jenta på fjøshjellen', 'No. 6 Guten og jenta på fjøshjellen (The Boy and the Girl in the Cow-shed Loft)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13807 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00125e3d-4dbc-3963-a1fb-2f424ee7b15c'
);


-- EG 109 앨범의 잎

UPDATE pieces piece
SET piece.title = '앨범의 잎', piece.title_en = 'Album Leaf, EG 109',
    piece.type = 'song', piece.opus_number = 'EG 109',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15297 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 15297 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 110 피아노곡 <흰 구름>

UPDATE pieces piece
SET piece.title = '피아노곡 <흰 구름>', piece.title_en = 'White Clouds (Hvite skyer)',
    piece.type = 'song', piece.opus_number = 'EG 110',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15265 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 15265 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 111 피아노곡 <요정의 곡>

UPDATE pieces piece
SET piece.title = '피아노곡 <요정의 곡>', piece.title_en = 'Gnomes'' Tune (Tusseslått)',
    piece.type = 'song', piece.opus_number = 'EG 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14899 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 14899 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 112 피아노곡 <춤은 계속된다>

UPDATE pieces piece
SET piece.title = '피아노곡 <춤은 계속된다>', piece.title_en = 'The Dance Goes On (Dansen går)',
    piece.type = 'song', piece.opus_number = 'EG 112',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14186 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 14186 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 114 현악 4중주를 위한 푸가 F단조

UPDATE pieces piece
SET piece.title = '현악 4중주를 위한 푸가 F단조', piece.title_en = 'Fugue in F minor for String Quartet',
    piece.type = 'song', piece.opus_number = 'EG 114',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1861, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13742 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1861
WHERE piece.id = 13742 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 115 첼로와 피아노를 위한 간주곡 A단조

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 간주곡 A단조', piece.title_en = 'Intermezzo in A minor for Cello and Piano',
    piece.type = 'song', piece.opus_number = 'EG 115',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1866, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14614 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1866
WHERE piece.id = 14614 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 116 피아노 3중주를 위한 Andante con moto C단조

UPDATE pieces piece
SET piece.title = '피아노 3중주를 위한 Andante con moto C단조', piece.title_en = 'Andante con moto in C minor for Piano Trio',
    piece.type = 'song', piece.opus_number = 'EG 116',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13872 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 13872 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 117 현악 4중주 2번 F장조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 F장조', piece.title_en = 'String Quartet No. 2 in F major (unfinished)',
    piece.type = 'album', piece.opus_number = 'EG 117',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14148 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 14148 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sostenuto – Allegro vivace e grazioso', part.name_en = 'I. Sostenuto – Allegro vivace e grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14148 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:df7ada29-17e7-4823-a32a-dcbc84c2537e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df7ada29-17e7-4823-a32a-dcbc84c2537e', 1, 'I', 'Sostenuto – Allegro vivace e grazioso', 'I. Sostenuto – Allegro vivace e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14148 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df7ada29-17e7-4823-a32a-dcbc84c2537e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro scherzando', part.name_en = 'II. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14148 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9e9e88b2-36b8-41f1-8434-5e9585740fe8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e9e88b2-36b8-41f1-8434-5e9585740fe8', 2, 'II', 'Allegro scherzando', 'II. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14148 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e9e88b2-36b8-41f1-8434-5e9585740fe8'
);


-- EG 119 교향곡 C단조

UPDATE pieces piece
SET piece.title = '교향곡 C단조', piece.title_en = 'Symphony in C minor',
    piece.type = 'album', piece.opus_number = 'EG 119',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14711 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 14711 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro molto', part.name_en = 'I. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14711 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e79baa41-8b3a-4949-ad15-9963549f0e5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e79baa41-8b3a-4949-ad15-9963549f0e5b', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14711 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e79baa41-8b3a-4949-ad15-9963549f0e5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio espressivo', part.name_en = 'II. Adagio espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14711 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:d90b3dcb-d185-4378-be06-e50e0645bf2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d90b3dcb-d185-4378-be06-e50e0645bf2b', 2, 'II', 'Adagio espressivo', 'II. Adagio espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14711 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d90b3dcb-d185-4378-be06-e50e0645bf2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '간주곡. Allegro energico', part.name_en = 'III. Intermezzo. Allegro energico',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14711 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:33c46765-c35a-4810-a34e-abf0c6f90269' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33c46765-c35a-4810-a34e-abf0c6f90269', 3, 'III', '간주곡. Allegro energico', 'III. Intermezzo. Allegro energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14711 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33c46765-c35a-4810-a34e-abf0c6f90269'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Allegro molto vivace', part.name_en = 'IV. Finale. Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14711 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fe7788f1-e026-4238-937b-51d19b6f2e57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe7788f1-e026-4238-937b-51d19b6f2e57', 4, 'IV', '피날레. Allegro molto vivace', 'IV. Finale. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14711 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe7788f1-e026-4238-937b-51d19b6f2e57'
);


-- EG 121 가곡 <Siehst du das Meer>

UPDATE pieces piece
SET piece.title = '가곡 <Siehst du das Meer>', piece.title_en = 'Siehst du das Meer (Look to the Sea)',
    piece.type = 'song', piece.opus_number = 'EG 121',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13969 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 13969 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 122 가곡 <Den syngende Menighet>

UPDATE pieces piece
SET piece.title = '가곡 <Den syngende Menighet>', piece.title_en = 'Den syngende Menighet (The Singing Congregation)',
    piece.type = 'song', piece.opus_number = 'EG 122',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14747 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 14747 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 123 가곡 <Til kirken hun vandrer>

UPDATE pieces piece
SET piece.title = '가곡 <Til kirken hun vandrer>', piece.title_en = 'Til kirken hun vandrer (Devoutest of Maidens)',
    piece.type = 'song', piece.opus_number = 'EG 123',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15646 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 15646 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 124 가곡 <Claras sang>

UPDATE pieces piece
SET piece.title = '가곡 <Claras sang>', piece.title_en = 'Claras sang (Clara''s Song)',
    piece.type = 'song', piece.opus_number = 'EG 124',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14292 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 14292 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 125 가곡 <Soldaten>

UPDATE pieces piece
SET piece.title = '가곡 <Soldaten>', piece.title_en = 'Soldaten (The Soldier)',
    piece.type = 'song', piece.opus_number = 'EG 125',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14040 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 14040 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 126 가곡 <Min lille fugl>

UPDATE pieces piece
SET piece.title = '가곡 <Min lille fugl>', piece.title_en = 'Min lille fugl (My Little Bird)',
    piece.type = 'song', piece.opus_number = 'EG 126',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14035 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 14035 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 127 가곡 <Dig elsker jeg>

UPDATE pieces piece
SET piece.title = '가곡 <Dig elsker jeg>', piece.title_en = 'Dig elsker jeg (I Love You, Dear)',
    piece.type = 'song', piece.opus_number = 'EG 127',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14034 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 14034 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 128 가곡 <Tåren>

UPDATE pieces piece
SET piece.title = '가곡 <Tåren>', piece.title_en = 'Tåren (The Tear)',
    piece.type = 'song', piece.opus_number = 'EG 128',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13805 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 13805 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 129 가곡 <Vesle gut>

UPDATE pieces piece
SET piece.title = '가곡 <Vesle gut>', piece.title_en = 'Vesle gut (Little Lad)',
    piece.type = 'song', piece.opus_number = 'EG 129',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1866, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13966 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1866
WHERE piece.id = 13966 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 130 가곡 <Den blonde Pige> I

UPDATE pieces piece
SET piece.title = '가곡 <Den blonde Pige> I', piece.title_en = 'Den blonde Pige I (The Fair Haired Maid I)',
    piece.type = 'song', piece.opus_number = 'EG 130',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1867, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13996 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1867
WHERE piece.id = 13996 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 131 가곡 <Odalisken synger>

UPDATE pieces piece
SET piece.title = '가곡 <Odalisken synger>', piece.title_en = 'Odalisken synger (The Odalisque)',
    piece.type = 'song', piece.opus_number = 'EG 131',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1870, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13931 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1870
WHERE piece.id = 13931 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 132 가곡 <Bergmanden>

UPDATE pieces piece
SET piece.title = '가곡 <Bergmanden>', piece.title_en = 'Bergmanden (The Miner)',
    piece.type = 'song', piece.opus_number = 'EG 132',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1870, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15166 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1870
WHERE piece.id = 15166 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 133 가곡 <Prinsessen>

UPDATE pieces piece
SET piece.title = '가곡 <Prinsessen>', piece.title_en = 'Prinsessen (The Princess)',
    piece.type = 'song', piece.opus_number = 'EG 133',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13985 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 13985 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 134 가곡 <Suk>

UPDATE pieces piece
SET piece.title = '가곡 <Suk>', piece.title_en = 'Suk (Sighs)',
    piece.type = 'song', piece.opus_number = 'EG 134',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13818 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 13818 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 135 가곡 <Til L. M. Lindemans Sølvbryllup>

UPDATE pieces piece
SET piece.title = '가곡 <Til L. M. Lindemans Sølvbryllup>', piece.title_en = 'Til L. M. Lindemans Sølvbryllup (For L. M. Lindeman''s Silver Wedding)',
    piece.type = 'song', piece.opus_number = 'EG 135',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13880 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 13880 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 136 가곡 <Til Generalkonsul Chr. Tønsberg>

UPDATE pieces piece
SET piece.title = '가곡 <Til Generalkonsul Chr. Tønsberg>', piece.title_en = 'Til Generalkonsul Chr. Tønsberg (To Chr. Tønsberg)',
    piece.type = 'song', piece.opus_number = 'EG 136',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13884 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 13884 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 137 가곡 <Den hvite, røde rose>

UPDATE pieces piece
SET piece.title = '가곡 <Den hvite, røde rose>', piece.title_en = 'Den hvite, røde rose (The White and Red, Red Roses)',
    piece.type = 'song', piece.opus_number = 'EG 137',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14028 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 14028 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 138 가곡 <Den blonde Pige> II

UPDATE pieces piece
SET piece.title = '가곡 <Den blonde Pige> II', piece.title_en = 'Den blonde Pige II (The Fair Haired Maid II)',
    piece.type = 'song', piece.opus_number = 'EG 138',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14003 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 14003 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 139 가곡 <Morgenbønn på skolen>

UPDATE pieces piece
SET piece.title = '가곡 <Morgenbønn på skolen>', piece.title_en = 'Morgenbønn på skolen (Morning Prayer at School)',
    piece.type = 'song', piece.opus_number = 'EG 139',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14021 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 14021 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 140 가곡 <På Hamars ruiner>

UPDATE pieces piece
SET piece.title = '가곡 <På Hamars ruiner>', piece.title_en = 'På Hamars ruiner (On the Ruins of Hamar)',
    piece.type = 'song', piece.opus_number = 'EG 140',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13905 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 13905 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 141 가곡 <Jenta>

UPDATE pieces piece
SET piece.title = '가곡 <Jenta>', piece.title_en = 'Jenta (The Lass)',
    piece.type = 'song', piece.opus_number = 'EG 141',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13943 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 13943 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 142 가곡 <Attegløyma>

UPDATE pieces piece
SET piece.title = '가곡 <Attegløyma>', piece.title_en = 'Attegløyma (The Forgotten Maid)',
    piece.type = 'song', piece.opus_number = 'EG 142',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13955 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 13955 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 144 가곡 <Under Juletræet>

UPDATE pieces piece
SET piece.title = '가곡 <Under Juletræet>', piece.title_en = 'Under Juletræet (Beneath the Christmas Tree)',
    piece.type = 'song', piece.opus_number = 'EG 144',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13937 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 13937 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 145 가곡 <Blåbæret>

UPDATE pieces piece
SET piece.title = '가곡 <Blåbæret>', piece.title_en = 'Blåbæret (The Blueberry)',
    piece.type = 'song', piece.opus_number = 'EG 145',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13975 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 13975 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 146 가곡 <Påskesang>

UPDATE pieces piece
SET piece.title = '가곡 <Påskesang>', piece.title_en = 'Påskesang (Easter Song)',
    piece.type = 'song', piece.opus_number = 'EG 146',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13796 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 13796 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 147 가곡 <Simpel sang>

UPDATE pieces piece
SET piece.title = '가곡 <Simpel sang>', piece.title_en = 'Simpel sang (A Simple Song)',
    piece.type = 'song', piece.opus_number = 'EG 147',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13831 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 13831 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 148 가곡 <Du retter tidt dit øjepar>

UPDATE pieces piece
SET piece.title = '가곡 <Du retter tidt dit øjepar>', piece.title_en = 'Du retter tidt dit øjepar (You Often Fix Your Gaze)',
    piece.type = 'song', piece.opus_number = 'EG 148',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15680 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 15680 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 149 가곡 <Valgsang>

UPDATE pieces piece
SET piece.title = '가곡 <Valgsang>', piece.title_en = 'Valgsang (Election Song)',
    piece.type = 'song', piece.opus_number = 'EG 149',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14012 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 14012 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 150 가곡 <Ave, maris stella>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ave, maris stella>', 'Ave, maris stella', 'song', 'EG 150', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 117
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ave, maris stella>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42b00f0d-9cc3-4fa6-9183-d38a62405f4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '42b00f0d-9cc3-4fa6-9183-d38a62405f4a'
FROM pieces p
WHERE p.composer_id = 117 AND p.title = '가곡 <Ave, maris stella>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42b00f0d-9cc3-4fa6-9183-d38a62405f4a'
);


-- EG 151 가곡 <Fædrelandssang>

UPDATE pieces piece
SET piece.title = '가곡 <Fædrelandssang>', piece.title_en = 'Fædrelandssang (National Song)',
    piece.type = 'song', piece.opus_number = 'EG 151',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13758 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 13758 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 152 <하우그투사> 미수록 가곡 EG 152

UPDATE pieces piece
SET piece.title = '<하우그투사> 미수록 가곡 EG 152', piece.title_en = 'Haugtussa: Songs Not Included in Op. 67, EG 152',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'EG', piece.catalogue_number = '152',
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14583 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 14583 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Prolog', part.name_en = 'No. 1 Prolog (Prologue)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-eg152:1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-eg152:1', 1, NULL, 'Prolog', 'No. 1 Prolog (Prologue)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-eg152:1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Veslemøy ved rokken', part.name_en = 'No. 2 Veslemøy ved rokken (Veslemøy at the Spinning Wheel)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-eg152:2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-eg152:2', 2, NULL, 'Veslemøy ved rokken', 'No. 2 Veslemøy ved rokken (Veslemøy at the Spinning Wheel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-eg152:2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Kvelding', part.name_en = 'No. 3 Kvelding (Evening)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-eg152:3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-eg152:3', 3, NULL, 'Kvelding', 'No. 3 Kvelding (Evening)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-eg152:3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sporven', part.name_en = 'No. 4 Sporven (The Sparrow)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c95f3178-743a-43f3-af98-ec8f117183d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c95f3178-743a-43f3-af98-ec8f117183d4', 4, NULL, 'Sporven', 'No. 4 Sporven (The Sparrow)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c95f3178-743a-43f3-af98-ec8f117183d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Fyrevarsel', part.name_en = 'No. 5 Fyrevarsel (Warning)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-eg152:5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-eg152:5', 5, NULL, 'Fyrevarsel', 'No. 5 Fyrevarsel (Warning)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-eg152:5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'I slåtten', part.name_en = 'No. 6 I slåtten (In the Hayfield)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:26bdf3ad-3a13-4822-a923-abab02aead55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26bdf3ad-3a13-4822-a923-abab02aead55', 6, NULL, 'I slåtten', 'No. 6 I slåtten (In the Hayfield)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26bdf3ad-3a13-4822-a923-abab02aead55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Veslemøy undrast', part.name_en = 'No. 7 Veslemøy undrast (Veslemøy Wondering)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:fd7c5619-6504-472b-a18c-10e9a1b50d79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd7c5619-6504-472b-a18c-10e9a1b50d79', 7, NULL, 'Veslemøy undrast', 'No. 7 Veslemøy undrast (Veslemøy Wondering)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd7c5619-6504-472b-a18c-10e9a1b50d79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Dømd', part.name_en = 'No. 8 Dømd (Doomed)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b22dad3b-1db5-41f4-a6ae-b5302ace9186' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b22dad3b-1db5-41f4-a6ae-b5302ace9186', 8, NULL, 'Dømd', 'No. 8 Dømd (Doomed)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b22dad3b-1db5-41f4-a6ae-b5302ace9186'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Den snilde guten', part.name_en = 'No. 9 Den snilde guten (The Nice Boy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-eg152:9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-eg152:9', 9, NULL, 'Den snilde guten', 'No. 9 Den snilde guten (The Nice Boy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-eg152:9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Veslemøy lengtar', part.name_en = 'No. 10 Veslemøy lengtar (Veslemøy Longing)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:b2e6b4ac-a5e6-4ebe-9630-e0351a0682eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2e6b4ac-a5e6-4ebe-9630-e0351a0682eb', 10, NULL, 'Veslemøy lengtar', 'No. 10 Veslemøy lengtar (Veslemøy Longing)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2e6b4ac-a5e6-4ebe-9630-e0351a0682eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Skog-glad', part.name_en = 'No. 11 Skog-glad (Forest Joy)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'classicmap:grieg:grieg-eg152:11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:grieg:grieg-eg152:11', 11, NULL, 'Skog-glad', 'No. 11 Skog-glad (Forest Joy)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:grieg:grieg-eg152:11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Ku-lok', part.name_en = 'No. 12 Ku-lok (Cow Call)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14583 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:23f65d6d-297f-46cb-a470-8160ac9978d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23f65d6d-297f-46cb-a470-8160ac9978d0', 12, NULL, 'Ku-lok', 'No. 12 Ku-lok (Cow Call)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14583 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23f65d6d-297f-46cb-a470-8160ac9978d0'
);


-- EG 153 가곡 <Jeg elsker>

UPDATE pieces piece
SET piece.title = '가곡 <Jeg elsker>', piece.title_en = 'Jeg elsker (I Loved Him)',
    piece.type = 'song', piece.opus_number = 'EG 153',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13921 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 13921 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 154 가곡 <Til en hunndjevel>

UPDATE pieces piece
SET piece.title = '가곡 <Til en hunndjevel>', piece.title_en = 'Til en hunndjevel (To a Devil)',
    piece.type = 'song', piece.opus_number = 'EG 154',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13788 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 13788 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 155 가곡 <Julens vuggesang>

UPDATE pieces piece
SET piece.title = '가곡 <Julens vuggesang>', piece.title_en = 'Julens vuggesang (Yuletide Cradle Song)',
    piece.type = 'song', piece.opus_number = 'EG 155',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13740 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 13740 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 156 가곡 <Gentlemen-menige>

UPDATE pieces piece
SET piece.title = '가곡 <Gentlemen-menige>', piece.title_en = 'Gentlemen-menige (Gentleman Rankers)',
    piece.type = 'song', piece.opus_number = 'EG 156',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13874 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 13874 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 157 가곡 <Jægeren>

UPDATE pieces piece
SET piece.title = '가곡 <Jægeren>', piece.title_en = 'Jægeren (Der Jäger, The Hunter)',
    piece.type = 'song', piece.opus_number = 'EG 157',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13945 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 13945 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 158 크리스티 동상 제막 칸타타

UPDATE pieces piece
SET piece.title = '크리스티 동상 제막 칸타타', piece.title_en = 'Christie Cantata (Kantate ved avsløringen av Christie-støtten)',
    piece.type = 'song', piece.opus_number = 'EG 158',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15074 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 15074 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 159 합창곡 <Dona nobis pacem>

UPDATE pieces piece
SET piece.title = '합창곡 <Dona nobis pacem>', piece.title_en = 'Dona nobis pacem',
    piece.type = 'song', piece.opus_number = 'EG 159',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15539 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 15539 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 160 4개의 남성 합창곡 EG 160

UPDATE pieces piece
SET piece.title = '4개의 남성 합창곡 EG 160', piece.title_en = '4 Songs for Male Chorus, EG 160',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'EG', piece.catalogue_number = '160',
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14850 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 14850 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Norsk Krigssang', part.name_en = 'No. 1 Norsk Krigssang',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14850 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:88337268-a833-45a6-bf12-632fa7fe1241' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88337268-a833-45a6-bf12-632fa7fe1241', 1, NULL, 'Norsk Krigssang', 'No. 1 Norsk Krigssang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14850 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88337268-a833-45a6-bf12-632fa7fe1241'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fredriksborg', part.name_en = 'No. 2 Fredriksborg',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14850 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:61a17f19-cee4-4e3b-bea2-ad82b603ab9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61a17f19-cee4-4e3b-bea2-ad82b603ab9f', 2, NULL, 'Fredriksborg', 'No. 2 Fredriksborg', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14850 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61a17f19-cee4-4e3b-bea2-ad82b603ab9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Studereliv', part.name_en = 'No. 3 Studereliv',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14850 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:0aa68c01-2fbf-4d07-ba03-2dbdbc90c972' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aa68c01-2fbf-4d07-ba03-2dbdbc90c972', 3, NULL, 'Studereliv', 'No. 3 Studereliv', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14850 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aa68c01-2fbf-4d07-ba03-2dbdbc90c972'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Den sildige Rose', part.name_en = 'No. 4 Den sildige Rose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14850 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8cc6a72a-8984-40eb-99d2-24465776efaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cc6a72a-8984-40eb-99d2-24465776efaa', 4, NULL, 'Den sildige Rose', 'No. 4 Den sildige Rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14850 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cc6a72a-8984-40eb-99d2-24465776efaa'
);


-- EG 161 합창곡 <Danmark>

UPDATE pieces piece
SET piece.title = '합창곡 <Danmark>', piece.title_en = 'Danmark (Denmark)',
    piece.type = 'song', piece.opus_number = 'EG 161',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14191 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 14191 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 162 요르겐 모에 시에 의한 2개의 남성 합창곡

UPDATE pieces piece
SET piece.title = '요르겐 모에 시에 의한 2개의 남성 합창곡', piece.title_en = '2 Songs of Jørgen Moe, EG 162',
    piece.type = 'album', piece.opus_number = 'EG 162',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1867, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14984 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1867
WHERE piece.id = 14984 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Aftenstemning', part.name_en = 'No. 1 Aftenstemning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14984 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:91804b41-5d60-43af-8a16-724ab7d4271b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91804b41-5d60-43af-8a16-724ab7d4271b', 1, NULL, 'Aftenstemning', 'No. 1 Aftenstemning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14984 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91804b41-5d60-43af-8a16-724ab7d4271b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bjørneskytten', part.name_en = 'No. 2 Bjørneskytten',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14984 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ef346a17-259c-40f1-b9fd-05c16d755aab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef346a17-259c-40f1-b9fd-05c16d755aab', 2, NULL, 'Bjørneskytten', 'No. 2 Bjørneskytten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14984 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef346a17-259c-40f1-b9fd-05c16d755aab'
);


-- EG 163 합창곡 <Sjømannssang>

UPDATE pieces piece
SET piece.title = '합창곡 <Sjømannssang>', piece.title_en = 'Sjømannssang (Seamen''s Song)',
    piece.type = 'song', piece.opus_number = 'EG 163',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14269 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 14269 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 164 칼 할스를 위한 칸타타

UPDATE pieces piece
SET piece.title = '칼 할스를 위한 칸타타', piece.title_en = 'Cantata to Karl Hals',
    piece.type = 'song', piece.opus_number = 'EG 164',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14787 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 14787 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 165 합창곡 <Ved J. S. Welhavens Båre>

UPDATE pieces piece
SET piece.title = '합창곡 <Ved J. S. Welhavens Båre>', piece.title_en = 'Ved J. S. Welhavens Båre',
    piece.type = 'song', piece.opus_number = 'EG 165',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14399 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 14399 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 166 합창곡 <Oppsang for frihetsfolket i Norden>

UPDATE pieces piece
SET piece.title = '합창곡 <Oppsang for frihetsfolket i Norden>', piece.title_en = 'Oppsang for frihetsfolket i Norden',
    piece.type = 'song', piece.opus_number = 'EG 166',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15253 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 15253 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 167 합창곡 <Ved Halfdan Kjerulfs minnestøtte>

UPDATE pieces piece
SET piece.title = '합창곡 <Ved Halfdan Kjerulfs minnestøtte>', piece.title_en = 'At the Halfdan Kjerulf Statue (Ved Halfdan Kjerulfs minnestøtte)',
    piece.type = 'album', piece.opus_number = 'EG 167',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14542 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 14542 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Noget langsomt', part.name_en = 'I. Noget langsomt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14542 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:2ec68758-26e3-3291-858e-a3132aecb7b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ec68758-26e3-3291-858e-a3132aecb7b0', 1, 'I', 'Noget langsomt', 'I. Noget langsomt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14542 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ec68758-26e3-3291-858e-a3132aecb7b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'I folketone. Andante', part.name_en = 'II. I folketone. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 14542 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:bcbd3ad9-d75b-364b-9132-4adba0b9b217' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bcbd3ad9-d75b-364b-9132-4adba0b9b217', 2, 'II', 'I folketone. Andante', 'II. I folketone. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 14542 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bcbd3ad9-d75b-364b-9132-4adba0b9b217'
);


-- EG 168 합창곡 <Inga Litamor>

UPDATE pieces piece
SET piece.title = '합창곡 <Inga Litamor>', piece.title_en = 'Inga Litamor',
    piece.type = 'song', piece.opus_number = 'EG 168',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14578 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 14578 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 169 2개의 남성 합창곡 EG 169

UPDATE pieces piece
SET piece.title = '2개의 남성 합창곡 EG 169', piece.title_en = '2 Male Choruses, EG 169',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'EG', piece.catalogue_number = '169',
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15177 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 15177 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Min deiligste tanke', part.name_en = 'No. 1 Min deiligste tanke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15177 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:ca066f08-6c73-4134-af9e-a8cd95fc898e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca066f08-6c73-4134-af9e-a8cd95fc898e', 1, NULL, 'Min deiligste tanke', 'No. 1 Min deiligste tanke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15177 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca066f08-6c73-4134-af9e-a8cd95fc898e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vårt løsen', part.name_en = 'No. 2 Vårt løsen',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 15177 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:672d7095-ba01-4d85-8130-ff907b7840c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:672d7095-ba01-4d85-8130-ff907b7840c1', 2, NULL, 'Vårt løsen', 'No. 2 Vårt løsen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 15177 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:672d7095-ba01-4d85-8130-ff907b7840c1'
);


-- EG 170 합창곡 <Sangerhilsen>

UPDATE pieces piece
SET piece.title = '합창곡 <Sangerhilsen>', piece.title_en = 'Sangerhilsen',
    piece.type = 'song', piece.opus_number = 'EG 170',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14574 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 14574 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 171 홀베르그 칸타타

UPDATE pieces piece
SET piece.title = '홀베르그 칸타타', piece.title_en = 'Holberg Cantata',
    piece.type = 'album', piece.opus_number = 'EG 171',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13837 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 13837 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro con brio', part.name_en = 'I. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13837 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:e06e6955-4061-43dc-acfd-1b2eb8b1d261' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e06e6955-4061-43dc-acfd-1b2eb8b1d261', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13837 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e06e6955-4061-43dc-acfd-1b2eb8b1d261'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto andante', part.name_en = 'II. Molto andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13837 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:33d0fed7-0728-4dc7-8040-84b1b7527035' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33d0fed7-0728-4dc7-8040-84b1b7527035', 2, 'II', 'Molto andante', 'II. Molto andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13837 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33d0fed7-0728-4dc7-8040-84b1b7527035'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto vivace', part.name_en = 'III. Allegro molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13837 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:9a21681d-615d-48ea-9ccf-289a8b9d2d4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a21681d-615d-48ea-9ccf-289a8b9d2d4d', 3, 'III', 'Allegro molto vivace', 'III. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13837 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a21681d-615d-48ea-9ccf-289a8b9d2d4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro moderato e marcato', part.name_en = 'IV. Allegro moderato e marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13837 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:22226a18-223f-4e5b-90fc-931a94136b0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22226a18-223f-4e5b-90fc-931a94136b0f', 4, 'IV', 'Allegro moderato e marcato', 'IV. Allegro moderato e marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13837 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22226a18-223f-4e5b-90fc-931a94136b0f'
);


-- EG 172 합창곡 <Flaggvise>

UPDATE pieces piece
SET piece.title = '합창곡 <Flaggvise>', piece.title_en = 'Flaggvise',
    piece.type = 'song', piece.opus_number = 'EG 172',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14294 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 14294 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 173 합창곡 <Kristianiensernes Sangerhilsen>

UPDATE pieces piece
SET piece.title = '합창곡 <Kristianiensernes Sangerhilsen>', piece.title_en = 'Kristianiensernes Sangerhilsen',
    piece.type = 'song', piece.opus_number = 'EG 173',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1895, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15476 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1895
WHERE piece.id = 15476 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 174 합창곡 <Jædervise>

UPDATE pieces piece
SET piece.title = '합창곡 <Jædervise>', piece.title_en = 'Jædervise',
    piece.type = 'song', piece.opus_number = 'EG 174',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15426 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 15426 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 175 합창곡 <Impromptu til Griegs Mandskor i Fort Dodge, Iowa>

UPDATE pieces piece
SET piece.title = '합창곡 <Impromptu til Griegs Mandskor i Fort Dodge, Iowa>', piece.title_en = 'Impromptu to Grieg Men''s Chorus in Fort Dodge, Iowa',
    piece.type = 'song', piece.opus_number = 'EG 175',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15547 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 15547 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 176 합창곡 <Til Ole Bull>

UPDATE pieces piece
SET piece.title = '합창곡 <Til Ole Bull>', piece.title_en = 'Til Ole Bull (To Ole Bull)',
    piece.type = 'song', piece.opus_number = 'EG 176',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 15686 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 15686 AND piece.composer_id = 117 AND piece.composition_year IS NULL;


-- EG 177 6개의 관현악 반주 가곡

UPDATE pieces piece
SET piece.title = '6개의 관현악 반주 가곡', piece.title_en = '6 Songs with Orchestra, EG 177',
    piece.type = 'album', piece.opus_number = 'EG 177',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1895, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13721 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1895
WHERE piece.id = 13721 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '솔베이그의 노래 (Solveigs sang)', part.name_en = 'No. 1 Solveigs sang (Solveig''s Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13721 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:c3b4421a-9e96-4f51-a40a-9a2a0f841c82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3b4421a-9e96-4f51-a40a-9a2a0f841c82', 1, NULL, '솔베이그의 노래 (Solveigs sang)', 'No. 1 Solveigs sang (Solveig''s Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13721 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3b4421a-9e96-4f51-a40a-9a2a0f841c82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '솔베이그의 자장가 (Solveigs vuggevise)', part.name_en = 'No. 2 Solveigs vuggevise (Solveig''s Cradle Song)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13721 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:8f83028b-c7ba-4dc7-8474-ebdbb76dfb41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f83028b-c7ba-4dc7-8474-ebdbb76dfb41', 2, NULL, '솔베이그의 자장가 (Solveigs vuggevise)', 'No. 2 Solveigs vuggevise (Solveig''s Cradle Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13721 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f83028b-c7ba-4dc7-8474-ebdbb76dfb41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '몬테 핀치오에서 (Fra Monte Pincio)', part.name_en = 'No. 3 Fra Monte Pincio (From Monte Pincio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13721 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:bfd18098-deb7-47b8-bf59-7dcc1bfcaf3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd18098-deb7-47b8-bf59-7dcc1bfcaf3c', 3, NULL, '몬테 핀치오에서 (Fra Monte Pincio)', 'No. 3 Fra Monte Pincio (From Monte Pincio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13721 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd18098-deb7-47b8-bf59-7dcc1bfcaf3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 15417 AND linked.composer_id = 117),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '백조 (En Svane)', part.name_en = 'No. 4 En Svane (A Swan)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13721 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:a2dbc004-2359-4306-85b7-3a16812bdc7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 15417 AND linked.composer_id = 117), 'musicbrainz:a2dbc004-2359-4306-85b7-3a16812bdc7c', 4, NULL, '백조 (En Svane)', 'No. 4 En Svane (A Swan)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13721 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2dbc004-2359-4306-85b7-3a16812bdc7c'
);

UPDATE pieces piece
SET piece.title = '6개의 관현악 반주 가곡 중 "백조 (En Svane)"', piece.title_en = '6 Songs with Orchestra, EG 177: No. 4 En Svane (A Swan)', piece.editor_locked = 1
WHERE piece.id = 15417 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '봄 (Våren)', part.name_en = 'No. 5 Våren (The Last Spring)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13721 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:f3320602-c3fb-4e40-a324-7a08e687e4ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3320602-c3fb-4e40-a324-7a08e687e4ab', 5, NULL, '봄 (Våren)', 'No. 5 Våren (The Last Spring)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13721 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3320602-c3fb-4e40-a324-7a08e687e4ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Henrik Wergeland', part.name_en = 'No. 6 Henrik Wergeland',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13721 AND p.composer_id = 117 AND part.part_key = 'musicbrainz:106da89c-ec7f-4b4d-8244-7e4ad1cd864d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:106da89c-ec7f-4b4d-8244-7e4ad1cd864d', 6, NULL, 'Henrik Wergeland', 'No. 6 Henrik Wergeland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13721 AND p.composer_id = 117
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:106da89c-ec7f-4b4d-8244-7e4ad1cd864d'
);


-- EG 179 4성부 카논

UPDATE pieces piece
SET piece.title = '4성부 카논', piece.title_en = 'Canon a 4 voci',
    piece.type = 'song', piece.opus_number = 'EG 179',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 14405 AND piece.composer_id = 117
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 14405 AND piece.composer_id = 117 AND piece.composition_year IS NULL;

-- 카탈로그에 대응이 없는 seed 작품 174개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 117 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    13734, 13743, 13793, 13797, 13799, 13864, 13882, 13895, 13927, 13999, 14006, 14014, 14022, 14043, 14055, 14057, 14059, 14067, 14068, 14096,
    14098, 14107, 14118, 14121, 14122, 14125, 14147, 14158, 14163, 14180, 14200, 14236, 14239, 14240, 14296, 14312, 14319, 14322, 14324, 14336,
    14358, 14360, 14362, 14380, 14396, 14397, 14402, 14403, 14404, 14427, 14429, 14432, 14447, 14459, 14461, 14468, 14492, 14516, 14521, 14527,
    14540, 14551, 14552, 14556, 14559, 14566, 14587, 14589, 14605, 14612, 14616, 14631, 14645, 14652, 14654, 14660, 14674, 14678, 14682, 14729,
    14733, 14742, 14748, 14761, 14770, 14789, 14799, 14820, 14826, 14839, 14866, 14869, 14882, 14893, 14927, 14928, 14947, 14949, 14955, 14957,
    14968, 14969, 15018, 15031, 15069, 15077, 15082, 15091, 15103, 15108, 15118, 15136, 15171, 15180, 15182, 15197, 15198, 15200, 15217, 15235,
    15240, 15246, 15248, 15270, 15284, 15286, 15293, 15298, 15306, 15308, 15317, 15318, 15356, 15363, 15374, 15390, 15395, 15401, 15422, 15424,
    15427, 15431, 15439, 15448, 15449, 15450, 15478, 15491, 15493, 15494, 15503, 15509, 15538, 15545, 15549, 15553, 15556, 15564, 15567, 15569,
    15591, 15604, 15611, 15617, 15631, 15635, 15649, 15654, 15655, 15659, 15661, 15673, 15674, 15687
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
