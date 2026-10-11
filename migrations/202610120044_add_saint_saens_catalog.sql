-- 생상스 작품을 출판 단위로 다시 짠다(카탈로그: Op.·R). 작품 387개(묶음 21, 다악장 50, 낱곡 316),
-- 새 작품 201개, 기존 작품 186개(seed 제목 고침 199개), part 285개, 그 아래 209개,
-- 기존 part 고쳐 씀 0개, 기존 작품 연결 20개. 카탈로그에 대응이 없는 seed 83개는 목록에서 숨긴다.
--
-- 정한 것
--   오페라는 seed 가 안을 가리키는 작품(<삼손과 데릴라>·<헨리 8세>·<아스카니오>·<파리사티스>·<야만인들>)만 part 를 둔다.
--   교향곡 3번은 manual 254 가 자리이고 MBID 를 쥔 seed 604 는 숨긴다. 255(아리아 대목 작품)는 그대로.
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

-- R. 289 오페라 <은종>

UPDATE pieces piece
SET piece.title = '오페라 <은종>', piece.title_en = 'Le timbre d''argent (The Silver Bell)',
    piece.type = 'song', piece.opus_number = 'R. 289',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1727 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 1727 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 30 오페라 <노란 공주>

UPDATE pieces piece
SET piece.title = '오페라 <노란 공주>', piece.title_en = 'La princesse jaune (The Yellow Princess)',
    piece.type = 'song', piece.opus_number = 'Op. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1568 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 1568 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 47 오페라 <삼손과 데릴라>

UPDATE pieces piece
SET piece.title = '오페라 <삼손과 데릴라>', piece.title_en = 'Samson et Dalila',
    piece.type = 'album', piece.opus_number = 'Op. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2136 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 2136 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1막', part.name_en = 'Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5', 1, NULL, '1막', 'Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서주', part.name_en = 'Scene 1: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0509d800-04fe-4863-ba17-2aecf640914b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0509d800-04fe-4863-ba17-2aecf640914b', 1, NULL, '서주', 'Scene 1: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0509d800-04fe-4863-ba17-2aecf640914b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Dieu ! Dieu d’Israël !', part.name_en = 'Scene 1: « Dieu ! Dieu d’Israël ! » (Les Hébreux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:214cd959-066d-4e60-b457-08fc69b7becd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:214cd959-066d-4e60-b457-08fc69b7becd', 2, NULL, 'Dieu ! Dieu d’Israël !', 'Scene 1: « Dieu ! Dieu d’Israël ! » (Les Hébreux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:214cd959-066d-4e60-b457-08fc69b7becd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Un jour, de nous, tu détournas la face', part.name_en = 'Scene 1: « Un jour, de nous, tu détournas la face » (Les Hébreux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6a1c7541-33ca-4c04-8517-e9b5049a7f13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a1c7541-33ca-4c04-8517-e9b5049a7f13', 3, NULL, 'Un jour, de nous, tu détournas la face', 'Scene 1: « Un jour, de nous, tu détournas la face » (Les Hébreux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a1c7541-33ca-4c04-8517-e9b5049a7f13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Quoi ! Veux‐tu donc qu’à jamais on efface', part.name_en = 'Scene 1: « Quoi ! Veux‐tu donc qu’à jamais on efface » (Les Hébreux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2c42992b-df46-438a-875d-894a5740ae70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c42992b-df46-438a-875d-894a5740ae70', 4, NULL, 'Quoi ! Veux‐tu donc qu’à jamais on efface', 'Scene 1: « Quoi ! Veux‐tu donc qu’à jamais on efface » (Les Hébreux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c42992b-df46-438a-875d-894a5740ae70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Arrêtez, ô mes frères', part.name_en = 'Scene 1: « Arrêtez, ô mes frères » (Samson, les Hébreux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:01d3475d-ade1-4376-9946-dff0a362dbd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:01d3475d-ade1-4376-9946-dff0a362dbd5', 5, NULL, 'Arrêtez, ô mes frères', 'Scene 1: « Arrêtez, ô mes frères » (Samson, les Hébreux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01d3475d-ade1-4376-9946-dff0a362dbd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'L’as‐tu donc oublié, celui dont la puissance', part.name_en = 'Scene 1: « L’as‐tu donc oublié, celui dont la puissance » (Samson, les Hébreux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a65724f8-b235-426b-8e14-2e8abe78c15a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a65724f8-b235-426b-8e14-2e8abe78c15a', 6, NULL, 'L’as‐tu donc oublié, celui dont la puissance', 'Scene 1: « L’as‐tu donc oublié, celui dont la puissance » (Samson, les Hébreux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a65724f8-b235-426b-8e14-2e8abe78c15a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Implorons à genoux', part.name_en = 'Scene 1: « Implorons à genoux » (Samson, les Hébreux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6084a0a8-65fd-4e76-90c3-bf1dc163462d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6084a0a8-65fd-4e76-90c3-bf1dc163462d', 7, NULL, 'Implorons à genoux', 'Scene 1: « Implorons à genoux » (Samson, les Hébreux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6084a0a8-65fd-4e76-90c3-bf1dc163462d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Qui donc élève ici la voix ?', part.name_en = 'Scene 2: « Qui donc élève ici la voix ? » (Abimélech, Samson, les Hébreux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3e15bab5-b96c-4883-bda2-010852174524' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e15bab5-b96c-4883-bda2-010852174524', 8, NULL, 'Qui donc élève ici la voix ?', 'Scene 2: « Qui donc élève ici la voix ? » (Abimélech, Samson, les Hébreux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e15bab5-b96c-4883-bda2-010852174524'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ce Dieu que votre voix', part.name_en = 'Scene 2: « Ce Dieu que votre voix » (Abimélech)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9aa166d6-20e9-4d00-9117-588f2e63aa67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9aa166d6-20e9-4d00-9117-588f2e63aa67', 9, NULL, 'Ce Dieu que votre voix', 'Scene 2: « Ce Dieu que votre voix » (Abimélech)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9aa166d6-20e9-4d00-9117-588f2e63aa67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'C’est toi que sa bouche invective', part.name_en = 'Scene 2: « C’est toi que sa bouche invective » (Samson, les Hébreux, Abimélech)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:29a5abdf-6067-4a8f-81d8-9fbebdefe226' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29a5abdf-6067-4a8f-81d8-9fbebdefe226', 10, NULL, 'C’est toi que sa bouche invective', 'Scene 2: « C’est toi que sa bouche invective » (Samson, les Hébreux, Abimélech)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29a5abdf-6067-4a8f-81d8-9fbebdefe226'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Israel ! Romps ta chaîne !', part.name_en = 'Scene 2: « Israel ! Romps ta chaîne ! » (Samson, les Hébreux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:368bfe4e-85d4-45b1-94bf-2d312600cbdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:368bfe4e-85d4-45b1-94bf-2d312600cbdd', 11, NULL, 'Israel ! Romps ta chaîne !', 'Scene 2: « Israel ! Romps ta chaîne ! » (Samson, les Hébreux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:368bfe4e-85d4-45b1-94bf-2d312600cbdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Que vois‐je ? Abimélech', part.name_en = 'Scene 3: « Que vois‐je ? Abimélech » (Le grand prêtre, premier Philistin, deuxième Philistin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c7719409-b6c7-4847-939b-fa065c632353' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7719409-b6c7-4847-939b-fa065c632353', 12, NULL, 'Que vois‐je ? Abimélech', 'Scene 3: « Que vois‐je ? Abimélech » (Le grand prêtre, premier Philistin, deuxième Philistin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7719409-b6c7-4847-939b-fa065c632353'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Seigneur ! La troupe furieuse … Maudite à jamais soit ta race', part.name_en = 'Scene 4: « Seigneur ! La troupe furieuse » … « Maudite à jamais soit ta race » (Messager, deux Philistins, le grand prêtre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:bba8e2b5-c2c2-42a8-917a-5019f3d7af0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bba8e2b5-c2c2-42a8-917a-5019f3d7af0c', 13, NULL, 'Seigneur ! La troupe furieuse … Maudite à jamais soit ta race', 'Scene 4: « Seigneur ! La troupe furieuse » … « Maudite à jamais soit ta race » (Messager, deux Philistins, le grand prêtre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba8e2b5-c2c2-42a8-917a-5019f3d7af0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '해돋이', part.name_en = 'Scene 5: Lever du jour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3bad41f2-a0bb-433c-8664-84d96d7761eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bad41f2-a0bb-433c-8664-84d96d7761eb', 14, NULL, '해돋이', 'Scene 5: Lever du jour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bad41f2-a0bb-433c-8664-84d96d7761eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Hymne de joie, hymne de délivrance', part.name_en = 'Scene 5: « Hymne de joie, hymne de délivrance » (Les vieillards hébreux, un vieillard hébreu)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c72ebd7e-51b6-4229-8fc4-1533b5991827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c72ebd7e-51b6-4229-8fc4-1533b5991827', 15, NULL, 'Hymne de joie, hymne de délivrance', 'Scene 5: « Hymne de joie, hymne de délivrance » (Les vieillards hébreux, un vieillard hébreu)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c72ebd7e-51b6-4229-8fc4-1533b5991827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Voici le printemps', part.name_en = 'Scene 6: « Voici le printemps » (Les Philistins)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3b178ea3-08d0-4f4f-8f01-10b417682876' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b178ea3-08d0-4f4f-8f01-10b417682876', 16, NULL, 'Voici le printemps', 'Scene 6: « Voici le printemps » (Les Philistins)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b178ea3-08d0-4f4f-8f01-10b417682876'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Je viens célébrer la victoire', part.name_en = 'Scene 6: « Je viens célébrer la victoire » (Dalila, Samson, un vieillard hébreu)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6c350392-0399-43a7-b051-acc1c64527ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c350392-0399-43a7-b051-acc1c64527ee', 17, NULL, 'Je viens célébrer la victoire', 'Scene 6: « Je viens célébrer la victoire » (Dalila, Samson, un vieillard hébreu)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c350392-0399-43a7-b051-acc1c64527ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '다곤 여사제들의 춤', part.name_en = 'Scene 6: Danse des prêtresses de Dagon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1e059b56-5672-40f5-83bb-07b6ce59f0bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e059b56-5672-40f5-83bb-07b6ce59f0bf', 18, NULL, '다곤 여사제들의 춤', 'Scene 6: Danse des prêtresses de Dagon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e059b56-5672-40f5-83bb-07b6ce59f0bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Printemps qui commence', part.name_en = 'Scene 6: « Printemps qui commence » (Dalila, un vieillard hébreu)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e5c307c8-1a5e-376f-85cc-395e480267ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e5c307c8-1a5e-376f-85cc-395e480267ef', 19, NULL, 'Printemps qui commence', 'Scene 6: « Printemps qui commence » (Dalila, un vieillard hébreu)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5c307c8-1a5e-376f-85cc-395e480267ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'L’esprit du mal a conduit cette femme', part.name_en = 'Scene 6: « L’esprit du mal a conduit cette femme » (Un vieillard hébreu)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7c48b486-a841-49c0-8357-f04ff0d01e5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c48b486-a841-49c0-8357-f04ff0d01e5a', 20, NULL, 'L’esprit du mal a conduit cette femme', 'Scene 6: « L’esprit du mal a conduit cette femme » (Un vieillard hébreu)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24850bd5-fbd3-457b-b14a-c18d330787c5'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c48b486-a841-49c0-8357-f04ff0d01e5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2막', part.name_en = 'Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1', 2, NULL, '2막', 'Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:04cfdb51-9ead-462c-b1d3-5a37d7249b19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04cfdb51-9ead-462c-b1d3-5a37d7249b19', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04cfdb51-9ead-462c-b1d3-5a37d7249b19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2398 AND linked.composer_id = 60),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Samson, recherchant ma présence … Amour, viens aider ma faiblesse !', part.name_en = 'Scene 1: « Samson, recherchant ma présence … Amour, viens aider ma faiblesse ! » (Dalila)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8fd957cf-8114-4c06-9079-c2186026060a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 2398 AND linked.composer_id = 60), 'musicbrainz:8fd957cf-8114-4c06-9079-c2186026060a', 2, NULL, 'Samson, recherchant ma présence … Amour, viens aider ma faiblesse !', 'Scene 1: « Samson, recherchant ma présence … Amour, viens aider ma faiblesse ! » (Dalila)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fd957cf-8114-4c06-9079-c2186026060a'
);

UPDATE pieces piece
SET piece.title = '오페라 <삼손과 데릴라> 2막 중 "Samson, recherchant ma présence … Amour, viens aider ma faiblesse !"', piece.title_en = 'Samson et Dalila, Act II: Scene 1: « Samson, recherchant ma présence … Amour, viens aider ma faiblesse ! » (Dalila)', piece.editor_locked = 1
WHERE piece.id = 2398 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'J’ai gravi la montagne', part.name_en = 'Scene 2: « J’ai gravi la montagne » (Le grand prêtre, Dalila)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:da9719ab-b4cd-4f57-a650-7d15ca9fb6a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da9719ab-b4cd-4f57-a650-7d15ca9fb6a0', 3, NULL, 'J’ai gravi la montagne', 'Scene 2: « J’ai gravi la montagne » (Le grand prêtre, Dalila)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da9719ab-b4cd-4f57-a650-7d15ca9fb6a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'À tes genoux sa force un jour l’abondonna', part.name_en = 'Scene 2: « À tes genoux sa force un jour l’abondonna » (Le grand prêtre, Dalila)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a97b1f55-c0cc-48be-bcc5-77bc1d031b71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a97b1f55-c0cc-48be-bcc5-77bc1d031b71', 4, NULL, 'À tes genoux sa force un jour l’abondonna', 'Scene 2: « À tes genoux sa force un jour l’abondonna » (Le grand prêtre, Dalila)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a97b1f55-c0cc-48be-bcc5-77bc1d031b71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Qu’importe à Dalila ton or ?', part.name_en = 'Scene 2: « Qu’importe à Dalila ton or ? » (Dalila, le grand prêtre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b31ce07c-d99c-4fa7-bb08-621668480cec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b31ce07c-d99c-4fa7-bb08-621668480cec', 5, NULL, 'Qu’importe à Dalila ton or ?', 'Scene 2: « Qu’importe à Dalila ton or ? » (Dalila, le grand prêtre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b31ce07c-d99c-4fa7-bb08-621668480cec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Mais sur son cœur déjà n’aurais‐tu pas en vain', part.name_en = 'Scene 2: « Mais sur son cœur déjà n’aurais‐tu pas en vain » (Le grand prêtre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:37e71bd1-6e8f-4e98-bba5-0092ff7a7fbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37e71bd1-6e8f-4e98-bba5-0092ff7a7fbc', 6, NULL, 'Mais sur son cœur déjà n’aurais‐tu pas en vain', 'Scene 2: « Mais sur son cœur déjà n’aurais‐tu pas en vain » (Le grand prêtre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37e71bd1-6e8f-4e98-bba5-0092ff7a7fbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Il faut, pour assouvir ma haine', part.name_en = 'Scene 2: « Il faut, pour assouvir ma haine » (Dalila, le grand prêtre)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4a229513-e228-415c-b693-4a02919a9ab4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a229513-e228-415c-b693-4a02919a9ab4', 7, NULL, 'Il faut, pour assouvir ma haine', 'Scene 2: « Il faut, pour assouvir ma haine » (Dalila, le grand prêtre)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a229513-e228-415c-b693-4a02919a9ab4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Samson, me disais‐tu, dans ces lieux doit se rendre ? … Se pourrait‐il que sur son cœur', part.name_en = 'Scene 2: « Samson, me disais‐tu, dans ces lieux doit se rendre ? » … « Se pourrait‐il que sur son cœur » (Le grand prêtre, Dalila)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:40676525-139e-4fad-85ce-cc45d7f1d6e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40676525-139e-4fad-85ce-cc45d7f1d6e9', 8, NULL, 'Samson, me disais‐tu, dans ces lieux doit se rendre ? … Se pourrait‐il que sur son cœur', 'Scene 2: « Samson, me disais‐tu, dans ces lieux doit se rendre ? » … « Se pourrait‐il que sur son cœur » (Le grand prêtre, Dalila)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40676525-139e-4fad-85ce-cc45d7f1d6e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'En ces lieux', part.name_en = 'Scene 3: « En ces lieux » (Samson, Dalila)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:be393d55-d7c9-4701-8c38-cdb5bb3f066e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be393d55-d7c9-4701-8c38-cdb5bb3f066e', 9, NULL, 'En ces lieux', 'Scene 3: « En ces lieux » (Samson, Dalila)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be393d55-d7c9-4701-8c38-cdb5bb3f066e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'C’est toi, c’est toi, mon bien‐aimé !', part.name_en = 'Scene 3: « C’est toi, c’est toi, mon bien‐aimé ! » (Dalila, Samson)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6cefa164-bc0b-4406-ab15-2d21a9e4ad2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6cefa164-bc0b-4406-ab15-2d21a9e4ad2e', 10, NULL, 'C’est toi, c’est toi, mon bien‐aimé !', 'Scene 3: « C’est toi, c’est toi, mon bien‐aimé ! » (Dalila, Samson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cefa164-bc0b-4406-ab15-2d21a9e4ad2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'D’Israël renaît l’espérance', part.name_en = 'Scene 3: « D’Israël renaît l’espérance » (Samson)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:dd68e76b-5173-4ae0-88b8-61616fcd4b35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd68e76b-5173-4ae0-88b8-61616fcd4b35', 11, NULL, 'D’Israël renaît l’espérance', 'Scene 3: « D’Israël renaît l’espérance » (Samson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd68e76b-5173-4ae0-88b8-61616fcd4b35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Qu’importe à mon cœur désolé', part.name_en = 'Scene 3: « Qu’importe à mon cœur désolé » (Dalila, Samson)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f9cd8481-b743-4812-8e91-9243cf4068e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9cd8481-b743-4812-8e91-9243cf4068e7', 12, NULL, 'Qu’importe à mon cœur désolé', 'Scene 3: « Qu’importe à mon cœur désolé » (Dalila, Samson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9cd8481-b743-4812-8e91-9243cf4068e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Un dieu plus puissant que le tien', part.name_en = 'Scene 3: « Un dieu plus puissant que le tien » (Dalila, Samson)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ea8d1c4a-8839-4c95-8707-a2b32a44bf11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea8d1c4a-8839-4c95-8707-a2b32a44bf11', 13, NULL, 'Un dieu plus puissant que le tien', 'Scene 3: « Un dieu plus puissant que le tien » (Dalila, Samson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea8d1c4a-8839-4c95-8707-a2b32a44bf11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 961 AND linked.composer_id = 60),
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '그대 음성에 내 마음 열리고 (Mon cœur s’ouvre à ta voix)', part.name_en = 'Scene 3: « Mon cœur s’ouvre à ta voix » (Dalila)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:460c7f4f-9193-34eb-b3e4-096d751c89d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 961 AND linked.composer_id = 60), 'musicbrainz:460c7f4f-9193-34eb-b3e4-096d751c89d9', 14, NULL, '그대 음성에 내 마음 열리고 (Mon cœur s’ouvre à ta voix)', 'Scene 3: « Mon cœur s’ouvre à ta voix » (Dalila)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:460c7f4f-9193-34eb-b3e4-096d751c89d9'
);

UPDATE pieces piece
SET piece.title = '오페라 <삼손과 데릴라> 2막 중 "그대 음성에 내 마음 열리고 (Mon cœur s’ouvre à ta voix)"', piece.title_en = 'Samson et Dalila, Act II: Scene 3: « Mon cœur s’ouvre à ta voix » (Dalila)', piece.editor_locked = 1
WHERE piece.id = 961 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Mais ! Non ! Que dis-je ? Hélas ! La triste Dalila', part.name_en = 'Scene 3: « Mais ! Non ! Que dis-je ? Hélas ! La triste Dalila » (Dalila, Samson)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:63f81d2c-9e30-467d-a501-a9a8d7cee6f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63f81d2c-9e30-467d-a501-a9a8d7cee6f4', 15, NULL, 'Mais ! Non ! Que dis-je ? Hélas ! La triste Dalila', 'Scene 3: « Mais ! Non ! Que dis-je ? Hélas ! La triste Dalila » (Dalila, Samson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63f81d2c-9e30-467d-a501-a9a8d7cee6f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'À moi ! Philistins ! À moi ! … Trahison !', part.name_en = 'Scene 3: « À moi ! Philistins ! À moi ! » … « Trahison ! » (Dalila, Samson)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:01dabd57-d15d-4f87-922e-801140fc5bf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:01dabd57-d15d-4f87-922e-801140fc5bf9', 16, NULL, 'À moi ! Philistins ! À moi ! … Trahison !', 'Scene 3: « À moi ! Philistins ! À moi ! » … « Trahison ! » (Dalila, Samson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bb2946a7-53a7-4e68-93e7-d6161711e9a1'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01dabd57-d15d-4f87-922e-801140fc5bf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3막', part.name_en = 'Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0', 3, NULL, '3막', 'Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서주', part.name_en = 'Scene 1: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b0ec68d9-995b-49a4-b2ba-ff708a24ad79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0ec68d9-995b-49a4-b2ba-ff708a24ad79', 1, NULL, '서주', 'Scene 1: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0ec68d9-995b-49a4-b2ba-ff708a24ad79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vois ma misère, hélas', part.name_en = 'Scene 1: « Vois ma misère, hélas » (Samson)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:df4a64c7-63cd-43ea-9f0f-e7430504c5b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df4a64c7-63cd-43ea-9f0f-e7430504c5b8', 2, NULL, 'Vois ma misère, hélas', 'Scene 1: « Vois ma misère, hélas » (Samson)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df4a64c7-63cd-43ea-9f0f-e7430504c5b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Hélas ! Israël dans les fers', part.name_en = 'Scene 1: « Hélas ! Israël dans les fers »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e06545dc-16fb-429a-8f81-4128208e9cf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e06545dc-16fb-429a-8f81-4128208e9cf8', 3, NULL, 'Hélas ! Israël dans les fers', 'Scene 1: « Hélas ! Israël dans les fers »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e06545dc-16fb-429a-8f81-4128208e9cf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Frères ! Votre chant douloureux', part.name_en = 'Scene 1: « Frères ! Votre chant douloureux »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5798f1f5-168c-4215-888b-0bfce4d42dae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5798f1f5-168c-4215-888b-0bfce4d42dae', 4, NULL, 'Frères ! Votre chant douloureux', 'Scene 1: « Frères ! Votre chant douloureux »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5798f1f5-168c-4215-888b-0bfce4d42dae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '간주곡', part.name_en = 'Scene 1: Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b7c11aa2-e190-4f40-8398-02852a0d8f62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b7c11aa2-e190-4f40-8398-02852a0d8f62', 5, NULL, '간주곡', 'Scene 1: Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7c11aa2-e190-4f40-8398-02852a0d8f62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '블레셋인들의 합창: L’aube qui blanchit déjà les coteaux', part.name_en = 'Scene 2: Chœur des Philistins « L’aube qui blanchit déjà les coteaux »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b25027b0-3714-4d5d-b2f7-5af90a9a58d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b25027b0-3714-4d5d-b2f7-5af90a9a58d6', 6, NULL, '블레셋인들의 합창: L’aube qui blanchit déjà les coteaux', 'Scene 2: Chœur des Philistins « L’aube qui blanchit déjà les coteaux »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b25027b0-3714-4d5d-b2f7-5af90a9a58d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '바카날', part.name_en = 'Scene 2: Bacchanale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6285e0b9-2d7e-392f-b614-f7cce79dd842' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6285e0b9-2d7e-392f-b614-f7cce79dd842', 7, NULL, '바카날', 'Scene 2: Bacchanale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6285e0b9-2d7e-392f-b614-f7cce79dd842'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Salut ! Salut au juge d’Israël', part.name_en = 'Scene 3: « Salut ! Salut au juge d’Israël »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8bb072fe-94ca-4ee5-83c3-721f93f97010' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8bb072fe-94ca-4ee5-83c3-721f93f97010', 8, NULL, 'Salut ! Salut au juge d’Israël', 'Scene 3: « Salut ! Salut au juge d’Israël »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb072fe-94ca-4ee5-83c3-721f93f97010'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'L’âme triste jusqu’à la mort', part.name_en = 'Scene 3: « L’âme triste jusqu’à la mort »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:09333550-b24d-4a3b-9a1e-5378faadd0fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09333550-b24d-4a3b-9a1e-5378faadd0fc', 9, NULL, 'L’âme triste jusqu’à la mort', 'Scene 3: « L’âme triste jusqu’à la mort »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09333550-b24d-4a3b-9a1e-5378faadd0fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Laisse‐moi prendre ta main', part.name_en = 'Scene 3: « Laisse‐moi prendre ta main » (Dalila, les Philistins)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b16bc1cd-1258-45fa-ad72-ec018369f02b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b16bc1cd-1258-45fa-ad72-ec018369f02b', 10, NULL, 'Laisse‐moi prendre ta main', 'Scene 3: « Laisse‐moi prendre ta main » (Dalila, les Philistins)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b16bc1cd-1258-45fa-ad72-ec018369f02b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Allons, Samson, divertis-nous', part.name_en = 'Scene 3: « Allons, Samson, divertis-nous »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0f8bde1a-2d62-400f-bde2-19abb480ed42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f8bde1a-2d62-400f-bde2-19abb480ed42', 11, NULL, 'Allons, Samson, divertis-nous', 'Scene 3: « Allons, Samson, divertis-nous »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f8bde1a-2d62-400f-bde2-19abb480ed42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Viens, Dalila, rendre grâce à nos dieux … Gloire à Dagon vainqueur !', part.name_en = 'Scene 3: « Viens, Dalila, rendre grâce à nos dieux … Gloire à Dagon vainqueur ! » (Le Grand Prêtre, Dalila, les Philistins)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:685d30a7-2b01-4400-9926-425049a4d399' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:685d30a7-2b01-4400-9926-425049a4d399', 12, NULL, 'Viens, Dalila, rendre grâce à nos dieux … Gloire à Dagon vainqueur !', 'Scene 3: « Viens, Dalila, rendre grâce à nos dieux … Gloire à Dagon vainqueur ! » (Le Grand Prêtre, Dalila, les Philistins)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:685d30a7-2b01-4400-9926-425049a4d399'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Gloire à Dagon', part.name_en = 'Scene 3: « Gloire à Dagon »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7a234e43-08c3-469f-821c-4e689d004327' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a234e43-08c3-469f-821c-4e689d004327', 13, NULL, 'Gloire à Dagon', 'Scene 3: « Gloire à Dagon »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a234e43-08c3-469f-821c-4e689d004327'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Dagon se révèle !', part.name_en = 'Scene 3: « Dagon se révèle ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c3caf57b-0a40-4b53-ba62-01892c49aff7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3caf57b-0a40-4b53-ba62-01892c49aff7', 14, NULL, 'Dagon se révèle !', 'Scene 3: « Dagon se révèle ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3caf57b-0a40-4b53-ba62-01892c49aff7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Pour que le sort soit favorable', part.name_en = 'Scene 3: « Pour que le sort soit favorable »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:aee4e459-b290-4629-9975-cdcc04001e57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aee4e459-b290-4629-9975-cdcc04001e57', 15, NULL, 'Pour que le sort soit favorable', 'Scene 3: « Pour que le sort soit favorable »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aee4e459-b290-4629-9975-cdcc04001e57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Guidez ses pas vers le milieu du temple', part.name_en = 'Scene 3: « Guidez ses pas vers le milieu du temple » (Le Grand Prêtre, Samson, les Philistins, Dalila)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a8bf3a0d-6088-4421-b702-6073caba4b81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8bf3a0d-6088-4421-b702-6073caba4b81', 16, NULL, 'Guidez ses pas vers le milieu du temple', 'Scene 3: « Guidez ses pas vers le milieu du temple » (Le Grand Prêtre, Samson, les Philistins, Dalila)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8bf3a0d-6088-4421-b702-6073caba4b81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Souviens‐toi de ton serviteur', part.name_en = 'Scene 3: « Souviens‐toi de ton serviteur »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2136 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6889f27d-7227-4e32-921b-53c9e390bcfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6889f27d-7227-4e32-921b-53c9e390bcfe', 17, NULL, 'Souviens‐toi de ton serviteur', 'Scene 3: « Souviens‐toi de ton serviteur »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c9fa2d22-f6b3-42c8-b062-8ad570bd6cf0'
WHERE p.id = 2136 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6889f27d-7227-4e32-921b-53c9e390bcfe'
);


-- R. 290 오페라 <에티엔 마르셀>

UPDATE pieces piece
SET piece.title = '오페라 <에티엔 마르셀>', piece.title_en = 'Étienne Marcel',
    piece.type = 'song', piece.opus_number = 'R. 290',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1879, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2674 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1879
WHERE piece.id = 2674 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- R. 291 오페라 <헨리 8세>

UPDATE pieces piece
SET piece.opus_number = 'R. 291'
WHERE piece.id = 495 AND piece.composer_id = 60
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 495 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1막', part.name_en = 'Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84', 1, NULL, '1막', 'Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:fe9d0f7d-25a5-4031-8eea-b5869972afe9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe9d0f7d-25a5-4031-8eea-b5869972afe9', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe9d0f7d-25a5-4031-8eea-b5869972afe9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Trop heureux, Don Gomez', part.name_en = 'Scène I: “Trop heureux, Don Gomez”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0ece6520-ed62-42df-bd24-f979bc73218e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ece6520-ed62-42df-bd24-f979bc73218e', 2, NULL, 'Trop heureux, Don Gomez', 'Scène I: “Trop heureux, Don Gomez”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ece6520-ed62-42df-bd24-f979bc73218e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mais, c’est du tribunal que la foule s’empresse!', part.name_en = 'Scène II: “Mais, c’est du tribunal que la foule s’empresse!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3d9328af-13d2-4036-bf4f-36a97aeada0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d9328af-13d2-4036-bf4f-36a97aeada0c', 3, NULL, 'Mais, c’est du tribunal que la foule s’empresse!', 'Scène II: “Mais, c’est du tribunal que la foule s’empresse!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d9328af-13d2-4036-bf4f-36a97aeada0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Daignez, Sire, accueillir ce lui qui m’accompagne', part.name_en = 'Scène III: “Daignez, Sire, accueillir ce lui qui m’accompagne”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a8cb652a-f331-4129-9942-ac515d63c21e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8cb652a-f331-4129-9942-ac515d63c21e', 4, NULL, 'Daignez, Sire, accueillir ce lui qui m’accompagne', 'Scène III: “Daignez, Sire, accueillir ce lui qui m’accompagne”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8cb652a-f331-4129-9942-ac515d63c21e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Donc, le Pape est hostile à ma secrete envie?', part.name_en = 'Scène IV: “Donc, le Pape est hostile à ma secrete envie?”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:829653af-7bba-4fff-8530-65685a0ca26c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:829653af-7bba-4fff-8530-65685a0ca26c', 5, NULL, 'Donc, le Pape est hostile à ma secrete envie?', 'Scène IV: “Donc, le Pape est hostile à ma secrete envie?”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:829653af-7bba-4fff-8530-65685a0ca26c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ô mon maître et Seigneur vous m’avez demandée', part.name_en = 'Scène V: “Ô mon maître et Seigneur vous m’avez demandée”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8c8d8cbc-5d41-4fca-9b80-09e704f56533' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c8d8cbc-5d41-4fca-9b80-09e704f56533', 6, NULL, 'Ô mon maître et Seigneur vous m’avez demandée', 'Scène V: “Ô mon maître et Seigneur vous m’avez demandée”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c8d8cbc-5d41-4fca-9b80-09e704f56533'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Don Gomez, juste ciel!', part.name_en = 'Scène VI: “Don Gomez, juste ciel!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e03cc74e-0f15-48ff-a4ac-24b8348c890c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e03cc74e-0f15-48ff-a4ac-24b8348c890c', 7, NULL, 'Don Gomez, juste ciel!', 'Scène VI: “Don Gomez, juste ciel!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c53d6bc0-04b6-4d7d-999c-daa80ce96e84'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e03cc74e-0f15-48ff-a4ac-24b8348c890c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2막', part.name_en = 'Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db', 2, NULL, '2막', 'Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '막간곡', part.name_en = 'Entracte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:640198d4-bc44-4a1d-9abe-3e4d1f6ad799' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:640198d4-bc44-4a1d-9abe-3e4d1f6ad799', 1, NULL, '막간곡', 'Entracte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:640198d4-bc44-4a1d-9abe-3e4d1f6ad799'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Joyeux enfants qui ne savez encore', part.name_en = 'Scène I: “Joyeux enfants qui ne savez encore”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:cc359e4d-3035-4335-bd75-462254a4958b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc359e4d-3035-4335-bd75-462254a4958b', 2, NULL, 'Joyeux enfants qui ne savez encore', 'Scène I: “Joyeux enfants qui ne savez encore”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc359e4d-3035-4335-bd75-462254a4958b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Norfolk avait dit vrai', part.name_en = 'Scène II: “Norfolk avait dit vrai”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c9155cf3-717b-48bb-b496-9ac63094085a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9155cf3-717b-48bb-b496-9ac63094085a', 3, NULL, 'Norfolk avait dit vrai', 'Scène II: “Norfolk avait dit vrai”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9155cf3-717b-48bb-b496-9ac63094085a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'C’est elle!', part.name_en = 'Scène III: “C’est elle!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:28501188-2376-4c0b-a32b-7b0620906aba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28501188-2376-4c0b-a32b-7b0620906aba', 4, NULL, 'C’est elle!', 'Scène III: “C’est elle!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28501188-2376-4c0b-a32b-7b0620906aba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Elle vient', part.name_en = 'Scène IV: “Elle vient”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c9956e52-a99f-4e80-88a9-63cc09402691' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9956e52-a99f-4e80-88a9-63cc09402691', 5, NULL, 'Elle vient', 'Scène IV: “Elle vient”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9956e52-a99f-4e80-88a9-63cc09402691'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Vous ici monsieur, faisant la cour à la belle marquise', part.name_en = 'Scène V: “Vous ici monsieur, faisant la cour à la belle marquise”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:02315f52-0def-469b-aee0-8787c2686b1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02315f52-0def-469b-aee0-8787c2686b1a', 6, NULL, 'Vous ici monsieur, faisant la cour à la belle marquise', 'Scène V: “Vous ici monsieur, faisant la cour à la belle marquise”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02315f52-0def-469b-aee0-8787c2686b1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Chère Anne que j’adore', part.name_en = 'Scène VI: “Chère Anne que j’adore”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:00e046ef-4124-4c1a-afec-f68850d43ac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00e046ef-4124-4c1a-afec-f68850d43ac6', 7, NULL, 'Chère Anne que j’adore', 'Scène VI: “Chère Anne que j’adore”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00e046ef-4124-4c1a-afec-f68850d43ac6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Reine! Je serai Reine!', part.name_en = 'Scène VII: “Reine! Je serai Reine!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8be4da4e-0880-4b0b-95b9-9da35603b58f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8be4da4e-0880-4b0b-95b9-9da35603b58f', 8, NULL, 'Reine! Je serai Reine!', 'Scène VII: “Reine! Je serai Reine!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8be4da4e-0880-4b0b-95b9-9da35603b58f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Pauvre fille! Que Dieu t’arrête en ton chemin!', part.name_en = 'Scène VIII: “Pauvre fille! Que Dieu t’arrête en ton chemin!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3b7886f6-c272-4c0b-84a9-1d971659b766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b7886f6-c272-4c0b-84a9-1d971659b766', 9, NULL, 'Pauvre fille! Que Dieu t’arrête en ton chemin!', 'Scène VIII: “Pauvre fille! Que Dieu t’arrête en ton chemin!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b7886f6-c272-4c0b-84a9-1d971659b766'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Eh quoi! Madame! Vous ici', part.name_en = 'Scène IX: “Eh quoi! Madame! Vous ici”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ab7a6856-c5c2-443e-bd36-49a62c438077' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab7a6856-c5c2-443e-bd36-49a62c438077', 10, NULL, 'Eh quoi! Madame! Vous ici', 'Scène IX: “Eh quoi! Madame! Vous ici”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab7a6856-c5c2-443e-bd36-49a62c438077'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Anne triomphe!', part.name_en = 'Scène X: “Anne triomphe!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:484381e2-5b1f-4729-875b-333c26647872' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:484381e2-5b1f-4729-875b-333c26647872', 11, NULL, 'Anne triomphe!', 'Scène X: “Anne triomphe!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08182a96-abbc-4bf3-9d61-bdd5c346a0db'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:484381e2-5b1f-4729-875b-333c26647872'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '2막 발레 (Divertissement)', part.name_en = 'Act II: Ballet-Divertissement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9', 3, NULL, '2막 발레 (Divertissement)', 'Act II: Ballet-Divertissement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서주 – Entrée des clans', part.name_en = 'Introduction – Entrée des clans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f728a2ec-8088-4282-9bc6-ee6b82fe9e80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f728a2ec-8088-4282-9bc6-ee6b82fe9e80', 1, NULL, '서주 – Entrée des clans', 'Introduction – Entrée des clans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f728a2ec-8088-4282-9bc6-ee6b82fe9e80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Idylle écossaise', part.name_en = 'Idylle écossaise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d2d91db2-abf3-4649-bcb9-7a35d547a289' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2d91db2-abf3-4649-bcb9-7a35d547a289', 2, NULL, 'Idylle écossaise', 'Idylle écossaise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2d91db2-abf3-4649-bcb9-7a35d547a289'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La fête du houblon', part.name_en = 'La fête du houblon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e8b31d5a-1a91-4699-9954-9738ee4ad28a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8b31d5a-1a91-4699-9954-9738ee4ad28a', 3, NULL, 'La fête du houblon', 'La fête du houblon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8b31d5a-1a91-4699-9954-9738ee4ad28a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Danse de la gipsy', part.name_en = 'Danse de la gipsy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:dce5dbca-7d3b-4e7a-bfa3-87c7e198d64b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dce5dbca-7d3b-4e7a-bfa3-87c7e198d64b', 4, NULL, 'Danse de la gipsy', 'Danse de la gipsy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dce5dbca-7d3b-4e7a-bfa3-87c7e198d64b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pas de highlanders', part.name_en = 'Pas de highlanders',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5193e147-ce3e-47ab-aa81-7cae00b685d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5193e147-ce3e-47ab-aa81-7cae00b685d5', 5, NULL, 'Pas de highlanders', 'Pas de highlanders', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5193e147-ce3e-47ab-aa81-7cae00b685d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Scherzetto', part.name_en = 'Scherzetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:efd9e699-1dfc-4bd8-8796-df63a703610f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efd9e699-1dfc-4bd8-8796-df63a703610f', 6, NULL, 'Scherzetto', 'Scherzetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efd9e699-1dfc-4bd8-8796-df63a703610f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '사라방드', part.name_en = 'Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1cb61d90-d81b-4d2b-b2f3-7b61ac0abb94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1cb61d90-d81b-4d2b-b2f3-7b61ac0abb94', 7, NULL, '사라방드', 'Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cb61d90-d81b-4d2b-b2f3-7b61ac0abb94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '지그와 피날레', part.name_en = 'Gigue et final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:13878d04-f7a6-4065-b6d8-b4470786d2f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13878d04-f7a6-4065-b6d8-b4470786d2f5', 8, NULL, '지그와 피날레', 'Gigue et final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84260fcb-fc8f-48db-938c-1e4f15cc19e9'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13878d04-f7a6-4065-b6d8-b4470786d2f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '3막', part.name_en = 'Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b', 4, NULL, '3막', 'Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sire, le Légat du saint Père arrive au palais', part.name_en = 'Scène I: “Sire, le Légat du saint Père arrive au palais”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e346431a-8c8e-428b-8dcd-a4b1c01261ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e346431a-8c8e-428b-8dcd-a4b1c01261ca', 1, NULL, 'Sire, le Légat du saint Père arrive au palais', 'Scène I: “Sire, le Légat du saint Père arrive au palais”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e346431a-8c8e-428b-8dcd-a4b1c01261ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ah! Ce pouvoir de Rome', part.name_en = 'Scène II: “Ah! Ce pouvoir de Rome”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c5e1d1e5-7908-44e0-b8b9-62f35ccf146d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5e1d1e5-7908-44e0-b8b9-62f35ccf146d', 2, NULL, 'Ah! Ce pouvoir de Rome', 'Scène II: “Ah! Ce pouvoir de Rome”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e1d1e5-7908-44e0-b8b9-62f35ccf146d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ah! La voici quelle est belle!', part.name_en = 'Scène III: “Ah! La voici quelle est belle!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:42e41b1b-b332-4970-9dd2-2414ff731110' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42e41b1b-b332-4970-9dd2-2414ff731110', 3, NULL, 'Ah! La voici quelle est belle!', 'Scène III: “Ah! La voici quelle est belle!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42e41b1b-b332-4970-9dd2-2414ff731110'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Que me veut-on', part.name_en = 'Scène IV: “Que me veut-on”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:38ac6a63-f855-4f7a-96cf-b04fed1a93df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38ac6a63-f855-4f7a-96cf-b04fed1a93df', 4, NULL, 'Que me veut-on', 'Scène IV: “Que me veut-on”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38ac6a63-f855-4f7a-96cf-b04fed1a93df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sire!', part.name_en = 'Scène V: “Sire!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:29a16743-e4c1-48df-a2d4-3a6f577ee67f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29a16743-e4c1-48df-a2d4-3a6f577ee67f', 5, NULL, 'Sire!', 'Scène V: “Sire!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29a16743-e4c1-48df-a2d4-3a6f577ee67f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Monsieur, bien qu’à bon droit surprise', part.name_en = 'Scène VI: “Monsieur, bien qu’à bon droit surprise”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8bfb0212-4895-442f-97fa-02703dd515b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8bfb0212-4895-442f-97fa-02703dd515b3', 6, NULL, 'Monsieur, bien qu’à bon droit surprise', 'Scène VI: “Monsieur, bien qu’à bon droit surprise”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bfb0212-4895-442f-97fa-02703dd515b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Fatal orgueil des Rois dont le ciel veut la perte!', part.name_en = 'Scène VII: “Fatal orgueil des Rois dont le ciel veut la perte!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6d7ed5e4-fdec-4a0d-82c3-62fb7ce5426c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d7ed5e4-fdec-4a0d-82c3-62fb7ce5426c', 7, NULL, 'Fatal orgueil des Rois dont le ciel veut la perte!', 'Scène VII: “Fatal orgueil des Rois dont le ciel veut la perte!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7ed5e4-fdec-4a0d-82c3-62fb7ce5426c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '종교 회의 행진곡', part.name_en = 'Le synode: Marche du Synode',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:632f6aea-52bc-49cf-abf0-fc6539f0883c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:632f6aea-52bc-49cf-abf0-fc6539f0883c', 8, NULL, '종교 회의 행진곡', 'Le synode: Marche du Synode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:632f6aea-52bc-49cf-abf0-fc6539f0883c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Le synode est ouvert.', part.name_en = 'Le synode: “Le synode est ouvert.”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2bc20ab8-7d7b-40c6-ae76-d8696c3db3ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2bc20ab8-7d7b-40c6-ae76-d8696c3db3ba', 9, NULL, 'Le synode est ouvert.', 'Le synode: “Le synode est ouvert.”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bc20ab8-7d7b-40c6-ae76-d8696c3db3ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Ah! Je suis perdue!', part.name_en = 'Le synode: “Ah! Je suis perdue!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6bf0c8e4-fac3-41f0-81b3-6bb55f52223d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6bf0c8e4-fac3-41f0-81b3-6bb55f52223d', 10, NULL, 'Ah! Je suis perdue!', 'Le synode: “Ah! Je suis perdue!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bf0c8e4-fac3-41f0-81b3-6bb55f52223d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'La Cour va prononcer.', part.name_en = 'Le synode: “La Cour va prononcer.”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7050e4b5-0ddf-4bfd-ad44-7cc2c7a130b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7050e4b5-0ddf-4bfd-ad44-7cc2c7a130b2', 11, NULL, 'La Cour va prononcer.', 'Le synode: “La Cour va prononcer.”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7050e4b5-0ddf-4bfd-ad44-7cc2c7a130b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Au nom de Clément sept, pontife souverain', part.name_en = 'Le synode: “Au nom de Clément sept, pontife souverain”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5afc1966-2aa2-40a9-a7ea-76100890d22a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5afc1966-2aa2-40a9-a7ea-76100890d22a', 12, NULL, 'Au nom de Clément sept, pontife souverain', 'Le synode: “Au nom de Clément sept, pontife souverain”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2fc02f9f-4288-425e-8bd1-ee20b2ab169b'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5afc1966-2aa2-40a9-a7ea-76100890d22a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '4막', part.name_en = 'Act IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086', 5, NULL, '4막', 'Act IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Les appartements de la Reine Anne', part.name_en = 'Premier tableau: Les appartements de la Reine Anne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d412b6c4-9013-4e7c-bea6-c347e0d5ce60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d412b6c4-9013-4e7c-bea6-c347e0d5ce60', 1, NULL, 'Les appartements de la Reine Anne', 'Premier tableau: Les appartements de la Reine Anne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d412b6c4-9013-4e7c-bea6-c347e0d5ce60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Bravo! du divertissement', part.name_en = 'Premier tableau, Scène I: “Bravo! du divertissement”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d7fb2609-1a6e-4094-9929-b13e20f98a28' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7fb2609-1a6e-4094-9929-b13e20f98a28', 2, NULL, 'Bravo! du divertissement', 'Premier tableau, Scène I: “Bravo! du divertissement”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7fb2609-1a6e-4094-9929-b13e20f98a28'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Encore lui!', part.name_en = 'Premier tableau, Scène II: “Encore lui!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ceb138b0-432c-41f3-ae2c-055d22aa3373' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ceb138b0-432c-41f3-ae2c-055d22aa3373', 3, NULL, 'Encore lui!', 'Premier tableau, Scène II: “Encore lui!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceb138b0-432c-41f3-ae2c-055d22aa3373'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Vous venez pour me perdre ici!', part.name_en = 'Premier tableau, Scène III: “Vous venez pour me perdre ici!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d2de96ae-8b01-4be6-bb67-05b1ab7f2299' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2de96ae-8b01-4be6-bb67-05b1ab7f2299', 4, NULL, 'Vous venez pour me perdre ici!', 'Premier tableau, Scène III: “Vous venez pour me perdre ici!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2de96ae-8b01-4be6-bb67-05b1ab7f2299'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Chez la Reine Gomez!', part.name_en = 'Premier tableau, Scène IV: “Chez la Reine Gomez!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:24e7c6b5-2a60-4b79-9d73-2a0fb77ce237' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:24e7c6b5-2a60-4b79-9d73-2a0fb77ce237', 5, NULL, 'Chez la Reine Gomez!', 'Premier tableau, Scène IV: “Chez la Reine Gomez!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24e7c6b5-2a60-4b79-9d73-2a0fb77ce237'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Après ce qui s’était passé, monsieur, naguère', part.name_en = 'Premier tableau, Scène V: “Après ce qui s’était passé, monsieur, naguère”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e12a2294-b8cc-44f3-a32f-8f912fda1b3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e12a2294-b8cc-44f3-a32f-8f912fda1b3c', 6, NULL, 'Après ce qui s’était passé, monsieur, naguère', 'Premier tableau, Scène V: “Après ce qui s’était passé, monsieur, naguère”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e12a2294-b8cc-44f3-a32f-8f912fda1b3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La retraite de Catherine à Kimbolth', part.name_en = 'Deuxième tableau: La retraite de Catherine à Kimbolth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:665bb09b-79fb-448a-9e71-f581dbc541c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:665bb09b-79fb-448a-9e71-f581dbc541c3', 7, NULL, 'La retraite de Catherine à Kimbolth', 'Deuxième tableau: La retraite de Catherine à Kimbolth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:665bb09b-79fb-448a-9e71-f581dbc541c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1870 AND linked.composer_id = 60),
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Fêtons le jour où naquit notre Roi', part.name_en = 'Deuxième tableau, Scène I: “Fêtons le jour où naquit notre Roi”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7dad364d-8d74-447b-bca9-f49ee21c8ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 1870 AND linked.composer_id = 60), 'musicbrainz:7dad364d-8d74-447b-bca9-f49ee21c8ab8', 8, NULL, 'Fêtons le jour où naquit notre Roi', 'Deuxième tableau, Scène I: “Fêtons le jour où naquit notre Roi”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dad364d-8d74-447b-bca9-f49ee21c8ab8'
);

UPDATE pieces piece
SET piece.title = '오페라 <헨리 8세> 4막 중 "Fêtons le jour où naquit notre Roi"', piece.title_en = 'Henry VIII, Act IV: Deuxième tableau, Scène I: “Fêtons le jour où naquit notre Roi”', piece.editor_locked = 1
WHERE piece.id = 1870 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Entrez, vous qui souffrez sans doute', part.name_en = 'Deuxième tableau, Scène II: “Entrez, vous qui souffrez sans doute”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e7626c54-445a-402b-bae0-0bad9c57e146' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7626c54-445a-402b-bae0-0bad9c57e146', 9, NULL, 'Entrez, vous qui souffrez sans doute', 'Deuxième tableau, Scène II: “Entrez, vous qui souffrez sans doute”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7626c54-445a-402b-bae0-0bad9c57e146'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Vous ici, soit madame!', part.name_en = 'Deuxième tableau, Scène III: “Vous ici, soit madame!”',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 495 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2a6f39ec-d5d2-4cea-9053-b1bf2576f234' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a6f39ec-d5d2-4cea-9053-b1bf2576f234', 10, NULL, 'Vous ici, soit madame!', 'Deuxième tableau, Scène III: “Vous ici, soit madame!”', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d4cf4f83-e99d-44b9-bee6-c6156a293086'
WHERE p.id = 495 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a6f39ec-d5d2-4cea-9053-b1bf2576f234'
);


-- R. 292 오페라 <프로세르핀>

UPDATE pieces piece
SET piece.title = '오페라 <프로세르핀>', piece.title_en = 'Proserpine',
    piece.type = 'song', piece.opus_number = 'R. 292',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2529 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 2529 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- R. 293 오페라 <아스카니오>

UPDATE pieces piece
SET piece.title = '오페라 <아스카니오>', piece.title_en = 'Ascanio',
    piece.type = 'album', piece.opus_number = 'R. 293',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2028 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 2028 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '1막', part.name_en = 'Act I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c', 1, NULL, '1막', 'Act I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Très bien!', part.name_en = 'Premier Tableau, Scène 1: Très bien!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:565eae01-f45e-4762-a66c-fbd2222d2b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:565eae01-f45e-4762-a66c-fbd2222d2b21', 1, NULL, 'Très bien!', 'Premier Tableau, Scène 1: Très bien!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:565eae01-f45e-4762-a66c-fbd2222d2b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Reste, Ascanio!', part.name_en = 'Premier Tableau, Scène 2: Reste, Ascanio!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:51246651-eb61-41bf-bb14-1f49d05a9214' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:51246651-eb61-41bf-bb14-1f49d05a9214', 2, NULL, 'Reste, Ascanio!', 'Premier Tableau, Scène 2: Reste, Ascanio!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51246651-eb61-41bf-bb14-1f49d05a9214'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Si loin et si haut...', part.name_en = 'Premier Tableau, Scène 2: Si loin et si haut...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5fbeff84-9318-4370-9563-3625085c525d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5fbeff84-9318-4370-9563-3625085c525d', 3, NULL, 'Si loin et si haut...', 'Premier Tableau, Scène 2: Si loin et si haut...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fbeff84-9318-4370-9563-3625085c525d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Maître!', part.name_en = 'Premier Tableau, Scène 3: Maître!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d0d42046-9647-43ac-ae81-e872b1ce87c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0d42046-9647-43ac-ae81-e872b1ce87c0', 4, NULL, 'Maître!', 'Premier Tableau, Scène 3: Maître!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0d42046-9647-43ac-ae81-e872b1ce87c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Jaloux de tout!', part.name_en = 'Premier Tableau, Scène 3: Jaloux de tout!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4e5bb849-b5be-4687-9aed-45bd246d71bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e5bb849-b5be-4687-9aed-45bd246d71bf', 5, NULL, 'Jaloux de tout!', 'Premier Tableau, Scène 3: Jaloux de tout!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e5bb849-b5be-4687-9aed-45bd246d71bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allons! Souriez, chère belle!', part.name_en = 'Premier Tableau, Scène 3: Allons! Souriez, chère belle!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:901b46dc-c6db-4a4c-a733-62f4e03fbd2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:901b46dc-c6db-4a4c-a733-62f4e03fbd2b', 6, NULL, 'Allons! Souriez, chère belle!', 'Premier Tableau, Scène 3: Allons! Souriez, chère belle!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:901b46dc-c6db-4a4c-a733-62f4e03fbd2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Le Roi! Voici le Roi!', part.name_en = 'Premier Tableau, Scène 4: Le Roi! Voici le Roi!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:39d42b6e-1053-4f8f-8fcb-2738ffcd8efd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39d42b6e-1053-4f8f-8fcb-2738ffcd8efd', 7, NULL, 'Le Roi! Voici le Roi!', 'Premier Tableau, Scène 4: Le Roi! Voici le Roi!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39d42b6e-1053-4f8f-8fcb-2738ffcd8efd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Bonjour ! Benvenuto!', part.name_en = 'Premier Tableau, Scène 4: Bonjour ! Benvenuto!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:493700c3-016e-4fa1-8390-3a7b89f6c364' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:493700c3-016e-4fa1-8390-3a7b89f6c364', 8, NULL, 'Bonjour ! Benvenuto!', 'Premier Tableau, Scène 4: Bonjour ! Benvenuto!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:493700c3-016e-4fa1-8390-3a7b89f6c364'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ascanio!', part.name_en = 'Premier Tableau, Scène 4: Ascanio!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ca79da32-1a20-4ae6-8170-82fff043dd19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca79da32-1a20-4ae6-8170-82fff043dd19', 9, NULL, 'Ascanio!', 'Premier Tableau, Scène 4: Ascanio!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca79da32-1a20-4ae6-8170-82fff043dd19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Avant ce jour ai-je jamais aimé?', part.name_en = 'Premier Tableau, Scène 4: Avant ce jour ai-je jamais aimé?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7bf5b8cf-7653-435b-a935-f7e7bd777cfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7bf5b8cf-7653-435b-a935-f7e7bd777cfc', 10, NULL, 'Avant ce jour ai-je jamais aimé?', 'Premier Tableau, Scène 4: Avant ce jour ai-je jamais aimé?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bf5b8cf-7653-435b-a935-f7e7bd777cfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Voilà le pur chef-d''œuvre, ami!', part.name_en = 'Premier Tableau, Scène 4: Voilà le pur chef-d''œuvre, ami!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c399dae2-639d-4e5a-9e33-a917a8926b73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c399dae2-639d-4e5a-9e33-a917a8926b73', 11, NULL, 'Voilà le pur chef-d''œuvre, ami!', 'Premier Tableau, Scène 4: Voilà le pur chef-d''œuvre, ami!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c399dae2-639d-4e5a-9e33-a917a8926b73'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'J''attends l''Empereur Charles-Quint...', part.name_en = 'Premier Tableau, Scène 4: J''attends l''Empereur Charles-Quint...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:985ca12f-3406-4c28-8b1b-dc2e48474875' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:985ca12f-3406-4c28-8b1b-dc2e48474875', 12, NULL, 'J''attends l''Empereur Charles-Quint...', 'Premier Tableau, Scène 4: J''attends l''Empereur Charles-Quint...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:985ca12f-3406-4c28-8b1b-dc2e48474875'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Vous serez obéi, Sire!', part.name_en = 'Premier Tableau, Scène 4: Vous serez obéi, Sire!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:bb0144a5-93b2-441c-af2b-4868628dffc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb0144a5-93b2-441c-af2b-4868628dffc9', 13, NULL, 'Vous serez obéi, Sire!', 'Premier Tableau, Scène 4: Vous serez obéi, Sire!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb0144a5-93b2-441c-af2b-4868628dffc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Quand nous serons devenus goutteux', part.name_en = 'Deuxième Tableau, Scène 1: Quand nous serons devenus goutteux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1b4833dc-7ab5-49bf-adf2-10207b035f8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1b4833dc-7ab5-49bf-adf2-10207b035f8b', 14, NULL, 'Quand nous serons devenus goutteux', 'Deuxième Tableau, Scène 1: Quand nous serons devenus goutteux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b4833dc-7ab5-49bf-adf2-10207b035f8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Pardonnez-moi, mademoiselle', part.name_en = 'Deuxième Tableau, Scène 2: Pardonnez-moi, mademoiselle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:841b0501-dd46-42e7-a80b-b92a01e4cb8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:841b0501-dd46-42e7-a80b-b92a01e4cb8e', 15, NULL, 'Pardonnez-moi, mademoiselle', 'Deuxième Tableau, Scène 2: Pardonnez-moi, mademoiselle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:841b0501-dd46-42e7-a80b-b92a01e4cb8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'La charité, ma belle dame!', part.name_en = 'Deuxième Tableau, Scène 2: La charité, ma belle dame!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ee7af870-7a58-47ba-bbd2-f55e05731f29' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee7af870-7a58-47ba-bbd2-f55e05731f29', 16, NULL, 'La charité, ma belle dame!', 'Deuxième Tableau, Scène 2: La charité, ma belle dame!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee7af870-7a58-47ba-bbd2-f55e05731f29'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Allez pourtant, mes chers enfants', part.name_en = 'Deuxième Tableau, Scène 2: Allez pourtant, mes chers enfants',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:72b63e5c-7e56-46e4-961d-0d13f7ef0e37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72b63e5c-7e56-46e4-961d-0d13f7ef0e37', 17, NULL, 'Allez pourtant, mes chers enfants', 'Deuxième Tableau, Scène 2: Allez pourtant, mes chers enfants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72b63e5c-7e56-46e4-961d-0d13f7ef0e37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Ah! La plaisante audace!', part.name_en = 'Deuxième Tableau, Scène 3: Ah! La plaisante audace!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d9299252-098c-4785-821f-2f59cefde9e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9299252-098c-4785-821f-2f59cefde9e7', 18, NULL, 'Ah! La plaisante audace!', 'Deuxième Tableau, Scène 3: Ah! La plaisante audace!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9299252-098c-4785-821f-2f59cefde9e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Voilà l''envahisseur!', part.name_en = 'Deuxième Tableau, Scène 4: Voilà l''envahisseur!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:20db9df3-04d6-40e1-a3c6-71a02e572cfe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:20db9df3-04d6-40e1-a3c6-71a02e572cfe', 19, NULL, 'Voilà l''envahisseur!', 'Deuxième Tableau, Scène 4: Voilà l''envahisseur!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20db9df3-04d6-40e1-a3c6-71a02e572cfe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'C''est elle!', part.name_en = 'Deuxième Tableau, Scène 5: C''est elle!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:565028be-8a7b-460d-a540-7164f3e84bfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:565028be-8a7b-460d-a540-7164f3e84bfa', 20, NULL, 'C''est elle!', 'Deuxième Tableau, Scène 5: C''est elle!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:565028be-8a7b-460d-a540-7164f3e84bfa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Jeanne, je te l''ai dit...', part.name_en = 'Deuxième Tableau, Scène 6: Jeanne, je te l''ai dit...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9ab9def8-818b-4855-98ab-515aa80ea65b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ab9def8-818b-4855-98ab-515aa80ea65b', 21, NULL, 'Jeanne, je te l''ai dit...', 'Deuxième Tableau, Scène 6: Jeanne, je te l''ai dit...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ab9def8-818b-4855-98ab-515aa80ea65b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Il ne faut pas...', part.name_en = 'Deuxième Tableau, Scène 7: Il ne faut pas...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ed6c21ce-afb0-407a-8325-aadee0caea23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed6c21ce-afb0-407a-8325-aadee0caea23', 22, NULL, 'Il ne faut pas...', 'Deuxième Tableau, Scène 7: Il ne faut pas...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed6c21ce-afb0-407a-8325-aadee0caea23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Il est deux nobles cœurs', part.name_en = 'Deuxième Tableau, Scène 8: Il est deux nobles cœurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:097aeeea-42a1-45b2-8c35-6a69362b13c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:097aeeea-42a1-45b2-8c35-6a69362b13c2', 23, NULL, 'Il est deux nobles cœurs', 'Deuxième Tableau, Scène 8: Il est deux nobles cœurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:097aeeea-42a1-45b2-8c35-6a69362b13c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'La divine enfant!', part.name_en = 'Deuxième Tableau, Scène 9: La divine enfant!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9ccf1e11-2537-49c0-8ca6-37a30df60ec3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ccf1e11-2537-49c0-8ca6-37a30df60ec3', 24, NULL, 'La divine enfant!', 'Deuxième Tableau, Scène 9: La divine enfant!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ccf1e11-2537-49c0-8ca6-37a30df60ec3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Amis, bonjour!', part.name_en = 'Deuxième Tableau, Scène 10: Amis, bonjour!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:08f48e7b-09c1-495a-a4d4-3db87133267b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08f48e7b-09c1-495a-a4d4-3db87133267b', 25, NULL, 'Amis, bonjour!', 'Deuxième Tableau, Scène 10: Amis, bonjour!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f48e7b-09c1-495a-a4d4-3db87133267b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'D''Estourville! D''Estourville!', part.name_en = 'Deuxième Tableau, Scène 10: D''Estourville! D''Estourville!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:400e0b81-4be4-4528-8fd3-09db3545e2ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:400e0b81-4be4-4528-8fd3-09db3545e2ce', 26, NULL, 'D''Estourville! D''Estourville!', 'Deuxième Tableau, Scène 10: D''Estourville! D''Estourville!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a426f5aa-836b-46ec-bbd2-49a87e23442c'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:400e0b81-4be4-4528-8fd3-09db3545e2ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2막', part.name_en = 'Act II',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d', 2, NULL, '2막', 'Act II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Frappe! Cogne!', part.name_en = 'Troisième Tableau, Scène 1: Frappe! Cogne!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:fef13e3b-1508-4d5c-834e-c2a32ed8099f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fef13e3b-1508-4d5c-834e-c2a32ed8099f', 1, NULL, 'Frappe! Cogne!', 'Troisième Tableau, Scène 1: Frappe! Cogne!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fef13e3b-1508-4d5c-834e-c2a32ed8099f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La la la la... Fiorentinelle!', part.name_en = 'Troisième Tableau, Scène 1: La la la la... Fiorentinelle!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:37b972f8-ed58-4fe3-9499-4ad409ee3b7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37b972f8-ed58-4fe3-9499-4ad409ee3b7f', 2, NULL, 'La la la la... Fiorentinelle!', 'Troisième Tableau, Scène 1: La la la la... Fiorentinelle!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37b972f8-ed58-4fe3-9499-4ad409ee3b7f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pourquoi vous taisez-vous?', part.name_en = 'Troisième Tableau, Scène 1: Pourquoi vous taisez-vous?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b7a84758-422a-42de-98dc-e62f57cbe8cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b7a84758-422a-42de-98dc-e62f57cbe8cb', 3, NULL, 'Pourquoi vous taisez-vous?', 'Troisième Tableau, Scène 1: Pourquoi vous taisez-vous?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7a84758-422a-42de-98dc-e62f57cbe8cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'À l''ombre des noires tours...', part.name_en = 'Troisième Tableau, Scène 1: À l''ombre des noires tours...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6bdc8d91-e250-417e-9bc9-0808e0d82923' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6bdc8d91-e250-417e-9bc9-0808e0d82923', 4, NULL, 'À l''ombre des noires tours...', 'Troisième Tableau, Scène 1: À l''ombre des noires tours...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bdc8d91-e250-417e-9bc9-0808e0d82923'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'L''Empereur Charles-Quint, arrivé ce matin...', part.name_en = 'Troisième Tableau, Scène 2: L''Empereur Charles-Quint, arrivé ce matin...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:77b40c58-4f7d-45e8-9ecd-4c41a6082adc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:77b40c58-4f7d-45e8-9ecd-4c41a6082adc', 5, NULL, 'L''Empereur Charles-Quint, arrivé ce matin...', 'Troisième Tableau, Scène 2: L''Empereur Charles-Quint, arrivé ce matin...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77b40c58-4f7d-45e8-9ecd-4c41a6082adc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ah ! Le destin va-t-il réaliser mon rêve?', part.name_en = 'Troisième Tableau, Scène 3: Ah ! Le destin va-t-il réaliser mon rêve?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5942e58c-2d18-4af9-a94b-300514eacf8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5942e58c-2d18-4af9-a94b-300514eacf8a', 6, NULL, 'Ah ! Le destin va-t-il réaliser mon rêve?', 'Troisième Tableau, Scène 3: Ah ! Le destin va-t-il réaliser mon rêve?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5942e58c-2d18-4af9-a94b-300514eacf8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Mon cœur est sous la pierre...', part.name_en = 'Troisième Tableau, Scène 3: Mon cœur est sous la pierre...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3ad9c774-de0b-4cc2-b5a2-90c243c0cbea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ad9c774-de0b-4cc2-b5a2-90c243c0cbea', 7, NULL, 'Mon cœur est sous la pierre...', 'Troisième Tableau, Scène 3: Mon cœur est sous la pierre...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad9c774-de0b-4cc2-b5a2-90c243c0cbea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'O douce Hébé...', part.name_en = 'Troisième Tableau, Scène 3: O douce Hébé...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:caae1fa8-9c36-4957-893b-dcb86a3ad4b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:caae1fa8-9c36-4957-893b-dcb86a3ad4b1', 8, NULL, 'O douce Hébé...', 'Troisième Tableau, Scène 3: O douce Hébé...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caae1fa8-9c36-4957-893b-dcb86a3ad4b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Qui vient?', part.name_en = 'Troisième Tableau, Scène 4: Qui vient?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2f707705-3a93-4655-94e3-7dc240ea35df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f707705-3a93-4655-94e3-7dc240ea35df', 9, NULL, 'Qui vient?', 'Troisième Tableau, Scène 4: Qui vient?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f707705-3a93-4655-94e3-7dc240ea35df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Pour avoir connu trop d''ivresses...', part.name_en = 'Troisième Tableau, Scène 4: Pour avoir connu trop d''ivresses...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:dc4a2cb8-0a99-4768-ba49-84fdf00990b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc4a2cb8-0a99-4768-ba49-84fdf00990b9', 10, NULL, 'Pour avoir connu trop d''ivresses...', 'Troisième Tableau, Scène 4: Pour avoir connu trop d''ivresses...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc4a2cb8-0a99-4768-ba49-84fdf00990b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Un message du Roi', part.name_en = 'Troisième Tableau, Scène 5: Un message du Roi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:aeb28999-4414-4060-b2cf-f7598afbea20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aeb28999-4414-4060-b2cf-f7598afbea20', 11, NULL, 'Un message du Roi', 'Troisième Tableau, Scène 5: Un message du Roi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aeb28999-4414-4060-b2cf-f7598afbea20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'O beauté, j''ai compris ta puissance!', part.name_en = 'Troisième Tableau, Scène 5: O beauté, j''ai compris ta puissance!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c9998e43-483b-4388-b07a-85046715f390' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9998e43-483b-4388-b07a-85046715f390', 12, NULL, 'O beauté, j''ai compris ta puissance!', 'Troisième Tableau, Scène 5: O beauté, j''ai compris ta puissance!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9998e43-483b-4388-b07a-85046715f390'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Qu''est-ce donc?', part.name_en = 'Troisième Tableau, Scène 6: Qu''est-ce donc?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:df527f00-2ca3-42d4-ae28-96042d8b43de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df527f00-2ca3-42d4-ae28-96042d8b43de', 13, NULL, 'Qu''est-ce donc?', 'Troisième Tableau, Scène 6: Qu''est-ce donc?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df527f00-2ca3-42d4-ae28-96042d8b43de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Colombe!', part.name_en = 'Troisième Tableau, Scène 6: Colombe!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:aa950126-c7df-4e88-9b66-0cc929b75742' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa950126-c7df-4e88-9b66-0cc929b75742', 14, NULL, 'Colombe!', 'Troisième Tableau, Scène 6: Colombe!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa950126-c7df-4e88-9b66-0cc929b75742'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Je suis votre féal!', part.name_en = 'Quatrième Tableau, Scène 1: Je suis votre féal!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a5f0d12b-cceb-40d2-bbea-c9ee5db2bb23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a5f0d12b-cceb-40d2-bbea-c9ee5db2bb23', 15, NULL, 'Je suis votre féal!', 'Quatrième Tableau, Scène 1: Je suis votre féal!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5f0d12b-cceb-40d2-bbea-c9ee5db2bb23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Adieu, beauté, ma mie, ma vie!', part.name_en = 'Quatrième Tableau, Scène 1: Adieu, beauté, ma mie, ma vie!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9c8429e2-5bee-4eb6-ba5f-f78251b48c9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c8429e2-5bee-4eb6-ba5f-f78251b48c9d', 16, NULL, 'Adieu, beauté, ma mie, ma vie!', 'Quatrième Tableau, Scène 1: Adieu, beauté, ma mie, ma vie!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c8429e2-5bee-4eb6-ba5f-f78251b48c9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Quelle folle chimère...', part.name_en = 'Quatrième Tableau, Scène 2: Quelle folle chimère...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5819c60e-2a2e-48f6-b0d7-53a80fb7ab4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5819c60e-2a2e-48f6-b0d7-53a80fb7ab4a', 17, NULL, 'Quelle folle chimère...', 'Quatrième Tableau, Scène 2: Quelle folle chimère...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5819c60e-2a2e-48f6-b0d7-53a80fb7ab4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Vous? Ascanio!', part.name_en = 'Quatrième Tableau, Scène 3: Vous? Ascanio!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:38f22031-eb5e-44d7-855f-39f3d2337c9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38f22031-eb5e-44d7-855f-39f3d2337c9e', 18, NULL, 'Vous? Ascanio!', 'Quatrième Tableau, Scène 3: Vous? Ascanio!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38f22031-eb5e-44d7-855f-39f3d2337c9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'J''ai fait un rêve enchanteur', part.name_en = 'Quatrième Tableau, Scène 3: J''ai fait un rêve enchanteur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ebe60ef2-0cff-4a5a-86a6-cc72d0d4307d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ebe60ef2-0cff-4a5a-86a6-cc72d0d4307d', 19, NULL, 'J''ai fait un rêve enchanteur', 'Quatrième Tableau, Scène 3: J''ai fait un rêve enchanteur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebe60ef2-0cff-4a5a-86a6-cc72d0d4307d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Quand l''amour vous protège', part.name_en = 'Quatrième Tableau, Scène 3: Quand l''amour vous protège',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e639618b-278f-477c-8ea9-71612c29a398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e639618b-278f-477c-8ea9-71612c29a398', 20, NULL, 'Quand l''amour vous protège', 'Quatrième Tableau, Scène 3: Quand l''amour vous protège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e639618b-278f-477c-8ea9-71612c29a398'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Ah ! Vous voilà venue à propos', part.name_en = 'Quatrième Tableau, Scène 4: Ah ! Vous voilà venue à propos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e491f148-1c83-42ae-9bbc-f72eb066f306' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e491f148-1c83-42ae-9bbc-f72eb066f306', 21, NULL, 'Ah ! Vous voilà venue à propos', 'Quatrième Tableau, Scène 4: Ah ! Vous voilà venue à propos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e491f148-1c83-42ae-9bbc-f72eb066f306'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2177 AND linked.composer_id = 60),
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Ah! Me taire... je ne le puis', part.name_en = 'Quatrième Tableau, Scène 4: Ah! Me taire... je ne le puis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:feebd3dd-386c-4115-9a1e-7ab52b5987ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 2177 AND linked.composer_id = 60), 'musicbrainz:feebd3dd-386c-4115-9a1e-7ab52b5987ef', 22, NULL, 'Ah! Me taire... je ne le puis', 'Quatrième Tableau, Scène 4: Ah! Me taire... je ne le puis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feebd3dd-386c-4115-9a1e-7ab52b5987ef'
);

UPDATE pieces piece
SET piece.title = '오페라 <아스카니오> 2막 중 "Ah! Me taire... je ne le puis"', piece.title_en = 'Ascanio, Act II: Quatrième Tableau, Scène 4: Ah! Me taire... je ne le puis', piece.editor_locked = 1
WHERE piece.id = 2177 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Que mon âme ravie...', part.name_en = 'Quatrième Tableau, Scène 4: Que mon âme ravie...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:40a1b939-37cd-4bd8-bebb-f8c2944263b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40a1b939-37cd-4bd8-bebb-f8c2944263b6', 23, NULL, 'Que mon âme ravie...', 'Quatrième Tableau, Scène 4: Que mon âme ravie...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c89a2173-9338-4e1a-a9e9-c603e7c3c66d'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40a1b939-37cd-4bd8-bebb-f8c2944263b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3막', part.name_en = 'Act III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd', 3, NULL, '3막', 'Act III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gloire au Roi François!', part.name_en = 'Cinquième Tableau: Gloire au Roi François!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3cc22951-d6fb-491b-bfe2-d663b9aa487c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3cc22951-d6fb-491b-bfe2-d663b9aa487c', 1, NULL, 'Gloire au Roi François!', 'Cinquième Tableau: Gloire au Roi François!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cc22951-d6fb-491b-bfe2-d663b9aa487c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pardonnez-moi, mon frère', part.name_en = 'Cinquième Tableau: Pardonnez-moi, mon frère',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:49af9741-393d-45aa-ad05-aaa163caf7fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49af9741-393d-45aa-ad05-aaa163caf7fc', 2, NULL, 'Pardonnez-moi, mon frère', 'Cinquième Tableau: Pardonnez-moi, mon frère', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49af9741-393d-45aa-ad05-aaa163caf7fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sire, écoutez-moi!', part.name_en = 'Cinquième Tableau: Sire, écoutez-moi!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e21fa87f-9064-456c-b85a-23e2a7ad5b52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e21fa87f-9064-456c-b85a-23e2a7ad5b52', 3, NULL, 'Sire, écoutez-moi!', 'Cinquième Tableau: Sire, écoutez-moi!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e21fa87f-9064-456c-b85a-23e2a7ad5b52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Va! La revanche est prête', part.name_en = 'Cinquième Tableau: Va! La revanche est prête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e218d8eb-3f96-404e-80f1-ed2b6712ee9f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e218d8eb-3f96-404e-80f1-ed2b6712ee9f', 4, NULL, 'Va! La revanche est prête', 'Cinquième Tableau: Va! La revanche est prête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e218d8eb-3f96-404e-80f1-ed2b6712ee9f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allez, mon frère, allez', part.name_en = 'Cinquième Tableau: Allez, mon frère, allez',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7c60c89b-9e8d-4b84-92c8-f5353302c790' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7c60c89b-9e8d-4b84-92c8-f5353302c790', 5, NULL, 'Allez, mon frère, allez', 'Cinquième Tableau: Allez, mon frère, allez', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c60c89b-9e8d-4b84-92c8-f5353302c790'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Gloire au Roi François!', part.name_en = 'Cinquième Tableau: Gloire au Roi François!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b1137659-468a-4ae3-a370-faa18a6de7bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1137659-468a-4ae3-a370-faa18a6de7bd', 6, NULL, 'Gloire au Roi François!', 'Cinquième Tableau: Gloire au Roi François!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88ed5b2e-b85b-4d49-b52a-1f5f0d15e0dd'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1137659-468a-4ae3-a370-faa18a6de7bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2385 AND linked.composer_id = 60),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '3막 발레 (Divertissement)', part.name_en = 'Act III: Ballet (Divertissement)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2385 AND linked.composer_id = 60), 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2', 4, NULL, '3막 발레 (Divertissement)', 'Act III: Ballet (Divertissement)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
);

UPDATE pieces piece
SET piece.title = '오페라 <아스카니오> 중 "3막 발레 (Divertissement)"', piece.title_en = 'Ascanio: Act III: Ballet (Divertissement)', piece.editor_locked = 1
WHERE piece.id = 2385 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Entrée du Maître des Jeux', part.name_en = 'Entrée du Maître des Jeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:267c8039-4fdc-4270-9b6d-525642a2562c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:267c8039-4fdc-4270-9b6d-525642a2562c', 1, NULL, 'Entrée du Maître des Jeux', 'Entrée du Maître des Jeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:267c8039-4fdc-4270-9b6d-525642a2562c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vénus, Junon et Pallas', part.name_en = 'Vénus, Junon et Pallas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e3397044-ae5e-4c19-b575-08f7efc57209' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3397044-ae5e-4c19-b575-08f7efc57209', 2, NULL, 'Vénus, Junon et Pallas', 'Vénus, Junon et Pallas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3397044-ae5e-4c19-b575-08f7efc57209'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Diane, Dryades et Naïades', part.name_en = 'Diane, Dryades et Naïades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:67190e4e-6fce-4edd-90a5-bb10347fff2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67190e4e-6fce-4edd-90a5-bb10347fff2f', 3, NULL, 'Diane, Dryades et Naïades', 'Diane, Dryades et Naïades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67190e4e-6fce-4edd-90a5-bb10347fff2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Bacchus et les Bacchantes', part.name_en = 'Bacchus et les Bacchantes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:599ed5f2-9da3-4acd-aa0f-6ab0afc6afc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:599ed5f2-9da3-4acd-aa0f-6ab0afc6afc5', 4, NULL, 'Bacchus et les Bacchantes', 'Bacchus et les Bacchantes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:599ed5f2-9da3-4acd-aa0f-6ab0afc6afc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Apparition de Phœbus, d''Apollon et les neuf Muses', part.name_en = 'Apparition de Phœbus, d''Apollon et les neuf Muses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:fa3aaaf5-d83a-40ea-b8d7-1a6933002193' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa3aaaf5-d83a-40ea-b8d7-1a6933002193', 5, NULL, 'Apparition de Phœbus, d''Apollon et les neuf Muses', 'Apparition de Phœbus, d''Apollon et les neuf Muses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa3aaaf5-d83a-40ea-b8d7-1a6933002193'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Phœbus prenant sa lyre, évoque l''Amour', part.name_en = 'Phœbus prenant sa lyre, évoque l''Amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:be66b91d-3911-4b3a-a55e-38a7aed96170' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be66b91d-3911-4b3a-a55e-38a7aed96170', 6, NULL, 'Phœbus prenant sa lyre, évoque l''Amour', 'Phœbus prenant sa lyre, évoque l''Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be66b91d-3911-4b3a-a55e-38a7aed96170'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'L''Amour fait apparaître Psyché', part.name_en = 'L''Amour fait apparaître Psyché',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6f45d1cd-552a-4955-ac6b-3a51ec7e8052' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f45d1cd-552a-4955-ac6b-3a51ec7e8052', 7, NULL, 'L''Amour fait apparaître Psyché', 'L''Amour fait apparaître Psyché', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f45d1cd-552a-4955-ac6b-3a51ec7e8052'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Ensemble de Phœbus, Diane, Erigone, Nicœa et Bacchus avec les Muses, les Nymphes et les Bacchantes', part.name_en = 'Ensemble de Phœbus, Diane, Erigone, Nicœa et Bacchus avec les Muses, les Nymphes et les Bacchantes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d8ce8d68-5b0c-4940-9f48-a23151b0f555' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8ce8d68-5b0c-4940-9f48-a23151b0f555', 8, NULL, 'Ensemble de Phœbus, Diane, Erigone, Nicœa et Bacchus avec les Muses, les Nymphes et les Bacchantes', 'Ensemble de Phœbus, Diane, Erigone, Nicœa et Bacchus avec les Muses, les Nymphes et les Bacchantes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8ce8d68-5b0c-4940-9f48-a23151b0f555'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Variation de l''Amour', part.name_en = 'Variation de l''Amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8514f3d4-ae57-4f75-b325-93756460912b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8514f3d4-ae57-4f75-b325-93756460912b', 9, NULL, 'Variation de l''Amour', 'Variation de l''Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8514f3d4-ae57-4f75-b325-93756460912b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Le Dragon des Hespérides apporte la pomme d''or', part.name_en = 'Le Dragon des Hespérides apporte la pomme d''or',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:347eeaf0-9b3a-41b0-b08b-e73b880309da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:347eeaf0-9b3a-41b0-b08b-e73b880309da', 10, NULL, 'Le Dragon des Hespérides apporte la pomme d''or', 'Le Dragon des Hespérides apporte la pomme d''or', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:347eeaf0-9b3a-41b0-b08b-e73b880309da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '피날레. Les Déesses, Bacchantes, Naïades et Dryades', part.name_en = 'Final Les Déesses, Bacchantes, Naïades et Dryades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:515b7454-1c3d-4599-90d4-625440286f14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:515b7454-1c3d-4599-90d4-625440286f14', 11, NULL, '피날레. Les Déesses, Bacchantes, Naïades et Dryades', 'Final Les Déesses, Bacchantes, Naïades et Dryades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:515b7454-1c3d-4599-90d4-625440286f14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Apothéose', part.name_en = 'Apothéose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:bb1e76b0-0d06-410e-b7e6-012fafce6dd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb1e76b0-0d06-410e-b7e6-012fafce6dd0', 12, NULL, 'Apothéose', 'Apothéose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b9739790-fe2c-4a78-aec8-8ef8abb217e2'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb1e76b0-0d06-410e-b7e6-012fafce6dd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '4막', part.name_en = 'Act IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a', 5, NULL, '4막', 'Act IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sommes-nous seuls?', part.name_en = 'Sixième Tableau, Scène 1: Sommes-nous seuls?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b67306d7-479d-48b6-a9f1-4afa261a369f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b67306d7-479d-48b6-a9f1-4afa261a369f', 1, NULL, 'Sommes-nous seuls?', 'Sixième Tableau, Scène 1: Sommes-nous seuls?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b67306d7-479d-48b6-a9f1-4afa261a369f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Tu sais mon désir', part.name_en = 'Sixième Tableau, Scène 1: Tu sais mon désir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3f20a93b-a0c6-44d8-85cf-e7835466f351' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f20a93b-a0c6-44d8-85cf-e7835466f351', 2, NULL, 'Tu sais mon désir', 'Sixième Tableau, Scène 1: Tu sais mon désir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f20a93b-a0c6-44d8-85cf-e7835466f351'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Hélas, ah ! ma douleur soutiendra ma colère!', part.name_en = 'Sixième Tableau, Scène 2: Hélas, ah ! ma douleur soutiendra ma colère!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:78b572a8-2ffd-4115-b441-9c2495505ea1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78b572a8-2ffd-4115-b441-9c2495505ea1', 3, NULL, 'Hélas, ah ! ma douleur soutiendra ma colère!', 'Sixième Tableau, Scène 2: Hélas, ah ! ma douleur soutiendra ma colère!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78b572a8-2ffd-4115-b441-9c2495505ea1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ah ! Te voilà donc revenue!', part.name_en = 'Sixième Tableau, Scène 3: Ah ! Te voilà donc revenue!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2bd17feb-a6b3-46b1-aa30-802dea32cc8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2bd17feb-a6b3-46b1-aa30-802dea32cc8b', 4, NULL, 'Ah ! Te voilà donc revenue!', 'Sixième Tableau, Scène 3: Ah ! Te voilà donc revenue!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bd17feb-a6b3-46b1-aa30-802dea32cc8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Inclinez-vous, mon lis', part.name_en = 'Sixième Tableau, Scène 4: Inclinez-vous, mon lis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:36e300d8-122f-4c94-b268-d7e7c5dd62db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36e300d8-122f-4c94-b268-d7e7c5dd62db', 5, NULL, 'Inclinez-vous, mon lis', 'Sixième Tableau, Scène 4: Inclinez-vous, mon lis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36e300d8-122f-4c94-b268-d7e7c5dd62db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'En ton amour ma foi profonde...', part.name_en = 'Sixième Tableau, Scène 4: En ton amour ma foi profonde...',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:854a5fae-b464-4784-8e96-bd615e54cbd6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:854a5fae-b464-4784-8e96-bd615e54cbd6', 6, NULL, 'En ton amour ma foi profonde...', 'Sixième Tableau, Scène 4: En ton amour ma foi profonde...', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:854a5fae-b464-4784-8e96-bd615e54cbd6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ah ! Je veux tout lui dire!', part.name_en = 'Sixième Tableau, Scène 4: Ah ! Je veux tout lui dire!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7f8be155-7b64-4345-8984-d0fb3fa38826' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f8be155-7b64-4345-8984-d0fb3fa38826', 7, NULL, 'Ah ! Je veux tout lui dire!', 'Sixième Tableau, Scène 4: Ah ! Je veux tout lui dire!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f8be155-7b64-4345-8984-d0fb3fa38826'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Enfants, je ne vous en veux pas!', part.name_en = 'Sixième Tableau, Scène 4: Enfants, je ne vous en veux pas!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a929f2ad-b086-408c-940b-7f13d9f313c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a929f2ad-b086-408c-940b-7f13d9f313c6', 8, NULL, 'Enfants, je ne vous en veux pas!', 'Sixième Tableau, Scène 4: Enfants, je ne vous en veux pas!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a929f2ad-b086-408c-940b-7f13d9f313c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'O bonté profonde', part.name_en = 'Sixième Tableau, Scène 4: O bonté profonde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:52c87ba6-38e0-491c-b373-f82ae8de6382' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52c87ba6-38e0-491c-b373-f82ae8de6382', 9, NULL, 'O bonté profonde', 'Sixième Tableau, Scène 4: O bonté profonde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52c87ba6-38e0-491c-b373-f82ae8de6382'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'O cœur pur, généreux et fort!', part.name_en = 'Sixième Tableau, Scène 4: O cœur pur, généreux et fort!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:86deebd2-7b89-4391-a42b-92c1f046572e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:86deebd2-7b89-4391-a42b-92c1f046572e', 10, NULL, 'O cœur pur, généreux et fort!', 'Sixième Tableau, Scène 4: O cœur pur, généreux et fort!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86deebd2-7b89-4391-a42b-92c1f046572e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ouvrez au nom du Roi!', part.name_en = 'Sixième Tableau, Scène 4: Ouvrez au nom du Roi!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:80a87b88-3e96-4816-b2df-c694263a0a05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80a87b88-3e96-4816-b2df-c694263a0a05', 11, NULL, 'Ouvrez au nom du Roi!', 'Sixième Tableau, Scène 4: Ouvrez au nom du Roi!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80a87b88-3e96-4816-b2df-c694263a0a05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Ouvre à présent!', part.name_en = 'Sixième Tableau, Scène 5: Ouvre à présent!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:775ab078-0d17-4acd-ad1b-dc7eca17a242' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:775ab078-0d17-4acd-ad1b-dc7eca17a242', 12, NULL, 'Ouvre à présent!', 'Sixième Tableau, Scène 5: Ouvre à présent!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:775ab078-0d17-4acd-ad1b-dc7eca17a242'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Mais ce n''est pas mon deuil', part.name_en = 'Sixième Tableau, Scène 5: Mais ce n''est pas mon deuil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:be157f57-b055-482a-a135-367164f91b66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be157f57-b055-482a-a135-367164f91b66', 13, NULL, 'Mais ce n''est pas mon deuil', 'Sixième Tableau, Scène 5: Mais ce n''est pas mon deuil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:51854002-1395-4965-9043-9b6f6a5fb54a'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be157f57-b055-482a-a135-367164f91b66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '5막', part.name_en = 'Act V',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168', 6, NULL, '5막', 'Act V', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서주', part.name_en = 'Septième Tableau, Scène 1: Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:26fcfc6d-73e6-4ef6-8823-99e3a4048185' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:26fcfc6d-73e6-4ef6-8823-99e3a4048185', 1, NULL, '서주', 'Septième Tableau, Scène 1: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26fcfc6d-73e6-4ef6-8823-99e3a4048185'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Trois jours! Tout est fini!', part.name_en = 'Septième Tableau, Scène 1: Trois jours! Tout est fini!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7aa3a21a-43c0-449b-946f-7eb376e3b7a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7aa3a21a-43c0-449b-946f-7eb376e3b7a5', 2, NULL, 'Trois jours! Tout est fini!', 'Septième Tableau, Scène 1: Trois jours! Tout est fini!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aa3a21a-43c0-449b-946f-7eb376e3b7a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Dans la splendeur impérissable', part.name_en = 'Septième Tableau, Scène 2: Dans la splendeur impérissable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:420bd737-21d6-4092-92c8-78e340507be8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:420bd737-21d6-4092-92c8-78e340507be8', 3, NULL, 'Dans la splendeur impérissable', 'Septième Tableau, Scène 2: Dans la splendeur impérissable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:420bd737-21d6-4092-92c8-78e340507be8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Benvenuto, ton œuvre est accomplie!', part.name_en = 'Septième Tableau, Scène 2: Benvenuto, ton œuvre est accomplie!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:dd49a4dd-5969-4a9c-b3ba-9b93b744bb0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd49a4dd-5969-4a9c-b3ba-9b93b744bb0e', 4, NULL, 'Benvenuto, ton œuvre est accomplie!', 'Septième Tableau, Scène 2: Benvenuto, ton œuvre est accomplie!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd49a4dd-5969-4a9c-b3ba-9b93b744bb0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'O force immense du génie!', part.name_en = 'Septième Tableau, Scène 2: O force immense du génie!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0ff2344c-020a-48dc-8755-cecb53426eba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ff2344c-020a-48dc-8755-cecb53426eba', 5, NULL, 'O force immense du génie!', 'Septième Tableau, Scène 2: O force immense du génie!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ff2344c-020a-48dc-8755-cecb53426eba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Si Colombe est vivante, ah! Qui donc est là, morte?', part.name_en = 'Septième Tableau, Scène 2: Si Colombe est vivante, ah! Qui donc est là, morte?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2028 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:32c1fccc-a84a-47fc-8f3a-0ab974e9eec7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32c1fccc-a84a-47fc-8f3a-0ab974e9eec7', 6, NULL, 'Si Colombe est vivante, ah! Qui donc est là, morte?', 'Septième Tableau, Scène 2: Si Colombe est vivante, ah! Qui donc est là, morte?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aba78822-f688-4ff3-ba2f-38c54e81f168'
WHERE p.id = 2028 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c1fccc-a84a-47fc-8f3a-0ab974e9eec7'
);


-- R. 294 오페라 <프리네>

UPDATE pieces piece
SET piece.title = '오페라 <프리네>', piece.title_en = 'Phryné',
    piece.type = 'song', piece.opus_number = 'R. 294',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 932 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 932 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- R. 295 오페라 <야만인들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <야만인들>', 'Les barbares', 'album', 'R. 295', NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <야만인들>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 3011 AND linked.composer_id = 60), 'musicbrainz:feae6a91-0979-4cd2-9158-9e767d729fc4', 1, NULL, '프롤로그', 'Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '오페라 <야만인들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feae6a91-0979-4cd2-9158-9e767d729fc4'
);

UPDATE pieces piece
SET piece.title = '오페라 <야만인들> 중 "프롤로그"', piece.title_en = 'Les barbares: Prologue', piece.editor_locked = 1
WHERE piece.id = 3011 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- R. 296 오페라 <엘렌>

UPDATE pieces piece
SET piece.title = '오페라 <엘렌>', piece.title_en = 'Hélène',
    piece.type = 'song', piece.opus_number = 'R. 296',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2080 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 2080 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- R. 297 오페라 <조상>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <조상>', 'L''ancêtre', 'song', 'R. 297', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <조상>'
);


-- R. 298 오페라 <데자니르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <데자니르>', 'Déjanire', 'song', 'R. 298', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <데자니르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '210ab7b3-a9f0-4f90-a43d-6ab512d9f43e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '210ab7b3-a9f0-4f90-a43d-6ab512d9f43e'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '오페라 <데자니르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '210ab7b3-a9f0-4f90-a43d-6ab512d9f43e'
);


-- R. 306 발레 <자보트>

UPDATE pieces piece
SET piece.title = '발레 <자보트>', piece.title_en = 'Javotte',
    piece.type = 'song', piece.opus_number = 'R. 306',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2314 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 2314 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 128 영화 음악 <기즈 공의 암살>

UPDATE pieces piece
SET piece.title = '영화 음악 <기즈 공의 암살>', piece.title_en = 'L''assassinat du duc de Guise',
    piece.type = 'song', piece.opus_number = 'Op. 128',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1785 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 1785 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- R. 317 부수음악 <안티고네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <안티고네>', 'Antigone, incidental music', 'song', 'R. 317', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <안티고네>'
);


-- R. 312 부수음악 <파리사티스>

UPDATE pieces piece
SET piece.title = '부수음악 <파리사티스>', piece.title_en = 'Parysatis, incidental music',
    piece.type = 'album', piece.opus_number = 'R. 312',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1432 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 1432 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le rossignol et la rose', part.name_en = 'Le rossignol et la rose',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1432 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1b55a3fd-996a-4eb1-b29d-df0d606ff6f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b55a3fd-996a-4eb1-b29d-df0d606ff6f6', 1, NULL, 'Le rossignol et la rose', 'Le rossignol et la rose', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1432 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b55a3fd-996a-4eb1-b29d-df0d606ff6f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1274 AND linked.composer_id = 60),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '발레 음악', part.name_en = 'Airs de ballet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1432 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:32d883fb-3180-4ae6-8aa7-4d23fa1ffe6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1274 AND linked.composer_id = 60), 'musicbrainz:32d883fb-3180-4ae6-8aa7-4d23fa1ffe6e', 2, NULL, '발레 음악', 'Airs de ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1432 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32d883fb-3180-4ae6-8aa7-4d23fa1ffe6e'
);

UPDATE pieces piece
SET piece.title = '부수음악 <파리사티스> 중 "발레 음악"', piece.title_en = 'Parysatis, incidental music: Airs de ballet', piece.editor_locked = 1
WHERE piece.id = 1274 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- R. 320 부수음악 <앙드로마크>

UPDATE pieces piece
SET piece.title = '부수음악 <앙드로마크>', piece.title_en = 'Andromaque, incidental music',
    piece.type = 'song', piece.opus_number = 'R. 320',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2035 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 2035 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 130 부수음악 <신앙>

UPDATE pieces piece
SET piece.title = '부수음악 <신앙>', piece.title_en = 'La foi, incidental music',
    piece.type = 'song', piece.opus_number = 'Op. 130',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1189 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 1189 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 부수음악 <On ne badine pas avec l'amour>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <On ne badine pas avec l''amour>', 'On ne badine pas avec l''amour, incidental music', 'song', NULL, NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <On ne badine pas avec l''amour>'
);


-- None 희가극 서곡 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '희가극 서곡 E단조', 'Overture to a Comic Opera in E minor', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '희가극 서곡 E단조'
);


-- None 소관현악을 위한 스케르초 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소관현악을 위한 스케르초 A장조', 'Scherzo in A major for Chamber Orchestra', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소관현악을 위한 스케르초 A장조'
);


-- R. 159 교향곡 A장조

UPDATE pieces piece
SET piece.title = '교향곡 A장조', piece.title_en = 'Symphony in A major',
    piece.type = 'album', piece.opus_number = 'R. 159',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1850, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2161 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1850
WHERE piece.id = 2161 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poco adagio – Allegro vivace', part.name_en = 'I. Poco adagio – Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2161 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8ad0fb1e-c767-4a75-96aa-1c04b79a7d86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad0fb1e-c767-4a75-96aa-1c04b79a7d86', 1, 'I', 'Poco adagio – Allegro vivace', 'I. Poco adagio – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2161 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad0fb1e-c767-4a75-96aa-1c04b79a7d86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Larghetto', part.name_en = 'II. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2161 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:943dca92-2030-4e35-879d-97ad5c07683b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:943dca92-2030-4e35-879d-97ad5c07683b', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2161 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:943dca92-2030-4e35-879d-97ad5c07683b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Allegro vivace – 트리오', part.name_en = 'III. Scherzo. Allegro vivace – Trio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2161 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5067642e-8e8d-4cf0-a109-4dbdf4b35eda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5067642e-8e8d-4cf0-a109-4dbdf4b35eda', 3, 'III', '스케르초. Allegro vivace – 트리오', 'III. Scherzo. Allegro vivace – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2161 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5067642e-8e8d-4cf0-a109-4dbdf4b35eda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Allegro molto – Presto', part.name_en = 'IV. Finale. Allegro molto – Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2161 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:bb20aa52-a3c1-42f3-8e6e-618a518c2583' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb20aa52-a3c1-42f3-8e6e-618a518c2583', 4, 'IV', '피날레. Allegro molto – Presto', 'IV. Finale. Allegro molto – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2161 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb20aa52-a3c1-42f3-8e6e-618a518c2583'
);


-- Op. 2 교향곡 1번 E♭장조

UPDATE pieces piece
SET piece.title = '교향곡 1번 E♭장조', piece.title_en = 'Symphony No. 1 in E♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 879 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 879 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1210 AND linked.composer_id = 60),
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio - Allegro', part.name_en = 'I. Adagio - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 879 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9016fdd2-e7d5-44c8-9a42-372b1dc7cfaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1210 AND linked.composer_id = 60), 'musicbrainz:9016fdd2-e7d5-44c8-9a42-372b1dc7cfaa', 1, 'I', 'Adagio - Allegro', 'I. Adagio - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 879 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9016fdd2-e7d5-44c8-9a42-372b1dc7cfaa'
);

UPDATE pieces piece
SET piece.title = '교향곡 1번 E♭장조 중 "Adagio - Allegro"', piece.title_en = 'Symphony No. 1 in E♭ major: I. Adagio - Allegro', piece.editor_locked = 1
WHERE piece.id = 1210 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2377 AND linked.composer_id = 60),
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '행진곡-스케르초. Allegretto scherzando', part.name_en = 'II. Marche-scherzo. Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 879 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b3c0b450-10fd-440e-a38a-ac6aa9d371d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2377 AND linked.composer_id = 60), 'musicbrainz:b3c0b450-10fd-440e-a38a-ac6aa9d371d4', 2, 'II', '행진곡-스케르초. Allegretto scherzando', 'II. Marche-scherzo. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 879 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3c0b450-10fd-440e-a38a-ac6aa9d371d4'
);

UPDATE pieces piece
SET piece.title = '교향곡 1번 E♭장조 중 "행진곡-스케르초. Allegretto scherzando"', piece.title_en = 'Symphony No. 1 in E♭ major: II. Marche-scherzo. Allegretto scherzando', piece.editor_locked = 1
WHERE piece.id = 2377 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 879 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:48c911d8-896b-4b8e-b43b-8ca68885a2a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48c911d8-896b-4b8e-b43b-8ca68885a2a8', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 879 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c911d8-896b-4b8e-b43b-8ca68885a2a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Allegro maestoso', part.name_en = 'IV. Finale. Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 879 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:17bfc46f-5a5e-4743-a52a-96fe17d23ec6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17bfc46f-5a5e-4743-a52a-96fe17d23ec6', 4, 'IV', '피날레. Allegro maestoso', 'IV. Finale. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 879 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17bfc46f-5a5e-4743-a52a-96fe17d23ec6'
);


-- R. 162 미완성 희가극 서곡 G장조

UPDATE pieces piece
SET piece.title = '미완성 희가극 서곡 G장조', piece.title_en = 'Overture to an Unfinished Comic Opera in G major',
    piece.type = 'song', piece.opus_number = 'R. 162',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1854, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2151 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1854
WHERE piece.id = 2151 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- R. 163 교향곡 F장조 "우르브스 로마"

UPDATE pieces piece
SET piece.title = '교향곡 F장조 "우르브스 로마"', piece.title_en = 'Symphony in F major "Urbs Roma"',
    piece.type = 'album', piece.opus_number = 'R. 163',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1856, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1508 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1856
WHERE piece.id = 1508 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo - Allegro', part.name_en = 'I. Largo - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1508 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0653e9b2-8901-41f3-9c94-22e7beca4f62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0653e9b2-8901-41f3-9c94-22e7beca4f62', 1, 'I', 'Largo - Allegro', 'I. Largo - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1508 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0653e9b2-8901-41f3-9c94-22e7beca4f62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto vivace', part.name_en = 'II. Molto vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1508 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:21d0b2de-7e18-42ee-a7f1-60d32a3443ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21d0b2de-7e18-42ee-a7f1-60d32a3443ac', 2, 'II', 'Molto vivace', 'II. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1508 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21d0b2de-7e18-42ee-a7f1-60d32a3443ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato assai serioso', part.name_en = 'III. Moderato assai serioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1508 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3ddd4f53-a817-470f-869f-e6309f87ecbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ddd4f53-a817-470f-869f-e6309f87ecbf', 3, 'III', 'Moderato assai serioso', 'III. Moderato assai serioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1508 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ddd4f53-a817-470f-869f-e6309f87ecbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Poco allegretto - Andante con moto', part.name_en = 'IV. Poco allegretto - Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1508 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:22240847-2dec-42e3-8d33-e97d5ce4e225' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22240847-2dec-42e3-8d33-e97d5ce4e225', 4, 'IV', 'Poco allegretto - Andante con moto', 'IV. Poco allegretto - Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1508 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22240847-2dec-42e3-8d33-e97d5ce4e225'
);


-- Op. 55 교향곡 2번 A단조

UPDATE pieces piece
SET piece.title = '교향곡 2번 A단조', piece.title_en = 'Symphony No. 2 in A minor',
    piece.type = 'album', piece.opus_number = 'Op. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1122 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 1122 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro marcato', part.name_en = 'I. Allegro marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1122 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:228a7e8b-c86c-4ffa-b18a-0952a58f377c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:228a7e8b-c86c-4ffa-b18a-0952a58f377c', 1, 'I', 'Allegro marcato', 'I. Allegro marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1122 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:228a7e8b-c86c-4ffa-b18a-0952a58f377c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1122 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6bd45e16-3e3a-47aa-8edc-1a130884b45e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bd45e16-3e3a-47aa-8edc-1a130884b45e', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1122 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bd45e16-3e3a-47aa-8edc-1a130884b45e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Presto', part.name_en = 'III. Scherzo. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1122 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:bb06f12f-22f7-418a-83ae-37a9f850003c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb06f12f-22f7-418a-83ae-37a9f850003c', 3, 'III', '스케르초. Presto', 'III. Scherzo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1122 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb06f12f-22f7-418a-83ae-37a9f850003c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Prestissimo', part.name_en = 'IV. Prestissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1122 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8e487c2a-fec5-4458-b7b7-1cf6f029b3a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e487c2a-fec5-4458-b7b7-1cf6f029b3a2', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1122 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e487c2a-fec5-4458-b7b7-1cf6f029b3a2'
);


-- Op. 49 관현악 모음곡 D장조

UPDATE pieces piece
SET piece.title = '관현악 모음곡 D장조', piece.title_en = 'Suite in D major for Orchestra',
    piece.type = 'album', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1888 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 1888 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1888 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:fbf2014b-d682-4f25-ae25-0512a8151db8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbf2014b-d682-4f25-ae25-0512a8151db8', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1888 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbf2014b-d682-4f25-ae25-0512a8151db8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '사라방드', part.name_en = 'II. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1888 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:08b78090-2a93-4198-8c03-33e3de9d2389' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08b78090-2a93-4198-8c03-33e3de9d2389', 2, 'II', '사라방드', 'II. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1888 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b78090-2a93-4198-8c03-33e3de9d2389'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '가보트', part.name_en = 'III. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1888 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1911e339-d2ab-4a0b-bc3f-17cbbf1fcaba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1911e339-d2ab-4a0b-bc3f-17cbbf1fcaba', 3, 'III', '가보트', 'III. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1888 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1911e339-d2ab-4a0b-bc3f-17cbbf1fcaba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '로망스', part.name_en = 'IV. Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1888 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:564ac384-b287-4b58-b08b-cf2c4269960a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:564ac384-b287-4b58-b08b-cf2c4269960a', 4, 'IV', '로망스', 'IV. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1888 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:564ac384-b287-4b58-b08b-cf2c4269960a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레', part.name_en = 'V. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1888 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c8adf9ef-cd48-4322-a15f-ac86b459eabf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8adf9ef-cd48-4322-a15f-ac86b459eabf', 5, 'V', '피날레', 'V. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1888 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8adf9ef-cd48-4322-a15f-ac86b459eabf'
);


-- R. 166 서곡 <스파르타쿠스> E♭장조

UPDATE pieces piece
SET piece.title = '서곡 <스파르타쿠스> E♭장조', piece.title_en = 'Spartacus Overture in E♭ major',
    piece.type = 'song', piece.opus_number = 'R. 166',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1723 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 1723 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 7b 관현악을 위한 <브르타뉴 랩소디>

UPDATE pieces piece
SET piece.title = '관현악을 위한 <브르타뉴 랩소디>', piece.title_en = 'Rhapsodie bretonne',
    piece.type = 'album', piece.opus_number = 'Op. 7b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2756 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 2756 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2756 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d0e2c01c-167d-4760-939f-2aba1230bc23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0e2c01c-167d-4760-939f-2aba1230bc23', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2756 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0e2c01c-167d-4760-939f-2aba1230bc23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2756 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:42763461-d8a4-45cf-9a53-2f30fcc1df31' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42763461-d8a4-45cf-9a53-2f30fcc1df31', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2756 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42763461-d8a4-45cf-9a53-2f30fcc1df31'
);


-- Op. 25 행진곡 <동양과 서양>

UPDATE pieces piece
SET piece.title = '행진곡 <동양과 서양>', piece.title_en = 'Orient et Occident, March',
    piece.type = 'song', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1303 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 1303 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 34 영웅 행진곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영웅 행진곡 E♭장조', 'Marche héroïque in E♭ major', 'song', 'Op. 34', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영웅 행진곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc8233c9-9386-4a6f-b8c2-bee24b506f5c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc8233c9-9386-4a6f-b8c2-bee24b506f5c'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '영웅 행진곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc8233c9-9386-4a6f-b8c2-bee24b506f5c'
);


-- Op. 31 교향시 <옴팔레의 물레> A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <옴팔레의 물레> A장조', 'Le rouet d''Omphale in A major', 'song', 'Op. 31', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <옴팔레의 물레> A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c43c7f8-1b75-4173-a85e-9d67787f05cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c43c7f8-1b75-4173-a85e-9d67787f05cf'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '교향시 <옴팔레의 물레> A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c43c7f8-1b75-4173-a85e-9d67787f05cf'
);


-- Op. 39 교향시 <파에톤> C장조

UPDATE pieces piece
SET piece.title = '교향시 <파에톤> C장조', piece.title_en = 'Phaéton in C major',
    piece.type = 'song', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1873, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2902 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1873
WHERE piece.id = 2902 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 50 교향시 <헤라클레스의 청년 시절> E♭장조

UPDATE pieces piece
SET piece.title = '교향시 <헤라클레스의 청년 시절> E♭장조', piece.title_en = 'La jeunesse d''Hercule in E♭ major',
    piece.type = 'song', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2813 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 2813 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 60 <알제리 모음곡> C장조

UPDATE pieces piece
SET piece.title = '<알제리 모음곡> C장조', piece.title_en = 'Suite algérienne in C major',
    piece.type = 'album', piece.opus_number = 'Op. 60',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 990 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 990 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡 (알제를 바라보며)', part.name_en = 'I. Prélude (en vue d''Alger)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 990 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ca030b6a-14af-4032-b205-c98f32d76227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca030b6a-14af-4032-b205-c98f32d76227', 1, 'I', '전주곡 (알제를 바라보며)', 'I. Prélude (en vue d''Alger)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 990 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca030b6a-14af-4032-b205-c98f32d76227'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '무어풍 랩소디', part.name_en = 'II. Rhapsodie mauresque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 990 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a9c0fdae-c096-4a9e-a6a2-1931af5e562a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9c0fdae-c096-4a9e-a6a2-1931af5e562a', 2, 'II', '무어풍 랩소디', 'II. Rhapsodie mauresque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 990 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9c0fdae-c096-4a9e-a6a2-1931af5e562a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '저녁의 몽상 (블리다에서)', part.name_en = 'III. Rêverie du soir (à Blidah)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 990 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4b51ef5d-de0b-4c79-b2d5-bed92efd2918' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b51ef5d-de0b-4c79-b2d5-bed92efd2918', 3, 'III', '저녁의 몽상 (블리다에서)', 'III. Rêverie du soir (à Blidah)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 990 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b51ef5d-de0b-4c79-b2d5-bed92efd2918'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '프랑스 군대 행진곡', part.name_en = 'IV. Marche militaire française',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 990 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b693305c-b546-47a7-9a37-3584fb867bc2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b693305c-b546-47a7-9a37-3584fb867bc2', 4, 'IV', '프랑스 군대 행진곡', 'IV. Marche militaire française', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 990 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b693305c-b546-47a7-9a37-3584fb867bc2'
);


-- Op. 63 <리스본의 밤> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<리스본의 밤> E♭장조', 'Une nuit à Lisbonne in E♭ major', 'song', 'Op. 63', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<리스본의 밤> E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c70ffe1-b343-4548-8aa0-e76d2923f5b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c70ffe1-b343-4548-8aa0-e76d2923f5b7'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '<리스본의 밤> E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c70ffe1-b343-4548-8aa0-e76d2923f5b7'
);


-- Op. 64 <아라곤의 호타> A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아라곤의 호타> A장조', 'La jota aragonese in A major', 'song', 'Op. 64', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아라곤의 호타> A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e7a5f8b-49db-49da-8c77-a83c0aed4348'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e7a5f8b-49db-49da-8c77-a83c0aed4348'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '<아라곤의 호타> A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e7a5f8b-49db-49da-8c77-a83c0aed4348'
);


-- Op. 69 <빅토르 위고 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<빅토르 위고 찬가>', 'Hymne à Victor Hugo', 'song', 'Op. 69', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<빅토르 위고 찬가>'
);


-- Op. 78 교향곡 3번 C단조 "오르간"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio – Allegro moderato – Poco adagio', part.name_en = 'I. Adagio – Allegro moderato – Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 254 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b22f5a02-8bb1-45b5-9f30-4f06942ef444' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b22f5a02-8bb1-45b5-9f30-4f06942ef444', 1, 'I', 'Adagio – Allegro moderato – Poco adagio', 'I. Adagio – Allegro moderato – Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 254 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b22f5a02-8bb1-45b5-9f30-4f06942ef444'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b22f5a02-8bb1-45b5-9f30-4f06942ef444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Adagio – Allegro moderato', part.name_en = '(a) Adagio – Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 254 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:109a15f2-323e-4d4a-8266-573aef7ebb8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:109a15f2-323e-4d4a-8266-573aef7ebb8e', 1, NULL, 'Adagio – Allegro moderato', '(a) Adagio – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b22f5a02-8bb1-45b5-9f30-4f06942ef444'
WHERE p.id = 254 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:109a15f2-323e-4d4a-8266-573aef7ebb8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b22f5a02-8bb1-45b5-9f30-4f06942ef444'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Poco adagio', part.name_en = '(b) Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 254 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f86fe2f3-c174-446f-b640-937e7c079502' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f86fe2f3-c174-446f-b640-937e7c079502', 2, NULL, 'Poco adagio', '(b) Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b22f5a02-8bb1-45b5-9f30-4f06942ef444'
WHERE p.id = 254 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f86fe2f3-c174-446f-b640-937e7c079502'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro moderato – Presto – Maestoso – Allegro', part.name_en = 'II. Allegro moderato – Presto – Maestoso – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 254 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:951dca18-26f9-438c-96f2-14852e4acc37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:951dca18-26f9-438c-96f2-14852e4acc37', 2, 'II', 'Allegro moderato – Presto – Maestoso – Allegro', 'II. Allegro moderato – Presto – Maestoso – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 254 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:951dca18-26f9-438c-96f2-14852e4acc37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:951dca18-26f9-438c-96f2-14852e4acc37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato – Presto', part.name_en = '(a) Allegro moderato – Presto – Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 254 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9d40c93c-6898-4fb6-9a2f-3f9d72421f4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d40c93c-6898-4fb6-9a2f-3f9d72421f4c', 1, NULL, 'Allegro moderato – Presto', '(a) Allegro moderato – Presto – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:951dca18-26f9-438c-96f2-14852e4acc37'
WHERE p.id = 254 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d40c93c-6898-4fb6-9a2f-3f9d72421f4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:951dca18-26f9-438c-96f2-14852e4acc37'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Maestoso – Allegro', part.name_en = '(b) Maestoso – Più allegro – Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 254 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5cbdbb7f-d2ce-4510-929e-f0d33a1c3a62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5cbdbb7f-d2ce-4510-929e-f0d33a1c3a62', 2, NULL, 'Maestoso – Allegro', '(b) Maestoso – Più allegro – Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:951dca18-26f9-438c-96f2-14852e4acc37'
WHERE p.id = 254 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cbdbb7f-d2ce-4510-929e-f0d33a1c3a62'
);


-- Op. 93 사라방드와 리고동 E장조

UPDATE pieces piece
SET piece.title = '사라방드와 리고동 E장조', piece.title_en = 'Sarabande et Rigaudon in E major',
    piece.type = 'album', piece.opus_number = 'Op. 93',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2154 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 2154 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '사라방드', part.name_en = 'I. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2154 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:fb5ca6e3-2dfd-47f4-b286-409efbc0dd70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb5ca6e3-2dfd-47f4-b286-409efbc0dd70', 1, 'I', '사라방드', 'I. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2154 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb5ca6e3-2dfd-47f4-b286-409efbc0dd70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '리고동', part.name_en = 'II. Rigaudon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2154 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:553490e7-6076-46b7-b5a5-78155dc5156a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:553490e7-6076-46b7-b5a5-78155dc5156a', 2, 'II', '리고동', 'II. Rigaudon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2154 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:553490e7-6076-46b7-b5a5-78155dc5156a'
);


-- Op. 117 대관식 행진곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관식 행진곡 E♭장조', 'Coronation March in E♭ major', 'song', 'Op. 117', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관식 행진곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94d13085-cda0-4ecf-82ba-723424c3911c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94d13085-cda0-4ecf-82ba-723424c3911c'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '대관식 행진곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94d13085-cda0-4ecf-82ba-723424c3911c'
);


-- Op. 130 <신앙>에 의한 3개의 교향적 그림

UPDATE pieces piece
SET piece.title = '<신앙>에 의한 3개의 교향적 그림', piece.title_en = '3 Symphonic Pictures after "La foi"',
    piece.type = 'album', piece.opus_number = 'Op. 130',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1663 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 1663 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poco allegro', part.name_en = 'I. Poco allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1663 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:15d084bd-83f5-41d5-9aa0-ed5fa57f33ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15d084bd-83f5-41d5-9aa0-ed5fa57f33ab', 1, 'I', 'Poco allegro', 'I. Poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1663 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15d084bd-83f5-41d5-9aa0-ed5fa57f33ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1663 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:65283c32-ba49-423c-be14-1fc0df5eec3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65283c32-ba49-423c-be14-1fc0df5eec3a', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1663 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65283c32-ba49-423c-be14-1fc0df5eec3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato e maestoso', part.name_en = 'III. Allegro moderato e maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1663 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:684de2a1-802c-4630-ba19-6667693edb62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:684de2a1-802c-4630-ba19-6667693edb62', 3, 'III', 'Allegro moderato e maestoso', 'III. Allegro moderato e maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1663 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:684de2a1-802c-4630-ba19-6667693edb62'
);


-- Op. 133 축전 서곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전 서곡 F장조', 'Ouverture de fête in F major', 'song', 'Op. 133', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전 서곡 F장조'
);


-- None <헤일! 캘리포니아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헤일! 캘리포니아>', 'Hail! California', 'song', NULL, NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<헤일! 캘리포니아>'
);


-- None <프랑스-스페인 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<프랑스-스페인 찬가>', 'Hymne franco-espagnol', 'song', NULL, NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<프랑스-스페인 찬가>'
);


-- Op. 125 군대 행진곡 <나일 강변에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군대 행진곡 <나일 강변에서>', 'Sur les bords du Nil, Marche militaire', 'song', 'Op. 125', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군대 행진곡 <나일 강변에서>'
);


-- Op. 152 빠른 행진곡 <승리를 향하여>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '빠른 행진곡 <승리를 향하여>', 'Vers la victoire, Pas redoublé', 'song', 'Op. 152', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '빠른 행진곡 <승리를 향하여>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '954ba305-b54c-44de-bc4f-b23110b344fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '954ba305-b54c-44de-bc4f-b23110b344fc'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '빠른 행진곡 <승리를 향하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '954ba305-b54c-44de-bc4f-b23110b344fc'
);


-- Op. 155 <연합국 행진곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<연합국 행진곡>', 'Marche interalliée', 'song', 'Op. 155', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<연합국 행진곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '342fbb56-5db5-4d90-9f00-932fdf5de7cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '342fbb56-5db5-4d90-9f00-932fdf5de7cb'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '<연합국 행진곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '342fbb56-5db5-4d90-9f00-932fdf5de7cb'
);


-- Op. 6 플루트와 클라리넷을 위한 타란텔라 A단조

UPDATE pieces piece
SET piece.title = '플루트와 클라리넷을 위한 타란텔라 A단조', piece.title_en = 'Tarantelle in A minor for Flute, Clarinet and Orchestra',
    piece.type = 'song', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1857, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 537 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1857
WHERE piece.id = 537 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 17 피아노 협주곡 1번 D장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 1번 D장조', piece.title_en = 'Piano Concerto No. 1 in D major',
    piece.type = 'album', piece.opus_number = 'Op. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1858, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2864 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1858
WHERE piece.id = 2864 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante – Allegro assai', part.name_en = 'I. Andante – Allegro assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2864 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f809c603-f18e-3a36-9beb-8b960df29416' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f809c603-f18e-3a36-9beb-8b960df29416', 1, 'I', 'Andante – Allegro assai', 'I. Andante – Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2864 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f809c603-f18e-3a36-9beb-8b960df29416'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto quasi adagio', part.name_en = 'II. Andante sostenuto quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2864 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:04440fb1-620f-31c7-bb2a-9d619042c0bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04440fb1-620f-31c7-bb2a-9d619042c0bc', 2, 'II', 'Andante sostenuto quasi adagio', 'II. Andante sostenuto quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2864 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04440fb1-620f-31c7-bb2a-9d619042c0bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'III. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2864 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f3c7719c-507e-37c4-984f-ee621963cc1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3c7719c-507e-37c4-984f-ee621963cc1e', 3, 'III', 'Allegro con fuoco', 'III. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2864 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3c7719c-507e-37c4-984f-ee621963cc1e'
);


-- Op. 58 바이올린 협주곡 2번 C장조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 2번 C장조', piece.title_en = 'Violin Concerto No. 2 in C major',
    piece.type = 'album', piece.opus_number = 'Op. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1858, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 848 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1858
WHERE piece.id = 848 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato e maestoso - Cadenza - a tempo più allegro', part.name_en = 'I. Allegro moderato e maestoso - Cadenza - a tempo più allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 848 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:36232915-d50a-34a8-84a5-b5a177b5e12d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36232915-d50a-34a8-84a5-b5a177b5e12d', 1, 'I', 'Allegro moderato e maestoso - Cadenza - a tempo più allegro', 'I. Allegro moderato e maestoso - Cadenza - a tempo più allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 848 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36232915-d50a-34a8-84a5-b5a177b5e12d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante espressivo', part.name_en = 'II. Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 848 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0db9fb58-9620-3e30-a270-31f72625b171' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0db9fb58-9620-3e30-a270-31f72625b171', 2, 'II', 'Andante espressivo', 'II. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 848 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0db9fb58-9620-3e30-a270-31f72625b171'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro scherzando quasi allegretto', part.name_en = 'III. Allegro scherzando quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 848 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7966fd31-9ba2-4cc6-8649-ac79c55dd421' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7966fd31-9ba2-4cc6-8649-ac79c55dd421', 3, 'III', 'Allegro scherzando quasi allegretto', 'III. Allegro scherzando quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 848 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7966fd31-9ba2-4cc6-8649-ac79c55dd421'
);


-- Op. 20 바이올린 협주곡 1번 A장조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 1번 A장조', piece.title_en = 'Violin Concerto No. 1 in A major',
    piece.type = 'song', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 508 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 508 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 16b 첼로와 관현악을 위한 모음곡

UPDATE pieces piece
SET piece.title = '첼로와 관현악을 위한 모음곡', piece.title_en = 'Suite for Cello and Orchestra',
    piece.type = 'album', piece.opus_number = 'Op. 16b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1178 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 1178 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡. Moderato assai', part.name_en = 'I. Prélude. Moderato assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1178 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:548dfa78-b259-43ff-9e69-8d0477b3056d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:548dfa78-b259-43ff-9e69-8d0477b3056d', 1, 'I', '전주곡. Moderato assai', 'I. Prélude. Moderato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1178 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:548dfa78-b259-43ff-9e69-8d0477b3056d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '세레나데. Andantino', part.name_en = 'II. Sérénade. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1178 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6d8ccc18-089f-456c-97ae-5276f3452704' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d8ccc18-089f-456c-97ae-5276f3452704', 2, 'II', '세레나데. Andantino', 'II. Sérénade. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1178 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d8ccc18-089f-456c-97ae-5276f3452704'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '가보트. Allegro non troppo', part.name_en = 'III. Gavotte. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1178 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:dbaff529-2f86-475c-bea8-73bf787fdbee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbaff529-2f86-475c-bea8-73bf787fdbee', 3, 'III', '가보트. Allegro non troppo', 'III. Gavotte. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1178 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbaff529-2f86-475c-bea8-73bf787fdbee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '로망스. Molto adagio', part.name_en = 'IV. Romance. Molto adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1178 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ac63f06c-a1d5-4c54-b8fa-b32a3f7d5b32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac63f06c-a1d5-4c54-b8fa-b32a3f7d5b32', 4, 'IV', '로망스. Molto adagio', 'IV. Romance. Molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1178 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac63f06c-a1d5-4c54-b8fa-b32a3f7d5b32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '타란텔라. Presto non troppo', part.name_en = 'V. Tarantelle. Presto non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1178 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:03b0ada3-e304-491f-8e78-4f5e35886d7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03b0ada3-e304-491f-8e78-4f5e35886d7d', 5, 'V', '타란텔라. Presto non troppo', 'V. Tarantelle. Presto non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1178 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03b0ada3-e304-491f-8e78-4f5e35886d7d'
);


-- Op. 22 피아노 협주곡 2번 G단조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 2번 G단조', piece.title_en = 'Piano Concerto No. 2 in G minor',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 654 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 654 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante sostenuto', part.name_en = 'I. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 654 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9dbcf681-347c-34b7-8563-9fe7bb558524' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dbcf681-347c-34b7-8563-9fe7bb558524', 1, 'I', 'Andante sostenuto', 'I. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 654 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dbcf681-347c-34b7-8563-9fe7bb558524'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro scherzando', part.name_en = 'II. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 654 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f28c7565-239f-3155-959b-65bb3ba44200' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f28c7565-239f-3155-959b-65bb3ba44200', 2, 'II', 'Allegro scherzando', 'II. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 654 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f28c7565-239f-3155-959b-65bb3ba44200'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 654 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:62940ce5-379e-3711-a658-486fe67b9cec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62940ce5-379e-3711-a658-486fe67b9cec', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 654 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62940ce5-379e-3711-a658-486fe67b9cec'
);


-- Op. 29 피아노 협주곡 3번 E♭장조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 3번 E♭장조', piece.title_en = 'Piano Concerto No. 3 in E♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1748 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 1748 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato assai - Più mosso (Allegro maestoso)', part.name_en = 'I. Moderato assai - Più mosso (Allegro maestoso)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1748 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ad3b544d-9bfd-3052-af11-0b1d345b5523' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad3b544d-9bfd-3052-af11-0b1d345b5523', 1, 'I', 'Moderato assai - Più mosso (Allegro maestoso)', 'I. Moderato assai - Più mosso (Allegro maestoso)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1748 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad3b544d-9bfd-3052-af11-0b1d345b5523'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1748 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:da69746b-8b5b-3c2f-bcd9-784349e9bddd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da69746b-8b5b-3c2f-bcd9-784349e9bddd', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1748 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da69746b-8b5b-3c2f-bcd9-784349e9bddd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1748 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0f45f2e5-544a-3418-90d2-7b4efc8d262d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f45f2e5-544a-3418-90d2-7b4efc8d262d', 3, 'III', 'Allegro non troppo', 'III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1748 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f45f2e5-544a-3418-90d2-7b4efc8d262d'
);


-- Op. 37 플루트 로망스 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 로망스 D♭장조', 'Romance in D♭ major for Flute', 'song', 'Op. 37', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 로망스 D♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc26bf62-4855-48c5-b6eb-a7b6ce2a78de'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc26bf62-4855-48c5-b6eb-a7b6ce2a78de'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '플루트 로망스 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc26bf62-4855-48c5-b6eb-a7b6ce2a78de'
);


-- Op. 33 첼로 협주곡 1번 A단조

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '289c4b5c-1f39-3996-b6c6-08a726aa40cf'
FROM pieces p
WHERE p.id = 256 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '289c4b5c-1f39-3996-b6c6-08a726aa40cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 256 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2f2034a8-3ce3-3acb-b85a-1dfbeb0e1365' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f2034a8-3ce3-3acb-b85a-1dfbeb0e1365', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 256 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f2034a8-3ce3-3acb-b85a-1dfbeb0e1365'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto con moto', part.name_en = 'II. Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 256 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:31e88396-1c72-3dd2-a48f-1c86ffff0629' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31e88396-1c72-3dd2-a48f-1c86ffff0629', 2, 'II', 'Allegretto con moto', 'II. Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 256 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31e88396-1c72-3dd2-a48f-1c86ffff0629'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto allegro (Tempo primo)', part.name_en = 'III. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 256 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:736196b3-c05f-3ae3-b4c8-560b37dc6e77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:736196b3-c05f-3ae3-b4c8-560b37dc6e77', 3, 'III', 'Molto allegro (Tempo primo)', 'III. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 256 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:736196b3-c05f-3ae3-b4c8-560b37dc6e77'
);


-- Op. 36 호른 로망스 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른 로망스 F장조', 'Romance in F major for Horn', 'song', 'Op. 36', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른 로망스 F장조'
);


-- Op. 48 바이올린 로망스 C장조

UPDATE pieces piece
SET piece.title = '바이올린 로망스 C장조', piece.title_en = 'Romance in C major for Violin',
    piece.type = 'song', piece.opus_number = 'Op. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1320 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 1320 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 44 피아노 협주곡 4번 C단조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 4번 C단조', piece.title_en = 'Piano Concerto No. 4 in C minor',
    piece.type = 'album', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2450 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 2450 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato - Andante', part.name_en = 'I. Allegro moderato - Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2450 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4c57b7e3-669c-3153-9c6c-f4043cfdef3c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c57b7e3-669c-3153-9c6c-f4043cfdef3c', 1, 'I', 'Allegro moderato - Andante', 'I. Allegro moderato - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2450 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c57b7e3-669c-3153-9c6c-f4043cfdef3c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro vivace - Andante - Allegro', part.name_en = 'II. Allegro vivace - Andante - Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2450 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c28c20b5-bd9a-32e7-8d06-60d5f631b942' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c28c20b5-bd9a-32e7-8d06-60d5f631b942', 2, 'II', 'Allegro vivace - Andante - Allegro', 'II. Allegro vivace - Andante - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2450 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c28c20b5-bd9a-32e7-8d06-60d5f631b942'
);


-- None 베토벤 피아노 협주곡 4번 카덴차

UPDATE pieces piece
SET piece.title = '베토벤 피아노 협주곡 4번 카덴차', piece.title_en = 'Cadenzas for Beethoven''s Piano Concerto No. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2514 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 2514 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '카덴차 (Allegro moderato)', part.name_en = 'Cadenza for I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2514 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:cee9a0b8-5f16-4c37-a4f2-63e7fd79f68c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cee9a0b8-5f16-4c37-a4f2-63e7fd79f68c', 1, NULL, '카덴차 (Allegro moderato)', 'Cadenza for I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2514 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cee9a0b8-5f16-4c37-a4f2-63e7fd79f68c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '카덴차 (Rondo. Vivace)', part.name_en = 'Cadenza for III. Rondo (Vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2514 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5bd7bb92-c10c-4cac-9602-d2f2cb304fdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bd7bb92-c10c-4cac-9602-d2f2cb304fdd', 2, NULL, '카덴차 (Rondo. Vivace)', 'Cadenza for III. Rondo (Vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2514 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bd7bb92-c10c-4cac-9602-d2f2cb304fdd'
);


-- Op. 61 바이올린 협주곡 3번 B단조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 3번 B단조', piece.title_en = 'Violin Concerto No. 3 in B minor',
    piece.type = 'album', piece.opus_number = 'Op. 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2825 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 2825 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2825 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:15f11332-cfdc-3657-8941-7cfdb8207277' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15f11332-cfdc-3657-8941-7cfdb8207277', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2825 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f11332-cfdc-3657-8941-7cfdb8207277'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino quasi allegretto', part.name_en = 'II. Andantino quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2825 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:70a870c9-1364-31f6-b27a-8306b28f773b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70a870c9-1364-31f6-b27a-8306b28f773b', 2, 'II', 'Andantino quasi allegretto', 'II. Andantino quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2825 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70a870c9-1364-31f6-b27a-8306b28f773b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto moderato e maestoso - Allegro non troppo', part.name_en = 'III. Molto moderato e maestoso - Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2825 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9bcd1a86-79c6-33ca-9a5a-94ab2fa0ca09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bcd1a86-79c6-33ca-9a5a-94ab2fa0ca09', 3, 'III', 'Molto moderato e maestoso - Allegro non troppo', 'III. Molto moderato e maestoso - Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2825 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bcd1a86-79c6-33ca-9a5a-94ab2fa0ca09'
);


-- Op. 62 바이올린 연주회용 소품 E단조

UPDATE pieces piece
SET piece.title = '바이올린 연주회용 소품 E단조', piece.title_en = 'Morceau de concert in E minor for Violin and Orchestra',
    piece.type = 'song', piece.opus_number = 'Op. 62',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1386 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 1386 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 67 호른 로망스 E장조

UPDATE pieces piece
SET piece.title = '호른 로망스 E장조', piece.title_en = 'Romance in E major for Horn',
    piece.type = 'song', piece.opus_number = 'Op. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2205 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 2205 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 70 알레그로 아파시오나토 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 아파시오나토 C#단조', 'Allegro appassionato in C# minor', 'song', 'Op. 70', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 아파시오나토 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '654e007a-b799-4694-9e28-5aed45583c75'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '654e007a-b799-4694-9e28-5aed45583c75'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '알레그로 아파시오나토 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '654e007a-b799-4694-9e28-5aed45583c75'
);


-- Op. 73 <오베르뉴 랩소디> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<오베르뉴 랩소디> C장조', 'Rhapsodie d''Auvergne in C major', 'song', 'Op. 73', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<오베르뉴 랩소디> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d47945b-a3cb-3cfc-b725-10063c6d7d88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d47945b-a3cb-3cfc-b725-10063c6d7d88'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '<오베르뉴 랩소디> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d47945b-a3cb-3cfc-b725-10063c6d7d88'
);


-- Op. 76 카프리스-왈츠 A♭장조 "웨딩 케이크"

UPDATE pieces piece
SET piece.title = '카프리스-왈츠 A♭장조 "웨딩 케이크"', piece.title_en = 'Caprice-valse in A♭ major "Wedding Cake"',
    piece.type = 'song', piece.opus_number = 'Op. 76',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 621 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 621 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 83 하바네즈 E장조

UPDATE pieces piece
SET piece.title = '하바네즈 E장조', piece.title_en = 'Havanaise in E major',
    piece.type = 'song', piece.opus_number = 'Op. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 511 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 511 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 94 호른 연주회용 소품 F단조

UPDATE pieces piece
SET piece.title = '호른 연주회용 소품 F단조', piece.title_en = 'Morceau de concert in F minor for Horn and Orchestra',
    piece.type = 'song', piece.opus_number = 'Op. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2120 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 2120 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 89 환상곡 <아프리카> G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 <아프리카> G단조', 'Africa, Fantaisie in G minor', 'song', 'Op. 89', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 <아프리카> G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '178dccc6-bfe2-32fb-9b05-b5e1e140ae24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '178dccc6-bfe2-32fb-9b05-b5e1e140ae24'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '환상곡 <아프리카> G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '178dccc6-bfe2-32fb-9b05-b5e1e140ae24'
);


-- Op. 103 피아노 협주곡 5번 F장조 "이집트"

UPDATE pieces piece
SET piece.title = '피아노 협주곡 5번 F장조 "이집트"', piece.title_en = 'Piano Concerto No. 5 in F major "Egyptian"',
    piece.type = 'album', piece.opus_number = 'Op. 103',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 673 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 673 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro animato', part.name_en = 'I. Allegro animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 673 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a04d106e-1068-49d7-b8ab-3c71a828275c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a04d106e-1068-49d7-b8ab-3c71a828275c', 1, 'I', 'Allegro animato', 'I. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 673 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a04d106e-1068-49d7-b8ab-3c71a828275c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 673 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:762c1d21-0631-4170-a2ed-a18bea874d95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:762c1d21-0631-4170-a2ed-a18bea874d95', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 673 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:762c1d21-0631-4170-a2ed-a18bea874d95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto allegro', part.name_en = 'III. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 673 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0ef0471d-052a-42b1-9067-d11ce9aac4b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ef0471d-052a-42b1-9067-d11ce9aac4b0', 3, 'III', 'Molto allegro', 'III. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 673 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ef0471d-052a-42b1-9067-d11ce9aac4b0'
);


-- None 베토벤 바이올린 협주곡 카덴차

UPDATE pieces piece
SET piece.title = '베토벤 바이올린 협주곡 카덴차', piece.title_en = 'Cadenzas for Beethoven''s Violin Concerto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2863 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 2863 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 119 첼로 협주곡 2번 D단조

UPDATE pieces piece
SET piece.title = '첼로 협주곡 2번 D단조', piece.title_en = 'Cello Concerto No. 2 in D minor',
    piece.type = 'album', piece.opus_number = 'Op. 119',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2593 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 2593 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato e maestoso', part.name_en = 'I. Allegro moderato e maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2593 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:861624eb-adcf-4a2f-bb94-39e3330951c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:861624eb-adcf-4a2f-bb94-39e3330951c0', 1, 'I', 'Allegro moderato e maestoso', 'I. Allegro moderato e maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2593 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:861624eb-adcf-4a2f-bb94-39e3330951c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro non troppo', part.name_en = 'II. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2593 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5dd5ea9f-573c-4a4c-8e69-a2431018c764' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dd5ea9f-573c-4a4c-8e69-a2431018c764', 2, 'II', 'Allegro non troppo', 'II. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2593 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dd5ea9f-573c-4a4c-8e69-a2431018c764'
);


-- Op. 122 <안달루시아 카프리스> G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<안달루시아 카프리스> G장조', 'Caprice andalou in G major', 'song', 'Op. 122', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<안달루시아 카프리스> G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b80028e-3ee7-4136-bb32-d96e43be13ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b80028e-3ee7-4136-bb32-d96e43be13ef'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '<안달루시아 카프리스> G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b80028e-3ee7-4136-bb32-d96e43be13ef'
);


-- Op. 132 <뮤즈와 시인> E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<뮤즈와 시인> E단조', 'La muse et le poète in E minor', 'song', 'Op. 132', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<뮤즈와 시인> E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd20898f8-01dd-43b6-a7a3-39213ee7f241'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd20898f8-01dd-43b6-a7a3-39213ee7f241'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '<뮤즈와 시인> E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd20898f8-01dd-43b6-a7a3-39213ee7f241'
);


-- R. 281 모차르트 피아노 협주곡 22번 카덴차

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모차르트 피아노 협주곡 22번 카덴차', 'Cadenzas for Mozart''s Piano Concerto No. 22, K. 482', 'song', 'R. 281', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모차르트 피아노 협주곡 22번 카덴차'
);


-- R. 279 모차르트 피아노 협주곡 24번 카덴차

UPDATE pieces piece
SET piece.title = '모차르트 피아노 협주곡 24번 카덴차', piece.title_en = 'Cadenzas for Mozart''s Piano Concerto No. 24, K. 491',
    piece.type = 'album', piece.opus_number = 'R. 279',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1911, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2627 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1911
WHERE piece.id = 2627 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '카덴차 (Allegro)', part.name_en = 'Cadenza for I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2627 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:52301e58-b69c-4e17-8372-c1ceff93209d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52301e58-b69c-4e17-8372-c1ceff93209d', 1, NULL, '카덴차 (Allegro)', 'Cadenza for I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2627 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52301e58-b69c-4e17-8372-c1ceff93209d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '카덴차 (Allegretto)', part.name_en = 'Cadenza for III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2627 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b55d3f09-ca28-4bb2-b3dc-ff0cc4a8381c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b55d3f09-ca28-4bb2-b3dc-ff0cc4a8381c', 2, NULL, '카덴차 (Allegretto)', 'Cadenza for III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2627 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b55d3f09-ca28-4bb2-b3dc-ff0cc4a8381c'
);


-- Op. 154 하프 연주회용 소품 G장조

UPDATE pieces piece
SET piece.title = '하프 연주회용 소품 G장조', piece.title_en = 'Morceau de concert in G major for Harp and Orchestra',
    piece.type = 'album', piece.opus_number = 'Op. 154',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1974 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 1974 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo – Allegro moderato', part.name_en = 'I. Allegro non troppo – Allegro moderato – attaca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1974 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a333f722-3cc3-4126-b335-189c3c13668f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a333f722-3cc3-4126-b335-189c3c13668f', 1, 'I', 'Allegro non troppo – Allegro moderato', 'I. Allegro non troppo – Allegro moderato – attaca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1974 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a333f722-3cc3-4126-b335-189c3c13668f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1974 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e173b4f4-ab6a-4621-9e72-11654288fac8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e173b4f4-ab6a-4621-9e72-11654288fac8', 2, 'II', 'Andante sostenuto', 'II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1974 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e173b4f4-ab6a-4621-9e72-11654288fac8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto allegro quasi presto', part.name_en = 'III. Molto allegro quasi presto – attaca',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1974 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7a90486a-cf65-420c-8f91-2c833894d16d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a90486a-cf65-420c-8f91-2c833894d16d', 3, 'III', 'Molto allegro quasi presto', 'III. Molto allegro quasi presto – attaca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1974 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a90486a-cf65-420c-8f91-2c833894d16d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo – Animato – Molto allegro', part.name_en = 'IV. Allegro non troppo – Animato – Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1974 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ef8ae0ef-4d83-4277-a232-d5cbe9c1c12a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef8ae0ef-4d83-4277-a232-d5cbe9c1c12a', 4, 'IV', 'Allegro non troppo – Animato – Molto allegro', 'IV. Allegro non troppo – Animato – Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1974 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef8ae0ef-4d83-4277-a232-d5cbe9c1c12a'
);


-- Op. 156 <사이프러스와 월계수> D단조

UPDATE pieces piece
SET piece.title = '<사이프러스와 월계수> D단조', piece.title_en = 'Cyprès et lauriers in D minor',
    piece.type = 'album', piece.opus_number = 'Op. 156',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2162 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 2162 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '사이프러스', part.name_en = 'I. Cyprès',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2162 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5957f36a-82bf-4792-8282-d39d44a73de8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5957f36a-82bf-4792-8282-d39d44a73de8', 1, 'I', '사이프러스', 'I. Cyprès', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2162 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5957f36a-82bf-4792-8282-d39d44a73de8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '월계수', part.name_en = 'II. Lauriers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2162 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9d602f75-8707-47dc-b6bd-de8f7d728664' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d602f75-8707-47dc-b6bd-de8f7d728664', 2, 'II', '월계수', 'II. Lauriers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2162 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d602f75-8707-47dc-b6bd-de8f7d728664'
);


-- Op. 162 플루트와 관현악을 위한 오들레트 Op. 162

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '162'
WHERE piece.id = 476 AND piece.composer_id = 60
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1920
WHERE piece.id = 476 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- R. 107 피아노 4중주 E장조

UPDATE pieces piece
SET piece.title = '피아노 4중주 E장조', piece.title_en = 'Piano Quartet in E major',
    piece.type = 'album', piece.opus_number = 'R. 107',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 510 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 510 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poco andante maestoso – Allegro vivace', part.name_en = 'I. Poco andante maestoso – Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 510 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ab38e123-3fa0-4b7f-9331-d957f198a9f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab38e123-3fa0-4b7f-9331-d957f198a9f6', 1, 'I', 'Poco andante maestoso – Allegro vivace', 'I. Poco andante maestoso – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 510 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab38e123-3fa0-4b7f-9331-d957f198a9f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 510 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b868331e-aa57-431e-aad3-b33cd8dc6d7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b868331e-aa57-431e-aad3-b33cd8dc6d7e', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 510 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b868331e-aa57-431e-aad3-b33cd8dc6d7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레. Allegro con fuoco', part.name_en = 'III. Finale. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 510 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7f5c953c-550d-4926-ac0d-403b84f9f8a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f5c953c-550d-4926-ac0d-403b84f9f8a7', 3, 'III', '피날레. Allegro con fuoco', 'III. Finale. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 510 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f5c953c-550d-4926-ac0d-403b84f9f8a7'
);


-- Op. 14 피아노 5중주 A단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 A단조', piece.title_en = 'Piano Quintet in A minor',
    piece.type = 'album', piece.opus_number = 'Op. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1701 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 1701 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato e maestoso', part.name_en = 'I. Allegro moderato e maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1701 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:40eed0e8-a95f-4073-97f5-644e1f9be9cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40eed0e8-a95f-4073-97f5-644e1f9be9cc', 1, 'I', 'Allegro moderato e maestoso', 'I. Allegro moderato e maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1701 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40eed0e8-a95f-4073-97f5-644e1f9be9cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante sostenuto', part.name_en = 'II. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1701 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5f6c55ba-153e-4790-9496-36fac3c0b429' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f6c55ba-153e-4790-9496-36fac3c0b429', 2, 'II', 'Andante sostenuto', 'II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1701 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f6c55ba-153e-4790-9496-36fac3c0b429'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1701 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:76f967c6-c259-4690-acd3-f79b61d49fbd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76f967c6-c259-4690-acd3-f79b61d49fbd', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1701 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76f967c6-c259-4690-acd3-f79b61d49fbd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro assai, ma tranquillo', part.name_en = 'IV. Allegro assai, ma tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1701 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:aa440d81-6a3e-4adc-ab95-87ed54de270b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa440d81-6a3e-4adc-ab95-87ed54de270b', 4, 'IV', 'Allegro assai, ma tranquillo', 'IV. Allegro assai, ma tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1701 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa440d81-6a3e-4adc-ab95-87ed54de270b'
);


-- None 바이올린과 피아노를 위한 화려한 카프리스 B단조

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 화려한 카프리스 B단조', piece.title_en = 'Caprice brillant in B minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2600 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 2600 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 16 첼로와 피아노를 위한 모음곡

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 모음곡', piece.title_en = 'Suite for Cello and Piano',
    piece.type = 'album', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2468 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 2468 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2468 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d16c79e2-8713-4256-92a4-f522896b9bbb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d16c79e2-8713-4256-92a4-f522896b9bbb', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2468 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d16c79e2-8713-4256-92a4-f522896b9bbb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '세레나데', part.name_en = 'II. Sérénade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2468 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ca4237b2-2661-4a02-807b-1a402d4e06ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca4237b2-2661-4a02-807b-1a402d4e06ed', 2, 'II', '세레나데', 'II. Sérénade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2468 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca4237b2-2661-4a02-807b-1a402d4e06ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초', part.name_en = 'III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2468 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:04d60b79-baea-4241-9fce-272149ca1c30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04d60b79-baea-4241-9fce-272149ca1c30', 3, 'III', '스케르초', 'III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2468 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04d60b79-baea-4241-9fce-272149ca1c30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '로망스', part.name_en = 'IV. Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2468 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:30871e11-6463-4c4d-8720-2e53e3abc090' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30871e11-6463-4c4d-8720-2e53e3abc090', 4, 'IV', '로망스', 'IV. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2468 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30871e11-6463-4c4d-8720-2e53e3abc090'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레', part.name_en = 'V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2468 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:86064eee-3c20-4853-af9e-136d67696e94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86064eee-3c20-4853-af9e-136d67696e94', 5, 'V', '피날레', 'V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2468 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86064eee-3c20-4853-af9e-136d67696e94'
);


-- Op. 18 피아노 3중주 1번 F장조

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번 F장조', piece.title_en = 'Piano Trio No. 1 in F major',
    piece.type = 'album', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1863, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2169 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1863
WHERE piece.id = 2169 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2870 AND linked.composer_id = 60),
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivace', part.name_en = 'I. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2169 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ab42f37e-126f-46bd-878f-292929038b74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2870 AND linked.composer_id = 60), 'musicbrainz:ab42f37e-126f-46bd-878f-292929038b74', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2169 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab42f37e-126f-46bd-878f-292929038b74'
);

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번 F장조 중 "Allegro vivace"', piece.title_en = 'Piano Trio No. 1 in F major: I. Allegro vivace', piece.editor_locked = 1
WHERE piece.id = 2870 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2186 AND linked.composer_id = 60),
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2169 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c8968dd9-03c7-4a0a-93ad-4aaa31f65e42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2186 AND linked.composer_id = 60), 'musicbrainz:c8968dd9-03c7-4a0a-93ad-4aaa31f65e42', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2169 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8968dd9-03c7-4a0a-93ad-4aaa31f65e42'
);

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번 F장조 중 "Andante"', piece.title_en = 'Piano Trio No. 1 in F major: II. Andante', piece.editor_locked = 1
WHERE piece.id = 2186 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 956 AND linked.composer_id = 60),
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Presto', part.name_en = 'III. Scherzo. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2169 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4a9b3291-f761-4f6c-912f-0574d1a11c6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 956 AND linked.composer_id = 60), 'musicbrainz:4a9b3291-f761-4f6c-912f-0574d1a11c6f', 3, 'III', '스케르초. Presto', 'III. Scherzo. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2169 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a9b3291-f761-4f6c-912f-0574d1a11c6f'
);

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번 F장조 중 "스케르초. Presto"', piece.title_en = 'Piano Trio No. 1 in F major: III. Scherzo. Presto', piece.editor_locked = 1
WHERE piece.id = 956 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2384 AND linked.composer_id = 60),
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2169 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d13b0639-62ac-4407-971c-a74288abe2b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2384 AND linked.composer_id = 60), 'musicbrainz:d13b0639-62ac-4407-971c-a74288abe2b2', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2169 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d13b0639-62ac-4407-971c-a74288abe2b2'
);

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번 F장조 중 "Allegro"', piece.title_en = 'Piano Trio No. 1 in F major: IV. Allegro', piece.editor_locked = 1
WHERE piece.id = 2384 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 15 세레나데 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데 E♭장조', 'Sérénade in E♭ major', 'song', 'Op. 15', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9aa24e79-483c-4286-a903-54eb193f8d15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9aa24e79-483c-4286-a903-54eb193f8d15'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '세레나데 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9aa24e79-483c-4286-a903-54eb193f8d15'
);


-- Op. 27 바이올린, 피아노, 오르간을 위한 로망스 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린, 피아노, 오르간을 위한 로망스 B♭장조', 'Romance in B♭ major for Violin, Piano and Organ', 'song', 'Op. 27', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린, 피아노, 오르간을 위한 로망스 B♭장조'
);


-- None <파리의 냄새>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<파리의 냄새>', 'Les odeurs de Paris', 'song', NULL, NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<파리의 냄새>'
);


-- Op. 38 바이올린 자장가 B♭장조

UPDATE pieces piece
SET piece.title = '바이올린 자장가 B♭장조', piece.title_en = 'Berceuse in B♭ major for Violin and Piano',
    piece.type = 'song', piece.opus_number = 'Op. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 857 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 857 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 32 첼로 소나타 1번 C단조

UPDATE pieces piece
SET piece.title = '첼로 소나타 1번 C단조', piece.title_en = 'Cello Sonata No. 1 in C minor',
    piece.type = 'album', piece.opus_number = 'Op. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2266 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 2266 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2266 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7b36f28a-567e-4313-8dfe-209a4b869bd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b36f28a-567e-4313-8dfe-209a4b869bd7', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2266 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b36f28a-567e-4313-8dfe-209a4b869bd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante tranquillo sostenuto', part.name_en = 'II. Andante tranquillo sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2266 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5b0346fb-e3d0-4b6d-abd6-ddfcf2fc57ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b0346fb-e3d0-4b6d-abd6-ddfcf2fc57ec', 2, 'II', 'Andante tranquillo sostenuto', 'II. Andante tranquillo sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2266 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b0346fb-e3d0-4b6d-abd6-ddfcf2fc57ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato', part.name_en = 'III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2266 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:98cec813-160f-43bc-b4fb-568f238e7749' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98cec813-160f-43bc-b4fb-568f238e7749', 3, 'III', 'Allegro moderato', 'III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2266 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98cec813-160f-43bc-b4fb-568f238e7749'
);


-- Op. 41 피아노 4중주 B♭장조

UPDATE pieces piece
SET piece.title = '피아노 4중주 B♭장조', piece.title_en = 'Piano Quartet in B♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1345 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 1345 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1345 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d595fdd9-0041-4dc8-90a0-718e019e8afd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d595fdd9-0041-4dc8-90a0-718e019e8afd', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1345 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d595fdd9-0041-4dc8-90a0-718e019e8afd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante maestoso ma con moto', part.name_en = 'II. Andante maestoso ma con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1345 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e5d50f8e-12ff-499b-a2c7-c4f767f72d07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5d50f8e-12ff-499b-a2c7-c4f767f72d07', 2, 'II', 'Andante maestoso ma con moto', 'II. Andante maestoso ma con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1345 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5d50f8e-12ff-499b-a2c7-c4f767f72d07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Poco allegro più tosto moderato', part.name_en = 'III. Poco allegro più tosto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1345 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:013f64f2-95c7-47b2-a8bd-697b43bd5911' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:013f64f2-95c7-47b2-a8bd-697b43bd5911', 3, 'III', 'Poco allegro più tosto moderato', 'III. Poco allegro più tosto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1345 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:013f64f2-95c7-47b2-a8bd-697b43bd5911'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1345 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9f59c16e-323f-4a65-976f-7eea9939f5f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f59c16e-323f-4a65-976f-7eea9939f5f6', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1345 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f59c16e-323f-4a65-976f-7eea9939f5f6'
);


-- Op. 43 첼로를 위한 알레그로 아파시오나토 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로를 위한 알레그로 아파시오나토 B단조', 'Allegro appassionato in B minor for Cello', 'song', 'Op. 43', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로를 위한 알레그로 아파시오나토 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cc6ec48-2b7c-4183-a4e7-b6a70e6ea054'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7cc6ec48-2b7c-4183-a4e7-b6a70e6ea054'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '첼로를 위한 알레그로 아파시오나토 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cc6ec48-2b7c-4183-a4e7-b6a70e6ea054'
);


-- Op. 51 첼로 로망스 D장조

UPDATE pieces piece
SET piece.title = '첼로 로망스 D장조', piece.title_en = 'Romance in D major for Cello and Piano',
    piece.type = 'song', piece.opus_number = 'Op. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1055 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 1055 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 65 7중주 E♭장조

UPDATE pieces piece
SET piece.title = '7중주 E♭장조', piece.title_en = 'Septet in E♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1878 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 1878 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주. Allegro moderato', part.name_en = 'I. Préambule. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1878 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8f062502-379a-40a9-b4ec-273f8afd7a8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f062502-379a-40a9-b4ec-273f8afd7a8c', 1, 'I', '전주. Allegro moderato', 'I. Préambule. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1878 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f062502-379a-40a9-b4ec-273f8afd7a8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '미뉴에트. Tempo di minuetto moderato', part.name_en = 'II. Menuet. Tempo di minuetto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1878 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c54574a5-78cd-4823-8690-565b131f02f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c54574a5-78cd-4823-8690-565b131f02f0', 2, 'II', '미뉴에트. Tempo di minuetto moderato', 'II. Menuet. Tempo di minuetto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1878 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c54574a5-78cd-4823-8690-565b131f02f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '간주곡. Andante', part.name_en = 'III. Intermède. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1878 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:37a1f9d8-29a0-41bc-a3f9-c578a4a05d3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37a1f9d8-29a0-41bc-a3f9-c578a4a05d3f', 3, 'III', '간주곡. Andante', 'III. Intermède. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1878 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37a1f9d8-29a0-41bc-a3f9-c578a4a05d3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '가보트와 피날레. Allegro ma non troppo', part.name_en = 'IV. Gavotte & final. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1878 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f0c65480-b0d3-4d00-a165-58379fe8e45c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0c65480-b0d3-4d00-a165-58379fe8e45c', 4, 'IV', '가보트와 피날레. Allegro ma non troppo', 'IV. Gavotte & final. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1878 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0c65480-b0d3-4d00-a165-58379fe8e45c'
);


-- Op. 75 바이올린 소나타 1번 D단조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 1번 D단조', piece.title_en = 'Violin Sonata No. 1 in D minor',
    piece.type = 'album', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 631 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 631 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro agitato – Adagio', part.name_en = 'I. Allegro agitato – Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 631 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:cf9a7101-d291-398b-8288-3a8a3e87d9c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf9a7101-d291-398b-8288-3a8a3e87d9c5', 1, 'I', 'Allegro agitato – Adagio', 'I. Allegro agitato – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 631 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf9a7101-d291-398b-8288-3a8a3e87d9c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto moderato – Allegro molto', part.name_en = 'II. Allegretto moderato – Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 631 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e5552953-75a7-3ad5-838a-28bad922bb2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5552953-75a7-3ad5-838a-28bad922bb2c', 2, 'II', 'Allegretto moderato – Allegro molto', 'II. Allegretto moderato – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 631 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5552953-75a7-3ad5-838a-28bad922bb2c'
);


-- R. 125 동물의 사육제

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7342dc65-b59b-448f-bfa3-7b8002e470d5'
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7342dc65-b59b-448f-bfa3-7b8002e470d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서주와 사자 왕의 행진', part.name_en = 'Introduction et marche royale du lion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2b49b461-64df-3183-bc1f-b95f4d298daf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b49b461-64df-3183-bc1f-b95f4d298daf', 1, NULL, '서주와 사자 왕의 행진', 'Introduction et marche royale du lion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b49b461-64df-3183-bc1f-b95f4d298daf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '암탉과 수탉', part.name_en = 'Poules et coqs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:98bc35f0-9a59-3366-9c6b-5a1c57d021ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98bc35f0-9a59-3366-9c6b-5a1c57d021ac', 2, NULL, '암탉과 수탉', 'Poules et coqs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98bc35f0-9a59-3366-9c6b-5a1c57d021ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '야생 당나귀', part.name_en = 'Hémiones (Animaux véloces)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:18b60b1e-c357-3dfd-85a3-e946aa0c8e43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18b60b1e-c357-3dfd-85a3-e946aa0c8e43', 3, NULL, '야생 당나귀', 'Hémiones (Animaux véloces)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18b60b1e-c357-3dfd-85a3-e946aa0c8e43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '거북', part.name_en = 'Tortues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:320bdcd7-fcf8-3d54-8c91-bd96db38757e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:320bdcd7-fcf8-3d54-8c91-bd96db38757e', 4, NULL, '거북', 'Tortues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:320bdcd7-fcf8-3d54-8c91-bd96db38757e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '코끼리', part.name_en = 'L''éléphant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c7ddc127-bc35-3460-8033-60ce47099861' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7ddc127-bc35-3460-8033-60ce47099861', 5, NULL, '코끼리', 'L''éléphant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ddc127-bc35-3460-8033-60ce47099861'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '캥거루', part.name_en = 'Kangourous',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:001587a1-bf3c-3d41-a389-211656b8d591' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:001587a1-bf3c-3d41-a389-211656b8d591', 6, NULL, '캥거루', 'Kangourous', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:001587a1-bf3c-3d41-a389-211656b8d591'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '수족관', part.name_en = 'Aquarium',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6297353e-063b-3a86-b457-caa690397443' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6297353e-063b-3a86-b457-caa690397443', 7, NULL, '수족관', 'Aquarium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6297353e-063b-3a86-b457-caa690397443'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '귀가 긴 등장인물', part.name_en = 'Personnages à longues oreilles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c2915374-0225-30a2-b285-09883b6f762b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2915374-0225-30a2-b285-09883b6f762b', 8, NULL, '귀가 긴 등장인물', 'Personnages à longues oreilles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2915374-0225-30a2-b285-09883b6f762b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '숲속의 뻐꾸기', part.name_en = 'Le coucou au fond des bois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:dea9bde9-a588-3e19-8da1-dc59d3dda73a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea9bde9-a588-3e19-8da1-dc59d3dda73a', 9, NULL, '숲속의 뻐꾸기', 'Le coucou au fond des bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea9bde9-a588-3e19-8da1-dc59d3dda73a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '큰 새장', part.name_en = 'Volière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6e19673d-d126-3f6d-a26e-42d03630ac65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e19673d-d126-3f6d-a26e-42d03630ac65', 10, NULL, '큰 새장', 'Volière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e19673d-d126-3f6d-a26e-42d03630ac65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '피아니스트', part.name_en = 'Pianistes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e81ae2e8-20e4-34cb-9b95-0111a012de8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e81ae2e8-20e4-34cb-9b95-0111a012de8b', 11, NULL, '피아니스트', 'Pianistes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e81ae2e8-20e4-34cb-9b95-0111a012de8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '화석', part.name_en = 'Fossiles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:07672a08-3570-3a17-a930-c69d32ad939d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07672a08-3570-3a17-a930-c69d32ad939d', 12, NULL, '화석', 'Fossiles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07672a08-3570-3a17-a930-c69d32ad939d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '백조', part.name_en = 'Le cygne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7d078026-e006-3fe1-b5d2-2a865f82ccef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d078026-e006-3fe1-b5d2-2a865f82ccef', 13, NULL, '백조', 'Le cygne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d078026-e006-3fe1-b5d2-2a865f82ccef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '피날레', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 252 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:90581120-3c85-3902-8e21-4656fc5b53e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90581120-3c85-3902-8e21-4656fc5b53e2', 14, NULL, '피날레', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 252 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90581120-3c85-3902-8e21-4656fc5b53e2'
);


-- Op. 79 덴마크와 러시아 선율에 의한 카프리스

UPDATE pieces piece
SET piece.title = '덴마크와 러시아 선율에 의한 카프리스', piece.title_en = 'Caprice sur des airs danois et russes',
    piece.type = 'song', piece.opus_number = 'Op. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1400 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 1400 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 91 <사포의 노래>

UPDATE pieces piece
SET piece.title = '<사포의 노래>', piece.title_en = 'Chant saphique',
    piece.type = 'song', piece.opus_number = 'Op. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 987 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 987 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 92 피아노 3중주 2번 E단조

UPDATE pieces piece
SET piece.title = '피아노 3중주 2번 E단조', piece.title_en = 'Piano Trio No. 2 in E minor',
    piece.type = 'album', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2354 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 2354 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non troppo', part.name_en = 'I. Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2354 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c25e4abf-28fe-4b06-88d0-5a5b77ecafd3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c25e4abf-28fe-4b06-88d0-5a5b77ecafd3', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2354 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c25e4abf-28fe-4b06-88d0-5a5b77ecafd3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2354 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2548a4ab-fdc3-4c0d-8f8d-389809d54d4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2548a4ab-fdc3-4c0d-8f8d-389809d54d4e', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2354 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2548a4ab-fdc3-4c0d-8f8d-389809d54d4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante con moto', part.name_en = 'III. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2354 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8f0c3b5a-2c6a-469c-b087-3f6ccf7d0345' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f0c3b5a-2c6a-469c-b087-3f6ccf7d0345', 3, 'III', 'Andante con moto', 'III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2354 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f0c3b5a-2c6a-469c-b087-3f6ccf7d0345'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Grazioso, poco allegro', part.name_en = 'IV. Grazioso, poco allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2354 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6a81a959-5e26-4b44-9b79-d815e0fb12cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a81a959-5e26-4b44-9b79-d815e0fb12cd', 4, 'IV', 'Grazioso, poco allegro', 'IV. Grazioso, poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2354 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a81a959-5e26-4b44-9b79-d815e0fb12cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro', part.name_en = 'V. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2354 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:42204b03-fc2e-41c2-abc0-8661c4d7963a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42204b03-fc2e-41c2-abc0-8661c4d7963a', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2354 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42204b03-fc2e-41c2-abc0-8661c4d7963a'
);


-- Op. 95 하프를 위한 환상곡 A단조

UPDATE pieces piece
SET piece.title = '하프를 위한 환상곡 A단조', piece.title_en = 'Fantaisie in A minor for Harp',
    piece.type = 'song', piece.opus_number = 'Op. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1200 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 1200 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 102 바이올린 소나타 2번 E♭장조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 E♭장조', piece.title_en = 'Violin Sonata No. 2 in E♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 102',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1743 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 1743 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Poco allegro più tosto moderato', part.name_en = 'I. Poco Allegro più tosto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7d724d52-df64-4afd-b90e-a4f16de9ea53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d724d52-df64-4afd-b90e-a4f16de9ea53', 1, 'I', 'Poco allegro più tosto moderato', 'I. Poco Allegro più tosto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d724d52-df64-4afd-b90e-a4f16de9ea53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Vivace', part.name_en = 'II. Scherzo vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:48d0002e-3c2b-4b48-8e08-61d72fe1a1e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48d0002e-3c2b-4b48-8e08-61d72fe1a1e8', 2, 'II', '스케르초. Vivace', 'II. Scherzo vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48d0002e-3c2b-4b48-8e08-61d72fe1a1e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:597de31e-2930-49ab-afa1-2215bcf67ff3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:597de31e-2930-49ab-afa1-2215bcf67ff3', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:597de31e-2930-49ab-afa1-2215bcf67ff3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro grazioso, non presto', part.name_en = 'IV. Allegro grazioso, non presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ca77e29f-e9b6-4b81-b911-639cf302e4d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca77e29f-e9b6-4b81-b911-639cf302e4d7', 4, 'IV', 'Allegro grazioso, non presto', 'IV. Allegro grazioso, non presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca77e29f-e9b6-4b81-b911-639cf302e4d7'
);


-- Op. 108 뱃노래 F장조

UPDATE pieces piece
SET piece.title = '뱃노래 F장조', piece.title_en = 'Barcarolle in F major',
    piece.type = 'song', piece.opus_number = 'Op. 108',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1897, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 917 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1897
WHERE piece.id = 917 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 112 현악 4중주 1번 E단조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 E단조', piece.title_en = 'String Quartet No. 1 in E minor',
    piece.type = 'album', piece.opus_number = 'Op. 112',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3002 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 3002 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3002 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5702b5a4-939f-4349-a5c5-1daf8682def0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5702b5a4-939f-4349-a5c5-1daf8682def0', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3002 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5702b5a4-939f-4349-a5c5-1daf8682def0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto allegro quasi presto', part.name_en = 'II. Molto allegro quasi presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3002 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:79daec37-2e7b-4bc8-9bf5-31411c0ad31f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79daec37-2e7b-4bc8-9bf5-31411c0ad31f', 2, 'II', 'Molto allegro quasi presto', 'II. Molto allegro quasi presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3002 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79daec37-2e7b-4bc8-9bf5-31411c0ad31f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto adagio', part.name_en = 'III. Molto adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3002 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d7ae1728-1d24-40b6-94df-eac8486e19a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7ae1728-1d24-40b6-94df-eac8486e19a3', 3, 'III', 'Molto adagio', 'III. Molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3002 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7ae1728-1d24-40b6-94df-eac8486e19a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo', part.name_en = 'IV. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3002 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d6572938-4826-4d5a-bb81-781a4e762b04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6572938-4826-4d5a-bb81-781a4e762b04', 4, 'IV', 'Allegro non troppo', 'IV. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3002 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6572938-4826-4d5a-bb81-781a4e762b04'
);


-- Op. 123 첼로 소나타 2번 F장조

UPDATE pieces piece
SET piece.title = '첼로 소나타 2번 F장조', piece.title_en = 'Cello Sonata No. 2 in F major',
    piece.type = 'album', piece.opus_number = 'Op. 123',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1228 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 1228 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Maestoso, largamente', part.name_en = 'I. Maestoso, largamente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1228 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4d793fe6-0771-4fbe-a684-3ca60eb06921' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d793fe6-0771-4fbe-a684-3ca60eb06921', 1, 'I', 'Maestoso, largamente', 'I. Maestoso, largamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1228 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d793fe6-0771-4fbe-a684-3ca60eb06921'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초와 변주', part.name_en = 'II. Scherzo con variazioni',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1228 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a79e0558-95a1-4f65-b9cc-3a238c1b70bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a79e0558-95a1-4f65-b9cc-3a238c1b70bd', 2, 'II', '스케르초와 변주', 'II. Scherzo con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1228 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a79e0558-95a1-4f65-b9cc-3a238c1b70bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '로망스', part.name_en = 'III. Romanza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1228 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f9f4be03-1ffd-469f-b09d-703c47468e6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9f4be03-1ffd-469f-b09d-703c47468e6f', 3, 'III', '로망스', 'III. Romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1228 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f4be03-1ffd-469f-b09d-703c47468e6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo grazioso', part.name_en = 'IV. Allegro non troppo grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1228 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:06c8d760-f4c6-4935-890e-942fc9ea088a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06c8d760-f4c6-4935-890e-942fc9ea088a', 4, 'IV', 'Allegro non troppo grazioso', 'IV. Allegro non troppo grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1228 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06c8d760-f4c6-4935-890e-942fc9ea088a'
);


-- Op. 124 바이올린과 하프를 위한 환상곡

UPDATE pieces piece
SET piece.title = '바이올린과 하프를 위한 환상곡', piece.title_en = 'Fantaisie for Violin and Harp',
    piece.type = 'song', piece.opus_number = 'Op. 124',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1907, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2732 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1907
WHERE piece.id = 2732 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 136 바이올린과 피아노를 위한 <삼면화>

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 <삼면화>', piece.title_en = 'Triptyque',
    piece.type = 'album', piece.opus_number = 'Op. 136',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1107 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 1107 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prémice', part.name_en = 'I. Prémice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1107 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:65055e15-9d1c-4d33-aac0-8230847266c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65055e15-9d1c-4d33-aac0-8230847266c4', 1, 'I', 'Prémice', 'I. Prémice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1107 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65055e15-9d1c-4d33-aac0-8230847266c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Vision congolaise', part.name_en = 'II. Vision congolaise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1107 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2a61c761-bde0-4b31-ae06-9799bd94125d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a61c761-bde0-4b31-ae06-9799bd94125d', 2, 'II', 'Vision congolaise', 'II. Vision congolaise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1107 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a61c761-bde0-4b31-ae06-9799bd94125d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Joyeuseté', part.name_en = 'III. Joyeuseté',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1107 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e7c52abc-7e25-4539-bb60-ebbb924dea82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7c52abc-7e25-4539-bb60-ebbb924dea82', 3, 'III', 'Joyeuseté', 'III. Joyeuseté', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1107 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7c52abc-7e25-4539-bb60-ebbb924dea82'
);


-- Op. 143 엘레지 1번

UPDATE pieces piece
SET piece.title = '엘레지 1번', piece.title_en = 'Élégie No. 1',
    piece.type = 'song', piece.opus_number = 'Op. 143',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1299 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 1299 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 144 트롬본 카바티나 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트롬본 카바티나 D♭장조', 'Cavatine in D♭ major for Trombone and Piano', 'song', 'Op. 144', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트롬본 카바티나 D♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a037f28-8aea-433e-ad61-ba0d834b67e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a037f28-8aea-433e-ad61-ba0d834b67e1'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '트롬본 카바티나 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a037f28-8aea-433e-ad61-ba0d834b67e1'
);


-- None <시계의 노래>

UPDATE pieces piece
SET piece.title = '<시계의 노래>', piece.title_en = 'L''air de la pendule',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2306 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 2306 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 153 현악 4중주 2번 G장조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 G장조', piece.title_en = 'String Quartet No. 2 in G major',
    piece.type = 'album', piece.opus_number = 'Op. 153',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2927 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 2927 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro animato', part.name_en = 'I. Allegro animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2927 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:cb3a7a0f-8386-49b4-a3fa-164f1e583c53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb3a7a0f-8386-49b4-a3fa-164f1e583c53', 1, 'I', 'Allegro animato', 'I. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2927 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb3a7a0f-8386-49b4-a3fa-164f1e583c53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Molto adagio - Andantino', part.name_en = 'II. Molto adagio - Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2927 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:cefbe5ba-dce2-4369-a3fc-e33c704017fe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cefbe5ba-dce2-4369-a3fc-e33c704017fe', 2, 'II', 'Molto adagio - Andantino', 'II. Molto adagio - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2927 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cefbe5ba-dce2-4369-a3fc-e33c704017fe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '간주곡과 피날레. Andantino – Allegretto con moto', part.name_en = 'III. Interlude et finale. Andantino – Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2927 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:116d2075-825b-475d-a7f6-a816675ab40c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:116d2075-825b-475d-a7f6-a816675ab40c', 3, 'III', '간주곡과 피날레. Andantino – Allegretto con moto', 'III. Interlude et finale. Andantino – Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2927 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:116d2075-825b-475d-a7f6-a816675ab40c'
);


-- Op. 158 첼로와 오르간을 위한 <기도>

UPDATE pieces piece
SET piece.title = '첼로와 오르간을 위한 <기도>', piece.title_en = 'Prière for Cello and Organ',
    piece.type = 'song', piece.opus_number = 'Op. 158',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 584 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 584 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 160 엘레지 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '엘레지 2번', 'Élégie No. 2', 'song', 'Op. 160', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '엘레지 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58e9bc33-1cfe-4668-ad24-070eb73607eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58e9bc33-1cfe-4668-ad24-070eb73607eb'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '엘레지 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58e9bc33-1cfe-4668-ad24-070eb73607eb'
);


-- Op. 166 오보에 소나타 D장조

UPDATE pieces piece
SET piece.title = '오보에 소나타 D장조', piece.title_en = 'Oboe Sonata in D major',
    piece.type = 'album', piece.opus_number = 'Op. 166',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2371 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 2371 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = 'I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2371 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:92a5576d-0cc6-42ac-bc9f-1a6d0359504c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92a5576d-0cc6-42ac-bc9f-1a6d0359504c', 1, 'I', 'Andantino', 'I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2371 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a5576d-0cc6-42ac-bc9f-1a6d0359504c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '파스토랄', part.name_en = 'II. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2371 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1f2d7caf-0b8f-4ea1-bc6a-f8b49bee48c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f2d7caf-0b8f-4ea1-bc6a-f8b49bee48c1', 2, 'II', '파스토랄', 'II. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2371 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f2d7caf-0b8f-4ea1-bc6a-f8b49bee48c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto allegro', part.name_en = 'III. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2371 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f28b57c5-84e2-4cbc-8364-6e1f2f4ef8fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f28b57c5-84e2-4cbc-8364-6e1f2f4ef8fb', 3, 'III', 'Molto allegro', 'III. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2371 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f28b57c5-84e2-4cbc-8364-6e1f2f4ef8fb'
);


-- Op. 167 클라리넷 소나타 E♭장조

UPDATE pieces piece
SET piece.title = '클라리넷 소나타 E♭장조', piece.title_en = 'Clarinet Sonata in E♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 167',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 928 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 928 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 928 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:68df11a2-29a0-4816-ab38-d133623a6c12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68df11a2-29a0-4816-ab38-d133623a6c12', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 928 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68df11a2-29a0-4816-ab38-d133623a6c12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro animato', part.name_en = 'II. Allegro animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 928 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c6ecdb58-6f76-3ca5-95bd-498ef247b2a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6ecdb58-6f76-3ca5-95bd-498ef247b2a3', 2, 'II', 'Allegro animato', 'II. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 928 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6ecdb58-6f76-3ca5-95bd-498ef247b2a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento', part.name_en = 'III. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 928 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:70aa78b6-168e-49b9-99f5-c273b9d7d4b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70aa78b6-168e-49b9-99f5-c273b9d7d4b1', 3, 'III', 'Lento', 'III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 928 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70aa78b6-168e-49b9-99f5-c273b9d7d4b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Molto allegro', part.name_en = 'IV. Molto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 928 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7861b8a6-e114-48bf-8939-5f677c7ba8d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7861b8a6-e114-48bf-8939-5f677c7ba8d8', 4, 'IV', 'Molto allegro', 'IV. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 928 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7861b8a6-e114-48bf-8939-5f677c7ba8d8'
);


-- Op. 168 바순 소나타 G장조

UPDATE pieces piece
SET piece.title = '바순 소나타 G장조', piece.title_en = 'Bassoon Sonata in G major',
    piece.type = 'album', piece.opus_number = 'Op. 168',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1564 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 1564 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1564 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7b072d78-73d7-4d61-8981-e2653c7d5ac6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b072d78-73d7-4d61-8981-e2653c7d5ac6', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1564 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b072d78-73d7-4d61-8981-e2653c7d5ac6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro scherzando', part.name_en = 'II. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1564 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:97e23311-8722-49f4-8487-95a5e6d7b927' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e23311-8722-49f4-8487-95a5e6d7b927', 2, 'II', 'Allegro scherzando', 'II. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1564 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e23311-8722-49f4-8487-95a5e6d7b927'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Molto adagio – Allegro moderato', part.name_en = 'III. Molto adagio – Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1564 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:18976c14-4a19-4a25-809a-68d0fa807273' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18976c14-4a19-4a25-809a-68d0fa807273', 3, 'III', 'Molto adagio – Allegro moderato', 'III. Molto adagio – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1564 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18976c14-4a19-4a25-809a-68d0fa807273'
);


-- R. 108 호른과 오르간을 위한 아다지오 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른과 오르간을 위한 아다지오 E♭장조', 'Adagio in E♭ major for Horn and Organ', 'song', 'R. 108', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른과 오르간을 위한 아다지오 E♭장조'
);


-- None 첼로 가보트 G단조

UPDATE pieces piece
SET piece.title = '첼로 가보트 G단조', piece.title_en = 'Gavotte in G minor for Cello and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1012 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 1 하모늄을 위한 3개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하모늄을 위한 3개의 소품', '3 Pieces for Harmonium', 'song', 'Op. 1', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하모늄을 위한 3개의 소품'
);


-- Op. 8 하모늄과 피아노를 위한 6개의 2중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하모늄과 피아노를 위한 6개의 2중주', '6 Duos for Harmonium and Piano', 'song', 'Op. 8', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하모늄과 피아노를 위한 6개의 2중주'
);


-- None 오르간을 위한 2개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 2개의 소품', '2 Pieces for Organ', 'song', NULL, NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 2개의 소품'
);


-- R. 78 오르간 환상곡 1번 E♭장조

UPDATE pieces piece
SET piece.title = '오르간 환상곡 1번 E♭장조', piece.title_en = 'Fantaisie No. 1 in E♭ major for Organ',
    piece.type = 'song', piece.opus_number = 'R. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1857, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2275 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1857
WHERE piece.id = 2275 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 9 <혼례 축복> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<혼례 축복> F장조', 'Bénédiction nuptiale in F major', 'song', 'Op. 9', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<혼례 축복> F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eaa685cf-422b-4cc8-8ead-a0ae5e2a2b28'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eaa685cf-422b-4cc8-8ead-a0ae5e2a2b28'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '<혼례 축복> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eaa685cf-422b-4cc8-8ead-a0ae5e2a2b28'
);


-- Op. 13 <거양성체 또는 영성체> E장조

UPDATE pieces piece
SET piece.title = '<거양성체 또는 영성체> E장조', piece.title_en = 'Élévation ou communion in E major',
    piece.type = 'song', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2039 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 2039 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 7 브르타뉴 성가에 의한 3개의 랩소디

UPDATE pieces piece
SET piece.title = '브르타뉴 성가에 의한 3개의 랩소디', piece.title_en = '3 Rhapsodies sur des cantiques bretons',
    piece.type = 'album', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1866, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2549 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1866
WHERE piece.id = 2549 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andantino con moto', part.name_en = 'No. 1. Andantino con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2549 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:fb799b72-2570-4f58-af11-f4ea61387ad2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb799b72-2570-4f58-af11-f4ea61387ad2', 1, NULL, 'Andantino con moto', 'No. 1. Andantino con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2549 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb799b72-2570-4f58-af11-f4ea61387ad2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato e pomposo', part.name_en = 'No. 2. Allegro moderato e pomposo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2549 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b18f0c8f-ccdb-4f16-8a4a-0b0392472172' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b18f0c8f-ccdb-4f16-8a4a-0b0392472172', 2, NULL, 'Allegro moderato e pomposo', 'No. 2. Allegro moderato e pomposo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2549 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b18f0c8f-ccdb-4f16-8a4a-0b0392472172'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'No. 3. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2549 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:394e0a4f-ac4d-40d9-8d47-328dc0412072' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:394e0a4f-ac4d-40d9-8d47-328dc0412072', 3, NULL, 'Andantino', 'No. 3. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2549 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:394e0a4f-ac4d-40d9-8d47-328dc0412072'
);


-- Op. 99 오르간 전주곡과 푸가 Op. 99

UPDATE pieces piece
SET piece.title = '오르간 전주곡과 푸가 Op. 99', piece.title_en = '3 Preludes and Fugues for Organ, Op. 99',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '99',
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1536 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 1536 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 E장조', part.name_en = 'No. 1 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f91f2c2e-8854-49b3-9ca5-335232805096' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f91f2c2e-8854-49b3-9ca5-335232805096', 1, NULL, '전주곡과 푸가 E장조', 'No. 1 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f91f2c2e-8854-49b3-9ca5-335232805096'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f91f2c2e-8854-49b3-9ca5-335232805096'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d0ed0536-aaf1-459e-9c55-6e61cdd336c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0ed0536-aaf1-459e-9c55-6e61cdd336c0', 1, NULL, '전주곡', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f91f2c2e-8854-49b3-9ca5-335232805096'
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0ed0536-aaf1-459e-9c55-6e61cdd336c0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f91f2c2e-8854-49b3-9ca5-335232805096'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8bedfe94-9646-4db0-b338-cb54b0afb9db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8bedfe94-9646-4db0-b338-cb54b0afb9db', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f91f2c2e-8854-49b3-9ca5-335232805096'
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bedfe94-9646-4db0-b338-cb54b0afb9db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 B장조', part.name_en = 'No. 2 in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:eadd2724-b614-4524-b834-0be7a854441b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eadd2724-b614-4524-b834-0be7a854441b', 2, NULL, '전주곡과 푸가 B장조', 'No. 2 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eadd2724-b614-4524-b834-0be7a854441b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eadd2724-b614-4524-b834-0be7a854441b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6803360d-c19c-4555-878a-d8252f94327c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6803360d-c19c-4555-878a-d8252f94327c', 1, NULL, '전주곡', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eadd2724-b614-4524-b834-0be7a854441b'
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6803360d-c19c-4555-878a-d8252f94327c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eadd2724-b614-4524-b834-0be7a854441b'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:14d09641-9dd7-481e-b4a4-2a20757d407c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:14d09641-9dd7-481e-b4a4-2a20757d407c', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eadd2724-b614-4524-b834-0be7a854441b'
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14d09641-9dd7-481e-b4a4-2a20757d407c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 E♭장조', part.name_en = 'No. 3 in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:957dcb00-5333-4c2e-9b4a-59fa6c516068' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:957dcb00-5333-4c2e-9b4a-59fa6c516068', 3, NULL, '전주곡과 푸가 E♭장조', 'No. 3 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:957dcb00-5333-4c2e-9b4a-59fa6c516068'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:957dcb00-5333-4c2e-9b4a-59fa6c516068'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e46f47a4-917c-49ce-bc55-e99ffc293a1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e46f47a4-917c-49ce-bc55-e99ffc293a1c', 1, NULL, '전주곡', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:957dcb00-5333-4c2e-9b4a-59fa6c516068'
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e46f47a4-917c-49ce-bc55-e99ffc293a1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:957dcb00-5333-4c2e-9b4a-59fa6c516068'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d6bedb5e-1b9a-47e2-9f2d-e45563253aad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6bedb5e-1b9a-47e2-9f2d-e45563253aad', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:957dcb00-5333-4c2e-9b4a-59fa6c516068'
WHERE p.id = 1536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6bedb5e-1b9a-47e2-9f2d-e45563253aad'
);


-- Op. 101 오르간 환상곡 2번 D♭장조

UPDATE pieces piece
SET piece.title = '오르간 환상곡 2번 D♭장조', piece.title_en = 'Fantaisie No. 2 in D♭ major for Organ',
    piece.type = 'song', piece.opus_number = 'Op. 101',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1895, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1392 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1895
WHERE piece.id = 1392 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 107 오르간을 위한 종교 행진곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 종교 행진곡 F장조', 'Marche religieuse in F major for Organ', 'song', 'Op. 107', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 종교 행진곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e13c95e9-2eb6-4b62-8cb0-025222678506'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e13c95e9-2eb6-4b62-8cb0-025222678506'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '오르간을 위한 종교 행진곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e13c95e9-2eb6-4b62-8cb0-025222678506'
);


-- Op. 109 오르간 전주곡과 푸가 Op. 109

UPDATE pieces piece
SET piece.title = '오르간 전주곡과 푸가 Op. 109', piece.title_en = '3 Preludes and Fugues for Organ, Op. 109',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '109',
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2451 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 2451 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 D단조', part.name_en = 'No. 1 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8fc0058d-56bd-413f-bb6c-61398f105347' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fc0058d-56bd-413f-bb6c-61398f105347', 1, NULL, '전주곡과 푸가 D단조', 'No. 1 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fc0058d-56bd-413f-bb6c-61398f105347'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8fc0058d-56bd-413f-bb6c-61398f105347'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:06edf3f4-4ee9-4d78-a161-3823f9687002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06edf3f4-4ee9-4d78-a161-3823f9687002', 1, NULL, '전주곡', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8fc0058d-56bd-413f-bb6c-61398f105347'
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06edf3f4-4ee9-4d78-a161-3823f9687002'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8fc0058d-56bd-413f-bb6c-61398f105347'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a9cd7c95-c044-4249-bb19-8b2e19b5b938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9cd7c95-c044-4249-bb19-8b2e19b5b938', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8fc0058d-56bd-413f-bb6c-61398f105347'
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9cd7c95-c044-4249-bb19-8b2e19b5b938'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 G장조', part.name_en = 'No. 2 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:758e6ee0-9828-467d-8207-1aecca0a0071' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:758e6ee0-9828-467d-8207-1aecca0a0071', 2, NULL, '전주곡과 푸가 G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:758e6ee0-9828-467d-8207-1aecca0a0071'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:758e6ee0-9828-467d-8207-1aecca0a0071'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c5db2381-2d13-4e6f-a6c9-365d5dc2836b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5db2381-2d13-4e6f-a6c9-365d5dc2836b', 1, NULL, '전주곡', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:758e6ee0-9828-467d-8207-1aecca0a0071'
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5db2381-2d13-4e6f-a6c9-365d5dc2836b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:758e6ee0-9828-467d-8207-1aecca0a0071'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1ea29e1f-f241-4bd9-a672-7f7f70ba8cfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ea29e1f-f241-4bd9-a672-7f7f70ba8cfa', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:758e6ee0-9828-467d-8207-1aecca0a0071'
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea29e1f-f241-4bd9-a672-7f7f70ba8cfa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 C장조', part.name_en = 'No. 3 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8db09000-2e2c-44cc-b58f-a97453e06d5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8db09000-2e2c-44cc-b58f-a97453e06d5a', 3, NULL, '전주곡과 푸가 C장조', 'No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8db09000-2e2c-44cc-b58f-a97453e06d5a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8db09000-2e2c-44cc-b58f-a97453e06d5a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b05597ac-407d-4e1a-bed2-9dfa6df0250b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b05597ac-407d-4e1a-bed2-9dfa6df0250b', 1, NULL, '전주곡', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8db09000-2e2c-44cc-b58f-a97453e06d5a'
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b05597ac-407d-4e1a-bed2-9dfa6df0250b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8db09000-2e2c-44cc-b58f-a97453e06d5a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2451 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:699b997a-4257-4042-acb1-9596f1b547a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:699b997a-4257-4042-acb1-9596f1b547a5', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8db09000-2e2c-44cc-b58f-a97453e06d5a'
WHERE p.id = 2451 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:699b997a-4257-4042-acb1-9596f1b547a5'
);


-- Op. 150 오르간을 위한 7개의 즉흥곡

UPDATE pieces piece
SET piece.title = '오르간을 위한 7개의 즉흥곡', piece.title_en = '7 Improvisations for Organ',
    piece.type = 'album', piece.opus_number = 'Op. 150',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 994 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 994 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = 'No. 1 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 994 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:37701090-e5f1-4cd5-8300-2411cfdd5977' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37701090-e5f1-4cd5-8300-2411cfdd5977', 1, NULL, 'E장조', 'No. 1 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 994 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37701090-e5f1-4cd5-8300-2411cfdd5977'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '"Feria Pentecostes"', part.name_en = 'No. 2 "Feria Pentecostes"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 994 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0a28123b-d3b9-4490-8380-6d3a97ec6a4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a28123b-d3b9-4490-8380-6d3a97ec6a4a', 2, NULL, '"Feria Pentecostes"', 'No. 2 "Feria Pentecostes"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 994 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a28123b-d3b9-4490-8380-6d3a97ec6a4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = 'No. 3 in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 994 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4df2bcc3-d39b-4ecd-86ee-6c5b734816c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4df2bcc3-d39b-4ecd-86ee-6c5b734816c8', 3, NULL, 'E♭장조', 'No. 3 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 994 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4df2bcc3-d39b-4ecd-86ee-6c5b734816c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'No. 4 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 994 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:79c717d0-d962-426b-808b-e283ccb073af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79c717d0-d962-426b-808b-e283ccb073af', 4, NULL, 'A장조', 'No. 4 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 994 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79c717d0-d962-426b-808b-e283ccb073af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '"Pro martyribus"', part.name_en = 'No. 5 "Pro martyribus"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 994 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:82f919ca-bd7b-4ea9-8736-058aaa3da166' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82f919ca-bd7b-4ea9-8736-058aaa3da166', 5, NULL, '"Pro martyribus"', 'No. 5 "Pro martyribus"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 994 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82f919ca-bd7b-4ea9-8736-058aaa3da166'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '"Pro defunctis"', part.name_en = 'No. 6 "Pro defunctis"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 994 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9da29834-2321-4748-9480-c2aa2c3db746' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9da29834-2321-4748-9480-c2aa2c3db746', 6, NULL, '"Pro defunctis"', 'No. 6 "Pro defunctis"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 994 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9da29834-2321-4748-9480-c2aa2c3db746'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 7 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 994 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a79c0fd6-05c6-4f88-9cbd-e8e42a51b119' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a79c0fd6-05c6-4f88-9cbd-e8e42a51b119', 7, NULL, 'A단조', 'No. 7 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 994 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a79c0fd6-05c6-4f88-9cbd-e8e42a51b119'
);


-- Op. 157 오르간 환상곡 3번 C장조

UPDATE pieces piece
SET piece.title = '오르간 환상곡 3번 C장조', piece.title_en = 'Fantaisie No. 3 in C major for Organ',
    piece.type = 'song', piece.opus_number = 'Op. 157',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2378 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 2378 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 오르간 또는 하모늄을 위한 5개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 또는 하모늄을 위한 5개의 소품', '5 Pieces for Organ or Harmonium', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 또는 하모늄을 위한 5개의 소품'
);


-- None 오르간 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 소품', 'Morceau for Organ', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 소품'
);


-- None 오르간 전주곡 F장조

UPDATE pieces piece
SET piece.title = '오르간 전주곡 F장조', piece.title_en = 'Prélude in F major for Organ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2037 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 135 왼손을 위한 6개의 연습곡

UPDATE pieces piece
SET piece.title = '왼손을 위한 6개의 연습곡', piece.title_en = '6 Études for the Left Hand',
    piece.type = 'album', piece.opus_number = 'Op. 135',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1626 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 1626 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1626 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4e477b3c-a30b-4824-af58-e36652ad0e75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e477b3c-a30b-4824-af58-e36652ad0e75', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1626 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e477b3c-a30b-4824-af58-e36652ad0e75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Alla fuga', part.name_en = 'Alla fuga',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1626 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:6dbc0000-2378-4fdd-9b36-ba519de133d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dbc0000-2378-4fdd-9b36-ba519de133d0', 2, NULL, 'Alla fuga', 'Alla fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1626 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dbc0000-2378-4fdd-9b36-ba519de133d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Moto perpetuo', part.name_en = 'Moto perpetuo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1626 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b5428013-aa60-44f6-b8fe-6c847361cf5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5428013-aa60-44f6-b8fe-6c847361cf5c', 3, NULL, 'Moto perpetuo', 'Moto perpetuo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1626 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5428013-aa60-44f6-b8fe-6c847361cf5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '부레', part.name_en = 'Bourrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1626 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8650cf25-d95b-4e46-87ad-297986ed4d8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8650cf25-d95b-4e46-87ad-297986ed4d8b', 4, NULL, '부레', 'Bourrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1626 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8650cf25-d95b-4e46-87ad-297986ed4d8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '엘레지', part.name_en = 'Élégie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1626 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:139ae2a4-fe18-49d5-b2ee-036ffe68bd39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:139ae2a4-fe18-49d5-b2ee-036ffe68bd39', 5, NULL, '엘레지', 'Élégie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1626 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139ae2a4-fe18-49d5-b2ee-036ffe68bd39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '지그', part.name_en = 'Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1626 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:aa68f3c9-55ed-45b8-ba96-e155b4a0154b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa68f3c9-55ed-45b8-ba96-e155b4a0154b', 6, NULL, '지그', 'Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1626 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa68f3c9-55ed-45b8-ba96-e155b4a0154b'
);


-- None 헨델 <유다스 마카베우스> 합창 주제에 의한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헨델 <유다스 마카베우스> 합창 주제에 의한 변주곡', 'Variations on the Chorus from Handel''s Judas Maccabaeus', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헨델 <유다스 마카베우스> 합창 주제에 의한 변주곡'
);


-- Op. 11 네 손을 위한 듀에티노 G장조

UPDATE pieces piece
SET piece.title = '네 손을 위한 듀에티노 G장조', piece.title_en = 'Duettino in G major for Piano Four Hands',
    piece.type = 'song', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1930 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 1930 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 59 네 손을 위한 <하랄 하르파그르 왕>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 <하랄 하르파그르 왕>', 'König Harald Harfagar for Piano Four Hands', 'song', 'Op. 59', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 <하랄 하르파그르 왕>'
);


-- Op. 81 네 손을 위한 앨범의 한 페이지

UPDATE pieces piece
SET piece.title = '네 손을 위한 앨범의 한 페이지', piece.title_en = 'Feuillet d''album for Piano Four Hands',
    piece.type = 'song', piece.opus_number = 'Op. 81',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2633 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 2633 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 86 네 손을 위한 빠른 행진곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 빠른 행진곡 B♭장조', 'Pas redoublé in B♭ major for Piano Four Hands', 'song', 'Op. 86', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 빠른 행진곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6da32e8b-94c6-4584-bcb8-f6d469618f63'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6da32e8b-94c6-4584-bcb8-f6d469618f63'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '네 손을 위한 빠른 행진곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6da32e8b-94c6-4584-bcb8-f6d469618f63'
);


-- Op. 105 네 손을 위한 자장가 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 자장가 E장조', 'Berceuse in E major for Piano Four Hands', 'song', 'Op. 105', NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 자장가 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '153f3af8-589a-47af-bc00-35fb2c734d5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '153f3af8-589a-47af-bc00-35fb2c734d5f'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '네 손을 위한 자장가 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '153f3af8-589a-47af-bc00-35fb2c734d5f'
);


-- Op. 163 알제 학생들에게 바치는 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알제 학생들에게 바치는 행진곡', 'Marche dédiée aux étudiants d''Alger', 'song', 'Op. 163', NULL, NULL, 1921, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알제 학생들에게 바치는 행진곡'
);


-- Op. 8b 두 대의 피아노를 위한 2중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 2중주', 'Duo for 2 Pianos', 'song', 'Op. 8b', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 2중주'
);


-- Op. 35 베토벤 주제에 의한 변주곡 E♭장조

UPDATE pieces piece
SET piece.title = '베토벤 주제에 의한 변주곡 E♭장조', piece.title_en = 'Variations on a Theme of Beethoven in E♭ major',
    piece.type = 'song', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1874, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2810 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1874
WHERE piece.id = 2810 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 96 <아랍 카프리스>

UPDATE pieces piece
SET piece.title = '<아랍 카프리스>', piece.title_en = 'Caprice arabe',
    piece.type = 'song', piece.opus_number = 'Op. 96',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1527 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 1527 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 77 두 대의 피아노를 위한 폴로네즈 F단조

UPDATE pieces piece
SET piece.title = '두 대의 피아노를 위한 폴로네즈 F단조', piece.title_en = 'Polonaise in F minor for 2 Pianos',
    piece.type = 'song', piece.opus_number = 'Op. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2585 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 2585 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 87 두 대의 피아노를 위한 스케르초

UPDATE pieces piece
SET piece.title = '두 대의 피아노를 위한 스케르초', piece.title_en = 'Scherzo for 2 Pianos',
    piece.type = 'song', piece.opus_number = 'Op. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2440 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 2440 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 106 <영웅 카프리스>

UPDATE pieces piece
SET piece.title = '<영웅 카프리스>', piece.title_en = 'Caprice héroïque',
    piece.type = 'song', piece.opus_number = 'Op. 106',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2687 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 2687 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- R. 7 안단테 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 G장조', 'Andante in G major', 'song', 'R. 7', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 G장조'
);


-- R. 15 알레그레토 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 E♭장조', 'Allegretto in E♭ major', 'song', 'R. 15', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 E♭장조'
);


-- None 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠', 'Waltz', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠'
);


-- Op. 3 바가텔 Op. 3

UPDATE pieces piece
SET piece.title = '바가텔 Op. 3', piece.title_en = '6 Bagatelles, Op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 940 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 940 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Poco sostenuto', part.name_en = 'No. 1. Poco sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 940 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:e3377500-4ccc-40df-ac75-64297cac9687' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3377500-4ccc-40df-ac75-64297cac9687', 1, NULL, 'Poco sostenuto', 'No. 1. Poco sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 940 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3377500-4ccc-40df-ac75-64297cac9687'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro animato quasi presto', part.name_en = 'No. 2. Allegro animato quasi presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 940 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:17686ba4-3972-4010-9ab1-2c5b40b79101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17686ba4-3972-4010-9ab1-2c5b40b79101', 2, NULL, 'Allegro animato quasi presto', 'No. 2. Allegro animato quasi presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 940 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17686ba4-3972-4010-9ab1-2c5b40b79101'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Poco adagio', part.name_en = 'No. 3. Poco adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 940 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f6089c08-f4b5-44f5-973d-e888b90a77c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6089c08-f4b5-44f5-973d-e888b90a77c2', 3, NULL, 'Poco adagio', 'No. 3. Poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 940 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6089c08-f4b5-44f5-973d-e888b90a77c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Moderato assai', part.name_en = 'No. 4. Moderato assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 940 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a9209c31-cdb2-46e7-b4b7-866a7d525dc3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9209c31-cdb2-46e7-b4b7-866a7d525dc3', 4, NULL, 'Moderato assai', 'No. 4. Moderato assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 940 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9209c31-cdb2-46e7-b4b7-866a7d525dc3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro molto', part.name_en = 'No. 5. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 940 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:37a360c4-bf31-4b08-8120-f054d9a7e9e7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37a360c4-bf31-4b08-8120-f054d9a7e9e7', 5, NULL, 'Allegro molto', 'No. 5. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 940 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37a360c4-bf31-4b08-8120-f054d9a7e9e7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Poco sostenuto', part.name_en = 'No. 6. Poco sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 940 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c9046ed9-040a-4a78-afb3-fff75ad943c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9046ed9-040a-4a78-afb3-fff75ad943c8', 6, NULL, 'Poco sostenuto', 'No. 6. Poco sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 940 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9046ed9-040a-4a78-afb3-fff75ad943c8'
);


-- Op. 21 마주르카 1번 G단조

UPDATE pieces piece
SET piece.title = '마주르카 1번 G단조', piece.title_en = 'Mazurka No. 1 in G minor',
    piece.type = 'song', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 977 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 977 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 23 가보트 C단조

UPDATE pieces piece
SET piece.title = '가보트 C단조', piece.title_en = 'Gavotte in C minor',
    piece.type = 'song', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2428 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 2428 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 24 마주르카 2번 G단조

UPDATE pieces piece
SET piece.title = '마주르카 2번 G단조', piece.title_en = 'Mazurka No. 2 in G minor',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1455 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 1455 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 무언가 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무언가 B단조', 'Romance sans paroles in B minor', 'song', NULL, NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무언가 B단조'
);


-- Op. 52 연습곡 Op. 52

UPDATE pieces piece
SET piece.title = '연습곡 Op. 52', piece.title_en = '6 Études, Op. 52',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '52',
    piece.composition_year = COALESCE(1877, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2538 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1877
WHERE piece.id = 2538 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'No. 1. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:559e71e6-3e61-411a-b917-8f8fa92be0fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:559e71e6-3e61-411a-b917-8f8fa92be0fd', 1, NULL, '전주곡', 'No. 1. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:559e71e6-3e61-411a-b917-8f8fa92be0fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '손가락의 독립을 위하여', part.name_en = 'No. 2. Pour l''indépendance des doigts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f7bc2827-5284-4b43-b85f-a24874b0edae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7bc2827-5284-4b43-b85f-a24874b0edae', 2, NULL, '손가락의 독립을 위하여', 'No. 2. Pour l''indépendance des doigts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7bc2827-5284-4b43-b85f-a24874b0edae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 F단조', part.name_en = 'No. 3. Prélude et fugue in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f629a805-e5dd-4853-b40a-730ae0954b6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f629a805-e5dd-4853-b40a-730ae0954b6d', 3, NULL, '전주곡과 푸가 F단조', 'No. 3. Prélude et fugue in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f629a805-e5dd-4853-b40a-730ae0954b6d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f629a805-e5dd-4853-b40a-730ae0954b6d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:82e28ab4-b711-4aea-a547-a84138940780' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82e28ab4-b711-4aea-a547-a84138940780', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f629a805-e5dd-4853-b40a-730ae0954b6d'
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82e28ab4-b711-4aea-a547-a84138940780'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f629a805-e5dd-4853-b40a-730ae0954b6d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c9b888fd-95f6-486b-bfdb-2f655cddedd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9b888fd-95f6-486b-bfdb-2f655cddedd7', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f629a805-e5dd-4853-b40a-730ae0954b6d'
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9b888fd-95f6-486b-bfdb-2f655cddedd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '리듬 연습곡', part.name_en = 'No. 4. Étude de rythme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8d5ac8c7-043e-4d83-b288-33c00747640d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d5ac8c7-043e-4d83-b288-33c00747640d', 4, NULL, '리듬 연습곡', 'No. 4. Étude de rythme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d5ac8c7-043e-4d83-b288-33c00747640d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 A장조', part.name_en = 'No. 5. Prélude et fugue in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:c5127b34-4b1f-4a9e-9ba6-22cf8d61507c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5127b34-4b1f-4a9e-9ba6-22cf8d61507c', 5, NULL, '전주곡과 푸가 A장조', 'No. 5. Prélude et fugue in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5127b34-4b1f-4a9e-9ba6-22cf8d61507c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5127b34-4b1f-4a9e-9ba6-22cf8d61507c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9fa0d2c7-0751-46cd-8649-4bc4bd548cac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fa0d2c7-0751-46cd-8649-4bc4bd548cac', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5127b34-4b1f-4a9e-9ba6-22cf8d61507c'
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fa0d2c7-0751-46cd-8649-4bc4bd548cac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5127b34-4b1f-4a9e-9ba6-22cf8d61507c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:32d90e8f-a3d1-455e-b1c6-e591193caf23' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32d90e8f-a3d1-455e-b1c6-e591193caf23', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c5127b34-4b1f-4a9e-9ba6-22cf8d61507c'
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32d90e8f-a3d1-455e-b1c6-e591193caf23'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '왈츠 형식으로', part.name_en = 'No. 6. En forme de valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2538 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8194934e-32b5-4188-9fa4-d6a38bc34146' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8194934e-32b5-4188-9fa4-d6a38bc34146', 6, NULL, '왈츠 형식으로', 'No. 6. En forme de valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2538 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8194934e-32b5-4188-9fa4-d6a38bc34146'
);


-- Op. 56 미뉴에트와 왈츠

UPDATE pieces piece
SET piece.title = '미뉴에트와 왈츠', piece.title_en = 'Menuet et valse',
    piece.type = 'album', piece.opus_number = 'Op. 56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2159 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 2159 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '미뉴에트', part.name_en = 'Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2159 AND p.composer_id = 60 AND part.part_key = 'classicmap:saint-saens:saint-saens-op56:1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op56:1', 1, NULL, '미뉴에트', 'Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2159 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op56:1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '왈츠', part.name_en = 'Valse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2159 AND p.composer_id = 60 AND part.part_key = 'classicmap:saint-saens:saint-saens-op56:2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op56:2', 2, NULL, '왈츠', 'Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2159 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op56:2'
);


-- Op. 66 마주르카 3번 B단조

UPDATE pieces piece
SET piece.title = '마주르카 3번 B단조', piece.title_en = 'Mazurka No. 3 in B minor',
    piece.type = 'song', piece.opus_number = 'Op. 66',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2298 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 2298 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 72 피아노 소품집 <앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소품집 <앨범>', 'Album, Op. 72', 'album', 'Op. 72', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소품집 <앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e105022c-3e98-48fa-9314-addfcc22082e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e105022c-3e98-48fa-9314-addfcc22082e'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '피아노 소품집 <앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e105022c-3e98-48fa-9314-addfcc22082e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 840 AND linked.composer_id = 60), 'musicbrainz:008d1551-fd6b-48fe-9a13-2751d61a7b89', 1, NULL, '전주곡', 'No. 1. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '피아노 소품집 <앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:008d1551-fd6b-48fe-9a13-2751d61a7b89'
);

UPDATE pieces piece
SET piece.title = '피아노 소품집 <앨범> 중 "전주곡"', piece.title_en = 'Album, Op. 72: No. 1. Prélude', piece.editor_locked = 1
WHERE piece.id = 840 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1808 AND linked.composer_id = 60), 'musicbrainz:76eb56cc-402a-4795-9db3-62eaab87ae7d', 2, NULL, '카리용', 'No. 2. Carillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '피아노 소품집 <앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76eb56cc-402a-4795-9db3-62eaab87ae7d'
);

UPDATE pieces piece
SET piece.title = '피아노 소품집 <앨범> 중 "카리용"', piece.title_en = 'Album, Op. 72: No. 2. Carillon', piece.editor_locked = 1
WHERE piece.id = 1808 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1480 AND linked.composer_id = 60), 'musicbrainz:4cf08b98-8cd7-418b-97d8-136e1b2e243a', 3, NULL, '토카타', 'No. 3. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '피아노 소품집 <앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cf08b98-8cd7-418b-97d8-136e1b2e243a'
);

UPDATE pieces piece
SET piece.title = '피아노 소품집 <앨범> 중 "토카타"', piece.title_en = 'Album, Op. 72: No. 3. Toccata', piece.editor_locked = 1
WHERE piece.id = 1480 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2264 AND linked.composer_id = 60), 'musicbrainz:ab3c6df1-47b2-4049-9b32-fcec5f7d6000', 4, NULL, '왈츠', 'No. 4. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '피아노 소품집 <앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab3c6df1-47b2-4049-9b32-fcec5f7d6000'
);

UPDATE pieces piece
SET piece.title = '피아노 소품집 <앨범> 중 "왈츠"', piece.title_en = 'Album, Op. 72: No. 4. Valse', piece.editor_locked = 1
WHERE piece.id = 2264 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 921 AND linked.composer_id = 60), 'musicbrainz:089c4ae5-572b-494b-a321-cb89d8dd23d8', 5, NULL, '나폴리 노래', 'No. 5. Chanson napolitaine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '피아노 소품집 <앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089c4ae5-572b-494b-a321-cb89d8dd23d8'
);

UPDATE pieces piece
SET piece.title = '피아노 소품집 <앨범> 중 "나폴리 노래"', piece.title_en = 'Album, Op. 72: No. 5. Chanson napolitaine', piece.editor_locked = 1
WHERE piece.id = 921 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2507 AND linked.composer_id = 60), 'musicbrainz:c7003242-ccc4-49c3-88ba-06a05e77c263', 6, NULL, '피날레', 'No. 6. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '피아노 소품집 <앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7003242-ccc4-49c3-88ba-06a05e77c263'
);

UPDATE pieces piece
SET piece.title = '피아노 소품집 <앨범> 중 "피날레"', piece.title_en = 'Album, Op. 72: No. 6. Final', piece.editor_locked = 1
WHERE piece.id = 2507 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 안단티노

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노', 'Andantino', 'song', NULL, NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노'
);


-- None 즉흥곡

UPDATE pieces piece
SET piece.title = '즉흥곡', piece.title_en = 'Improvisation',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2714 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 2714 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 80 <이탈리아의 추억> G장조

UPDATE pieces piece
SET piece.title = '<이탈리아의 추억> G장조', piece.title_en = 'Souvenir d''Italie in G major',
    piece.type = 'song', piece.opus_number = 'Op. 80',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2661 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 2661 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 85 <저녁 종> A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<저녁 종> A♭장조', 'Les cloches du soir in A♭ major', 'song', 'Op. 85', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<저녁 종> A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b4c8bd2-a392-4cf6-ab46-77ed472d2359'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b4c8bd2-a392-4cf6-ab46-77ed472d2359'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '<저녁 종> A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b4c8bd2-a392-4cf6-ab46-77ed472d2359'
);


-- Op. 88 <카나리아 왈츠> A단조

UPDATE pieces piece
SET piece.title = '<카나리아 왈츠> A단조', piece.title_en = 'Valse canariote in A minor',
    piece.type = 'song', piece.opus_number = 'Op. 88',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2738 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 2738 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 90 피아노 모음곡 F장조

UPDATE pieces piece
SET piece.title = '피아노 모음곡 F장조', piece.title_en = 'Suite in F major for Piano',
    piece.type = 'album', piece.opus_number = 'Op. 90',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3003 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 3003 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡과 푸가', part.name_en = 'I. Prélude et Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3003 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:52197af3-2fe5-4f9d-ad54-09c28dc045c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52197af3-2fe5-4f9d-ad54-09c28dc045c2', 1, 'I', '전주곡과 푸가', 'I. Prélude et Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3003 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52197af3-2fe5-4f9d-ad54-09c28dc045c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '미뉴에트', part.name_en = 'II. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3003 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b5965995-5158-4133-be56-aa518d66f3a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5965995-5158-4133-be56-aa518d66f3a9', 2, 'II', '미뉴에트', 'II. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3003 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5965995-5158-4133-be56-aa518d66f3a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '가보트', part.name_en = 'III. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3003 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a2c536aa-8f86-4cb7-92d4-0fe5c4f447ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2c536aa-8f86-4cb7-92d4-0fe5c4f447ba', 3, 'III', '가보트', 'III. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3003 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2c536aa-8f86-4cb7-92d4-0fe5c4f447ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '지그', part.name_en = 'IV. Gigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3003 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5953a54a-21aa-4f6b-82c0-d9957ddc5817' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5953a54a-21aa-4f6b-82c0-d9957ddc5817', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3003 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5953a54a-21aa-4f6b-82c0-d9957ddc5817'
);


-- Op. 97 피아노를 위한 주제와 변주

UPDATE pieces piece
SET piece.title = '피아노를 위한 주제와 변주', piece.title_en = 'Thème varié',
    piece.type = 'song', piece.opus_number = 'Op. 97',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2458 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 2458 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 100 <이스마일리아의 추억>

UPDATE pieces piece
SET piece.title = '<이스마일리아의 추억>', piece.title_en = 'Souvenir d''Ismaïlia',
    piece.type = 'song', piece.opus_number = 'Op. 100',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1895, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2007 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1895
WHERE piece.id = 2007 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 104 <귀여운 왈츠> E♭장조

UPDATE pieces piece
SET piece.title = '<귀여운 왈츠> E♭장조', piece.title_en = 'Valse mignonne in E♭ major',
    piece.type = 'song', piece.opus_number = 'Op. 104',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2156 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 2156 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 4개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 소품', '4 Pieces', 'song', NULL, NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 소품'
);


-- Op. 110 <무심한 왈츠> D♭장조

UPDATE pieces piece
SET piece.title = '<무심한 왈츠> D♭장조', piece.title_en = 'Valse nonchalante in D♭ major',
    piece.type = 'song', piece.opus_number = 'Op. 110',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 892 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 892 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 111 연습곡 Op. 111

UPDATE pieces piece
SET piece.title = '연습곡 Op. 111', piece.title_en = '6 Études, Op. 111',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '111',
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3004 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 3004 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '장3도와 단3도', part.name_en = 'No. 1. Tierces majeures et mineures',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3004 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7c2dacde-b2e5-40b1-87e8-6b888792f5be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c2dacde-b2e5-40b1-87e8-6b888792f5be', 1, NULL, '장3도와 단3도', 'No. 1. Tierces majeures et mineures', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3004 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c2dacde-b2e5-40b1-87e8-6b888792f5be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '반음계 패시지', part.name_en = 'No. 2. Traits chromatiques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3004 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:dc9fb208-f53a-42b0-8f25-d9557c773491' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc9fb208-f53a-42b0-8f25-d9557c773491', 2, NULL, '반음계 패시지', 'No. 2. Traits chromatiques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3004 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc9fb208-f53a-42b0-8f25-d9557c773491'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '전주곡과 푸가 E♭단조', part.name_en = 'No. 3. Prélude et fugue in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3004 AND p.composer_id = 60 AND part.part_key = 'classicmap:saint-saens:saint-saens-op111:3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op111:3', 3, NULL, '전주곡과 푸가 E♭단조', 'No. 3. Prélude et fugue in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3004 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op111:3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:saint-saens:saint-saens-op111:3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3004 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:39e7da72-2a37-46eb-b836-6b6a5b8f3327' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39e7da72-2a37-46eb-b836-6b6a5b8f3327', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:saint-saens:saint-saens-op111:3'
WHERE p.id = 3004 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39e7da72-2a37-46eb-b836-6b6a5b8f3327'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:saint-saens:saint-saens-op111:3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸가', part.name_en = 'Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3004 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0fbc100b-9b5d-4d0a-9b27-b5b00406cf7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0fbc100b-9b5d-4d0a-9b27-b5b00406cf7c', 2, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:saint-saens:saint-saens-op111:3'
WHERE p.id = 3004 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fbc100b-9b5d-4d0a-9b27-b5b00406cf7c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '라스팔마스의 종', part.name_en = 'No. 4. Les cloches de Las Palmas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3004 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2974139c-5888-4ae7-8516-fdafecb421a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2974139c-5888-4ae7-8516-fdafecb421a6', 4, NULL, '라스팔마스의 종', 'No. 4. Les cloches de Las Palmas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3004 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2974139c-5888-4ae7-8516-fdafecb421a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '반음계 장3도', part.name_en = 'No. 5. Tierces majeures chromatiques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3004 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d1d2cf05-62b7-49b2-bd04-e32ff7d1ea22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1d2cf05-62b7-49b2-bd04-e32ff7d1ea22', 5, NULL, '반음계 장3도', 'No. 5. Tierces majeures chromatiques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3004 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1d2cf05-62b7-49b2-bd04-e32ff7d1ea22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '토카타 (피아노 협주곡 5번에 의한)', part.name_en = 'No. 6. Toccata d''après le 5e concerto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3004 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1b8c0c23-2ad2-4981-9523-311bdd5ee541' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b8c0c23-2ad2-4981-9523-311bdd5ee541', 6, NULL, '토카타 (피아노 협주곡 5번에 의한)', 'No. 6. Toccata d''après le 5e concerto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3004 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b8c0c23-2ad2-4981-9523-311bdd5ee541'
);


-- Op. 120 <나른한 왈츠> E장조

UPDATE pieces piece
SET piece.title = '<나른한 왈츠> E장조', piece.title_en = 'Valse langoureuse in E major',
    piece.type = 'song', piece.opus_number = 'Op. 120',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2628 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 2628 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 앨범의 한 페이지 (1909)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 (1909)', 'Feuillet d''album (1909)', 'song', NULL, NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 (1909)'
);


-- Op. 139 <즐거운 왈츠>

UPDATE pieces piece
SET piece.title = '<즐거운 왈츠>', piece.title_en = 'Valse gaie',
    piece.type = 'song', piece.opus_number = 'Op. 139',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1277 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 1277 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 161 푸가 Op. 161

UPDATE pieces piece
SET piece.title = '푸가 Op. 161', piece.title_en = '6 Fugues, Op. 161',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '161',
    piece.composition_year = COALESCE(1920, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2934 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1920
WHERE piece.id = 2934 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'No. 1. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2934 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:97c702b7-de1c-499c-9856-da831a8b9ca5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97c702b7-de1c-499c-9856-da831a8b9ca5', 1, NULL, 'Allegro moderato', 'No. 1. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2934 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97c702b7-de1c-499c-9856-da831a8b9ca5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Poco allegro grazioso', part.name_en = 'No. 2. Poco allegro grazioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2934 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9cdec5c6-5958-4632-a05f-f822a41de208' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cdec5c6-5958-4632-a05f-f822a41de208', 2, NULL, 'Poco allegro grazioso', 'No. 2. Poco allegro grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2934 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cdec5c6-5958-4632-a05f-f822a41de208'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'No. 3. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2934 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:33b03996-6362-4ead-8063-ae7dac138f8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33b03996-6362-4ead-8063-ae7dac138f8c', 3, NULL, 'Allegretto', 'No. 3. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2934 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33b03996-6362-4ead-8063-ae7dac138f8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'No. 4. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2934 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:900875b4-5ab7-44df-8e27-139ae2095f9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:900875b4-5ab7-44df-8e27-139ae2095f9b', 4, NULL, 'Allegro moderato', 'No. 4. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2934 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:900875b4-5ab7-44df-8e27-139ae2095f9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andantino quasi allegretto', part.name_en = 'No. 5. Andantino quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2934 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:a5d5bb6e-7d26-4db4-adc8-2db3232ded96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5d5bb6e-7d26-4db4-adc8-2db3232ded96', 5, NULL, 'Andantino quasi allegretto', 'No. 5. Andantino quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2934 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5d5bb6e-7d26-4db4-adc8-2db3232ded96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Maestoso poco allegro', part.name_en = 'No. 6. Maestoso poco allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2934 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:45181c08-625e-412f-a24c-59faea177c15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45181c08-625e-412f-a24c-59faea177c15', 6, NULL, 'Maestoso poco allegro', 'No. 6. Maestoso poco allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2934 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45181c08-625e-412f-a24c-59faea177c15'
);


-- Op. 169 앨범의 한 페이지 (1921)

UPDATE pieces piece
SET piece.title = '앨범의 한 페이지 (1921)', piece.title_en = 'Feuillet d''album (1921)',
    piece.type = 'song', piece.opus_number = 'Op. 169',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1398 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 1398 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 오라토리오 <물에서 구한 모세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <물에서 구한 모세>', 'Moïse sauvé des eaux', 'song', NULL, NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <물에서 구한 모세>'
);


-- Op. 4 미사

UPDATE pieces piece
SET piece.title = '미사', piece.title_en = 'Mass',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 536 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 536 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '키리에', part.name_en = 'I. Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:436b43f5-4cae-46df-b41e-1c6e093d5b8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:436b43f5-4cae-46df-b41e-1c6e093d5b8b', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:436b43f5-4cae-46df-b41e-1c6e093d5b8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '글로리아', part.name_en = 'II. Gloria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:20a1232a-0891-45a2-a6b1-97a79fcfcc5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20a1232a-0891-45a2-a6b1-97a79fcfcc5c', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20a1232a-0891-45a2-a6b1-97a79fcfcc5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '크레도', part.name_en = 'III. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7d673f17-1167-4646-a2c7-961d90d6dcc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d673f17-1167-4646-a2c7-961d90d6dcc8', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d673f17-1167-4646-a2c7-961d90d6dcc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '상투스', part.name_en = 'IV. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:06c8b429-51eb-41c2-b38f-91ff4b04d7c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06c8b429-51eb-41c2-b38f-91ff4b04d7c8', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06c8b429-51eb-41c2-b38f-91ff4b04d7c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '베네딕투스', part.name_en = 'V. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:43d487fe-79a4-4201-afd0-346157f06d5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43d487fe-79a4-4201-afd0-346157f06d5c', 5, 'V', '베네딕투스', 'V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43d487fe-79a4-4201-afd0-346157f06d5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'O Salutaris', part.name_en = 'VI. O Salutaris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:21383196-4a7f-42a8-a46a-1fb136d4064d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21383196-4a7f-42a8-a46a-1fb136d4064d', 6, 'VI', 'O Salutaris', 'VI. O Salutaris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21383196-4a7f-42a8-a46a-1fb136d4064d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '아뉴스 데이', part.name_en = 'VII. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 536 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:cb8e7b39-5729-4ee1-824c-6597c0fc85da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb8e7b39-5729-4ee1-824c-6597c0fc85da', 7, 'VII', '아뉴스 데이', 'VII. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 536 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb8e7b39-5729-4ee1-824c-6597c0fc85da'
);


-- Op. 5 합창과 오르간을 위한 <탄툼 에르고>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창과 오르간을 위한 <탄툼 에르고>', 'Tantum ergo for Chorus and Organ', 'song', 'Op. 5', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창과 오르간을 위한 <탄툼 에르고>'
);


-- Op. 12 <크리스마스 오라토리오>

UPDATE pieces piece
SET piece.title = '<크리스마스 오라토리오>', piece.title_en = 'Oratorio de Noël',
    piece.type = 'song', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1858, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 627 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1858
WHERE piece.id = 627 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None <Veni Creator> C장조

UPDATE pieces piece
SET piece.title = '<Veni Creator> C장조', piece.title_en = 'Veni Creator in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1858, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1010 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1858
WHERE piece.id = 1010 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 성가 <Ô saint autel> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Ô saint autel> D장조', 'Ô saint autel, Cantique in D major', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Ô saint autel> D장조'
);


-- None 성가 <Pour vous bénir, Seigneur> E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Pour vous bénir, Seigneur> E장조', 'Pour vous bénir, Seigneur, Cantique in E major', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Pour vous bénir, Seigneur> E장조'
);


-- Op. 42 시편 18편 <Cœli enarrant>

UPDATE pieces piece
SET piece.title = '시편 18편 <Cœli enarrant>', piece.title_en = 'Cœli enarrant (Psalm 18)',
    piece.type = 'album', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2743 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 2743 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주와 합창', part.name_en = 'I. Introduction et choeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:8b3174c3-f234-38b7-a334-2e4e4d9cd1b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b3174c3-f234-38b7-a334-2e4e4d9cd1b6', 1, 'I', '서주와 합창', 'I. Introduction et choeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b3174c3-f234-38b7-a334-2e4e4d9cd1b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '독창과 합창', part.name_en = 'II. Solo et Choeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:803087c7-e54e-3ec0-82fb-1b406beea950' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:803087c7-e54e-3ec0-82fb-1b406beea950', 2, 'II', '독창과 합창', 'II. Solo et Choeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:803087c7-e54e-3ec0-82fb-1b406beea950'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '레치타티보', part.name_en = 'III. Récit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:2c351ffa-5450-3346-ad79-53b094415ae7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c351ffa-5450-3346-ad79-53b094415ae7', 3, 'III', '레치타티보', 'III. Récit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c351ffa-5450-3346-ad79-53b094415ae7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '합창', part.name_en = 'IV. Choeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:270bec42-01d6-32ad-9683-5d6e516234a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:270bec42-01d6-32ad-9683-5d6e516234a5', 4, 'IV', '합창', 'IV. Choeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:270bec42-01d6-32ad-9683-5d6e516234a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '2중창', part.name_en = 'V. Duo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f4aefb58-4c1e-36f3-98e1-c734869b3e06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4aefb58-4c1e-36f3-98e1-c734869b3e06', 5, 'V', '2중창', 'V. Duo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4aefb58-4c1e-36f3-98e1-c734869b3e06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '4중창', part.name_en = 'VI. Quatuor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:597c9703-a65b-35e3-9507-90f442d687a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:597c9703-a65b-35e3-9507-90f442d687a0', 6, 'VI', '4중창', 'VI. Quatuor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:597c9703-a65b-35e3-9507-90f442d687a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '5중창과 합창', part.name_en = 'VII. Quintette et choeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:92dd3f69-1bd2-33e0-b99f-0393003e7c01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92dd3f69-1bd2-33e0-b99f-0393003e7c01', 7, 'VII', '5중창과 합창', 'VII. Quintette et choeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92dd3f69-1bd2-33e0-b99f-0393003e7c01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '6중창', part.name_en = 'VIII. Sextuor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:04f06656-9bfc-35e2-a2b7-af7130f5da8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04f06656-9bfc-35e2-a2b7-af7130f5da8a', 8, 'VIII', '6중창', 'VIII. Sextuor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04f06656-9bfc-35e2-a2b7-af7130f5da8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = '아리아', part.name_en = 'IX. Air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:650e945f-ffbd-3e53-924e-03a82c6bc959' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:650e945f-ffbd-3e53-924e-03a82c6bc959', 9, 'IX', '아리아', 'IX. Air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:650e945f-ffbd-3e53-924e-03a82c6bc959'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = '피날레', part.name_en = 'X. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2743 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:48fdf76d-2550-399d-9281-38bd4abc9a11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48fdf76d-2550-399d-9281-38bd4abc9a11', 10, 'X', '피날레', 'X. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2743 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48fdf76d-2550-399d-9281-38bd4abc9a11'
);


-- Op. 45 오라토리오 <대홍수>

UPDATE pieces piece
SET piece.title = '오라토리오 <대홍수>', piece.title_en = 'Le déluge',
    piece.type = 'song', piece.opus_number = 'Op. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1875, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2741 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1875
WHERE piece.id = 2741 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 54 레퀴엠

UPDATE pieces piece
SET piece.title = '레퀴엠', piece.title_en = 'Requiem',
    piece.type = 'album', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2784 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 2784 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Requiem & 키리에', part.name_en = 'I. Requiem & Kyrie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2784 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ec7f47a9-b1c5-32c4-a912-28ec2cc6a31d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec7f47a9-b1c5-32c4-a912-28ec2cc6a31d', 1, 'I', 'Requiem & 키리에', 'I. Requiem & Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2784 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec7f47a9-b1c5-32c4-a912-28ec2cc6a31d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dies irae', part.name_en = 'II. Dies Irae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2784 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:1b7f489e-5cd1-3609-abe2-cc4d6e48284c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b7f489e-5cd1-3609-abe2-cc4d6e48284c', 2, 'II', 'Dies irae', 'II. Dies Irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2784 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b7f489e-5cd1-3609-abe2-cc4d6e48284c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Rex tremendae', part.name_en = 'III. Rex tremendae',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2784 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:46ec7f2a-dea5-3405-8e1c-3a5126537287' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46ec7f2a-dea5-3405-8e1c-3a5126537287', 3, 'III', 'Rex tremendae', 'III. Rex tremendae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2784 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46ec7f2a-dea5-3405-8e1c-3a5126537287'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Oro supplex', part.name_en = 'IV. Oro supplex',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2784 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:d571c969-ebaa-3b65-8934-461236682661' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d571c969-ebaa-3b65-8934-461236682661', 4, 'IV', 'Oro supplex', 'IV. Oro supplex', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2784 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d571c969-ebaa-3b65-8934-461236682661'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Hostias', part.name_en = 'V. Hostias',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2784 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b3f71028-552f-3c75-a863-4a67ea88299d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3f71028-552f-3c75-a863-4a67ea88299d', 5, 'V', 'Hostias', 'V. Hostias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2784 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3f71028-552f-3c75-a863-4a67ea88299d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '상투스', part.name_en = 'VI. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2784 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:3deb28ea-4ceb-36a3-aa6d-5890a99ad302' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3deb28ea-4ceb-36a3-aa6d-5890a99ad302', 6, 'VI', '상투스', 'VI. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2784 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3deb28ea-4ceb-36a3-aa6d-5890a99ad302'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '베네딕투스', part.name_en = 'VII. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2784 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:fe355abe-bee7-3101-8cf8-b9774b7fa267' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe355abe-bee7-3101-8cf8-b9774b7fa267', 7, 'VII', '베네딕투스', 'VII. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2784 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe355abe-bee7-3101-8cf8-b9774b7fa267'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '아뉴스 데이', part.name_en = 'VIII. Agnus Dei',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2784 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:f901e393-ea63-38a1-b2b8-e019c95e2989' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f901e393-ea63-38a1-b2b8-e019c95e2989', 8, 'VIII', '아뉴스 데이', 'VIII. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2784 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f901e393-ea63-38a1-b2b8-e019c95e2989'
);


-- None <만성절 봉헌송> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<만성절 봉헌송> F장조', 'Offertoire pour la Toussaint in F major', 'song', NULL, NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<만성절 봉헌송> F장조'
);


-- Op. 127 시편 150편 <Laudate Dominum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 150편 <Laudate Dominum>', 'Psalm 150 "Laudate Dominum" (Praise Ye the Lord)', 'song', 'Op. 127', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 150편 <Laudate Dominum>'
);


-- Op. 140 오라토리오 <약속의 땅>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <약속의 땅>', 'La terre promise (The Promised Land)', 'song', 'Op. 140', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <약속의 땅>'
);


-- Op. 145 혼성 합창 <아베 마리아>

UPDATE pieces piece
SET piece.title = '혼성 합창 <아베 마리아>', piece.title_en = 'Ave Maria for Mixed Chorus',
    piece.type = 'song', piece.opus_number = 'Op. 145',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1914, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1988 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1914
WHERE piece.id = 1988 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 147 남성 합창 <Tu es Petrus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <Tu es Petrus>', 'Tu es Petrus', 'song', 'Op. 147', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <Tu es Petrus>'
);


-- Op. 148 모테트 <Quam dilecta>

UPDATE pieces piece
SET piece.title = '모테트 <Quam dilecta>', piece.title_en = 'Quam dilecta, Motet',
    piece.type = 'song', piece.opus_number = 'Op. 148',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1778 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 1778 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 149 무반주 합창 <Laudate Dominum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 합창 <Laudate Dominum>', 'Laudate Dominum for Mixed Chorus', 'song', 'Op. 149', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 합창 <Laudate Dominum>'
);


-- None <아베 베룸> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아베 베룸> D장조', 'Ave verum in D major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아베 베룸> D장조'
);


-- None 9개의 라틴어 성가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '9개의 라틴어 성가', '9 Sacred Latin Chants', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '9개의 라틴어 성가'
);


-- None 시편 136편 <Super flumina Babylonis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 136편 <Super flumina Babylonis>', 'Psalm 136 "Super flumina Babylonis"', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 136편 <Super flumina Babylonis>'
);


-- None 6개의 종교 합창곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 종교 합창곡', '6 Sacred Choruses', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 종교 합창곡'
);


-- None 칸타타 <Imogine>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Imogine>', 'Imogine, Cantata', 'song', NULL, NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Imogine>'
);


-- None 칸타타 <Télésille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Télésille>', 'Télésille, Cantata', 'song', NULL, NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Télésille>'
);


-- None 칸타타 (1849)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 (1849)', 'Cantata (1849)', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 (1849)'
);


-- None 합창곡 <La rose>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <La rose>', 'La rose', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <La rose>'
);


-- None 칸타타 <Le retour de Virginie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Le retour de Virginie>', 'Le retour de Virginie, Cantata', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Le retour de Virginie>'
);


-- None 교향적 송가 <Les cloches>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 송가 <Les cloches>', 'Les cloches, Symphonic Ode', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 송가 <Les cloches>'
);


-- None 푸가와 합창

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가와 합창', 'Fugue et chœur', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가와 합창'
);


-- None <성 세실리아 송가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<성 세실리아 송가>', 'Ode à Sainte-Cécile', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<성 세실리아 송가>'
);


-- None <La toilette de la marquise de Présalé>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<La toilette de la marquise de Présalé>', 'La toilette de la marquise de Présalé', 'song', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<La toilette de la marquise de Présalé>'
);


-- None 합창과 관현악을 위한 <맥베스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창과 관현악을 위한 <맥베스>', 'Macbeth for Chorus and Orchestra', 'song', NULL, NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창과 관현악을 위한 <맥베스>'
);


-- Op. 19 칸타타 <프로메테우스의 결혼>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <프로메테우스의 결혼>', 'Les noces de Prométhée', 'song', 'Op. 19', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <프로메테우스의 결혼>'
);


-- None 남성 합창 <겨울 세레나데>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <겨울 세레나데>', 'Sérénade d''hiver', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <겨울 세레나데>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd26a6941-b955-49fa-a287-8b7abe83a3f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd26a6941-b955-49fa-a287-8b7abe83a3f6'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '남성 합창 <겨울 세레나데>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd26a6941-b955-49fa-a287-8b7abe83a3f6'
);


-- None 합창곡 <La nuage>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <La nuage>', 'La nuage', 'song', NULL, NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <La nuage>'
);


-- Op. 46 남성 합창 <기드온의 병사들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <기드온의 병사들>', 'Les soldats de Gédéon', 'song', 'Op. 46', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <기드온의 병사들>'
);


-- Op. 53 2개의 합창곡 Op. 53

UPDATE pieces piece
SET piece.title = '2개의 합창곡 Op. 53', piece.title_en = '2 Choruses, Op. 53 "L''art d''être grand-père"',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '53',
    piece.composition_year = COALESCE(1878, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2957 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1878
WHERE piece.id = 2957 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson de grand-père', part.name_en = 'Chanson de grand-père',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2957 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:bb7135ed-afcc-4ce0-83ab-aaf784416224' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb7135ed-afcc-4ce0-83ab-aaf784416224', 1, NULL, 'Chanson de grand-père', 'Chanson de grand-père', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2957 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb7135ed-afcc-4ce0-83ab-aaf784416224'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chanson d''ancêtre', part.name_en = 'Chanson d''ancêtre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2957 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:53d05b07-599c-4abd-a467-a12e9b00b656' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53d05b07-599c-4abd-a467-a12e9b00b656', 2, NULL, 'Chanson d''ancêtre', 'Chanson d''ancêtre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2957 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53d05b07-599c-4abd-a467-a12e9b00b656'
);


-- Op. 57 칸타타 <리라와 하프>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <리라와 하프>', 'La lyre et la harpe', 'song', 'Op. 57', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <리라와 하프>'
);


-- Op. 68 2개의 합창곡 Op. 68

UPDATE pieces piece
SET piece.title = '2개의 합창곡 Op. 68', piece.title_en = '2 Choruses, Op. 68',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '68',
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 662 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 662 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Calme des nuits', part.name_en = 'Calme des nuits',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 662 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:ff0f0692-56be-492c-9ec0-0ffc6406c853' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff0f0692-56be-492c-9ec0-0ffc6406c853', 1, NULL, 'Calme des nuits', 'Calme des nuits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 662 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff0f0692-56be-492c-9ec0-0ffc6406c853'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Les Fleurs et les arbres', part.name_en = 'Les Fleurs et les arbres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 662 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:38d94be2-7d1d-47e2-9adc-a2a8d8a7b993' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38d94be2-7d1d-47e2-9adc-a2a8d8a7b993', 2, NULL, 'Les Fleurs et les arbres', 'Les Fleurs et les arbres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 662 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38d94be2-7d1d-47e2-9adc-a2a8d8a7b993'
);


-- Op. 71 2개의 합창곡 Op. 71

UPDATE pieces piece
SET piece.title = '2개의 합창곡 Op. 71', piece.title_en = '2 Choruses, Op. 71',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '71',
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1853 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 1853 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Les Marins de Kermor', part.name_en = 'Les Marins de Kermor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1853 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:7e62c5f9-ea6f-4e44-b0be-ecea3c4580f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e62c5f9-ea6f-4e44-b0be-ecea3c4580f6', 1, NULL, 'Les Marins de Kermor', 'Les Marins de Kermor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1853 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e62c5f9-ea6f-4e44-b0be-ecea3c4580f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Les Titans', part.name_en = 'Les Titans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1853 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4a2b69f5-2a27-460e-ac2e-7589a4279abf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a2b69f5-2a27-460e-ac2e-7589a4279abf', 2, NULL, 'Les Titans', 'Les Titans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1853 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a2b69f5-2a27-460e-ac2e-7589a4279abf'
);


-- Op. 74 남성 합창 <살타렐로>

UPDATE pieces piece
SET piece.title = '남성 합창 <살타렐로>', piece.title_en = 'Saltarelle',
    piece.type = 'song', piece.opus_number = 'Op. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1646 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 1646 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 84 남성 합창 <전사들>

UPDATE pieces piece
SET piece.title = '남성 합창 <전사들>', piece.title_en = 'Les guerriers',
    piece.type = 'song', piece.opus_number = 'Op. 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1610 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 1610 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 26b 칸타타 <페르시아의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <페르시아의 밤>', 'Nuit persane', 'song', 'Op. 26b', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <페르시아의 밤>'
);


-- Op. 113 남성 합창 <가을의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <가을의 노래>', 'Chants d''automne', 'song', 'Op. 113', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <가을의 노래>'
);


-- Op. 114 소프라노와 여성 합창을 위한 <밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소프라노와 여성 합창을 위한 <밤>', 'La nuit', 'song', 'Op. 114', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소프라노와 여성 합창을 위한 <밤>'
);


-- Op. 115 칸타타 <하늘의 불>

UPDATE pieces piece
SET piece.title = '칸타타 <하늘의 불>', piece.title_en = 'Le feu céleste',
    piece.type = 'song', piece.opus_number = 'Op. 115',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2495 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 2495 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 121 남성 합창 <프랑스에게>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <프랑스에게>', 'À la France', 'song', 'Op. 121', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <프랑스에게>'
);


-- None 남성 합창 <호라티우스의 송가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <호라티우스의 송가>', 'Ode d''Horace', 'song', NULL, NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <호라티우스의 송가>'
);


-- Op. 126 칸타타 <코르네유의 영광>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <코르네유의 영광>', 'La gloire de Corneille', 'song', 'Op. 126', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <코르네유의 영광>'
);


-- Op. 129 남성 합창 <아침>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <아침>', 'Le matin for Male Chorus', 'song', 'Op. 129', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <아침>'
);


-- Op. 131 합창곡 <영광>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <영광>', 'La gloire', 'song', 'Op. 131', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <영광>'
);


-- Op. 134 남성 합창 <비행사들에게>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <비행사들에게>', 'Aux aviateurs', 'song', 'Op. 134', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <비행사들에게>'
);


-- Op. 137 남성 합창 <광부들에게>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <광부들에게>', 'Aux mineurs', 'song', 'Op. 137', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <광부들에게>'
);


-- Op. 138 남성 합창 <봄의 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <봄의 찬가>', 'Hymne au printemps', 'song', 'Op. 138', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <봄의 찬가>'
);


-- Op. 141 2개의 합창곡 Op. 141

UPDATE pieces piece
SET piece.title = '2개의 합창곡 Op. 141', piece.title_en = '2 Choruses, Op. 141',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '141',
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1592 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 1592 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Des pas dans l''allée', part.name_en = 'Des pas dans l’allée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1592 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:60479426-db3b-4169-b85a-7c4894d7f9a5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60479426-db3b-4169-b85a-7c4894d7f9a5', 1, NULL, 'Des pas dans l''allée', 'Des pas dans l’allée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1592 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60479426-db3b-4169-b85a-7c4894d7f9a5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Trinquons', part.name_en = 'Trinquons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1592 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:0d6ba7f2-a7a5-4468-b3af-9a6b6d4f954a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d6ba7f2-a7a5-4468-b3af-9a6b6d4f954a', 2, NULL, 'Trinquons', 'Trinquons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1592 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d6ba7f2-a7a5-4468-b3af-9a6b6d4f954a'
);


-- Op. 142 남성 합창 <노동 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <노동 찬가>', 'Hymne au travail', 'song', 'Op. 142', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <노동 찬가>'
);


-- Op. 151 3개의 합창곡 Op. 151

UPDATE pieces piece
SET piece.title = '3개의 합창곡 Op. 151', piece.title_en = '3 Choruses, Op. 151',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '151',
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2142 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 2142 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson des aiguilles', part.name_en = 'Chanson des aiguilles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2142 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4b4ef14a-0175-463a-ab1b-0156156e2082' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b4ef14a-0175-463a-ab1b-0156156e2082', 1, NULL, 'Chanson des aiguilles', 'Chanson des aiguilles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2142 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b4ef14a-0175-463a-ab1b-0156156e2082'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Salut au Chevalier Printemps', part.name_en = 'Salut au Chevalier Printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2142 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:425e1e6a-ed45-4c84-819f-508d84a8b465' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:425e1e6a-ed45-4c84-819f-508d84a8b465', 2, NULL, 'Salut au Chevalier Printemps', 'Salut au Chevalier Printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2142 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:425e1e6a-ed45-4c84-819f-508d84a8b465'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Sourire', part.name_en = 'Le Sourire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2142 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b82c791c-8d75-41fa-aae4-3a4e5dd43b59' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b82c791c-8d75-41fa-aae4-3a4e5dd43b59', 3, NULL, 'Le Sourire', 'Le Sourire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2142 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b82c791c-8d75-41fa-aae4-3a4e5dd43b59'
);


-- None <잔 다르크 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<잔 다르크 찬가>', 'Hymne à Jeanne d''Arc', 'song', NULL, NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<잔 다르크 찬가>'
);


-- Op. 164 2성 합창 <하늘의 정복자들에게>

UPDATE pieces piece
SET piece.title = '2성 합창 <하늘의 정복자들에게>', piece.title_en = 'Aux conquérants de l''air',
    piece.type = 'song', piece.opus_number = 'Op. 164',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2303 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 165 2성 합창 <봄>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2성 합창 <봄>', 'Le printemps', 'song', 'Op. 165', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2성 합창 <봄>'
);


-- None 여성 합창을 위한 카논

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 합창을 위한 카논', 'Canon for Female Chorus', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 합창을 위한 카논'
);


-- None 성가 <À Saint Joseph>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <À Saint Joseph>', 'À Saint Joseph, Cantique', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <À Saint Joseph>'
);


-- None 성가 <Dans ce beau mois>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Dans ce beau mois>', 'Dans ce beau mois, Cantique', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Dans ce beau mois>'
);


-- None 성가 <Nous qu'en ces lieux>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Nous qu''en ces lieux>', 'Nous qu''en ces lieux, Cantique', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Nous qu''en ces lieux>'
);


-- None 성가 <Reçois mes hommages>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Reçois mes hommages>', 'Reçois mes hommages, Cantique', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Reçois mes hommages>'
);


-- None 성가 <La madonna col bambino> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <La madonna col bambino> F장조', 'La madonna col bambino in F major', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <La madonna col bambino> F장조'
);


-- None <O salutaris> B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> B♭장조', 'O salutaris in B♭ major', 'song', NULL, NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> B♭장조'
);


-- None <아베 마리아> B♭장조

UPDATE pieces piece
SET piece.title = '<아베 마리아> B♭장조', piece.title_en = 'Ave Maria in B♭ major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1859, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2254 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1859
WHERE piece.id = 2254 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None <아베 마리아> E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아베 마리아> E장조', 'Ave Maria in E major', 'song', NULL, NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아베 마리아> E장조'
);


-- None <아베 마리아> A장조 (1860)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아베 마리아> A장조 (1860)', 'Ave Maria in A major (c. 1860)', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아베 마리아> A장조 (1860)'
);


-- None <아베 베룸> B♭장조

UPDATE pieces piece
SET piece.title = '<아베 베룸> B♭장조', piece.title_en = 'Ave verum in B♭ major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1021 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 1021 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 성가 <Heureux qui du cœur de Marie> A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Heureux qui du cœur de Marie> A장조', 'Heureux qui du cœur de Marie in A major', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Heureux qui du cœur de Marie> A장조'
);


-- None <O salutaris> A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> A장조', 'O salutaris in A major', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> A장조'
);


-- None 성가 <Reine des cieux> A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Reine des cieux> A♭장조', 'Reine des cieux in A♭ major', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Reine des cieux> A♭장조'
);


-- None <Sub tuum> F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Sub tuum> F단조', 'Sub tuum in F minor', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Sub tuum> F단조'
);


-- None <탄툼 에르고> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<탄툼 에르고> E♭장조', 'Tantum ergo in E♭ major', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<탄툼 에르고> E♭장조'
);


-- None <아베 베룸> B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아베 베룸> B단조', 'Ave verum in B minor', 'song', NULL, NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아베 베룸> B단조'
);


-- None <아베 마리아> A장조 (1865)

UPDATE pieces piece
SET piece.title = '<아베 마리아> A장조 (1865)', piece.title_en = 'Ave Maria in A major (1865)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2509 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 2509 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None <Inviolata> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Inviolata> D장조', 'Inviolata in D major', 'song', NULL, NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Inviolata> D장조'
);


-- None <O salutaris> A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> A♭장조', 'O salutaris in A♭ major', 'song', NULL, NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> A♭장조'
);


-- None <O salutaris> E♭장조 (1875)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> E♭장조 (1875)', 'O salutaris in E♭ major (1875)', 'song', NULL, NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> E♭장조 (1875)'
);


-- None <O salutaris> E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> E장조', 'O salutaris in E major', 'song', NULL, NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> E장조'
);


-- None <O salutaris> E♭장조 (1884)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> E♭장조 (1884)', 'O salutaris in E♭ major (1884)', 'song', NULL, NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> E♭장조 (1884)'
);


-- None <Deus Abraham> F장조

UPDATE pieces piece
SET piece.title = '<Deus Abraham> F장조', piece.title_en = 'Deus Abraham in F major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 876 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 876 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None <Pie Jesu> C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Pie Jesu> C단조', 'Pie Jesu in C minor', 'song', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Pie Jesu> C단조'
);


-- None <Panis angelicus> F장조

UPDATE pieces piece
SET piece.title = '<Panis angelicus> F장조', piece.title_en = 'Panis angelicus in F major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1817 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 1817 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None <성모 호칭 기도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<성모 호칭 기도>', 'Litanies à la Sainte Vierge', 'song', NULL, NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<성모 호칭 기도>'
);


-- Op. 26 가곡집 <페르시아의 노래>

UPDATE pieces piece
SET piece.title = '가곡집 <페르시아의 노래>', piece.title_en = 'Mélodies persanes',
    piece.type = 'album', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1870, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1761 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1870
WHERE piece.id = 1761 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Brise', part.name_en = 'La Brise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1761 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:b295a050-a7b9-47aa-a9a4-ea9e92822a5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b295a050-a7b9-47aa-a9a4-ea9e92822a5b', 1, NULL, 'La Brise', 'La Brise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1761 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b295a050-a7b9-47aa-a9a4-ea9e92822a5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La Splendeur vide', part.name_en = 'La Splendeur vide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1761 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:4e611dbb-9aa7-49ea-bf76-99fa96153a89' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e611dbb-9aa7-49ea-bf76-99fa96153a89', 2, NULL, 'La Splendeur vide', 'La Splendeur vide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1761 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e611dbb-9aa7-49ea-bf76-99fa96153a89'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Solitaire', part.name_en = 'La Solitaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1761 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:437cabd8-e803-4fba-85f3-b8cb5238d8c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:437cabd8-e803-4fba-85f3-b8cb5238d8c7', 3, NULL, 'La Solitaire', 'La Solitaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1761 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:437cabd8-e803-4fba-85f3-b8cb5238d8c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sabre en main', part.name_en = 'Sabre en main',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1761 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:5646d367-491b-49de-9808-3fe572cc0768' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5646d367-491b-49de-9808-3fe572cc0768', 4, NULL, 'Sabre en main', 'Sabre en main', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1761 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5646d367-491b-49de-9808-3fe572cc0768'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Au cimetière', part.name_en = 'Au cimetière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1761 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:50a0f2ab-c367-4df9-a42f-8cf95a3e96e6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50a0f2ab-c367-4df9-a42f-8cf95a3e96e6', 5, NULL, 'Au cimetière', 'Au cimetière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1761 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50a0f2ab-c367-4df9-a42f-8cf95a3e96e6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tournoiement (Songe d''opium)', part.name_en = 'Tournoiement (Songe d''opium)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1761 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:9c59faf2-2b85-3b47-a97b-a4f38b8f9010' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c59faf2-2b85-3b47-a97b-a4f38b8f9010', 6, NULL, 'Tournoiement (Songe d''opium)', 'Tournoiement (Songe d''opium)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1761 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c59faf2-2b85-3b47-a97b-a4f38b8f9010'
);


-- None 가곡집 <롱사르의 시 5편>

UPDATE pieces piece
SET piece.title = '가곡집 <롱사르의 시 5편>', piece.title_en = '5 Poèmes de Ronsard',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2312 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 2312 AND piece.composer_id = 60 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'L''amour oyseau', part.name_en = 'L''amour oyseau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2312 AND p.composer_id = 60 AND part.part_key = 'classicmap:saint-saens:saint-saens-w416:1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-w416:1', 1, NULL, 'L''amour oyseau', 'L''amour oyseau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2312 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-w416:1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L''amour blessé', part.name_en = 'L''amour blessé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2312 AND p.composer_id = 60 AND part.part_key = 'classicmap:saint-saens:saint-saens-w416:2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-w416:2', 2, NULL, 'L''amour blessé', 'L''amour blessé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2312 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-w416:2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'À Sainte-Blaise', part.name_en = 'À Sainte-Blaise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2312 AND p.composer_id = 60 AND part.part_key = 'classicmap:saint-saens:saint-saens-w416:3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-w416:3', 3, NULL, 'À Sainte-Blaise', 'À Sainte-Blaise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2312 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-w416:3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Grasselette et maigrelette', part.name_en = 'Grasselette et maigrelette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2312 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:24321c31-2b3c-430b-879f-6c6f90de98c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24321c31-2b3c-430b-879f-6c6f90de98c5', 4, NULL, 'Grasselette et maigrelette', 'Grasselette et maigrelette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2312 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24321c31-2b3c-430b-879f-6c6f90de98c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'L''amant malheureux', part.name_en = 'L''amant malheureux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2312 AND p.composer_id = 60 AND part.part_key = 'musicbrainz:65e8e28a-ac37-4d41-9ccd-509c5cf1c107' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65e8e28a-ac37-4d41-9ccd-509c5cf1c107', 5, NULL, 'L''amant malheureux', 'L''amant malheureux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2312 AND p.composer_id = 60
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65e8e28a-ac37-4d41-9ccd-509c5cf1c107'
);


-- Op. 146 가곡집 <붉은 재>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <붉은 재>', 'La cendre rouge, 10 Poèmes lyriques', 'album', 'Op. 146', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <붉은 재>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:1', 1, NULL, 'Prélude', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:2', 2, NULL, 'Âme triste', 'Âme triste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:3', 3, NULL, 'Douceur', 'Douceur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:4', 4, NULL, 'Silence', 'Silence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:5', 5, NULL, 'Pâques', 'Pâques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:6', 6, NULL, 'Jour de pluie', 'Jour de pluie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:7', 7, NULL, 'Amoroso', 'Amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:8', 8, NULL, 'Mai', 'Mai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:9', 9, NULL, 'Petite main', 'Petite main', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-op146:10', 10, NULL, 'Reviens', 'Reviens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <붉은 재>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-op146:10'
);


-- None 가곡집 <옛 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <옛 노래>', 'Vieilles chansons', 'album', NULL, NULL, NULL, 1921, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <옛 노래>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 909 AND linked.composer_id = 60), 'musicbrainz:07dc88dd-0410-4b2a-9847-a05c607676a4', 1, NULL, 'Temps nouveau', 'Temps nouveau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <옛 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07dc88dd-0410-4b2a-9847-a05c607676a4'
);

UPDATE pieces piece
SET piece.title = '가곡집 <옛 노래> 중 "Temps nouveau"', piece.title_en = 'Vieilles chansons: Temps nouveau', piece.editor_locked = 1
WHERE piece.id = 909 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-w434:2', 2, NULL, 'Avril', 'Avril', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <옛 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-w434:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:saint-saens:saint-saens-w434:3', 3, NULL, 'Villanelle', 'Villanelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡집 <옛 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:saint-saens:saint-saens-w434:3'
);


-- None 낭송과 피아노를 위한 <Les heures>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '낭송과 피아노를 위한 <Les heures>', 'Les heures', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '낭송과 피아노를 위한 <Les heures>'
);


-- None 가곡 <Ariel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ariel>', 'Ariel', 'song', NULL, NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ariel>'
);


-- None 가곡 <Le soir>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le soir>', 'Le soir', 'song', NULL, NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le soir>'
);


-- None 가곡 <La maman>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La maman>', 'La maman', 'song', NULL, NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La maman>'
);


-- None 가곡 <Tandis que sur vos ans>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tandis que sur vos ans>', 'Tandis que sur vos ans', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tandis que sur vos ans>'
);


-- None 가곡 <La Golfe de Baya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La Golfe de Baya>', 'La Golfe de Baya', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La Golfe de Baya>'
);


-- None 가곡 <Télésille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Télésille>', 'Télésille', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Télésille>'
);


-- None 가곡 <Bergeronnette>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Bergeronnette>', 'Bergeronnette', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Bergeronnette>'
);


-- None 가곡 <Lamento>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lamento>', 'Lamento', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lamento>'
);


-- None 가곡 <Le lac>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le lac>', 'Le lac', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le lac>'
);


-- None 가곡 <Guitare>

UPDATE pieces piece
SET piece.title = '가곡 <Guitare>', piece.title_en = 'Guitare',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1851, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1066 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1851
WHERE piece.id = 1066 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Le poète mourant>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le poète mourant>', 'Le poète mourant', 'song', NULL, NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le poète mourant>'
);


-- None 가곡 <Le rendezvous>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le rendezvous>', 'Le rendezvous', 'song', NULL, NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le rendezvous>'
);


-- None 가곡 <Rêverie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Rêverie>', 'Rêverie', 'song', NULL, NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Rêverie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86013a94-beb3-491d-9f40-59f286e83b98'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86013a94-beb3-491d-9f40-59f286e83b98'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡 <Rêverie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86013a94-beb3-491d-9f40-59f286e83b98'
);


-- None 가곡 <Idylle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Idylle>', 'Idylle', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Idylle>'
);


-- None 가곡 <L'automne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''automne>', 'L''automne', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''automne>'
);


-- None 가곡 <Le pas d'armes du Roi Jean>

UPDATE pieces piece
SET piece.title = '가곡 <Le pas d''armes du Roi Jean>', piece.title_en = 'Le pas d''armes du Roi Jean',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1852, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1132 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1852
WHERE piece.id = 1132 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Mélodie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mélodie>', 'Mélodie', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mélodie>'
);


-- None 가곡 <La feuille de peuplier>

UPDATE pieces piece
SET piece.title = '가곡 <La feuille de peuplier>', piece.title_en = 'La feuille de peuplier',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1853, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1417 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1853
WHERE piece.id = 1417 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Ruhethal>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ruhethal>', 'Ruhethal', 'song', NULL, NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ruhethal>'
);


-- None 가곡 <La chasse du burgrave>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La chasse du burgrave>', 'La chasse du burgrave', 'song', NULL, NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La chasse du burgrave>'
);


-- None 가곡 <La porta dell'inferno>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La porta dell''inferno>', 'La porta dell''inferno', 'song', NULL, NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La porta dell''inferno>'
);


-- None 가곡 <La cloche>

UPDATE pieces piece
SET piece.title = '가곡 <La cloche>', piece.title_en = 'La cloche',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1984 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 1984 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <L'attente>

UPDATE pieces piece
SET piece.title = '가곡 <L''attente>', piece.title_en = 'L''attente',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 957 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 957 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Le lever de la lune>

UPDATE pieces piece
SET piece.title = '가곡 <Le lever de la lune>', piece.title_en = 'Le lever de la lune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1159 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 1159 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Le sommeil des fleurs>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le sommeil des fleurs>', 'Le sommeil des fleurs', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le sommeil des fleurs>'
);


-- None 2중창 <Pastorale>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Pastorale>', 'Pastorale', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Pastorale>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a7c2eb7-31bc-4b42-a1aa-261b22f11a08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3a7c2eb7-31bc-4b42-a1aa-261b22f11a08'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '2중창 <Pastorale>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a7c2eb7-31bc-4b42-a1aa-261b22f11a08'
);


-- None 가곡 <Plainte>

UPDATE pieces piece
SET piece.title = '가곡 <Plainte>', piece.title_en = 'Plainte',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1636 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 1636 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 2중창 <Viens!>

UPDATE pieces piece
SET piece.title = '2중창 <Viens!>', piece.title_en = 'Viens!',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1855, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1165 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1855
WHERE piece.id = 1165 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <À la lune>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <À la lune>', 'À la lune', 'song', NULL, NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <À la lune>'
);


-- None 가곡 <La mort d'Ophélie>

UPDATE pieces piece
SET piece.title = '가곡 <La mort d''Ophélie>', piece.title_en = 'La mort d''Ophélie',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1857, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1898 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1857
WHERE piece.id = 1898 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 2중창 <Le soir descend sur la colline>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Le soir descend sur la colline>', 'Le soir descend sur la colline', 'song', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Le soir descend sur la colline>'
);


-- None 가곡 <Pourquoi t'exiler>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pourquoi t''exiler>', 'Pourquoi t''exiler', 'song', NULL, NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pourquoi t''exiler>'
);


-- None 가곡 <Souvenances>

UPDATE pieces piece
SET piece.title = '가곡 <Souvenances>', piece.title_en = 'Souvenances',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1858, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1567 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1858
WHERE piece.id = 1567 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Étoile du matin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Étoile du matin>', 'Étoile du matin', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Étoile du matin>'
);


-- None 가곡 <Extase>

UPDATE pieces piece
SET piece.title = '가곡 <Extase>', piece.title_en = 'Extase',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1860, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2587 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1860
WHERE piece.id = 2587 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 10 코르네유 <오라스>의 장면

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코르네유 <오라스>의 장면', 'Scène d''Horace', 'song', 'Op. 10', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코르네유 <오라스>의 장면'
);


-- None 가곡 <Soirée en mer>

UPDATE pieces piece
SET piece.title = '가곡 <Soirée en mer>', piece.title_en = 'Soirée en mer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1862, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2837 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1862
WHERE piece.id = 2837 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Canzonetta toscana>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Canzonetta toscana>', 'Canzonetta toscana', 'song', NULL, NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Canzonetta toscana>'
);


-- None 가곡 <Le matin>

UPDATE pieces piece
SET piece.title = '가곡 <Le matin>', piece.title_en = 'Le matin',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1864, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2620 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1864
WHERE piece.id = 2620 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Clair de lune>

UPDATE pieces piece
SET piece.title = '가곡 <Clair de lune>', piece.title_en = 'Clair de lune',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1689 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 1689 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Heures passées>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Heures passées>', 'Heures passées', 'song', NULL, NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Heures passées>'
);


-- None 가곡 <L'enlèvement>

UPDATE pieces piece
SET piece.title = '가곡 <L''enlèvement>', piece.title_en = 'L''enlèvement',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1865, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2107 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1865
WHERE piece.id = 2107 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Le chant de ceux qui s'en vont sur la mer>

UPDATE pieces piece
SET piece.title = '가곡 <Le chant de ceux qui s''en vont sur la mer>', piece.title_en = 'Le chant de ceux qui s''en vont sur la mer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1855 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 1855 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <La coccinelle>

UPDATE pieces piece
SET piece.title = '가곡 <La coccinelle>', piece.title_en = 'La coccinelle',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2694 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 2694 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Maria-Lucrezia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Maria-Lucrezia>', 'Maria-Lucrezia', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Maria-Lucrezia>'
);


-- None 가곡 <Tristesse>

UPDATE pieces piece
SET piece.title = '가곡 <Tristesse>', piece.title_en = 'Tristesse',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1868, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1816 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1868
WHERE piece.id = 1816 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <À quoi bon entendre les oiseaux des bois?>

UPDATE pieces piece
SET piece.title = '가곡 <À quoi bon entendre les oiseaux des bois?>', piece.title_en = 'À quoi bon entendre les oiseaux des bois?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3014 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 3014 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Marquise, vous souvenez-vous?>

UPDATE pieces piece
SET piece.title = '가곡 <Marquise, vous souvenez-vous?>', piece.title_en = 'Marquise, vous souvenez-vous?',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1869, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2131 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1869
WHERE piece.id = 2131 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Si vous n'avez rien à me dire>

UPDATE pieces piece
SET piece.title = '가곡 <Si vous n''avez rien à me dire>', piece.title_en = 'Si vous n''avez rien à me dire',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1870, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1514 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1870
WHERE piece.id = 1514 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <A Voice by the Cedar Tree>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <A Voice by the Cedar Tree>', 'A Voice by the Cedar Tree', 'song', NULL, NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <A Voice by the Cedar Tree>'
);


-- None 가곡 <Désir de l'Orient>

UPDATE pieces piece
SET piece.title = '가곡 <Désir de l''Orient>', piece.title_en = 'Désir de l''Orient',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2302 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 2302 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 2중창 <El desdichado>

UPDATE pieces piece
SET piece.title = '2중창 <El desdichado>', piece.title_en = 'El desdichado',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1871, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2582 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1871
WHERE piece.id = 2582 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <My Land>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <My Land>', 'My Land', 'song', NULL, NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <My Land>'
);


-- None 가곡 <Dans ton cœur>

UPDATE pieces piece
SET piece.title = '가곡 <Dans ton cœur>', piece.title_en = 'Dans ton cœur',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1872, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1715 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1872
WHERE piece.id = 1715 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Danse macabre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Danse macabre>', 'Danse macabre', 'song', NULL, NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Danse macabre>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f47b103e-0133-411e-b9a4-887e8862afe1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f47b103e-0133-411e-b9a4-887e8862afe1'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡 <Danse macabre>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f47b103e-0133-411e-b9a4-887e8862afe1'
);


-- None 가곡 <Vogue, vogue la galère>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Vogue, vogue la galère>', 'Vogue, vogue la galère', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Vogue, vogue la galère>'
);


-- None 가곡 <Night Song of Preciosa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Night Song of Preciosa>', 'Night Song of Preciosa', 'song', NULL, NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Night Song of Preciosa>'
);


-- None 가곡 <Dans les coins bleus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dans les coins bleus>', 'Dans les coins bleus', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dans les coins bleus>'
);


-- None 가곡 <Chanson à boire du vieux temps>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson à boire du vieux temps>', piece.title_en = 'Chanson à boire du vieux temps',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1085 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 1085 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Ronde>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ronde>', 'Ronde', 'song', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ronde>'
);


-- None 가곡 <Une flûte invisible>

UPDATE pieces piece
SET piece.title = '가곡 <Une flûte invisible>', piece.title_en = 'Une flûte invisible',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1644 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 1644 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 82 가곡 <La fiancée du timbalier>

UPDATE pieces piece
SET piece.title = '가곡 <La fiancée du timbalier>', piece.title_en = 'La fiancée du timbalier',
    piece.type = 'song', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 999 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 999 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Suzette et Suzon>

UPDATE pieces piece
SET piece.title = '가곡 <Suzette et Suzon>', piece.title_en = 'Suzette et Suzon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1390 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 1390 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Guitares et mandolines>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Guitares et mandolines>', 'Guitares et mandolines', 'song', NULL, NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Guitares et mandolines>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '813e47d8-53cb-47eb-b80f-fa47537c3c01'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '813e47d8-53cb-47eb-b80f-fa47537c3c01'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡 <Guitares et mandolines>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '813e47d8-53cb-47eb-b80f-fa47537c3c01'
);


-- None 가곡 <Présage de la croix>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Présage de la croix>', 'Présage de la croix', 'song', NULL, NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Présage de la croix>'
);


-- None 가곡 <Aimons-nous>

UPDATE pieces piece
SET piece.title = '가곡 <Aimons-nous>', piece.title_en = 'Aimons-nous',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1088 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 1088 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Amour viril>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Amour viril>', 'Amour viril', 'song', NULL, NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Amour viril>'
);


-- None 가곡 <Là-bas>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Là-bas>', 'Là-bas', 'song', NULL, NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Là-bas>'
);


-- None 가곡 <Les fées>

UPDATE pieces piece
SET piece.title = '가곡 <Les fées>', piece.title_en = 'Les fées',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1868 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 1868 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Les fleurs>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Les fleurs>', 'Les fleurs', 'song', NULL, NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Les fleurs>'
);


-- None 가곡 <Le rossignol>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le rossignol>', 'Le rossignol', 'song', NULL, NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le rossignol>'
);


-- None 가곡 <Madeleine>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Madeleine>', 'Madeleine', 'song', NULL, NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Madeleine>'
);


-- None 가곡 <Romance>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Romance>', 'Romance', 'song', NULL, NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Romance>'
);


-- None 가곡 <Fière beauté>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Fière beauté>', 'Fière beauté', 'song', NULL, NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Fière beauté>'
);


-- None 가곡 <La sérénité>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La sérénité>', 'La sérénité', 'song', NULL, NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La sérénité>'
);


-- None 가곡 <Peut-être?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Peut-être?>', 'Peut-être?', 'song', NULL, NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Peut-être?>'
);


-- None 가곡 <Primavera> (1893)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Primavera> (1893)', 'Primavera (1893)', 'song', NULL, NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Primavera> (1893)'
);


-- None 가곡 <Vive Paris, vive la France>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Vive Paris, vive la France>', 'Vive Paris, vive la France', 'song', NULL, NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Vive Paris, vive la France>'
);


-- None 가곡 <La libellule>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La libellule>', 'La libellule', 'song', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La libellule>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59291d21-5e2c-4372-bbea-6bd97b205fbc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '59291d21-5e2c-4372-bbea-6bd97b205fbc'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡 <La libellule>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59291d21-5e2c-4372-bbea-6bd97b205fbc'
);


-- Op. 98 <팔라스 아테나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<팔라스 아테나>', 'Pallas Athéné', 'song', 'Op. 98', NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<팔라스 아테나>'
);


-- None 가곡 <Pourquoi rester seulette?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pourquoi rester seulette?>', 'Pourquoi rester seulette?', 'song', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pourquoi rester seulette?>'
);


-- None 2중창 <Vénus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Vénus>', 'Vénus', 'song', NULL, NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Vénus>'
);


-- None 가곡 <Madrigal>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Madrigal>', 'Madrigal', 'song', NULL, NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Madrigal>'
);


-- None 가곡 <Les vendanges>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Les vendanges>', 'Les vendanges', 'song', NULL, NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Les vendanges>'
);


-- None 가곡 <Lever de soleil sur le Nil>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lever de soleil sur le Nil>', 'Lever de soleil sur le Nil', 'song', NULL, NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lever de soleil sur le Nil>'
);


-- None 가곡 <Si je l'osais>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Si je l''osais>', 'Si je l''osais', 'song', NULL, NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Si je l''osais>'
);


-- None 가곡 <Sonnet>

UPDATE pieces piece
SET piece.title = '가곡 <Sonnet>', piece.title_en = 'Sonnet',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1489 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 1489 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Les cloches de la mer>

UPDATE pieces piece
SET piece.title = '가곡 <Les cloches de la mer>', piece.title_en = 'Les cloches de la mer',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1804 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 1804 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- Op. 116 <롤라>

UPDATE pieces piece
SET piece.title = '<롤라>', piece.title_en = 'Lola',
    piece.type = 'song', piece.opus_number = 'Op. 116',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 968 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 968 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Désir d'amour>

UPDATE pieces piece
SET piece.title = '가곡 <Désir d''amour>', piece.title_en = 'Désir d''amour',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1515 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 1515 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Elle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Elle>', 'Elle', 'song', NULL, NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Elle>'
);


-- Op. 118 4중창 <Romance du soir>

UPDATE pieces piece
SET piece.title = '4중창 <Romance du soir>', piece.title_en = 'Romance du soir',
    piece.type = 'song', piece.opus_number = 'Op. 118',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3006 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 3006 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <L'arbre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''arbre>', 'L''arbre', 'song', NULL, NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''arbre>'
);


-- None 가곡 <Sœur Anne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sœur Anne>', 'Sœur Anne', 'song', NULL, NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sœur Anne>'
);


-- None 가곡 <Le fleuve>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le fleuve>', 'Le fleuve', 'song', NULL, NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le fleuve>'
);


-- None 가곡 <L'étoile>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''étoile>', 'L''étoile', 'song', NULL, NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''étoile>'
);


-- None 가곡 <Soir romantique>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Soir romantique>', 'Soir romantique', 'song', NULL, NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Soir romantique>'
);


-- None 가곡 <Violons dans le soir>

UPDATE pieces piece
SET piece.title = '가곡 <Violons dans le soir>', piece.title_en = 'Violons dans le soir',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1907, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1906 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1907
WHERE piece.id = 1906 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Fomicacicadéide>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Fomicacicadéide>', 'Fomicacicadéide', 'song', NULL, NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Fomicacicadéide>'
);


-- None 가곡 <La cigale et la fourmi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La cigale et la fourmi>', 'La cigale et la fourmi', 'song', NULL, NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La cigale et la fourmi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0c39870-93fc-41a0-bfcf-be999b491002'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0c39870-93fc-41a0-bfcf-be999b491002'
FROM pieces p
WHERE p.composer_id = 60 AND p.title = '가곡 <La cigale et la fourmi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0c39870-93fc-41a0-bfcf-be999b491002'
);


-- None 가곡 <Le vent dans la plaine>

UPDATE pieces piece
SET piece.title = '가곡 <Le vent dans la plaine>', piece.title_en = 'Le vent dans la plaine',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2511 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 2511 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Les sapins>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Les sapins>', 'Les sapins', 'song', NULL, NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Les sapins>'
);


-- None 가곡 <Vive la France>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Vive la France>', 'Vive la France', 'song', NULL, NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Vive la France>'
);


-- None 가곡 <La Française>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La Française>', 'La Française', 'song', NULL, NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La Française>'
);


-- None 가곡 <Ne l'oubliez pas>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ne l''oubliez pas>', 'Ne l''oubliez pas', 'song', NULL, NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ne l''oubliez pas>'
);


-- None 가곡 <S'il est un charmant gazon>

UPDATE pieces piece
SET piece.title = '가곡 <S''il est un charmant gazon>', piece.title_en = 'S''il est un charmant gazon',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1506 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 1506 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Honneur à l'Amérique>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Honneur à l''Amérique>', 'Honneur à l''Amérique', 'song', NULL, NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Honneur à l''Amérique>'
);


-- None 가곡 <Angélus>

UPDATE pieces piece
SET piece.title = '가곡 <Angélus>', piece.title_en = 'Angélus',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2292 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 2292 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Où nous avons aimé>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Où nous avons aimé>', 'Où nous avons aimé', 'song', NULL, NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Où nous avons aimé>'
);


-- None 가곡 <Papillons>

UPDATE pieces piece
SET piece.title = '가곡 <Papillons>', piece.title_en = 'Papillons',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2094 AND piece.composer_id = 60
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 2094 AND piece.composer_id = 60 AND piece.composition_year IS NULL;


-- None 가곡 <Victoire!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Victoire!>', 'Victoire!', 'song', NULL, NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Victoire!>'
);


-- Op. 159 가곡 <Hymne à la paix>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Hymne à la paix>', 'Hymne à la paix', 'song', 'Op. 159', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Hymne à la paix>'
);


-- None 가곡 <Antwort>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Antwort>', 'Antwort', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Antwort>'
);


-- None 가곡 <Chanson de Fortunio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Chanson de Fortunio>', 'Chanson de Fortunio', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Chanson de Fortunio>'
);


-- None 가곡 <L'echo de la harpe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''echo de la harpe>', 'L''echo de la harpe', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''echo de la harpe>'
);


-- None 가곡 <Primavera> (샤를 도를레앙 시)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Primavera> (샤를 도를레앙 시)', 'Primavera (Charles d''Orléans)', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Primavera> (샤를 도를레앙 시)'
);


-- None 가곡 <Sérénade>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sérénade>', 'Sérénade', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sérénade>'
);


-- None 가곡 <Toi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Toi>', 'Toi', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 60
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Toi>'
);

-- 카탈로그에 대응이 없는 seed 작품 83개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 60 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    567, 604, 665, 737, 773, 785, 839, 845, 875, 877, 891, 915, 934, 1104, 1119, 1120, 1128, 1129, 1152, 1158,
    1162, 1167, 1188, 1261, 1262, 1316, 1340, 1371, 1378, 1438, 1483, 1488, 1507, 1605, 1613, 1654, 1659, 1719, 1749, 1771,
    1810, 1813, 1856, 1909, 1911, 1918, 1919, 1939, 1960, 1973, 1977, 2021, 2052, 2072, 2149, 2197, 2212, 2216, 2327, 2341,
    2441, 2523, 2548, 2571, 2586, 2663, 2672, 2716, 2790, 2794, 2826, 2853, 2861, 2909, 2910, 2935, 2959, 2985, 2998, 9089,
    9851, 11189, 11889
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
