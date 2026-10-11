-- 라흐마니노프 작품을 출판 단위로 다시 짠다(카탈로그: Op.·TN). 작품 83개(묶음 29, 다악장 23, 낱곡 31),
-- 새 작품 15개, 기존 작품 68개(seed 제목 고침 101개), part 339개, 그 아래 0개,
-- 기존 part 고쳐 씀 0개, 기존 작품 연결 41개. 카탈로그에 대응이 없는 seed 43개는 목록에서 숨긴다.
--
-- 정한 것
--   작품번호 없는 곡은 Threlfall–Norris 번호. 변주곡 Op. 22·42·43 과 <철야 기도>·<전례>는 seed 가 안을 가리켜 part 를 둔다.
--   229 전주곡 C#단조·455 Op. 23-5·228 「보칼리제」는 묶음 안 곡으로 잇는다. MB 편곡 모음(catch-all) work 를 가리키는 seed 는 숨긴다.
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

-- Op. 1 피아노 협주곡 1번 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 1번 F#단조', 'Piano Concerto No. 1 in F# minor', 'album', 'Op. 1', NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 1번 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b54d962b-58c0-4151-8db5-d793fd7ce520'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b54d962b-58c0-4151-8db5-d793fd7ce520'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 협주곡 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b54d962b-58c0-4151-8db5-d793fd7ce520'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8b386fb-fe83-37d7-8e55-5c2c0069bb31', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 협주곡 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8b386fb-fe83-37d7-8e55-5c2c0069bb31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf2cc967-8497-30c4-a902-e7c4920c5774', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 협주곡 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf2cc967-8497-30c4-a902-e7c4920c5774'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1027913b-7fe5-337e-a996-eea51d326813', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 협주곡 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1027913b-7fe5-337e-a996-eea51d326813'
);


-- Op. 2 첼로와 피아노를 위한 2개의 소품 Op. 2

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 2개의 소품 Op. 2', piece.title_en = '2 Pieces for Cello and Piano, Op. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '2',
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1842 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 1842 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡 F장조', part.name_en = 'Prélude in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1842 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:9096b9bf-5a44-48a3-9b8d-4434e7e1640d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9096b9bf-5a44-48a3-9b8d-4434e7e1640d', 1, NULL, '전주곡 F장조', 'Prélude in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1842 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9096b9bf-5a44-48a3-9b8d-4434e7e1640d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '동양풍 춤곡 A단조', part.name_en = 'Danse orientale in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1842 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:57eaf9ec-f5b9-492d-9915-b700bc5d6cd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57eaf9ec-f5b9-492d-9915-b700bc5d6cd9', 2, NULL, '동양풍 춤곡 A단조', 'Danse orientale in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1842 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57eaf9ec-f5b9-492d-9915-b700bc5d6cd9'
);


-- Op. 3 환상적 소품집 Op. 3

UPDATE pieces piece
SET piece.title = '환상적 소품집 Op. 3', piece.title_en = 'Morceaux de fantaisie, Op. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '3',
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1920 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 1920 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '엘레지 E♭단조', part.name_en = 'Élégie in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1920 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:fb5fda5d-864c-315b-912b-8ba94ef836ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb5fda5d-864c-315b-912b-8ba94ef836ce', 1, NULL, '엘레지 E♭단조', 'Élégie in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1920 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb5fda5d-864c-315b-912b-8ba94ef836ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 229 AND linked.composer_id = 51),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '전주곡 C#단조 "모스크바의 종"', part.name_en = 'Prélude in C# minor "The Bells of Moscow"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1920 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d0261eb5-7e04-3804-94f6-11f1439442a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 229 AND linked.composer_id = 51), 'musicbrainz:d0261eb5-7e04-3804-94f6-11f1439442a8', 2, NULL, '전주곡 C#단조 "모스크바의 종"', 'Prélude in C# minor "The Bells of Moscow"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1920 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0261eb5-7e04-3804-94f6-11f1439442a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '멜로디 E장조', part.name_en = 'Mélodie in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1920 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5aae00ec-e455-33a1-a582-45947316a87a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5aae00ec-e455-33a1-a582-45947316a87a', 3, NULL, '멜로디 E장조', 'Mélodie in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1920 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aae00ec-e455-33a1-a582-45947316a87a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '폴리시넬 F#단조', part.name_en = 'Polichinelle in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1920 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e75572e0-f1e8-31be-9370-df780be38de3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e75572e0-f1e8-31be-9370-df780be38de3', 4, NULL, '폴리시넬 F#단조', 'Polichinelle in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1920 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e75572e0-f1e8-31be-9370-df780be38de3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '세레나데 B♭단조', part.name_en = 'Sérénade in B♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1920 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:bc2c07bf-e4d9-3139-b732-9130c387392e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc2c07bf-e4d9-3139-b732-9130c387392e', 5, NULL, '세레나데 B♭단조', 'Sérénade in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1920 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc2c07bf-e4d9-3139-b732-9130c387392e'
);


-- Op. 4 6개의 로망스 Op. 4

UPDATE pieces piece
SET piece.catalogue_system = 'Op.', piece.catalogue_number = '4'
WHERE piece.id = 496 AND piece.composer_id = 51
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 496 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'O net, molyu, ne ukhodi!', part.name_en = 'O net, molyu, ne ukhodi!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 496 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2ef7506c-f53d-4d03-b21a-05b30e7efefe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ef7506c-f53d-4d03-b21a-05b30e7efefe', 1, NULL, 'O net, molyu, ne ukhodi!', 'O net, molyu, ne ukhodi!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 496 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ef7506c-f53d-4d03-b21a-05b30e7efefe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Utro', part.name_en = 'Utro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 496 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c329e920-7432-42ff-9f38-54b78005de30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c329e920-7432-42ff-9f38-54b78005de30', 2, NULL, 'Utro', 'Utro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 496 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c329e920-7432-42ff-9f38-54b78005de30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'V molchan''i nochi taynoy', part.name_en = 'V molchan''i nochi taynoy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 496 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:02b4a195-6462-399c-a854-8f26b372cac7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02b4a195-6462-399c-a854-8f26b372cac7', 3, NULL, 'V molchan''i nochi taynoy', 'V molchan''i nochi taynoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 496 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02b4a195-6462-399c-a854-8f26b372cac7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2408 AND linked.composer_id = 51),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ne poy, krasavitsa, pri mne', part.name_en = 'Ne poy, krasavitsa, pri mne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 496 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c8341d42-38cc-494c-95df-b5a9d548f8f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2408 AND linked.composer_id = 51), 'musicbrainz:c8341d42-38cc-494c-95df-b5a9d548f8f3', 4, NULL, 'Ne poy, krasavitsa, pri mne', 'Ne poy, krasavitsa, pri mne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 496 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8341d42-38cc-494c-95df-b5a9d548f8f3'
);

UPDATE pieces piece
SET piece.title = '6개의 로망스 Op. 4 중 "Ne poy, krasavitsa, pri mne"', piece.title_en = '6 Romances, Op. 4: Ne poy, krasavitsa, pri mne', piece.editor_locked = 1
WHERE piece.id = 2408 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Uzh ty, niva moya', part.name_en = 'Uzh ty, niva moya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 496 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:76df0c6c-6807-41dc-89d1-3b1205c58ef9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76df0c6c-6807-41dc-89d1-3b1205c58ef9', 5, NULL, 'Uzh ty, niva moya', 'Uzh ty, niva moya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 496 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76df0c6c-6807-41dc-89d1-3b1205c58ef9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Davno l'', moy drug', part.name_en = 'Davno l'', moy drug',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 496 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b18908da-7e41-4d86-b211-3edc1a69abdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b18908da-7e41-4d86-b211-3edc1a69abdf', 6, NULL, 'Davno l'', moy drug', 'Davno l'', moy drug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 496 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b18908da-7e41-4d86-b211-3edc1a69abdf'
);


-- Op. 5 두 대의 피아노를 위한 모음곡 1번 "환상적 그림"

UPDATE pieces piece
SET piece.title = '두 대의 피아노를 위한 모음곡 1번 "환상적 그림"', piece.title_en = 'Suite No. 1 for Two Pianos "Fantaisie-tableaux", Op. 5',
    piece.type = 'album', piece.opus_number = 'Op. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13290 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 13290 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '뱃노래. Allegretto', part.name_en = 'I. Barcarolle: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13290 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:39f9f63c-be97-4ab0-8aeb-8e7dde927309' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39f9f63c-be97-4ab0-8aeb-8e7dde927309', 1, 'I', '뱃노래. Allegretto', 'I. Barcarolle: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13290 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39f9f63c-be97-4ab0-8aeb-8e7dde927309'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La nuit... L''amour... Adagio sostenuto', part.name_en = 'II. La nuit... L''amour...: Adagio sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13290 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b7f066a8-6b0c-45f0-a8e9-659563bcdb7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7f066a8-6b0c-45f0-a8e9-659563bcdb7e', 2, 'II', 'La nuit... L''amour... Adagio sostenuto', 'II. La nuit... L''amour...: Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13290 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7f066a8-6b0c-45f0-a8e9-659563bcdb7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Les larmes. Largo di molto', part.name_en = 'III. Les larmes: Largo di molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13290 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e722e64f-ff16-4768-b398-631bd331e521' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e722e64f-ff16-4768-b398-631bd331e521', 3, 'III', 'Les larmes. Largo di molto', 'III. Les larmes: Largo di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13290 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e722e64f-ff16-4768-b398-631bd331e521'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Pâques. Allegro maestoso', part.name_en = 'IV. Pâques: Allegro maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13290 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:dd4a665d-c825-3e69-8a60-ca28861d1fdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd4a665d-c825-3e69-8a60-ca28861d1fdf', 4, 'IV', 'Pâques. Allegro maestoso', 'IV. Pâques: Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13290 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd4a665d-c825-3e69-8a60-ca28861d1fdf'
);


-- Op. 6 바이올린과 피아노를 위한 2개의 살롱 소품 Op. 6

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 2개의 살롱 소품 Op. 6', piece.title_en = '2 Morceaux de salon for Violin and Piano, Op. 6',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '6',
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1859 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 1859 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '로망스 D단조', part.name_en = 'Romance in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1859 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:1123334e-9195-3675-8cab-c9aefb6dc3b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1123334e-9195-3675-8cab-c9aefb6dc3b6', 1, NULL, '로망스 D단조', 'Romance in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1859 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1123334e-9195-3675-8cab-c9aefb6dc3b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '헝가리 춤곡 D단조', part.name_en = 'Danse hongroise in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1859 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:cb9ce95d-5455-4470-86fb-b69aa8219a43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb9ce95d-5455-4470-86fb-b69aa8219a43', 2, NULL, '헝가리 춤곡 D단조', 'Danse hongroise in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1859 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb9ce95d-5455-4470-86fb-b69aa8219a43'
);


-- Op. 7 관현악 환상곡 <바위>

UPDATE pieces piece
SET piece.title = '관현악 환상곡 <바위>', piece.title_en = 'The Rock, Fantasy for Orchestra, Op. 7',
    piece.type = 'song', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 610 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 610 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- Op. 8 6개의 로망스 Op. 8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 8', '6 Romances, Op. 8', 'album', NULL, 'Op.', '8', 1893, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 8'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a322d4e-58d2-4c8a-bcfc-fe5e5f70c32b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a322d4e-58d2-4c8a-bcfc-fe5e5f70c32b'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a322d4e-58d2-4c8a-bcfc-fe5e5f70c32b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:187e6944-295a-4792-8bb9-01fb45fc3d29', 1, NULL, 'Rechnaya lileya', 'Rechnaya lileya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:187e6944-295a-4792-8bb9-01fb45fc3d29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4da454a0-a811-4127-ace4-02920b782c95', 2, NULL, 'Ditya, kak tsvetok ty prekrasna', 'Ditya, kak tsvetok ty prekrasna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4da454a0-a811-4127-ace4-02920b782c95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfbe4aac-be1b-4492-81de-751e097d3a49', 3, NULL, 'Duma', 'Duma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfbe4aac-be1b-4492-81de-751e097d3a49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4da2d5c1-50d5-479e-8547-3db011ef48af', 4, NULL, 'Polyubila ya na pechal'' svoyu', 'Polyubila ya na pechal'' svoyu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4da2d5c1-50d5-479e-8547-3db011ef48af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0725205c-902e-4d58-a9db-e92686158775', 5, NULL, 'Son', 'Son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0725205c-902e-4d58-a9db-e92686158775'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd23d87-3cbf-42e3-af18-8f619d55864c', 6, NULL, 'Molitva', 'Molitva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd23d87-3cbf-42e3-af18-8f619d55864c'
);


-- Op. 9 피아노 3중주 2번 D단조 "비가"

UPDATE pieces piece
SET piece.title = '피아노 3중주 2번 D단조 "비가"', piece.title_en = 'Trio élégiaque No. 2 in D minor, Op. 9',
    piece.type = 'album', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12182 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 12182 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12182 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:71795545-5cfd-38fa-85b9-9bde61c4743c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71795545-5cfd-38fa-85b9-9bde61c4743c', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12182 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71795545-5cfd-38fa-85b9-9bde61c4743c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Quasi variazione', part.name_en = 'II. Quasi variazione',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12182 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ab058a70-c9bc-3135-a6e6-c0f7539c920c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab058a70-c9bc-3135-a6e6-c0f7539c920c', 2, 'II', 'Quasi variazione', 'II. Quasi variazione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12182 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab058a70-c9bc-3135-a6e6-c0f7539c920c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro risoluto', part.name_en = 'III. Allegro risoluto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12182 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:bdfaea55-9816-3de4-b57d-db3933da2007' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdfaea55-9816-3de4-b57d-db3933da2007', 3, 'III', 'Allegro risoluto', 'III. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12182 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdfaea55-9816-3de4-b57d-db3933da2007'
);


-- Op. 10 살롱 소품집 Op. 10

UPDATE pieces piece
SET piece.title = '살롱 소품집 Op. 10', piece.title_en = 'Morceaux de salon, Op. 10',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '10',
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 975 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 975 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '녹턴 A단조', part.name_en = 'Nocturne in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 975 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:4528a199-9bfe-42a4-ba18-d9720d1ac223' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4528a199-9bfe-42a4-ba18-d9720d1ac223', 1, NULL, '녹턴 A단조', 'Nocturne in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 975 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4528a199-9bfe-42a4-ba18-d9720d1ac223'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '왈츠 A장조', part.name_en = 'Valse in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 975 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5200c3bf-a3a6-4d2a-8dd6-3b082ad41058' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5200c3bf-a3a6-4d2a-8dd6-3b082ad41058', 2, NULL, '왈츠 A장조', 'Valse in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 975 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5200c3bf-a3a6-4d2a-8dd6-3b082ad41058'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '뱃노래 G단조', part.name_en = 'Barcarolle in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 975 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:0e218339-fab1-4a65-8d7d-fd1ae1719088' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e218339-fab1-4a65-8d7d-fd1ae1719088', 3, NULL, '뱃노래 G단조', 'Barcarolle in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 975 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e218339-fab1-4a65-8d7d-fd1ae1719088'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '멜로디 E단조', part.name_en = 'Mélodie in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 975 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:041a6e1a-9f2f-4478-a332-51bca78c6f5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:041a6e1a-9f2f-4478-a332-51bca78c6f5f', 4, NULL, '멜로디 E단조', 'Mélodie in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 975 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:041a6e1a-9f2f-4478-a332-51bca78c6f5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '유머레스크 G장조', part.name_en = 'Humoresque in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 975 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c90f6019-76ff-4304-b5cc-295aa0eecf70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c90f6019-76ff-4304-b5cc-295aa0eecf70', 5, NULL, '유머레스크 G장조', 'Humoresque in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 975 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c90f6019-76ff-4304-b5cc-295aa0eecf70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '로망스 F단조', part.name_en = 'Romance in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 975 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:cbb27e7d-325d-413a-8210-63122ac59811' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbb27e7d-325d-413a-8210-63122ac59811', 6, NULL, '로망스 F단조', 'Romance in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 975 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbb27e7d-325d-413a-8210-63122ac59811'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '마주르카 D♭장조', part.name_en = 'Mazurka in D♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 975 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6af9fd79-38ab-461c-b4bf-8b285ccbd7a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6af9fd79-38ab-461c-b4bf-8b285ccbd7a9', 7, NULL, '마주르카 D♭장조', 'Mazurka in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 975 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6af9fd79-38ab-461c-b4bf-8b285ccbd7a9'
);


-- Op. 11 피아노 연탄을 위한 6개의 소품 Op. 11

UPDATE pieces piece
SET piece.title = '피아노 연탄을 위한 6개의 소품 Op. 11', piece.title_en = '6 Morceaux for Piano Four Hands, Op. 11',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '11',
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 822 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 822 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '뱃노래 G단조', part.name_en = 'Barcarolle in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 822 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:47881a56-27dd-42af-b6be-340b5d4b2ae9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47881a56-27dd-42af-b6be-340b5d4b2ae9', 1, NULL, '뱃노래 G단조', 'Barcarolle in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 822 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47881a56-27dd-42af-b6be-340b5d4b2ae9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '스케르초 D장조', part.name_en = 'Scherzo in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 822 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d6f9a695-3293-4bb3-95a5-f8a4689a35e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6f9a695-3293-4bb3-95a5-f8a4689a35e5', 2, NULL, '스케르초 D장조', 'Scherzo in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 822 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6f9a695-3293-4bb3-95a5-f8a4689a35e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '러시아 주제 B단조', part.name_en = 'Thème russe in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 822 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c8446c75-da47-43e5-9f0f-ab1e1118292d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8446c75-da47-43e5-9f0f-ab1e1118292d', 3, NULL, '러시아 주제 B단조', 'Thème russe in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 822 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8446c75-da47-43e5-9f0f-ab1e1118292d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '왈츠 A장조', part.name_en = 'Valse in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 822 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5d3387c7-b5af-4405-96a1-bb1dd559281b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d3387c7-b5af-4405-96a1-bb1dd559281b', 4, NULL, '왈츠 A장조', 'Valse in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 822 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d3387c7-b5af-4405-96a1-bb1dd559281b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '로망스 C단조', part.name_en = 'Romance in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 822 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6c727fab-3755-47d2-8af0-d9a8a7f9d996' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c727fab-3755-47d2-8af0-d9a8a7f9d996', 5, NULL, '로망스 C단조', 'Romance in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 822 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c727fab-3755-47d2-8af0-d9a8a7f9d996'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '슬라바 C장조', part.name_en = 'Slava in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 822 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3a5bb5e5-adc0-4b26-82fb-241ea02a6028' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a5bb5e5-adc0-4b26-82fb-241ea02a6028', 6, NULL, '슬라바 C장조', 'Slava in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 822 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a5bb5e5-adc0-4b26-82fb-241ea02a6028'
);


-- Op. 12 집시 주제에 의한 카프리치오

UPDATE pieces piece
SET piece.title = '집시 주제에 의한 카프리치오', piece.title_en = 'Caprice bohémien, Op. 12',
    piece.type = 'song', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2421 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 2421 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- Op. 13 교향곡 1번 D단조

UPDATE pieces piece
SET piece.title = '교향곡 1번 D단조', piece.title_en = 'Symphony No. 1 in D minor, Op. 13',
    piece.type = 'album', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1895, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1192 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1895
WHERE piece.id = 1192 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Grave — Allegro ma non troppo', part.name_en = 'I. Grave — Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1192 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:a058038b-d246-3b75-9da4-f60c6f261253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a058038b-d246-3b75-9da4-f60c6f261253', 1, 'I', 'Grave — Allegro ma non troppo', 'I. Grave — Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1192 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a058038b-d246-3b75-9da4-f60c6f261253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Allegro animato', part.name_en = 'II. Allegro animato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1192 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3806596b-5831-3b9e-b0e5-c5b7d93bf634' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3806596b-5831-3b9e-b0e5-c5b7d93bf634', 2, 'II', '스케르초. Allegro animato', 'II. Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1192 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3806596b-5831-3b9e-b0e5-c5b7d93bf634'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Larghetto', part.name_en = 'III. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1192 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7e4ae7c1-4921-380a-b198-d8a3c9335479' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e4ae7c1-4921-380a-b198-d8a3c9335479', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1192 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e4ae7c1-4921-380a-b198-d8a3c9335479'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con fuoco', part.name_en = 'IV. Allegro con fuoco',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1192 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:f38fdd59-0ea6-330f-91ee-ab4c1514ac87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f38fdd59-0ea6-330f-91ee-ab4c1514ac87', 4, 'IV', 'Allegro con fuoco', 'IV. Allegro con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1192 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f38fdd59-0ea6-330f-91ee-ab4c1514ac87'
);


-- Op. 14 12개의 로망스 Op. 14

UPDATE pieces piece
SET piece.title = '12개의 로망스 Op. 14', piece.title_en = '12 Romances, Op. 14',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '14',
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2838 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 2838 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Ya zhdu tebya', part.name_en = 'Ya zhdu tebya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ef148cc3-e73d-4dce-bd05-b28247dd3f6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef148cc3-e73d-4dce-bd05-b28247dd3f6c', 1, NULL, 'Ya zhdu tebya', 'Ya zhdu tebya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef148cc3-e73d-4dce-bd05-b28247dd3f6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Ostrovok', part.name_en = 'Ostrovok',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e028496e-046f-4d8f-bea8-d81d8ed736c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e028496e-046f-4d8f-bea8-d81d8ed736c1', 2, NULL, 'Ostrovok', 'Ostrovok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e028496e-046f-4d8f-bea8-d81d8ed736c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Davno v lyubvi otrady malo', part.name_en = 'Davno v lyubvi otrady malo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:9d1e030a-1b4b-4f3b-b4ed-25afea5eb6d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d1e030a-1b4b-4f3b-b4ed-25afea5eb6d3', 3, NULL, 'Davno v lyubvi otrady malo', 'Davno v lyubvi otrady malo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d1e030a-1b4b-4f3b-b4ed-25afea5eb6d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ya byl u ney', part.name_en = 'Ya byl u ney',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8e7bc582-d0f8-48b2-bde6-2e96ba8232d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e7bc582-d0f8-48b2-bde6-2e96ba8232d2', 4, NULL, 'Ya byl u ney', 'Ya byl u ney', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e7bc582-d0f8-48b2-bde6-2e96ba8232d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Eti letniye nochi', part.name_en = 'Eti letniye nochi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:995acac3-99fa-4c76-9f31-e7a7bff4d1cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:995acac3-99fa-4c76-9f31-e7a7bff4d1cc', 5, NULL, 'Eti letniye nochi', 'Eti letniye nochi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:995acac3-99fa-4c76-9f31-e7a7bff4d1cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Tebya tak lyubyat vse', part.name_en = 'Tebya tak lyubyat vse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:09c09afa-a369-4e73-9a1c-41c94a765508' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09c09afa-a369-4e73-9a1c-41c94a765508', 6, NULL, 'Tebya tak lyubyat vse', 'Tebya tak lyubyat vse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09c09afa-a369-4e73-9a1c-41c94a765508'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ne ver'' mne, drug!', part.name_en = 'Ne ver'' mne, drug!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:0ee421eb-6df6-4c32-b161-c044a4b1c141' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee421eb-6df6-4c32-b161-c044a4b1c141', 7, NULL, 'Ne ver'' mne, drug!', 'Ne ver'' mne, drug!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee421eb-6df6-4c32-b161-c044a4b1c141'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'O, ne grusti!', part.name_en = 'O, ne grusti!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:1061cba7-ca2c-4ed9-b7c6-83d705d6611a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1061cba7-ca2c-4ed9-b7c6-83d705d6611a', 8, NULL, 'O, ne grusti!', 'O, ne grusti!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1061cba7-ca2c-4ed9-b7c6-83d705d6611a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ona, kak polden'', khorosha', part.name_en = 'Ona, kak polden'', khorosha',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:efb99d6d-524c-4129-b4ff-3ed32f13c9e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efb99d6d-524c-4129-b4ff-3ed32f13c9e4', 9, NULL, 'Ona, kak polden'', khorosha', 'Ona, kak polden'', khorosha', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efb99d6d-524c-4129-b4ff-3ed32f13c9e4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'V moyey dushe', part.name_en = 'V moyey dushe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:775fac4b-a27e-4451-bbf9-1f86f2dde287' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:775fac4b-a27e-4451-bbf9-1f86f2dde287', 10, NULL, 'V moyey dushe', 'V moyey dushe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:775fac4b-a27e-4451-bbf9-1f86f2dde287'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Vesenniye vody', part.name_en = 'Vesenniye vody',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2f2648bd-c5f9-45ec-b00b-873eed2b23b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f2648bd-c5f9-45ec-b00b-873eed2b23b2', 11, NULL, 'Vesenniye vody', 'Vesenniye vody', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f2648bd-c5f9-45ec-b00b-873eed2b23b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Pora!', part.name_en = 'Pora!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2838 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:19f7879c-b890-44e6-aae6-1216f957ec3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19f7879c-b890-44e6-aae6-1216f957ec3b', 12, NULL, 'Pora!', 'Pora!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2838 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19f7879c-b890-44e6-aae6-1216f957ec3b'
);


-- Op. 15 6개의 합창곡 Op. 15

UPDATE pieces piece
SET piece.title = '6개의 합창곡 Op. 15', piece.title_en = '6 Choruses, Op. 15',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '15',
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 880 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 880 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Slav''sya!', part.name_en = 'Slav''sya!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 880 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:4665b15e-0dde-4dd4-ad1f-82b5eaad1aa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4665b15e-0dde-4dd4-ad1f-82b5eaad1aa9', 1, NULL, 'Slav''sya!', 'Slav''sya!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 880 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4665b15e-0dde-4dd4-ad1f-82b5eaad1aa9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nochka', part.name_en = 'Nochka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 880 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6abc14f2-9cc3-4bc8-8966-581fc74f9824' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6abc14f2-9cc3-4bc8-8966-581fc74f9824', 2, NULL, 'Nochka', 'Nochka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 880 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6abc14f2-9cc3-4bc8-8966-581fc74f9824'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sosna', part.name_en = 'Sosna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 880 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e3d6f9a8-78e2-4960-a461-38527216d522' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3d6f9a8-78e2-4960-a461-38527216d522', 3, NULL, 'Sosna', 'Sosna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 880 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3d6f9a8-78e2-4960-a461-38527216d522'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Zadremali volny', part.name_en = 'Zadremali volny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 880 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:be1515c5-6885-4d53-bf12-4f8ca9e86670' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be1515c5-6885-4d53-bf12-4f8ca9e86670', 4, NULL, 'Zadremali volny', 'Zadremali volny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 880 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be1515c5-6885-4d53-bf12-4f8ca9e86670'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Nevolya', part.name_en = 'Nevolya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 880 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e1f98fe3-8230-4fe3-ae2a-ff530c9c4d1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1f98fe3-8230-4fe3-ae2a-ff530c9c4d1a', 5, NULL, 'Nevolya', 'Nevolya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 880 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1f98fe3-8230-4fe3-ae2a-ff530c9c4d1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Angel', part.name_en = 'Angel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 880 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:40d03f2e-86ae-4de3-a824-1891900dcc8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40d03f2e-86ae-4de3-a824-1891900dcc8f', 6, NULL, 'Angel', 'Angel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 880 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40d03f2e-86ae-4de3-a824-1891900dcc8f'
);


-- Op. 16 악흥의 순간 Op. 16

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '악흥의 순간 Op. 16', '6 Moments musicaux, Op. 16', 'album', NULL, 'Op.', '16', 1896, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '악흥의 순간 Op. 16'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec96faf2-f16a-4741-a132-d21e82938cc7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec96faf2-f16a-4741-a132-d21e82938cc7'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '악흥의 순간 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec96faf2-f16a-4741-a132-d21e82938cc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c0e55ba-ce26-43cb-b69e-615008b98228', 1, NULL, 'Andantino B♭단조', 'Andantino in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '악흥의 순간 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c0e55ba-ce26-43cb-b69e-615008b98228'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:893e45e2-1dee-409b-a6e3-ba4306d3a583', 2, NULL, 'Allegretto E♭단조', 'Allegretto in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '악흥의 순간 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:893e45e2-1dee-409b-a6e3-ba4306d3a583'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f6105e7-0098-4c60-a697-688db113d5cd', 3, NULL, 'Andante cantabile B단조', 'Andante cantabile in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '악흥의 순간 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f6105e7-0098-4c60-a697-688db113d5cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2afb0719-5599-45a4-a808-a57c3c83df1e', 4, NULL, 'Presto E단조', 'Presto in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '악흥의 순간 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2afb0719-5599-45a4-a808-a57c3c83df1e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fc20ef6-67b1-4519-8049-5efacfd14669', 5, NULL, 'Adagio sostenuto D♭장조', 'Adagio sostenuto in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '악흥의 순간 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fc20ef6-67b1-4519-8049-5efacfd14669'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff987495-fdb4-4923-9b39-0d8082b0b749', 6, NULL, 'Maestoso C장조', 'Maestoso in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '악흥의 순간 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff987495-fdb4-4923-9b39-0d8082b0b749'
);


-- Op. 17 두 대의 피아노를 위한 모음곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 모음곡 2번', 'Suite No. 2 for Two Pianos, Op. 17', 'album', 'Op. 17', NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 모음곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2086db91-1680-47c7-820b-864bb599b129'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2086db91-1680-47c7-820b-864bb599b129'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '두 대의 피아노를 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2086db91-1680-47c7-820b-864bb599b129'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d198a80-233c-3a44-91d3-679eed6bb407', 1, 'I', '서주. Alla marcia', 'I. Introduction: Alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '두 대의 피아노를 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d198a80-233c-3a44-91d3-679eed6bb407'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:335168cc-c6d6-31ab-a87b-c4c5458784dd', 2, 'II', '왈츠. Presto', 'II. Valse: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '두 대의 피아노를 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:335168cc-c6d6-31ab-a87b-c4c5458784dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c1c7bc-6be4-38ae-9785-6b2dc7af9dae', 3, 'III', '로망스. Andantino', 'III. Romance: Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '두 대의 피아노를 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c1c7bc-6be4-38ae-9785-6b2dc7af9dae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef76fd52-f7de-3b62-ba8e-d151ba635be9', 4, 'IV', '타란텔라. Presto', 'IV. Tarantelle: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '두 대의 피아노를 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef76fd52-f7de-3b62-ba8e-d151ba635be9'
);


-- Op. 18 피아노 협주곡 2번 C단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 225 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:4661a9a2-3986-30a8-a044-b79359dfd4fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4661a9a2-3986-30a8-a044-b79359dfd4fc', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 225 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4661a9a2-3986-30a8-a044-b79359dfd4fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio sostenuto', part.name_en = 'II. Adagio sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 225 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ee48e04f-d88e-3562-b5b9-98ceb0d218d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee48e04f-d88e-3562-b5b9-98ceb0d218d1', 2, 'II', 'Adagio sostenuto', 'II. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 225 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee48e04f-d88e-3562-b5b9-98ceb0d218d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro scherzando', part.name_en = 'III. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 225 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:f06a3c2f-ae0d-30d0-b108-c8cf8af6fc33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f06a3c2f-ae0d-30d0-b108-c8cf8af6fc33', 3, 'III', 'Allegro scherzando', 'III. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 225 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f06a3c2f-ae0d-30d0-b108-c8cf8af6fc33'
);


-- Op. 19 첼로 소나타 G단조

UPDATE pieces piece
SET piece.title = '첼로 소나타 G단조', piece.title_en = 'Cello Sonata in G minor, Op. 19',
    piece.type = 'album', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 702 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 702 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento — Allegro moderato', part.name_en = 'I. Lento — Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 702 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7533a62f-d244-3cf8-89ed-da576eb9ea76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7533a62f-d244-3cf8-89ed-da576eb9ea76', 1, 'I', 'Lento — Allegro moderato', 'I. Lento — Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 702 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7533a62f-d244-3cf8-89ed-da576eb9ea76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro scherzando', part.name_en = 'II. Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 702 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:47711307-5fae-3e9c-aea7-ff965a48b4a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47711307-5fae-3e9c-aea7-ff965a48b4a9', 2, 'II', 'Allegro scherzando', 'II. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 702 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47711307-5fae-3e9c-aea7-ff965a48b4a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 702 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:416888a5-862a-389e-b21c-d43a5e716c96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:416888a5-862a-389e-b21c-d43a5e716c96', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 702 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:416888a5-862a-389e-b21c-d43a5e716c96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro mosso', part.name_en = 'IV. Allegro mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 702 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:93bc3ba3-7c26-3df2-be97-d7d02e0d324b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93bc3ba3-7c26-3df2-be97-d7d02e0d324b', 4, 'IV', 'Allegro mosso', 'IV. Allegro mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 702 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93bc3ba3-7c26-3df2-be97-d7d02e0d324b'
);


-- Op. 20 칸타타 <봄>

UPDATE pieces piece
SET piece.title = '칸타타 <봄>', piece.title_en = 'Spring, Cantata, Op. 20',
    piece.type = 'song', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 597 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 597 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- Op. 21 12개의 로망스 Op. 21

UPDATE pieces piece
SET piece.title = '12개의 로망스 Op. 21', piece.title_en = '12 Romances, Op. 21',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '21',
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 563 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 563 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sud''ba', part.name_en = 'Sud''ba',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8e51593b-643e-4f30-a615-e683b504218a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e51593b-643e-4f30-a615-e683b504218a', 1, NULL, 'Sud''ba', 'Sud''ba', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e51593b-643e-4f30-a615-e683b504218a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Nad svezhey mogiloy', part.name_en = 'Nad svezhey mogiloy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3857e0de-5373-44d7-a351-71b47fc62b93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3857e0de-5373-44d7-a351-71b47fc62b93', 2, NULL, 'Nad svezhey mogiloy', 'Nad svezhey mogiloy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3857e0de-5373-44d7-a351-71b47fc62b93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sumerki', part.name_en = 'Sumerki',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:39797244-a3c9-4311-b6e0-832d6bbf07c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39797244-a3c9-4311-b6e0-832d6bbf07c5', 3, NULL, 'Sumerki', 'Sumerki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39797244-a3c9-4311-b6e0-832d6bbf07c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 838 AND linked.composer_id = 51),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Oni otvechali', part.name_en = 'Oni otvechali',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:71a204ca-c20c-471d-b3a0-7bfbae0fbdbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 838 AND linked.composer_id = 51), 'musicbrainz:71a204ca-c20c-471d-b3a0-7bfbae0fbdbf', 4, NULL, 'Oni otvechali', 'Oni otvechali', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71a204ca-c20c-471d-b3a0-7bfbae0fbdbf'
);

UPDATE pieces piece
SET piece.title = '12개의 로망스 Op. 21 중 "Oni otvechali"', piece.title_en = '12 Romances, Op. 21: Oni otvechali', piece.editor_locked = 1
WHERE piece.id = 838 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '라일락 (Siren'')', part.name_en = 'Siren''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:95e6cd62-11db-3a40-86b9-b0c5edb5cd0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95e6cd62-11db-3a40-86b9-b0c5edb5cd0b', 5, NULL, '라일락 (Siren'')', 'Siren''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95e6cd62-11db-3a40-86b9-b0c5edb5cd0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Otryvok iz A. Myusse', part.name_en = 'Otryvok iz A. Myusse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:577fdece-1f56-491d-8883-698d9266ebf9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:577fdece-1f56-491d-8883-698d9266ebf9', 6, NULL, 'Otryvok iz A. Myusse', 'Otryvok iz A. Myusse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:577fdece-1f56-491d-8883-698d9266ebf9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Zdes'' khorosho', part.name_en = 'Zdes'' khorosho',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:4e908cfa-4961-34c7-8a85-149c2dd6d86e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e908cfa-4961-34c7-8a85-149c2dd6d86e', 7, NULL, 'Zdes'' khorosho', 'Zdes'' khorosho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e908cfa-4961-34c7-8a85-149c2dd6d86e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Na smert'' chizhika', part.name_en = 'Na smert'' chizhika',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b4937541-56b0-416a-9cfd-e53c60868881' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4937541-56b0-416a-9cfd-e53c60868881', 8, NULL, 'Na smert'' chizhika', 'Na smert'' chizhika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4937541-56b0-416a-9cfd-e53c60868881'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Melodiya', part.name_en = 'Melodiya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3893295a-5f92-40ce-bb4e-40cbb80729fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3893295a-5f92-40ce-bb4e-40cbb80729fd', 9, NULL, 'Melodiya', 'Melodiya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3893295a-5f92-40ce-bb4e-40cbb80729fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Pred ikonoy', part.name_en = 'Pred ikonoy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:f9f0252c-0eac-4214-81bd-23d9f4694dd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9f0252c-0eac-4214-81bd-23d9f4694dd5', 10, NULL, 'Pred ikonoy', 'Pred ikonoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9f0252c-0eac-4214-81bd-23d9f4694dd5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Ya ne prorok', part.name_en = 'Ya ne prorok',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6ed7e5e3-7d8d-410d-ac67-b45a10456142' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ed7e5e3-7d8d-410d-ac67-b45a10456142', 11, NULL, 'Ya ne prorok', 'Ya ne prorok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ed7e5e3-7d8d-410d-ac67-b45a10456142'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2508 AND linked.composer_id = 51),
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Kak mne bol''no', part.name_en = 'Kak mne bol''no',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 563 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:1c4dee46-adab-4954-8803-d42f6dc464c0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2508 AND linked.composer_id = 51), 'musicbrainz:1c4dee46-adab-4954-8803-d42f6dc464c0', 12, NULL, 'Kak mne bol''no', 'Kak mne bol''no', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 563 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c4dee46-adab-4954-8803-d42f6dc464c0'
);

UPDATE pieces piece
SET piece.title = '12개의 로망스 Op. 21 중 "Kak mne bol''no"', piece.title_en = '12 Romances, Op. 21: Kak mne bol''no', piece.editor_locked = 1
WHERE piece.id = 2508 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 22 쇼팽 주제에 의한 변주곡

UPDATE pieces piece
SET piece.title = '쇼팽 주제에 의한 변주곡', piece.title_en = 'Variations on a Theme of Chopin, Op. 22',
    piece.type = 'album', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 552 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 552 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '주제. Largo', part.name_en = 'Theme: Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d9bd19b2-f4f6-4081-a3bb-e76febb17d6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9bd19b2-f4f6-4081-a3bb-e76febb17d6f', 1, NULL, '주제. Largo', 'Theme: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9bd19b2-f4f6-4081-a3bb-e76febb17d6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '변주 I. Moderato', part.name_en = 'Variation I: Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8fce2e4a-4b48-4238-aeae-e0fae2047049' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fce2e4a-4b48-4238-aeae-e0fae2047049', 2, NULL, '변주 I. Moderato', 'Variation I: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fce2e4a-4b48-4238-aeae-e0fae2047049'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '변주 II. Allegro', part.name_en = 'Variation II: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e6c8d9e1-3634-49ae-bcd5-69b836baee26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6c8d9e1-3634-49ae-bcd5-69b836baee26', 3, NULL, '변주 II. Allegro', 'Variation II: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6c8d9e1-3634-49ae-bcd5-69b836baee26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '변주 III', part.name_en = 'Variation III',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:bd3926b9-9af2-4d6d-aaaf-7333ad0f6aba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd3926b9-9af2-4d6d-aaaf-7333ad0f6aba', 4, NULL, '변주 III', 'Variation III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd3926b9-9af2-4d6d-aaaf-7333ad0f6aba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '변주 IV', part.name_en = 'Variation IV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:baf2cb6e-4b87-4aef-9a52-beaa583dff4c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baf2cb6e-4b87-4aef-9a52-beaa583dff4c', 5, NULL, '변주 IV', 'Variation IV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baf2cb6e-4b87-4aef-9a52-beaa583dff4c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '변주 V. Meno mosso', part.name_en = 'Variation V: Meno mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:9a0c8c29-10b1-4d66-aa55-e7dd2817e2dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a0c8c29-10b1-4d66-aa55-e7dd2817e2dc', 6, NULL, '변주 V. Meno mosso', 'Variation V: Meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a0c8c29-10b1-4d66-aa55-e7dd2817e2dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '변주 VI. Meno mosso', part.name_en = 'Variation VI: Meno mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:07a7fc11-237c-4e5e-9645-ae665a6ad396' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07a7fc11-237c-4e5e-9645-ae665a6ad396', 7, NULL, '변주 VI. Meno mosso', 'Variation VI: Meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07a7fc11-237c-4e5e-9645-ae665a6ad396'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '변주 VII. Allegro', part.name_en = 'Variation VII: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:dd3adf11-8bb8-41c8-a6f9-1b88bef2651a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd3adf11-8bb8-41c8-a6f9-1b88bef2651a', 8, NULL, '변주 VII. Allegro', 'Variation VII: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd3adf11-8bb8-41c8-a6f9-1b88bef2651a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '변주 VIII', part.name_en = 'Variation VIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:4e7907f7-121b-49e1-a361-d807db802122' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7907f7-121b-49e1-a361-d807db802122', 9, NULL, '변주 VIII', 'Variation VIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7907f7-121b-49e1-a361-d807db802122'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '변주 IX', part.name_en = 'Variation IX',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ba8a4f02-fc6d-47d0-b791-1cb47f2a5acb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba8a4f02-fc6d-47d0-b791-1cb47f2a5acb', 10, NULL, '변주 IX', 'Variation IX', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba8a4f02-fc6d-47d0-b791-1cb47f2a5acb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '변주 X. Più vivo', part.name_en = 'Variation X: Più vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ebad8f54-9a9b-4f0a-9644-f7894adb87ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebad8f54-9a9b-4f0a-9644-f7894adb87ea', 11, NULL, '변주 X. Più vivo', 'Variation X: Più vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebad8f54-9a9b-4f0a-9644-f7894adb87ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '변주 XI. Lento', part.name_en = 'Variation XI: Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:04d5a8c0-9330-41c2-95c2-b4342fbcc9d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04d5a8c0-9330-41c2-95c2-b4342fbcc9d1', 12, NULL, '변주 XI. Lento', 'Variation XI: Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04d5a8c0-9330-41c2-95c2-b4342fbcc9d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '변주 XII. Moderato', part.name_en = 'Variation XII: Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:32ad7a17-c9a6-4cfd-9b16-bf6789e042bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32ad7a17-c9a6-4cfd-9b16-bf6789e042bc', 13, NULL, '변주 XII. Moderato', 'Variation XII: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ad7a17-c9a6-4cfd-9b16-bf6789e042bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '변주 XIII. Largo', part.name_en = 'Variation XIII: Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b8fe80b8-6d04-4e9b-a6da-1b5f101bbaa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8fe80b8-6d04-4e9b-a6da-1b5f101bbaa6', 14, NULL, '변주 XIII. Largo', 'Variation XIII: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8fe80b8-6d04-4e9b-a6da-1b5f101bbaa6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '변주 XIV. Moderato', part.name_en = 'Variation XIV: Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:bc558c26-f8a7-4100-be65-78e40249520c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc558c26-f8a7-4100-be65-78e40249520c', 15, NULL, '변주 XIV. Moderato', 'Variation XIV: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc558c26-f8a7-4100-be65-78e40249520c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '변주 XV. Allegro scherzando', part.name_en = 'Variation XV: Allegro scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:27f93cdd-5767-4e46-b3b2-033ceaf52a51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27f93cdd-5767-4e46-b3b2-033ceaf52a51', 16, NULL, '변주 XV. Allegro scherzando', 'Variation XV: Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27f93cdd-5767-4e46-b3b2-033ceaf52a51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '변주 XVI. Lento', part.name_en = 'Variation XVI: Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:304722d4-9cd8-4b4d-aa09-08d86adaaeb5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:304722d4-9cd8-4b4d-aa09-08d86adaaeb5', 17, NULL, '변주 XVI. Lento', 'Variation XVI: Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304722d4-9cd8-4b4d-aa09-08d86adaaeb5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '변주 XVII. Grave', part.name_en = 'Variation XVII: Grave',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:fe64bf97-b513-40ea-acad-849f0cde49a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe64bf97-b513-40ea-acad-849f0cde49a0', 18, NULL, '변주 XVII. Grave', 'Variation XVII: Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe64bf97-b513-40ea-acad-849f0cde49a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = '변주 XVIII. Più mosso', part.name_en = 'Variation XVIII: Più mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:aa009516-0347-4e84-907d-d3cc31b6b1a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa009516-0347-4e84-907d-d3cc31b6b1a6', 19, NULL, '변주 XVIII. Più mosso', 'Variation XVIII: Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa009516-0347-4e84-907d-d3cc31b6b1a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '변주 XIX. Allegro vivace', part.name_en = 'Variation XIX: Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:79fe5ea0-54e7-4523-94f8-c79ec4882a02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79fe5ea0-54e7-4523-94f8-c79ec4882a02', 20, NULL, '변주 XIX. Allegro vivace', 'Variation XIX: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79fe5ea0-54e7-4523-94f8-c79ec4882a02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = '변주 XX. Presto', part.name_en = 'Variation XX: Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b6db469f-d6cb-4164-905f-2845dbb83d94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6db469f-d6cb-4164-905f-2845dbb83d94', 21, NULL, '변주 XX. Presto', 'Variation XX: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6db469f-d6cb-4164-905f-2845dbb83d94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = '변주 XXI. Andante — Più vivo', part.name_en = 'Variation XXI: Andante — Più vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b47d1cd9-8073-4c0e-92e9-2723c0c3cfb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b47d1cd9-8073-4c0e-92e9-2723c0c3cfb6', 22, NULL, '변주 XXI. Andante — Più vivo', 'Variation XXI: Andante — Più vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b47d1cd9-8073-4c0e-92e9-2723c0c3cfb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = '변주 XXII. Maestoso', part.name_en = 'Variation XXII: Maestoso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 552 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e8df4c82-32ad-4753-961c-16607e1c838c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8df4c82-32ad-4753-961c-16607e1c838c', 23, NULL, '변주 XXII. Maestoso', 'Variation XXII: Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 552 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8df4c82-32ad-4753-961c-16607e1c838c'
);


-- Op. 23 전주곡 Op. 23

UPDATE pieces piece
SET piece.title = '전주곡 Op. 23', piece.title_en = '10 Preludes, Op. 23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '23',
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 701 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 701 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'F#단조', part.name_en = 'No. 1 in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:63ec2ef8-5c31-3d97-8fc2-2692500e19d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63ec2ef8-5c31-3d97-8fc2-2692500e19d7', 1, NULL, 'F#단조', 'No. 1 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63ec2ef8-5c31-3d97-8fc2-2692500e19d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'B♭장조', part.name_en = 'No. 2 in B♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d6e35e13-0b02-328b-9eda-3ed4428a6df3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6e35e13-0b02-328b-9eda-3ed4428a6df3', 2, NULL, 'B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e35e13-0b02-328b-9eda-3ed4428a6df3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 3 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:83060f3d-63fb-3b0e-b1d7-ddb91089f35d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83060f3d-63fb-3b0e-b1d7-ddb91089f35d', 3, NULL, 'D단조', 'No. 3 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83060f3d-63fb-3b0e-b1d7-ddb91089f35d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = 'No. 4 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5db89d7b-d1d1-3a25-ad6c-2c01551e8519' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5db89d7b-d1d1-3a25-ad6c-2c01551e8519', 4, NULL, 'D장조', 'No. 4 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5db89d7b-d1d1-3a25-ad6c-2c01551e8519'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 455 AND linked.composer_id = 51),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = 'No. 5 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:aecd9670-5296-3ac9-9eef-a808bb8d29a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 455 AND linked.composer_id = 51), 'musicbrainz:aecd9670-5296-3ac9-9eef-a808bb8d29a3', 5, NULL, 'G단조', 'No. 5 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aecd9670-5296-3ac9-9eef-a808bb8d29a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = 'No. 6 in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d0b0e8e6-6d2f-3e67-83f4-1a283af88d78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0b0e8e6-6d2f-3e67-83f4-1a283af88d78', 6, NULL, 'E♭장조', 'No. 6 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0b0e8e6-6d2f-3e67-83f4-1a283af88d78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 7 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ded94a27-cb28-328f-8f86-8d872f868b12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ded94a27-cb28-328f-8f86-8d872f868b12', 7, NULL, 'C단조', 'No. 7 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ded94a27-cb28-328f-8f86-8d872f868b12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A♭장조', part.name_en = 'No. 8 in A♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8b3b9147-de55-3e5d-b082-0c7ad3c3b7cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b3b9147-de55-3e5d-b082-0c7ad3c3b7cf', 8, NULL, 'A♭장조', 'No. 8 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b3b9147-de55-3e5d-b082-0c7ad3c3b7cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'E♭단조', part.name_en = 'No. 9 in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:1496b5ab-fc6f-3a6f-b0b5-8b5b022e03b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1496b5ab-fc6f-3a6f-b0b5-8b5b022e03b5', 9, NULL, 'E♭단조', 'No. 9 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1496b5ab-fc6f-3a6f-b0b5-8b5b022e03b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'G♭장조', part.name_en = 'No. 10 in G♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 701 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e6351aa9-21ea-36c9-9ce0-c7a612618da4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6351aa9-21ea-36c9-9ce0-c7a612618da4', 10, NULL, 'G♭장조', 'No. 10 in G♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 701 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6351aa9-21ea-36c9-9ce0-c7a612618da4'
);


-- Op. 24 오페라 <인색한 기사>

UPDATE pieces piece
SET piece.title = '오페라 <인색한 기사>', piece.title_en = 'The Miserly Knight, Op. 24',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 569 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 569 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- Op. 25 오페라 <프란체스카 다 리미니>

UPDATE pieces piece
SET piece.title = '오페라 <프란체스카 다 리미니>', piece.title_en = 'Francesca da Rimini, Op. 25',
    piece.type = 'song', piece.opus_number = 'Op. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2017 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 2017 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- Op. 26 15개의 로망스 Op. 26

UPDATE pieces piece
SET piece.title = '15개의 로망스 Op. 26', piece.title_en = '15 Romances, Op. 26',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '26',
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 3005 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 3005 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Yest'' mnogo zvukov', part.name_en = 'Yest'' mnogo zvukov',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:f119fcf9-aa67-4535-a8cf-987ff61b4cb8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f119fcf9-aa67-4535-a8cf-987ff61b4cb8', 1, NULL, 'Yest'' mnogo zvukov', 'Yest'' mnogo zvukov', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f119fcf9-aa67-4535-a8cf-987ff61b4cb8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vsyo otnyal u menya', part.name_en = 'Vsyo otnyal u menya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:99393d76-3e96-4da1-8f56-9d026d0a2111' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99393d76-3e96-4da1-8f56-9d026d0a2111', 2, NULL, 'Vsyo otnyal u menya', 'Vsyo otnyal u menya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99393d76-3e96-4da1-8f56-9d026d0a2111'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'My otdokhnyom', part.name_en = 'My otdokhnyom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:4a75ef35-69e3-404c-a85c-534b59c8d3fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a75ef35-69e3-404c-a85c-534b59c8d3fb', 3, NULL, 'My otdokhnyom', 'My otdokhnyom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a75ef35-69e3-404c-a85c-534b59c8d3fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dva proshchaniya', part.name_en = 'Dva proshchaniya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:f7159db0-b06b-49d5-b618-8374b4f249a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7159db0-b06b-49d5-b618-8374b4f249a3', 4, NULL, 'Dva proshchaniya', 'Dva proshchaniya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7159db0-b06b-49d5-b618-8374b4f249a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pokinem, milaya', part.name_en = 'Pokinem, milaya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b4a3b6b2-b018-4176-96bb-81460af3899a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4a3b6b2-b018-4176-96bb-81460af3899a', 5, NULL, 'Pokinem, milaya', 'Pokinem, milaya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4a3b6b2-b018-4176-96bb-81460af3899a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Khristos voskres', part.name_en = 'Khristos voskres',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c550fcf9-5efa-423b-bb57-388014ee30e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c550fcf9-5efa-423b-bb57-388014ee30e5', 6, NULL, 'Khristos voskres', 'Khristos voskres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c550fcf9-5efa-423b-bb57-388014ee30e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'K detyam', part.name_en = 'K detyam',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d9453190-b7ff-44b7-bba3-a2eec4d82808' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9453190-b7ff-44b7-bba3-a2eec4d82808', 7, NULL, 'K detyam', 'K detyam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9453190-b7ff-44b7-bba3-a2eec4d82808'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Poshchady ya molyu!', part.name_en = 'Poshchady ya molyu!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:97d1c893-95ff-4a20-b0b1-1043894818cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97d1c893-95ff-4a20-b0b1-1043894818cc', 8, NULL, 'Poshchady ya molyu!', 'Poshchady ya molyu!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97d1c893-95ff-4a20-b0b1-1043894818cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2761 AND linked.composer_id = 51),
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ya opyat'' odinok', part.name_en = 'Ya opyat'' odinok',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:1403e314-ee7f-491f-a220-468346176af5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2761 AND linked.composer_id = 51), 'musicbrainz:1403e314-ee7f-491f-a220-468346176af5', 9, NULL, 'Ya opyat'' odinok', 'Ya opyat'' odinok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1403e314-ee7f-491f-a220-468346176af5'
);

UPDATE pieces piece
SET piece.title = '15개의 로망스 Op. 26 중 "Ya opyat'' odinok"', piece.title_en = '15 Romances, Op. 26: Ya opyat'' odinok', piece.editor_locked = 1
WHERE piece.id = 2761 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'U moyego okna', part.name_en = 'U moyego okna',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:1281bdfc-6818-406f-94f3-a0624020496c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1281bdfc-6818-406f-94f3-a0624020496c', 10, NULL, 'U moyego okna', 'U moyego okna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1281bdfc-6818-406f-94f3-a0624020496c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Fontan', part.name_en = 'Fontan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:58862e11-fc07-4dac-9878-bcf66d5d1b13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58862e11-fc07-4dac-9878-bcf66d5d1b13', 11, NULL, 'Fontan', 'Fontan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58862e11-fc07-4dac-9878-bcf66d5d1b13'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Noch'' pechal''na', part.name_en = 'Noch'' pechal''na',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3a62d885-1457-41bb-ac4c-d38868576077' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a62d885-1457-41bb-ac4c-d38868576077', 12, NULL, 'Noch'' pechal''na', 'Noch'' pechal''na', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a62d885-1457-41bb-ac4c-d38868576077'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Vchera my vstretilis''', part.name_en = 'Vchera my vstretilis''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:774d3447-7510-4ab9-9628-144c8fc2343b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:774d3447-7510-4ab9-9628-144c8fc2343b', 13, NULL, 'Vchera my vstretilis''', 'Vchera my vstretilis''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:774d3447-7510-4ab9-9628-144c8fc2343b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Kol''tso', part.name_en = 'Kol''tso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:fa6f2ae9-c963-4c3c-8d58-8b65a15c4ace' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa6f2ae9-c963-4c3c-8d58-8b65a15c4ace', 14, NULL, 'Kol''tso', 'Kol''tso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa6f2ae9-c963-4c3c-8d58-8b65a15c4ace'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2834 AND linked.composer_id = 51),
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Prokhodit vsyo', part.name_en = 'Prokhodit vsyo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 3005 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:cfe5ae43-b2eb-423d-8c9b-70655744fa8f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2834 AND linked.composer_id = 51), 'musicbrainz:cfe5ae43-b2eb-423d-8c9b-70655744fa8f', 15, NULL, 'Prokhodit vsyo', 'Prokhodit vsyo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 3005 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfe5ae43-b2eb-423d-8c9b-70655744fa8f'
);

UPDATE pieces piece
SET piece.title = '15개의 로망스 Op. 26 중 "Prokhodit vsyo"', piece.title_en = '15 Romances, Op. 26: Prokhodit vsyo', piece.editor_locked = 1
WHERE piece.id = 2834 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 27 교향곡 2번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 E단조', 'Symphony No. 2 in E minor, Op. 27', 'album', 'Op. 27', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4279c16c-4c19-32cf-894e-20660ee66e99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4279c16c-4c19-32cf-894e-20660ee66e99'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향곡 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4279c16c-4c19-32cf-894e-20660ee66e99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1905bef1-965f-3ea1-aaf2-0131b4eca3af', 1, 'I', 'Largo — Allegro moderato', 'I. Largo — Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향곡 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1905bef1-965f-3ea1-aaf2-0131b4eca3af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddaf99e8-fb78-35dc-b6ec-c1e277e67114', 2, 'II', 'Allegro molto', 'II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향곡 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddaf99e8-fb78-35dc-b6ec-c1e277e67114'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d7c7cd2-da79-37f4-98b8-ccfb1a4ac6c4', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향곡 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d7c7cd2-da79-37f4-98b8-ccfb1a4ac6c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44bb85c5-fd9c-3194-8370-9e5d6c76e6d2', 4, 'IV', 'Allegro vivace', 'IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향곡 2번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44bb85c5-fd9c-3194-8370-9e5d6c76e6d2'
);


-- Op. 28 피아노 소나타 1번 D단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 1번 D단조', piece.title_en = 'Piano Sonata No. 1 in D minor, Op. 28',
    piece.type = 'album', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1603 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 1603 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1603 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:0f105d49-d7a6-4d05-a071-a8f7458faa96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f105d49-d7a6-4d05-a071-a8f7458faa96', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1603 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f105d49-d7a6-4d05-a071-a8f7458faa96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1603 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:db4d7ed8-4c74-4acc-83c7-24731d9fd71a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db4d7ed8-4c74-4acc-83c7-24731d9fd71a', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1603 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db4d7ed8-4c74-4acc-83c7-24731d9fd71a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto', part.name_en = 'III. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1603 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:09ae50d8-021a-4f67-8849-c77355b63adc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09ae50d8-021a-4f67-8849-c77355b63adc', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1603 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09ae50d8-021a-4f67-8849-c77355b63adc'
);


-- Op. 29 교향시 <죽음의 섬>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <죽음의 섬>', 'Isle of the Dead, Op. 29', 'song', 'Op. 29', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <죽음의 섬>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab65bc19-0079-31a9-9521-5f6ea4c1c637'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab65bc19-0079-31a9-9521-5f6ea4c1c637'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향시 <죽음의 섬>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab65bc19-0079-31a9-9521-5f6ea4c1c637'
);


-- Op. 30 피아노 협주곡 3번 D단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non tanto', part.name_en = 'I. Allegro ma non tanto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 226 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e55e8d47-c07a-31f5-90e4-404b8e975255' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e55e8d47-c07a-31f5-90e4-404b8e975255', 1, 'I', 'Allegro ma non tanto', 'I. Allegro ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 226 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e55e8d47-c07a-31f5-90e4-404b8e975255'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '간주곡. Adagio', part.name_en = 'II. Intermezzo: Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 226 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3daf2401-b558-3212-b70e-cb738749e02d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3daf2401-b558-3212-b70e-cb738749e02d', 2, 'II', '간주곡. Adagio', 'II. Intermezzo: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 226 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3daf2401-b558-3212-b70e-cb738749e02d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레. Alla breve', part.name_en = 'III. Finale: Alla breve',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 226 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6910fb86-7ccd-3152-8edf-42c762f29dd1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6910fb86-7ccd-3152-8edf-42c762f29dd1', 3, 'III', '피날레. Alla breve', 'III. Finale: Alla breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 226 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6910fb86-7ccd-3152-8edf-42c762f29dd1'
);


-- Op. 31 성 요한 크리소스톰의 전례

UPDATE pieces piece
SET piece.title = '성 요한 크리소스톰의 전례', piece.title_en = 'Liturgy of St John Chrysostom, Op. 31',
    piece.type = 'album', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2977 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 2977 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Velikaya yekteniya', part.name_en = 'I. The Great Litany',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:a3bb4f22-84d3-4fcb-8ead-437d36621e51' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3bb4f22-84d3-4fcb-8ead-437d36621e51', 1, 'I', 'Velikaya yekteniya', 'I. The Great Litany', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3bb4f22-84d3-4fcb-8ead-437d36621e51'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Blagoslovi, dushe moya, Gospoda', part.name_en = 'II. The First Antiphon: Bless the Lord, O My Soul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:58068341-f9c7-3c45-899c-209f1ce784b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58068341-f9c7-3c45-899c-209f1ce784b7', 2, 'II', 'Blagoslovi, dushe moya, Gospoda', 'II. The First Antiphon: Bless the Lord, O My Soul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58068341-f9c7-3c45-899c-209f1ce784b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Slava Ottsu i Synu. Yedinorodnyy Syne', part.name_en = 'III. The Second Antiphon: Glory Be to the Father — Only-Begotten Son',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c62d5b31-e9fc-34c2-9751-4e59cd792155' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c62d5b31-e9fc-34c2-9751-4e59cd792155', 3, 'III', 'Slava Ottsu i Synu. Yedinorodnyy Syne', 'III. The Second Antiphon: Glory Be to the Father — Only-Begotten Son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c62d5b31-e9fc-34c2-9751-4e59cd792155'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vo Tsarstvii Tvoyem', part.name_en = 'IV. The Third Antiphon: In Your Kingdom',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:dca85950-8e06-3cc2-a5b9-8e71968996f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dca85950-8e06-3cc2-a5b9-8e71968996f1', 4, 'IV', 'Vo Tsarstvii Tvoyem', 'IV. The Third Antiphon: In Your Kingdom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dca85950-8e06-3cc2-a5b9-8e71968996f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Priidite, poklonimsya', part.name_en = 'V. The Little Entrance: Come, Let Us Worship',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:f09542c4-6f89-356e-8d91-eb9c0956bb17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f09542c4-6f89-356e-8d91-eb9c0956bb17', 5, 'V', 'Priidite, poklonimsya', 'V. The Little Entrance: Come, Let Us Worship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f09542c4-6f89-356e-8d91-eb9c0956bb17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Gospodi, spasi blagochestivyya. Svyatyy Bozhe', part.name_en = 'VI. Trisagion: Lord, We Pray That You May Be Merciful',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6cf5b253-a1db-3400-9f7b-2758e4133f5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cf5b253-a1db-3400-9f7b-2758e4133f5f', 6, 'VI', 'Gospodi, spasi blagochestivyya. Svyatyy Bozhe', 'VI. Trisagion: Lord, We Pray That You May Be Merciful', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cf5b253-a1db-3400-9f7b-2758e4133f5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Sugubaya yekteniya', part.name_en = 'VII. The Augmented Litany',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c63c649e-307a-3593-ade8-ed321b300edd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c63c649e-307a-3593-ade8-ed321b300edd', 7, 'VII', 'Sugubaya yekteniya', 'VII. The Augmented Litany', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c63c649e-307a-3593-ade8-ed321b300edd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Kheruvimskaya pesn''', part.name_en = 'VIII. Cherubic Hymn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:58345be1-a283-3cd3-8c1a-c087f682d596' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58345be1-a283-3cd3-8c1a-c087f682d596', 8, 'VIII', 'Kheruvimskaya pesn''', 'VIII. Cherubic Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58345be1-a283-3cd3-8c1a-c087f682d596'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Prositel''naya yekteniya', part.name_en = 'IX. The Litany of Supplication',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:fcf7ee3c-20f1-4ecd-8de0-24bc4d3fa5d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcf7ee3c-20f1-4ecd-8de0-24bc4d3fa5d1', 9, 'IX', 'Prositel''naya yekteniya', 'IX. The Litany of Supplication', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcf7ee3c-20f1-4ecd-8de0-24bc4d3fa5d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Veruyu', part.name_en = 'X. Credo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:30b98879-67b7-308b-b840-db2fcb49cbe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30b98879-67b7-308b-b840-db2fcb49cbe4', 10, 'X', 'Veruyu', 'X. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b98879-67b7-308b-b840-db2fcb49cbe4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Milost'' mira', part.name_en = 'XI. The Eucharistic Prayer: A Mercy Of Peace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e50e1bf5-82f0-3121-987d-692bfc1135e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e50e1bf5-82f0-3121-987d-692bfc1135e2', 11, 'XI', 'Milost'' mira', 'XI. The Eucharistic Prayer: A Mercy Of Peace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e50e1bf5-82f0-3121-987d-692bfc1135e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Tebe poyem', part.name_en = 'XII. We Praise Thee',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8a489571-25b3-3e14-bd53-575def620a8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a489571-25b3-3e14-bd53-575def620a8a', 12, 'XII', 'Tebe poyem', 'XII. We Praise Thee', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a489571-25b3-3e14-bd53-575def620a8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Dostoyno yest''', part.name_en = 'XIII. Hymn to the Mother of God: It Is Truly Meet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5d53f1ef-6202-3682-b63b-668a87494b41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d53f1ef-6202-3682-b63b-668a87494b41', 13, 'XIII', 'Dostoyno yest''', 'XIII. Hymn to the Mother of God: It Is Truly Meet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d53f1ef-6202-3682-b63b-668a87494b41'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Otche nash', part.name_en = 'XIV. The Lord''s Prayer: Our Father',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6b45ca10-4b27-3918-a21f-8edcab294e42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b45ca10-4b27-3918-a21f-8edcab294e42', 14, 'XIV', 'Otche nash', 'XIV. The Lord''s Prayer: Our Father', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b45ca10-4b27-3918-a21f-8edcab294e42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Yedin svyat', part.name_en = 'XV. One Is Holy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:610465d6-a868-4b30-af83-c2d91af1fd85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:610465d6-a868-4b30-af83-c2d91af1fd85', 15, 'XV', 'Yedin svyat', 'XV. One Is Holy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:610465d6-a868-4b30-af83-c2d91af1fd85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Khvalite Gospoda s nebes', part.name_en = 'XVI. Communion Hymn: Praise the Lord From The Heavens',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2359b88f-2c0a-3be9-868b-b2324ecf5b9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2359b88f-2c0a-3be9-868b-b2324ecf5b9a', 16, 'XVI', 'Khvalite Gospoda s nebes', 'XVI. Communion Hymn: Praise the Lord From The Heavens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2359b88f-2c0a-3be9-868b-b2324ecf5b9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XVII',
    part.name_ko = 'Blagosloven gryadyy. Videkhom svet istinnyy', part.name_en = 'XVII. Blessed Is He — We Have Seen the Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8e80d144-57eb-3a3b-8154-7190151f7b42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e80d144-57eb-3a3b-8154-7190151f7b42', 17, 'XVII', 'Blagosloven gryadyy. Videkhom svet istinnyy', 'XVII. Blessed Is He — We Have Seen the Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e80d144-57eb-3a3b-8154-7190151f7b42'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'XVIII',
    part.name_ko = 'Da ispolnyatsya usta nasha', part.name_en = 'XVIII. Hymn Of Praise: Let Our Mouths Be Filled',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:99943fbe-dddc-3f9a-aaf1-c0304477f812' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99943fbe-dddc-3f9a-aaf1-c0304477f812', 18, 'XVIII', 'Da ispolnyatsya usta nasha', 'XVIII. Hymn Of Praise: Let Our Mouths Be Filled', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99943fbe-dddc-3f9a-aaf1-c0304477f812'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = 'XIX',
    part.name_ko = 'Budi imya Gospodne', part.name_en = 'XIX. Blessed Be the Name of the Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:64e714d7-74c0-374c-b6aa-0f7cd170fb62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64e714d7-74c0-374c-b6aa-0f7cd170fb62', 19, 'XIX', 'Budi imya Gospodne', 'XIX. Blessed Be the Name of the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64e714d7-74c0-374c-b6aa-0f7cd170fb62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = 'XX',
    part.name_ko = 'Otpust', part.name_en = 'XX. Dismissal',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2977 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ca3b4787-07d7-3f38-87cf-dd6a5350cf0a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca3b4787-07d7-3f38-87cf-dd6a5350cf0a', 20, 'XX', 'Otpust', 'XX. Dismissal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2977 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca3b4787-07d7-3f38-87cf-dd6a5350cf0a'
);


-- Op. 32 전주곡 Op. 32

UPDATE pieces piece
SET piece.title = '전주곡 Op. 32', piece.title_en = '13 Preludes, Op. 32',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '32',
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2318 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 2318 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = 'No. 1 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6b87a2e8-c58a-3328-bb19-f39eaecd4604' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b87a2e8-c58a-3328-bb19-f39eaecd4604', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b87a2e8-c58a-3328-bb19-f39eaecd4604'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'B♭단조', part.name_en = 'No. 2 in B♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:faaac863-7896-3b7b-90bd-8d912c9c85c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faaac863-7896-3b7b-90bd-8d912c9c85c2', 2, NULL, 'B♭단조', 'No. 2 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faaac863-7896-3b7b-90bd-8d912c9c85c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = 'No. 3 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:18af6383-802c-3721-92b9-29b4ee11a771' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18af6383-802c-3721-92b9-29b4ee11a771', 3, NULL, 'E장조', 'No. 3 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18af6383-802c-3721-92b9-29b4ee11a771'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'No. 4 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8f3f3f9a-a549-3909-8023-979a78c7b228' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f3f3f9a-a549-3909-8023-979a78c7b228', 4, NULL, 'E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f3f3f9a-a549-3909-8023-979a78c7b228'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = 'No. 5 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7efe5b56-6b4b-3afe-a6d1-f34f63fa0091' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7efe5b56-6b4b-3afe-a6d1-f34f63fa0091', 5, NULL, 'G장조', 'No. 5 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7efe5b56-6b4b-3afe-a6d1-f34f63fa0091'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'F단조', part.name_en = 'No. 6 in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:a5ab72d4-7703-3f36-a58d-db44e729e33d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5ab72d4-7703-3f36-a58d-db44e729e33d', 6, NULL, 'F단조', 'No. 6 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5ab72d4-7703-3f36-a58d-db44e729e33d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = 'No. 7 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:f4086a9c-f93f-3dbb-ab4b-f7ba41f559c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4086a9c-f93f-3dbb-ab4b-f7ba41f559c6', 7, NULL, 'F장조', 'No. 7 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4086a9c-f93f-3dbb-ab4b-f7ba41f559c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 8 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:02d89048-6e39-35cd-aba3-0ada82f9996a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02d89048-6e39-35cd-aba3-0ada82f9996a', 8, NULL, 'A단조', 'No. 8 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02d89048-6e39-35cd-aba3-0ada82f9996a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'No. 9 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:edf7c18a-6204-3841-bce5-8be28ba07401' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edf7c18a-6204-3841-bce5-8be28ba07401', 9, NULL, 'A장조', 'No. 9 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf7c18a-6204-3841-bce5-8be28ba07401'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = 'No. 10 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:62985701-14f0-3fde-aa1e-108bcc2b6e20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62985701-14f0-3fde-aa1e-108bcc2b6e20', 10, NULL, 'B단조', 'No. 10 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62985701-14f0-3fde-aa1e-108bcc2b6e20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'B장조', part.name_en = 'No. 11 in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:552832a5-8caa-3418-bec2-595306102572' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:552832a5-8caa-3418-bec2-595306102572', 11, NULL, 'B장조', 'No. 11 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:552832a5-8caa-3418-bec2-595306102572'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'G#단조', part.name_en = 'No. 12 in G# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:42b978ed-d32c-31d4-89ee-6d18b78a81ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b978ed-d32c-31d4-89ee-6d18b78a81ef', 12, NULL, 'G#단조', 'No. 12 in G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b978ed-d32c-31d4-89ee-6d18b78a81ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'D♭장조', part.name_en = 'No. 13 in D♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2318 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:633e9273-3cbe-31cc-b5ce-42492d0614db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:633e9273-3cbe-31cc-b5ce-42492d0614db', 13, NULL, 'D♭장조', 'No. 13 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2318 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:633e9273-3cbe-31cc-b5ce-42492d0614db'
);


-- Op. 33 회화적 연습곡 Op. 33

UPDATE pieces piece
SET piece.title = '회화적 연습곡 Op. 33', piece.title_en = 'Études-tableaux, Op. 33',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '33',
    piece.composition_year = COALESCE(1911, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 708 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1911
WHERE piece.id = 708 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'F단조', part.name_en = 'No. 1 in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 708 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7f84a847-e12b-369b-9595-1e629b04e218' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f84a847-e12b-369b-9595-1e629b04e218', 1, NULL, 'F단조', 'No. 1 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 708 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f84a847-e12b-369b-9595-1e629b04e218'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = 'No. 2 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 708 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:24043f88-b948-4988-aebc-dbae0297624f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24043f88-b948-4988-aebc-dbae0297624f', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 708 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24043f88-b948-4988-aebc-dbae0297624f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 3 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 708 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b0a0210a-fb15-455f-8d63-1b8746990457' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0a0210a-fb15-455f-8d63-1b8746990457', 3, NULL, 'C단조', 'No. 3 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 708 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0a0210a-fb15-455f-8d63-1b8746990457'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 4 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 708 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:97d724e5-812e-3c90-b63b-fe58801acb4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97d724e5-812e-3c90-b63b-fe58801acb4d', 4, NULL, 'D단조', 'No. 4 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 708 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97d724e5-812e-3c90-b63b-fe58801acb4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'E♭단조', part.name_en = 'No. 5 in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 708 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8dc0f9ba-c8de-4c94-8458-efbd0b4d0505' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8dc0f9ba-c8de-4c94-8458-efbd0b4d0505', 5, NULL, 'E♭단조', 'No. 5 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 708 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8dc0f9ba-c8de-4c94-8458-efbd0b4d0505'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = 'No. 6 in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 708 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d933099e-0cb4-45bb-a0fb-7cb4828b8034' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d933099e-0cb4-45bb-a0fb-7cb4828b8034', 6, NULL, 'E♭장조', 'No. 6 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 708 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d933099e-0cb4-45bb-a0fb-7cb4828b8034'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = 'No. 7 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 708 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6ded84c4-b22c-4dfb-acb6-6fe249d4fc93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ded84c4-b22c-4dfb-acb6-6fe249d4fc93', 7, NULL, 'G단조', 'No. 7 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 708 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ded84c4-b22c-4dfb-acb6-6fe249d4fc93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'C#단조', part.name_en = 'No. 8 in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 708 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:00f72c3d-cad4-4d68-a3ca-a89520f6ee03' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00f72c3d-cad4-4d68-a3ca-a89520f6ee03', 8, NULL, 'C#단조', 'No. 8 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 708 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00f72c3d-cad4-4d68-a3ca-a89520f6ee03'
);


-- Op. 34 14개의 로망스 Op. 34

UPDATE pieces piece
SET piece.title = '14개의 로망스 Op. 34', piece.title_en = '14 Romances, Op. 34',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '34',
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2283 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 2283 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Muza', part.name_en = 'Muza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d5c281dd-6aca-4b84-bf01-1d9355994584' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5c281dd-6aca-4b84-bf01-1d9355994584', 1, NULL, 'Muza', 'Muza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5c281dd-6aca-4b84-bf01-1d9355994584'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'V dushe u kazhdogo iz nas', part.name_en = 'V dushe u kazhdogo iz nas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:102d9b67-a587-438f-ab99-f9b2b5409af0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:102d9b67-a587-438f-ab99-f9b2b5409af0', 2, NULL, 'V dushe u kazhdogo iz nas', 'V dushe u kazhdogo iz nas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:102d9b67-a587-438f-ab99-f9b2b5409af0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Burya', part.name_en = 'Burya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:11795165-9995-469d-8e2a-86ea3d3d9899' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11795165-9995-469d-8e2a-86ea3d3d9899', 3, NULL, 'Burya', 'Burya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11795165-9995-469d-8e2a-86ea3d3d9899'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Veter perelyotnyy', part.name_en = 'Veter perelyotnyy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:06b12c18-47d0-44e5-b20e-8202b13ee12b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b12c18-47d0-44e5-b20e-8202b13ee12b', 4, NULL, 'Veter perelyotnyy', 'Veter perelyotnyy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b12c18-47d0-44e5-b20e-8202b13ee12b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Arion', part.name_en = 'Arion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:298e88a3-9b6c-4a11-8cde-a131abcb5053' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:298e88a3-9b6c-4a11-8cde-a131abcb5053', 5, NULL, 'Arion', 'Arion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:298e88a3-9b6c-4a11-8cde-a131abcb5053'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Voskresheniye Lazarya', part.name_en = 'Voskresheniye Lazarya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e9ffb898-ee17-4409-822b-b70d2862da7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9ffb898-ee17-4409-822b-b70d2862da7b', 6, NULL, 'Voskresheniye Lazarya', 'Voskresheniye Lazarya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9ffb898-ee17-4409-822b-b70d2862da7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Ne mozhet byt''!', part.name_en = 'Ne mozhet byt''!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ecb22a31-db7a-4f21-94dc-58740c24c24e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecb22a31-db7a-4f21-94dc-58740c24c24e', 7, NULL, 'Ne mozhet byt''!', 'Ne mozhet byt''!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecb22a31-db7a-4f21-94dc-58740c24c24e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Muzyka', part.name_en = 'Muzyka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:36b4d9fe-b7c9-4ff0-9053-40c4036505cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36b4d9fe-b7c9-4ff0-9053-40c4036505cc', 8, NULL, 'Muzyka', 'Muzyka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36b4d9fe-b7c9-4ff0-9053-40c4036505cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Ty znal yego', part.name_en = 'Ty znal yego',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:62460131-b035-464e-b012-aec0117aa898' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62460131-b035-464e-b012-aec0117aa898', 9, NULL, 'Ty znal yego', 'Ty znal yego', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62460131-b035-464e-b012-aec0117aa898'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Sey den'' ya pomnyu', part.name_en = 'Sey den'' ya pomnyu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:43327c93-3e70-4535-9220-c6f7d8a4e20c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43327c93-3e70-4535-9220-c6f7d8a4e20c', 10, NULL, 'Sey den'' ya pomnyu', 'Sey den'' ya pomnyu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43327c93-3e70-4535-9220-c6f7d8a4e20c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Obrochnik', part.name_en = 'Obrochnik',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5b9f7da1-179e-44da-98ef-0ce324e4103c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b9f7da1-179e-44da-98ef-0ce324e4103c', 11, NULL, 'Obrochnik', 'Obrochnik', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b9f7da1-179e-44da-98ef-0ce324e4103c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Kakoye schast''ye', part.name_en = 'Kakoye schast''ye',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:fcc0ac79-be86-43cc-ba9a-3235909895e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcc0ac79-be86-43cc-ba9a-3235909895e2', 12, NULL, 'Kakoye schast''ye', 'Kakoye schast''ye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcc0ac79-be86-43cc-ba9a-3235909895e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Dissonans', part.name_en = 'Dissonans',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7bc575ba-b832-4acf-9c31-bbc672abaea8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bc575ba-b832-4acf-9c31-bbc672abaea8', 13, NULL, 'Dissonans', 'Dissonans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bc575ba-b832-4acf-9c31-bbc672abaea8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 228 AND linked.composer_id = 51),
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '보칼리제', part.name_en = 'Vocalise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2283 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:24b1c94b-2779-3964-bc2e-3c5d4137f3f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 228 AND linked.composer_id = 51), 'musicbrainz:24b1c94b-2779-3964-bc2e-3c5d4137f3f9', 14, NULL, '보칼리제', 'Vocalise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2283 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24b1c94b-2779-3964-bc2e-3c5d4137f3f9'
);


-- Op. 35 합창 교향곡 <종>

UPDATE pieces piece
SET piece.title = '합창 교향곡 <종>', piece.title_en = 'The Bells, Op. 35',
    piece.type = 'album', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 819 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 819 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ma non tanto', part.name_en = 'I. Allegro ma non tanto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 819 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:85e7eae9-79b6-3586-bd6b-ce4a193e9fda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85e7eae9-79b6-3586-bd6b-ce4a193e9fda', 1, 'I', 'Allegro ma non tanto', 'I. Allegro ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 819 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85e7eae9-79b6-3586-bd6b-ce4a193e9fda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 819 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e6bad294-4b37-3c91-91d2-77cd1687ec7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6bad294-4b37-3c91-91d2-77cd1687ec7b', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 819 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6bad294-4b37-3c91-91d2-77cd1687ec7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 819 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:72a259bb-5698-371d-8974-0a9139037d0b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72a259bb-5698-371d-8974-0a9139037d0b', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 819 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72a259bb-5698-371d-8974-0a9139037d0b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento lugubre', part.name_en = 'IV. Lento lugubre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 819 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:f5b049e0-160a-370e-a0ad-ebeaddaeb79d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5b049e0-160a-370e-a0ad-ebeaddaeb79d', 4, 'IV', 'Lento lugubre', 'IV. Lento lugubre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 819 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5b049e0-160a-370e-a0ad-ebeaddaeb79d'
);


-- Op. 36 피아노 소나타 2번 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 2번 B♭단조', 'Piano Sonata No. 2 in B♭ minor, Op. 36', 'album', 'Op. 36', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 2번 B♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d16c7ff-0db4-4512-8fa2-cb63a5dda29f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d16c7ff-0db4-4512-8fa2-cb63a5dda29f'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 소나타 2번 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d16c7ff-0db4-4512-8fa2-cb63a5dda29f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:584c5f9d-b017-4309-8829-4863aaec89b3', 1, 'I', 'Allegro agitato', 'I. Allegro agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 소나타 2번 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:584c5f9d-b017-4309-8829-4863aaec89b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfdd0250-fe50-4c04-9984-341dbb366785', 2, 'II', 'Non allegro — Lento', 'II. Non allegro — Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 소나타 2번 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfdd0250-fe50-4c04-9984-341dbb366785'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2edb51d4-bc68-45fe-aa56-51519b586be2', 3, 'III', 'L''istesso tempo — Allegro molto', 'III. L''istesso tempo — Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 소나타 2번 B♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2edb51d4-bc68-45fe-aa56-51519b586be2'
);


-- Op. 37 철야 기도

UPDATE pieces piece
SET piece.title = '철야 기도', piece.title_en = 'All-Night Vigil, Op. 37',
    piece.type = 'album', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 618 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 618 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Priidite, poklonimsya', part.name_en = 'I. Come, Let Us Worship',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:aded1efb-2835-4552-92b4-f9d69147ff3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aded1efb-2835-4552-92b4-f9d69147ff3f', 1, 'I', 'Priidite, poklonimsya', 'I. Come, Let Us Worship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aded1efb-2835-4552-92b4-f9d69147ff3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Blagoslovi, dushe moya', part.name_en = 'II. Bless the Lord, O My Soul',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:579669d8-ea67-4580-bf24-3921e8d278b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:579669d8-ea67-4580-bf24-3921e8d278b6', 2, 'II', 'Blagoslovi, dushe moya', 'II. Bless the Lord, O My Soul', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:579669d8-ea67-4580-bf24-3921e8d278b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Blazhen muzh', part.name_en = 'III. Blessed Is the Man',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:56ad9dae-fe75-4fba-bea4-ac10f94a0c33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56ad9dae-fe75-4fba-bea4-ac10f94a0c33', 3, 'III', 'Blazhen muzh', 'III. Blessed Is the Man', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56ad9dae-fe75-4fba-bea4-ac10f94a0c33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Svete tikhiy', part.name_en = 'IV. O Gladsome Light',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:634a694b-2ed2-4c0d-8ee5-93219a3f8102' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:634a694b-2ed2-4c0d-8ee5-93219a3f8102', 4, 'IV', 'Svete tikhiy', 'IV. O Gladsome Light', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:634a694b-2ed2-4c0d-8ee5-93219a3f8102'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Nyne otpushchayeshi', part.name_en = 'V. Lord, Now Lettest Thou',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:33464860-2cb1-38d5-8697-d47c8bfadd9a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33464860-2cb1-38d5-8697-d47c8bfadd9a', 5, 'V', 'Nyne otpushchayeshi', 'V. Lord, Now Lettest Thou', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33464860-2cb1-38d5-8697-d47c8bfadd9a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1195 AND linked.composer_id = 51),
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Bogoroditse Devo, raduysya', part.name_en = 'VI. Rejoice, O Virgin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:115b4536-d3f7-34a1-9686-fa0a426917d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1195 AND linked.composer_id = 51), 'musicbrainz:115b4536-d3f7-34a1-9686-fa0a426917d2', 6, 'VI', 'Bogoroditse Devo, raduysya', 'VI. Rejoice, O Virgin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:115b4536-d3f7-34a1-9686-fa0a426917d2'
);

UPDATE pieces piece
SET piece.title = '철야 기도 중 "Bogoroditse Devo, raduysya"', piece.title_en = 'All-Night Vigil, Op. 37: VI. Rejoice, O Virgin', piece.editor_locked = 1
WHERE piece.id = 1195 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Shestopsalmiye', part.name_en = 'VII. The Six Psalms',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:a8be0992-196e-358f-87b4-c8c867e48c9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8be0992-196e-358f-87b4-c8c867e48c9b', 7, 'VII', 'Shestopsalmiye', 'VII. The Six Psalms', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8be0992-196e-358f-87b4-c8c867e48c9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Khvalite imya Gospodne', part.name_en = 'VIII. Praise the Name of the Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6b16c882-3459-44d9-b6f3-6c0020f74525' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b16c882-3459-44d9-b6f3-6c0020f74525', 8, 'VIII', 'Khvalite imya Gospodne', 'VIII. Praise the Name of the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b16c882-3459-44d9-b6f3-6c0020f74525'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Blagosloven yesi, Gospodi', part.name_en = 'IX. Blessed Art Thou, O Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:775e7fb7-57fa-4c25-96cd-3aad42bab423' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:775e7fb7-57fa-4c25-96cd-3aad42bab423', 9, 'IX', 'Blagosloven yesi, Gospodi', 'IX. Blessed Art Thou, O Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:775e7fb7-57fa-4c25-96cd-3aad42bab423'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Voskreseniye Khristovo videvshe', part.name_en = 'X. Having Beheld the Resurrection',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7c294da9-7ed6-469a-a372-684c95305623' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c294da9-7ed6-469a-a372-684c95305623', 10, 'X', 'Voskreseniye Khristovo videvshe', 'X. Having Beheld the Resurrection', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c294da9-7ed6-469a-a372-684c95305623'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Velichit dusha moya Gospoda', part.name_en = 'XI. My Soul Magnifies the Lord',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:af729e0f-bfce-380e-9c95-8d0d19bd119b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af729e0f-bfce-380e-9c95-8d0d19bd119b', 11, 'XI', 'Velichit dusha moya Gospoda', 'XI. My Soul Magnifies the Lord', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af729e0f-bfce-380e-9c95-8d0d19bd119b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Slavosloviye velikoye', part.name_en = 'XII. The Great Doxology',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3b84168a-4f6b-409e-a8fd-49669af365c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b84168a-4f6b-409e-a8fd-49669af365c3', 12, 'XII', 'Slavosloviye velikoye', 'XII. The Great Doxology', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b84168a-4f6b-409e-a8fd-49669af365c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Tropar'' "Dnes'' spaseniye"', part.name_en = 'XIII. Troparion: Today Salvation Has Come',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3323b34e-5906-4bb7-9442-5988ecf6ec09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3323b34e-5906-4bb7-9442-5988ecf6ec09', 13, 'XIII', 'Tropar'' "Dnes'' spaseniye"', 'XIII. Troparion: Today Salvation Has Come', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3323b34e-5906-4bb7-9442-5988ecf6ec09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Tropar'' "Voskres iz groba"', part.name_en = 'XIV. Troparion: Thou Didst Rise from the Tomb',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:414ea43c-86ca-400f-b963-87772d6468da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:414ea43c-86ca-400f-b963-87772d6468da', 14, 'XIV', 'Tropar'' "Voskres iz groba"', 'XIV. Troparion: Thou Didst Rise from the Tomb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:414ea43c-86ca-400f-b963-87772d6468da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'Vzbrannoy Voyevode', part.name_en = 'XV. To Thee, the Victorious Leader',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:92a1e1c4-df01-4d16-b9c2-eb06c54f8dd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92a1e1c4-df01-4d16-b9c2-eb06c54f8dd4', 15, 'XV', 'Vzbrannoy Voyevode', 'XV. To Thee, the Victorious Leader', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a1e1c4-df01-4d16-b9c2-eb06c54f8dd4'
);


-- Op. 38 6개의 로망스 Op. 38

UPDATE pieces piece
SET piece.title = '6개의 로망스 Op. 38', piece.title_en = '6 Romances, Op. 38',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '38',
    piece.composition_year = COALESCE(1916, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2567 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1916
WHERE piece.id = 2567 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Noch''yu v sadu u menya', part.name_en = 'Noch''yu v sadu u menya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2567 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:181ccbe4-4bfb-47a0-a9fc-1caa03b5771b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:181ccbe4-4bfb-47a0-a9fc-1caa03b5771b', 1, NULL, 'Noch''yu v sadu u menya', 'Noch''yu v sadu u menya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2567 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:181ccbe4-4bfb-47a0-a9fc-1caa03b5771b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'K ney', part.name_en = 'K ney',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2567 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:db7ddcb1-4388-4db0-b3f6-8cd4d7ff92ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db7ddcb1-4388-4db0-b3f6-8cd4d7ff92ec', 2, NULL, 'K ney', 'K ney', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2567 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db7ddcb1-4388-4db0-b3f6-8cd4d7ff92ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Margaritki', part.name_en = 'Margaritki',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2567 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2120391f-60cc-466e-9491-d7a98a10bd3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2120391f-60cc-466e-9491-d7a98a10bd3b', 3, NULL, 'Margaritki', 'Margaritki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2567 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2120391f-60cc-466e-9491-d7a98a10bd3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Krysolov', part.name_en = 'Krysolov',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2567 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:87a1a915-a057-4c65-9f85-67083c249d10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87a1a915-a057-4c65-9f85-67083c249d10', 4, NULL, 'Krysolov', 'Krysolov', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2567 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87a1a915-a057-4c65-9f85-67083c249d10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Son', part.name_en = 'Son',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2567 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e5389ef8-6437-4f08-8264-d9471cf89e71' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5389ef8-6437-4f08-8264-d9471cf89e71', 5, NULL, 'Son', 'Son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2567 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5389ef8-6437-4f08-8264-d9471cf89e71'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Au!', part.name_en = 'Au!',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2567 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:563ef776-31f8-401e-b695-dd8b09441998' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:563ef776-31f8-401e-b695-dd8b09441998', 6, NULL, 'Au!', 'Au!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2567 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:563ef776-31f8-401e-b695-dd8b09441998'
);


-- Op. 39 회화적 연습곡 Op. 39

UPDATE pieces piece
SET piece.title = '회화적 연습곡 Op. 39', piece.title_en = 'Études-tableaux, Op. 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 689 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 689 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 1 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:24693797-d043-357a-9949-d9693ae3dfeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24693797-d043-357a-9949-d9693ae3dfeb', 1, NULL, 'C단조', 'No. 1 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24693797-d043-357a-9949-d9693ae3dfeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 2 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:66f59083-0d1e-48fd-99d8-dfa226cbd616' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66f59083-0d1e-48fd-99d8-dfa226cbd616', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66f59083-0d1e-48fd-99d8-dfa226cbd616'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'F#단조', part.name_en = 'No. 3 in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:75aa347a-34bb-3b3f-8cc8-40f80fdc5789' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75aa347a-34bb-3b3f-8cc8-40f80fdc5789', 3, NULL, 'F#단조', 'No. 3 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75aa347a-34bb-3b3f-8cc8-40f80fdc5789'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = 'No. 4 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7c600898-941d-35a8-82a1-29cc57ec5506' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c600898-941d-35a8-82a1-29cc57ec5506', 4, NULL, 'B단조', 'No. 4 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c600898-941d-35a8-82a1-29cc57ec5506'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'E♭단조', part.name_en = 'No. 5 in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:432ea29b-0971-3ad5-b4d0-b5d228c295de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:432ea29b-0971-3ad5-b4d0-b5d228c295de', 5, NULL, 'E♭단조', 'No. 5 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:432ea29b-0971-3ad5-b4d0-b5d228c295de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 6 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c7b168ab-0c17-42dc-ba66-3a564c560e6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7b168ab-0c17-42dc-ba66-3a564c560e6e', 6, NULL, 'A단조', 'No. 6 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7b168ab-0c17-42dc-ba66-3a564c560e6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 7 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:dc81fce1-2f20-432a-bfd9-9b0320037bcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc81fce1-2f20-432a-bfd9-9b0320037bcb', 7, NULL, 'C단조', 'No. 7 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc81fce1-2f20-432a-bfd9-9b0320037bcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 8 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:cf121643-da83-32b3-8e59-fe1ecb919acf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf121643-da83-32b3-8e59-fe1ecb919acf', 8, NULL, 'D단조', 'No. 8 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf121643-da83-32b3-8e59-fe1ecb919acf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = 'No. 9 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d9b8759e-cb5c-3b55-836d-a4c49c54ba6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9b8759e-cb5c-3b55-836d-a4c49c54ba6a', 9, NULL, 'D장조', 'No. 9 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9b8759e-cb5c-3b55-836d-a4c49c54ba6a'
);


-- Op. 40 피아노 협주곡 4번 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 4번 G단조', 'Piano Concerto No. 4 in G minor, Op. 40', 'album', 'Op. 40', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 4번 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42f2a0b3-16cf-4045-a8f5-843d1ba8f635'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '42f2a0b3-16cf-4045-a8f5-843d1ba8f635'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 협주곡 4번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42f2a0b3-16cf-4045-a8f5-843d1ba8f635'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2488 AND linked.composer_id = 51), 'musicbrainz:5888724e-8731-3618-bc05-81dc8bb77ea4', 1, 'I', 'Allegro vivace (Alla breve)', 'I. Allegro vivace (Alla breve)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 협주곡 4번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5888724e-8731-3618-bc05-81dc8bb77ea4'
);

UPDATE pieces piece
SET piece.title = '피아노 협주곡 4번 G단조 중 "Allegro vivace (Alla breve)"', piece.title_en = 'Piano Concerto No. 4 in G minor, Op. 40: I. Allegro vivace (Alla breve)', piece.editor_locked = 1
WHERE piece.id = 2488 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1885 AND linked.composer_id = 51), 'musicbrainz:28357a3e-e9ec-3494-988b-4ae5fd78c4a9', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 협주곡 4번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28357a3e-e9ec-3494-988b-4ae5fd78c4a9'
);

UPDATE pieces piece
SET piece.title = '피아노 협주곡 4번 G단조 중 "Largo"', piece.title_en = 'Piano Concerto No. 4 in G minor, Op. 40: II. Largo', piece.editor_locked = 1
WHERE piece.id = 1885 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 849 AND linked.composer_id = 51), 'musicbrainz:756782f7-f78d-3fd8-9137-0d0c8fd12c86', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 협주곡 4번 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:756782f7-f78d-3fd8-9137-0d0c8fd12c86'
);

UPDATE pieces piece
SET piece.title = '피아노 협주곡 4번 G단조 중 "Allegro vivace"', piece.title_en = 'Piano Concerto No. 4 in G minor, Op. 40: III. Allegro vivace', piece.editor_locked = 1
WHERE piece.id = 849 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 41 3개의 러시아 노래 Op. 41

UPDATE pieces piece
SET piece.title = '3개의 러시아 노래 Op. 41', piece.title_en = '3 Russian Songs, Op. 41',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '41',
    piece.composition_year = COALESCE(1927, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2883 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1927
WHERE piece.id = 2883 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Cherez rechku, rechku bystru', part.name_en = 'Cherez rechku, rechku bystru',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2883 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:621bb5fe-1f13-370c-9ac1-5228125ddda3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:621bb5fe-1f13-370c-9ac1-5228125ddda3', 1, NULL, 'Cherez rechku, rechku bystru', 'Cherez rechku, rechku bystru', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2883 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:621bb5fe-1f13-370c-9ac1-5228125ddda3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Akh ty, Van''ka', part.name_en = 'Akh ty, Van''ka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2883 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:dfac2dfa-9dd6-3c2c-8a42-75f642daf80e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfac2dfa-9dd6-3c2c-8a42-75f642daf80e', 2, NULL, 'Akh ty, Van''ka', 'Akh ty, Van''ka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2883 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfac2dfa-9dd6-3c2c-8a42-75f642daf80e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Belilitsy, rumyanitsy vy moi', part.name_en = 'Belilitsy, rumyanitsy vy moi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2883 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2db8489c-dcc6-349c-8380-64bb1227bf7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2db8489c-dcc6-349c-8380-64bb1227bf7f', 3, NULL, 'Belilitsy, rumyanitsy vy moi', 'Belilitsy, rumyanitsy vy moi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2883 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2db8489c-dcc6-349c-8380-64bb1227bf7f'
);


-- Op. 42 코렐리 주제에 의한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코렐리 주제에 의한 변주곡', 'Variations on a Theme of Corelli, Op. 42', 'album', 'Op. 42', NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코렐리 주제에 의한 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5cf8acd-06dc-3355-b536-f456c8e95bce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5cf8acd-06dc-3355-b536-f456c8e95bce'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5cf8acd-06dc-3355-b536-f456c8e95bce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1feb1c8-4ead-4156-83db-f6549b89d3f6', 1, NULL, '주제. Andante', 'Theme: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1feb1c8-4ead-4156-83db-f6549b89d3f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea9ef47-bbe2-4522-a598-ae33b62f0c40', 2, NULL, '변주 I. Poco più mosso', 'Variation I: Poco più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea9ef47-bbe2-4522-a598-ae33b62f0c40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:450e2861-533e-4bc3-8682-bca66e50ed21', 3, NULL, '변주 II. L''istesso tempo', 'Variation II: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:450e2861-533e-4bc3-8682-bca66e50ed21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e77030d9-20cd-4c11-b5eb-b4df06287b4c', 4, NULL, '변주 III. Tempo di menuetto', 'Variation III: Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e77030d9-20cd-4c11-b5eb-b4df06287b4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70902075-dafb-4f0f-b4d0-98e00a3301e1', 5, NULL, '변주 IV. Andante', 'Variation IV: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70902075-dafb-4f0f-b4d0-98e00a3301e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79afd310-0d30-4632-a8d7-7a8d9fc91d13', 6, NULL, '변주 V. Allegro (ma non tanto)', 'Variation V: Allegro (ma non tanto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79afd310-0d30-4632-a8d7-7a8d9fc91d13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f23766f3-f1fb-4356-b927-85502db7f35e', 7, NULL, '변주 VI. L''istesso tempo', 'Variation VI: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f23766f3-f1fb-4356-b927-85502db7f35e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e94aba3-5013-46b0-bd2b-ced409452639', 8, NULL, '변주 VII. Vivace', 'Variation VII: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e94aba3-5013-46b0-bd2b-ced409452639'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1e5d124-8854-4986-bb03-9957205f2263', 9, NULL, '변주 VIII. Adagio misterioso', 'Variation VIII: Adagio misterioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1e5d124-8854-4986-bb03-9957205f2263'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c17c60a-8c7c-45f4-8575-e365e20821b1', 10, NULL, '변주 IX. Un poco più mosso', 'Variation IX: Un poco più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c17c60a-8c7c-45f4-8575-e365e20821b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1198067-e9ed-4ed1-bb86-b7cf4d1285c3', 11, NULL, '변주 X. Allegro scherzando', 'Variation X: Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1198067-e9ed-4ed1-bb86-b7cf4d1285c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58321a63-696c-4b24-80eb-58f90fc293f4', 12, NULL, '변주 XI. Allegro vivace', 'Variation XI: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58321a63-696c-4b24-80eb-58f90fc293f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89830411-bb39-46b8-8e73-300c9f767c78', 13, NULL, '변주 XII. L''istesso tempo', 'Variation XII: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89830411-bb39-46b8-8e73-300c9f767c78'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08b13881-734e-4b32-b772-fe9d4d113a85', 14, NULL, '변주 XIII. Agitato', 'Variation XIII: Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08b13881-734e-4b32-b772-fe9d4d113a85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c45ec4b-fe2d-4eaf-8c29-7846d6be3e38', 15, NULL, '간주곡. A tempo rubato', 'Intermezzo: A tempo rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c45ec4b-fe2d-4eaf-8c29-7846d6be3e38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17f93d63-a3d7-4837-82f2-fb15120d3b60', 16, NULL, '변주 XIV. Andante (come prima)', 'Variation XIV: Andante (come prima)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17f93d63-a3d7-4837-82f2-fb15120d3b60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24f1bdd0-f50e-4cdd-80f6-201af04dde66', 17, NULL, '변주 XV. L''istesso tempo', 'Variation XV: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24f1bdd0-f50e-4cdd-80f6-201af04dde66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b631001-d8aa-46b8-b5a1-3eeadfe1d521', 18, NULL, '변주 XVI. Allegro vivace', 'Variation XVI: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b631001-d8aa-46b8-b5a1-3eeadfe1d521'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c313ffd-4b7c-4bbf-a16b-55d1074ac2e6', 19, NULL, '변주 XVII. Meno mosso', 'Variation XVII: Meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c313ffd-4b7c-4bbf-a16b-55d1074ac2e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:147ed985-4dd0-459f-915f-a10db063ef8c', 20, NULL, '변주 XVIII. Allegro con brio', 'Variation XVIII: Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:147ed985-4dd0-459f-915f-a10db063ef8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec71484b-8e01-428b-b26f-a8febff60b4c', 21, NULL, '변주 XIX. Più mosso. Agitato', 'Variation XIX: Più mosso. Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec71484b-8e01-428b-b26f-a8febff60b4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:192cae17-2fdc-45b9-8ddb-591906bffd73', 22, NULL, '변주 XX. Più mosso', 'Variation XX: Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:192cae17-2fdc-45b9-8ddb-591906bffd73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:080d3eb1-1d67-41bd-ac67-373676fd2b2a', 23, NULL, '코다. Andante', 'Coda: Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '코렐리 주제에 의한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:080d3eb1-1d67-41bd-ac67-373676fd2b2a'
);


-- Op. 43 파가니니 주제에 의한 광시곡

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서주. Allegro vivace', part.name_en = 'Introduction: Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:4df364a2-cd62-30ae-a287-a44f0203be19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4df364a2-cd62-30ae-a287-a44f0203be19', 1, NULL, '서주. Allegro vivace', 'Introduction: Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4df364a2-cd62-30ae-a287-a44f0203be19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '변주 I. Precedente', part.name_en = 'Variation I: Precedente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:399ff0ee-1bcb-3a34-8022-2d2453c92668' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:399ff0ee-1bcb-3a34-8022-2d2453c92668', 2, NULL, '변주 I. Precedente', 'Variation I: Precedente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:399ff0ee-1bcb-3a34-8022-2d2453c92668'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1996 AND linked.composer_id = 51),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '주제. L''istesso tempo', part.name_en = 'Theme: L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7082527f-34a1-32da-9bb5-b2994e21ad98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1996 AND linked.composer_id = 51), 'musicbrainz:7082527f-34a1-32da-9bb5-b2994e21ad98', 3, NULL, '주제. L''istesso tempo', 'Theme: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7082527f-34a1-32da-9bb5-b2994e21ad98'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "주제. L''istesso tempo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Theme: L''istesso tempo', piece.editor_locked = 1
WHERE piece.id = 1996 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1651 AND linked.composer_id = 51),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '변주 II. L''istesso tempo', part.name_en = 'Variation II: L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:336921a8-61b3-31b7-9d7b-cffcd3980367' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1651 AND linked.composer_id = 51), 'musicbrainz:336921a8-61b3-31b7-9d7b-cffcd3980367', 4, NULL, '변주 II. L''istesso tempo', 'Variation II: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:336921a8-61b3-31b7-9d7b-cffcd3980367'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 II. L''istesso tempo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation II: L''istesso tempo', piece.editor_locked = 1
WHERE piece.id = 1651 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 3018 AND linked.composer_id = 51),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '변주 III. L''istesso tempo', part.name_en = 'Variation III: L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:a85dd2e2-eb10-3966-ac79-85db4687115e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 3018 AND linked.composer_id = 51), 'musicbrainz:a85dd2e2-eb10-3966-ac79-85db4687115e', 5, NULL, '변주 III. L''istesso tempo', 'Variation III: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a85dd2e2-eb10-3966-ac79-85db4687115e'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 III. L''istesso tempo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation III: L''istesso tempo', piece.editor_locked = 1
WHERE piece.id = 3018 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2464 AND linked.composer_id = 51),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '변주 IV. Più vivo', part.name_en = 'Variation IV: Più vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:0b1213c2-c2a7-3ae7-8b1d-028e1921e7a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2464 AND linked.composer_id = 51), 'musicbrainz:0b1213c2-c2a7-3ae7-8b1d-028e1921e7a8', 6, NULL, '변주 IV. Più vivo', 'Variation IV: Più vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b1213c2-c2a7-3ae7-8b1d-028e1921e7a8'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 IV. Più vivo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation IV: Più vivo', piece.editor_locked = 1
WHERE piece.id = 2464 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1652 AND linked.composer_id = 51),
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '변주 V. Tempo precedente', part.name_en = 'Variation V: Tempo precedente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ebc7396f-12ca-3198-8ae2-662b47baecac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1652 AND linked.composer_id = 51), 'musicbrainz:ebc7396f-12ca-3198-8ae2-662b47baecac', 7, NULL, '변주 V. Tempo precedente', 'Variation V: Tempo precedente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebc7396f-12ca-3198-8ae2-662b47baecac'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 V. Tempo precedente"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation V: Tempo precedente', piece.editor_locked = 1
WHERE piece.id = 1652 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2512 AND linked.composer_id = 51),
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '변주 VI. L''istesso tempo', part.name_en = 'Variation VI: L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:583d6afa-4006-3b0c-bb8f-95359e232528' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2512 AND linked.composer_id = 51), 'musicbrainz:583d6afa-4006-3b0c-bb8f-95359e232528', 8, NULL, '변주 VI. L''istesso tempo', 'Variation VI: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:583d6afa-4006-3b0c-bb8f-95359e232528'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 VI. L''istesso tempo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation VI: L''istesso tempo', piece.editor_locked = 1
WHERE piece.id = 2512 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1035 AND linked.composer_id = 51),
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '변주 VII. Meno mosso, a tempo moderato', part.name_en = 'Variation VII: Meno mosso, a tempo moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:d0465913-a9dc-3676-a8bd-f1ba981a7bba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1035 AND linked.composer_id = 51), 'musicbrainz:d0465913-a9dc-3676-a8bd-f1ba981a7bba', 9, NULL, '변주 VII. Meno mosso, a tempo moderato', 'Variation VII: Meno mosso, a tempo moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0465913-a9dc-3676-a8bd-f1ba981a7bba'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 VII. Meno mosso, a tempo moderato"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation VII: Meno mosso, a tempo moderato', piece.editor_locked = 1
WHERE piece.id = 1035 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2844 AND linked.composer_id = 51),
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '변주 VIII. Tempo I', part.name_en = 'Variation VIII: Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:af26e52f-4697-3524-8b60-7b045371140e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2844 AND linked.composer_id = 51), 'musicbrainz:af26e52f-4697-3524-8b60-7b045371140e', 10, NULL, '변주 VIII. Tempo I', 'Variation VIII: Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af26e52f-4697-3524-8b60-7b045371140e'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 VIII. Tempo I"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation VIII: Tempo I', piece.editor_locked = 1
WHERE piece.id = 2844 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2089 AND linked.composer_id = 51),
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '변주 IX. L''istesso tempo', part.name_en = 'Variation IX: L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:66d78cf2-85cf-3c58-9571-8c315dd43ca2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2089 AND linked.composer_id = 51), 'musicbrainz:66d78cf2-85cf-3c58-9571-8c315dd43ca2', 11, NULL, '변주 IX. L''istesso tempo', 'Variation IX: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66d78cf2-85cf-3c58-9571-8c315dd43ca2'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 IX. L''istesso tempo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation IX: L''istesso tempo', piece.editor_locked = 1
WHERE piece.id = 2089 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1121 AND linked.composer_id = 51),
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '변주 X. Poco marcato', part.name_en = 'Variation X: Poco marcato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:90585082-bec0-3e6a-b60c-5bcf804575e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1121 AND linked.composer_id = 51), 'musicbrainz:90585082-bec0-3e6a-b60c-5bcf804575e0', 12, NULL, '변주 X. Poco marcato', 'Variation X: Poco marcato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90585082-bec0-3e6a-b60c-5bcf804575e0'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 X. Poco marcato"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation X: Poco marcato', piece.editor_locked = 1
WHERE piece.id = 1121 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '변주 XI. Moderato', part.name_en = 'Variation XI: Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:bc02af24-f976-3edc-ab49-44cc89814285' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc02af24-f976-3edc-ab49-44cc89814285', 13, NULL, '변주 XI. Moderato', 'Variation XI: Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc02af24-f976-3edc-ab49-44cc89814285'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2995 AND linked.composer_id = 51),
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '변주 XII. Tempo di minuetto', part.name_en = 'Variation XII: Tempo di minuetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:949e354f-823c-3b55-b017-e9447c3b3c86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2995 AND linked.composer_id = 51), 'musicbrainz:949e354f-823c-3b55-b017-e9447c3b3c86', 14, NULL, '변주 XII. Tempo di minuetto', 'Variation XII: Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:949e354f-823c-3b55-b017-e9447c3b3c86'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XII. Tempo di minuetto"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XII: Tempo di minuetto', piece.editor_locked = 1
WHERE piece.id = 2995 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2137 AND linked.composer_id = 51),
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '변주 XIII. Allegro', part.name_en = 'Variation XIII: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:37d402c7-b2c0-3737-aa78-4653749f281b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2137 AND linked.composer_id = 51), 'musicbrainz:37d402c7-b2c0-3737-aa78-4653749f281b', 15, NULL, '변주 XIII. Allegro', 'Variation XIII: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37d402c7-b2c0-3737-aa78-4653749f281b'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XIII. Allegro"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XIII: Allegro', piece.editor_locked = 1
WHERE piece.id = 2137 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 866 AND linked.composer_id = 51),
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '변주 XIV. L''istesso tempo', part.name_en = 'Variation XIV: L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b4010321-6207-3eff-b062-35b4e793d508' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 866 AND linked.composer_id = 51), 'musicbrainz:b4010321-6207-3eff-b062-35b4e793d508', 16, NULL, '변주 XIV. L''istesso tempo', 'Variation XIV: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4010321-6207-3eff-b062-35b4e793d508'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XIV. L''istesso tempo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XIV: L''istesso tempo', piece.editor_locked = 1
WHERE piece.id = 866 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1621 AND linked.composer_id = 51),
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '변주 XV. Più vivo scherzando', part.name_en = 'Variation XV: Più vivo scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:3d618f0e-b50d-31bc-8411-6a8598ac6a73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1621 AND linked.composer_id = 51), 'musicbrainz:3d618f0e-b50d-31bc-8411-6a8598ac6a73', 17, NULL, '변주 XV. Più vivo scherzando', 'Variation XV: Più vivo scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d618f0e-b50d-31bc-8411-6a8598ac6a73'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XV. Più vivo scherzando"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XV: Più vivo scherzando', piece.editor_locked = 1
WHERE piece.id = 1621 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2604 AND linked.composer_id = 51),
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '변주 XVI. Allegretto', part.name_en = 'Variation XVI: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:c92f0bf0-e3d0-3cf6-a1b1-afbff4bbd316' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2604 AND linked.composer_id = 51), 'musicbrainz:c92f0bf0-e3d0-3cf6-a1b1-afbff4bbd316', 18, NULL, '변주 XVI. Allegretto', 'Variation XVI: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c92f0bf0-e3d0-3cf6-a1b1-afbff4bbd316'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XVI. Allegretto"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XVI: Allegretto', piece.editor_locked = 1
WHERE piece.id = 2604 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2490 AND linked.composer_id = 51),
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = '변주 XVII. Allegretto', part.name_en = 'Variation XVII: Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:ee19d872-95b7-35d7-a856-e6686ebb3e6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2490 AND linked.composer_id = 51), 'musicbrainz:ee19d872-95b7-35d7-a856-e6686ebb3e6c', 19, NULL, '변주 XVII. Allegretto', 'Variation XVII: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee19d872-95b7-35d7-a856-e6686ebb3e6c'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XVII. Allegretto"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XVII: Allegretto', piece.editor_locked = 1
WHERE piece.id = 2490 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '변주 XVIII. Andante cantabile', part.name_en = 'Variation XVIII: Andante cantabile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:6c85b6a0-a215-38bc-ac2b-4b2b52bfb211' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c85b6a0-a215-38bc-ac2b-4b2b52bfb211', 20, NULL, '변주 XVIII. Andante cantabile', 'Variation XVIII: Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c85b6a0-a215-38bc-ac2b-4b2b52bfb211'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1760 AND linked.composer_id = 51),
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = '변주 XIX. A tempo vivace', part.name_en = 'Variation XIX: A tempo vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:e4da54cd-e58f-3965-9d48-0578654a1b07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1760 AND linked.composer_id = 51), 'musicbrainz:e4da54cd-e58f-3965-9d48-0578654a1b07', 21, NULL, '변주 XIX. A tempo vivace', 'Variation XIX: A tempo vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4da54cd-e58f-3965-9d48-0578654a1b07'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XIX. A tempo vivace"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XIX: A tempo vivace', piece.editor_locked = 1
WHERE piece.id = 1760 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1116 AND linked.composer_id = 51),
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = '변주 XX. Un poco più vivo', part.name_en = 'Variation XX: Un poco più vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2a9abdb6-b9e6-3ad3-a1e2-4acec6f774d9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1116 AND linked.composer_id = 51), 'musicbrainz:2a9abdb6-b9e6-3ad3-a1e2-4acec6f774d9', 22, NULL, '변주 XX. Un poco più vivo', 'Variation XX: Un poco più vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a9abdb6-b9e6-3ad3-a1e2-4acec6f774d9'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XX. Un poco più vivo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XX: Un poco più vivo', piece.editor_locked = 1
WHERE piece.id = 1116 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2975 AND linked.composer_id = 51),
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = '변주 XXI. Un poco più vivo', part.name_en = 'Variation XXI: Un poco più vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5d6bc95a-98ef-3a62-ba2f-059cc42321ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2975 AND linked.composer_id = 51), 'musicbrainz:5d6bc95a-98ef-3a62-ba2f-059cc42321ed', 23, NULL, '변주 XXI. Un poco più vivo', 'Variation XXI: Un poco più vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d6bc95a-98ef-3a62-ba2f-059cc42321ed'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XXI. Un poco più vivo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XXI: Un poco più vivo', piece.editor_locked = 1
WHERE piece.id = 2975 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2410 AND linked.composer_id = 51),
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = '변주 XXII. Un poco più vivo (Alla breve)', part.name_en = 'Variation XXII: Un poco più vivo (Alla breve)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:a2ab87f2-0841-3f0a-ab92-d9c298dd8f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2410 AND linked.composer_id = 51), 'musicbrainz:a2ab87f2-0841-3f0a-ab92-d9c298dd8f19', 24, NULL, '변주 XXII. Un poco più vivo (Alla breve)', 'Variation XXII: Un poco più vivo (Alla breve)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2ab87f2-0841-3f0a-ab92-d9c298dd8f19'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XXII. Un poco più vivo (Alla breve)"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XXII: Un poco più vivo (Alla breve)', piece.editor_locked = 1
WHERE piece.id = 2410 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2650 AND linked.composer_id = 51),
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = '변주 XXIII. L''istesso tempo', part.name_en = 'Variation XXIII: L''istesso tempo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:135663a1-93e2-3e77-86dc-8ea27ac533eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2650 AND linked.composer_id = 51), 'musicbrainz:135663a1-93e2-3e77-86dc-8ea27ac533eb', 25, NULL, '변주 XXIII. L''istesso tempo', 'Variation XXIII: L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:135663a1-93e2-3e77-86dc-8ea27ac533eb'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XXIII. L''istesso tempo"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XXIII: L''istesso tempo', piece.editor_locked = 1
WHERE piece.id = 2650 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2092 AND linked.composer_id = 51),
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = '변주 XXIV. A tempo un poco meno mosso', part.name_en = 'Variation XXIV: A tempo un poco meno mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 227 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:90d1ea4d-056c-3fe7-9cdf-34df79524d7c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2092 AND linked.composer_id = 51), 'musicbrainz:90d1ea4d-056c-3fe7-9cdf-34df79524d7c', 26, NULL, '변주 XXIV. A tempo un poco meno mosso', 'Variation XXIV: A tempo un poco meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 227 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90d1ea4d-056c-3fe7-9cdf-34df79524d7c'
);

UPDATE pieces piece
SET piece.title = '파가니니 주제에 의한 광시곡 중 "변주 XXIV. A tempo un poco meno mosso"', piece.title_en = 'Rhapsody on a Theme of Paganini, Op. 43: Variation XXIV: A tempo un poco meno mosso', piece.editor_locked = 1
WHERE piece.id = 2092 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 44 교향곡 3번 A단조

UPDATE pieces piece
SET piece.title = '교향곡 3번 A단조', piece.title_en = 'Symphony No. 3 in A minor, Op. 44',
    piece.type = 'album', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1936, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 796 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1936
WHERE piece.id = 796 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento — Allegro moderato', part.name_en = 'I. Lento — Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 796 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:a9c1e4d7-128f-3a49-a337-4d347695fe92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9c1e4d7-128f-3a49-a337-4d347695fe92', 1, 'I', 'Lento — Allegro moderato', 'I. Lento — Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 796 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9c1e4d7-128f-3a49-a337-4d347695fe92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio ma non troppo — Allegro vivace', part.name_en = 'II. Adagio ma non troppo — Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 796 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:9b1d834e-8d71-35c0-944d-ad69f2c6fd87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b1d834e-8d71-35c0-944d-ad69f2c6fd87', 2, 'II', 'Adagio ma non troppo — Allegro vivace', 'II. Adagio ma non troppo — Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 796 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b1d834e-8d71-35c0-944d-ad69f2c6fd87'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro — Allegro vivace', part.name_en = 'III. Allegro — Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 796 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:57caa574-a305-3cd1-abf1-02929d5e3ad9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57caa574-a305-3cd1-abf1-02929d5e3ad9', 3, 'III', 'Allegro — Allegro vivace', 'III. Allegro — Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 796 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57caa574-a305-3cd1-abf1-02929d5e3ad9'
);


-- Op. 45 교향적 춤곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 춤곡', 'Symphonic Dances, Op. 45', 'album', 'Op. 45', NULL, NULL, 1940, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 춤곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a452d093-32f6-4bf9-b1f9-5fa69eec29a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a452d093-32f6-4bf9-b1f9-5fa69eec29a5'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향적 춤곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a452d093-32f6-4bf9-b1f9-5fa69eec29a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1287 AND linked.composer_id = 51), 'musicbrainz:e13eb896-203d-39c3-849f-1957bf1e69bb', 1, 'I', 'Non allegro', 'I. Non allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향적 춤곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e13eb896-203d-39c3-849f-1957bf1e69bb'
);

UPDATE pieces piece
SET piece.title = '교향적 춤곡 중 "Non allegro"', piece.title_en = 'Symphonic Dances, Op. 45: I. Non allegro', piece.editor_locked = 1
WHERE piece.id = 1287 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1114 AND linked.composer_id = 51), 'musicbrainz:c94b3874-8ad7-3ff9-8888-5b03aa7c0c08', 2, 'II', 'Andante con moto (Tempo di valse)', 'II. Andante con moto (Tempo di valse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향적 춤곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c94b3874-8ad7-3ff9-8888-5b03aa7c0c08'
);

UPDATE pieces piece
SET piece.title = '교향적 춤곡 중 "Andante con moto (Tempo di valse)"', piece.title_en = 'Symphonic Dances, Op. 45: II. Andante con moto (Tempo di valse)', piece.editor_locked = 1
WHERE piece.id = 1114 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1990 AND linked.composer_id = 51), 'musicbrainz:0311f549-3408-308e-b79b-db07c323a02e', 3, 'III', 'Lento assai — Allegro vivace', 'III. Lento assai — Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '교향적 춤곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0311f549-3408-308e-b79b-db07c323a02e'
);

UPDATE pieces piece
SET piece.title = '교향적 춤곡 중 "Lento assai — Allegro vivace"', piece.title_en = 'Symphonic Dances, Op. 45: III. Lento assai — Allegro vivace', piece.editor_locked = 1
WHERE piece.id = 1990 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- TN ii/40 스케르초 D단조

UPDATE pieces piece
SET piece.title = '스케르초 D단조', piece.title_en = 'Scherzo in D minor',
    piece.type = 'song', piece.opus_number = 'TN ii/40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 571 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 571 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/43 교향곡 D단조 "청년 교향곡"

UPDATE pieces piece
SET piece.title = '교향곡 D단조 "청년 교향곡"', piece.title_en = 'Symphony in D minor "Youth Symphony"',
    piece.type = 'song', piece.opus_number = 'TN ii/43',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 542 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 542 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/44 교향시 <로스티슬라프 공>

UPDATE pieces piece
SET piece.title = '교향시 <로스티슬라프 공>', piece.title_en = 'Prince Rostislav',
    piece.type = 'song', piece.opus_number = 'TN ii/44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1787 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 1787 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- None 모음곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 D단조', 'Suite in D minor', 'album', NULL, NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9984911b-999e-4892-8e38-3f7f85a64076'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9984911b-999e-4892-8e38-3f7f85a64076'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '모음곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9984911b-999e-4892-8e38-3f7f85a64076'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a87a238-b61a-4668-9d20-e838c5fc8000', 1, 'I', 'Lento — Allegro moderato', 'I. Lento — Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '모음곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a87a238-b61a-4668-9d20-e838c5fc8000'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47e8da4a-0b4d-47b1-8ef3-02373876eb88', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '모음곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47e8da4a-0b4d-47b1-8ef3-02373876eb88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6312187e-1d75-44f9-96fd-c184877f660c', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '모음곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6312187e-1d75-44f9-96fd-c184877f660c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6e608a2-0fce-4269-874b-c20be1f8d23b', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '모음곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e608a2-0fce-4269-874b-c20be1f8d23b'
);


-- TN ii/30 현악 4중주 1번

UPDATE pieces piece
SET piece.title = '현악 4중주 1번', piece.title_en = 'String Quartet No. 1',
    piece.type = 'album', piece.opus_number = 'TN ii/30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2920 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 2920 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 967 AND linked.composer_id = 51),
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '로망스. Andante espressivo', part.name_en = 'I. Romance: Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2920 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:cc36bc1c-237d-4804-a347-9525dbe311cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 967 AND linked.composer_id = 51), 'musicbrainz:cc36bc1c-237d-4804-a347-9525dbe311cb', 1, 'I', '로망스. Andante espressivo', 'I. Romance: Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2920 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc36bc1c-237d-4804-a347-9525dbe311cb'
);

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 중 "로망스. Andante espressivo"', piece.title_en = 'String Quartet No. 1: I. Romance: Andante espressivo', piece.editor_locked = 1
WHERE piece.id = 967 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1138 AND linked.composer_id = 51),
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Allegro', part.name_en = 'II. Scherzo: Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2920 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8c8dae57-dec8-4c6c-be3d-7d2b46da63e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1138 AND linked.composer_id = 51), 'musicbrainz:8c8dae57-dec8-4c6c-be3d-7d2b46da63e9', 2, 'II', '스케르초. Allegro', 'II. Scherzo: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2920 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c8dae57-dec8-4c6c-be3d-7d2b46da63e9'
);

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 중 "스케르초. Allegro"', piece.title_en = 'String Quartet No. 1: II. Scherzo: Allegro', piece.editor_locked = 1
WHERE piece.id = 1138 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- TN ii/31 바이올린과 피아노를 위한 로망스 A단조

UPDATE pieces piece
SET piece.title = '바이올린과 피아노를 위한 로망스 A단조', piece.title_en = 'Romance in A minor for Violin and Piano',
    piece.type = 'song', piece.opus_number = 'TN ii/31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1738 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 1738 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/32 첼로와 피아노를 위한 리트 F단조

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 리트 F단조', piece.title_en = 'Lied in F minor for Cello and Piano',
    piece.type = 'song', piece.opus_number = 'TN ii/32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 588 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 588 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/33 첼로와 피아노를 위한 멜로디 D장조

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 멜로디 D장조', piece.title_en = 'Mélodie in D major for Cello and Piano',
    piece.type = 'song', piece.opus_number = 'TN ii/33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1521 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 1521 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/34 피아노 3중주 1번 G단조 "비가"

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번 G단조 "비가"', piece.title_en = 'Trio élégiaque No. 1 in G minor',
    piece.type = 'song', piece.opus_number = 'TN ii/34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1518 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 1518 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/35 현악 4중주 2번 G단조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 G단조', piece.title_en = 'String Quartet No. 2 in G minor',
    piece.type = 'album', piece.opus_number = 'TN ii/35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2689 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 2689 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:b25f18d1-89ff-42bc-b54c-97e94074a2a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b25f18d1-89ff-42bc-b54c-97e94074a2a2', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b25f18d1-89ff-42bc-b54c-97e94074a2a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante molto sostenuto', part.name_en = 'II. Andante molto sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2689 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:33286a3c-0055-440e-a75f-515db13e247b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33286a3c-0055-440e-a75f-515db13e247b', 2, 'II', 'Andante molto sostenuto', 'II. Andante molto sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2689 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33286a3c-0055-440e-a75f-515db13e247b'
);


-- None 피아노 소품 D단조

UPDATE pieces piece
SET piece.title = '피아노 소품 D단조', piece.title_en = 'Piano Piece in D minor',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1496 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 1496 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/11 무언가 D단조

UPDATE pieces piece
SET piece.title = '무언가 D단조', piece.title_en = 'Song Without Words in D minor',
    piece.type = 'song', piece.opus_number = 'TN ii/11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 516 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 516 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/12 4개의 소품 TN ii/12

UPDATE pieces piece
SET piece.title = '4개의 소품 TN ii/12', piece.title_en = '4 Pieces, TN ii/12',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'TN', piece.catalogue_number = 'ii/12',
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2712 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 2712 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '로망스 F#단조', part.name_en = 'Romance in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2712 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:461d0bdd-2de4-472d-b51f-77ad7185faff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:461d0bdd-2de4-472d-b51f-77ad7185faff', 1, NULL, '로망스 F#단조', 'Romance in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2712 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:461d0bdd-2de4-472d-b51f-77ad7185faff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '전주곡 E♭단조', part.name_en = 'Prélude in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2712 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:518f9252-475b-4468-b584-b371b2792df0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:518f9252-475b-4468-b584-b371b2792df0', 2, NULL, '전주곡 E♭단조', 'Prélude in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2712 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:518f9252-475b-4468-b584-b371b2792df0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '멜로디 E장조', part.name_en = 'Mélodie in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2712 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5c29abd8-6f98-44b3-ad52-f8ed64d8335c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c29abd8-6f98-44b3-ad52-f8ed64d8335c', 3, NULL, '멜로디 E장조', 'Mélodie in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2712 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c29abd8-6f98-44b3-ad52-f8ed64d8335c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '가보트 D장조', part.name_en = 'Gavotte in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2712 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:49d2ff18-0740-497d-a1db-8dc413bd8905' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49d2ff18-0740-497d-a1db-8dc413bd8905', 4, NULL, '가보트 D장조', 'Gavotte in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2712 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49d2ff18-0740-497d-a1db-8dc413bd8905'
);


-- TN ii/13 3개의 녹턴 TN ii/13

UPDATE pieces piece
SET piece.title = '3개의 녹턴 TN ii/13', piece.title_en = '3 Nocturnes, TN ii/13',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'TN', piece.catalogue_number = 'ii/13',
    piece.composition_year = COALESCE(1888, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1342 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1888
WHERE piece.id = 1342 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'F#단조', part.name_en = 'No. 1 in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1342 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:7517b740-703e-444d-8190-2e2f29069aaa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7517b740-703e-444d-8190-2e2f29069aaa', 1, NULL, 'F#단조', 'No. 1 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1342 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7517b740-703e-444d-8190-2e2f29069aaa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = 'No. 2 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1342 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:69b66420-5e1a-4a0d-80cf-b5b673c0f86f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69b66420-5e1a-4a0d-80cf-b5b673c0f86f', 2, NULL, 'F장조', 'No. 2 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1342 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69b66420-5e1a-4a0d-80cf-b5b673c0f86f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 3 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1342 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2b21357d-5088-4f28-8382-338259bf200a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b21357d-5088-4f28-8382-338259bf200a', 3, NULL, 'C단조', 'No. 3 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1342 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b21357d-5088-4f28-8382-338259bf200a'
);


-- TN ii/14 카논 E단조

UPDATE pieces piece
SET piece.title = '카논 E단조', piece.title_en = 'Canon in E minor',
    piece.type = 'song', piece.opus_number = 'TN ii/14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1623 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 1623 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- None 푸가 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 D단조', 'Fugue in D minor', 'song', NULL, NULL, NULL, 1891, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7df0d234-7fbd-4c7a-96c6-e106ac44d46c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7df0d234-7fbd-4c7a-96c6-e106ac44d46c'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '푸가 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7df0d234-7fbd-4c7a-96c6-e106ac44d46c'
);


-- TN ii/15 전주곡 F장조

UPDATE pieces piece
SET piece.title = '전주곡 F장조', piece.title_en = 'Prelude in F major',
    piece.type = 'song', piece.opus_number = 'TN ii/15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 577 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 577 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/17 2개의 소품 TN ii/17

UPDATE pieces piece
SET piece.title = '2개의 소품 TN ii/17', piece.title_en = '2 Pieces, TN ii/17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'TN', piece.catalogue_number = 'ii/17',
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1857 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 1857 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '환상적 소품 G단조', part.name_en = 'Morceau de fantaisie in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1857 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:8e147a47-3a1d-409e-9c9d-10163c4049b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e147a47-3a1d-409e-9c9d-10163c4049b5', 1, NULL, '환상적 소품 G단조', 'Morceau de fantaisie in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1857 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e147a47-3a1d-409e-9c9d-10163c4049b5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '푸게타 F장조', part.name_en = 'Fughetta in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1857 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:42be8f02-929a-41be-ba99-000d8b27ee38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42be8f02-929a-41be-ba99-000d8b27ee38', 2, NULL, '푸게타 F장조', 'Fughetta in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1857 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42be8f02-929a-41be-ba99-000d8b27ee38'
);


-- TN ii/19 3개의 소품 TN ii/19

UPDATE pieces piece
SET piece.title = '3개의 소품 TN ii/19', piece.title_en = '3 Pieces, TN ii/19',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'TN', piece.catalogue_number = 'ii/19',
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 971 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 971 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡 D단조', part.name_en = 'Prelude in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 971 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:742d4858-87e9-4377-8954-4a80ccc938f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:742d4858-87e9-4377-8954-4a80ccc938f3', 1, NULL, '전주곡 D단조', 'Prelude in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 971 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:742d4858-87e9-4377-8954-4a80ccc938f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '동양풍 스케치 B♭장조', part.name_en = 'Oriental Sketch in B♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 971 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:bf84865e-f8f8-384d-bd0f-c4439994ee58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf84865e-f8f8-384d-bd0f-c4439994ee58', 2, NULL, '동양풍 스케치 B♭장조', 'Oriental Sketch in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 971 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf84865e-f8f8-384d-bd0f-c4439994ee58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '단편 A♭장조', part.name_en = 'Fragments in A♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 971 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2f6734a9-28e2-303e-87a8-e18632fa57fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f6734a9-28e2-303e-87a8-e18632fa57fb', 3, NULL, '단편 A♭장조', 'Fragments in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 971 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f6734a9-28e2-303e-87a8-e18632fa57fb'
);


-- TN ii/20 피아노 연탄을 위한 로망스 G장조

UPDATE pieces piece
SET piece.title = '피아노 연탄을 위한 로망스 G장조', piece.title_en = 'Romance in G major for Piano Four Hands',
    piece.type = 'song', piece.opus_number = 'TN ii/20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1102 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 1102 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/21 이탈리아 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '이탈리아 폴카', 'Polka italienne', 'song', 'TN ii/21', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '이탈리아 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd508a290-4aee-4240-b8ca-309fe408c02f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd508a290-4aee-4240-b8ca-309fe408c02f'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '이탈리아 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd508a290-4aee-4240-b8ca-309fe408c02f'
);


-- TN ii/22 피아노 6손을 위한 2개의 소품 TN ii/22

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 6손을 위한 2개의 소품 TN ii/22', '2 Pieces for Piano Six Hands, TN ii/22', 'album', NULL, 'TN', 'ii/22', 1891, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 6손을 위한 2개의 소품 TN ii/22'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e812c3c-911a-47a1-a803-b834e38247f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e812c3c-911a-47a1-a803-b834e38247f5'
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 6손을 위한 2개의 소품 TN ii/22' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e812c3c-911a-47a1-a803-b834e38247f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7609fff-6aec-30bd-b26e-41f80212ffd3', 1, NULL, '왈츠 A장조', 'Waltz in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 6손을 위한 2개의 소품 TN ii/22' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7609fff-6aec-30bd-b26e-41f80212ffd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b59d158-6b57-3830-891e-f5ca6a4651db', 2, NULL, '로망스 A장조', 'Romance in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '피아노 6손을 위한 2개의 소품 TN ii/22' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b59d158-6b57-3830-891e-f5ca6a4651db'
);


-- TN ii/23 두 대의 피아노를 위한 러시아 광시곡 E단조

UPDATE pieces piece
SET piece.title = '두 대의 피아노를 위한 러시아 광시곡 E단조', piece.title_en = 'Russian Rhapsody in E minor for Two Pianos',
    piece.type = 'song', piece.opus_number = 'TN ii/23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 629 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 629 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/50 2개의 가곡 TN ii/50

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 가곡 TN ii/50', '2 Songs, TN ii/50', 'album', NULL, 'TN', 'ii/50', 1890, 'manual', 1
FROM composers c
WHERE c.id = 51
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 가곡 TN ii/50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 474 AND linked.composer_id = 51), 'musicbrainz:090824fd-79c8-4dad-aa5b-02f120f890f2', 1, NULL, 'U vrat obiteli svyatoy', 'U vrat obiteli svyatoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '2개의 가곡 TN ii/50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:090824fd-79c8-4dad-aa5b-02f120f890f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2803 AND linked.composer_id = 51), 'musicbrainz:e7a0ae53-dfdc-46f7-87d7-84ef941a29b4', 2, NULL, 'Ya tebe nichego ne skazhu', 'Ya tebe nichego ne skazhu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 51 AND p.title = '2개의 가곡 TN ii/50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a0ae53-dfdc-46f7-87d7-84ef941a29b4'
);

UPDATE pieces piece
SET piece.title = '2개의 가곡 TN ii/50 중 "Ya tebe nichego ne skazhu"', piece.title_en = '2 Songs, TN ii/50: Ya tebe nichego ne skazhu', piece.editor_locked = 1
WHERE piece.id = 2803 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- TN ii/51 가곡 <Opyat' vstrepenulos' ty, serdtse>

UPDATE pieces piece
SET piece.title = '가곡 <Opyat'' vstrepenulos'' ty, serdtse>', piece.title_en = 'Opyat'' vstrepenulos'' ty, serdtse',
    piece.type = 'song', piece.opus_number = 'TN ii/51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 556 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 556 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- None <보리스 고두노프>의 2개의 독백

UPDATE pieces piece
SET piece.title = '<보리스 고두노프>의 2개의 독백', piece.title_en = '2 Monologues from Boris Godunov',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1555 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 1555 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '피멘의 독백', part.name_en = 'Pimen''s Monologue (Monolog Pimena)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1555 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:41acdbeb-19a3-4eb2-9187-4b073c4dd298' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41acdbeb-19a3-4eb2-9187-4b073c4dd298', 1, NULL, '피멘의 독백', 'Pimen''s Monologue (Monolog Pimena)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1555 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41acdbeb-19a3-4eb2-9187-4b073c4dd298'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '보리스의 독백', part.name_en = 'Boris''s Monologue (Monolog Borisa)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1555 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:5cd0fc9d-cda6-4749-86f8-4dedbd293155' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cd0fc9d-cda6-4749-86f8-4dedbd293155', 2, NULL, '보리스의 독백', 'Boris''s Monologue (Monolog Borisa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1555 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cd0fc9d-cda6-4749-86f8-4dedbd293155'
);


-- TN ii/52 2개의 가곡 TN ii/52

UPDATE pieces piece
SET piece.title = '2개의 가곡 TN ii/52', piece.title_en = '2 Songs, TN ii/52',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'TN', piece.catalogue_number = 'ii/52',
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1894 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 1894 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C''était en avril', part.name_en = 'C''était en avril',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1894 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:85edd525-e93e-4577-956e-6dd8df8ea8e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85edd525-e93e-4577-956e-6dd8df8ea8e3', 1, NULL, 'C''était en avril', 'C''était en avril', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1894 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85edd525-e93e-4577-956e-6dd8df8ea8e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Smerkalos''', part.name_en = 'Smerkalos''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1894 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:fd44970d-f5ec-4b17-a304-3a9c73eedddf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd44970d-f5ec-4b17-a304-3a9c73eedddf', 2, NULL, 'Smerkalos''', 'Smerkalos''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1894 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd44970d-f5ec-4b17-a304-3a9c73eedddf'
);


-- TN ii/53 3개의 가곡 TN ii/53

UPDATE pieces piece
SET piece.title = '3개의 가곡 TN ii/53', piece.title_en = '3 Songs, TN ii/53',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'TN', piece.catalogue_number = 'ii/53',
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2608 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 2608 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pesnya razocharovannogo', part.name_en = 'Pesnya razocharovannogo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2608 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:9b65df1c-bd04-40ba-b172-d6666e4b5358' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b65df1c-bd04-40ba-b172-d6666e4b5358', 1, NULL, 'Pesnya razocharovannogo', 'Pesnya razocharovannogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2608 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b65df1c-bd04-40ba-b172-d6666e4b5358'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Uvyal tsvetok', part.name_en = 'Uvyal tsvetok',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2608 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:25b1abfa-bb3e-4275-97c7-b3571e1469b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25b1abfa-bb3e-4275-97c7-b3571e1469b0', 2, NULL, 'Uvyal tsvetok', 'Uvyal tsvetok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2608 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25b1abfa-bb3e-4275-97c7-b3571e1469b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ty pomnish'' li vecher?', part.name_en = 'Ty pomnish'' li vecher?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2608 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:db77453c-91c7-4297-9536-443db92a9ab8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db77453c-91c7-4297-9536-443db92a9ab8', 3, NULL, 'Ty pomnish'' li vecher?', 'Ty pomnish'' li vecher?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2608 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db77453c-91c7-4297-9536-443db92a9ab8'
);


-- TN ii/54 가곡 <Ikalos' li tebe, Natasha?>

UPDATE pieces piece
SET piece.title = '가곡 <Ikalos'' li tebe, Natasha?>', piece.title_en = 'Ikalos'' li tebe, Natasha?',
    piece.type = 'song', piece.opus_number = 'TN ii/54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 622 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 622 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/55 가곡 <Noch'>

UPDATE pieces piece
SET piece.title = '가곡 <Noch''>', piece.title_en = 'Noch''',
    piece.type = 'song', piece.opus_number = 'TN ii/55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2750 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 2750 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/56 가곡 <Pis'mo K. S. Stanislavskomu>

UPDATE pieces piece
SET piece.title = '가곡 <Pis''mo K. S. Stanislavskomu>', piece.title_en = 'Pis''mo K. S. Stanislavskomu',
    piece.type = 'song', piece.opus_number = 'TN ii/56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1926 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 1926 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/57 가곡 <Iz Yevangeliya ot Ioanna>

UPDATE pieces piece
SET piece.title = '가곡 <Iz Yevangeliya ot Ioanna>', piece.title_en = 'Iz Yevangeliya ot Ioanna',
    piece.type = 'song', piece.opus_number = 'TN ii/57',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2386 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 2386 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/58 2개의 가곡 TN ii/58

UPDATE pieces piece
SET piece.title = '2개의 가곡 TN ii/58', piece.title_en = '2 Songs, TN ii/58',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'TN', piece.catalogue_number = 'ii/58',
    piece.composition_year = COALESCE(1916, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2618 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1916
WHERE piece.id = 2618 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Molitva', part.name_en = 'Molitva',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:2c1d94db-09a8-4658-b0fc-48b5549569c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c1d94db-09a8-4658-b0fc-48b5549569c1', 1, NULL, 'Molitva', 'Molitva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c1d94db-09a8-4658-b0fc-48b5549569c1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vsyo khochet pet''', part.name_en = 'Vsyo khochet pet''',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2618 AND p.composer_id = 51 AND part.part_key = 'musicbrainz:a2e24f57-3413-435d-bf9b-e1d23fb0b0a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2e24f57-3413-435d-bf9b-e1d23fb0b0a9', 2, NULL, 'Vsyo khochet pet''', 'Vsyo khochet pet''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2618 AND p.composer_id = 51
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2e24f57-3413-435d-bf9b-e1d23fb0b0a9'
);


-- TN ii/60 모테트 <데우스 메우스>

UPDATE pieces piece
SET piece.title = '모테트 <데우스 메우스>', piece.title_en = 'Deus meus',
    piece.type = 'song', piece.opus_number = 'TN ii/60',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1655 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 1655 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/61 합창 협주곡 <기도 속에 잠들지 않는 성모>

UPDATE pieces piece
SET piece.title = '합창 협주곡 <기도 속에 잠들지 않는 성모>', piece.title_en = 'O Mother of God Vigilantly Praying',
    piece.type = 'song', piece.opus_number = 'TN ii/61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 598 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 598 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/62 합창곡 <정령들의 합창>

UPDATE pieces piece
SET piece.title = '합창곡 <정령들의 합창>', piece.title_en = 'Chorus of Spirits',
    piece.type = 'song', piece.opus_number = 'TN ii/62',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 613 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 613 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/63 합창곡 <치유자 판텔레이>

UPDATE pieces piece
SET piece.title = '합창곡 <치유자 판텔레이>', piece.title_en = 'Panteley the Healer',
    piece.type = 'song', piece.opus_number = 'TN ii/63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 530 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 530 AND piece.composer_id = 51 AND piece.composition_year IS NULL;


-- TN ii/70 오페라 <알레코>

UPDATE pieces piece
SET piece.title = '오페라 <알레코>', piece.title_en = 'Aleko',
    piece.type = 'song', piece.opus_number = 'TN ii/70',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 681 AND piece.composer_id = 51
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 681 AND piece.composer_id = 51 AND piece.composition_year IS NULL;

-- 카탈로그에 대응이 없는 seed 작품 43개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 51 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    821, 827, 939, 1040, 1077, 1100, 1151, 1220, 1255, 1302, 1355, 1571, 1578, 1619, 1639, 1681, 1694, 1698, 1710, 1737,
    1854, 1934, 2009, 2020, 2027, 2053, 2060, 2083, 2108, 2111, 2270, 2311, 2336, 2368, 2376, 2427, 2447, 2611, 2776, 2788,
    2871, 2876, 2912
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
